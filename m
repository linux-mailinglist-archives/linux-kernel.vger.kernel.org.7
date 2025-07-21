Return-Path: <linux-kernel+bounces-739595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63FB0C850
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2AD16365B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B12DEA79;
	Mon, 21 Jul 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoXhyD+Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858C2D63FA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113486; cv=none; b=e0ZRMYC5lUdEB8I71q5phIgRah3yPUf3Z8Nohb2onmGjznykLKdfhUONIVUzwGvP0t6Slxcl61JJMLMr6VpS6PqbmOf3Zh6dI2ndp3YUNsxa1bx+znqQ22inrJbBOD/mjRZAxHo7h2NvucWF6hdnfmpGXIq16G/SJ8NLmeau5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113486; c=relaxed/simple;
	bh=Aeb+cBaDP6mCJ/kvpMM3pvMOYo5DtWUCf8qOisApiNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzNN1/HNKlWtZVCzUbE8Gx48pcMHfr0lK1RcnUiMhWQ87n5Cl3F7POZ/pr4KKa73KMcVa1ReYiGg7rQhP760+XNnpydsaiT1TsAe2nlIwzBZwzr8sDtK5wjeZBigo95RfAmtSEHnkciVe/37FXrKywcXMszDfXj/TCJ/Wu+KK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoXhyD+Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LA3eRO005659
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7eaykh2jpr4tDzQ/ml8eASCLk5tz1CCA/grPwuJlCtA=; b=GoXhyD+Qx6sZ84f5
	Lw9+R7ToqBXi7jfqR+wvz34jza0wQeaCbxhOP36MJNguhVMXL5LymKf9pLVjeR6/
	/csboVapjS5vGcrZ63JRIA0EeuTNuLM5rdUA6kw2hA1eYMEdrUunMSFtxkacgLnr
	TaEEXoguHDC7Dc+GUcFnb7NEmhfFYxaiXzdLp4a6uRXLGPat0uqdYV509Tvm0VQH
	fgRlrUs6+Lj6mrt6aBXml2tAAMEykShAi7Jw1bT3fkV94eHfxAPv0pqbIlUIw5Yz
	FLqIS9Y/Knt5/TBTOeAMEiCxIWvHtJ1rib1DWX3iSseOPWDJpUYYO4r/t/uiMeuJ
	QyPHqw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q62ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:58:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2365ab89b52so39512665ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753113482; x=1753718282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eaykh2jpr4tDzQ/ml8eASCLk5tz1CCA/grPwuJlCtA=;
        b=krMXAuK0hM5FbZMol5Cjp/iRv8VdbHfzT7awq88XE0jCQQVjxEqHHrNkbCVVLQBFB3
         UFjOJEYMXZHlk2uVeZoTMVJFrAjJjlV2bqXMWEVjY74XEwnL+2jWXh41gb5sCb8CAG6J
         0Albq4AWTA0sMFQonn0CqFJkiOK9yE9mEuOhz9fmmXJvuKY4RbWwUIsy8or3AOiIGwxw
         0cxmDD3yEcpKuydPognU9wMslXYyfd1c9xC8ZSQwWuDzkpxy/2j5qX0RkWPWe1vltI4c
         Ru/jZGhTHGwnTir1d/q32i16+z9/AVGRbSQunkVBUy8Zs5yM0ZPxeKr6/KEZlXG/oFLe
         35VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7rEV1pEziM0lhaG87Eljqt+j+BUK3Oa2hTUBqPjDMqpJT1gp4gk+IfFnQqZERSLUeAfHbJ680B3V6hCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5WYZrZBz8VB/S1gEnfiZ2IPCzkY3z/FxG1EmKLIWtSmBM1Dr
	emZCsbJ8A1BhhrKGOA3loQBOKDBc8u3mSUrMpVpZTJ2vef7xNEA0O9JzV3bBiEgFSUmBby2xTe2
	PLF1PYVEaQeHz/0XRKUfoQwD/ZcGOES7BRC1+eR8/f7ieZ6LVs0+Jb0NHoSorVXBD8uo=
