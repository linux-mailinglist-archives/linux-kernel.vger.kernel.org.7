Return-Path: <linux-kernel+bounces-848673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A4BCE4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7282D4FA1C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D030147A;
	Fri, 10 Oct 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDSbhlIG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798711DFD8F;
	Fri, 10 Oct 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122618; cv=none; b=qH32J0EuWT91M/+nTUIAkkByuezaA8hbkJYJYHtCRcvgBMtoDP4k46BvKvbGVL6wcCug33TtJNlV2PgLVpAdP7IgXNtMQD/8zYGF3GuTQ6up6z71LOk9bxfRw8YebThJQwwv/uvxn8+2lQAitV8EHt4SC3kVrVRtfNn+ZQN/eY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122618; c=relaxed/simple;
	bh=cdBUSD3I+k/RO6LWHsL0MFySxp8ZU7S3XnCWu70QZ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjGpEAWSpmkw16wNzivVf6RdPjnidPPB+9v/q2Q3rq+Ylfv7xUo/h0V5Em83uubGb1DGk24YqR6GcdGhHfVHPEcXlW1RI9RujIEeJ0RcicklhStt/4NI764Y/eeGHKMuKYzTRT8P9Nui+kvTHFQ++ADy2DBk4jyxbHbaVCrdhOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDSbhlIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15E8C4CEF1;
	Fri, 10 Oct 2025 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760122618;
	bh=cdBUSD3I+k/RO6LWHsL0MFySxp8ZU7S3XnCWu70QZ+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDSbhlIGRbJqZPIRs2W2ss1kLLlsIjei8ZXMtw6XojXU3iSDcxEwyIbG57HSHq6vW
	 Et0HW/Z6PWxZfvNdWKiPkUaEpDgIUcLSdppjfXCsVOeIirumef7l4mTXalIDl30CLe
	 lFImCZdFQv5X6gvq07emAcWWoXHuFSGdmJAakusLvgBHcs8iji2Dirvb1YUx8uOiPQ
	 oKyIDvjk4KDuXp7XoKkukmAI1HJ2CZYj+gcPvBYjV+P4o9JbuAZEeENDYlouumkVFI
	 tPvHdCrjHMRKfMRMfrX8DZdnztFyYc8BnB5eJcnOyYdvluys8ctYIDnagPV9NSXl8w
	 g6Op+VVcM/UWQ==
Date: Fri, 10 Oct 2025 13:56:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: devicetree@vger.kernel.org, robinchen@ti.com, will-wang@ti.com,
	lgirdwood@gmail.com, chinkaiting@google.com, broonie@kernel.org,
	jim.shil@goertek.com, henry.lo@ti.com, tiwai@suse.de,
	13916275206@139.com, linux-kernel@vger.kernel.org, jesse-ji@ti.com,
	conor+dt@kernel.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, krzk+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, k-yi@ti.com,
	toastcheng@google.com
Subject: Re: [PATCH v6 2/2] ASoC: dt-bindings: ti,tas2781: Add support for
 TAS5802, TAS5815, and TAS5828
Message-ID: <176012261542.715803.6759759704259980882.robh@kernel.org>
References: <20251010022951.51581-1-baojun.xu@ti.com>
 <20251010022951.51581-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010022951.51581-2-baojun.xu@ti.com>


On Fri, 10 Oct 2025 10:29:51 +0800, Baojun Xu wrote:
> TAS5802, TAS5815, and TAS5828 are in same family with TAS5825, TAS5827,
> TAS5802 and TAS5815 share same address setting, and TAS5828
> share same address setting with TAS5827.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---
> v6:
>  - Change the patch title and the description in more detail
> v5:
>  - Change the patch title and the description
> v4:
>  - Change the patch title
>  - Add TAS5802 support in yaml file
>  - Change description for missed TAS5815
>  - Change format to keep all lines within 80 bytes in length
> v3:
>  - Rewrite the patch title
>  - Add TAS5815 support in yaml file
> v2:
>  - Update description for TAS5828
>  - Change commit tree to .../tiwai/sound.git
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 43 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


