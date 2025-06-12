Return-Path: <linux-kernel+bounces-684214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F4AD77BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E013188B683
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6E929A30A;
	Thu, 12 Jun 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lLs11Kyp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93429AB16
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744546; cv=none; b=t0MOgu+y77PWZc7TFwuNKKQbL0/syh2Tq1tNAg2WYWQ7CvH6iyoVFw+jT+bUIPAtv6TKINVXoXWLsBiKG/do0aLI7eyWvVf4Kfv86C41+nVErmhaSuPn7y/KfPp0Qcsi4Sg71cof9ZzXSUbvjRjNjWgFuR/h3W2uaT7yoG8e+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744546; c=relaxed/simple;
	bh=PGehsHoizkrd8R5cCu2NLJQi4bgOrkQgwqSIon4JV4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGdk4a60Yy9FJAqHJPU9j2ZjAobW5fsmMxZfzO93l1EYp2pO/MzBk3eZHZqCVQwqUiBhNxnnT2ilAb6gPzt97fXilGFr9yIQ5G9UrU2Th8wp3jJ7CjBjcG8R/LJFyJPg1AdvjIC2A30oCiV+OsIHZVP5caFR7DQguOXKXBVwK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lLs11Kyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CCe1m0023383
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 16:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VMDdf245hQfcWfFSlTgjzttwvhnXQd+4tGEplrSaiyA=; b=lLs11KypUAw8c5gW
	JPQNXkDa2/gTpLBVtGiw+1cDYJGuHyT91EwB42YmTpJJ2n4SKoCzKVZuzKY+L5Hk
	2QLJS/jnxTn2PZEAxYRny9WwKCKcQZmuSPjo8LyGm1OVgquAnRHcF0mpi4RhrZQk
	wa0SlIVXvN7pMSafHbhFvFQ3T7Fr+DTgBxcFSRucLycNxSCeUpcT4cSH2hbK9VKG
	HnQaLVbkHsH/pHfxD9ZFzeBk5umSLj2Mxs+e8lcWWSNsgzIOA5RlnFlny0Cxb5ZV
	E2+POJ14v2ihNOJIFFnM/M5TKban3dOop97hkeN45GC+zT93xn4iV16AYl3HqSbX
	qGNYkA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477y3grm1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 16:09:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d21080c26fso28298285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 09:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744538; x=1750349338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMDdf245hQfcWfFSlTgjzttwvhnXQd+4tGEplrSaiyA=;
        b=hAwkMoUXtb0MyZc0ne9a9U+Uc46jQEOBNteAptsiqBo0WN+1u5Ns52gEMIoRDEyL7I
         5I5VuDVFxxNeyQQfvNulNMV7QFiuFLeteMIZslYJl2CQs72hChpP1h5hnbk0KuEgmKlZ
         lxa6pHlmm0bVpe6ul8PHySJ3l6LQ8IXLcCN9fFYTq/yCdz6yDof3UV+mS2jnrHymu+Q9
         tGm/fXBNRlIgpBMoKhQL5/Zde+QDchOxxAzQWpLI9gsLVPNB+8D8stCvopfCRl4ODwmD
         y9lmwNP3KGgLrzeFO+KIBGUr00lxZheHjL3nbsmqNTju4RPihTFdcEDFO+tAxTU7+qFZ
         X1zw==
X-Forwarded-Encrypted: i=1; AJvYcCXa57Zx99wAwmGTra0fgMgDO2KIlxMijeOOXCm6mZ41xAvhkLtdh8xjU9mJcAjeEOyK+I9o7CMYhCFwFN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlHhwEaLC5Q/yx/LeEetQSIUYio21rhOJAxmh7IbQV7rSQsiB
	hb8AxgqtNACV81FqPaXmgT06x9h58JDDM5hnoro/lAXp/odXOisF6BdnrsY6pHuDWEQ+4qxbAkS
	hCDpELv3Evcz20TcKoCSnemv9XR225CB5amqirHt27/B2RPfCh060VFh9TSXB6X+aF3YW6bq4rZ
	Y=
