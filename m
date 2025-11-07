Return-Path: <linux-kernel+bounces-890147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FDC3F544
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC194ED630
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA448303C8F;
	Fri,  7 Nov 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="fYiQs6Pa"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064FF2EA75E;
	Fri,  7 Nov 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510075; cv=none; b=tMhuSeQPregwiCTfoweEknq9QkAUm3mKnnGCe//rCT/XUJ8uW69YjaQ7LPrWPWjBVvonARjY3AvDJVQ/b12TOYFbxUdJASVthl6EWHZnQWR6CjWn/CJjvNO0gEJIJOZ0PgNeiAGYUKhR0ktbH523WQ3Wf7XSGFPLXwI+1vyEqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510075; c=relaxed/simple;
	bh=MRszau4EGn8ahuZAhFMfYjkTGaVs/90v6F7rF4hkSWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTKXBUKw47Xe/34GOUs9lyYgHIdglm4YR2WD7s84Qe/idP2MqFAdSgpfK8bj2an8rPN3OzPZPdzTk3/taVaXd9viciPDw/0QSHjhZ4DScEtsSbKPZW70ZMfHUHNLOI/h6J2xG8W/JjESv2y9lMYrVn1vgFvWA8UPLtPumwafxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=fYiQs6Pa; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A120C5AB91;
	Fri,  7 Nov 2025 11:07:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1762510064;
	bh=MRszau4EGn8ahuZAhFMfYjkTGaVs/90v6F7rF4hkSWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYiQs6Pac3M3WJFBzrBnwpq944TMUbEbgbXKMkw3Dp38PLYRrRkPHEs9PGGLC372G
	 NOeOz6BL7iA1cZWovGR+XgokbPnL/tQL0jTzcogd+h2/fOc/+6RJHA3oZTKUp90POf
	 OeCCyRo9SrpD/wwQ/DEM3a6Iuzqwj2bGKzBLaG548wVTweH5RsTxEWDKNlM9xka5kE
	 A9gNZ2EAvo4CGr9ATBabG6XiWGo5j6ZQlJXVtM0DPocT7m36qC12CwDg2rAu/AHLW/
	 jbXMHQKYidvLniLffVHOnCaDkDWZY1Rt7MvJ7ylYn/82bepOyj5bUhs044RaLR4ecW
	 hFTcp4/eBQv6w==
Date: Fri, 7 Nov 2025 11:07:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux IOMMU <iommu@lists.linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Randy Dunlap <rdunlap@infradead.org>, Kevin Tian <kevin.tian@intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 0/2] genpt documentation fixes
Message-ID: <7cq6vnkxgxmduboodquplg7efijx7yc7y3ddyalgf7tqg46tyk@7ityzyjwxomm>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107081300.13033-2-bagasdotme@gmail.com>

On Fri, Nov 07, 2025 at 03:12:59PM +0700, Bagas Sanjaya wrote:
> Bagas Sanjaya (2):
>   Documentation: genpt: Don't use code block marker before iommu_amdv1.c
>     include listing
>   iommupt: Describe @bitnr parameter
> 
>  Documentation/driver-api/generic_pt.rst | 2 +-
>  drivers/iommu/generic_pt/pt_common.h    | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

