Return-Path: <linux-kernel+bounces-740675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B0B0D798
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990A4168ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31F2E1C50;
	Tue, 22 Jul 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="egWukgoF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D952E11B9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181810; cv=none; b=LraeN0HPBvV4QBm8Mk4MibjgCQHukp/1zu/xbA9EAvK32Y52/q8KwOr/Ro/DjMvqm3AK37iinMRnwcezuLRfznQVMAGN/8KaopvP4LKqqkFwLRTTusoEPUOIkKca34Jgsq0HdoDi2YkrQyfpRj9/KibofHzt48sOu+7wI7a2T/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181810; c=relaxed/simple;
	bh=VmcMpMv1o/xrcqGxrBQh966G5LBlrvi8MJ4jNjqHCfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tr4DYOY41QLxaG486rZX8SKoCQzJdu/SzC/MojWWlFXuKWtrhpNskqlhybuJ/58+S4p7C6I162uFBTcWSkqYfTbM/e7SJD7b0JfSIZJyl6As90lF5WNl9ZbSWmUfoKcPN2P2mkv6HIHuijqULLYOr1ecrlU43mW1nEgEPpIUdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=egWukgoF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M8rwGq006230
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g7qM0Z+wf2GStDuKTmGsX7zzLsTCMG5C7nE0l4CouW0=; b=egWukgoFgVppj7xX
	iusTxAI5opKABbqQShMnS5QxJtmiE+cepNnCJG8n2YZCxjiTmxuzHbV2/k7xZDRL
	1MOhybQeF1bz7jSSRCPPYVYaaljLZRLtAVUb6z6woTBBNCJ1vz07/9OIOvz5V3tD
	oP3MPTUmvqTYonFhCAlIs933VYDZMAD8dDcII/2xGcQASb+RjU92bBxrZGJLU2xi
	gTt+Dw2J4fTY21dneHK6uSbbelwU2xO7ken5tRtdqCIc7Pj4Ggdj7Zu008MrGKvR
	tC8zbEYL2jZwVORAXrWZBnv9RkQ3MiAei/GeG2E0CijURnhJpcOIMY3FsxdhwHWI
	t4Ar+Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q974e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:56:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235eefe6a8fso40975155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753181806; x=1753786606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7qM0Z+wf2GStDuKTmGsX7zzLsTCMG5C7nE0l4CouW0=;
        b=ZosCvjuGE88aoPWspC0OKDX4Wo1EBpysCDF2dZfeZG35SAHH62UQ7uxufXqiBoBenF
         HED7dvBqd60qWENNhsK4wUf+45/lyIrPy4fMCbInwUm2Q+NRS4fENf6FWM4KEvPfjzQz
         k/g/7FoRc0WmLLAh3EKCBKpcsgt5lv5xxXcqdoPvJ+kk7qO3cFA+QzxbgaGgQgTULnY7
         /YN2p5d7aUQCO1f8eG+jvTTLSmrq7twvi/eQO8EVisQ3e3LltjU5OkUEpZquqdmSAEbP
         hAlsgUK86He4KGhwiTYpgj5hNt9OBXu2apCjirGYLjCrN8cblsamYyb9MRx4eCS3cvU9
         gMjA==
X-Forwarded-Encrypted: i=1; AJvYcCWPia5dlGREoWQdNP/mYnQxQ9Ye7GSFKg/4Vx3VwieNHRjmjAPZngeR5tKm7c0JnBPdG54rI1AjGNl0UK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRg8E88o58citRmPx072pnvo6/979mBoMCYo8Vo/hKEf/ZHn0
	ok9N9QbR5Kp+MwldZb8eTkeYQeS0aVUyB4YcTWedTI5uHtiDnmwj/zQCJ2j4IHLAOsgc5pMRZqQ
	y8SJqW9fDJYavQEcuZlTK7j5pX+0v171orWj2nVwOXirwvF0kr5SeXrEs8C4b5EOukKw=
X-Gm-Gg: ASbGncsoAlU6HQa5NaEV4lyIegUCoINhyj/4454j9GyheYJNULTxiOm3iFIu2OVOEry
	+EGrcgDH0R5yhzjBUWohOXcEwuAMk6iFNtQqZgWlfeesnkAQYQdEdUoFyFX6La/QiBAlNPHkjnU
	0HfoDVCaoZDvMhW6+VnxWtm7bSKNfEV90dUHNJSWhcyzBmOLgOEy+Cxbo+nnJNXAQmkZzQVe1jX
	x0XXg0UCnDdKOuBMRP75Zy/yd6Qxtwt4ZqVErqi3P6XmKTvAMJoXW3xv3ZII1BNSlTMCbcRYxeu
	c6y2NDzixfcqPn4+EzlfaiDksPPIHRMcmhE3cgoQwEkS3x2t8TVqHA3QvOcYzuxCjIIfcvOvDG1
	B0e0=
