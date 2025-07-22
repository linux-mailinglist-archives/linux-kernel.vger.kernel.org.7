Return-Path: <linux-kernel+bounces-740691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93534B0D7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724383A78B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A7228C002;
	Tue, 22 Jul 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VN1GIgCe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB212E4255
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182703; cv=none; b=kmlUCY04OyfRuN6P8OaDfrR2ZUtfo6A6Kv0WJ/WEI8xiHUA+9SAeXz8TPITZSYv4Ir/LDBZPGJtNyHSv8z2N3j+QYGIzfc/h5jcFXkWEvp6mLgremqsaLTeisiGj0btb106AcLBUGpjpZT7xTZf/2Rvje/QCFNggqutabOdhfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182703; c=relaxed/simple;
	bh=7b1qh/dSogZFvxoYSJwQTetAmceccBgx4t1nS6JueJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYjGxKPN9sx0hRVDWQIkXvqirJYNVtQDT66o7TeeTSlKeBzAsKCBWSq/HgR9xFNR8u++YDHVzHJwu0Rwt0PWWBYQGceFXutwPoElt2o6On8eAX7121nTCYNCtQdtMAEJ/z/VjZaCq7J7ER/M5sQtlDdfa4vSYtf1nbsc8lFTl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VN1GIgCe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M8PwoE012733
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oi53JRV3Vx8pK1+2DIKrj/tvup2GlNnWQRcDHigNxvk=; b=VN1GIgCeEgOMNW7R
	rl90UYWSjqYLzpZJst5i/oNnzS2+YJm4hxij3KFwC1rs4uVnJ2kvevDtylePTc3t
	2MibDyIbck2LKYEo38AHuqEicubnowr7Rtb1ajOD72iXX4uUZMolughWTplSTMe7
	rxVhv7dJqD8ZcXi7gKh4u53Y9Nn7jewsmZq9rlJoh4A2DGu/dTFSYYb/RljPf34Z
	xqH3SNp78F/IZzhjF0MQn/STwypElO8PQqE6M41mNKUP8YWgpnvHL2jibxfBer7E
	WKgOF7UrB13XfAohrGiIXAKdtZzkuMi7ykuvNHnnWlphqgnpS1/JnbSMRGYxBD2X
	s8QzWg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6kg07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:11:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-756a4884dfcso5211484b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182699; x=1753787499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi53JRV3Vx8pK1+2DIKrj/tvup2GlNnWQRcDHigNxvk=;
        b=YY9II1Y3z0HWD/n/Y5juBDba4aKi2O7Z85Y+hq55d5wvEm1+WQPpDixcQjBgqK+xj+
         ussvSd2yhy7KsGFygnaTUXU1SLRsi0HK+zn4i5LBToYNBTvLiOZudTeaQswJKS2hwrOt
         QF+RiVo/oekK0edx7qoVlCivXkCGNOb0YhK/pAzR1thL7NYgE+M93nGS2iH5YBIF03rc
         2A+dH9G++vgBxO0HvnC0OH14Y+MZIvrpoldYgx0PRXAlZ7et6tHAIoCJEdmHkCCdiObm
         6iScIxf/4nZS0AIirC1l0lfmzYFWnon4k+j/Ccv12bTRs/Uc7v2Wd4aIV093IHHG7xy2
         fqww==
X-Forwarded-Encrypted: i=1; AJvYcCXsh9HfFSv6tdCtCD+W086xfJBnTEn8SZPF4XoZS7CQiM4aLecxknzdRiUcPuK6ITvzobXW8T6sxJo11wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvF+mupg0rcWqSeBkpVlTOiaE9N6iRNbWJgOBpvh+bmYnyUEZ
	aSn0Xs1WEtTyZw6ilHHXt3ryr5XRYG/dCYQqvHPhCBTeF4mCJyoG58RIS0wmQkov447U+akj3Nq
	cmP4irIDIZPtC80cwT+PD3hTpvYFChls6+95Y/RBqEki/xL6/RjLOaozSwFy+MeCoC9w=
