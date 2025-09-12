Return-Path: <linux-kernel+bounces-813949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14157B54D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7885416080A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08630E846;
	Fri, 12 Sep 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ERMbbQEI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BD30F921
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679164; cv=none; b=Fph9UnE6o3CYgnlLsqmDiEGlt/CejVeeG+XPTtOSwpHFon5jUy5qxVnL1FkJKSCJlVbauLZdGhAUAdU2oB9iObU3aK4N3bt8n/Sz/6iiz/ALOsa2RI3soFnpV9GF1VF2md43P7CLzK2yIt5Snw9FOES9ooDVx2k7A5/uxw9WVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679164; c=relaxed/simple;
	bh=oWGivKsHxkmHI/ov59Bz/LsMaz2L1v6ycuboHhiWC0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2Fg3B9H40gwTvxq8XirySpKeyiPwt+edMmMTo4qsBwqOn+mdNqrLVp2gKOPHsVMo8MRXpDVsHbvNiaIbId6EFDk/ZPk3097MohEIZm6EBiu6lRIlLxUr0NX6GwWGrtd6UFFr9nTnfFTuVdOvEdqQQxLPC5yssDvLpM54GvLgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ERMbbQEI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fLVP017819
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zI8guBb3Lo60ZeYXEP0MXbu6
	oVCoqd2RpOjF36niL0E=; b=ERMbbQEIEeC7btydKuXkpC0mwnfj1F7Ywp2yIK+Y
	p0xIR881VWrMk5qiPUA4VMMUlXNe+85sKGEbX1sj5wohtBp22e7uwOdcHhxTdtyW
	SiOQ29t8n5XmP4/USzu4AdHykf/SEYvTF0y7bUmPU6mNpyyXzVBdYjRp23J2UE6D
	ywGwqEn//5Qsuc1E7NNAgVAfX9hxAAHJN91zR/QDcTm3rNroYNm55fipI1483YfN
	27wBLYz5yW8IffYX3cEhIGWswS0VkRX7VDo0Zk0pdmMNMlUtkssLUhEZdPMyEzd5
	nbxEvwCX/tOJD6UMCM+71b06AjOgcpTfuVVQkzUfIovT3A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8unhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:12:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-718c2590e94so64640046d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679159; x=1758283959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI8guBb3Lo60ZeYXEP0MXbu6oVCoqd2RpOjF36niL0E=;
        b=CipZER++PTa192xx1vneVLmUj4ChxGXlrzAIArGvMmefzgCSPeuJkdx9CFlhyIL/Jx
         OtXblwWYSIHRVML3aq0sBNqkLBnek2hKWij4utfaVTe/05Nx5b8OXc87av4tSOX7404c
         n2BLJrAHVWwBCJlI7xQdw0q3LvDtkz2ctfz9sVPjnc5WCGnonoard8l/E0MPU6ChiFR/
         m0rg6WWH5vH4GCAa5vJ25zs027/Cbw57WiLnFu75cJgEsdO9rAKfQotgNDgOP4y9FyJb
         UkvpRqiYWCmxB+6+rpBzgnxmRRHpAmcJ/3zv/JH/V2tLW1vYPnEgsKj1rqJCF3fOWVn+
         XziA==
X-Forwarded-Encrypted: i=1; AJvYcCUC0GNRqcZDHYG2S1KoakhJ4JrJt5gckcUDHl+oX3iUWj/z94RBDz/UsXOxoE96zuOzoohk7/jn70jnuO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoG087pRW9MAwJ0FspITYlmFgqkThuCuLLRovCWTpNhs69cOQk
	+XxosrwTkOgAW9tBpI2aPV7njXCnxFsZRITrtHJxX+ef6ZbsoPu85qyNiZ3paCrn5WIsQu69lp2
	45NSJnJhi2d2OqPWEbOzwWSNjXxtitYIEQpMA0lqSmODhBXfhxs/UmWK5eYz4YGOjztY=
X-Gm-Gg: ASbGncuxQi+ZVIRHIW7tiCr69gzDa8fLiY1VndovEc925vUcxtNHuFDWSVXhmvSXnHl
	Ij8Kg+RTrCnrMb3piAS4AM7KJbDhBmmSGMzeHv2vHcugls785LsRmATRm51G61f7AWz4bY4AgYT
	TxPESc+Dm8enssAj5XRJBNwI7wDTh2O96enkN2pODHhOQexdMJlBN+0xqSx4L74o+FvFCYY0d6t
	fhzm/zhCnc96Z/COkAZkay8b0KMzh0mm5KXqET3X5P5b8Xyh104kXOb+HQPQRhgOiZST1DrgZHq
	ci0IWuk4y8sxnsaMy81X3Hnwd9fXaB5IkZaMudbHDqZUdBvD6qnlzndRBY1jO2nnHHk3wNpkEue
	lxCimS+9H0XKRyc3H82pywIjeKPYV6WhygGSwX98kPYKMuEQQWz4K
X-Received: by 2002:a05:6214:e44:b0:72a:6d80:89 with SMTP id 6a1803df08f44-7621f5326bcmr84955566d6.14.1757679158466;
        Fri, 12 Sep 2025 05:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETqAAx9aPZRKQ9jf+u+KmM6Kvfm0l4R77YKoWyoC00QsU84Zpj1UOrIYuydwW4MVV7TmB7Pg==
