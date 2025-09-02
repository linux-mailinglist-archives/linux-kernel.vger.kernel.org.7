Return-Path: <linux-kernel+bounces-796075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3FB3FB95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7401C7A400B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6826A0AD;
	Tue,  2 Sep 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EgnZ0Y/q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24015228CB8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807301; cv=none; b=pyqickTdf0YQIeQFCY2a8ZxViGUg+jlsg0nrQKnCliR7xVzV5fe7/ki6ul/j23Inus9cxt5Svt4/1I4JYKB4StbOGzDXO8ZSX3u0F4q0kARq/Cgwp2Jx4DjwMH0bJGgr5HrAIzBQ4crb8NttSY3pAAfjO2aJSe+K4xR4zSEvChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807301; c=relaxed/simple;
	bh=+JpjsGOPnsruEpgBEzVnmy6AXeU90/5N3+cp1l9aa7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m15wWicKyf535PQ3RzYvXOn04ND57a00/ENBuc+dTPuoJC4Df6flXFVI0gPNOP2TaR6Ck7EgWoBVNXUYh/gwbp2bJBAxEYB0ctcT2xDRwBflw9lRlB3FgpS59zrwE/XX5DU+LJ+XD26SHCkZzQ2OkcHiXYHguvDr4ZBopjU0CmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EgnZ0Y/q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rtg9021463
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 10:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BwC/nawaLvi9t0RWv3QL/WI5
	Jwj7NSyP50cGH4NSFis=; b=EgnZ0Y/qJrBtOT7pfzw3X0lnweFwVU3o/TrdLXjQ
	jxt9wT4FNSUh+xWLhIkCUvapyU0lLJqblPdXtKh1kS5PXOox7/uPqmn48zvwGCQv
	MhtxsM2BQhmtXCTEY2NDkhU5z9RxqjneuECPSIPT3GRPJ5h75Vc7PElEzeMfIWT5
	pVHuwyWGUwArJjPlKSXp+dDF1icHt9zXVIe2PIpHJSw9Jyt00cgOqBw/SEssFp05
	3LrdfNfKGrEZ7ZZpyl6luQDadY3wEJ7x6jQMaeIqF3y4HJoZKFqnu2XPgNEmgzhr
	ZWyfKSoc9coqt1uEaOKvFTkpFfTMXfqOV7cKNeiNcGKyBQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8ryeuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:01:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b327a79a30so61384181cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807298; x=1757412098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwC/nawaLvi9t0RWv3QL/WI5Jwj7NSyP50cGH4NSFis=;
        b=qvjYhlNhC3VJg2v90RHMCQ8HLidhO5B0z/FncWcPVBGzdBub4WDnzVKn1VN8TSjgA0
         a6Y4Dre68z7elHJhUNIUPOTlj/mHoG9HuvZ4uYTBwyIRsQTyKgQW4G1abx/o7IAjdPG3
         acjLBDOl1iW9ntIAXaeaenJw8sLhR1jiooCOLIYbX8Y3FXblCqMxIyP5KoyVvamgsSKk
         kdtTAVJRad8o2IkFosPk/vr5u2albW2ZsXTPJpoXMmA8QCor9j33bz6mBHuv5kB4V4EF
         6yHyr9mduRw6R606J6uwYfU1luEvPA+LBsASuRbxzbqJlnKciajgv76UQxI0xKA09WbO
         Rg5A==
X-Forwarded-Encrypted: i=1; AJvYcCWOu+uHO6ei253XhDFL6BhySWZfSXw3k8x0nJiXBxurfdmV3hWaYzvWyeSzVb8YvoHLF487uSMGPFeH8xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9UCBoJte6rVdIjDwQLXVNlnrQPy+ww51/IWM/+KHt7OWh/UL
	TDVwIjA5VYNyQIpmDiT4+nOST27oUnIftVX1VrgyP+oq96jZfxTPKoJwaN+h1egwBW5nrJ29rus
	T8yHTcDTkojmFOudqGnWYXIYGoH0Yl1NvKkqOc4RPBw3siDs27SG1jFbNvck/aDOyeT8=
X-Gm-Gg: ASbGncuO2OhfZ31TIq2UJdekG4/W1dDXiqu2MOGX9pFtug12n4l15w4a31anN4VtNO3
	GrgbERb+hh+2lGAbYwIwlDZOIhipkNl1hhsu1bgu/E/CRZMuOpjwVkcZj5auKDrWFu/sl4lL0aq
	KV/GqTxtqt87EV8fWrv+a5Ke+WxM26Hnr+iCc3UNZDRgUSWFZgmc/Oia1jlg5E0q3koGMK/01dP
	LOrolXhgbPGKJ5W4dzwsSXabGBv7i1107jp/kKUivc2vmtHpBSzafD0313OuMQh3RKGbuiqZNv0
	XDta81qtxrm/Ne3/yDlft5nPNZzLpRZiSAhNzfEDlFTZsuRIkyCNFVMKwaDqYik41t5qYMd43nB
	B+yP8OWHCplE5HxuGaQrIoGGG3+sNWbsyTdAgvWzsef53d5BvsNGY
X-Received: by 2002:a05:622a:cf:b0:4b3:479d:85de with SMTP id d75a77b69052e-4b3479d8a44mr19164061cf.70.1756807297738;
        Tue, 02 Sep 2025 03:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIzhdTdKaG+HoZjO6SOOOHS8+U94QR+yYF63Rf6q/hpnZhrkWYy2UVMLS/EJe5SAHyG+zmqg==