X-Gm-Gg: ASbGncux01mWoN3TN2GDMZK2CgzawwnZznvLOoWTT+KDnqir+C4L9toYxyuW5VhIh4e
	Q+163S+wdHud97USUIZeJ+sqOlx+9ge1k50+lYG8J8ktdYtqiKaLu6Jp8kyITRx35UpeLcNvXUR
	W4Z5JKw1A2CDzuBmtGCSsbqWp5j4PEgU65K09pvqPDmpyCVjyOLtYKV+A6x9Gstp3iSilv+qZUk
	M3TyG60jfvbC+4DT3TP5yrnIWllYzws33jfzV058l97n8ej+KYMYlQ3b7OnvBZuXXBa+pDSypqi
	iGBzp7vnkSakLx6kTqFpj6ut0ln3ghj5kbfUKDhaVW8djj1FEw56CkY63sVOtz7ebRIkDg47O7i
	Trc0=
X-Received: by 2002:a05:6a21:e85:b0:21f:ee3f:8ad5 with SMTP id adf61e73a8af0-23812c48c36mr39345038637.20.1753182699040;
        Tue, 22 Jul 2025 04:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzvWUcEPNXtNIE/BBj0biFMIcwHJBPX8MO6tw2I2eYccmF/S3eY5ug3RzJMiSa80xvG6s1rw==
X-Received: by 2002:a05:6a21:e85:b0:21f:ee3f:8ad5 with SMTP id adf61e73a8af0-23812c48c36mr39344983637.20.1753182698520;
        Tue, 22 Jul 2025 04:11:38 -0700 (PDT)
Received: from [10.219.49.237] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678d9bsm7465223b3a.109.2025.07.22.04.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:11:38 -0700 (PDT)
Message-ID: <8d488066-6f29-4ef8-8f09-26328b5213f1@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:41:31 +0530
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
 <d614d8e3-963d-4d34-9b15-1544c7a22cf0@oss.qualcomm.com>
 <a006f099-578f-45aa-b165-64e28b8f930e@kernel.org>
Content-Language: en-US
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
In-Reply-To: <a006f099-578f-45aa-b165-64e28b8f930e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687f71ec cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yfeqtnweelXl-nV2tnwA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: p7IkPV1wIbS2tlS7U_0LzzM00YTa6Vtm
X-Proofpoint-GUID: p7IkPV1wIbS2tlS7U_0LzzM00YTa6Vtm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MSBTYWx0ZWRfXxG9TpZ1ZiF6x
 dWshpexNtvlEw5mLStilEq3qkiCCEJIqUfOYQ9DK/eOTMQR9xD+pOg3VOo88AFqAEfv/oxQftis
 95CpFfUQQgHEjhOxDvRxr+4t4lu3obyswCrI52HfQpbnLAPCDOsHrUoFsOPLKvgfYesiRcWGP3g
 HDN5yiysFKtH7qaL/6gDk7hDz7fDEmKBE0UoI/fXUKLKi/Q74EF3oA1CHjNAzTJHzLTS6kt0cC7
 FLK5p/MIvdX61Cd/i5HYzjKg6TswHNUAKLvq78AL0bN5Gj7Oq8aoSVzSKpe+5YhJK2f2dC67E3j
 AT+SJ8NGQucztdYAjR/UP7GuFDLepotQAOhGk2UMz5sbWJsmSqaBRbxcnwa32LVQwkq1K1cWMAt
 ecAecHQJpFnVolxt7jTUY16/fpryvVXoPfdWSzXDSZn8W3g9HKDj19xm+sSOPLL38WGP++9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220091



