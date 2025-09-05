Return-Path: <linux-kernel+bounces-801878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625D9B44B10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014A11C81C97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264391DE4FB;
	Fri,  5 Sep 2025 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lxnPFCXF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E71AAE28
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034243; cv=none; b=UwUKTmEvxCQzp1makd4Wf5lZUNpJf1KcD3/q9l1b2+cqLot7E0De5bSl/lzqxt8x244WXKroga/w39BQj9mgKAzwKRICZ8Q3S1MOTyzPH04J4EquK8gn7uwtNbRDLsvHamwNwtnBEQNxJ+cVzkuWZfYUUk+lhzlFycDzbRCFOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034243; c=relaxed/simple;
	bh=E60oZCvVY2XQC5MKAz3hSZqG5cJY22Czhkp4QdVVK0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6jWedjtYnaISh2w1eZN4kwX+DeD/Y2CK3jm4Khap+sAF0dJebLGGuxyM2Qsa4opL3KSO11NKJJx0fYu3qNzM65OkI2bUwloj9Kzzc+Qw8YN8u+pZ6pbabKczLJnWSMWWlcLtxbaVC1afJmdfdFQu7hRuDPmIgZer/4SokvT0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lxnPFCXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IYFqe002728
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 01:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9x/ZnBgm4svQLivjO5lFYu5fqyWw8hoi1jnTAaS2pOs=; b=lxnPFCXFMyLZb9AV
	X7ffLjgtvcqL2/6lLBrlZcUNg+kauiZcZo42GKmwsofn19Ry5flHl2HMRIR6P11H
	5r2PYbyEFe+WoS3bL5DpivX/ej1D/yLd4jWblkAuKqHQRxVBU+PN0ZerITKwbPq3
	Jzwg5izzv+6/NUywDnTNx3UI3iEr6VY18T/yFEqTYhRD9e0hu2GCbZ+v/rJDJ9ri
	mXyamNeHb+IPEuC7DKyobtiPNptI/RN2jS1CmPcVr6xPs7Uhn0xuQSwlt3ETZ1OG
	8DcXjD+TW9607Z75ANPR4g6GNs8Whx58d12fG4nnI1eRYXZu0gwSc1V8CUAeLXJ6
	B0yxvw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush396xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:04:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24c99bd543aso25508025ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 18:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757034240; x=1757639040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9x/ZnBgm4svQLivjO5lFYu5fqyWw8hoi1jnTAaS2pOs=;
        b=s/XqKzCe4BJ/qI5ks09oLtvPQoc+fr0ZwA530iIl9yZ4E7VAg4zQOLsO1aykKR3BKs
         l/PWS1qEh93UNNYbHtBJO/mAZaAaX1ky8ZXZP7MOiS3mSJcfm1TcKpMoBxrwu+M+tDju
         pRUiCd5rr56ohKOiu6Xdbxgr3E7GX0uEAQptPq2K45ggT8LOPVX3l6heQKq2DNTbssf7
         Jj0cWDw2l9J2F4cDszGHY3CvlSbzSMa9nR0+MyOQhUwV6+JOEXbhkrhYP/ob/ImnNb9i
         EoAXLXoPugOXrsbMqgwWQO9rtnMxEEUO88TOkjkEB83vKTCA+RUm1is1O6FVouTela1Q
         1LWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKU2CtEO57T6jxVKL+PwJoM3FBDWnPLvagkLzvcPGZGOO7q3KpK3EmgSekreL47LNfxv+utZ/gpGUfoZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHD3UzE2lnN+GeChVjrnUVajef/5qZXJDQ30++pl9IYgisiqE
	cjUxPaGPlD/Ya/0RrO02WJeOR4iCgUTHuwTZb52Rf7N6gEb0EuSxGQVTRJEwuo8ospcJfBzmW9d
	NUIEwwpkbhcjRlT7vyXIa4TjZP7Lom1dVQ71x6hYeI+i0MkFEo9mVdu+ai39a7YN3HSs=
X-Gm-Gg: ASbGnctOlWtPw/dZ699Ui/D9z3JGC7GBd6bCQCudtuxJn8qjDwY35WBFbp9TZQBJMpL
	EC0SKcZ9pZGL//KEKPSQX8nl8Bz6VIqeRAdyngOWU+n8LcWyICbbllDdfjQcoJMrcjJ6pJpJh2m
	1xJpeyYOFratRmiI30SQXsRBfpA6Jf03K5YAawu4717FiuBwYQytSXsJd4JsPMHDp433Sdq8ra0
	O+ojU5JhQezWG5yREwbisR3ZNbO8b3b1lg50FWWNjRby9SsqlLrvkxMOfT31HRN97ouDE3PRgph
	ZBNzOItgeobiXGPhIbiNBMplQnvsQYESYxdy6uBgTuv6Er5A+eZQ5YxlGCLjGYeXcREoW21aBi8
	VUzJWXwOUtusBOuQ5Jo79/u9mbH3GPasC