X-Received: by 2002:a17:903:3d0d:b0:234:f4da:7eed with SMTP id d9443c01a7336-23e3b84f72emr252315485ad.44.1753181806153;
        Tue, 22 Jul 2025 03:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUt6A7hh/EP89XTAOzcg/lK9W717hw7dFv37fh4cCUg4RhbdxPMNKnk9K5jOdZTIMUErJkMw==
X-Received: by 2002:a17:903:3d0d:b0:234:f4da:7eed with SMTP id d9443c01a7336-23e3b84f72emr252315085ad.44.1753181805624;
        Tue, 22 Jul 2025 03:56:45 -0700 (PDT)
Received: from [10.219.49.237] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60e9b4sm74000165ad.56.2025.07.22.03.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:56:45 -0700 (PDT)
Message-ID: <d614d8e3-963d-4d34-9b15-1544c7a22cf0@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:26:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: codecs: wsa883x: Handle shared reset GPIO
 for WSA883x speakers
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
 <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_pkumpatl@quicinc.com, kernel@oss.qualcomm.com
References: <20250718104628.3732645-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250718104628.3732645-3-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250721-hairy-aardwolf-of-enterprise-bbc99f@kuoka>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <20250721-hairy-aardwolf-of-enterprise-bbc99f@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4OSBTYWx0ZWRfX3jCd14KDayNz
 OZscBC7wI7Db86GG1eOpe8y94kitv1FYTmYX1neNb/dovd0oEF2ZvfuIt03bfTyYR0OIn01G09R
 5mTDyFM2x7SPB0R9GEmutsQCzRqnwJmvtwjxqqc9RUM5dtl2qS50PhuJBTV9n437jrZo6Ln8BPi
 AhKpCwpSBHff7FjkmR+cQ+5lqqagtIMbJAJUOemK2LOCFj3/b9LCKz9+uF1++iXJsBnIoXiwP4j
 5himKtHBHeFBL+UeU7zhrqzDv4v61lC35g16F7GwV1Pe0TgfuhkVooPPZL3oS2sIKy/2DECRIAv
 /Lg6nkPHXNjh/L6X2ol5NoevXE7kXlRXwPJSaQ4hNi+BJ+KbR+j354exAUnHlQyxP/CXhduASQ+
 iQTVivXZ0PVTFgdXCIsyIHO9BGk23KZ481VRpY0gi8izwKFjy3wFrVXk0eSATBGAoQFJyIc+
X-Proofpoint-ORIG-GUID: BxpAm9-_8aCbCf2F_D6vIjP0PXdxSMxS
X-Proofpoint-GUID: BxpAm9-_8aCbCf2F_D6vIjP0PXdxSMxS
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687f6e6f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=i4jCgTYSAnVeQ-bZYmQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220089



On 7/21/2025 1:53 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 18, 2025 at 04:16:28PM +0530, Mohammad Rafi Shaik wrote:
>> On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
>> WSA8830/WSA8835 speakers share a common reset (shutdown) GPIO.
>> To handle such cases, use the reset controller framework along
>> with the "reset-gpio" driver.
>>
>> Register devm action to safely disable the regulator on device removal
>> to prevents a potential release warning from _regulator_put().
> 
> It is not possible to remove the device - suppress bind attrs. How did
> you trigger that?
> 
Ack,

I encountered the warning as regulator was being released unexpectedly,
triggering _regulator_put() warnings. While the device itself isn't 
removed, Registering the devm action ensures safe cleanup without 
triggering warnings.

Please check the below logs.

I could use some suggestions for this issue. please help with some 
suggestions how i can approve this design.

Thanks,
Rafi.
>>
>> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
>> ---
>>   sound/soc/codecs/wsa883x.c | 93 +++++++++++++++++++++++++++++---------
>>   1 file changed, 71 insertions(+), 22 deletions(-)
> 
> ...
> 
>>   static int wsa883x_probe(struct sdw_slave *pdev,
>>   			 const struct sdw_device_id *id)
>>   {
>> @@ -1566,13 +1615,18 @@ static int wsa883x_probe(struct sdw_slave *pdev,
>>   	if (ret)
>>   		return dev_err_probe(dev, ret, "Failed to enable vdd regulator\n");
>>   
>> -	wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
>> -						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
>> -	if (IS_ERR(wsa883x->sd_n)) {
>> -		ret = dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),
>> -				    "Shutdown Control GPIO not found\n");
>> -		goto err;
>> -	}
>> +	ret = wsa883x_get_reset(dev, wsa883x);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Register devm action to safely disable the regulator on device removal.
>> +	 * This prevents a potential release warning from _regulator_put().
>> +	 */
>> +	ret = devm_add_action_or_reset(dev, wsa883x_regulator_disable,
>> +				       wsa883x);
> 
> If removal is possible (but then explain in commit msg how), then this
> should be separate commit with fixes and cc-stable, because you are
> fixing actual bug - lack of regulator release on unbind.
> 
Ack,

