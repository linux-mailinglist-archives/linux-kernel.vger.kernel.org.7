Return-Path: <linux-kernel+bounces-886353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C6C354F6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AD2E4E06CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1330F7F8;
	Wed,  5 Nov 2025 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="WIB9Yl0W"
Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088F3016E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341396; cv=none; b=nj18dkbA3698UXMD3Y+rgT/J7K/IxO/W/LLm0H25/uaqJARAMEjk1qzSRd8AECxWtIamdZLGNELSCBRx5asp3VDR2wNE7a+FQygWbP3Ocksruq7CiWucd8iRx2g4eFcGqT1fs6gAm/LkrkASINNBMxUtn08rA0m2v+qXLkcF408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341396; c=relaxed/simple;
	bh=gmrLDFWIcFEh0KvbnxCeN7ggLLHUJBDVEAKb2UpLZVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ii8pqR2Dn9LeOzol0Cm14pNqtZHI5l1ITEe75nfLCGGSuHUhAEH3RRqLwdTYySTswX/5nSoZG2VvPD4PXrj0BuWic9ECtORQYxZVtl8/R0UqFXJqNAPLxa3UIx8UI+o3XR/0XGq3Fh9K/7a8uVI70DJDz+mmc0cw1wQgmH+1/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=WIB9Yl0W; arc=none smtp.client-ip=146.20.161.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762339061;
	bh=gmrLDFWIcFEh0KvbnxCeN7ggLLHUJBDVEAKb2UpLZVs=;
	h=Date:Subject:To:From:From;
	b=WIB9Yl0WLbne2ba/EbDcR8hvmkBLPu3P9tUJXDUfGuBWGZyE8ZSCPCfHby8Ps5EiK
	 5pg0bNdpL//RNxxKHOR9cvcpx7164ljYF5c96DymehkxBorl8BbQ2oEIIJ5g7GaaLr
	 F0B5oQ5VCT9UHZFRWAh8gYSjavaMLtZ7lOlHSzbk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CD318403C0;
	Wed,  5 Nov 2025 05:37:40 -0500 (EST)
Message-ID: <22148db9-3579-4298-b641-91cc98dc1c5c@mev.co.uk>
Date: Wed, 5 Nov 2025 10:37:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] fpga: Add dummy definitions of API functions
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20251104153013.154463-1-abbotti@mev.co.uk>
 <aQqsnFl8uakMAsH+@yilunxu-OptiPlex-7050>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <aQqsnFl8uakMAsH+@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: e93dd03d-3b13-4ec7-81ac-1f36f800238a-1-1

On 2025-11-05 01:47, Xu Yilun wrote:
> On Tue, Nov 04, 2025 at 03:27:01PM +0000, Ian Abbott wrote:
>> Add dummy definitions of the FPGA API functions for build testing
>>
>> 1) fpga: altera-pr-ip: Add dummy definitions of API functions
>> 2) fpga: bridge: Add dummy definitions of API functions
>> 3) fpga: manager: Add dummy definitions of API functions
>> 4) fpga: region: Add dummy definitions of API functions
> 
> Sorry I don't get the idea. Why should someone use FPGA APIs without
> selecting CONIG_FPGA_XXX? Better make the changes along with the use
> case patches.

Projects using FPGAs often have custom devices with custom, out-of-tree 
drivers, so it's quite useful to be able to build test those drivers 
against later kernel versions on the host to keep up with kernel API 
drift, prior to possible later adoption of the kernel version on the target.

> Thanks,
> Yilun
> 
>>
>>   include/linux/fpga/altera-pr-ip-core.h |  8 ++-
>>   include/linux/fpga/fpga-bridge.h       | 75 ++++++++++++++++++++++++++-
>>   include/linux/fpga/fpga-mgr.h          | 95 +++++++++++++++++++++++++++++++---
>>   include/linux/fpga/fpga-region.h       | 44 ++++++++++++++--
>>   4 files changed, 207 insertions(+), 15 deletions(-)
However, I messed up the patches, because I only built them without the 
FPGA configure options defined.  I plan to submit a v2 patch series 
unless it is deemed a complete waste of effort by the maintainers.

Cheers,
Ian
-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


