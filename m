Return-Path: <linux-kernel+bounces-731162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACACB05032
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82D21AA486E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F3327F183;
	Tue, 15 Jul 2025 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1DPvF40"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB92561AE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752553103; cv=none; b=VTcVuoZxQkVkwiXy2CCsXm8DgD/UBjO6UdZ8xwqRpPQR1js6XjSZpWA4frx9IuwoB6d2eqbLf2iCA/nJq9Xynlh92TOsfK5yiZgvAo/2ypquyUcWcyaQ4IjSHDIx/IiIpCrEaRhMh6FyWlcfbzDQcJLRG/EzxfN/r/HaTC3n2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752553103; c=relaxed/simple;
	bh=dFKWHIQddjxHUPkRV2M3jjcwPHCaNzGHYMUWZuz27pA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SZ5r77+JSQ6d20PkfQJpAFzED/OU8HAsG49h8ftYfG8ib6lLAy00pSYhKk3rjq2JyeaN/AgnrMr9k7j/N/z9NIMDLgDbReBggROxBSCZhi8wlSRHrXS/vE80tDfihJz5Qja9bC/3zDUslPylpptS6RUsnfXOR3JKhfvfBOBWiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1DPvF40; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGSBDK011518
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uzm3o8XukJIfDxG+gIGMGpjKkmpbr4jLR61YoqCEI4M=; b=p1DPvF40/MI+Vnm4
	PfsCtjTRYXnwPO1N1Krud9tSW6geE5N2pGlrnKKxq+Ie6oY5Y1+gsLz5HCKoya+L
	jRbkj+WVEgFNU7QPPBxEfvIwKT6vCXNKv8WE30Om8CmV7pTL3dwAXmAm8Ght0EiX
	Tnb4kNytKs+hATELaSSnVDBTbcky7LITH+ptZ1QtPdPtGWflbOAgbFqUGSAZ3+fE
	PGGAWZX0G4cyq1wblm1aVXWN2HpAoItAZRoRv5zZ+T8rA81gv3eqge9Ew7ChwVYo
	Kq456fnOa5wVAd1hsSFD73c49gC2l0g37ZummJivcJ879Z1j3UMhnDBxAFwGma4m
	+5urAQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyhj4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:18:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235dd77d11fso54073645ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752553099; x=1753157899;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzm3o8XukJIfDxG+gIGMGpjKkmpbr4jLR61YoqCEI4M=;
        b=f0CRgxD3+2f7Fc1lTbyGFDf2TL3EeGoGphEaehxUZzURFPGYq3FM48SamZYqLpYtmX
         sbd2LJorSenIDUHB2R9uqch4Rp/S/obuEsF/9GoJH2lioCdefU8oW2VhknSzEwDN0NL1
         vrGwC6CuTarDNHyF1pD7x+PqK3EsFQgBcHZCifzDFhi5HOSi12J0GJ7Vnqf0L6Kr+VWt
         v/GzMrgdZkaPz7c77pCXMuVnTkwN3PZrS7sDI2nzzGns7MBQ3fvJbMFY9Fc4Q6Rnj4C8
         RcwiiOMWUCSLje2TFJq9FldrEx0FmtjgKLQqiihou2XVYlod/iOBF/S/6cjoj4+zk9TN
         9AHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYJVwvkgP9T93k2uQwCEgZTTu4ChYvgDXkuB8h1IxUqjKd3cXENmwoiMPCpiHX1oFTJ/qhBeILq1DT9VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+gAa0ElsFSXFO/YgP7mZHIjV/OFB7YkeB6HNcgx/mRV3uvY2
	OmxOXoBdBktA2PReCGWS7wZRZ0e9A/81W+s7H2/hvQp+T+RWVBYRAfysMdzxAtnbe266gAwd6j5
	aoHcBgN5BRih+Ec38M1NJUVBgLjOqFlxcorv4i/GdyWrKm82b0JrWK+cdnEtZRjSMT+g=
X-Gm-Gg: ASbGnctdM1/rvpx0Qh5SVU45fMYxtthPWzaz2Oxf1Ld9nSSRokUNylT8nIttrs+sRPs
	W0YvNqD/rz86a3Oo43+RRSonL7Df2BgLjAB7EPRqVrUWAEnSDFiBUgOPO8vrxXTkqHueFsl2Fba
	4UZxUAsLJAROgJZO1vXhKiyinxqdnFVnXKTv0AJV7hLKeT2OKaFBNjgd6g5BiDoE/iJPpUOsZFH
	UE5Tno//L8uiOLTzW0sz54o+VwhEvHxxJz3Vje8H2tv8Mkj50LoG04UwNCjVIjgmPgZHvyb+AGQ
	2v6TKgeYsKSV/l1YJ/EpU5NRNe5EVWrmsUISSADfNGxRLXhQR+wvTUMoRQZukwj1DJhO
