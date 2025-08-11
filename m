Return-Path: <linux-kernel+bounces-762084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE036B201FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1681189EAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F076C2DBF73;
	Mon, 11 Aug 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lveOeLxK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B42DAFDE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901614; cv=none; b=uWFOYdF4UvlgnGlAdJdBHJGzCqg8k1uwWmS2ozYTTnuEBGuv1c2ue6ALH1MpRfT7FSP+F3CD8yvlzJ1B0pPGDuQH6Yasd/zLfvSZKd1SSc34fw7HoIhrHrNDpSHD3NkZzCOGL8Zfmyh7E0+blveB90penUKjUv/7HXMOBNSKuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901614; c=relaxed/simple;
	bh=zt4usI7wOdzWsTqZ1WBM0aj2WHMVpGhK1jXWfwzFFsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOPC3FeftsusMGz6qQxLFj7WmRj9CK5Yx7K9eIwgAMX2nKwYY8JP+hS5GEc/3MYX2D5R582BOkByRaiCAHUP9QB2yuWx2HeNN+or7/pWcaMcxSs+pZB9FzXM8BE3eSbAHAl1IA/XwjhMJA4Ji0oLuEwWSwmJAsEahF/XTRL61sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lveOeLxK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ALoKW2028203
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LIVwbR0aICOANyl1yo8eAsvQlfDzlKmgpVcSOQw7yWM=; b=lveOeLxKtakVxdYs
	GCrb1kM0qWyKHP5iNjb0zYzTTxQXSY1VLb9Zgs5jTPuyOL4v9Dcztp/+Jv7s7jFU
	g3kI2N2g51T9T8pKF6M9rTINjOEMB3fs8aAXIk4246i3Gih5N9qADlY8fj8/Df8+
	5RW6NTZ2Azruze/31Jc74AWC2CDxO8kH4HLFjQBAIBuWywXHQjqPaZ/TJVExIZP6
	LYU+8Jxh5nfYCjArpn7pkst16jpZZz437zEV4cSBQgxXfJRIkEcLBVUtKA7koyT7
	aoH1f4TbyeIA/St3ET7NvcqUFk5GaB3FmKT8FX9Z0gDmfzvXJ2FSnc0VDChAopWQ
	HzByaw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dwngumrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:40:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-707641946ecso10509416d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754901611; x=1755506411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIVwbR0aICOANyl1yo8eAsvQlfDzlKmgpVcSOQw7yWM=;
        b=OSd44iilfbffKTda7ZoYDpuhvzVyH15Q9NVJzd+BEBtizJ37Pa1ryqlBa3PLYUjywI
         FKg/fYP0641pSpD6SrYRbt7H/JxAfYJSopKi+WUnrVyFiCKxBPmFTVTjHHZA6qdkFRyr
         uQSLWWaiTuLDIt7M+7P8WTNiX4of92W2BwnFHCNh91l/lmbMvo5KtX28vsLE1pUdubZ/
         VSCQmZ7eYYiM+l2k0/bm4OXic/7gQaMXF6iznvC8zceU59AN3zGIEf/1mvm7V2ZcM7oO
         qOhkOYbOkC8FUnlGoM6E0I0MKCkf9bPti0mzlmUN5VBhvave3mem8btsGWaGzC7ClTqo
         FNSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0nbu34tkiWk3TvRJNGmYncaW4wk0e2D8xgBPNJh7d9BPS4myxAXnNsS1c60qGZ3Zfsqxqgq4q+PpZYX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsQZB3pHC/YtkazBOcFuZOKPA2MK8Z4vKttA6Uytu0SyXeUaA
	mv8j2QXQwkY3oPkAcgiCFY3t5cmY7LFW7ae0SiP+CGnjkPTNvRpRzZafobunoeFvLGyGiBybgZe
	bIR7HTt4pjXkrQwq2CMJ+DajobUV4gB+RbS1J+IgurTO0Yi0zCFOJ2lcK+8an520Nyzo=
X-Gm-Gg: ASbGncvXLWIFWAL51LvQznQLxZ8WG1M/bQM3cCzdZgfDKQogfCWzzqx+qyvdlb5sJ64
	KXi+IQygHNusErg8KH9/Jl4YsOnU6Q/gEINmarLwmJpmgzn0+ilO2cT0mQdhUOOATn6XD4QcRqd
	9fA7uXcqhjT9sQuvxixDZwnZuFXkBTovFoZdkotcV7WzWj9PJ/4x7wg6YjHayyFR1vC3Ae3kKqQ
	uRjSIETVJ8araZlVlGrUiJA0Ho0f1ruBGHqkh6FabCdzR8Ns9NlzZcK7wzpuzG4roIoo2iffrMn
	bzuwzd6I4gqWiPbvXxdU4YxSHZkhlQMJu3wNMVK7JVPiYVHhGGGhlARao0Ul2xRvqcPlpXWnmCP
	w7JTNcojUHttAVwynYg==
