Return-Path: <linux-kernel+bounces-893401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23157C47456
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 044034E5849
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEE718CBE1;
	Mon, 10 Nov 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bfILjCMM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VcHQQbdS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D01B6CE9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785708; cv=none; b=YelIFfYrVWUWWsE50M1pruexuZrMOxBlS9NV+SuCCVBALzx+guEhAbOpvn935ymqP/+urGbr/qA3IZk0wRuPaYxapbe7pFXobPePyYaZkV3DfItGcjtcVOeju+XC4Hsl5C3+CDoR1cTeL2/xh46e3IAX2NMsV+ujYBJku82q2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785708; c=relaxed/simple;
	bh=EGsoQ001UBEf7yxavI8ZABTjuEBgxU+e7Nmf8KHADdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJ5dFXieEm5K9/WTa6gwoaiVrrHvE1aMUCBBBrQG14Az/L1iEUxb6/UxGrtcnAXcjjQWiuJAAP95Z3hCedj4QC+GmlX49ah1mmY8JbqRg8qOmV5aWPkdDXTKdT763E8qJ3tCJa/b3esZ/SbAMVezl4Y5mvmSKiMag8w4iM8Q4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bfILjCMM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VcHQQbdS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACmB1x2407079
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HYPBMmPMrl74VcBNfaZK6P0Th/jmEX2D4ZwvG4S3pO4=; b=bfILjCMMjXR9ll5x
	cD6jtvxG6fD6T52Kv9T5eFgtaACKtgd2pxJrJYkaEhSdnaM0G+6qMOnEyxVw2yen
	nmcvAkwEwJggDXfQcRGcs/MT52ntoYywDMTghWYOAfQDTvazF2IIX6muvRRypGTt
	x8vgomIVGqrxB59uYFQIxGMx3TZWKb3fmh+SmVuUNocYD5V7cwCQsPZaZs5F2/RB
	z5OlpnaqX899nLntx4ApLqe42zY1vRkWgA0SMYsI+iKlLn2JwNGALeD+zMx57m3c
	hyhkTX25wcuYf3cNxj5vL8BW4eS4tRJhRvSUdnKFh8C33GUfWnHecHjyk0tCeDsj
	yWYvEw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd9eyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:41:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295b713530cso37021825ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762785705; x=1763390505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYPBMmPMrl74VcBNfaZK6P0Th/jmEX2D4ZwvG4S3pO4=;
        b=VcHQQbdSM5Bp4nMKLj3Hc9UaVVR046iVSoSkob1KKcJwtrp+WjxuC+yDr8CoBWhTNo
         Tl1o+VOhbRfJ3peDiS/rn77KjRlmykkeY0TCiU5rhLgNnQwSzDjGkrdTEo2NllTvEOsv
         QE/mMHmtx+HtLAqh5Pqr998Be7rGgGZbhATpZTAiouFc29aZz3e1AdhEma0yQYHV+mgb
         uBpAr47/nHruu7gXpw3xlfNp82A0OYXDXopy+Iwytmi9CMPtmhXIjxgX1YE8N2wHqnll
         MJPVoejaMKKWtBrXISS3Jc9ORP//KhXelIdOwWs5iNd1+272MV8fGvv5gp+erhcgRdsl
         XfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785705; x=1763390505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYPBMmPMrl74VcBNfaZK6P0Th/jmEX2D4ZwvG4S3pO4=;
        b=eeXnvBSz3RlwH082dGwIPnrpoIAVyVG4vIcYPUC+jKohRWTdJgkuMi+ZppW89Q7+Ph
         dqcth+8KS5+nFBvhKoM2KOXIMSHn59pPztijv+RQAMhhsxaZPXnPWNb3fpcNcxrcOXVZ
         zSBE41ySV0JkCuZhTyDeDlBttC6eD6fJKSuqmjnbUcG3s9ujrz5/9BM9kaWSDWAnCe1F
         Jx2r/u+420aJ8WAU8SWd9cFdvFC/TF/MiVPOR4H52grV7qc58v3QTmzMMKq4rpbuxm7c
         TU8eJs8tRuz6X3ptTj9QneKS6gXI0Ec5zi3XAm0SfEEoglZ0X1PWfh2donPYOeW+1XOI
         qiOA==
X-Forwarded-Encrypted: i=1; AJvYcCUexIcfw6w+d3NS/k2An3dLMu6bxR/3g/D4qaQHR4xZk82EX4bIP2MarJIN0Ikd0v5/LEGdBlLYIVSjA+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5H+sqfRSUpq7fUUnB942vu6a9fNHvnpsVPw8piNmcWYPh7uuK
	fwiGupB2BzOr6Pr1rLyG5NiJv0Zr3cmkjp6OYYdSxwHPtZiCBe6wr48zCbxUqEDRKXBkuUiA6bm
	CMC+SxiEm2IZxPNRXizVJgFBQpAhlPbs6gpoXH8I+CeIyikoYzt/afeEl39Rn6JKO1nE=
