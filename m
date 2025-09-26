Return-Path: <linux-kernel+bounces-834025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98793BA3A03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544CD627B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94012EB866;
	Fri, 26 Sep 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Elhy6ylj"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAB29D270;
	Fri, 26 Sep 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889981; cv=none; b=HoGNOgyaXBEVQvZvOVmCJ9tUlzyKU3gBcz4ecIbhzMhhdaphS5bdZaFzX+d1ts0wTnVJTW/BydvW3YDX4fRc/mRgif6H2zxL7/Ai/C0jNe++LE4xX+GPzRTg51A3eTSwq36cfuWp1nkQHd12RJAKwUGBlpAKhSut8bmY6DM/H2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889981; c=relaxed/simple;
	bh=iKGIQrBTGPGYaEhEEJeu4uB+yiqoHuwEbxgwF8VGH0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a19r26x6apWhf/I1nx7PUzuuEDdkzOdWSa2MX0wxZYnJ9bH0Y0//WUY1iPzG2BOhU9Tzn0XXKRA0kDwIsaUEjM2cj1lVLOwGE01TjsQU3HRDKmQyLPVhWUrf+6dgd28JwdANtC53DwO2xHQECYOnUKzuXU2cZY2XWHo4n1nNQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Elhy6ylj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8E97D406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758889977; bh=0hIQ+oQcP/oIsDr0ENYVMh6imZqohMhKK/Ccbk4kRWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Elhy6ylj8mLJf3EVV0Y0yxp/FPtvflJtRCh3X3q4eQwcPn1aaqVEmYFizwC1xJFZ7
	 Tq1N/jmFtGmZpLOjA5zeHCIJvBcX+HFd51cRdlfeOlkq9itjrDyYPhSeIP3wNUA+09
	 w8rNV00p4Xt7vmuakZXJ6lJXxKG41XtxLoKJPc0zZFW03tGlH8++5hNk0kxH05Z8Jd
	 CWci2quEhewhdbpkImSB9II3An0ou2Ef4yWE/9nNciJT99PwEvpJqbXOo9kJCGmncJ
	 3+C36nmKhlQAMSpAGhlKFiX8ahte7U94rKKDZQOjFPQhMxVH0RDPqP+ntUno25fciF
	 Qqk4xbtXXDG7A==
Received: from localhost (unknown [151.82.181.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8E97D406FB;
	Fri, 26 Sep 2025 12:32:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Markus
 Heidelberg <m.heidelberg@cab.de>
Subject: Re: [PATCH] Documentation: fix spelling, typos, grammar, duplicated
 words
In-Reply-To: <20250926095312.206231-1-m.heidelberg@cab.de>
References: <20250926095312.206231-1-m.heidelberg@cab.de>
Date: Fri, 26 Sep 2025 06:32:52 -0600
Message-ID: <875xd52y2z.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Heidelberg <m.heidelberg@cab.de> writes:

> diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
> index 0042776a9e17..b3d352d2ffcc 100644
> --- a/Documentation/kernel-hacking/hacking.rst
> +++ b/Documentation/kernel-hacking/hacking.rst
> @@ -259,7 +259,7 @@ overruns. Make sure that will be enough.
>  .. note::
>  
>      You will know when you are a real kernel hacker when you start
> -    typoing printf as printk in your user programs :)
> +    typing printf as printk in your user programs :)

This one, at least, is as intended and does not need to be "fixed".

For a future version, it would be better to split the patches apart and
send them to the relevant maintainers.

jon

