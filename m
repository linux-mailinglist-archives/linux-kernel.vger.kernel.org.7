Return-Path: <linux-kernel+bounces-818699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD26EB5955E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFAC1895E59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50ED306B2E;
	Tue, 16 Sep 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhgXC3H5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A7305E1E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022630; cv=none; b=atonMi+ruXdvBYhyRKP+KWwvPlMRfyPBffOWk6pEGJa9fZU9wpxlii1K7D2mOVnhvbJDDrkRimAIM8YS/0xUUUEKlSfQeuz9CyjDe1+MpQCOIu1f/4rH7D/IHVgSphrWT3m0iHPuwXtncco4spaD7s+yHEJ1qcN2NsFD34Z9gV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022630; c=relaxed/simple;
	bh=xn7ANSlqcAqHWO14s9VykRufGNwLeeuGRFzr+dBcA84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fokkIkKyIgVYG0ThVZz5iPdTAByFgBPkbM+1pZL7cnxQJ60/ateeEJB4ka4GYiwvuV2LlDt6enSLiS4MLaHd6DnPf2zsBCmb4d5OmmT0cb/p5B29AV0LzLsGJbjugbsnQ07WhFnNZiAZUJThkNy2s190WN/UrNxlKFGXRbg0T/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhgXC3H5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA2o2h005547
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8r+uRlaevPVdXlAyT4T9NwO2zYw30Nbmp0nZRslTI10=; b=AhgXC3H5SED8o8nr
	/sacaXb8HtYMysQNCcT0CthTAQZ9iWqMK2W7hleKFmth8FN5AIpPa9/X1aMhkiF6
	jv6UvKzwXjHITupz+xHy9DrwPiir7Klbv/7aqfaJ4I62h6lB2kqZn736ew3ccnft
	1bTGLV3raPmRJJETBKXjJUki6fVMeKrvnoZ8YvqrJ5qbunstQLo/rxqGOjthBKs5
	G117Uj9t7ShkuBJAd6NN3TCTS3c/Iru4T/B5ct5O89t3hGHnBjoymCqnk+2dmjrl
	jaG4Qa6tSggMYbHGp6bnCcK4/pLEpbwGsRVq/m0HiJ+AFP6R8QuVsdKJY178s511
	OcFZcg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u58mfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:37:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72023d1be83so162728216d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758022625; x=1758627425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8r+uRlaevPVdXlAyT4T9NwO2zYw30Nbmp0nZRslTI10=;
        b=SMy7rym1jQl2SZ0gM/yYpFeChT1T8Zq1fGbqxo+TUV7k636mbFE5LZCauWUFPC4GOP
         hpWdqPfI+35UR/NJ5WI3BRnSI6oE5LpLRSzO/P+zCyyxkIAEp7ZuadzjYJvSMvQVVnL1
         LJdtd+DJEGHhOUWymmeHJj8YLuNaOeOPGFt2keJQSJcxzRks9wZD6V+TpelQwjay58qs
         VpAlEMGFuxmGjckx3fDJjKfZ6Q3tpeU3pj1wQZMshpFO5z+Q6af4iU21/lkHhHxKPXHn
         SnF/flvXSkRcmYsbfJWBUu9k5SZTAoCDe2NOJ/1Rtcral4dKOeE/UPON2lH8GRO+8jJd
         ej8w==
X-Forwarded-Encrypted: i=1; AJvYcCU3y+vohoTmwuHQ751d83TEhdJJE+kbXZxSiB2tb/lVKg3XGk+x4Wrk2W6pnkdyFLgF+gCQDEFRr+kG7nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnxNiyO/YOwOG4Zp4LJJ7NPA2P0eJS3Xm1NrFCI/RO+XDIECb
	KF9BEUfUO3ddxaU3LkAbYLS3i+JsfOOvFuuGN9h2Lc5l20/rZNqrZpXxHTL3bAegcQB7X3WymZa
	RhRkNIQN+HAhlNeJhYoUoThHyeKoSucIBnMLPNM9gwTYXds92XH87A5vZzd/kYhDWRhU=
X-Gm-Gg: ASbGnctm+kOr1z+xYIFodu/jpmiTiqj/ly7tX2kAGHe3BLaONMQcSSZk4k2tPwedCqR
	YyYuH1H3TNS5psjenGKhCF2QoMNZCrGbMOhXy5Qj+70RWIKrerWX3ks1AgxWwe5gkt9tl/Mh8a/
	ss+p5ccAJwJMKtEmrDMc/DclCvSeSYZuPaem0lK7V4d0SOKKKv6YDFnWilVa6PJPTYtWQCnHBuF
	u9eRRPwYbXV8YCpEJWo3uAWv3pYldeVdcKlqu4p0ZuDYXTs67JRKuItpdcTZJzeCKrE1kjAB3r/
	leVzRq90rN39FH+AF+X0V70NsMcUzsV/mPXE18TFEuJcokTaAXDh0og9LdWCQFO6/2ZOM+0xsC2
	6zJK0UKkrh7mMjpIwhdVzJH2306rGDIGO/iUVasRjSnL57BTbi1Mm
X-Received: by 2002:a05:6214:4104:b0:72d:2745:e51b with SMTP id 6a1803df08f44-767c1f72004mr181805056d6.44.1758022625186;
        Tue, 16 Sep 2025 04:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrdj7CKBZutEb3X6G6Si0JxbfNPIbPU3VNg/diPoQkuTWBTcD8Rz2tsUYzQoStTeuysCm17Q==
