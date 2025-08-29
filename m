Return-Path: <linux-kernel+bounces-792502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBCB3C4DA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8801C20BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297D273D92;
	Fri, 29 Aug 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CHxokGkA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E5F194A73;
	Fri, 29 Aug 2025 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506679; cv=none; b=L+dj/M5HF2m9CYHg70XL7H/9xUc9ikZuBtsGV/AnY+vxEPtmNIiFGUc+Ss5OIASOjsFxL0J486OLNlchWTjoIeEc2NBFeTU1cs+xe+xwS/8HlayDXFFNJbwQvwsAq4fikCLlBzRPWHeq8s/D9RtL/h+1pUfTdDcEtb4w9P70FBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506679; c=relaxed/simple;
	bh=2xd7CV1ps8F4Ia+GtpmLH2P5MzMy8ycFYNjMETz1IZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIs47bKSk1WX9aqSXzP/Ik49SYeeo0CQom3BwrMQlJ5XoSqt0MRGk8nMrKpXsLdjYZH0MvJ0ESLSjbx4VvrVOoxL61UOJ4/6YwMuu3iHboGGMG2lDnnDk35kWi5fAGsg8Tl2wSXZo1Si3shoOhBp9+WxeMd7WfrETTGHpTKZr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CHxokGkA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4B13540AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756506676; bh=0lefTQnohYQB/+OCIX/Ack65rHqDEmkusNMfujbY6lA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CHxokGkAPVRXN+AXoS/eyrFGvlTkSfyi5AdUkx64MiLSdaoio1eocKkHn3/++W2EU
	 eU125JjKLuKHmLCbfuCFsrXgSCgMj9NmKYn4KbGj6y2j5iOuFLyA8lt5Q+d1jA/WRL
	 14v2e5TZcG4KaAXVF5uM/spj/MAV1CB0wroIr+wT5AD2USNldv9yybVHwS04LGUB8A
	 uSAPwG7iY9Spntt81C4Qa9kqbrRI1pABggx8EPHUDDrx4HjWBAKDkckJlWFlHK6GlI
	 XTkqC0aA5nNfDeemBMpoc4ttQckDG86PnfkTDXc6QPquLscSIGdoc/av5hkrgJdZqU
	 Keasv2qGlmWig==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4B13540AE2;
	Fri, 29 Aug 2025 22:31:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux F2FS
 <linux-f2fs-devel@lists.sourceforge.net>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Bagas
 Sanjaya <bagasdotme@gmail.com>, Daeho Jeong <daehojeong@google.com>,
 Yuanye Ma <yuanye.ma20@gmail.com>, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 0/6] f2fs: documentation formatting cleanup and
 improvements
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Date: Fri, 29 Aug 2025 16:31:15 -0600
Message-ID: <87qzwt3glo.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Here are documentation formatting cleanup for f2fs. This also includes
> docs retitle at the end of series ([6/6]) as a bonus.
>
> This series is based on docs-next tree.
>
> Enjoy!
>
> Bagas Sanjaya (6):
>   Documentation: f2fs: Separate errors mode subtable
>   Documentation: f2fs: Format compression level subtable
>   Documentation: f2fs: Span write hint table section rows
>   Documentation: f2fs: Wrap snippets in literal code blocks
>   Documentation: f2fs: Indent compression_mode option list
>   Documentation: f2fs: Reword title
>
>  Documentation/filesystems/f2fs.rst | 88 +++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 38 deletions(-)

Jaegeuk, are you going to pick this up, or would you like me to?

Thanks,

jon

