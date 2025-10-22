Return-Path: <linux-kernel+bounces-864630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BFABFB397
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1391A01358
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF116270ED9;
	Wed, 22 Oct 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoovsAjg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65D17332C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126743; cv=none; b=gzbIi9/BPtD/X2AV69fkAAxeWghTBi9MOyIcbvzTQM1HRnhuNTLIgzwS1RMuV3oRRkZb+uRudhQC2N8eIJA/7v3CbT+8CQrIpMqNkrhg4MAS++aTZAV8lCoNsknv23mE69rukOIT7mt3q0FDWRt3UQ2pGZeVqiUAcXUlLSVpTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126743; c=relaxed/simple;
	bh=HotdHt9tSRG/l9u8l0jrHhHMNryAyiv5DnclJcYD9DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxBK5Bt+WxLGruPHk69frhqMcSSPdMog5ql/VhQKdngt9A9YmAA0m3PZGpCVag5eeQZuPfqST8gKRNWuk7pccWpL4+7V7heOJrE1wluJvy4Gr2EV5sj9VWHNpL/gK3L4vG6xZQBnKUpT7/efemF5ncDu0ZdDaTUE2KkEkosV2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoovsAjg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7Z6ow012419
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gL1oSL5COCo33UPaZkHwdffpCD3r0s6TIvOc79+npqQ=; b=UoovsAjgB93b7px1
	kFp1U3H3nnIDdIxw1dFkJ9LdXGSVAtdC/M/s18sUscm3/VG0i+IV2CfyDqhx3qbA
	GscTW/JzsFz0Qmvg4igd4fklb/fIuSdlm/bRuwL/hXZg/ZbNevgc2KEZeoZEqDV6
	F8t1lHlFRXqA48saHAcv5b2zAnG6qFEM2/LIq5nCyVmPX0G6ini0bPDKEmFiDD6L
	52uAC4lrKZo27PfdpR5y6zybZ6o1St2My6m638sXX1T/ejBE1SU5q0hIXkKp7IYQ
	1JL0IFtNOSb6BYXXoXMZc76lXgWfRzgAJ42NCGfoVnohpeci9z7fvHV3FfOJbLi9
	gKGlbw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0j0pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:52:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a9ec4746so49429721cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126740; x=1761731540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gL1oSL5COCo33UPaZkHwdffpCD3r0s6TIvOc79+npqQ=;
        b=jGGSqkAhG8bFl6rTbCbBgZZr9iQGLb5ab4wAtTxKiMqlVqo0W7JVaKh9LXyn59MhV/
         cVz4LGx4UX8GTb5PGoTKBrvylI+ARacS8fZs80QuskpqI0uUGn+NFysdaF0bvgk62dlT
         UFcEdR6YJyJ6igYw9urOBsGhUHWHBAQ6WjYfLoJZgojxJON1D5OxIGSTrxIKO4PqPnIi
         2NwSViWjm17nD//3GQG9LqPho8LEmuHmBbZu/gf0T+mtzz74VFPFxyPWQZ+mMAQcTlof
         VdrZM7YR4onoSS1T5K6PFloPNwvm9GCBnNsF179/TQwW8o/KphsRR/BlfTfPyS01NIbT
         JyOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdI8ryELeJBSPDUGABBKzYPbKAwa1fVvgyXNzf0qG+5LHeIk5HPLJ5JbqeShuOAx9xf3M8uYm5ttFW6ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xE0aBgwAhuneyBEW+xtVQYAzV38vd6qHJASvCfYz5NSvE4Ku
	5Ase0Dy1gzga8P350M27nKeCnBBRz/2O32MH+JhyX74sUb+FQEyorvEXUASXrtJSyerNQJQYQPR
	TI0qjiy6269t7EKYIZqS3S9UUJz1Hakn6b2vxoanyGQTX4oPUGBY1+c7HfqPO/VALSHE=
X-Gm-Gg: ASbGncv9XNbnJM7PSWEKEibb7+moVi2RnyWHSokbbySQgi9wFGSvqDV/bJBGM//GbbG
	py8zfnDbAjA9OflV2M+N4mZHrv+IY6nOlKfLSE6roY4Z4p95HhBfPmEyQuQYSnee9yLmYej/F3Y
	OrGwFvccC3S1CzHawuhyXvrtI8rL7DTTrSXiZraUPDm21Nf1kzDSS8mJPF0cV6VAUI5VXSb35lQ
	cJRN5qj81GoZyX8ABAa5yNlg0yusUXsygZ7Ib3CoIiAH8OMvjrVp7AgYbH6vo9Y4JcetNgLRYmp
	CP0Npl+aINq2053k0yBedWm3EV9XkfnaOuHv1k6EKT1Pmh+/V0Km20JzbRtP73Y9xTGwyseDQj+
	4T/rBvtOeA0JWS7V/QmMUuGc2bA==
X-Received: by 2002:a05:622a:138b:b0:4e6:f8b8:50f7 with SMTP id d75a77b69052e-4e89d33642bmr274377771cf.44.1761126740250;
        Wed, 22 Oct 2025 02:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD6+cZ2h2uTsJmpX7ZrNcDvQJ02RS4D6pmlQSOL6VJLe0LLRCucdWLVJ34ffIHd5GjyVi6dw==
X-Received: by 2002:a05:622a:138b:b0:4e6:f8b8:50f7 with SMTP id d75a77b69052e-4e89d33642bmr274377521cf.44.1761126739754;
        Wed, 22 Oct 2025 02:52:19 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm24523076f8f.5.2025.10.22.02.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:52:19 -0700 (PDT)
