Return-Path: <linux-kernel+bounces-802915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 463A2B45858
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BED1C841A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83D86250;
	Fri,  5 Sep 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PffN2JcE"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276FAB640
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077263; cv=none; b=l7E1V1OvF7qtvo9p3Gf87kBPHvB76wmb/oO+ocQ45BALXbBwEskvtQRuXerwhkV1PVRQAvoTbR+zq6jas0NIAPQP0SDu/wLGOBN8ymDzafNsDFzDNGJ2Ou5hvqMo/Md1A9lurAye/6cp4dmt7sPp8KxV/ySTamwAy5AWflTxGvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077263; c=relaxed/simple;
	bh=cpfj21JmBcuZVpXwVG09m9Ezr6VNRpFa2CECZ7dB7+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGstTRJznjEvQCXOuGMb/q923qkfe/r/m6SwAjrHxGtzpPUyt03qMDu7FebidYE+ehro1fRiVx1F7fHslKTfLbYXForWxMU25JKCni/v+7gYQZ+0qVq6jMK3lIdN0Hsck8vem3tbZnHwQ3z0fl08CbMAO429JVM9Fi/gfTZACBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=PffN2JcE; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E490F54B04;
	Fri,  5 Sep 2025 15:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757077261;
	bh=cpfj21JmBcuZVpXwVG09m9Ezr6VNRpFa2CECZ7dB7+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PffN2JcEEs8371rZ7rvNIsuHHi/dBgG4XC1ihkuUgMd+Am7EWkEtctZWjn5/3g1cm
	 muoActV3+0B9/j6bnboV6hbKy8sHLHiO1SHiJj5f5kf51rytrMK268pTyGB3bv2D0i
	 OLF6Jt+LrrWa48+vC7rX2xeFfEZQBU7xx8RqBP7ZC1q2USgrDj/WQG79IOc2P0cCUx
	 2VFZC5q6Fulsm+hjsAffPf/ZADkxI2VXXvX0R5lyEHoRH5IcyK5cEOGNCvOb8CmNHp
	 74LXy4RC3wIVrPAPMQ22DqXVeSFNri6J5xS8di6r2gpUxdgWZ/WNk1It0JSX0RcfKR
	 sQlKtyNW453pg==
Date: Fri, 5 Sep 2025 15:00:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Eugene Koira <eugkoira@amazon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.17-rc
Message-ID: <aLrfC9NCbfn5ZCis@8bytes.org>
References: <20250903055329.2876815-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903055329.2876815-1-baolu.lu@linux.intel.com>

On Wed, Sep 03, 2025 at 01:53:28PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following fix has been queued for v6.17-rc:
> 
> - Fix __domain_mapping()'s usage of switch_to_super_page()
> 
> It fixes a bug in __domain_mapping() where valid PTEs that are beyond
> the affected huge page range might be zeroed out. The patch has been
> reviewed and tested and is ready for merge. Please consider it for
> v6.17-rc.
> 
> Best regards,
> baolu
> 
> Eugene Koira (1):
>   iommu/vt-d: Fix __domain_mapping()'s usage of switch_to_super_page()

Applied for -rc, thanks.

