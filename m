Return-Path: <linux-kernel+bounces-857278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD6BE6648
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E04C4F1BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E327A2AD11;
	Fri, 17 Oct 2025 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkHBEjPM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D29211F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678211; cv=none; b=oRbOH+U2XFR9p7eiO/IjJHWUmQV8K0u2Hl9kbk2VGQbrehWTZZqts3UKQW3/JIA6K3Jx5M+pdMzL2+5xbV5MpTDvr1BYFQ8pahalHv+HNiStgBC5aSPbyzHgdB8T2rRZ9bOGJQTadb9dK12/bQ/OVkbIxsMJP6hd/MeItxxNLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678211; c=relaxed/simple;
	bh=8CsWUb+Zq/G7HJ8BD18g+VNAJUOF6SIm3BWqUKXNUqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3F24sUcqVPUA4ZMTOoLMKW66C+G1Vrdgsqi6H5brewyK6HbDUPE94MjRex9O5Exr5m6iLIhC+wmuwNxtuyA5Jun7fBMRg1l6A0Mro5qcrRk2dqzx4Qyj754iAePEDWWHtyWgNCQqrlqwONcxcNi20RYjLLuoEew65x0dRAgck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkHBEjPM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLMXR006527
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2i3SzamJL4AYPJyTX0D+tVvBeIVOXOGLPmwZ6XLXzAw=; b=dkHBEjPMHL9wAjE0
	5upjym3ARatCxOz2kNM/uOm+afi35HA2Ma5DEdQuPpRhvUC6OKX8VNdPlIDk45YU
	RJ0ZfAyYmAVgRSbAAaJjpK3lNY/TrvW2V3J+efAGycFTDDuhBy9Lx1sqg6a1imIs
	dLGlbV4577mcwWSs55mU6/cXVbM8WtILML3laAVORCLApOvoOtRTwnBM1dbwtE8a
	2L8gjzTGxHwRAz6mEY4L5xzEKJf9R0qhlQPVTZrh3okG0uHomhBFq44pMc6rkrdA
	Eb4SUNk+PmjPLFVDAPs80bBQqlUE5IWIdBdA4fqtIiJ6gWI+9DLD8vHPUsvcCaF9
	6Y7RpA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff12w98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:16:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780f914b5a4so1669585b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760678208; x=1761283008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2i3SzamJL4AYPJyTX0D+tVvBeIVOXOGLPmwZ6XLXzAw=;
        b=N297ermAXSNuFx3GdkaZ6g7UNiJGmLXhN/eJel/ljoxGcny35XLhQYSFIn73bebspq
         jWsLV7qoShKOZsUsFlFCeq5XXZIByibNIzLciH7SuNRHlL/SJmwkMLc0U42yfEU9NPzd
         u8Ow3UJ0NYS8yB+9x0nLUZbOdZ3hVtSsZUeuxZGzM8U+IU7lK9NmOLh5EZvU0cO8M2fT
         SLYhqr0XKIhc/0oKplCh28TBDXDsTLGibVwe+Da9SPIQYJeOoPa9l5RqFHpVr25Z2gbB
         qboTZcQGrNw55+dEVx6QDIqaF8j/2bmaffpeuoVpfhTbMfdo60RpGqXo9trGIJYXGRPN
         6gjA==
X-Forwarded-Encrypted: i=1; AJvYcCWGQ7iM2uTxc5hmS1qGJ5qsEUIlg3ABdJLOThRbTHWrMJ4lyva6p+2KEwJ5hvdj8kDv3EDlMfusBSaq4BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNyHiypIoujm7TE1PYnDciWo2HZZiLcInPstcmVeBRNk/TQ7A
	2rX2r6FCDnw48YBszvYWMTCXUexn4kUZwnQlLGhmne6vRwivh/190CQrthj/dmCl0EJw/EniK+1
	sEdZWPoJA+dkk2pte+D13o/6tFUaPDnOmwxa17duT8QvBUTjGu95TJQFYtQSksyUpGJI=
