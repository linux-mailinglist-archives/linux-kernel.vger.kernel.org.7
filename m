Return-Path: <linux-kernel+bounces-867172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC6C01BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097741AA1C30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6632AAAC;
	Thu, 23 Oct 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aL/NA2Lc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52F1E3787
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229413; cv=none; b=SMFESHhlAvO9blRiRor54z9Ua7UA+DjYWxVba2Fm9mq1Zy2Cgh5C+cEOgM9LV6kLZlwa9e1ck7RtTU/nbr0zNnKBY+a8UscB3eVrg4EmBJJvlWhF/pAvoWS5KcM18kHDH9h0tXgCf+4RJE6LadDBulocicNI7GgpanCfhtaxnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229413; c=relaxed/simple;
	bh=F1cgo+7/vye/dP1rUI0JQIx0PF45Y1SGew0xi6mK2BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxSHQOY1YiJdgQuXuvBY7Fh8gs2tzF8RfNfWyYkazG2ZlVTq6FCe4uG8kXoxF3490v6KObmMFRQvOgFjeQ93A9zIlqFyLo5teecnzB6DGZNe5Da9NoJ/+d5R29D4IIp3g7/U4PCIyyy/LAGqSIK51OZe5MtU05LgbHDmbo3cHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aL/NA2Lc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEGj3E029729
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FA91y8KBUO4yhV25FdwhubQyZiPrjcasBtAmZwi3V70=; b=aL/NA2Lc3/ljPfoP
	lLeXT+Py0a/r3/HbBV0VMnS3CLMvLjonmjRYWDLf0Vcd9U2UOYPUkXS5K6xMEGms
	sN42I1lvQ8X8Xx48WqprCCKRSm9USeVu2q4j/klqQDCCMTvN41DW87NSb/9Zw23B
	OjL9Md02aUJSI81b4AAp01FSI4UYyqnCm2gmMe9ZnoTGvdLy4TBZTGfFvvdpZYx4
	/cSqn76H1KYT1apWVmu3AWhZgEIokfUlsbhXU1Yjgbn3mYp1lbUyFoW6PGWd3Qk/
	fqFGdX6JRZVmkW3RverCKRy98guzrzmN1dxGvMaUhr+x7RhzLDOHBMOnQY4RdCQ/
	DPxpbg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge8pap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:23:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8bb155690so12781301cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229410; x=1761834210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FA91y8KBUO4yhV25FdwhubQyZiPrjcasBtAmZwi3V70=;
        b=GR1a+cuUuYtHSYNH4+Kw7MuGDlxHhl3WEMUWh6EG887/wf0ycLx9URLV9qlrIZjiMP
         Rts/zXv3GCijK7uKSdPNkREH9Uaa/AHEiI9EgBM9ftw6D8K9eh4SBoS0PmKi+aHGgvQM
         94Af7wQ8k1tZQC4jyr22OcJnCBRkOFjcqlr01sKdIE6+g1LH8d883MFhmh0CXxeF5Y0F
         0vfoaxw5U0tbEzwZqNnLxCkw+yeRpS3DGcjAD3JWs++biqnMt3QayJ9DqOWN8lKlnZ7g
         95tBiDIWfQcmytdMZc71hUuVMjjMDyBybfQalOeNeSXHUl1nM11Nmec8BZPuzmf/Pm0c
         IxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUFoHGWF2W/xirknkDQUhs7M1UaQgLa6ew2/DxximQcjVyBAdP6bfvsEM6mdvi5ewOl1v35Y8w29wOWMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vqR2hu0PDcyFzcDJSg3cX6GZVowysFFFT7y6NbQC6sX1NYe2
	4JmlzwRQqObDeD+XOM262zUDZdzj6SJlgdg2thkLYZPhKKpB/tlaX3H6XaCkCA8gM2AEev7O4si
	tZubMbkQxcbP9DdV7H2T6W9wYI8lged6kuBxu5WvWtBy+R1i6yVPogrtsR4Xlapft6eQ=
X-Gm-Gg: ASbGncvFMS+VKcwyakBoKzTm/AGwei87ORMS54YkfZ133dOjx/wCeGBanGOWVAktjGx
	B9oUB3kjxbr/j2Fay+C23ua1wdgyWq79vGnqTisj5M0aREWQU3sn3bPL3B9kFaWz8wQJS56vYLv
	+tiIoSMSHkKI/wTmjA/HsKE1pTbAz4nHSZdW8YYnQm0BSJ+j0eq1oiOzoMhohc542CpjbYFq2vy
	Hzk0zpw+v1Jy0gS5kSYPQB7AXMRiCJnY/lf9XTQkwmnFEPNfMOqUNEHAhl72W/XvT4jJx3rTs+K
	sUiBtiyE29dTeFewobMkhWVlqugKFd9xFRgqxl4cu8vDEZmblFmZxJreTAW1fz+CtcV/FViPsvk
	uG1kay43bKGa6yGMM8XVfalfk3oaet2sEyMsvqRD7RhFbyrbkQTNx8qml+Z83EO/Kt9UmXHtH1H
	dTAfIiyCWepQ95
X-Received: by 2002:ac8:5ccc:0:b0:4e8:a416:95e5 with SMTP id d75a77b69052e-4e8a4169b8bmr317127601cf.69.1761229409515;
        Thu, 23 Oct 2025 07:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiz4qw3pTudhYYiN2tAR6mmdOeBX2RP+NnhmDODFeqeER7hF+zhUWWqTSs258QYXdg5Oy39Q==
