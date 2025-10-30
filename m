Return-Path: <linux-kernel+bounces-878476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB5C20C50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D481A68366
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C827CCE2;
	Thu, 30 Oct 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cw4NWfRM"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C927A917
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835859; cv=none; b=UrObtw6DIV9XqWYvVACf4VW5Q0dOqmFNiPjUXQXVpdX5/KEeEsBelt0y4bE691QztpcB2o/9mVSAfHd2YaL4ZrxVEZdNGFoJmbjwR8xHIwCnO7z0So4WBkWYGSwkENJnJrdX2a0vh5iOXOjT+iaxEtL8eo6b77SiJn5kTS4lavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835859; c=relaxed/simple;
	bh=ETOATM5qH2qm7D4Kf6Y3WSupVBpNwRNqG50pShfhYyM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=AtjE+XrE4cd29bV/EhVHBQQJ+FSUu8umIcYmGZYUWbSszESnIiKb5Xcn25/4rwkFP/5E/uFMF0277DNSpOGVUndIm8PkWCytFhaTWt332/FfblF0BJL5RwhslRR+r0fcjrlyLCiEp6VvY1MUitJ7ZjCFk4hNaPR9MLiOu+nYwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cw4NWfRM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DDBC0C0DAB4;
	Thu, 30 Oct 2025 14:50:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 547E76068C;
	Thu, 30 Oct 2025 14:50:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07728118085D0;
	Thu, 30 Oct 2025 15:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761835855; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/5QmLAbB3bIU4Ql0Kwi/aAatM3bfZBytTuFNp0I0dMQ=;
	b=Cw4NWfRMu7iA0vfrTlZd21uu4IqUjsVzKM2um3d4pvcjjWn7iaFwPCOcPHvbypdzBfeCPL
	EJCiJJ+IG+nXvjuXwqcq7qcCUHL/6de211IpcllY+z8fAhXNI33ehMUQas1za8pEKPAbeT
	PMNOnhR35btZu5UO2ehKR8zOUiK/26efIDSILzAlWcOC7Ni9WSHxxRruwzqJ96OrxKgh0H
	EMxVbWrvAmYHpu3cSpBZNg6JhkMoodjh7A54RksAK1YtZFqP5GWfWxAKp8n8p7vjWjwgR2
	UD+PL7fwmhS2ImOABnr5k1uQqYZi5KSZf4RmzWhxFwWpBdhowjhnFUrSDrW0Rw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 15:50:52 +0100
Message-Id: <DDVQOOYR7YOO.3L40JABB6VVUW@bootlin.com>
To: "Carlos Llamas" <cmllamas@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 "Breno Leitao" <leitao@debian.org>, "Miroslav Benes" <mbenes@suse.cz>,
 "Mark Brown" <broonie@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>
Cc: <kernel-team@android.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: fix build ID and PC
 source parsing
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20251030010347.2731925-1-cmllamas@google.com>
In-Reply-To: <20251030010347.2731925-1-cmllamas@google.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Thu Oct 30, 2025 at 2:03 AM CET, Carlos Llamas wrote:
> Support for parsing PC source info in stacktraces (e.g. '(P)') was
> added in commit 2bff77c665ed ("scripts/decode_stacktrace.sh: fix
> decoding of lines with an additional info"). However, this logic was
> placed after the build ID processing. This incorrect order fails to
> parse lines containing both elements, e.g.:
>
>   drm_gem_mmap_obj+0x114/0x200 [drm 03d0564e0529947d67bb2008c3548be77279f=
d27] (P)
>
> This patch fixes the problem by extracting the PC source info first and
> then processing the module build ID. With this change, the line above is
> now properly parsed as such:
>
>   drm_gem_mmap_obj (./include/linux/mmap_lock.h:212 ./include/linux/mm.h:=
811 drivers/gpu/drm/drm_gem.c:1177) drm (P)
>
> While here, also add a brief explanation the build ID section.
>
> Fixes: bdf8eafbf7f5 ("arm64: stacktrace: report source of unwind data")
> Fixes: 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of lines=
 with an additional info")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