X-Gm-Gg: ASbGncsjCi8G8aHxAz+3suNk2vcV7s2BkUkiw0ml3ky9BRU5BXc907nh9gb9/mCdBLH
	9e4QloqrlfXQ+gp8zBgdiuYr74HthycNC0nT8u4ssC9wucH7zUHKVXkif+PYpYzsKJ1g7NdEFmR
	jzbHVGtqDpMSUj6/9htc0sZ0kMmz8cvsaEVIYRT4G8vbZNL4tEMJFM5lATYGeRHVswSxZdEvGwd
	qbkubA4sf6+VgDRKX8RNHO7hHqHwLsG9kY5vXvbCKodL4iJ83ysCX8C8c1mtBuBQEL7wrj6MCme
	89dU68I3EcNNfB7aGUdSow9EGKxXMbBHC7BRqaJHuW8ATMffXGdscIZprPy/WOWG0HcOlSTVMZ1
	Q7BI=
X-Received: by 2002:a05:6214:c29:b0:6fa:fcb0:b899 with SMTP id 6a1803df08f44-6fb2c32ab8emr39535216d6.4.1749744537748;
        Thu, 12 Jun 2025 09:08:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+D5X1wryQh51o/X5l6y2rdDrAfTEHWP7abeXOFfZNhoERX71xp6+QeRZLtXPBG3zlw4YXTg==
X-Received: by 2002:a05:6214:c29:b0:6fa:fcb0:b899 with SMTP id 6a1803df08f44-6fb2c32ab8emr39535106d6.4.1749744537267;
        Thu, 12 Jun 2025 09:08:57 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadb22a06sm156601366b.93.2025.06.12.09.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 09:08:56 -0700 (PDT)
Message-ID: <1bf920c8-245b-40c3-bce1-ec5194b30fd9@oss.qualcomm.com>
Date: Thu, 12 Jun 2025 18:08:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/msm/adreno: Check for recognized GPU before
 bind
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20250609182439.28432-1-robin.clark@oss.qualcomm.com>
 <20250609182439.28432-4-robin.clark@oss.qualcomm.com>
 <DAKOKYU9O323.M7OSA1CFHQWX@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DAKOKYU9O323.M7OSA1CFHQWX@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: hC3er6TdZZbliT9OtF5vNPLmygAHCukR
X-Proofpoint-ORIG-GUID: hC3er6TdZZbliT9OtF5vNPLmygAHCukR
X-Authority-Analysis: v=2.4 cv=DPqP4zNb c=1 sm=1 tr=0 ts=684afb9c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=4MAclHcQAAAA:8
 a=wlZFfpuQTLNucttZ8HoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=6vtlOZhwcO7ZS_iRoh4Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEyMyBTYWx0ZWRfXyRN0y93z7kxN
 s/+457eAon4BvsTVQvzQ7fniUNQhdh/c4Ysql6I8hz5a3Ddb6bEqkKjWsX+WX35UL9QxrSvmycI
 k8PjJK0AURRT7MOB9nf/uc8NxyzGNTbLi8x43vD2v3SdNRxAOzKFhujOjNbV2p1PLrdZCyo0Fmf
 gS92cBWtOXLSu/rC3wQuhlTql36wsZBvjADxXHtijvy/4KBXXa5qkb9PytZjHXXv97PXEWSwAGI
 pJu9cBeZ1dhBEHbrndHC2/IibGcL1YFuMAL6EbiDbgsM/gShzi4mGIo4LXFCskJis5ROEPy5WB9
 c9YeK4EFTg14RZIoRZ7WufFW9Y0i3axTEE/Qjw7a0Wmoad+HaHBkeOMf+kBpP/s/HpLVbmuqJBM
 DwzVzuMFNX1c2/5mghsJ5G+CeTvlrxx4vfyH8l3JFgNgjIbCOMxPfLRd9qgeOZhMXIMw9wLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120123

