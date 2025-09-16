Return-Path: <linux-kernel+bounces-818039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0CB58BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CD1B223DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F4248F7D;
	Tue, 16 Sep 2025 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pax8MzK9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AE23AE62
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757990416; cv=none; b=Z9X3xjjwAPsdoMknwpAmGyOt7sJnK5l74AJ50fHdGZlU8FVj+FxgTcUqRRuvNTVDL1kTJrrH53kyFx/I4b9bmjKOduJPKozabD2dbigCxr/fHscisTT5uS/5ufvx21BvNuH1PPSK+yuRBiVF92g0Y5aSvGZ3uwmgQC2vtFr7740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757990416; c=relaxed/simple;
	bh=sw3T+Yf7rRxGoEHikzqSJtqsISrkBdzL4ry7W6NjCME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCDiKpxMLQvwSk8u1d2t0IixBrYhhVdeJ1S9eR+RPcF5fNoC7AR1chPv3zSlrAN1fnSEjJ7PpcBx6HfhW4KXVpy2BFvjJ/NmaYF8yptZg5WD21inEL4IY4f5gVfoHJRcWNco4llrXkDyM+RUvvGrcIrQi4vBghXTjakWWJWYgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pax8MzK9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FGXM08021860
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ALKBbxJKWhBYDEwvuuS6efzqtoWF3Q6y4KRex8tFebc=; b=Pax8MzK9tDYbi4Wi
	Ua6hvVsXPpOHAhwBypsMIc9+z4o6lY/oYAjB83+3hbB+EwhrKjBydKQAtUqlD/M8
	eVsqnkaGkJzDxO+RjNwvZLqBHAj6rkTSL2N7BF4N3MNpXPvWGKl+z+kmmgOSP2RK
	99dQKfqF/K+g7XKOMTUe+kxakNT6FGXjMoqlsMgu9iLXOvyoqtY7/uMZ88IZKoM/
	uKlha3oiUB6s19t7AWs457xcN5xpTZfKY2MI9xbAFDyEylwNgYhILNcCuNnHQkNd
	opNG3nl8dWny9qc48KNuQeoGhTTfqThLp8b3exkw1BvCmq3mEe2/Ui3/Jv0rc25T
	NnbHdw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n2r71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:40:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25d7c72e163so73078795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757990410; x=1758595210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALKBbxJKWhBYDEwvuuS6efzqtoWF3Q6y4KRex8tFebc=;
        b=rUfxGISUnz1Ed5JQqUd29cfqLyYhF/yqH5kSOloI0kk0Ywqtxhy6wPP7Ak3iXWTqlM
         ZVMIWoUHu1qtVNfg4KtUCguuFGVcDhNt+sTiCITVAi3t2idmwLdXfOeRSkgSZ2+Bjr9j
         ESYFL0Vr536vnOfaLIQ9O0nD+JTfFJmuiHKlcy4/+Duo5YGDalZCE2TKTVSSkeWMavbM
         xnt9ff/fkR9I0SpB1RmE43Z1gwYhFT75CeOBjyrFedFmT+GIfNTvdBT4T+GyevJd/KLN
         g6zY9ttiKfznTBsj4q4HFjRb9PdbIp5AeHC2xwruJSowM1GigSfYUUyef22fKcN5St+T
         a3UA==
X-Forwarded-Encrypted: i=1; AJvYcCUv0u4bqsuN4qs8DCPxE97J3i3sDpQNWW2NCa+wXDatrGfOSrrerq8E9LEgbTcgyrLzpNlfgfzYkf95mtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK6Z/Oz+2rJD4QFt5+zDzWMx4WCnOf+nDukmGNJtrxlRIwZ2TK
	3CL3Cqcqfj0LsaokV2Hajw+gwKLVYr8ebmho0ymmTQDx7qzlaNRi+qjpo/Fzgny09INLfLL4MZI
	R9TJKuah95cTfhqZWg6sEfkVCFBSgEzegZZgmeIuf0rRGE9YH4ijDOcHXjtdj5/QZrO4=
X-Gm-Gg: ASbGncsVF4FXYsffp0iZ+/+x1oZS9i/m44gigMRCfeTN7dGB5vO8MRVrT8RFkXebBYd
	wznXSYiX2t858stiXV3E0SgMjhiYVzJlWwdIV2D4559NP29IF5sC6EAcccO3berMTxB4CdVwFY4
	Ao43HFeHq8t3ttzEfRI9h/w1+U+9ykyTCswLf2ibjKWT23oaHNDn75QhSmuCm8y2ejPsOuyeFYA
	PN+gBolKZHbk4u38r8o9r3eLRbQE6vm6Y8NIl6eqszduFgutCIStESTPk3aAL7+xYXl3ZdiqMhX
	aeIRiNrTjMB4XiXhOLGZhJOTH5fJsqAPT+F/2rCqzIXhLYfq2W8XiTKTX1viUDb0WkXmH3r4Sjj
	Z/xcqLoAZp0vwoVJzWozaqTNiM/mNw+VyNA==