X-Received: by 2002:ac8:5ccc:0:b0:4e8:a416:95e5 with SMTP id d75a77b69052e-4e8a4169b8bmr317126921cf.69.1761229409023;
        Thu, 23 Oct 2025 07:23:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4cd12e9sm770286e87.32.2025.10.23.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:23:27 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:23:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm630/660: Add CDSP-related nodes
Message-ID: <4q7rtc7kdfpy7pyqa4eztjcgpraonxlx2hxcrez46msqthjtmt@f43oyk2imi5c>
References: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-0-9ab5f2865a6e@mainlining.org>
 <20251019-qcom-sdm660-cdsp-adsp-dts-v1-1-9ab5f2865a6e@mainlining.org>
 <5hbc24lihvau7s2opzcxxgxkzugmbqmdtqwy23m45j4po23lnh@jyjlbgfjaddw>
 <f8daddfd-e0ec-4acd-afc5-cf0969aebb9f@mainlining.org>
 <0ca0bdfe-b228-49be-9ef7-71482d372e0f@mainlining.org>
 <141450a6-4578-4823-b516-d180eaf3ccc7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <141450a6-4578-4823-b516-d180eaf3ccc7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX7rfhgaFII08F
 x5ssCDhz1rP/piyyVPfWFE4JqfZmFdlG7/h+2bHFPm9jqwQDofvkS4qrbEOrWJEDbljHsbUlUjS
 uDk+vw0/IQEqQVu3LiXc30gZRcbmbmizLBbQNGt1mHP+5JhtioBJkHwxiWEU6FPwhvmuR2fOGof
 QxTx8kEHzPecfqmHPzMssnn8xcDQx2hEs9gi9NTyVbkZa7cyhSN6XC5rLqopRiANf5SPto1CvQ1
 MBXdYcwqo4JP29tSR8dKXMIpRt4uWf8PJzRmv0lsTJC6wxEfYGtV3sSnHYtx70PWHtrhdWSI+El
 ce9qpNDfFCP/PZGTveUMzei/72yBF613DR/NuWPz9a6PTfoT6bZgB8BdJGF78hDuiYjV7eBOi1z
 TOWl2YNijajdB1zH1yrk/sIbmPWNKg==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa3a62 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8
 a=hfPBaJTrTtnCdmrs9_IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: rQlP3fQsYCa6TfYCKNlJZaRhaDlVzhp8
X-Proofpoint-ORIG-GUID: rQlP3fQsYCa6TfYCKNlJZaRhaDlVzhp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On Wed, Oct 22, 2025 at 07:17:51PM +0200, Konrad Dybcio wrote:
> On 10/20/25 5:42 PM, Nickolay Goppen wrote:
> > 
> > 20.10.2025 18:27, Nickolay Goppen пишет:
> >>
> >> 20.10.2025 16:14, Dmitry Baryshkov пишет:
> >>> On Sun, Oct 19, 2025 at 07:27:06PM +0300, Nickolay Goppen wrote:
> >>>> In order to enable CDSP support for SDM660 SoC:
> >>>>   * add shared memory p2p nodes for CDSP
> >>>>   * add CDSP-specific smmu node
> >>>>   * add CDSP peripheral image loader node
> >>>>
> >>>> Memory region for CDSP in SDM660 occupies the same spot as
> >>>> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
> >>>> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
> >>>> cdsp_region, which is also larger in size.
> >>>>
> >>>> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
> >>>> related nodes and add buffer_mem back.
> >>>>
> >>>> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> >>>> ---
> >>>>   arch/arm64/boot/dts/qcom/sdm630.dtsi |   2 +-
> >>>>   arch/arm64/boot/dts/qcom/sdm636.dtsi |  14 ++++
> >>>>   arch/arm64/boot/dts/qcom/sdm660.dtsi | 152 +++++++++++++++++++++++++++++++++++
> >>>>   3 files changed, 167 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> >>>> index 8b1a45a4e56e..a6a1933229b9 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> >>>> @@ -563,7 +563,7 @@ modem_smp2p_in: slave-kernel {
> >>>>           };
> >>>>       };
> >>>>   -    soc@0 {
> >>>> +    soc: soc@0 {
> >>>>           #address-cells = <1>;
> >>>>           #size-cells = <1>;
> >>>>           ranges = <0 0 0 0xffffffff>;
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sdm636.dtsi b/arch/arm64/boot/dts/qcom/sdm636.dtsi
> >>>> index ae15d81fa3f9..41e4e97f7747 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sdm636.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/sdm636.dtsi
> >>>> @@ -16,6 +16,20 @@
> >>>>    * be addressed when the aforementioned
> >>>>    * peripherals will be enabled upstream.
> >>>>    */
> >>>> +/delete-node/ &cdsp_pil;
> >>>> +/delete-node/ &cdsp_smmu;
> >>>> +/delete-node/ &cdsp_region;
> >>>> +
> >>>> +/ {
> >>>> +    /delete-node/ smp2p-cdsp;
> >>>> +
> >>>> +    reserved-memory {
> >>>> +        buffer_mem: tzbuffer@94a00000 {
> >>>> +            reg = <0x00 0x94a00000 0x00 0x100000>;
> >>>> +            no-map;
> >>>> +        };
> >>>> +    };
> >>>> +};
> >>> This probably means that we need to invert things and make SDM636
> >>> inherit SDM630 and SDM660 inherit SDM636. Would you mind doing that as a
> >>> part of this patchset?
> >> I'd mind
> > Konrad decided to do the split this way for some reason initially
> 
> This isn't a very good argument, but I think keeping it as-is is a
> good idea in this case, as opening sdm660.dtsi I see a need for some
> more cleanup work on this platform.. which I don't think anyone
> is willing to do short term, this is less invasive

Okay. It just felt weird to readd the node that we remove in the
previous #include.

-- 
With best wishes
Dmitry