On 7/22/2025 4:36 PM, Krzysztof Kozlowski wrote:
> On 22/07/2025 12:56, Mohammad Rafi Shaik wrote:
>>
>>
>> On 7/21/2025 1:53 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Jul 18, 2025 at 04:16:28PM +0530, Mohammad Rafi Shaik wrote:
>>>> On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
>>>> WSA8830/WSA8835 speakers share a common reset (shutdown) GPIO.
>>>> To handle such cases, use the reset controller framework along
>>>> with the "reset-gpio" driver.
>>>>
>>>> Register devm action to safely disable the regulator on device removal
>>>> to prevents a potential release warning from _regulator_put().
>>>
>>> It is not possible to remove the device - suppress bind attrs. How did
>>> you trigger that?
>>>
>> Ack,
>>
>> I encountered the warning as regulator was being released unexpectedly,
>> triggering _regulator_put() warnings. While the device itself isn't
>> removed, Registering the devm action ensures safe cleanup without
>> triggering warnings.
> 
> Logs are cut - you do not see the most important part, who puts the
> regulator?
> 
> How unregistering regulator solves the incomplete get/put paths? It
> feels like you are hiding real problem instead of fixing it.
> 
>>
>> Please check the below logs.
>>
>> I could use some suggestions for this issue. please help with some
>> suggestions how i can approve this design.
>>
>> Thanks,
>> Rafi.
> 
> 
> ...
> 
>> [   10.679294][   T90] ------------[ cut here ]------------
>> [   10.684772][   T90] WARNING: CPU: 1 PID: 90 at
>> /drivers/regulator/core.c:2450 _regulator_put+0x50/0x60
>> [   10.694344][   T90] Modules linked in: snd_soc_hdmi_codec
>> phy_qcom_edp venus_dec venus_enc videobuf2_dma_contig rpmsg_ctrl
>> qrtr_smd fastrpc rpmsg_char videobuf2_memops qcom_pd_mapper nb7vpq904m
>> msm lontium_lt9611uxc ucsi_glink typec_ucsi pmic_glink_altmode
>> qcom_battmgr aux_hpd_bridge ath11k_ahb ath11k hci_uart rtc_pm8xxx btqca
>> coresight_stm bluetooth qcom_pon stm_core venus_core pwrseq_qcom_wcn
>> drm_exec mac80211 ocmem v4l2_mem2mem gpu_sched videobuf2_v4l2 videodev
>> nvmem_qcom_spmi_sdam qcom_spmi_adc_tm5 snd_soc_sc8280xp
>> drm_display_helper qcom_vadc_common snd_soc_qcom_sdw coresight_tmc
>> snd_soc_qcom_common videobuf2_common qcom_stats coresight_etm4x
>> qcom_q6v5_pas phy_qcom_qmp_combo usb_f_qdss mc drm_dp_aux_bus
>> ecdh_generic qcom_pil_info qcom_q6v5 ecc coresight_replicator aux_bridge
>> coresight_csr qcom_sysmon coresight_funnel pwrseq_core gpi typec
>> i2c_qcom_geni qcom_common coresight icc_bwmon llcc_qcom qcom_glink_smem
>> qcrypto pinctrl_sc7280_lpass_lpi mdt_loader snd_soc_lpass_wsa_macro
>> sha256_generic pinctrl_lpass_lpi
>> [   10.694524][   T90]  snd_soc_lpass_va_macro display_connector
>> snd_soc_lpass_macro_common authenc drm_kms_helper libdes qrtr libarc4
>> icc_osm_l3 qcom_rng pmic_glink cfg80211 rfkill drm fuse ipv6
>> [   10.804083][   T90] CPU: 1 UID: 0 PID: 90 Comm: kworker/u32:4 Not
>> tainted 6.14.0 #1
>> [   10.811959][   T90] Hardware name: Qualcomm Technologies, Inc.
>> Robotics RB3gen2 (DT)
>> [   10.819920][   T90] Workqueue: events_unbound deferred_probe_work_func
>> [   10.826643][   T90] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT
>> -SSBS BTYPE=--)
>> [   10.834510][   T90] pc : _regulator_put+0x50/0x60
>> [   10.839362][   T90] lr : regulator_put+0x30/0x48
>> [   10.844118][   T90] sp : ffff8000809e3670
>> [   10.848244][   T90] x29: ffff8000809e3670 x28: 0000000000000000 x27:
>> ffff70941a04a080
>> [   10.856300][   T90] x26: 0000000000000000 x25: ffffbfa860a9bee8 x24:
>> ffffbfa860e79cb0
>> [   10.864354][   T90] x23: ffff709406e62640 x22: ffff709418668808 x21:
>> ffff8000809e3710
>> [   10.872409][   T90] x20: ffff709415e81840 x19: ffffbfa86119b680 x18:
>> 00000000ffffffff
>> [   10.880462][   T90] x17: ffffbfa86013d058 x16: ffffbfa8601cbac4 x15:
>> ffff709419a70b48
>> [   10.888517][   T90] x14: 0000000000000000 x13: ffff709400032b10 x12:
>> 0000000000000000
>> [   10.896573][   T90] x11: 0000000000000000 x10: ffffbfa85fdbcc60 x9 :
>> ffffbfa85fdbc7e0
>> [   10.904627][   T90] x8 : ffff709418668ab0 x7 : ffff709418668ab0 x6 :
>> ffff709418668ab0
>> [   10.912676][   T90] x5 : ffff709418668ab0 x4 : ffff709418668ab0 x3 :
>> ffff709415e807c0
>> [   10.920727][   T90] x2 : ffff709406e62640 x1 : 0000000000000001 x0 :
> 
> Everything above is irrelevant.
> 
>> ffff709415e81840
>> [   10.928781][   T90] Call trace:
>> [   10.932024][   T90]  _regulator_put+0x50/0x60 (P)
>> [   10.936877][   T90]  regulator_put+0x30/0x48
>> -----------
> 
> And this is only relevant information which tells nothing. Are you sure
> you pasted FULL log?
> 