The Reason to introduced this change in same patch,

without devm_add_action_or_reset(dev, wsa883x_regulator_disable, wsa883x);

if i try to enable ->devm_reset_control_get_optional_shared_deasserted()

seeing below crash logs.  _regulator_put() release warning.

logs
-----
[   10.679294][   T90] ------------[ cut here ]------------
[   10.684772][   T90] WARNING: CPU: 1 PID: 90 at 
/drivers/regulator/core.c:2450 _regulator_put+0x50/0x60
[   10.694344][   T90] Modules linked in: snd_soc_hdmi_codec 
phy_qcom_edp venus_dec venus_enc videobuf2_dma_contig rpmsg_ctrl 
qrtr_smd fastrpc rpmsg_char videobuf2_memops qcom_pd_mapper nb7vpq904m 
msm lontium_lt9611uxc ucsi_glink typec_ucsi pmic_glink_altmode 
qcom_battmgr aux_hpd_bridge ath11k_ahb ath11k hci_uart rtc_pm8xxx btqca 
coresight_stm bluetooth qcom_pon stm_core venus_core pwrseq_qcom_wcn 
drm_exec mac80211 ocmem v4l2_mem2mem gpu_sched videobuf2_v4l2 videodev 
nvmem_qcom_spmi_sdam qcom_spmi_adc_tm5 snd_soc_sc8280xp 
drm_display_helper qcom_vadc_common snd_soc_qcom_sdw coresight_tmc 
snd_soc_qcom_common videobuf2_common qcom_stats coresight_etm4x 
qcom_q6v5_pas phy_qcom_qmp_combo usb_f_qdss mc drm_dp_aux_bus 
ecdh_generic qcom_pil_info qcom_q6v5 ecc coresight_replicator aux_bridge 
coresight_csr qcom_sysmon coresight_funnel pwrseq_core gpi typec 
i2c_qcom_geni qcom_common coresight icc_bwmon llcc_qcom qcom_glink_smem 
qcrypto pinctrl_sc7280_lpass_lpi mdt_loader snd_soc_lpass_wsa_macro 
sha256_generic pinctrl_lpass_lpi
[   10.694524][   T90]  snd_soc_lpass_va_macro display_connector 
snd_soc_lpass_macro_common authenc drm_kms_helper libdes qrtr libarc4 
icc_osm_l3 qcom_rng pmic_glink cfg80211 rfkill drm fuse ipv6
[   10.804083][   T90] CPU: 1 UID: 0 PID: 90 Comm: kworker/u32:4 Not 
tainted 6.14.0 #1
[   10.811959][   T90] Hardware name: Qualcomm Technologies, Inc. 
Robotics RB3gen2 (DT)
[   10.819920][   T90] Workqueue: events_unbound deferred_probe_work_func
[   10.826643][   T90] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT 
-SSBS BTYPE=--)
[   10.834510][   T90] pc : _regulator_put+0x50/0x60
[   10.839362][   T90] lr : regulator_put+0x30/0x48
[   10.844118][   T90] sp : ffff8000809e3670
[   10.848244][   T90] x29: ffff8000809e3670 x28: 0000000000000000 x27: 
ffff70941a04a080
[   10.856300][   T90] x26: 0000000000000000 x25: ffffbfa860a9bee8 x24: 
ffffbfa860e79cb0
[   10.864354][   T90] x23: ffff709406e62640 x22: ffff709418668808 x21: 
ffff8000809e3710
[   10.872409][   T90] x20: ffff709415e81840 x19: ffffbfa86119b680 x18: 
00000000ffffffff
[   10.880462][   T90] x17: ffffbfa86013d058 x16: ffffbfa8601cbac4 x15: 
ffff709419a70b48
[   10.888517][   T90] x14: 0000000000000000 x13: ffff709400032b10 x12: 
0000000000000000
[   10.896573][   T90] x11: 0000000000000000 x10: ffffbfa85fdbcc60 x9 : 
ffffbfa85fdbc7e0
[   10.904627][   T90] x8 : ffff709418668ab0 x7 : ffff709418668ab0 x6 : 
ffff709418668ab0
[   10.912676][   T90] x5 : ffff709418668ab0 x4 : ffff709418668ab0 x3 : 
ffff709415e807c0
[   10.920727][   T90] x2 : ffff709406e62640 x1 : 0000000000000001 x0 : 
ffff709415e81840
[   10.928781][   T90] Call trace:
[   10.932024][   T90]  _regulator_put+0x50/0x60 (P)
[   10.936877][   T90]  regulator_put+0x30/0x48
-----------

Thanks & Regards,
Rafi.

> Best regards,
> Krzysztof
> 