X-Received: by 2002:a05:6214:4104:b0:72d:2745:e51b with SMTP id 6a1803df08f44-767c1f72004mr181804586d6.44.1758022624520;
        Tue, 16 Sep 2025 04:37:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65a3464bsm4260659e87.139.2025.09.16.04.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:37:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:37:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v2] dt-bindings: display/msm: dp-controller: Add SM6150
Message-ID: <lf254j35dxbvenodtexxd4fdlzfp3esu7fgakhekya66ce3tfc@7oe47nc2tjun>
References: <20250916-add-dp-controller-support-for-sm6150-v2-1-e466da9bb77d@oss.qualcomm.com>
 <5sg43rsun33i6bm3vz7io7yx2p4m7bmk5bnrnjg6u3zrulyofs@gyxtnfs4gvhz>
 <d302e71f-19bb-426f-a7df-c0d7854e97af@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d302e71f-19bb-426f-a7df-c0d7854e97af@oss.qualcomm.com>
X-Proofpoint-GUID: OfelZ6j4v9hczSr063_u_Qg9ermJk80I
X-Proofpoint-ORIG-GUID: OfelZ6j4v9hczSr063_u_Qg9ermJk80I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX+Aybw5WTN50T
 JWIuNnlc2Lb+FliuB2fj+H8Ao59hKl4QKVQpwia+wow++/jjz56SyL92N9ykhFVWbVcUEdKgkni
 kyzEQsaw9h/XPu7yk6U3yWJjMPXNRjvxhr2QyC1rsJ0cejeZ0aeP37esGsdFARDTh3Qo2SfVYgN
 vq7/Z4SiIjO5OvorhlCHIA9EgYSM+LDxFxw5mfZWBLu/dqfaWSnSnDUtiptg5w4NKGgtplRn1h0
 NW5Np0Q1tmLncLLbPslGAacTl8dtScqueuA1kpzHRTIhujMQ/zg/Vrv5zqNRhMqvCYD0YICZji7
 XOnobq0TWze4n6JOg67xjXqFzMwYMhvpUcuw80NNX0p9RyWZ5iAywoBS4yj6x6MtRPdhj+zdsh2
 IReCe/Zn
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c94be2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2Fl1_B1TyGCfFF3moNUA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

On Tue, Sep 16, 2025 at 07:25:28PM +0800, Xiangxu Yin wrote:
> 
> On 9/16/2025 6:22 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 16, 2025 at 03:31:35PM +0800, Xiangxu Yin wrote:
> >> Add DisplayPort controller binding for Qualcomm SM6150 SoC.
> >> 'qcom,sm6150-dp' uses the same controller IP as 'qcom,sm8150-dp'.
> >> Declare 'qcom,sm6150-dp' as a fallback compatible to 'qcom-sm8350-dp'
> >> for consistency with existing bindings and to ensure correct matching and
> >> future clarity.
> >>
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >> This series splits the SM6150 dp-controller definition from the
> >> '[v3] Add DisplayPort support for QCS615 platform' series and rebases
> >> 'dt-bindings: msm/dp: Add support for 4 pixel streams'.
> >>
> >> The devicetree modification for DisplayPort on SM6150 will be provided
> >> in a future patch.
> >> ---
> >> Changes in v2:
> >> - Update commit message and binding with fallback configuration. [Dmitry]
> >> - Drop driver patch since SM6150 is declared as a fallback to 'qcom-sm8350-dp'.
> >> - Link to v1: https://lore.kernel.org/r/20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com
> >> ---
> >>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> index aeb4e4f36044a0ff1e78ad47b867e232b21df509..82481519005a1b038a351aa358b9266239d0e8a9 100644
> >> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> @@ -46,6 +46,7 @@ properties:
> >>        - items:
> >>            - enum:
> >>                - qcom,sar2130p-dp
> >> +              - qcom,sm6150-dp
> >
> > In the review to the previos iteration I think I was a bit explicit:
> > "qcom,sm6150-dp", "qcom,sm8150-dp", "qcom-sm8350-dp". You seemed to
> > agree to it. Now you didn't implemet that. Why?
> 
> 
> Sorry, I misunderstood your previous comment.
> I thought the recommendation was only about the commit message, not the
> binding structure.
> 
> Does the current implementation mean that qcom,sm6150-dp and qcom,sm8150-dp
> fallback to "qcom,sm8350-dp"?
>     - items:
>         - enum:
>             - qcom,sar2130p-dp
>             - qcom,sm6150-dp
>             - qcom,sm7150-dp
>             - qcom,sm8150-dp
>             - qcom,sm8250-dp
>             - qcom,sm8450-dp
>             - qcom,sm8550-dp
>         - const: qcom,sm8350-dp
> 
> Do you mean modifying it as below?

I suggested a compat string. Please modify schema accordingly.

>     - items:
>         - enum:
>             - qcom,sar2130p-dp
>             - qcom,sm6150-dp
>             - qcom,sm7150-dp
>             - qcom,sm8250-dp
>             - qcom,sm8450-dp
>             - qcom,sm8550-dp
>         - const: qcom,sm8150-dp
>         - const: qcom,sm8350-dp
> 
> 
> >>                - qcom,sm7150-dp
> >>                - qcom,sm8150-dp
> >>                - qcom,sm8250-dp
> >>
> >> ---
> >> base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> >> change-id: 20250916-add-dp-controller-support-for-sm6150-525ac2ed8c86
> >>
> >> Best regards,
> >> -- 
> >> Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >>

-- 
With best wishes
Dmitry