Message-ID: <76567559-4cac-467f-9740-e8a539a445f7@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 10:52:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: qcom: sdw: fix memory leak
To: Steev Klimaszewski <threeway@gmail.com>
Cc: Stable@vger.kernel.org, alexey.klimov@linaro.org, broonie@kernel.org,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        perex@perex.cz, srini@kernel.org, tiwai@suse.com
References: <20251021104002.249745-2-srinivas.kandagatla@oss.qualcomm.com>
 <20251022003429.4445-1-threeway@gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251022003429.4445-1-threeway@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX8JSnQwSt6A0o
 cRrVth+zOjLVSBdasZhLFIzpsRsNsjNTxfQE8Y49R1gfrQv8O80sf50IFqtAyOuY3FpK0tdgMfG
 /TOnjm1VOqt85y81oFHfTZx4303UPYdq307n0BrpM/7otpisYPVxsV9fXoCx6+KRCQPvd7ADkRF
 e6RNtLmzLktJDxj4SvaSiHGkQIgebYPjrCoqMPGT18ypNOyWS7blu4mtLEGE2GE8JF1QDbjV+xq
 /df6oVf3FQqoMWdbGMyujRoniwjn6Nqa98gCUOOe2BsIu4SYZMmiGE6kO706tOIygT0jZmPmJWW
 oH0LeqQ6B4xZfDf5tvgOq3AmZ3vn9YzZkMm7sLOz/9PVAUk6iak7HxMlE0SQ4ye5iVGd62l60sZ
 sAjXDxuQYojXq+EX8wpgLMMFLKlC+A==
X-Proofpoint-ORIG-GUID: p_XU33pRWY4vfpsBUMeGIHd6Bw9GUqIV
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f8a955 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iO20W2wDcHnNQb4HqdoA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: p_XU33pRWY4vfpsBUMeGIHd6Bw9GUqIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On 10/22/25 1:34 AM, Steev Klimaszewski wrote:
> Hi Srini,
> 
> On the Thinkpad X13s, with this patchset applied, we end up seeing a NULL
> pointer dereference:
> 

Thanks Steev,
I think I know the issue, There was a silly typo in 3/4 patch.
Could you please try this change, I will send this in v3 anyway;


-------------------------->cut<------------------------
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 16bf09db29f5..6576b47a4c8c 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -31,6 +31,7 @@ static bool qcom_snd_is_sdw_dai(int id)
 	case RX_CODEC_DMA_RX_6:
 	case RX_CODEC_DMA_RX_7:
 	case SLIMBUS_0_RX...SLIMBUS_6_TX:
+		return true;
 	default:
 		break;
 	}

-------------------------->cut<------------------------

thanks,
Srini> Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000020
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010abfe000
> pgd=0000000000000000, p4d=0000000000000000
>  SMP
>  pdr_interface(E) crc8(E) phy_qcom_qmp_pcie(E) icc_osm_l3(E) gpio_sbu_mux(E) qcom_wdt(E) typec(E) qcom_pdr_msg(E) qmi_helpers(E) smp2p(E) rpmsg_core(E) fixed(E) gpio_keys(E) qnoc_sc8280xp(E) pwm_bl(E) smem(E) efivarfs(E)
> CPU: 5 UID: 111 PID: 1501 Comm: wireplumber Tainted: G            E       6.17.4 #2 PREEMPTLAZY
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS N3HET94W (1.66 ) 09/15/2025
> pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> pc : sdw_stream_add_slave+0x4c/0x440 [soundwire_bus]
> lr : sdw_stream_add_slave+0x4c/0x440 [soundwire_bus]
> sp : ffff80008bc2b250
> x29: ffff80008bc2b250 x28: ffff0000a56b2f88 x27: 0000000000000000
> x26: 0000000000000000 x25: ffff0000a301b000 x24: 0000000000000000
> x23: ffff0000e8ce0280 x22: 0000000000000000 x21: 0000000000000000
> x20: ffff80008bc2b300 x19: ffff0000a305a880 x18: 0000000000000000
> x17: 0000000000000000 x16: ffffb9859eb15c48 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffb985391c0614
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff0000a56b2fd0
> x5 : ffff0000a56b2f80 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : ffff0000eb005000 x1 : 0000000000000000 x0 : ffff00011de2c890
> Call trace:
> (P)
>  wcd938x_sdw_hw_params+0xa8/0x200 [snd_soc_wcd938x_sdw]
>  wcd938x_codec_hw_params+0x48/0x88 [snd_soc_wcd938x]
>  snd_soc_dai_hw_params+0x44/0x90 [snd_soc_core]
>  __soc_pcm_hw_params+0x230/0x620 [snd_soc_core]
>  dpcm_be_dai_hw_params+0x260/0x888 [snd_soc_core]
>  dpcm_fe_dai_hw_params+0xc4/0x3b0 [snd_soc_core]
>  snd_pcm_hw_params+0x180/0x468 [snd_pcm]
>  snd_pcm_common_ioctl+0xc00/0x18b8 [snd_pcm]
>  snd_pcm_ioctl+0x38/0x60 [snd_pcm]
>  __arm64_sys_ioctl+0xac/0x108
>  invoke_syscall.constprop.0+0x64/0xe8
>  el0_svc_common.constprop.0+0xc0/0xe8
>  do_el0_svc+0x24/0x38
>  el0_svc+0x3c/0x170
>  el0t_64_sync_handler+0xa0/0xf0
>  el0t_64_sync+0x198/0x1a0
> Code: f9418c00 b9006fe3 91004000 97ffe306 (f8420f43)
> ---[ end trace 0000000000000000 ]---
> 
> -- steev