X-Received: by 2002:a17:903:1a0e:b0:248:c96e:f46 with SMTP id d9443c01a7336-24944b81c37mr262422515ad.60.1757034239987;
        Thu, 04 Sep 2025 18:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7PL5Q1tEpk5K+qxnrlMkRx3Zfh4Hi5/r47t4WUi+YB3Zb3IhsOhnnrsNU7IDSjiEHTamUJQ==
X-Received: by 2002:a17:903:1a0e:b0:248:c96e:f46 with SMTP id d9443c01a7336-24944b81c37mr262422075ad.60.1757034239485;
        Thu, 04 Sep 2025 18:03:59 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c8945d925sm58656885ad.36.2025.09.04.18.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 18:03:58 -0700 (PDT)
Message-ID: <af7cf6cc-d558-435e-b406-374ef92914a2@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 09:03:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: x1e80100-crd: Add charge limit
 nvmem
To: Maud Spierings <maud_spierings@hotmail.com>,
        devnull+fenglin.wu.oss.qualcomm.com@kernel.org
Cc: andersson@kernel.org, bryan.odonoghue@linaro.org, conor+dt@kernel.org,
        david.collins@oss.qualcomm.com, devicetree@vger.kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, kernel@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, me@kuruczgy.com, robh@kernel.org,
        sre@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com
References: <20250826-qcom_battmgr_update-v3-8-74ea410ef146@oss.qualcomm.com>
 <AM7P189MB100958EDD985483DB1F32EC5E301A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <AM7P189MB100958EDD985483DB1F32EC5E301A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX89r2QKaOwjNB
 5kaTcKLEZ8KBFMCAXh/xcVdDiE0cDda4R57Ym3bK03vUr7XzJI8t4fs83J3SBC+U+5RyeAue/j0
 zByrv7DthbRSFgenwjjY+GYnedym6WDrre5lEHLJ6bCFW4qJhuWS2eOGD/B/v36TMqdx9EhpYVa
 tvAJU186AIBKL1h4gE8NgpEdGOIHcRV2j0eIJAkp1kTrmqoTZuo6YTwEnQPzVJOCu7iczLDtkUP
 H5NFk4Eckm2fw2u2lY3fzsuXNu8nPa8BQDvjxSCmyWyCzjZIPyyW5jvPQhdzmUL3b13unJKi0aM
 ZHa3tzetw4ZH62o/w+n1ZbLaAfOT+cDtmHYUgDaajpETB0psOMEZ8wmoidwC6Qb8WKwjcCKqyIB
 RNslIWP3
X-Proofpoint-ORIG-GUID: fuE4Od8cRij11mUShroPRhh9ANGFyety
X-Proofpoint-GUID: fuE4Od8cRij11mUShroPRhh9ANGFyety
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68ba3701 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=065pQyBIx5i4jwDuaBsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032


On 9/3/2025 4:41 PM, Maud Spierings wrote:
> Hi Fenglin,
>
>> Add nvmem cells for getting charge control thresholds if they have
>> been set previously.
>>
>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  2 ++
>>  arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi 
>> b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> index 
>> c9f0d505267081af66b0973fe6c1e33832a2c86b..8c3d30dd936ef9b12867971f5f237dd12484072d 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> @@ -82,6 +82,8 @@ pmic-glink {
>>                      <&tlmm 123 GPIO_ACTIVE_HIGH>,
>>                      <&tlmm 125 GPIO_ACTIVE_HIGH>;
>>
>> +        nvmem-cells = <&charge_limit_en>, <&charge_limit_end>, 
>> <&charge_limit_delta>;
>> +        nvmem-cell-names = "charge_limit_en", "charge_limit_end", 
>> "charge_limit_delta";
>>          /* Left-side rear port */
>>          connector@0 {
>>              compatible = "usb-c-connector";
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi 
>> b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
>> index 
>> c02fd4d15c9649c222caaafa5ed2c777a10fb4f5..abf7afe5127d7b8b572513234e00009ce837837d 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
>> @@ -239,6 +239,26 @@ reboot_reason: reboot-reason@48 {
>>              };
>>          };
>>
>> +        pmk8550_sdam_15: nvram@7e00 {
>> +            compatible = "qcom,spmi-sdam";
>> +            reg = <0x7e00>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges = <0 0x7e00 0x100>;
>> +
>> +            charge_limit_en: charge-limit-en@73 {
>> +                reg = <0x73 0x1>;
>> +            };
>> +
>> +            charge_limit_end: charge-limit-end@75 {
>> +                reg = <0x75 0x1>;
>> +            };
>> +
>> +            charge_limit_delta: charge-limit-delta@75 {
>
> I think this is supposed to be @76 given the reg property below and 
> the other ones above.

Thanks for catching it. I will address it in next patch.


>
>> +                reg = <0x76 0x1>;
>> +            };
>> +        };
>> +
>>          pmk8550_gpios: gpio@8800 {
>>              compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
>>              reg = <0xb800>;
>>
>> -- 
>> 2.34.1
>
> Kind regards,
> Maud