sharing the full crash logs
---------------------------
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
[   10.941276][   T90]  devm_regulator_release+0x14/0x20
[   10.946486][   T90]  release_nodes+0x60/0xfc
[   10.950886][   T90]  devres_release_all+0x90/0xe0
[   10.955737][   T90]  device_unbind_cleanup+0x18/0x60
[   10.960846][   T90]  really_probe+0x210/0x2c0
[   10.965341][   T90]  __driver_probe_device+0x78/0x120
[   10.970539][   T90]  driver_probe_device+0x3c/0x154
[   10.975561][   T90]  __device_attach_driver+0xb8/0x140
[   10.980854][   T90]  bus_for_each_drv+0x88/0xe8
[   10.985520][   T90]  __device_attach+0xa0/0x190
[   10.990185][   T90]  device_initial_probe+0x14/0x20
[   10.995209][   T90]  bus_probe_device+0xb4/0xc0
[   10.999876][   T90]  device_add+0x5a4/0x780
[   11.004187][   T90]  device_register+0x20/0x30
[   11.008767][   T90]  sdw_slave_add+0x1a4/0x244
[   11.013352][   T90]  sdw_of_find_slaves+0x100/0x198
[   11.018377][   T90]  sdw_bus_master_add+0x1c0/0x310
[   11.023401][   T90]  qcom_swrm_probe+0x2a0/0x5a4
[   11.028158][   T90]  platform_probe+0x68/0xdc
[   11.032654][   T90]  really_probe+0xbc/0x2c0
[   11.037052][   T90]  __driver_probe_device+0x78/0x120
[   11.042249][   T90]  driver_probe_device+0x3c/0x154
[   11.047273][   T90]  __device_attach_driver+0xb8/0x140
[   11.052568][   T90]  bus_for_each_drv+0x88/0xe8
[   11.057235][   T90]  __device_attach+0xa0/0x190
[   11.061903][   T90]  device_initial_probe+0x14/0x20
[   11.066926][   T90]  bus_probe_device+0xb4/0xc0
[   11.071595][   T90]  deferred_probe_work_func+0x90/0xc8
[   11.076974][   T90]  process_one_work+0x16c/0x3f4
[   11.081828][   T90]  worker_thread+0x2c8/0x3e4
[   11.086410][   T90]  kthread+0x12c/0x210
[   11.090455][   T90]  ret_from_fork+0x10/0x20
[   11.094857][   T90] ---[ end trace 0000000000000000 ]---
--------------------------
>>
>> Thanks & Regards,
>> Rafi.
>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 
> 
> Best regards,
> Krzysztof


