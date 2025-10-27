Return-Path: <linux-kernel+bounces-872253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F84C0FBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E303188C7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707513191BC;
	Mon, 27 Oct 2025 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EwRWcjft"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320030F543;
	Mon, 27 Oct 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587076; cv=none; b=ZvmBK4GZtM0/Cys2OUVGp2sfn/u72gdUP9qYAs4hpbYXYD84l4kYmginn/YG/Kz/OQcJPUYzrwE7DSyn7hfu2g7nfquIWNZdkMnFShtXfWa0MEvcA7iGgAUP7nMofX5zvJrWRe14A7La57QnM7+e8Nq7oMP9Y0iKTRp8Iqmgdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587076; c=relaxed/simple;
	bh=RfDe/lk36tQ9ZdGPDwQ02XQAHmaEu1Gz4r8TGZV+Q48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fDSOf6GLvMTKrDDLipzciIl72U7BmAfd+NN1qGx+yRsRR6yvn4mG5ff0m48pDClhg2XWvai3BMUZQUZ6Z2Oj7Fu/Y6Xq46ePEXfli48RfT3UbNLNmVj+skuf/oPS3Zz1/9hz4vLVFA042KpoSZ6IEKTs4McPmoMqz4FTBvtS5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EwRWcjft; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E62B540B18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761587074; bh=EkrU6qdStYnXfZpqvAS9tlf6vDNj3y10mTd/12SI7So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EwRWcjft/wYue7JisKvKQGpG6X7FZJ5d9pgR+itMqbVoja+8pedYQuBnwqU5Qu0mu
	 MRisTn5GAWr/VtJd2EY3eGH9Cg26xNVlIR2bEd/L/S9JIwD4CNMqox0Nq1o8aEP+s+
	 JB5hltbxWkrtx84EaJB/J7QEQxOAYEdS1uTaWL8Gt0WZXz37vnlXmHay11nec5Ak32
	 fn+o5PhQ7d1kFewIW5k2m/LvHjD40oRplT9Yzh6YkzPESPMu3zN392YJ9n6UjxS2t3
	 YBBV6qgcVcNLjTlH1ZbFb7hpU/QPsZLmj+hOSyzUEOm9/vIkrld+UbJ16M/ZCJWuoK
	 63c9BSS6rzlBw==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E62B540B18;
	Mon, 27 Oct 2025 17:44:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/30] docs: reporting-issues: outline why reporting
 is complicated
In-Reply-To: <a6704ef5b3a8dcbaf645ddb5407e8f13553502b0.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <a6704ef5b3a8dcbaf645ddb5407e8f13553502b0.1761481839.git.linux@leemhuis.info>
Date: Mon, 27 Oct 2025 11:44:33 -0600
Message-ID: <87ecqonsse.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Replace the closing words with a section that describes why reporting
> Linux kernel bugs is more complicated than in other FLOSS projects.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 67 ++++++++++++++++---
>  1 file changed, 59 insertions(+), 8 deletions(-)

So the text is OK but ... this is now the second section that is
essentially a long apology for the kernel process being so difficult.
It seems redundant with the other text, and I'm not convinced we need
it.

Again, length is an impediment to getting people to actually read this
stuff; we should be trying to be as concise as we can.  Do we really
need this?

Thanks,

jon

