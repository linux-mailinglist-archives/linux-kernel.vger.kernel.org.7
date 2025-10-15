Return-Path: <linux-kernel+bounces-854494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C168BBDE836
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565833E2E69
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02A450FE;
	Wed, 15 Oct 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2gpWtDl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F02EEDE;
	Wed, 15 Oct 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532007; cv=none; b=H6bfbBBRKlqCrgAyr4MpfzRTALdqy/qELkuUF9UwIVTW2iDOv14LWUYWYi50OrLMWXgU9aJAAJDfkt2ubLtgaImg3sGSPeLL36hjUDxlM33m1Gd8kbkA5pgNK4/OvMFKmTA5c3UaZmyvOEEYP5cz9sl8e3a8xvmrBi+7SXJ5XTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532007; c=relaxed/simple;
	bh=+O+6yIYr8FzPbqLDVixZB4ttA26iKq/msZN98cXYthY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwgvhmdKNH5D6acT2uDdhlP8ZCaIPkxARwe21FutwgHhjrErlnwtodRnUhj4uTwwpPdGtPgFLc8/ZBK47Ykol1if3uz0DGpNognoca5Fn5CF+GlW3C1riqjkWITKg4E3lDO9lmNMl2y18CLSuLAyawSbQQ2zZCL9Zr4RABsXD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2gpWtDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA87C113D0;
	Wed, 15 Oct 2025 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760532007;
	bh=+O+6yIYr8FzPbqLDVixZB4ttA26iKq/msZN98cXYthY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2gpWtDlTvjz1RDRypFRUoftIsS0ta1nv63XEuFb5Qe1CuP9upnEyqfjCVqMU8cSJ
	 1gCJ9jDGdZgCB1T7ePBrQtrNok3LkzGJtm2WiyhGaqo7BVSmgJdoBQGoDRSrrU1L3P
	 yVH0X0bryzo8kuVyhmLhmffkRwVOdSCJYFI5YpVuHYygAj5Bfijy/0mJ5NfG572Cia
	 zt2wY8pqlX8IdCV7E5zw5i63b30mYPPFahizjf71RkJV+2tDy1N3T97K703ZDl7PVl
	 svMAb2IJN/RSFUJG465hYPxa3DWrcTLRR6N6QirtImasYNszxyYT6P4jR5vVgUXbUF
	 KoSBHpkeF+Qlw==
Date: Wed, 15 Oct 2025 07:40:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: 13916275206@139.com, chinkaiting@google.com, devicetree@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, tiwai@suse.de,
	linux-kernel@vger.kernel.org, toastcheng@google.com, k-yi@ti.com,
	shenghao-ding@ti.com, will-wang@ti.com, jesse-ji@ti.com,
	broonie@kernel.org, krzk+dt@kernel.org, jim.shil@goertek.com,
	robinchen@ti.com, henry.lo@ti.com, conor+dt@kernel.org,
	lgirdwood@gmail.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ASoC: dt-bindings: ti,tas2781: Add TAS5802,
 TAS5815, and TAS5828
Message-ID: <176053200447.3198136.11218701016836668854.robh@kernel.org>
References: <20251010085349.52951-1-baojun.xu@ti.com>
 <20251010085349.52951-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010085349.52951-2-baojun.xu@ti.com>


On Fri, 10 Oct 2025 16:53:49 +0800, Baojun Xu wrote:
> TAS5802, TAS5815, and TAS5828 are in same family with TAS5825, TAS5827,
> TAS5802 and TAS5815 share same address setting, and TAS5828
> share same address setting with TAS5827.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> ---
> v7:
>  - Updated the patch subject
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


