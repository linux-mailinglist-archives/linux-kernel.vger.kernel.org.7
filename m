Return-Path: <linux-kernel+bounces-893395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A612C47405
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F1884EC5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73901313263;
	Mon, 10 Nov 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fs/1mSr6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jn/8Yvrk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D33081B4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785511; cv=none; b=gsLuJQztOMUEmPaS0l6hH23d+UIgKfLUqWS/NlFH6/Zhgkp081AUbWZ/iAyPVq3AdSKxThvgZpm1KLhMl39iHxJzRPDw3TuDnLI7lweQptdIoh+aummn3uj93SvS8PTxuy79f/nR5E/ILOHXIrA81de3CvhT8VIjdY6qZJetE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785511; c=relaxed/simple;
	bh=Kv+GgVexbGopxr7yumqlBiancGmQZWWVjQWyj1jNkno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGEwy2ukthSeNTv0YvZMunogOzS3qlbi9HWdoNCnfTlTsTPmlnmgu0SQCZLOKUeSeJ/coPgWlOdbCTak3YrMhW1Cv5Ok+N/ed0sEI78075KMyK9xXvCX4wjL/5+gosAmhfLKbkrY6MzKP8xlRsMeEKVrF5pV6DnpilPrJlYwXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fs/1mSr6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jn/8Yvrk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9Cgg33146225
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DjXlGf6kCK1SRmg1a5VtEsJaR1Zk+XRBUVbJsc742Xk=; b=Fs/1mSr6ibXTZsBm
	K5ACt9BDv18vhbSavu73Iw/bUfBeSMqG7PKz/LE6fa3WvrCs53lpV5uD38jrsVYT
	Lzpw3TaCvOuBJYvrK8X+QejBmwOf4xpqIIxkvBIuGFQQWx1iwazN731vOfPTfVDW
	buOdmttgzcjg/yKdGIZsnELNhOAt7w095Q1A//CC1fIhwKZmZ25t1hY17sr/SX7t
	k6haVM9zF1eFi4QBlG/VcSq2if1FrHkoGtm/w6qrY2XhWbhWyleUkZEKZLx1hflH
	POTYPJ6J6MNQIMYGIiUF6Vr/7q92cffk777Huwd3iWZNwM24E8o92VkFv59jC6P7
	x/DVOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd7hrxr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:38:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-341aec498fdso4953249a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762785506; x=1763390306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DjXlGf6kCK1SRmg1a5VtEsJaR1Zk+XRBUVbJsc742Xk=;
        b=Jn/8YvrkizRMJyTkETr5o6pggtaQ/KMqLDmwX1QAudTOWslftxuGHCgYF36uQ91EHy
         zEUJ3ckOexQOG4nV09RtiZVCtgBgYhHmGMXNLF97Jr1IykxoNSqRbIsOC5AjZIcSiUGd
         o1ccuVdhdBrl6MIM3/MTDYNGo4/T1EwOBWhRh8ejzbJh0yfrTSlk/CgNcjGosODHv8UP
         VgKDoDtiIeEF2pQWCO1iEIljWO9bhTz9OyooD6Rr8jGUKfIs/xRy42qWCOZxm9wzocG4
         XAunKGg1LQH5nPQdPmwNL29uNCipIbRkaEjBLfshAWc8HqbqqYWWl2ghUmMF23c18yWd
         4zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785506; x=1763390306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjXlGf6kCK1SRmg1a5VtEsJaR1Zk+XRBUVbJsc742Xk=;
        b=f7b/0uy+vAcQCnqRyt0Onic+GZ+PBT6QzwhkiHTJculpu+pnYfv7AYY3GDKxrefNEW
         JC5HRfqIj2hOoQnuak4rv9Exme0ATgnxXC9nIyULwpXQKdNMRLPyPKZurMHhgQExbChE
         5LSrrDpfLvN+dED/WefrKw9D9r/80U11kZ7YjN+ETVGy4Ysjp337XxxOLcVXggFAzmTJ
         MuUiO0kBq9BXuR4pmShKdhUG3GJwXHgs6Pmjwknp5krbrlL5XYyrRkJRhb5C6Ia6PH0X
         GPkSd/jJKTqOprWSmKkrGc5HMXqMs8Qt1FHPJ1N07btMaPQb5q7DW20e7pD2FjWij0eb
         QQqA==
X-Forwarded-Encrypted: i=1; AJvYcCXt5/P0UT1uzQxmt3VAYd9L2LnVzvQysGGl3icJMHqWgWQBdLW0ZQuPo0Bgt2m5QdzhEDkwBdeFTqp5vEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOMv5oVP1I05fb49Ed6dFXFz2yX2zLKswJ6o6q7OLYRJlsdRU
	0pBvvMlFQZF2QwC2HNnfz9xdmBpTowbuP+MoU5WYF50g8kFfN8TZVCAZVz673M7s0gUFAGvGJ9t
	saHlTAnavBCGmqOOlXj3Lvh2Bn6dA2ujDtZNbJ+bRCi9F4brrIY87dzykXwJ1crSpyuU=