X-Received: by 2002:a05:622a:cf:b0:4b3:479d:85de with SMTP id d75a77b69052e-4b3479d8a44mr19161411cf.70.1756807295614;
        Tue, 02 Sep 2025 03:01:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56082790204sm565117e87.77.2025.09.02.03.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 03:01:34 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:01:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] dt-bindings: display/msm: dp-controller: fix
 fallback for SM6350
Message-ID: <ysj4ndb4twcvmlxb3marh2vktxxsup5l6ioljdgzlod46uimh2@pkgta6r3ydqx>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
 <20250829-dp_mst_bindings-v7-2-2b268a43917b@oss.qualcomm.com>
 <20250901-arboreal-gay-wolf-bcaaec@kuoka>
 <qy6c2gundpbz5ixqpt2hefzfb56wcrzcaclqwg2opof4zc7lep@dpc3nv6usurk>
 <24999a53-ea5a-4823-a84f-2ca0ca184bb4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24999a53-ea5a-4823-a84f-2ca0ca184bb4@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX08teKE+pbfbJ
 8VUe/4a8B/ABImii7Ew+xEkghjb2RJMdZWyZogrY92SlHV11JaNkxZ2xrWVriEAd0VEv/xN60xn
 aEfa53ipQeUbELG8c7O9fhUvl6QmLm8BFhGfkaPWkH7f+/uJNytG2lnFV+fJARcQsPZx4Mm6VGd
 yvb8QwJX747PUjDTcjKhnmaMKmmVF2EQYmBdc4QufkB33970DzU5ns5kQvaN9vMYo3ZKYJS0iFg
 so5rz9mlLODMAywWisIrm5zndG9AedomRdcMFyeYYNdBTbrKL0ByUa5Nre8EPzPiEeXtakUqxhS
 PAAIqNGf4wbTT1cqdFf/wjBnmTB/47+OEWvEnE+8XdFaiV20LLUgiYMs7F1HzPvVewMZsE8rv8F
 8OR8HLb2
X-Proofpoint-GUID: FHUmQ-DtjpiZ8YJmHmT_r6_qhcbztWOv
X-Proofpoint-ORIG-GUID: FHUmQ-DtjpiZ8YJmHmT_r6_qhcbztWOv
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b6c083 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ZVPz9Q7mt2jYMwHyQ58A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Tue, Sep 02, 2025 at 08:04:54AM +0200, Krzysztof Kozlowski wrote:
> On 02/09/2025 06:03, Dmitry Baryshkov wrote:
> > On Mon, Sep 01, 2025 at 05:45:49AM +0200, Krzysztof Kozlowski wrote:
> >> On Fri, Aug 29, 2025 at 01:48:15AM +0300, Dmitry Baryshkov wrote:
> >>> The SM6350 doesn't have MST support, as such it is not compatible with
> >>> the SM8350 platform. Add new entry for SM6350 with fallback to SC7180
> >>> (which belongs to the same generation and also doesn't have MST
> >>> support).
> >>>
> >>> Fixes: 39086151593a ("dt-bindings: display: msm: dp-controller: document SM6350 compatible")
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>> ---
> >>>  .../devicetree/bindings/display/msm/dp-controller.yaml     | 14 +++++++++++++-
> >>>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >>> index aed3bafa67e3c24d2a876acd29660378b367603a..0f814aa6f51406fdbdd7386027f88dfbacb24392 100644
> >>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >>> @@ -31,13 +31,25 @@ properties:
> >>>            - qcom,sm8650-dp
> >>>        - items:
> >>>            - enum:
> >>> -              - qcom,sar2130p-dp
> >>>                - qcom,sm6350-dp
> >>> +          - const: qcom,sc7180-dp
> >>> +
> >>> +      # deprecated entry for compatibility with old DT
> >>> +      - items:
> >>> +          - enum:
> >>> +              - qcom,sm6350-dp
> >>> +          - const: qcom,sm8350-dp
> >>> +        deprecated: true
> >>
> >> If it is only about bindings then there is little benefit in keeping
> >> this, just drop this case.  However you cannot drop it from DTS, so this
> >> is a bit pointless.
> > 
> > Our plan is:
> > - land updated DT bindings, describing MST clocks on MST-enabled
> >   platforms,
> > - land updated DTS, adding MST clocks where applicable,
> 
> This part breaks all out-of-tree users of DTS.

User of which one? SM6350 or all DTS?

It extends the ABI, so no, it shouldn't. We add regions and clocks,
existing users can use the previously defined feature set.

Anyway, is it about adding more explicit note to the cover letter and/or
commit message or would you have any other proposal on how to handle the
issue?

> 
> > - land driver changes, keeping legacy support for non-MST DTs on
> >   MST-enabled SoCs
> > 
> >>
> >> Lack of MST support is not informative enough to claim it is not
> >> compatible with 8350. For example if it was working fine via fallback,
> >> then that statement is simply not correct.
> >>
> >> And it HAD to work fine, because there is nothing binding to
> >> qcom,sm6350-dp.
> > 
> > It is working fine since currently we don't have MST support on the
> > driver side (nor do we describe MST clocks in DT). It's true that the
> > driver will have to handle non-MST DT for SM8350. However I definitely
> > don't want to describe both cases in the bindings. SM6350 is not going
> > to be compatible with the MST-enabled SM8350 schema.
> 
> The question is rather: is SM6350 going to be compatible (working) with
> MST-enabled drivers.

If somebody implements e.g. U-Boot DP MST support after we land DP MST
bindings, I would not guarantee that. SM8350 will already have second
stream clock.

-- 
With best wishes
Dmitry

