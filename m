Return-Path: <linux-kernel+bounces-620916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D36A9D151
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4C1C00F30
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64E187332;
	Fri, 25 Apr 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j/Z0vcEy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E772D78A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608621; cv=none; b=bzDQwuWr+zLhgCPQuluI53UlCePgvaOwVXnvV49KOjBRl3pfWmY0lcpJPCxTNXFBLMdvxVHoMQEI+Iy9w9w5F/HdkmyFonQLfxpL2SNQAFJE52kFoDBRt99eQnSH/0MeCVn91sA5LmF4PXCWUGi9B0fAnXOrnIRUr2zA07tmBvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608621; c=relaxed/simple;
	bh=0gGZ81N4A9C8aEn4uz+ebR5itI9/Zkg/y5zmyTShTrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmHjZvfW0ibX+uvNDWhUq2VOaADLP4A6/w7lRKwOvxrNbfIKkvDCCKwSjA66m8H/6W5FFb6JEomHjAbNQoa5UaLGzmLdEaWrJYaKWhT22VrfAON+Kvxto4Xmp5TK5oBMolC53oslkUq5Em6JrtJH9H6kJLJrgMttuZTHJ2rINss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j/Z0vcEy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGJqV1004013
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AvM+02wHKQUUk7PA7Mt2UgaPJ57vrere5Ms7BkW9B8I=; b=j/Z0vcEyWcQcdfKe
	tQH6rGJ0IjjjqbKQoer2edUDnY0/djYpqywKNHBhTYgQo+U1lPaE4GO4+TaDBvBv
	7BWgLmNKwM0ebitgBqbBIRNZN5DK/ZKJuvsJaX+P5WBBvfwM8cSAZTyn8mUvt6pE
	4sfLjIq2F7SlZhM+ENM8EZ5jYoCkbqkPCoauKmGee55Q3ntEqUdMgfb7hh8A5xVJ
	LuhULkZ8RNdR2QImBQQ5EfseG5Fwe8JiV9K4Fgbac0kRrsYGz1N2zvO7zRNcqu6i
	Rf47di1mRAqqTW2OqhR13bH5D8Hq9CDoHFHj9ZgpHxnBD5dBZl5aA+K/D2ZUf9gR
	QIgJpQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh2a5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:16:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5c77aff55so667017585a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 12:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745608617; x=1746213417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvM+02wHKQUUk7PA7Mt2UgaPJ57vrere5Ms7BkW9B8I=;
        b=vFpBTq8IBsyI1TmkWuQplwC6zlpWR6kSvGaJpkYJlNNuahhiAA5AJQ+rXb+sc0JuF9
         3Xrtwt6n5ylXb3uL+20yl+2e1F4rBfkQ+yvhPfHVOA1x4DywNjpLauarmSSjT5m6oLCk
         RNfL9YDMhXgc7QVMFlCGPBLRUumDQg7XeeyckdWY7Ef/6d3APuSvW73jMyyAC6eidpaJ
         dS9rRDTG0FDhQUQxmnHvGefdnkVDH9D6FqCCDLuFTFqgbovvDGM9o1Lzvx9pbdr9mCkE
         zPsknz11gORK6sgd66Vgxzfgz+e+Becpw9bZtr1fIGy+HuK0/wVTKcDBnfOUeioabahj
         LmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCxkq5gY2WbEyfsrtgRZD6x63tuiFPoVZXO9fMiJGah0GJF3e65pgcVx3sU7xHokfHAoy+mfpD3F1Ff6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiWBTAW7Qb3diggbOcCT9wfv8BdZQplVShwP5ys1jkQMdUA4v
	+IFCbEpcgC2iKhJOo7G3OBaum9kjogOYPEu9QXo5QWzBQRaE257J4QWWeUU1fTn3BI6R2RpKfnE
	jtDuymP23d/8cBBXXGDwY6XHBVMSxVj//QNZSu1RXNriPGs5rvqRumXEgyh+ASpM=
X-Gm-Gg: ASbGncti06F2tJQ/jJ7opU7+slG/RW7UZdO+NJPKFs9F59iKslTIq34sM3c25n+yMLZ
	nZKhfAf0FKKCHIlRdJZ52yTfbvNbBNQSC2oT6BFTJPFR1IWpwK2d7HaKuQJjJTr0IvguefNlTSE
	3ZG3GPv146ydELj64XdHSbanicnv0enOzhhsy1e6U0Zyp7v1jXj1szQu+hZzidcVsVLGJo283Cd
	xtMXqdnexAhy2ygvYtqk8Rt6uLAD07/q8H/Fv9GH7v6+rK6Zd3QXtZRsAloyxd3v4Kk1H3Qsitd
	EHbtsZsS1xy4m7dEu5rx8tISLkBrdTFTEBYttOBirAs+VZe9T1JYjDqaJcg0QzYme29KTc++VDk
	=
X-Received: by 2002:a05:620a:439b:b0:7c7:b60f:ebd8 with SMTP id af79cd13be357-7c9668711bdmr135700485a.24.1745608617669;
        Fri, 25 Apr 2025 12:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLvVYIuCfd7N47SYf7k0yis4BdYavV24mRBREqRBvjDFmYGO5KeapM1HaXCAvzIXJi0HNW8A==
