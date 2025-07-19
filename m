Return-Path: <linux-kernel+bounces-737801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E7CB0B0B8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2601AA1D87
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79462882CF;
	Sat, 19 Jul 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1o9Kuvb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39121FDD
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939752; cv=none; b=VwgmzfenjtsEuS1en9uY4feCqh1DKS8toguiiawqJ62HyvMATldYjBmsYsBtfZox9QxKmGo6FL0Zox4qqiXz2T5vrTwcCE7KYXOkvt3JRhIiEQ3EtZwbfG6bgTPDI2N4bO5LkMhTnjdf4slRViuuGItOAxZzLnjumr9IZ1dHAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939752; c=relaxed/simple;
	bh=DEvVPbCtw11NFjGces/xoch33xS6tb9+zxHp1secYOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF1XzjGQLnOe0RbhvF5OTYRIJjR/vjAqUETOWvmf+scTSHyRAKwmTcN/U71XJ4OBpYLbax2umWlHSCZD7Dimxo60f0AK63QG7LVnnF0uVe8AJuh3k/9sBGzIrJp+GYMqobqCaLiZfDtag6/XyLWCLYE5x3TVyGEaGlnQIvA+BOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1o9Kuvb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752939750; x=1784475750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DEvVPbCtw11NFjGces/xoch33xS6tb9+zxHp1secYOo=;
  b=I1o9Kuvb2JDTfDr0Fdp1BHFLue+nHbwJv+dRDoRhXkS2Q1hLwpAF+FN1
   g0zY0wcvVTBfIJfkXZPgMfWHWPYSVU4nkK+gKuRmH7WV/oQiO7ED8Ulq5
   ry9+QWmzraWWpf8/T5CMqhFAGewsyg2MmLjF+THgBeIA54xNjgNNcB8MM
   KqmZYUVS8kBH2qGZFjTs29MXG97QRSkCD3oTVnVmeFU386QKtK9WwGce6
   SfkntzIx6L7r4Ey67iWgCY55Hl/sGoWSZPIeZ0Y60n88BtfDafcKJb5xP
   be7zXrK4enK3AgQjzQg4msiy1h0r+APQJrKle1T3F1GNd4FE3Vvw420AG
   A==;
X-CSE-ConnectionGUID: 1f1ChNCGQJmxis4qDAT4Tg==
X-CSE-MsgGUID: Thf2i+vRTOWFXrncdgUj7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="42834141"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="42834141"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 08:42:30 -0700
X-CSE-ConnectionGUID: ArCfbBFSRVq1JyaiioaeuQ==
X-CSE-MsgGUID: RPqkSNjVTQmkMrOxKr5mUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="158510114"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 19 Jul 2025 08:42:27 -0700
Date: Sat, 19 Jul 2025 23:33:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v6 0/8] iommufd: Destroy vdevice on device unbind
Message-ID: <aHu602GIHL4cHvST@yilunxu-OptiPlex-7050>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
 <yq5ajz45275s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ajz45275s.fsf@kernel.org>

> >  9 files changed, 419 insertions(+), 231 deletions(-)
> >
> 
> Can you share the commit id these patches are against.

Sorry, somehow I forgot to use --base 

base-commit: 601b1d0d9395c711383452bd0d47037afbbb4bcf

> 
> -aneesh

