Return-Path: <linux-kernel+bounces-737837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F64B0B11D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6DDAA1B72
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F12877ED;
	Sat, 19 Jul 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oL1WctaN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C3E8632B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946681; cv=none; b=c05NQPbQ7uypzD24Zs/aT7sNA/f6ulDXqGE7dpj5X0V2OOQxBpgH2IRxnd+jO9S/wKsRi7Az1KyHq0FexM1VJOOmdQ1aFrYGvMVuumS3Ssshb61iWk4QCOlbt5/6e6VlwZTwaGddpZiJwEexqN6lGe4jO33cDNEZrcr1LdnDCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946681; c=relaxed/simple;
	bh=l9pWszHcvlWae0ybRVxovXrxHNxxC2htd+6q7MexnJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpW8nVW3eLNoY8PQpo0IUtFIrz3G2Tlf0HHnNaCYEYEMjqGr+2G39Gv40EQVRnN0sICiRCANLDmWmwm1M4m/ruZqtjekJasteqoeBRRyXi41sSxKYPCWA6TCiyowcHgQ5fQ+/sFIo/obsKabjqW9FrdD3oxIFHTTtX7jlrJBU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oL1WctaN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56JDaJVV021619
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FZljlJT2qbBwi7FRDYe/gjY8HI2+8fcJAaiOiTqbESQ=; b=oL1WctaNTr2hoM1R
	AQtzwh9PTmZV6rRngkX7LxxhiA3DOUH87RckIoI4QMw/oPasgyI7m70T2RVOvSPa
	g3xFlS4+l8RN4ADGonFuWdYl9Wybvhun//i18RHqHxoXJUObrtse/7BjggXRbbmf
	LFFieVicZm5vOzmnXW7DoxphK+cWSiNSSj9EdX9rvnu0yrk84wXCyhhERHKILDi6
	D0ee9GJuqCZLZ4Piscbm4yFs4tlQwFij5TVMY+kQEqCa0BARtWVqyCqb+MdU0wYG
	LKbB/DTaXMEl/2lFRfJO31y8nW2IdPHbyf1/4nPQrjNBCqMtBYU/L1F1jdK35Yd8
	IwXtdA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048t900t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:37:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3f321dc6abso1089470a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752946677; x=1753551477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZljlJT2qbBwi7FRDYe/gjY8HI2+8fcJAaiOiTqbESQ=;
        b=llLYjMTp51BPo6HzM+ndwJ6Kv59B9h56ESS/5SmUNIepZTbs8amiTxzWEL8qj4/1rW
         fsjd5xmrwY3OCRipajhAY33E8uhG/NOJegViswZKTPwuBZB7grU+7zY8eMqlbJsrRSTM
         aVw4Hb3SG89pqA2ZgohTFCFDeT3kDwTLKCTh/1Q9zv0GdT3e75vnqCvU5CFHwqpx/4Ax
         qIxnxEjUrcRrDP8jgbLTfzkayQCDLnjNTVUajk6lqlmWCFx8kQaawqnQRfGMFTCSram8
         A3QW7gqJ24hnhQCVtb8Lv5xlL/WiZ/TzbhuRB9YQfbtACWCewZGZ6oSSC5VcT9veRPaU
         MBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlA5LquQ8ebtAAq1rTFdK1XdB60NPR0OGIf1cKXLgPMvEhUthdoD+kEXSPbVfWm9cyAaBhZOxyarnEUdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDN0l6oAamqKAXwOddIOJtcXV9XXk8uAJs0fzpU/g/9Y8O4No
	P9u3VuMzq5dIXn+0/JClVJ5wIQvsX3pBmGqkE+OA5CHaIIytxTIGqYQLsh1CJQ1sWh2mSrkg6ux
	kxQeoMzyT9CEFjI9njQb/ObEjWrvlprwJ0wXhh/DaWAAHkLJhdrBjZsgSA7ISWp19hn0=
X-Gm-Gg: ASbGncsE1Vm8wCvMTz/SJLGCmC5tKpnp49we8zeZ/LfnHA3MwkZIjC76rvfXelDqEW3
	dW+JTN6QCd1fpgpzX6vjxQrQrux/VtYa9ZAUn2lB2RfZhlbHwtja1F4OQeruXtJGqT9lBAygbFv
	wT0xC++Xj4Q24snuSMF1bA9xkWrPlGsuqbq+Yd/MSFDYo48FzEQgYwyIt3s2cKgT8mvTdoQGzUt
	dYlCpgiGKNOpSY8gGchDLcTNeFcuPaHlKd+0If7xuoN1d3fiOx1Dp61wIxVtj1xNNUK0RkmMyvY
	AJZdyv3hg8pTrRAaD/lwdPVzqKMtCDiBiXTAMPkPeWo1nBbdM6x/zQcsc/RshdoW0GGPdv2j+yN
	F
