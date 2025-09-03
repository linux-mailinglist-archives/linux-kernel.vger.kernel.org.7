Return-Path: <linux-kernel+bounces-798780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9774DB422E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447AF480E77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D712831159A;
	Wed,  3 Sep 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CFVGfxqV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51285789D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908052; cv=none; b=MCCCi+kQNxM1bVywHYoNg1EwCxYBTsNC6kJZkkE2GA3MaHPyqLME8SxiW2PToj5wETGmeM2zalVaKMv84PHlEHg3nKNGfoDg4+AW7PaJVAeWrhyti6+xzzf7+x6rvdQqw9gCQIjU69AWY13rpHHBJ1hsWeO0VJq55bGCrAyiMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908052; c=relaxed/simple;
	bh=t3R4VcBPORWQP4a1txxFGFYIIPQ5pFRx1DiAIXKhZdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnHmZ+QL8EzVs7t0xdLRm5Q36JtejkECMDqyPiyzT4SXH057T1EeWEtRJvSUvWYVkLEkDwKjJpaJQ41Bj4TyXzTdqUQjuJ44D6oms+XfChZUqcOLjJ9g93s/szI+5wF6IG+JOb1va+YDHzzFNj+0hYDk8GfW4HTkkoNtZmh44EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CFVGfxqV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxPel017623
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 14:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Z6pj88/J3j1NKaodwkNXmQxi
	gRcyLxr517oZ55+1nuk=; b=CFVGfxqVsPqKflGUyxNKOIe0rLvur1zSQf2LpgzV
	+ILbhpQ0vD5AoJ7+LmJFdk6AHSfrSenkwAEsCZ+DbtBU64bsBOwqQF1RWuvTY7u3
	Rbjt+M/eTERLXCzecdEpMLPFnzObwrwUvK7Fj5aBVkGAM8J1/7aeTbKPShBkyjjx
	gpCTHlt4+cUB/nfSH4McgdMVB+jIWPkLI+cvNHkQfoXjt7Y1/YAqddjpM3XlrP1W
	lyhzm7i7qMIFOSy/C+eC+4mrBSuLC8bb/IK2i9qM8pVmNe4sbKEl7TqJnvwtUwyc
	qYaXegb/3vEHbjSe9rSinT5HrTClAeeXJM96kLIjMSNXaA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj0ey5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:00:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2f78511e6so61064991cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908048; x=1757512848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6pj88/J3j1NKaodwkNXmQxigRcyLxr517oZ55+1nuk=;
        b=BM5eZe54YiKUZvXyME69hodHnWuVa+7/A92O4anThtlYnCsibABfCAmMMecYO8Ofvf
         zIx6nafEVGXN2coFkjR089bsvMODrc5fWwAdwnC0EfYK717dOkrWT6bjXeHRwoBlYCgL
         96SMqRVEM0S11f8AiCp/P1BHmHqoTgEG0qHld71yDbpHOmX5OnOZwKHeHLRzZ7Oc6/d+
         ays5uJD2Vv8bw4BZ2BVXg0WtAMsLUEBS8Z3vUjsgcDytFk++30U3WJZ7aZFSRLM9LKK6
         s2Ha24kZz4skpeuya6toKnkw5wbyzdmg0ZXkzsiCNkP/mybZSQAyuBNv4LbQS+YfWv5w
         YNAA==
X-Forwarded-Encrypted: i=1; AJvYcCVYlaIsniLqRCTZueE1d3YaZECh4Fx8ZAqKxpe4dMw73/IhltIUxrW5YsX+2beeNWyCpfPPAl1VJMNsr5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmqC3fCWqQFYTEysPvTM4zzUj4PXwDDDL/pXsrBivnY4q7y5j
	b5b13rGpZBpVx6zy7OwpKJ+ck6kL43ISB2/4lBlzVFHDK7WfWK1R9m9WSp9dE/doAcGJS1nrYiG
	FS5dkVWSRy1Hjzzp3GtDjNWSRjJinUvw4BG5gUaf6Vmh+qDfPh18JQry7VFUPV38D6w0=
X-Gm-Gg: ASbGncvCDU9wDSIjWiG6wNPA5s1FfVA+at+6YPBPG52NpvkfeZmoaCpReJwXkSbScVy
	1QA8DIufKM5AnNeg2rnPVjjYj1V8zg8UhGw+BD5RuTjkhxL2o8y2zvjPWjvJbxyp55gWpdKG5A1
	PzO9Jqd6dP+BdUUs6fjwSJvkqRuyJeTZX/HkE8JLRXEzdmhVlB1MwT+eoImkQnAI6lqOZ+8qIKB
	G/z10qIYVtmPNLy1QS1pC/l7qN2Yh1APsAHjkKHC6UEjvIWtsKleGCPbIjOVXpd1y4B9chByCk4
	UtEQji9oCVAzKRLmukaup/Wjl5Ywy+V+rF5zyrPECPV8ig/mq5oS0h5E5Pr60+i0hAR9nJEf7i1
	d+qr0VDoDsarVrlrakCcHk0Bs0jJK/etPdFMjR7mPFvQ3A5CjUOa5