X-Received: by 2002:a05:6214:e44:b0:72a:6d80:89 with SMTP id 6a1803df08f44-7621f5326bcmr84954736d6.14.1757679157622;
        Fri, 12 Sep 2025 05:12:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b2a925dsm7684111fa.46.2025.09.12.05.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:12:36 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:12:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document lanes mapping when not using in USB-C complex
Message-ID: <rioswugtt3v6f6qa2w5qcmnqjzuxkm372sgovdy7cj3g2jfxru@tg2bdy5hxjhr>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
 <20250908-topic-x1e80100-hdmi-v3-3-c53b0f2bc2fb@linaro.org>
 <7dzfcuvr45h4iailtjutqjev7lofoqu7w6ob77gehgmy7mctpk@k7oob4wj3c7a>
 <14d58c6d-ca20-4349-8031-9906a4539fef@linaro.org>
 <c25kbb65aijgolxjzunydvhupt774pfmbcz5lvfvl5f74rrxtr@vboh347gdvdp>
 <da984d8f-85ae-44cf-8de4-208bfc9e292d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da984d8f-85ae-44cf-8de4-208bfc9e292d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX5aMe1Nzm5PIT
 IMkBZTCB1C6Nv8Iko39F/QNpQ4xFzVXlbN0QBPnSkXEbA8I5/o+KWNBu7IDulsBonLu8PktWnpP
 PsJjud7VIMKyN8bLGBKJsaQnzQRmGfRF9cqu5eP1V9jfNDB7YfrIdmfGOVtr7lN1uw/BntPeRTb
 b+xVkTJx+gB37Mhd3tJ2RH7cCh6rycgvjxx+LKoE6Hdnv5XN9yClMMWyEfQC2FeReP3SECwQSEo
 i/uM2oQr4WyE8CDAVzZEXXCjVcvibO/WjJrjACWV72MlTzV2JBYA6lh0OCxIt77jUDvadzVUl+g
 carn/pSo1nnDJmICmngRSnAcxkOJ1VyXTSa3a5PAGioAOp7JyTcKpH4JVsFcZsQBhtXjlkGsLkS
 RobDOhNi
X-Proofpoint-ORIG-GUID: GfGw4OpCYcKQdwfhU_nocmgJRIqc-13X
X-Proofpoint-GUID: GfGw4OpCYcKQdwfhU_nocmgJRIqc-13X
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c40e38 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=r0EWWIcaWpoI38bJcbMA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Tue, Sep 09, 2025 at 01:21:19PM +0200, Konrad Dybcio wrote:
> On 9/9/25 1:16 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 09, 2025 at 09:14:49AM +0200, Neil Armstrong wrote:
> >> On 08/09/2025 23:14, Dmitry Baryshkov wrote:
> >>> On Mon, Sep 08, 2025 at 03:04:20PM +0200, Neil Armstrong wrote:
> >>>> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> >>>> of a combo glue to route either lanes to the 4 shared physical lanes.
> >>>>
> >>>> The routing of the lanes can be:
> >>>> - 2 DP + 2 USB3
> >>>> - 4 DP
> >>>> - 2 USB3
> >>>>
> >>>> The layout of the lanes was designed to be mapped and swapped
> >>>> related to the USB-C Power Delivery negociation, so it supports
> >>>> a finite set of mappings inherited by the USB-C Altmode layouts.
> >>>>
> >>>> Nevertheless those QMP Comby PHY can be used to drive a DisplayPort
> >>>> connector, DP->HDMI bridge, USB3 A Connector, etc... without
> >>>> an USB-C connector and no PD events.
> >>>>
> >>>> Document the data-lanes on numbered port@0 out endpoints,
> >>>> allowing us to document the lanes mapping to DisplayPort
> >>>> and/or USB3 connectors/peripherals.
> >>>>
> >>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>> ---
> >>>>   .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 59 +++++++++++++++++++++-
> >>>>   1 file changed, 58 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> >>>> index 5005514d7c3a1e4a8893883497fd204bc04e12be..51e0d0983091af0b8a5170ac34a05ab0acc435a3 100644
> >>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> >>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> >>>> @@ -81,10 +81,67 @@ properties:
> >>>>     ports:
> >>>>       $ref: /schemas/graph.yaml#/properties/ports
> >>>> +
> >>>>       properties:
> >>>>         port@0:
> >>>> -        $ref: /schemas/graph.yaml#/properties/port
> >>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
> >>>>           description: Output endpoint of the PHY
> >>>> +        unevaluatedProperties: false
> >>>> +
> >>>> +        properties:
> >>>> +          endpoint:
> >>>> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> >>>> +            unevaluatedProperties: false
> >>>> +
> >>>> +          endpoint@0:
> >>>> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> >>>> +            description: Display Port Output lanes of the PHY when used with static mapping
> >>>> +            unevaluatedProperties: false
> >>>> +
> >>>> +            properties:
> >>>> +              data-lanes:
> >>>> +                $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>> +                minItems: 2
> >>>
> >>> Nit: DP can work in a 1-lane mode. Do we nned to support that in the PHY?
> >>
> >> So the PHY already supports 1-lane, but the QMP Combo only supports
> >> mapping 2+2 or 4, but nevetheless we can still decscribe 1 lane in DT
> >> int both in & out endpoint and still should work fine.
> >>
> >> Do you think this should be done now ?
> > 
> > Do we support it in the PHY hardware?
> 
> I don't think the PHY cares if it's 1 or 2 lanes

After taking a lookg at the HPG and the driver sources, it does. So, I'd
say, please describe 1-lane mode (which most likely can be enabled only
on selected set of lanes).

-- 
With best wishes
Dmitry

