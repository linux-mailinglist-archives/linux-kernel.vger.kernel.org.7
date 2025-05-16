Return-Path: <linux-kernel+bounces-650801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4339EAB963D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 08:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239ECA0303C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2068E226D00;
	Fri, 16 May 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OmzugMIF"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F622617F
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378197; cv=none; b=gG+wmdbv1Wsl1UkHxeJNQm5Tc3jyUGfpA5rQ0+YcKPRRwpm6eFPKeAnscJufa0zshP0xuNb+Se9NxwYzY/m8TIXOJIUhEv3SFdWQnI4+JIuOwaChIHpnLQy+J99ctcvDAcr4QiLlhBWZ2pBbRIo1n0gZFk/inB5zQbOw8DWn/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378197; c=relaxed/simple;
	bh=lvZN8ysfJIxtlbmf2W6ZNOmXfkWyntAbEQLSjdeK6Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8u8bdOdB3xFzCl4AlNF9+39dJj6tAbdum2eqkGxLh/Ernep526KQoar/7SPup/HVm4s/hj5BxQhODjuzNOr4L+Rr9jnnenS+ikTbH0JsftFBnGmmvlCBKfypDsUh8ygXHA0Ev7CbIBTuLhviSZHt6N2XmAf+TxuOsoN/OoAY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=OmzugMIF; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BF9554B709;
	Fri, 16 May 2025 08:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747378194;
	bh=lvZN8ysfJIxtlbmf2W6ZNOmXfkWyntAbEQLSjdeK6Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmzugMIFy9I9MsjspOeLFtK7NKdkManP5FRIFLfK5GMviXeOjr+bkCrDLTVRyYe3X
	 9v3pyG5VriexOAnyHfTcv750WLw/IBJhhFKG1w6ADEtsapKBAm9N7UmvY+5bJIkbUT
	 Xd17DE86fTfsQRunKbPz2W++xTkZHIMWafoDAr9Q3fHp7mvD0+ubyPwYucaGo/RraK
	 R59QfPSRMIR3tV6tUMnj2/DIsjrXO19AYRRRAQFsPWDyG5I0+xjR/m1QEdwLU1eR5s
	 pp82Rmk5Q8EZbKVY9TKTekdPpgIEP2s0gI80gq3KuLsC2cU5/TRbEn2RSpOSY89SYb
	 +sLH1YYWRA2NQ==
Date: Fri, 16 May 2025 08:49:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] [PULL REQUEST] Intel IOMMU updates for v6.16
Message-ID: <aCbgEdv-dMX7wa6G@8bytes.org>
References: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513030739.2718555-1-baolu.lu@linux.intel.com>

On Tue, May 13, 2025 at 11:07:34AM +0800, Lu Baolu wrote:
> Jason Gunthorpe (1):
>   iommu/vt-d: Restore WO permissions on second-level paging entries
> 
> Lu Baolu (2):
>   iommu/vt-d: Use ida to manage domain id
>   iommu/vt-d: Replace spin_lock with mutex to protect domain ida
> 
> Wei Wang (2):
>   iommu/vt-d: Eliminate pci_physfn() in dmar_find_matched_satc_unit()
>   iommu/vt-d: Change dmar_ats_supported() to return boolean
> 
>  drivers/iommu/intel/dmar.c  |   4 ++
>  drivers/iommu/intel/iommu.c | 113 ++++++++++--------------------------
>  drivers/iommu/intel/iommu.h |  21 +++++--
>  3 files changed, 51 insertions(+), 87 deletions(-)

Applied all, thanks Baolu.

