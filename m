Return-Path: <linux-kernel+bounces-807536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5838FB4A5CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243597B7048
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A82586E8;
	Tue,  9 Sep 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkE1o8KV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5624EA81
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407542; cv=none; b=eFoQ4OKXVqOO4C/r00Yuw9mBkfoezmC099x+ko3fsRYDwEVcZftpwrOX1sjZCSItej2rSPWl3hKUcHI1wSVFs+vM78zxhytpvfBSF2i4YH+VbtPLpJqZ+B8PPnA1oK9BN3I+BSYU2eQhgRJeejvPqbldIcUG+5pZ+ldtydt8JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407542; c=relaxed/simple;
	bh=Pa+vz0KFh6DTaA/CGgHn960N3UQmZjnHgqQ+q8ywuVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOcuVDvCd5egp6ZU1yzfdRJyhtfxWSnCu0VKS4QIkFJf0vUcaTTwIIuJ5y8J6izobokzueOZz+L73aV1ZRTXwtxInqjL53p3REQxJzkxyqAewI61JVlM/D/mlhhwUksdUXpNBKL3jL5fnMzvN6kYkkgZ3M19S8YvrvsFkMfWSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkE1o8KV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896Sjq4007720
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fa2kQFxYmWf21zOyKAAlQ46RUigKSHEniPLTl0DpNvE=; b=hkE1o8KVzS1Y7pef
	cxBBP/fMEkMfU37evIwBNfO6mpmoR+fu/q4MVQqOETTeaWOZvwcHIEGZYwGRsTY0
	+cfHkxArRvympOPyHk0/rH/JkRJhWTmha9EMAUaQ2QDbfwyrCLPAZxZjhaCAgMln
	2mywVmvvhLHGmMcsyzvCZeB0VCDKjzaD72JNNwXCXbV49vGI6oJxagiYHL2CbLjo
	4TRzj9Lfn4QPcxPG6670XG8xGBYISDjkVhEmK2KU9eazuBVzRdc4Ri8Te/X0NjfU
	sPL1WeTQREDSNkuONoAGpZXWsPLvC58jjo151qQUWi00Nvj0r/NYA0sQTPFxkWPO
	sSJQaw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0qj7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:45:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e9b60ce6so126453811cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407538; x=1758012338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa2kQFxYmWf21zOyKAAlQ46RUigKSHEniPLTl0DpNvE=;
        b=SJcCmsUeYnbU8OB+JZ2TbmiUsfEseP+ukL0mkzY5rQylAPZkIiVugEAGj1R62TC0Qs
         v7qvRoXdlcq1eMOMMOJsPKGKEiTKPEwq6Pa1jloaRzBlOozUJtEqADwagHY7lVtjpcOg
         Y9avzOwskue/2aqgsGl5cdYautAeZLxtx9RWMxUEtMrQm5rKnq2hmQrE9RevDfKnBaXz
         0t27M+Mmz4cTM3S/MRG91ryklA0tFIfIxo1hKCWMoOSh/4l7oCo2xJBrfoB36/PZkdAh
         yNIcqCsXbmhsf77UQrDxcoSO7KAC95uHHKkE1gSpptD3KJeXRk5t74osaFlROOEB3Sgy
         Do6w==
X-Forwarded-Encrypted: i=1; AJvYcCXhIe2UOkODAP15D6/Kq88JwAS6Ff0OwfitJeh883vUwQ3H2mkV8zwuICP5ucnA68fTUKLhi0NTX7xSNTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ehCO2WedEXU3UISfV7wZ0n9jpFHqNU2x4fDYU74MKVTaI0Ls
	OkEjHAwd2d+YeeYH3cH72x2RiqD7gRZpJduyW5eSpXuW+OC93ENYbE+kkHdXUxyE3uo30omz7AT
	X+L+K+5JVS8n7D2NwBDOzUwQKusx7E7kCBjF4oIYGIB10UzZUR7y0uBPGFl69HvRcpbM=
X-Gm-Gg: ASbGncsy7Y0MY5vbEUoO4u7cTd1s83xHnLRvBjrsso4vhai1WDdcqMELFKxMydE7sYi
	TiLwM+VvBZZCVQTYVxfn8LExV82kKUVxwHRGILSrTNn7tf/ytRdL3CzgnFQqIU4fliFegZV2WxB
	02swLD4i56eGjiGXpnpuIt0L2SsJ5BN4C+ZqhyKW90H/JUkGwwvfn8Pf8/mFF+n4MSAbQ/mF00I
	W/8MeERaDHWqcwGuYWpqA4AoQUmXh8MRIbqkHAZ7w0KpnYNxpjF35QtFvdjAcYy2vNGifbNx3Di
	gaN2OmPwEqsPeC27JDOdHlCckaPxFFwf4m0B2Qq1nIGQE4VsKuVR+Lvj8038SuelKwG4QLt7Iwm
	6azuu2PrOX3pCGWInWAwjyQV/3Ci2AxpVxboY6xY6TgO835/+HqIo