X-Received: by 2002:a17:903:1aa3:b0:246:2b29:71c7 with SMTP id d9443c01a7336-25d2607a10amr176506605ad.25.1757990409790;
        Mon, 15 Sep 2025 19:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHutrm0VahgASYcAGOWnnFZbZG2dQel55GBh/Zu5/ngeQI/Oxmg11OWKXNdJCX6YG0DD91+/A==
X-Received: by 2002:a17:903:1aa3:b0:246:2b29:71c7 with SMTP id d9443c01a7336-25d2607a10amr176506265ad.25.1757990409367;
        Mon, 15 Sep 2025 19:40:09 -0700 (PDT)
Received: from [10.133.33.240] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm109794985ad.127.2025.09.15.19.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 19:40:08 -0700 (PDT)
Message-ID: <c5e3ac07-e91e-4c9f-9256-497991b75200@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 10:40:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
 <f3s2srlmvuj7wmh4rndffmbfrzylbuq4rsu7pqqrnqa5fgsmch@t5f4dgmqtgys>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <f3s2srlmvuj7wmh4rndffmbfrzylbuq4rsu7pqqrnqa5fgsmch@t5f4dgmqtgys>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3pE4XmXyCLkSzEIh6J-kVcc5-9zWzB20
X-Proofpoint-ORIG-GUID: 3pE4XmXyCLkSzEIh6J-kVcc5-9zWzB20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX1pfzGtlPizES
 /667+TRK6Q42xzDXERRdqw77EqgJZhEKbnqkgdPM+NCWKDj9q0b479IMmR7ErN1O3/pOPySxrsi
 W99kJaTNqaa3gNjx4XkmFJtpjSr6M+2c+hi9tld0ffY54wTTj94VFLAdxdts+AFIOfRU0qNOS8q
 NkqLSZOB61G5TygpeIS1Ik23L1iMi/OXVhG5I2PLTmwIYo5ODc3QOLHzBF2BvqllR9EYaXgC4wS
 5HZg/FGDS5A5bBZUYDVq+FH8dynIqOqxPkkLTV8tZipPocFCcla0ymt+XOmrUn7zV5JoophQMFg
 83eZsPqCpPFLT1pZGE3I45KsPpaSNta9vfW2f50yFHxxsxb2cJwAzYNUzgzK6Mpz2wtJKUTGgOh
 9vvF/qHN
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c8ce0e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=lkjHs5G_WC6zgKVeVEUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087


On 9/15/2025 6:19 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 15, 2025 at 04:49:57PM +0800, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> Add variant definitions for SM8550 and X1E80100 platforms. Add a compat
>> for SM8550 and update match data for X1E80100 specifically so that they
>> could be handled differently in supporting charge control functionality.
> Why?
Is the question about why this was submitted as a separate patch, or 
about the need for the change itself? The reason for the change is 
explained in the commit text. As for submitting it separately, that was 
done to address Bryan's comments to split out the compats changes. 
Anyway, I will address the further comments from Stephen to make the 
change bisectable.
>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>   drivers/power/supply/qcom_battmgr.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
>> index 008e241e3eac3574a78459a2256e006e48c9f508..174d3f83ac2b070bb90c21a498686e91cc629ebe 100644
>> --- a/drivers/power/supply/qcom_battmgr.c
>> +++ b/drivers/power/supply/qcom_battmgr.c
>> @@ -19,8 +19,10 @@
>>   #define BATTMGR_STRING_LEN	128
>>   
>>   enum qcom_battmgr_variant {
>> -	QCOM_BATTMGR_SM8350,
>>   	QCOM_BATTMGR_SC8280XP,
>> +	QCOM_BATTMGR_SM8350,
>> +	QCOM_BATTMGR_SM8550,
>> +	QCOM_BATTMGR_X1E80100,
>>   };
>>   
>>   #define BATTMGR_BAT_STATUS		0x1
>> @@ -1333,7 +1335,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
>>   static const struct of_device_id qcom_battmgr_of_variants[] = {
>>   	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>>   	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>> -	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
>> +	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
>>   	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>>   	{}
>>   };
>>
>> -- 
>> 2.34.1
>>
>>