X-Received: by 2002:a17:903:2381:b0:235:1171:6d1d with SMTP id d9443c01a7336-23dede2efd2mr201885435ad.9.1752553099054;
        Mon, 14 Jul 2025 21:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSR1JCrm29sPlBvrgSPyyxQnSbvHwk6Kiv95T3q3tvlO3uU7qin2TLupU+hhFPMssDqsfqg==
X-Received: by 2002:a17:903:2381:b0:235:1171:6d1d with SMTP id d9443c01a7336-23dede2efd2mr201885145ad.9.1752553098603;
        Mon, 14 Jul 2025 21:18:18 -0700 (PDT)
Received: from [192.168.1.36] ([116.68.96.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359b6fsm99909735ad.212.2025.07.14.21.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 21:18:17 -0700 (PDT)
Message-ID: <0d1e5ac2-9bf1-4fe5-b832-2e438e51d7db@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 09:48:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: qcom: Remove extcon functionality from glue
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250714044703.2091075-1-krishna.kurapati@oss.qualcomm.com>
 <b3767f6b-9793-47bc-9b09-70fc931ce8f3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b3767f6b-9793-47bc-9b09-70fc931ce8f3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wtk7fd4G7ytW1CTcHrSGYNVxuwEh7-Ro
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6875d68c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=eHFrewLOQS0FNmfAC0rGFw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=427AQKXnQCN1OQ7kLHEA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAzNSBTYWx0ZWRfXwWKQYLdeIc5o
 A/FRG4YCv7yKciM7U8DReQ4pqiseGYV1myCTLBHSSNVuONs3+XokP3Wqv9PSZDx/psG2GuvVgQH
 AKIkGH6z5dZ5NxIU4UoXWp+foQX17GCA4atUtXRPg63mB7lOJ1Yd+l24vzAgLXhD/cOa+HtNKub
 ggPE9pPrKKp4paegt0MmB8Pkz42j4gSAEVyKG3HLZCW3QLJtUozRt+zTlxv0iCHZwUwC2z+KAa8
 jWHFyIcj4Pn/mxypGZLaAKBMWWsNRQ8arEur26xb1Y3fLNfUHsxybL6/MpEY6+oaANI3IM35sTU
 tMo7mvgJSJ5ifTO2byJs/p8sAWNhqzhVjpIaF+sRQH8uanw4ZKlKPjZ/tWBCgHW0PUYARwdadEv
 aMdCHm5KnyHyVPn7Ut2ZSlD/xrsS35hkgXR14ZjEGgcCxxOZwCs4+KRueSe6hCaiZDoDxdIi
X-Proofpoint-GUID: wtk7fd4G7ytW1CTcHrSGYNVxuwEh7-Ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=843
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150035



On 7/14/2025 8:59 PM, Prashanth K wrote:
> 
> 
> On 7/14/2025 10:17 AM, Krishna Kurapati wrote:
>> Deprecate usage of extcon functionality from the glue driver. Now
>> that the glue driver is a flattened implementation, all existing
>> DTs would eventually move to new bindings. While doing so let them
>> make use of role-switch/ typec frameworks to provide role data
>> rather than using extcon.
>>
>> On upstream, summary of targets/platforms using extcon is as follows:
>>
>> 1. MSM8916 and MSM8939 use Chipidea controller, hence the changes have no
>> effect on them.
>>
>> 2. Of the other extcon users, most of them use "linux,extcon-usb-gpio"
>> driver which relies on id/vbus gpios to inform role changes. This can be
>> transitioned to role switch based driver (usb-conn-gpio) while flattening
>> those platforms to move away from extcon and rely on role
>> switching.
>>
>> 3. The one target that uses dwc3 controller and extcon and is not based
>> on reading gpios is "arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi".
>> This platform uses TI chip to provide extcon. If usb on this platform is
>> being flattneed, then effort should be put in to define a usb-c-connector
>> device in DT and make use of role switch functionality in TUSB320L driver.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> This change was 4rth patch in [1]. It was suggested to make this as the
>> first patch of the series. Since this is independent of role switch
>> patches, sending this out separately. Removed RB Tag of Dmitry since the
>> patch has been changed.
>>
>> [1]: https://lore.kernel.org/all/20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com/
>>
[...]
> 
> Shouldn't we cleanup the Kconfig also? Anyways it's not critical, so it
> can be handled in a follow-up patch if preferred.
> 
> config USB_DWC3_QCOM
> 		tristate "Qualcomm Platform"
> 		depends on ARCH_QCOM || COMPILE_TEST
> -		depends on EXTCON || !EXTCON
> 		depends on OF
> 

Ignore the above comment, both dwc3-qcom and dwc3-qcom-legacy uses same
config. Sorry for the spam!