X-Received: by 2002:a05:6214:2b0b:b0:707:1b36:28b0 with SMTP id 6a1803df08f44-709b07d721fmr45628406d6.5.1754901610740;
        Mon, 11 Aug 2025 01:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmqi4GHf2A7H36MKIKZoZhHH6tD7LdfZ+CPYZTKbI125W7w1bLdBwTOiUmiKDMJ/XmSBxNuw==
X-Received: by 2002:a05:6214:2b0b:b0:707:1b36:28b0 with SMTP id 6a1803df08f44-709b07d721fmr45628116d6.5.1754901610242;
        Mon, 11 Aug 2025 01:40:10 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15a66sm18447502a12.16.2025.08.11.01.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:40:09 -0700 (PDT)
Message-ID: <d9357f4a-6f26-4570-bcb5-62fe39c78a70@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 10:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] drm/msm/a6xx: Fix PDC sleep sequence
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-5-9347aa5bcbd6@oss.qualcomm.com>
 <937197e9-09dd-4f3c-bdb4-4001f5217c07@oss.qualcomm.com>
 <ba1d97d0-3420-4cca-8823-4d27cbe7bae6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ba1d97d0-3420-4cca-8823-4d27cbe7bae6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5R4BSBluVSKrRamHPXi2hOjB919mh8ZR
X-Authority-Analysis: v=2.4 cv=RunFLDmK c=1 sm=1 tr=0 ts=6899ac6b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qoSIoJJoY18thYJL65kA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 5R4BSBluVSKrRamHPXi2hOjB919mh8ZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxOCBTYWx0ZWRfX+xn39oIMApFp
 KRvHqmcwzHrt94JEcxARnGeXzB5WXQAeuT9Bg5+4yqgfRqZeAJm4r4Ff5eSfIHrLwCCDg0ETJzc
 QG1EzP46kImwMFs6dYadOL1BCEJiNl+B0OZJvM2I2EaQEyAhdY27gLcTotuolTXq44quR4M2Xu9
 KYS8MqD4MoZtIXJK62gIUgXa8VL4gf6rjOEr7i2QqeAFlj53mt0CkeFWMM9dQ3ZhY+6atjPHCbG
 HcV6qKecFOql4uhfk5hXC1N1rLqu305rxSI74wzFcotMHL8Gjrr46p8T/mr8SNusDw61qKUr73W
 ELQRuHshxHSxnImIBVMrSy9TJ9bJ+LkzWCBQJJIwhwpsSONOc/uiR1TQwfpAUMMQJBDD+5+43Am
 FRRdvGbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090018

On 8/8/25 7:22 PM, Akhil P Oommen wrote:
> On 8/7/2025 7:21 PM, Konrad Dybcio wrote:
>> On 7/20/25 2:16 PM, Akhil P Oommen wrote:
>>> Since the PDC resides out of the GPU subsystem and cannot be reset in
>>> case it enters bad state, utmost care must be taken to trigger the PDC
>>> wake/sleep routines in the correct order.
>>>
>>> The PDC wake sequence can be exercised only after a PDC sleep sequence.
>>> Additionally, GMU firmware should initialize a few registers before the
>>> KMD can trigger a PDC sleep sequence. So PDC sleep can't be done if the
>>> GMU firmware has not initialized. Track these dependencies using a new
>>> status variable and trigger PDC sleep/wake sequences appropriately.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>
>> FWIW some time ago I made this patch, which tackles a similar issue,
>> perhaps it's a good idea to merge both:
>>
>> From 7d6441fc6ec5ee7fe723e1ad86d11fdd17bee922 Mon Sep 17 00:00:00 2001
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Date: Thu, 20 Feb 2025 10:28:51 +0100
>> Subject: [PATCH] drm/msm/adreno: Delay the Adreno RPMh startup to HFI init
>>
>> There's no use in trying to power up the GX logic before we're almost
>> ready to fire up the GPU. In fact, with A8xx the PDC and RSC uCode are
>> loaded by the GMU firmware, so we *must* wait for the GMU to fully
>> initialize before trying to do so.
>>
> 
> iirc, this wake up sequence should be done before fw start. That aligns
> with downstream sequence order too.

FWIW techpack/graphics adreno_gen7_gmu.c @ gfx-kernel.lnx.15.0.r3-rel
adb0a9da173e ("kgsl: rgmu: corrected pm suspend flag check on resume")

// load gmu fw, enable clocks, irq, set up chipid etc.
[...]

// unmask CM3_SYSRESET
ret = gen7_gmu_device_start(adreno_dev);
if (ret)
        goto err;

if (!test_bit(GMU_PRIV_PDC_RSC_LOADED, &gmu->flags)) {
	// set PDC_GPU_ENABLE_PDC & seq_start_addr
        ret = gen7_load_pdc_ucode(adreno_dev);
        if (ret)
                goto err;

	// disable hwcg, sleep/wake handshake setup, pdc ucode
        gen7_load_rsc_ucode(adreno_dev);
        set_bit(GMU_PRIV_PDC_RSC_LOADED, &gmu->flags);
}

// set HFI_CTRL_INIT
ret = gen7_gmu_hfi_start(adreno_dev);
if (ret)
        goto err;

// continue booting the gpus, send out feature messages

on a830, the patch is observably necessary (gmu doesn't start otherwise)

Konrad