X-Received: by 2002:ac8:5e53:0:b0:4b3:48b2:aa9f with SMTP id d75a77b69052e-4b348b2b623mr70291451cf.50.1756908045431;
        Wed, 03 Sep 2025 07:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnDnwIQkCmFKK18oDjQbnACoTF/d8n+oT9VNWxZl8INMw0myHrJGeaehADC9LPm5hkCdYKhA==
X-Received: by 2002:ac8:5e53:0:b0:4b3:48b2:aa9f with SMTP id d75a77b69052e-4b348b2b623mr70287801cf.50.1756908041921;
        Wed, 03 Sep 2025 07:00:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90454sm10451921fa.18.2025.09.03.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:00:39 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:00:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
Message-ID: <t5pxum74q3fwf6wgcbaeaginjvtjfn357pkfswvafsggtmvxfv@jl5qjfhpmmow>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-3-97d26bb2144e@oss.qualcomm.com>
 <f11b778d-eba1-4712-81c7-b83f2cb38b46@oss.qualcomm.com>
 <exkrgx6rdotfrrsnklsd7zk4ydehsk5vaoevibpqisyq2dwbd4@sa4kgnuexlna>
 <f169be5a-faa5-4824-861e-27bd2083b9cf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f169be5a-faa5-4824-861e-27bd2083b9cf@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX4tMTwa+Ll4vf
 cKybM+6yaIOPpifzs6jYom8WqyRcl5op2+so4ScigLr1oKwkjHAN+RkGgnV4P8f7tnTV0q8eD3b
 uibcrQ7uHJv9wNeV4V1zo2ZtqISgmcOO/kVaP0IARIrjOiqS8GIwC8e1FZy5kDyi4iJiOhnmCZi
 bOsMIh/fnvlIsh+ytZQ7/jZJxcl2L3i7SDNQyPMUknTB81QrQv+igtsI5s0Wyu3Va0Td98Yv4df
 ZFDXfYp8ySRyshEvi1g9VNOdS3EB3TF41ukUuePruRLCiIJrpJqWkXAW36tYb42P3NsdtO36cbL
 VEjnWuKBJxzsiRQWLxF1st6+hD4nlGJ4CuJgdSuUa6fkQlpFXwgfPtqn11rlS9UckCjBvICxJV0
 r7yd2BwW
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b84a11 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=I_3-zorBrfLWAkoykd4A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2ipn-rd1jXo-po6NTtKkOKosgMg11rl-
X-Proofpoint-ORIG-GUID: 2ipn-rd1jXo-po6NTtKkOKosgMg11rl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On Wed, Sep 03, 2025 at 03:36:34PM +0200, Konrad Dybcio wrote:
> On 9/3/25 2:39 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 03, 2025 at 02:26:30PM +0200, Konrad Dybcio wrote:
> >> On 8/21/25 8:55 PM, Akhil P Oommen wrote:
> >>> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> >>>
> >>> Add gpu and gmu nodes for sa8775p chipset. As of now all
> >>> SKUs have the same GPU fmax, so there is no requirement of
> >>> speed bin support.
> >>>
> >>> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> >>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 116 +++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 116 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>> index 8ceb59742a9fc6562b2c38731ddabe3a549f7f35..8eac8d4719db9230105ad93ac22287850b6b007c 100644
> >>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>> @@ -1097,6 +1097,18 @@ ipcc: mailbox@408000 {
> >>>  			#mbox-cells = <2>;
> >>>  		};
> >>>  
> >>> +		qfprom: efuse@784000 {
> >>> +			compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
> >>> +			reg = <0x0 0x00784000 0x0 0x2410>;
> >>
> >> len = 0x3000
> >>
> >> [...]
> >>
> >>> +		gmu: gmu@3d6a000 {
> >>> +			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
> >>> +			reg = <0x0 0x03d6a000 0x0 0x34000>,
> >>
> >> This bleeds into GPU_CC, len should be 0x26000
> > 
> > gpucc is in the middle of GMU, see other platforms.
> 
> This is not the case here

Why? I think GPU CC is a part of the GMU by design: GMU accesses GPU CC
registers directly from the firmware.

-- 
With best wishes
Dmitry

