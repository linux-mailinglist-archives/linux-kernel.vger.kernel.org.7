Return-Path: <linux-kernel+bounces-769585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6CB270AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A2560443
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E322F26C3AA;
	Thu, 14 Aug 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq05dWe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0D2DF68;
	Thu, 14 Aug 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206202; cv=none; b=S2DfnTe0+H9sClz8PF1JPUvp1jjsPm1kt2mr/U2AFTON+qyBn5w6wjSF6CUIz+b7gvDZI1fPGrRTOKwiTcbNkx2JkWgqFzcnGm2m7BBxBmDpJvDXgb3d06KywliIfdpe5E4TL7BpJNvKiSedugG5TL/JzSrHF7WB0Hm5RSzyHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206202; c=relaxed/simple;
	bh=F9NgLCE3CgUchXXAG7Nui76NLuCv1bWSnUYa8fyTInY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMCPbQgdjiSTS63PPT9yLEczFQRyuAvV07yTADuz//oNmwIUFC/81tJJt+0gYOoLJ8w9O29LvVuI08fQtWbnUdYQgekrb6AKTSYtBVYWHbah9JoPFTeT3zqCNLtygDzJ7g1pmuV0zcPVhLIy2v/jiHxdSCLFxaBpr+17Obr70jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq05dWe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8643C4CEED;
	Thu, 14 Aug 2025 21:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755206201;
	bh=F9NgLCE3CgUchXXAG7Nui76NLuCv1bWSnUYa8fyTInY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bq05dWe4xStG585C1iiBph/1g+sM0LGg6ptLwmqQ1eEwMRmC4Y9hfBi0pUUh4bKpg
	 Au+WIFl7RIBC56LaOyHUQbRrtpEqoOhxTZ7riZRwj71nRQbE3hzHjmKkbe3buqPBzv
	 9yQRGziSldWsSdy4hBCu0HPAjmV3eX+hZd3N2R6Q/gPjLKh54osy/n1QB6Ti/gDSaT
	 6CDhgyg8rM9DOOc7VAQSDazfSi1kt1vBzdIoZgmBI2Vzw5YonfCtYkeoE5bOcqBYtN
	 eOCqADPZ9DN/MPUrV4gPBuTrfrZg0qPtsGqCG3Emj7cUQNeo2c/PO5GrbY6nSihmPE
	 44BwkWPWQYrKA==
Date: Thu, 14 Aug 2025 21:16:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>
Subject: Re: [PATCH] hyperv: Add missing field to
 hv_output_map_device_interrupt
Message-ID: <aJ5SOFR8HNqPxBKN@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157B75073B1E6ACDB6405C1D435A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157B75073B1E6ACDB6405C1D435A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Aug 14, 2025 at 06:57:22PM +0000, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, August 13, 2025 11:21 AM
> > 
> > This field is unused, but the correct structure size is needed
> > when computing the amount of space for the output argument to
> > reside, so that it does not cross a page boundary.
> > 
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> >  include/hyperv/hvhdk_mini.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > index 42e7876455b5..858f6a3925b3 100644
> > --- a/include/hyperv/hvhdk_mini.h
> > +++ b/include/hyperv/hvhdk_mini.h
> > @@ -301,6 +301,7 @@ struct hv_input_map_device_interrupt {
> >  /* HV_OUTPUT_MAP_DEVICE_INTERRUPT */
> >  struct hv_output_map_device_interrupt {
> >  	struct hv_interrupt_entry interrupt_entry;
> > +	u64 ext_status_deprecated[5];
> 
> Your email identifying the problem said that without this
> change, struct hv_output_map_device_interrupt is 0x10
> bytes in size, which matches what I calculate from the definition.
> This change adds 0x28 bytes, making the struct size now 0x38
> bytes. But your other email said Hyper-V expects the size to be
> 0x58 bytes. Is array size "5" correct, or is there some other
> cause of the discrepancy?
> 

FWIW the array size 5 here is correct.

Wei

> Michael
> 
> >  } __packed;
> > 
> >  /* HV_INPUT_UNMAP_DEVICE_INTERRUPT */
> > --
> > 2.34.1
> 
> 

