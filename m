Return-Path: <linux-kernel+bounces-781458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B028B312BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2168A07FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A2214232;
	Fri, 22 Aug 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBDRRZ+H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F61DDC08
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854355; cv=none; b=PMqxZnPTiZUqflp2Ju6VvC3F4wnVc7sqKns4dovFZsYl/lep9dYD0gGOBx/6oGmdotzCJnbUW+IX/OHcvrQvEVC26uU2yPI869nrquBjFCoZFhGOIBlQhB+ufD7BYVFllNHkycei20wqesuGPll5LzLYZmKIoIVmyQw4/0hnWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854355; c=relaxed/simple;
	bh=v6k5RWnZnRqmPJ73pd1EMHbTJmMfnyZBSuSPtczMxQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKoOd11l+Dj3AI0e49RRWR0YdY7kVSnKCtIfzpdWuOEo2gV7LIJUKV1ytsUuuUA2bgDSAeIZ2lgX8nwCa2m7VgGrivEQChzRi8CF0BJ+1DfGrmPMobrlZy1D8SIWtqfry1x6J9Jt5OB9Oxxpy0xfjSBbkCFQLHWJiZv956Ypsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBDRRZ+H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UIlT027215
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UR8YTvAoFiE7uKP9EFgzqtNd9BlRcDjah+SNG7rFzDQ=; b=jBDRRZ+HBX2UQimW
	WkaIb5r8nv1RvU3YDVQxzw+rMKYZP5zD6xsLPPpgCl+ToW2+6EBx4OKR61YW+oBL
	Y9j0x4DNkSJvoD1EtP9nVSMN/7CIyHb/HO9Wt11u4PCA17aCZ/JuSAcwYk5EHGKa
	4JKFmezsDUp74aLQpBt0aOh4mQJAuN8sUHt/LDRx+NJrdCTuWqeY5PLgxmU4v6L6
	uX/RSSmhP+1L0AwTXs4jPxM6LT8UJbuRbWtcEHLjFd+qjbxd9G1eV6rewEM2NsOP
	JGh8p7+HyJi4hT7FkCyel9ZqM3u0JPdxuxSRC6HHGkVkLhgox8vMwqxobVFiaPOA
	MR/qYw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298nqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:19:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109bc5ecaso54679291cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854352; x=1756459152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UR8YTvAoFiE7uKP9EFgzqtNd9BlRcDjah+SNG7rFzDQ=;
        b=LR1G572WhxjFHCKIlt+1AY+GnsbP9Vr/xJo7I2GBNzQkR0Ouw4cHHQcFdH7DnKxuNZ
         jZTx3FqOAjYQYZ9BPxDka0RGKjMETV1uc3HwY7WobyhU8CW62LUglLyyCLfD+NuQfBVX
         647wYNfBY5Vlr29YuP65/dDfstxa1dnCUE25XGZWNflAg1tCRV3pgyfFDqAc03DdiNzb
         SDnYK52g3uaZwnIQxGxfmmmJgu4IsVtnsSo4VuVFXpxTT19hM0DLB6pR/cmGw46mzjDz
         kg3K6dwYqqPBdfjCLL6AvXWS2T6ufpBUX0xhtaJud0A8qoaFTKrOURt0JqsbiegGSzsO
         mF+A==
X-Forwarded-Encrypted: i=1; AJvYcCUxSG9phJM4VFLDh5+0et9e0LXr33yYWT62xqTRVettMSEkdmMGQfVbTHd5mgMP3j3rHCJpMJrtPcFFOgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJYjMyz54xk7v1tsE5G54OKetf/LzWLlv0uVYpeeVq5s+9G25
	1pJZLgolL0Ad/nzbpiIbKIPOZRpj0M24WpmUAmMb3tzIAChu1pZk0+wtL/NbdmG6gop3bjyc3xX
	dwTuzWS6e9pDVTqBdNhT9GCuaWekwrYPgHKe7N2oME8oiwZ8Np1XACR865k3gxnN6rfQ=
X-Gm-Gg: ASbGncv6PqmSLuXNQ8PPeFMuPwl+wfow0fw1Ex69J+qSOe48rSdUH97+vleo77bD0bI
	0ktUJdq9Dp1oZYkZ72EZNsEIa/b7dhsrQnpPJ/HZBSbVULI2WwPJw4yvQw+PNHeqZCr7hr1viHj
	Cxh7+d5mSEH/5rtiPnDpP2EPsvDR8RvtJMolECDvskh7UUEZBgM9TXyR5EZcKv3KBcCo0aoJ0j5
	4Y8D7jaI5LBSXU71VRz3pLJkvabJjVQgOpJKTX2ikvKW/De+IIvnCcfmY9K8koF+0C52DyJYkGD
	T8I7DyRbffOUZIl3OBvXzMuLQVx0c1pWFDHmIX+7R2MtBaZX3x04lIny3NFMq/CqYuqiOpZBnzP
	c9g7F0IRTMM8a07f3Xw==
X-Received: by 2002:a05:622a:1353:b0:4b2:8ac5:25a7 with SMTP id d75a77b69052e-4b2aab75c87mr22539901cf.80.1755854352008;
        Fri, 22 Aug 2025 02:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhQe/0qT5qVOaaQF4aOu6Jtxg+P2oHtaij6naoDV2P2u2q7XUfpRoxorEfQKrlbAq8zOb79Q==
X-Received: by 2002:a05:622a:1353:b0:4b2:8ac5:25a7 with SMTP id d75a77b69052e-4b2aab75c87mr22539701cf.80.1755854351366;
        Fri, 22 Aug 2025 02:19:11 -0700 (PDT)