X-Gm-Gg: ASbGnctB4ZHiAxP7fLp9+Gg1VuXxR4/pygLXs+Eexu227vbftyU9CuZ0pNOvFMfPktR
	ApWATNapRj3PyV55cW0qRk8iu2ZoMW834B419vOA4ui+CvmW/tomN33CQpQ46FtZGbger9yFOJu
	hZoAm/YsN6x4ejLIPlTcRU+VZOjaoBZqd2cj1FRjfc7Kx8pxxTIV09rw+PT8avQXE8zJFlJOjBY
	beKSIglt8TSPxrcCB7FaEZ0jlESrb3O1KJbZwgVfL/FsCTcd0Dnqv6KkLarN7bmVlHTTO0/GMXY
	camUJuC5ayawm2cBPFR5e+T79DPYlGrpYuZ75VuUJPK2D6g6haagnBAQbUdMNEypPmh8Jzb/YL/
	9nXoXMsSjsNJWM97uDDv2zy1hHfjdNywQ
X-Received: by 2002:a17:902:da4b:b0:27e:f018:d2fb with SMTP id d9443c01a7336-297e540dbf8mr103670135ad.6.1762785705551;
        Mon, 10 Nov 2025 06:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzUGI3gfRP1roHcIKhz5BZsgRD+n11EwhNGgQ9IIMPUd06GGUlB6wwr56gPGTWX6jx/IrBZg==
X-Received: by 2002:a17:902:da4b:b0:27e:f018:d2fb with SMTP id d9443c01a7336-297e540dbf8mr103669785ad.6.1762785705031;
        Mon, 10 Nov 2025 06:41:45 -0800 (PST)
Received: from [10.219.57.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34370ec58d9sm7675580a91.6.2025.11.10.06.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:41:44 -0800 (PST)
Message-ID: <821358a8-64ed-46c9-3fd4-538e194fa5b3@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 20:11:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v17 07/12] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Content-Language: en-US
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
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
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Xin Liu
 <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>
 <ec5c9da3-297f-4a07-bb95-512cc607917e@oss.qualcomm.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <ec5c9da3-297f-4a07-bb95-512cc607917e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GnrDeKwG-lEcMgVng8jFJN94JrYsgqCV
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911f9aa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yV86LA_xD0RmO51t7RcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: GnrDeKwG-lEcMgVng8jFJN94JrYsgqCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEyNyBTYWx0ZWRfX9MGlJI016f3R
 iov0ipfD6UGDNY+nGO6UznlgdD84SHgMDq+kyN71EVeluXlm9zoYMduV6eql30+wyAaYlOkzskV
 DDxNJ5linOgUzqjFOknY1JfvXEjFqiZwKfsyg9s7pGepdn6CFr5MbuBVix76EkndIsGBVYVAgYY
 BdrlgnaN84gg3QkIgWId0u+mKtFqVJkuKzfsxUO/MlRLg056Q2aQYYjN++Bnp5N6UcsXiqwakAV
 RZz0rqeLFNpVzHUhmdAhJKPQDQj/tCMN5Zo9dWSty7GZZCXCFu7de+v3Va50GjOA4H9Cw8fZPWa
 LRv5VO+XKd0RvWsxaN2rjuyrZ4FC56+IsXLdHAnxwSOBdnpW6DzwKDNZFqy1GeV0+g+/kxwsMjf
 MN21SgxLYGc+EIIZRcjZ9SFbkymVXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100127



On 11/10/2025 10:10 AM, Kathiravan Thirumoorthy wrote:
> 
> On 11/9/2025 8:07 PM, Shivendra Pratap wrote:
>> +static int __init psci_init_vendor_reset(void)
>> +{
>> +    struct reboot_mode_driver *reboot;
>> +    struct device_node *psci_np;
>> +    struct device_node *np;
> 
> 
> We can take advantage of __cleanup() attribute to simply the code paths.
> 
> Declare the variables like below
> 
>     struct device_node *psci_np __free(device_node) = NULL;
>     struct device_node *np __free(device_node) = NULL;
> 
> and get rid of the explicit of_node_put().
> 
> I think, we can take up this an improvement once this series landed. But if you happen to respin to address other issues, please take care of this as well.

Let me evaluate this for next respin.

thanks,
Shivendra