X-Gm-Gg: ASbGncvr3rRWzw2zquX5w7CJTYx7lK47w8zH1B87yG7JPqe8wxrhyrODgpguTDAXhnW
	xKKCdt4I6C45gkWlHop/VGaSOGhse2uQ3dOc2pJl4Qoq2hESZUtVY1oz7c9i4PaQIwwGSwbSvVW
	9xeaEwr4tK9hzNALWOnLh4WV0zb5PPfO3Knc1BNfHxOjsHjguXzjnEgtSO42u2IGheGlcBhp7Y0
	Oa3ANkAoDNeF9kPlgjdENvQuFchVB2rH5X/8s2vG20WNNLHby6VZmeTIM6s0sf8STz9ATtJ9k9t
	+Uq2JsuGfwUEoU0LJ+/NhDvQPLydbX9h/ubeZB4YKB/XGWIsssOx7kNT3gX3GmFZgMZejtVUPTW
	hTJtP4bs4KDEAIcJvS+hq2c9WaZnNd2Zb
X-Received: by 2002:a17:90a:ec84:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-3436cb91ec3mr10817686a91.23.1762785506405;
        Mon, 10 Nov 2025 06:38:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcDiYkW+6pedjCMiR1BaFljPhTaDiM32XOE7C47GkBGlZcqk0BMUcwHHXae+/cHPVW0xghTA==
X-Received: by 2002:a17:90a:ec84:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-3436cb91ec3mr10817613a91.23.1762785505845;
        Mon, 10 Nov 2025 06:38:25 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0aee149sm8431073a91.1.2025.11.10.06.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:38:25 -0800 (PST)
Message-ID: <16521e84-9da6-53a7-febe-9decb6970c06@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 20:08:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 03/12] power: reset: reboot-mode: Add support for 64
 bit magic
Content-Language: en-US
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
 <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JvPggTpPpLS_04aoCtQpwc4J4n14SFqy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEyNiBTYWx0ZWRfXy9nh2MNyqMpw
 jo+9QWnCNIXiKEpldb7EwrEQcNgHfiVJi5qdl4yXnbXvMo7JSYREaY12GQsk6/ZcNfZ3EYTarQ/
 +u5IrSH0QnDF4mHaBu93UP6v/KG53GaO8Az1gLJeuqgonApt3WpsmRDfBbwVgHMHQxC/Vd5Ya9v
 k7e6Op2ybwSvbPUS/O0MAMBd8A0tu5nahuQty5TJwt4xpAulTE2Prz8sVLe/NeURMVWhUlIshrg
 KPHQ+Jgs72GQ2wpoEo9o/7ASHsVUf6bjpfCYYSbpZXKdmbSjcUBmvi3vyJ4Txl7zh90O+lEHxHH
 3BSLI8oSgD/RHV8E7Z6ypSBKu6C9BYxJnXyAPbiAvJXVv+cWyQ3J97JqU5V7nVyDj4XLqphWsO1
 UdPKEO+SahdTHJK0DxYWRkcaz+q0nA==
X-Proofpoint-ORIG-GUID: JvPggTpPpLS_04aoCtQpwc4J4n14SFqy
X-Authority-Analysis: v=2.4 cv=Yt4ChoYX c=1 sm=1 tr=0 ts=6911f8e3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=vG-lknqJ1RofaPO6YZUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100126



On 11/10/2025 7:15 PM, Mukesh Ojha wrote:
> On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
>> Current reboot-mode supports a single 32-bit argument for any

[SNIP..]

>>  
>> -static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
>> -				    unsigned int magic)
>> +static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>>  {
>> -	int ret;
>>  	struct nvmem_reboot_mode *nvmem_rbm;
>> +	u32 magic_32;
>> +	int ret;
>> +
>> +	if (magic > U32_MAX)
>> +		return -EINVAL;
> 
> 
> I believe, we need a comment in all the client driver.. 

Ack. Will add a comment.

> 
>> +
>> +	magic_32 = magic;
>>  
>>  	nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
>>  
>> -	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
>> +	ret = nvmem_cell_write(nvmem_rbm->cell, &magic_32, sizeof(magic_32));
>>  	if (ret < 0)
>>  		dev_err(reboot->dev, "update reboot mode bits failed\n");
>>  
>> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
>> index 7e108982a582e8243c5c806bd4a793646b87189f..d0ed9431a02313a7bbaa93743c16fa1ae713ddfe 100644
>> --- a/drivers/power/reset/qcom-pon.c
>> +++ b/drivers/power/reset/qcom-pon.c
>> @@ -27,17 +27,22 @@ struct qcom_pon {
>>  	long reason_shift;
>>  };
>>  
>> -static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
>> -				    unsigned int magic)
>> +static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>>  {
>>  	struct qcom_pon *pon = container_of
>>  			(reboot, struct qcom_pon, reboot_mode);
>> +	u32 magic_32;
>>  	int ret;
>>
> 
> Since we are doing this change in reboot framework, client driver should know about
> it too about this new check because of framework.

ok.

> 
>> +	if (magic > U32_MAX || (magic << pon->reason_shift) > U32_MAX)
> 
> 
> is this (magic << pon->reason_shift) > U32_MAX really needed ..?

Can be omitted as we already checked magic > U32_MAX. Will
remove it.

> 

[SNIP..]

>> diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
>> index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..3cbd000c512239b12ec51987e900d260540a9dea 100644
>> --- a/drivers/power/reset/syscon-reboot-mode.c
>> +++ b/drivers/power/reset/syscon-reboot-mode.c
>> @@ -20,16 +20,21 @@ struct syscon_reboot_mode {
>>  	u32 mask;
>>  };
>>  
>> -static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
>> -				    unsigned int magic)
>> +static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>>  {
>>  	struct syscon_reboot_mode *syscon_rbm;
>> +	u32 magic_32;
>>  	int ret;
>>
> 
> same here

will add comment here.

thanks,
Shivendra

