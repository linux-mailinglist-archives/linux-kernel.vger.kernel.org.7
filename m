Return-Path: <linux-kernel+bounces-774026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A4DB2ADB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06181964508
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E62340D8B;
	Mon, 18 Aug 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jTDbiiow"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774A253F3A;
	Mon, 18 Aug 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533128; cv=none; b=XI8SNMgOpAlmHH6nsACeglvyx0tzadj0dGAhoMgZYw8R7IgudA2NaA3b0WbWrlTV84QGsjqDygRgJbBeKQw3z18u6kbXS3yNIDIkGU4sge60hMCoi66TvDPYk1zgENZGKN7iFKEFZ3pipWBkKxewLHWDXo+u/ThURIXmRhwRIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533128; c=relaxed/simple;
	bh=5mamOuwuN2q0c1HpCm7iCluXnDCuzCY0FW8G1fkNs8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SCE66YrqFibZDyfTrGYuVy6xrrOS77FSgi+kw5UjeznLnlVsG16Bc7UW2P8j0hvGQ2042q/LeOLUAcTe/kyw87XPBQrUGfNbKOCQkJBNMUk+mhr0FAhT9C+rd0G2OUQZyzXJptFJbudIuWdexKBypOYV7Zs2rVPAmcfNHrSmUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jTDbiiow; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AB7A640AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755533126; bh=wk/rXX1AoG7L4arFu7XcJ27vQ+aO9yrhpMlrzmUyPdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jTDbiiowfIAA2xOD4uU5CeBeWqMnV7BuSLi6XqnYorLlyf5ORDCLrbvz6iIbWtys6
	 Noh5+xeaOO2cxsWtOhIap65y9wTXy4pShJCTyw5m2xgpdFoJeWvysyXTV9ng0v96W0
	 aRROIASopbyNyUnJUySksoJgTlPCW9Z03yPxAR+jznpiM9Z8asZnw2xnGvdb3EZolm
	 BwCnva1idG2KoKtDV2UzTXApepaytbFj+Drf+stuCkUGuJ55fGkDLtPQk1EY3iqm/t
	 XKtxXnBhOmfeLjYPJNrj9MZVwF85xNd4Bhut++3rAhnoTRcKm9s/+2ZAawPpQ9jvGD
	 9XvvK8kNdszjQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AB7A640AB4;
	Mon, 18 Aug 2025 16:05:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>, tglx@linutronix.de,
 bp@alien8.de, peterz@infradead.org, jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, "Nikola Z. Ivanov"
 <zlatistiv@gmail.com>
Subject: Re: [PATCH] docs: Replace dead links to spectre side channel white
 papers
In-Reply-To: <20250816190028.55573-1-zlatistiv@gmail.com>
References: <20250816190028.55573-1-zlatistiv@gmail.com>
Date: Mon, 18 Aug 2025 10:05:25 -0600
Message-ID: <875xekaa4a.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nikola Z. Ivanov" <zlatistiv@gmail.com> writes:

> The papers are published by Intel, AMD and MIPS.
>
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> ---
> The MIPS blog post is nowhere to be found on mips.com,
> instead a link is placed to the last time the web archive
> has crawled it.
>
>  Documentation/admin-guide/hw-vuln/spectre.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I sure wish I understood why companies feel such a need to break links
so often ... I've applied this, thanks.

jon

