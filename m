Return-Path: <linux-kernel+bounces-802914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29DB45856
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FC53AECA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB78350840;
	Fri,  5 Sep 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="vV5P3vG4"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732A350835
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077129; cv=none; b=VfYdOHc90cyAnaiONKrlxBE1gZq6Baxyl6nT/3g2ywuNulxSqjtUwT5Yv1LQaCYFrJDfzORyf8lfijmqj2CUnhZKsdeulBTga/m7fiSYvA+OZZWkLwm/z1Mrf+AjxEPQvW+m8/HsUitriLumEROw3T72HElrdfC8rbvcY/sNEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077129; c=relaxed/simple;
	bh=RcmxVQgj4OeABmLrsIQO0VZ8BVIj60bpYWvgPtZ0tiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORDPVv1QBOQB0BdxCfSJRkKjVdSZCOxsOCpys5oAg9aIWY3dpYbVVr4crVR92WSaC07PhSm8jj/Zj55uL4sw3Q1+6PzQMiEj24O8AC8QDd0izM/IcPfOVFX1LFL+AFqBJraQBp0hIiPPSn8FSqB9XvmbgP9bgCOJVA5yolcZl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=vV5P3vG4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5A0FC548D8;
	Fri,  5 Sep 2025 14:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757077126;
	bh=RcmxVQgj4OeABmLrsIQO0VZ8BVIj60bpYWvgPtZ0tiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vV5P3vG4CShLJrt4R2J2VYP/o+TfVjftSb8Q5b0ntfouY/yjcc3OIqaxAtyqgm3km
	 K/GiO32Jz4aTedEaIB9HeuM+4WNygK0iTnJqecTY0VYMV45yz8CdZIFSmqkdpMiWJB
	 8gFWSNouWiLVNuQdYDSqHkWQ2pwwXgbgyv4KkM63VNYUBGJt5/O2jfa9OFxLMQevRm
	 DFpOvJe9ky++mlEvU56hUAf/052xCiQSfTV7ltJNTrIgulbGMqjbR5827r43a9MkV9
	 Z3akb8Gvy67w5Algo3/sAx5TfhuWVtdkwK0hWs+XXY/y8Zamtq2zu5SyDs4ukb0CCD
	 G/R0f4ojojmew==
Date: Fri, 5 Sep 2025 14:58:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: Use int type to store negative error codes
Message-ID: <aLrehYcpQcmmuKPR@8bytes.org>
References: <20250829140219.121783-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829140219.121783-1-rongqianfeng@vivo.com>

On Fri, Aug 29, 2025 at 10:02:19PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int to store negative error codes
> or zero;
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly. Additionally, assigning negative error codes to
> unsigned type may trigger a GCC warning when the -Wsign-conversion flag
> is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