X-Received: by 2002:a05:622a:5e05:b0:4b6:236:3f32 with SMTP id d75a77b69052e-4b60236429amr79524261cf.77.1757407538509;
        Tue, 09 Sep 2025 01:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER5hHlXx5UTU+e+w4PLfk659mk/2aAhqRlis8BzleBfAkcCxzbcmgNq7E4vUzOfp7AF/REfw==
X-Received: by 2002:a05:622a:5e05:b0:4b6:236:3f32 with SMTP id d75a77b69052e-4b60236429amr79524091cf.77.1757407537960;
        Tue, 09 Sep 2025 01:45:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34715db904csm5157031fa.2.2025.09.09.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:45:37 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:45:35 +0300
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
Subject: Re: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
Message-ID: <3zi57uvggw3zgrj4bfouzjnf56yywjnw46f5ru7krihyrw5bkc@c3xf73ianksa>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
 <xurpc3mk5kksx7lfpsdqgasov5gc4dpsmz6iv2hjhsp5tewbue@dvrupbjzgxle>
 <c4eeb8a8-2819-4ac5-8dc1-cce209d7cbc4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4eeb8a8-2819-4ac5-8dc1-cce209d7cbc4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: IjCzposqHJj-_Z1UWZ4tcQ8bbGPtFug6
X-Proofpoint-GUID: IjCzposqHJj-_Z1UWZ4tcQ8bbGPtFug6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX/TpiLjxi4vN9
 +crry2RK8FD7ZFbJX7TJmUaT3uxns+izuBgjrq/Bh8C7Vcg5oduADxlTJKZUt37d/85SaqVt8EQ
 copUbG5oetH26J89iYfVPTy1UPzNs/Dolvc5jGVyOg66sW2BZnmJDXr61vhuV8lbl4k5NSUd+j8
 5TsL0TL6KdS/phG0VDtP3FAbnX+eplN69chDQz+q+fc3dGvMdXCY4DQd8g76uWEZ3U02N/ich7w
 hzOD2/FAt8IkFHNdB/e84a0be+cfFgNeFa2nFNyg0RTNC1XWl2s7YA9EDu4PZ/+T947tBxwTAzc
 XNOjFXfeVrjHqwtqmBiyLMw4geyFM8X9qRj/1uuUnCNwWRwAhkOF1yrvVG+Q07GGDswdl5gW8hj
 1SAm345O
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68bfe933 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TUuSr-ulYHZ9osfFkC4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Tue, Sep 09, 2025 at 04:39:26PM +0800, Xiangxu Yin wrote:
> 
> On 9/4/2025 8:34 AM, Dmitry Baryshkov wrote:
> > On Wed, Aug 20, 2025 at 05:34:43PM +0800, Xiangxu Yin wrote:
> >> Add DisplayPort controller for Qualcomm SM6150 SoC.
> >> While SM6150 currently shares the same configuration as SC7180,
> >> its hardware capabilities differ. Explicitly listing it ensures clarity
> >> and avoids potential issues if SC7180 support evolves in the future.
> >>
> >> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> >> ---
> >>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
> >> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >> @@ -27,6 +27,7 @@ properties:
> >>            - qcom,sc8280xp-dp
> >>            - qcom,sc8280xp-edp
> >>            - qcom,sdm845-dp
> >> +          - qcom,sm6150-dp
> > The DP MST bindings were A-b'ed and R-b'ed by Rob, so I picked them up
> > into msm-next-lumag. Please rebase your patchset on top of it and
> > resend. At this point I'm interested in DP bindings and DP driver
> > patches, the PHY part can come up separately.
> >
> > As for the compatibilities, I think DP on SM6150 should be compatible
> > with either DP on SDM845 or DP on SM8350. Please choose one which suits
> > better.
> 
> 
> Sure, I’ll split out the DP binding and controller compatible parts into a 
> separate patch series.
> 
> SDM845 seems not support wide_bus, while SM8350 looks closer to SM6150.
> But I noticed SM8350 is still configured as SC7180 under dp_display in
> msm-next-lumag’s top, so this change will mainly about the binding, right?

Yes, it's only about the bindings for now. The driver support for DP MST
is still WIP.

> 
> 
> >>            - qcom,sm8350-dp
> >>            - qcom,sm8650-dp
> >>        - items:
> >>
> >> -- 
> >> 2.34.1
> >>

-- 
With best wishes
Dmitry