X-Received: by 2002:a05:620a:439b:b0:7c7:b60f:ebd8 with SMTP id af79cd13be357-7c9668711bdmr135694085a.24.1745608617219;
        Fri, 25 Apr 2025 12:16:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb3983fsm706745e87.60.2025.04.25.12.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:16:55 -0700 (PDT)
Date: Fri, 25 Apr 2025 22:16:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robdclark@gmail.com>, Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 3/4] drm/msm/a6xx: Get HBB dynamically, if available
Message-ID: <dhn55tynono5lvk7sxhcrww37mfty6pyzn52oaoyefmbm3ivh4@6qzhjyte6ntv>
References: <20911703-ab4e-4eb2-8611-294730a06d2f@quicinc.com>
 <CACu1E7HDmQXDNtEQCXpHXsOKPCOgrWgo+_kcgizo9Mp1ntjDbA@mail.gmail.com>
 <1282bf58-e431-4a07-97e5-628437e7ce5f@quicinc.com>
 <CACu1E7GwMCt6+JJQGgSvJObTMMWYLPd69owyFo7S=sxu_EEsUw@mail.gmail.com>
 <16845de2-a40a-4e3d-b3aa-c91e7072b57f@quicinc.com>
 <CAF6AEGvyeRLHFBYmxkevgT+hosXGiH_w8Z+UjQmL+LdbNfVZ+w@mail.gmail.com>
 <acd1c8dd-286b-40b7-841d-e53e2d155a61@oss.qualcomm.com>
 <CAF6AEGts5rWvgyZy8RtAaUOsad362AG-uNjxF9vyj4szg=b5Bw@mail.gmail.com>
 <6233171a-2964-4d57-986c-d3f1725eacd6@oss.qualcomm.com>
 <eac33841-4796-43bf-affe-31901344c5ff@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eac33841-4796-43bf-affe-31901344c5ff@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=680bdfab cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=qLch0_GepN5255_xqOIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 72ZPVEOKU8kRgBaaCzu_WJzxc3N1JjEn
X-Proofpoint-ORIG-GUID: 72ZPVEOKU8kRgBaaCzu_WJzxc3N1JjEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzNyBTYWx0ZWRfX540z+lzEY6W+ 56JO2pNBaBtcb6xQTIveassUvwoT16v1WQo3BR5fLzubrBhYtlY6SEBV7nITcuErxZBMKcKeZb6 j5tX+fVHpFZQkr+sfZ2/1urawn1ECIUnWatxdzwaMaM+Aa1D0/NDuBsLS0qoUxO986WEGLtUVC6
 gFhKFbJgILgMHjzf8cejR0uHqYAF19QuI02QFdKnfUgxAJ4XhCMi+RqY2rLax0hKeqmPeW3Mcqr lddXoMuC5MmMpNB60LrMQbQwrYqJ7O+LdXcSqlq3bYxowcOUOzgOXYGpe2cq34LEW4C/iGV0b+b zCkcAMZ/pCY1NOX5LmncQIN0Ry6wm/tOa4FspLW9IwmhK2sMvT6t36+PP7zKYqyWmtSoPufMTSe
 0E5w30nes4YD+MeO3ltzxO4PLmnj+705z4X+edANR8HnHmP55Jcn3Pf5FHBPcFxJr12u4Rtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250137