On 6/12/25 6:04 PM, Alexey Klimov wrote:
> On Mon Jun 9, 2025 at 7:24 PM BST, Rob Clark wrote:
>> If we have a newer dtb than kernel, we could end up in a situation whe=
re
>> the GPU device is present in the dtb, but not in the drivers device
>> table.  We don't want this to prevent the display from probing.  So
>> check that we recognize the GPU before adding the GPU component.
>>
>> v2: use %pOF
>>
>> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 29 ++++++++++++++++++---=
-
>>  drivers/gpu/drm/msm/msm_drv.c              |  2 +-
>>  drivers/gpu/drm/msm/msm_gpu.h              |  1 +
>>  3 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/=
drm/msm/adreno/adreno_device.c
>> index 778e6ae7f137..0d12454b1f2e 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -178,6 +178,26 @@ static int find_chipid(struct device_node *node, =
uint32_t *chipid)
>>  	return 0;
>>  }
>> =20
>> +bool adreno_has_gpu(struct device_node *node)
>> +{
>> +	const struct adreno_info *info;
>> +	uint32_t chip_id;
>> +	int ret;
>> +
>> +	ret =3D find_chipid(node, &chip_id);
>> +	if (ret)
>> +		return false;
>> +
>> +	info =3D adreno_info(chip_id);
>> +	if (!info) {
>> +		pr_warn("%pOF: Unknown GPU revision: %"ADRENO_CHIPID_FMT"\n",
>> +			node, ADRENO_CHIPID_ARGS(chip_id));
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static int adreno_bind(struct device *dev, struct device *master, voi=
d *data)
>>  {
>>  	static struct adreno_platform_config config =3D {};
>> @@ -188,18 +208,17 @@ static int adreno_bind(struct device *dev, struc=
t device *master, void *data)
>>  	int ret;
>> =20
>>  	ret =3D find_chipid(dev->of_node, &config.chip_id);
>> -	if (ret)
>> +	/* We shouldn't have gotten this far if we can't parse the chip_id *=
/
>> +	if (WARN_ON(ret))
>>  		return ret;
>=20
> I just hit this with linux-next on qrb2210 RB1 [1].
>=20
> Is it expected an warning now or do we miss some device tree updates on=

> linux-next for RB1?
>=20
> I don't recall seeing such warnings previously.
>=20
> Thanks,
> Alexey
>=20
> [1]:
>=20
>  msm_dpu 5e01000.display-controller: bound 5e94000.dsi (ops dsi_ops [ms=
m])
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 242 at drivers/gpu/drm/msm/adreno/adreno_device.c=
:224 adreno_bind+0x90/0x120 [msm]
>  Modules linked in: q6asm_dai q6routing q6afe_dai q6adm q6asm q6afe_clo=
cks snd_q6dsp_common q6afe q6core apr pdr_interface qrtr_smd qcom_pd_mapp=
er qcom_pdr_msg mcp251xfd ath10k_snoc snd_soc_wsa881x_i2c snd_soc_wsa881x=
_common can_dev lontium_lt9611uxc(+) ath10k_core ath mac80211 hci_uart bt=
qca btbcm libarc4 msm snd_soc_sm8250 qrtr bluetooth drm_exec snd_soc_qcom=
_sdw qcom_q6v5_pas llcc_qcom snd_soc_qcom_common lmh qcom_wdt ocmem cfg80=
211 ecdh_generic qcom_pil_info pinctrl_sm6115_lpass_lpi gpu_sched ecc drm=
_display_helper rfkill qcom_q6v5 pinctrl_lpass_lpi qcom_sysmon pwrseq_cor=
e lpasscc_sm6115 dispcc_qcm2290 qcom_common snd_soc_lpass_va_macro cec sn=
d_soc_lpass_rx_macro drm_dp_aux_bus snd_soc_lpass_tx_macro qcom_glink_sme=
m gpucc_qcm2290 snd_soc_pm4125 mdt_loader snd_soc_lpass_macro_common qmi_=
helpers snd_soc_pm4125_sdw soundwire_qcom regmap_sdw slimbus qcom_pmic_tc=
pm qcom_usb_vbus_regulator drm_client_lib tcpm rtc_pm8xxx snd_soc_wcd_mbh=
c aux_hpd_bridge qcom_pon qcrypto soundwire_bus sha256 qcom_stats gpi
>   spi_geni_qcom i2c_qcom_geni rpmsg_ctrl libsha256_generic libsha256 rp=
msg_char qcom_rng sha256_arm64 authenc icc_bwmon phy_qcom_qmp_usbc libdes=
 typec phy_qcom_qusb2 display_connector i2c_gpio rmtfs_mem drm_kms_helper=
 socinfo fuse drm backlight dm_mod ip_tables x_tables ipv6
>  CPU: 0 UID: 0 PID: 242 Comm: (udev-worker) Not tainted 6.16.0-rc1-next=
-20250612-00025-g0ce0d3974333-dirty #2 PREEMPT=20
>  Hardware name: Qualcomm Technologies, Inc. Robotics RB1 (DT)
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : adreno_bind+0x90/0x120 [msm]
>  lr : adreno_bind+0x50/0x120 [msm]
>  sp : ffff8000813f3580
>  x29: ffff8000813f3580 x28: ffff000008ae8800 x27: ffff000007c63700
>  x26: ffffca4a2814b860 x25: ffff000008b26880 x24: ffffca4a24922000
>  x23: ffffca4a249229d8 x22: ffff000009838800 x21: ffff000008b26880
>  x20: ffff000002ce4410 x19: ffffca4a2495a710 x18: 0000000000000006
>  x17: 6f5f697364207370 x16: 6f28206973642e30 x15: 0720072007200720
>  x14: 0000000000000000 x13: 0000000000000000 x12: 0101010101010101
>  x11: 7f7f7f7f7f7f7f7f x10: ffffca4a2866e1b2 x9 : 0000000000000002
>  x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff2f383131
>  x5 : ffff00007fc1b968 x4 : 0000000000000000 x3 : 000000000000001e
>  x2 : 0000000000000001 x1 : 0000000007000200 x0 : ffffca4a2495a710
>  Call trace:
>   adreno_bind+0x90/0x120 [msm] (P)
>   component_bind_all+0x100/0x23c
>   msm_drm_bind+0x148/0x3e0 [msm]
>   try_to_bring_up_aggregate_device+0x16c/0x1e0
>   __component_add+0xa4/0x174
>   component_add+0x14/0x20
>   dsi_dev_attach+0x20/0x34 [msm]
>   dsi_host_attach+0x58/0x98 [msm]
>   devm_mipi_dsi_attach+0x34/0x90
>   lt9611uxc_attach_dsi.isra.0+0x94/0x124 [lontium_lt9611uxc]
>   lt9611uxc_probe+0x568/0x604 [lontium_lt9611uxc]
>   i2c_device_probe+0x158/0x32c
>   really_probe+0xbc/0x2b4
>   __driver_probe_device+0x78/0x120
>   driver_probe_device+0x3c/0x154
>   __driver_attach+0x90/0x1a0
>   bus_for_each_dev+0x68/0xb8
>   driver_attach+0x24/0x30
>   bus_add_driver+0xe4/0x208
>   driver_register+0x68/0x124
>   i2c_register_driver+0x48/0xcc
>   lt9611uxc_driver_init+0x20/0x1000 [lontium_lt9611uxc]
>   do_one_initcall+0x60/0x1d4
>   do_init_module+0x54/0x23c
>   load_module+0x1730/0x1cc0
>   init_module_from_file+0x74/0xa0
>   __arm64_sys_finit_module+0x130/0x2f8
>   invoke_syscall+0x48/0x104
>   el0_svc_common.constprop.0+0xc0/0xe0
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x2c/0x80
>   el0t_64_sync_handler+0x10c/0x138
>   el0t_64_sync+0x198/0x19c
>  ---[ end trace 0000000000000000 ]---
>  adreno 5900000.gpu: supply vdd not found, using dummy regulator
>  adreno 5900000.gpu: supply vddcx not found, using dummy regulator
>  msm_dpu 5e01000.display-controller: bound 5900000.gpu (ops a3xx_ops [m=
sm])
>  [drm:dpu_kms_hw_init:1173] dpu hardware revision:0x60050000
>  dummy 1-0045: No cache used with register defaults set!
>  [drm] Initialized msm 1.12.0 for 5e01000.display-controller on minor 0=

>  msm_dpu 5e01000.display-controller: [drm:adreno_request_fw [msm]] load=
ed qcom/a702_sqe.fw from new location

Looks like we should be doing this instead

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm=
/msm/adreno/adreno_device.c
index 5e7307567239..16e7ac444efd 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -221,7 +221,7 @@ static int adreno_bind(struct device *dev, struct dev=
ice *master, void *data)
=20
        info =3D adreno_info(config.chip_id);
        /* We shouldn't have gotten this far if we don't recognize the GP=
U: */
-       if (!WARN_ON(info))
+       if (WARN_ON(!info))
                return -ENXIO;
=20
        config.info =3D info;


Konrad

