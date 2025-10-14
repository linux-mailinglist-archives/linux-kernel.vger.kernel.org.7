Return-Path: <linux-kernel+bounces-852220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC39BD876C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCE3F4FABD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEEF2EA486;
	Tue, 14 Oct 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ErIKlQPZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F729993F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434597; cv=none; b=BlOoepWue349d8hqbvcp78ix1rrlIOe/c6nC3QJfjSwNo2q7sEhZWv5hFKNlwBJxmGz9PoEqcgHS1Lxy5WNAfSo8EUpyIP/+XtCFq/Z/tJ76iZ1VBEMDc30jeu9fNThd6WX6ZoL5klYSNyvEPom9TswYqnF96c4Tw42BMgP1NaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434597; c=relaxed/simple;
	bh=j0urYs90kPTFfhj6XsGDs3vJJ8OV9y18S3hd/gfBDIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcJEJCvHpcIdVKK3F9/1kvFyiqvbEwY34V4aUJ3wxnaUJzKP2LyBnk9+/i/HNqCaXoM9cy1p5Lxye3Txp/t4d3OBRLeZJMGsuuWM7E+ewPM0rgVoXKiaj+AFfb0ZKABJ5Oc79dYRmK40EM2y9HOhNIbZRtBxzf+z9e1Z/ttkxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErIKlQPZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87aK2017040
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RBVC+5/5ABafrPQ+4V6HCdRE
	5Qnnq6FFZbvfYQ5jpT4=; b=ErIKlQPZQMOrg/qnmzemszHado82YkEIlTM5k+Ng
	SHK2L/l+BM4TdVruAnnOwh8LzH0kStRIjZ5qkSTSaiSf045I47edY9lctn284X+Q
	03oOOW1yFDf9mWP6ofnHDlBXtZb0dHMCWPqIQkyTv2QoOCe+HJTG/hTbmg2pdCGA
	hGhlxuzTlViBKodnkYMk7zdDvgUvD2bN8xtZQMN+pt0Xi47tAkukQ70Igwukc822
	m929KjMPQdhFHrA3qZL/UBaA0n1Mi4/pso3yqeQddVyXj6927t41f0jeGLMiwpgm
	r4GkKnnqbzrhepUJUqgzK+meRFin0yLc5Wr8CxcP2NC1WQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd900un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:36:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78f6250f0cdso234720466d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434593; x=1761039393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBVC+5/5ABafrPQ+4V6HCdRE5Qnnq6FFZbvfYQ5jpT4=;
        b=Os9u/zoN5vZmTTC28wXN1wqchObanxlX+xSSqDzlyogCxiVembq4P9PRDHTNm7E+nZ
         RVMCcVCdFYR3ijwMY0dWtOavFORLRfz369XVAagzUOwvlYZxLgJbdZEOT7GsT9N7UYmm
         cB4ZcitAH1gz3gANX+AuttCwArhIcTMwzOiZn+DbJV0KWyP8udzlUMSHfOFiajW4x4P7
         vfXSYuOEtCA+hWHOcQEiVYsXpWDuV9PRPhUIOhG9qrmqlEQoVAe0VrE5Px/Y3fvegkR5
         sr7erekgu01kf06iSXpP0NygRu/4auDnXvyMTVJpm00fpCSX07tbRrUQsJ3KseusR37v
         TOXg==
X-Forwarded-Encrypted: i=1; AJvYcCW0YZTYdseNqimDY2kdByDrtBy7i4PFCfQfsM85qZ4F9Nc0oKJ4u2S2LqtFbMfvcrn4oe9rqMMJHp48MZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPw9vpnTUdBoeUNdBRKasslHAvkQLzASKz26x986oVT7lC4+7
	S7P5h8XUQbecve3v0bL+uAzn8S/phKDWzvA2U10Y2Dn3lMc9Yrras0sgCzMqdIkFt0T/BXCjKoD
	diAj/HxafQiyKEia59XpDIwbRUx8MeS8ibXlRWmaT+TIj1brhrF57VkbCfjONDIJBB9o=