X-Gm-Gg: ASbGnctvgh3mDU8ue76Q7+d3ntxcTFPdDkis0Eqs5o3eOC4+pV6xScTH9qqVeNJEAI9
	DPPwLM0s2t4Ypdop9sDqYANOG6sgBGxRXy6B5VTpc6nFnC80ro+c6k/JZhhskkoJpxtujFUj8Ao
	KYra4Q/CC2cLNPTtbZsfK+SJ7tkxTIIeFUKBtk2hOhHl8mz8IlXvEVb4776c70GnPXNRHxjgNc8
	jWkBJK3QnDsquCHFS0EHMokQriql8Dfirk8pGh+a5HDrayPbDQWsZMW2nfYMiFelgg3vU8ZT0kO
	RS4BaQzYj5SxO/g5/CfIL2zbBeMMwMJIIoGS5fA36Z1/89cVq8oTkZK5yT6nLMt79syzZ63Ixg9
	Y7/FVZ6M/0k8JDHCd7oY5OnD+Jnc=
X-Received: by 2002:a05:6a20:1611:b0:334:84f7:564b with SMTP id adf61e73a8af0-334a8536f64mr3070534637.23.1760678208038;
        Thu, 16 Oct 2025 22:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/y/lA99xt+x1uOg5ljZ5MzeXPQPV2BT5QU7TifJtGK4mBkRRMuRFx49x342nAHdOiJhOUaQ==
X-Received: by 2002:a05:6a20:1611:b0:334:84f7:564b with SMTP id adf61e73a8af0-334a8536f64mr3070510637.23.1760678207531;
        Thu, 16 Oct 2025 22:16:47 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096740sm24387908b3a.38.2025.10.16.22.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 22:16:47 -0700 (PDT)
Message-ID: <37f54b76-a274-4ce2-aaa9-88ba0eb84199@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:46:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_SM_TCSRCC_8750 from m to
 y
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
References: <20251017-update_defconfig_tcsrcc_sm8750-v1-1-34b1b47a0bda@oss.qualcomm.com>
 <30390038-0f90-48a4-befe-475cf88ba1fb@kernel.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <30390038-0f90-48a4-befe-475cf88ba1fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0Wv6sNez0bmI
 05bIX10jOCKpRSL3bR2yYg+hI/bceXZyHBDNuNpIAZLcmBPGSoV6FpXd3wF6BeqPoTsGIKtJyUW
 NrjLNPHyMVCcLGmqXcIl7c1aJYwKBwixGVXdBGC5ovVicrCnYOq+lzM7J8vCtF7dJ7yYQqbUK8F
 a+ui8SbAHHY4f8aWyqFLkLdt6KHSXwwVxAWl5NwqFIg5POYYTUrAuLvVckRj+ouam5qLwsxv6AI
 fH3cdXOrDTNfSSehC7Fv1YE34mZkFn3Y63lahutCHmDeWMxXV0iZbh8yPKQnYZGU8BciYESTZ8f
 KNZPlDpAQrQupAap0/Vr7T9y0QeS+7DYLwtYw/3Tg==
X-Proofpoint-GUID: yQDfjig-hWeO4UjvJawbyNrrrvTEpeYv
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f1d141 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eFfWDuD68qI0Rqvue3IA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: yQDfjig-hWeO4UjvJawbyNrrrvTEpeYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/17/2025 10:00 AM, Krzysztof Kozlowski wrote:
> On 16/10/2025 20:53, Taniya Das wrote:
>> The TCSR clock controller is required  during boot to provide the ref
>> clocks to the UFS controller. Setting CONFIG_SM_TCSRCC_8750 to y ensures
>> the UFS driver successfully probe and initialize the device.
>>
>> Without this change, the UFS subsystem fails to mount as a usable file
>> system during boot.
> 
> 
> That's not what I observed. UFS works fine, especially that it is a
> module, so no, this is not a desired change and explanation is not only
> insufficient but actually incorrect.
> 

Krzysztof, on Pakala MTP we are observing the below issue and it
requires the module of tscrcc to be loaded explicitly. This patch also
aligns to how it is on all other targets.

/soc@0/phy@1d80000: Failed to get clk index: 2 ret: -517
[   10.496570] ufshcd-qcom 1d84000.ufs: freq-table-hz property not specified
[   10.503660] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
find vdd-hba-supply regulator, assuming enabled
[   10.514548] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
find vccq2-supply regulator, assuming enabled
[   10.565955] platform 1d80000.phy: deferred probe pending: (reason
unknown)
[   10.573078] platform 1d84000.ufs: deferred probe pending:
ufshcd-qcom: ufshcd_pltfrm_init() failed

-- 
Thanks,
Taniya Das


