Return-Path: <linux-kernel+bounces-779749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEBB2F82C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2305C5C03D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE602E88A6;
	Thu, 21 Aug 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4mELOpC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF219E97B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779714; cv=none; b=pa8iOqovGt3NPmnayZIKjsC8lpY/uzeMj7+HJkPs9yhQMs2WYmAdPtPbKbzK+KlUoFsM9Z75LG8So4YIIAJDf6BjrZ8yyT6H3QAx34kFXLcupOL7RFQ1q8R7MlV0WjohNlqE8ISXyOwUcsCJuQ8KgVdQ40noHZWSBh22nDRiXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779714; c=relaxed/simple;
	bh=DGvtspg+o3hfUEstMz0E2+Cnk1KXwX8hkIEwnGjIn7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4+V0aUakpBVkaY3E19AK8tO196BpYzC3EL+ymCMdxx9CvMS2RHw2p3nFbKmPPl4pGmTMiHoTpX8r2yLlZgw3lgpXFRGW7OIDeT6/c4oVBHiPYPLDjz7ElQHdSxfFpuaW7xgLJmIWR10y5xXyKnhJcJachYhIi3VNY/EyZj/wX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4mELOpC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755779713; x=1787315713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DGvtspg+o3hfUEstMz0E2+Cnk1KXwX8hkIEwnGjIn7k=;
  b=F4mELOpCmdDMtPhVvAb/UzuZDYEl+pqHbuXtT5iczIR64pu+xXePVtAM
   mx3lazEOR0a9Twe7JJ+JR/RPX9Hh3JcWYCez71WglkPJm/5yqJsPBHVnN
   D6+l9/fSiLH0VQHqOjFs1t4uEx5THFAHTz0VxZQfi8tXcXUwXSkvcYVJX
   QwFelGV1fTqg7zkuoV71nh6XvdA7D0vPVN5zCFkcHRghGgqtsNmg3T5kj
   3mzJ4Kus69SzDTqUWjTh9Tz/A2EjUV4uokELwEhWYDt1QN6KVJd9w3n47
   GFeznt3iQ3V7IqDgsDnAkDtKCQR3qtFwv/NJmWwUJUj+LdmVAWaGduYxX
   g==;
X-CSE-ConnectionGUID: 82jcxUBiQ6SZGOMZ1h/1ew==
X-CSE-MsgGUID: WUXh5QCQTVKBRzxV6yhWUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80664174"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="80664174"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:35:12 -0700
X-CSE-ConnectionGUID: LBW8nRnRQyym4I4hZR4PSg==
X-CSE-MsgGUID: R8EN2j4AQj2jVZVb6lceMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="192082428"
Received: from mfalkows-mobl.ger.corp.intel.com (HELO [10.245.121.109]) ([10.245.121.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:35:10 -0700
Message-ID: <d1b744c9-0f2d-4ff8-832f-209167cb940b@linux.intel.com>
Date: Thu, 21 Aug 2025 14:35:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: accel: amdxdna: Update compiler
 information
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, jacek.lawrynowicz@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 mario.limonciello@amd.com
References: <20250820233817.4050006-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Falkowski, Maciej" <maciej.falkowski@linux.intel.com>
In-Reply-To: <20250820233817.4050006-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>

On 8/21/2025 1:38 AM, Lizhi Hou wrote:
> The compiler information is outdated. Update it to the latest.
>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   Documentation/accel/amdxdna/amdnpu.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
> index fbe0a7585345..42e54904f9a8 100644
> --- a/Documentation/accel/amdxdna/amdnpu.rst
> +++ b/Documentation/accel/amdxdna/amdnpu.rst
> @@ -223,13 +223,13 @@ Userspace components
>   Compiler
>   --------
>   
> -Peano is an LLVM based open-source compiler for AMD XDNA Array compute tile
> -available at:
> +Peano is an LLVM based open-source single core compiler for AMD XDNA Array
> +compute tile. Peano is available at:
>   https://github.com/Xilinx/llvm-aie
>   
> -The open-source IREE compiler supports graph compilation of ML models for AMD
> -NPU and uses Peano underneath. It is available at:
> -https://github.com/nod-ai/iree-amd-aie
> +IRON is an open-source array compiler for AMD XDNA Array based NPU which uses
> +Peano underneath. IRON is available at:
> +https://github.com/Xilinx/mlir-aie
>   
>   Usermode Driver (UMD)
>   ---------------------