X-Gm-Gg: ASbGncvErOEAUiEE89AwV44fsYZtOdc1TfHBQZ8ypwM58m1R6Uwmwb0SkFpQ6ETZbOY
	NGq0WAg6R7LJZxiLmXp4ilC++n3wPJdh3umPzZMFRRTOwxtG8W2tHzMHyVSIob7F3qQsPQJxff9
	GGfygZjJ6J0TGzVhhvweoJZ4BbJ7r62ic6c2s0wBVp8JgidqcN2XbEh+YCV1cvRiFWV6mY6LyZc
	TuQqujx5nFIOM32cSd7d7birWh4TLXi4kjvOrPIYyFM4Cj/BXFbz9XFhJaQZzqSrYcGMpiBkkWi
	zDD/bEkzIdMATODDd7DoqOXW6BRFza2JYYRs+UBOox9+Ip+ZK1reas+yDZq5a8ZGZkoogVG5CyC
	13NzCIcXEfgHGojZ+4/3JW6266nmY/6oa9j+onZEB3oa6Lpwf3IcQ
X-Received: by 2002:ac8:58c1:0:b0:4db:9c75:abad with SMTP id d75a77b69052e-4e6ead675e6mr362283381cf.74.1760434593434;
        Tue, 14 Oct 2025 02:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERrjyZhC8WYF5QIYCGn45rVK5JIGxvjZP4pOiPgTYBQZVXJXtDIxnFvrzcK8U0iF1Mgp1g4g==
X-Received: by 2002:ac8:58c1:0:b0:4db:9c75:abad with SMTP id d75a77b69052e-4e6ead675e6mr362282921cf.74.1760434592949;
        Tue, 14 Oct 2025 02:36:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088584806sm5055024e87.123.2025.10.14.02.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:36:32 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:36:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: qcs8300-ride: add anx7625 DSI
 to DP bridge node
Message-ID: <acfvx2smpoco3hakkhas3w3fybu36it65lpelbuigcyg2f4thh@qjbtzgxcsrxj>
References: <20251006013924.1114833-1-quic_amakhija@quicinc.com>
 <20251006013924.1114833-8-quic_amakhija@quicinc.com>
 <vj3pwikzgbflzwqwkbvdfac44llinsmrhrqnvu6gx756xz4h3e@2lspa6zx5xgr>
 <3597f849-fe69-48a5-91cb-7a0bdc9f3e7d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3597f849-fe69-48a5-91cb-7a0bdc9f3e7d@quicinc.com>
X-Proofpoint-ORIG-GUID: Xe9_hleOIvzxPNd5sbzzXrMs8ilPWMpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX+zVRzn2VxjrS
 /bMvbFIgBYTJoCggfX+oTJIFjErqm+pnKj65RcbPWedBNaU6VlG3dna2E9J5WfO/xNJA6l/VOqe
 iMcWKgU29upOeiiF7SPhDANJCOjTjW8j/rueZOVp9jxdlVqaCStYu3xYsEC/YGSdk9am2hEHRv0
 dApUSzDFufyGUGgUWigKPNuiLuH7PM6eAiXOFJnO6yO/GDwqbHHV2/9Qls0Gz2PAOV3r7SZoCjW
 hrHa3Wvi627WxQ6m+VKpS9pKlpjU5bDdHqOiykQFpKb/yhVzfpE9IhrXAe36Dd2r5YGMRzd8VIc
 nFAfMNX+xrdgQPTFFs3iRlpvAm2SDNqq1znDvIhVhPN6JEeYMgyZ5qrFDzVCrSiuTIfPQKmbKXt
 9tYeUUraPpBid1weFuiWbx8ApJEucA==
X-Proofpoint-GUID: Xe9_hleOIvzxPNd5sbzzXrMs8ilPWMpB
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ee19a2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=mWwphNQy6DiE2YH7zW4A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 12:06:13PM +0530, Ayushi Makhija wrote:
> On 10/6/2025 3:46 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 06, 2025 at 07:09:24AM +0530, Ayushi Makhija wrote:
> >> Add anx7625 DSI to DP bridge device node.
> >>
> >> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 170 ++++++++++++++++++++++
> >>  1 file changed, 170 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> >> index 891e49602c97..5d4040376857 100644
> >> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> >> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> >> @@ -24,6 +24,64 @@ chosen {
> >>  		stdout-path = "serial0:115200n8";
> >>  	};
> >>  
> >> +	vreg_12p0: vreg-12p0-regulator {
> > 
> > Why are these nodes not in a correct place? Also, why are they named
> > differently from all other regulators in this board file?
> 
> Hi Dmitry,
> 
> Will keep the nodes at their correct place based on alphabetical order in next patchset.
> Similar names I have used in LeMans for these regulators. We have kept these name based on the information of these regulator we got from SW doc for monaco.

There is a slight difference between two DTSIs. LeMans RIDE uses
vreg-foo-regulator, while qcs8300-ride.dtsi got regulator-usb2-vbus
(which is close to what other platforms use). I think we should also be
using regulator-vreg-12p0.

-- 
With best wishes
Dmitry