X-Gm-Gg: ASbGnctw8spAkwUXu0d08DyVk13V4ngbiUkVQAOmr7XiIkiE10oHZgBrgRUxCF7u9eY
	XJ6eP9QBzzzgzhSMB+3kmIJdJOhTugeDk4mUHbw2y+8c74FKp6XA6l1jleu0S2NQ6DJbt4iAI5G
	QJGxxIACQq6PzrlYdZq/84qix8osenzS4C805PZW4i/777zs5ooFQKkMWjF48Ddjl6hVQN37wzV
	cr2QyKGyzgIEsUNqjeDqGdpAZMIQMQH5wMVTwgQ9IE78RuAcg1S4EO+bcoG21eaEHjH4h8BwR5k
	QBP5JA4PmP9hw6urhYrlbRZoeh5i3PLc0crct8nx503P5xv4IM5MtdaT4W/ey/bBY3lGnzQrEd/
	kb7OrYEqjO3VXHIK3SJ+evSP8qtlre/lPsOuPOrnzWPEZj/9xmZ24
X-Received: by 2002:a17:903:3d0d:b0:234:f4da:7eed with SMTP id d9443c01a7336-23e3b84f72emr209498175ad.44.1753113482588;
        Mon, 21 Jul 2025 08:58:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfxVD4xFyUDm77aId4Mxba2CamnraZ59KFcCKOXsR0AXPmtHwmcTsp614S8u5McuJQ6G4ayg==
X-Received: by 2002:a17:903:3d0d:b0:234:f4da:7eed with SMTP id d9443c01a7336-23e3b84f72emr209497835ad.44.1753113482146;
        Mon, 21 Jul 2025 08:58:02 -0700 (PDT)
Received: from [10.50.52.170] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6eeb9csm59786515ad.186.2025.07.21.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:58:01 -0700 (PDT)
Message-ID: <32facbb3-3cdb-42dc-9e65-3daa0b3899a8@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 21:27:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add glymur pinctrl driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721143037.20983-1-pankaj.patil@oss.qualcomm.com>
 <20250721143037.20983-3-pankaj.patil@oss.qualcomm.com>
 <21c75060-eb8b-45f8-bddb-816fce787240@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <21c75060-eb8b-45f8-bddb-816fce787240@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE0MSBTYWx0ZWRfX8pss3r/jP+ro
 qkUgObe3IQFbyrXbh0p5DIBibmlMxxXUPMsl9JhILjQmp2JcGPBmcCrzov+AFWy88OK1T177G1g
 knlL51hlzBn6VPryD7TLeSj3OqSBPVbGE/cpjvV+5GhmH/eXbNHTmGusd92kQ5ZdT4EOqWDQR8k
 mB2dHMrx/Y1MTkheBwMDjssXQuvj30AIZ5hdv3r/5t4fLfDAqYnHUd14L+luzidKMbOaQ058xMA
 VkeVvlPegC3kl9mb2/C8OrAjjvpsOU/H2/N6Fj81c1ZbEUefY/OOdkL+126oVAEtv4gj8sh1AFZ
 ZfNpUR20hxRJDNoj1OqmENsMeERnX+RfpAnoFM+IWtKn/J05YvXEejGVjrM3vjFDOtvJ8fxO1Z/
 axu4O9hTpS6f69gM4M2mo/3VtNibA20Rvkk3DfQ8VQtVzhANQHxair7U+XrBMMietKoqDZ8u
X-Proofpoint-ORIG-GUID: oxddnMp2vmNF9E8CkZOpvWrf7s8vc0UH
X-Proofpoint-GUID: oxddnMp2vmNF9E8CkZOpvWrf7s8vc0UH
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687e638b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=TZC3DJ3nR-gMiTPXGEMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210141

On 7/21/2025 8:21 PM, Konrad Dybcio wrote:
> On 7/21/25 4:30 PM, Pankaj Patil wrote:
>> Add TLMM pinctrl driver to support pin configuration with pinctrl
>> framework for Glymur SoC.
>> ---
>> Changes in v2:
>> UFS_RESET macro updated
>> Removed obsolete comment for msm_pingroup glymur_groups
>> Update gpio count in glymur_tlmm struct via .ngpio
>>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
> As Krzysztof pointed out, your s-o-b is not part of the commit message
> (include blurbs under the --- line, which Git will ignore)
>
> [...]
>
>> +static const struct of_device_id glymur_tlmm_of_match[] = {
>> +	{ .compatible = "qcom,glymur-tlmm", .data = &glymur_tlmm },
>> +	{},
> Nit: "{ }"
>
> (no comma, as this is the sentinel and we most definitely don't want
> the list to grow beyond it)
>
> Konrad
Fixing the review comments in v3,
Formatting issues in my setup, will take care of s-o-b in v3.
Thanks

