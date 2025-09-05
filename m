Return-Path: <linux-kernel+bounces-802895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722EB4581C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EF23B490D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6E34F47B;
	Fri,  5 Sep 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nb8iuz9A"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219EE1F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076458; cv=none; b=SfOKS3uFgMD00mAkdE+W1dvDU4iUVQIiBShpc8In4lpPtUtPqy0PyJuJihKPGUzgblRIRvd1lZ1iUygWLeIU0mUpPBEx2kjgDttExrNJOFbsUDXBGcxXPxpnwJviY5zi+9f5V7V0AdkdOOsVjqdJnxRNG336m3vgO+LfQS4H35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076458; c=relaxed/simple;
	bh=QEQQVhBJr9vTGUqxLLbGROAdD9ATWKivXMfcUsVX360=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXvWjHg59MrOYBorb5Vm6iApXxFHgqE+0rCxL3+S+VfmGG0ekhk4Ee3IYB+EIi9zqBmlcxw8he3dti2pL/R7KNgXViy3zIh2WRAdiygLfMgDH3FO39s4NbKLCbwRHY5XEegmOO3rVtExwqfsixX5Z80xYTXegNM+EFBm1oEtWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=nb8iuz9A; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 035C254B38;
	Fri,  5 Sep 2025 14:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757076456;
	bh=QEQQVhBJr9vTGUqxLLbGROAdD9ATWKivXMfcUsVX360=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nb8iuz9ARztuzTmOcRKnAzfrKUCGJ/Fc+ZsvXMwokcue6P8JrZitKrkILOM4b7AgF
	 xCqOV3yArN/7bWpSYYbI5weW8PcmqSX4HO8dw0efTuCmqjvHg5NUqiU86qK7H0H9u5
	 hEKbPt4UN5uY1i6tPQ4QyslY2eO7lW3KKluDkXHsUUTTFL+iAd8uzqEoIQwQ1p5dFN
	 J3uuQ/Kv/8/OGV553xtsHqRkdfipIF0oZKx++hOgIdlkRRdMa2fBn78j7sMTPiRfh6
	 XmuRL8gKN0y+CQNGrOnGSAdyldpV01hwoY9WK5NoQRWvnVCFDgOtjwuZoRJs58sEmv
	 +toBN7N892Xew==
Date: Fri, 5 Sep 2025 14:47:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] iommu/apple-dart: Clear stream error indicator bits for
 T8110 DARTs
Message-ID: <aLrb5kt7imDLdZpm@8bytes.org>
References: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>

On Tue, Aug 26, 2025 at 12:57:18PM +0200, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> These registers exist and at least on the t602x variant the IRQ only
> clears when theses are cleared.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> I've overlooked this change for the 4 level page table / t6020 support
> series [1]. There are no dependencies to series so this can go in on its
> own.
> 
> Janne
> 
> 1: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net/
> ---
>  drivers/iommu/apple-dart.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