On Thu, Apr 24, 2025 at 10:28:58PM +0200, Konrad Dybcio wrote:
> On 4/23/25 5:23 PM, Dmitry Baryshkov wrote:
> > On 23/04/2025 17:55, Rob Clark wrote:
> >> On Tue, Apr 22, 2025 at 4:57 PM Konrad Dybcio
> >> <konrad.dybcio@oss.qualcomm.com> wrote:
> >>>
> >>> On 4/21/25 10:13 PM, Rob Clark wrote:
> >>>> On Fri, Apr 18, 2025 at 9:00 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >>>>>
> >>>>> On 4/18/2025 6:40 AM, Connor Abbott wrote:
> >>>>>> On Thu, Apr 17, 2025, 1:50 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >>>>>>>
> >>>>>>> On 4/17/2025 9:02 PM, Connor Abbott wrote:
> >>>>>>>> On Thu, Apr 17, 2025 at 3:45 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 4/10/2025 11:13 PM, Konrad Dybcio wrote:
> >>>>>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>>>>>>>
> >>>>>>>>>> The Highest Bank address Bit value can change based on memory type used.
> >>>>>>>>>>
> >>>>>>>>>> Attempt to retrieve it dynamically, and fall back to a reasonable
> >>>>>>>>>> default (the one used prior to this change) on error.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>>>>>>> ---
> >>>>>>>>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 ++++++++++++++-
> >>>>>>>>>>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>>>>>>>> index 06465bc2d0b4b128cddfcfcaf1fe4252632b6777..a6232b382bd16319f20ae5f8f5e57f38ecc62d9f 100644
> >>>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>>>>>>>> @@ -13,6 +13,7 @@
> >>>>>>>>>>   #include <linux/firmware/qcom/qcom_scm.h>
> >>>>>>>>>>   #include <linux/pm_domain.h>
> >>>>>>>>>>   #include <linux/soc/qcom/llcc-qcom.h>
> >>>>>>>>>> +#include <linux/soc/qcom/smem.h>
> >>>>>>>>>>
> >>>>>>>>>>   #define GPU_PAS_ID 13
> >>>>>>>>>>
> >>>>>>>>>> @@ -587,6 +588,8 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
> >>>>>>>>>>
> >>>>>>>>>>   static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
> >>>>>>>>>>   {
> >>>>>>>>>> +     int hbb;
> >>>>>>>>>> +
> >>>>>>>>>>        gpu->ubwc_config.rgb565_predicator = 0;
> >>>>>>>>>>        gpu->ubwc_config.uavflagprd_inv = 0;
> >>>>>>>>>>        gpu->ubwc_config.min_acc_len = 0;
> >>>>>>>>>> @@ -635,7 +638,6 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
> >>>>>>>>>>            adreno_is_a690(gpu) ||
> >>>>>>>>>>            adreno_is_a730(gpu) ||
> >>>>>>>>>>            adreno_is_a740_family(gpu)) {
> >>>>>>>>>> -             /* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
> >>>>>>>>>>                gpu->ubwc_config.highest_bank_bit = 16;
> >>>>>>>>>>                gpu->ubwc_config.amsbc = 1;
> >>>>>>>>>>                gpu->ubwc_config.rgb565_predicator = 1;
> >>>>>>>>>> @@ -664,6 +666,13 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
> >>>>>>>>>>                gpu->ubwc_config.highest_bank_bit = 14;
> >>>>>>>>>>                gpu->ubwc_config.min_acc_len = 1;
> >>>>>>>>>>        }
> >>>>>>>>>> +
> >>>>>>>>>> +     /* Attempt to retrieve the data from SMEM, keep the above defaults in case of error */
> >>>>>>>>>> +     hbb = qcom_smem_dram_get_hbb();
> >>>>>>>>>> +     if (hbb < 0)
> >>>>>>>>>> +             return;
> >>>>>>>>>> +
> >>>>>>>>>> +     gpu->ubwc_config.highest_bank_bit = hbb;
> >>>>>>>>>
> >>>>>>>>> I am worried about blindly relying on SMEM data directly for HBB for
> >>>>>>>>> legacy chipsets. There is no guarantee it is accurate on every chipset
> >>>>>>>>> and every version of firmware. Also, until recently, this value was
> >>>>>>>>> hardcoded in Mesa which matched the value in KMD.
> >>>>>>>>
> >>>>>>>> To be clear about this, from the moment we introduced host image
> >>>>>>>> copies in Mesa we added support for querying the HBB from the kernel,
> >>>>>>>> explicitly so that we could do what this series does without Mesa ever
> >>>>>>>> breaking. Mesa will never assume the HBB unless the kernel is too old
> >>>>>>>> to support querying it. So don't let Mesa be the thing that stops us
> >>>>>>>> here.
> >>>>>>>
> >>>>>>> Thanks for clarifying about Mesa. I still don't trust a data source that
> >>>>>>> is unused in production.
> >>>>>>
> >>>>>> Fair enough, I'm not going to argue with that part. Just wanted to
> >>>>>> clear up any confusion about Mesa.
> >>>>>>
> >>>>>> Although, IIRC kgsl did set different values for a650 depending on
> >>>>>> memory type... do you know what source that used?
> >>>>>
> >>>>> KGSL relies on an undocumented devicetree node populated by bootloader
> >>>>> to detect ddrtype and calculates the HBB value based on that.
> >>>>
> >>>> Would it be reasonable to use the smem value, but if we find the
> >>>> undocumented dt property, WARN_ON() if it's value disagrees with smem?
> >>>>
> >>>> That would at least give some confidence, or justified un-confidence
> >>>> about the smem values
> >>>
> >>> The aforementioned value is populated based on the data that this
> >>> driver reads out, and only on the same range of platforms that this
> >>> driver happens to cater to
> >>
> >> Did I understand that correctly to mean that the dt property is based
> >> on the same smem value that you are using?  In that case, there should
> >> be no argument against using the smem value as the source of truth.
> > 
> > It is, but is done by the bootloader that knows exact format of the data.
> 
> Right, so the only point of concern here is the handwavy matching-by-size
> logic.

Kind of. The other issue is several cases where GPU and MDSS drivers
disagree about UBWC config. I think the plan might be:
- Introduce UBWC config database, ruling out incoherences between these
  drivers
- Parse SMEM and the non-standard OF property, verify both against each
  other and against the UBWC database
- One-by-one drop entries from UBWC database as they are verified
  against the readout values.

I understand that it is a long-term plan, but granted the issues we've
had before (tiling screen corruptions, which was fixed / worked around
by lowering HBB) I think this is the most viable path forward.

-- 
With best wishes
Dmitry

