Return-Path: <linux-kernel+bounces-899911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB04C59614
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01E974EB28B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106326B0BE;
	Thu, 13 Nov 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsY4pPki"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA626A1C4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052798; cv=none; b=RMEaiCX7qf3VL1eSxIZcm3qHEyvDKPfv6fko5jarP2KfX1LbqZamld6zvzY3dWmGR5r1d/C62gn3jexKJCVaROWO/sKqB5TAzMqpgTvm5zdYDI4/ppQTnNfstU4E8HI/ZJ34oiNDWD4k/hPa7C5VuQrT8OEL7OgrqueY67+R844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052798; c=relaxed/simple;
	bh=J0LTneI1w5+0lzY1O12kiuLMwx/JWYrlOjCzi0DReoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+FknSi4F+XdNPIto/VA4QIG4GMZsCsjolZG5SeBghgve9jMj9Jh99acRqYGFIMTFsKKORj7Ss0ndKc/Kw6BtkBYZHignMH35ZNr9tZXxmN7ol6pk/U1J91u3Tz9O8cUwprSNbZXDjCzHbDKIGVRw9VVck1Jx5ppwvos2LEeukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsY4pPki; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763052797; x=1794588797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J0LTneI1w5+0lzY1O12kiuLMwx/JWYrlOjCzi0DReoI=;
  b=AsY4pPkiAyn/9B4vjPI/hliiCSqBbbVClHe1BmaZxUtVMTcyzUbuJver
   Cxe5/K8cxWhP0O4pc0LOakXw3AX3fPk2hYEGM/5fTOhSCvD94JkmoRYlv
   HjbFNl3pCMtJYhL9yXZFdWYSjWcEya56SNRAHdgQaWCuZn7Vui6LlLrUF
   ugz9yPsiq6RMfs6gr/9xtWPEHq/MC2vvThMLlqch1DvyMcd3whv62F6Z3
   9iTtsenKKvozGMls+elW76LehLWNnKdXViFZpfkzUMq/25CPvT8QdlYvU
   RC1Ab0pv3aVRMFxV4llUZyQ4TmTEiz6r9YF7L8F3TyFFrQN7T6AIAy57B
   g==;
X-CSE-ConnectionGUID: WDYpKoFsQ5uVMhA63avWEQ==
X-CSE-MsgGUID: YhZYdMQpSTOnWUT/+d8XWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="69005316"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="69005316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:53:16 -0800
X-CSE-ConnectionGUID: drIi4XjdTmmPsoCB7w559w==
X-CSE-MsgGUID: l4WSpUDzRcW1RZZ4B5vlsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="212945564"
Received: from mfalkows-mobl.ger.corp.intel.com (HELO [10.246.18.39]) ([10.246.18.39])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:53:14 -0800
Message-ID: <56ceb509-496f-41c1-a864-6b2eb841c24b@linux.intel.com>
Date: Thu, 13 Nov 2025 17:53:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: Treat power-off failure as unrecoverable
 error
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
 mario.limonciello@amd.com
References: <20251106180521.1095218-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Falkowski, Maciej" <maciej.falkowski@linux.intel.com>
In-Reply-To: <20251106180521.1095218-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>

On 11/6/2025 7:05 PM, Lizhi Hou wrote:
> Failing to set power off indicates an unrecoverable hardware or firmware
> error. Update the driver to treat such a failure as a fatal condition
> and stop further operations that depend on successful power state
> transition.
>
> This prevents undefined behavior when the hardware remains in an
> unexpected state after a failed power-off attempt.
>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_smu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/aie2_smu.c b/drivers/accel/amdxdna/aie2_smu.c
> index 11c0e9e7b03a..bd94ee96c2bc 100644
> --- a/drivers/accel/amdxdna/aie2_smu.c
> +++ b/drivers/accel/amdxdna/aie2_smu.c
> @@ -147,6 +147,16 @@ int aie2_smu_init(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
>   
> +	/*
> +	 * Failing to set power off indicates an unrecoverable hardware or
> +	 * firmware error.
> +	 */
> +	ret = aie2_smu_exec(ndev, AIE2_SMU_POWER_OFF, 0, NULL);
> +	if (ret) {
> +		XDNA_ERR(ndev->xdna, "Access power failed, ret %d", ret);
> +		return ret;
> +	}
> +
>   	ret = aie2_smu_exec(ndev, AIE2_SMU_POWER_ON, 0, NULL);
>   	if (ret) {
>   		XDNA_ERR(ndev->xdna, "Power on failed, ret %d", ret);

