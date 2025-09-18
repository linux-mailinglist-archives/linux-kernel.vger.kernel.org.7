Return-Path: <linux-kernel+bounces-823284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA97B860CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147911C88380
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C403112DD;
	Thu, 18 Sep 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hCJ5RUJG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B13112B3;
	Thu, 18 Sep 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212901; cv=none; b=DOv4veAyTBkDnwpRKapZPWne8YHcv/okHoj2Xq8vD8d2DOWAVnnEwb+QYLkJ65CSC7cBKJR7mAuoFjYbIvfi7WxjMG9gEo91cpHhQRfHsUCDceMsm+VS2MALAri2r2jR3+aI3647UxqRYIFZa490+9oVDtSb/aQ9Votn2c4HQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212901; c=relaxed/simple;
	bh=qBKz4C+w/KBrM80RfkXDiIXqvpU2ntlrdWDMNsfFnPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjYAe63GnSJiNkPtarnhndt3HIlaVFOVmaGuAn/TAH+RaqMPHzSUIgM9FURs3R0DO8g84HFAijmSr4haH2n0ZwKutwcVz5wvWigLmUfru6oWzdEYJfHYkS0hSaJnlaDR9wmw+lqRiXTBoRu5rMxdl2Cn/75vRyyF/AayU4gVrN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hCJ5RUJG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E652240B19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758212892; bh=g2UWspJR3qAhMNSiIrScr8d+0YeZmjDM7f23lhzrPoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hCJ5RUJGPHkgApbvn+is/5u2O4R1ghVG7qOJJgDHjXvOE01jfgX8WpSYb4raYS3xa
	 B5OzdUpgzZ9+sVk1OaGA/loRiW1WL73exBhmcjdIOiltxtaz37G+IE8itvJUk5vG23
	 ++ndUe57iyy+lrKo2Wr8lKph3CNq4O0gbxwQwy8heYN6kJFk8ySyrI/jnn815nNK8w
	 DsLwv0cCEiPLQJeu5Xc4/dukvpggeiggCYE0GInJ7toNHC7jpK6I1p3E0cPuszX0dc
	 mE3eqTHlDKFCZzJsNsrJrETjWsN3x1Y3nRqAEQ1sIOYE/UeKY49KtsaQj77AjgbS0l
	 VaqS1JSb3Qjuw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E652240B19;
	Thu, 18 Sep 2025 16:28:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Randy Dunlap
 <rdunlap@infradead.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: maintainer: Fix ambiguous subheading formatting
In-Reply-To: <20250916222944.2547948-2-thorsten.blum@linux.dev>
References: <20250916222944.2547948-2-thorsten.blum@linux.dev>
Date: Thu, 18 Sep 2025 10:28:10 -0600
Message-ID: <87ecs39145.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@linux.dev> writes:

> Add a newline after both subheadings to avoid any ambiguous formatting,
> especially in htmldocs. Without the newline, subheadings are rendered as
> part of the following paragraphs, which can be confusing to read.
>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Fix subheading formatting with newlines as suggested by Randy
> - Link to v1: https://lore.kernel.org/r/20250915192235.2414746-2-thorsten.blum@linux.dev/
> ---
>  Documentation/maintainer/maintainer-entry-profile.rst | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

jon