X-Received: by 2002:a17:903:1a45:b0:234:c2e7:a102 with SMTP id d9443c01a7336-23e2576c1bfmr203194215ad.43.1752946677275;
        Sat, 19 Jul 2025 10:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmsqS+oyiroy7F7asjC+RhuXy5jbyXwVyJMviTpt16hI2w+2DRxkm7tSvxqRyFMSouRG3FRQ==
X-Received: by 2002:a17:903:1a45:b0:234:c2e7:a102 with SMTP id d9443c01a7336-23e2576c1bfmr203193755ad.43.1752946676803;
        Sat, 19 Jul 2025 10:37:56 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.231.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2d7asm31792585ad.1.2025.07.19.10.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 10:37:56 -0700 (PDT)
Message-ID: <1653597d-4d6b-a771-fbd8-c129c630ac0a@oss.qualcomm.com>
Date: Sat, 19 Jul 2025 23:07:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v11 2/8] power: reset: reboot-mode: Add support for 64 bit
 magic
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
 <20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com>
 <6vlm3ybjpy2jq3cr2pzj4vcmqwoissdml2xmhfzlulfbrpzakt@xrepu6c5zykb>
 <713b2cc8-1bc7-a8b7-678b-5fc7fe25615a@oss.qualcomm.com>
 <8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDE3NiBTYWx0ZWRfX3jbCN5cn10d5
 HJkhHmCWOqDB3h2mS2ZTCP00w+SwQoFvG1bXsx/bIa2Lca1fDrRZKE8SttbX8QtHugQhUCSSGr3
 H71C8PXQZy3MPJFsoKC0/RbG5Efq4/bVyFHpgPvUibANiNRkZJimE9auPRBQtPhumPAHvl0RKq7
 Euqm6wpSvgY42kzAPYTyXH7yGrKBaZjiFfm7+9xhlAiMGdcUNwiZEJWNqMcsSTfAZGtOnIRfC29
 /qbYBwTue5GJWtUP7QtTFkcAqribdvFCMf934LUrdQb2KPrQBgRBU8Y9ZqEzVUXcEPA1uEEudl3
 z4zIZRaKXU1gy5r3J64GJ8SwLyVC7gCAx5kN3NN6vams25q/XzRClNxLMCLiW4LRjE8szPsZisU
 bBguTAphB1UeMLsCDhtMKgYi57TwFheoItfByHKSL12CQ02hUuxBs+rAr8yqo/L5Zy27tDAr
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687bd7f6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=PsbcbGlCJbaar3GLNM5paQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=vijFQojot4H3nP37T3UA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: JU4-NQActC6xD5AHfoBXDTWG6VisrjGB
X-Proofpoint-ORIG-GUID: JU4-NQActC6xD5AHfoBXDTWG6VisrjGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=725 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507190176



On 7/19/2025 10:27 PM, Andrew Lunn wrote:
>>>> +static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
>>>>  {
>>>>  	struct qcom_pon *pon = container_of
>>>>  			(reboot, struct qcom_pon, reboot_mode);
>>>> @@ -37,7 +36,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
>>>>  	ret = regmap_update_bits(pon->regmap,
>>>>  				 pon->baseaddr + PON_SOFT_RB_SPARE,
>>>>  				 GENMASK(7, pon->reason_shift),
>>>> -				 magic << pon->reason_shift);
>>>> +				 ((u32)magic) << pon->reason_shift);
> 
> As a general rule of thumb, code with casts is poor quality code. Try
> to write the code without casts.
> 
> Maybe something like
> 
>       If (magic > MAX_U32)
>       	   return -EINVAL;
> 
>       magic_32 = magic;
sure will update it. And in above, should it be recommended to add a explicit
cast(for any avoiding any compiler complains)?
 like: magic_32 = (u32)magic;
> 
> You might be able to go further, and validate that magic actually fits
> into the field when you consider the << pon->reason_shift.
will add a check to see make sure the value is in range after "<< pon->reason_shift".

- thanks.
> 
> 	Andrew

