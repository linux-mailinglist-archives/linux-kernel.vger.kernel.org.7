Return-Path: <linux-kernel+bounces-622927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183CAA9EE84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7526A174B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFB262FEE;
	Mon, 28 Apr 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="YG5PiWxd"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF7026136D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838309; cv=none; b=FW3knKUGQIsG/xb4Wiba4fld30OffRdZ+cDDlZ8AC0ihNWQ5L6F2ZFWANfMKjtVqyM20o0Dr69a9FbQHsp/N+qf3XDosI0ZVwFTeeDpKy7gpGqnJ5bq+K+ImI6cMes8rqSlUHn9AI1QOpiTcIAWrabMgtPZSZfaqrLOkQrhRrdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838309; c=relaxed/simple;
	bh=bqBEy1pjrZkJZH4HVMstyRULaGNN46KRsmnDIVHBgp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyIY/GTl+kUjB2WsobZCgmJTMOmGJLacQ/mdSzoNskthkNmS3vfN0mpmCn2ytDCFFOpjpBv6VsLT5tsOSWDiAoq+ql4EVF2hvtTzNr7a2g+7/8Za81NSCMckFfckByc7beacLhtMpyvfIM39fNTEXrqv1AQUNjdvWXVujFAeSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=YG5PiWxd; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0E0A049648;
	Mon, 28 Apr 2025 13:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745838306;
	bh=bqBEy1pjrZkJZH4HVMstyRULaGNN46KRsmnDIVHBgp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YG5PiWxd3YffeFLcyzRv61sn/383feozlcfTgQvLPpb8F35fecTZANNxCIR8SHgvG
	 ajHsE4Oc2IQvYE8zVIindtBE5uYglz9+bEcu9fmg5b9I73Bftl+OpMIPO2CKGQiI9p
	 Kuw6Mkmm6G7w6PsJoZX6/doliaVPIglFqzdRIbALiN5Qw/3VOEh2uWacu6CbG2qOfg
	 p1qTVO+QwxVzzU9gOe9HHr7lOh8D0eXoe4r48/NvBpn+uMPueK6xsjJLMmsLXRcnhz
	 +b6rdkBKvqb6/VH2mWiNfDgCknp5b7weMPo8WYn5rKPm0YSB1rbIWERbuLiEUSd5gU
	 BHZ3iwa4gCzJQ==
Date: Mon, 28 Apr 2025 13:05:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Message-ID: <aA9g4DsqlMdi0985@8bytes.org>
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418080130.1844424-1-baolu.lu@linux.intel.com>

On Fri, Apr 18, 2025 at 04:01:22PM +0800, Lu Baolu wrote:
> Jason Gunthorpe (2):
>   iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
>   iommu: Remove IOMMU_DEV_FEAT_SVA
> 
> Lu Baolu (6):
>   iommu/vt-d: Put iopf enablement in domain attach path
>   iommufd/selftest: Put iopf enablement in domain attach path
>   dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
>   uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
>   iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
>   iommu: Remove iommu_dev_enable/disable_feature()

Applied, thanks.