Received: from [10.207.49.70] (84-253-220-51.bb.dnainternet.fi. [84.253.220.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f32d1e17csm101972e87.17.2025.08.22.02.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:19:10 -0700 (PDT)
Message-ID: <8aa65fdc-d5a1-4a81-bcc1-8d953fa0ffa8@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 12:19:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-ufs: Add regulator loads for SM8650
 and SM8750
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, mani@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250819222832.8471-1-quic_nitirawa@quicinc.com>
 <20250819222832.8471-3-quic_nitirawa@quicinc.com>
 <ger4kizeltjwalfuwu4dpfjiskrv2okgo5c7d6n3pb24yaxgfo@nkcndblyx3il>
 <b453b8ff-a460-4ccd-9019-aed746a7d52d@quicinc.com>
 <ukxv7donvkulgci2dwrokuflzxzeyh4kohoyja2vywropntxnb@qepcssbe4wpc>
 <9a38ec05-f7ab-4241-ba47-0d514b79e808@quicinc.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <9a38ec05-f7ab-4241-ba47-0d514b79e808@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a83611 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JdIsBVl79nXNK9flUcZCTw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=9j3tyaYXLkDgBcrGQc0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Jy50gehKUB0rIR6oEgWB29nYfnEX5EFc
X-Proofpoint-GUID: Jy50gehKUB0rIR6oEgWB29nYfnEX5EFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8b9HxGHxTEfz
 Agwfs3mS1oLb7SeLlq2vKaZFkcO/d1kbyLoxT9a9kJ6zMpaiokz40HmoJQRxRgI+BQMcxyXwTs+
 +Hm8yoNRiu5gyovt2WYBC79TrekVNnUwA34nzPB/dTzyyG8ogipptt2lr0Z/ouU7lypJ02QtcP/
 XogjrryDNqv3E1MafYvTGQNXQpsRm/3VznaDyXEgcPlfsHbS1evfJ68KtNDLRAfx7Sp8tuxE5YR
 hJIY+JWuQ/Qm1fC2Soee5FLvONxJhUKDiLJ8X1oPie5yScDbdffYPLbNtNw/dTcORJxbYtn5kM5
 krc5PcgIT7SlYoeAKoIG3O8q41tjmS6tP4PbKjbhfwiyjfr47O21nlk9K3ROaZL8wBZqBTnK8dy
 2nU0UWxueBRZR21H/6svgTyhd7VXDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 21/08/2025 19:02, Nitin Rawat wrote:
> 
> 
> On 8/20/2025 5:24 PM, Dmitry Baryshkov wrote:
>> On Wed, Aug 20, 2025 at 12:07:57PM +0530, Nitin Rawat wrote:
>>>
>>>
>>> On 8/20/2025 6:19 AM, Dmitry Baryshkov wrote:
>>>> On Wed, Aug 20, 2025 at 03:58:26AM +0530, Nitin Rawat wrote:
>>>>> Add regulator load voting support for SM8650 and SM8750 platforms by
>>>>> introducing dedicated regulator bulk data arrays with their load
>>>>> values.
>>>>>
>>>>> The load requirements are:
>>>>> - SM8650: vdda-phy (205mA), vdda-pll (17.5mA)
>>>>> - SM8750: vdda-phy (213mA), vdda-pll (18.3mA)
>>>>>
>>>>> This ensures stable operation and proper power management for these
>>>>> platforms where regulators are shared between the QMP USB PHY and
>>>>> other IP blocks by setting appropriate regulator load currents 
>>>>> during PHY
>>>>> operations.
>>>>>
>>>>> Configurations without specific load requirements will continue to 
>>>>> work
>>>>> unchanged, as init_load_uA remains zero-initialized when .init_load_uA
>>>>> is not provided.
>>>>
>>>> Can we please get configuration for the rest of the platforms?
>>>
>>> Hi Dmitry,
>>>
>>> If you're okay with it, can I merge the configuration for the remaining
>>> platforms in the next patch series after I complete testing on all 
>>> remaining
>>> platforms.
>>
>> You don't need to test, finding MSM8996 or 98 might be troublesome. Just
>> fill in the values from the hardware documentation.
> 
> Hi Dmitry,
> 
> While implementing changes for all remaining platform, I noticed that 
> the "regulator-allow-set-load" property is defined only for SM8750 and 
> SM8850 within the PMIC PHY and PLL device tree nodes which means that 
> even if the UFS PHY driver is updated to vote for this configuration on 
> other platforms, it will have no impact.

If I remember correctly, on other platforms we don't allow setting the 
load exactly because consumers were not voting on the current/power 
requirements.

> 
> Should I still proceed with applying the change across all platform, or 
> limit it to just the SM8750 and SM8850 drivers? What’s your recommendation?

I think, we should proceed, then once all PHYs get those votes we can 
enable load toggling on those platforms too.

> 
> ===========================================================================
> // Device tree:
> vreg_l1j_0p91: ldo1 {
>      regulator-name = "vreg_l1j_0p91";
>      regulator-min-microvolt = <880000>;
>      regulator-max-microvolt = <920000>;
>      regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>      regulator-allow-set-load;
>      regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM 
> RPMH_REGULATOR_MODE_HPM>;
> };
> 
> ===========================================================================
> drivers/regulator/of_regulator.c
> 
> 
> if (of_property_read_bool(np, "regulator-allow-set-load"))
>          constraints->valid_ops_mask |= REGULATOR_CHANGE_DRMS;
> 
> ===========================================================================
> //drivers/regulator/core.c
> static int drms_uA_update(struct regulator_dev *rdev)
> {
>      ...
>      if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS)) {
>          rdev_dbg(rdev, "DRMS operation not allowed\n");
>          return 0;
>      }
>      ...
> }
> 
> 
> Regards,
> Nitin
> 
> 
> 
> 
>>
> 


-- 
With best wishes
Dmitry

