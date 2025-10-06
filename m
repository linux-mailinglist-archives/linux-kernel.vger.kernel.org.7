Return-Path: <linux-kernel+bounces-842824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D39FBBDB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09ED4EA36E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866AB23FC5A;
	Mon,  6 Oct 2025 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZo+kfQz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF723D289
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746916; cv=none; b=ijrK+c6a0epZljNj/7MVrDpNnyW+jB4qIYv9XhsjVxCI8FE3SJG26g6KHutTgUvuToslgL3F7oFRYJK2JeW6dGu6/QvwnrUk+0uOmCYEJYlxVVK7DVi6aDAWAhkM29SLYLNrHz2X0x3z32n/PTmD6YW9kBvOPmckxcDB+XHSl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746916; c=relaxed/simple;
	bh=KOEfItLpTHHUF2NjaTltq4XrtKm97oaO8gQyfhxK6zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/GL8UUyVk9W7SJnPNbO4KotPpvpGPPdlY3/EaKyu8WGGFCNRHSo8lOaopjUVAPonRJ1eCwOZpSxbpKf4Wk9X0GUQ/SSyIqFFrwj5qLjRXyr4Y4wgTl5jFQQysxxXzobmAhZ3+Jk86zlLLlhCXIe3uq7mUuIukU+6cMAO7UvYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bZo+kfQz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NDf7p000970
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/GVt1K9Lflbj12O6/RaG4Mti
	+z7CPLMv3q3Zlvsed98=; b=bZo+kfQzbY2w14g+9jjoaiorc2gFKSmmjrAZdx4v
	2cTdYL8jmknRf+PryJo564MYnyPaNeyff33SJYOHctCuZbgQIoZwrEl0SmWJGkVh
	6viz29fRyKqYPn4J4iKz5gqjfogUTuUiqz3XpuQ5UJfogW65pgeNJoZ1SmBVdEQ2
	yU5TUiXE6uutxE5wzfXe87XMc2PbRfyQCYS0mdQ0aUGiaYrL8R6fpBLCfLUeiq/8
	SbwZJ4pk1mhoUbpAlvd7msAajxhVP/Yfmsct/++485ZjMmGJcjcsRO8twyJnWGXz
	3ARxoE8FARPiRMCxOgkoU4ZQZoWoKOlP4HwKVuIEnXfW1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9duss0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:35:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e5739a388bso102648681cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759746912; x=1760351712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GVt1K9Lflbj12O6/RaG4Mti+z7CPLMv3q3Zlvsed98=;
        b=LEskgwSZpwtiJAEhIN3TFr5nfxEAdX1I8bYppzqZvzQol08IPuciEfn58069/UwhIV
         7h/FLJJJNllICQGYgK4qgnbOkABCQhyaXIod3T5g8hdeCNzn3tNNirOtrm3pQ8oAeCqZ
         kvzZ+EMGB/hYeHbzHuzc9UUH1TjOkGUahYsciib9zgRlkWTa/D0sHHcilqkYInAur6T1
         etQum6TRajVe/k7V9gRn+1W4KeSvih/5Cv5UXZvWsyiI9pxOmLrYeb8JFMO8qAq3OVKe
         aBfKCT4A8PiqhLxjD/IaFeVWnhTFGNYU0ost3gNLQYlB5WM1xRwicQuGmDghISULVeJR
         qrVA==
X-Forwarded-Encrypted: i=1; AJvYcCXp8xdL0db4/YVIhg3zk38eABqwTw0V8cwb71RBPYqpYJDnTFDkK69q17lLEV73pMOtmszVsZ3qCgCG85E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjA6Qk/gtMzKOrAtvL4G+clEOTKNzCDji5qz3eb9+kSj+3dpey
	IuuPjvy7oPIg7m2Xa3oE922SqBhEnkjSxCR5hTRaIJXqqQNkOmI9fJPeSoJ7ZwAk0uVoQqHKJdm
	6sP9ihz6NBwcwVvjzbGtKu3v8UrN2jTPkiZHk5fYDkkoFIq7RVKEQeLSEWJYMOiym3YU=
X-Gm-Gg: ASbGncsY7/QrfzkLzVLPpm2AHd4G4oRFaBry4byWvQoIBwlRDUgeBk1LVi81FHJsJWa
	q9NAaHUPKZVjAWZwr3OPX9hnVSEsd5NhqWviS7rQCFW60JMoeqdZeerQVQR/1XsN8QaaOzxAz0S
	rVv/AoZ/jb0vfBptlf/9CSs/Bbi3Mc9ZFVwjkqGPyjT9mVU8qTngs2VuoTqR7UxAm71uf2d2JH/
	aHzLLeTqF3E9RaJAAjXAk2hWr1sf2oVLbFyNLuuS3KJSlf48SoqgUNhyHFtrHEyzNd8CfFCg+Do
	Aos4KA3jV+gASAV5wwAZxeDNi5lMZtomBvmRE7ZFOBcLFdouI+LpH7ko1opGNVWjGU7EiRsH31C
	bbvA6ajq1OwTzPfQyCDf+sxxoU0Y9wWTzYFxAcwpsgkazNdIHcl7W0Kwvow==
X-Received: by 2002:a05:622a:4a8b:b0:4b6:2be2:e816 with SMTP id d75a77b69052e-4e576a45338mr152170461cf.8.1759746911811;
        Mon, 06 Oct 2025 03:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD7NGFTQ7j7kDpuOlH2JVm1Bio02PxWYP8W51tf9aEfgOxa//y48qL1owpgFsKldjyFIyTGA==
X-Received: by 2002:a05:622a:4a8b:b0:4b6:2be2:e816 with SMTP id d75a77b69052e-4e576a45338mr152170291cf.8.1759746911251;
        Mon, 06 Oct 2025 03:35:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba4cdf47sm43332131fa.52.2025.10.06.03.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:35:10 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:35:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Xilin Wu <sophon@radxa.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Message-ID: <v4oxbjc4jho5uuz2k2ou4rvycdwifu2wuvbhldgfrm7ord4yqu@7ktz3a4233ff>
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
 <20250930-topic-x1e80100-hdmi-v4-2-86a14e8a34ac@linaro.org>
 <74446713-15a1-4706-b3c7-801724467575@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74446713-15a1-4706-b3c7-801724467575@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e39b62 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=LC5ovIGdoV6AwfhOO1gA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qNl1z2Be1jl6vBCgUdavbJawyeqyw-Mk
X-Proofpoint-ORIG-GUID: qNl1z2Be1jl6vBCgUdavbJawyeqyw-Mk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX4hNFvU9dpysV
 +TqOgXv6FFAMe0xuUOff54v8cA/89LInmd88RxL3sAZ2tu+A9K4Byd7fttlJHxHEo83LtRDb4Zp
 90HsR6OTs3eAcIrwjPHUHet4B5Syl6y9fJtyuHpsucpQmZjW+GPpq7+saHAgMUM42V92rl8VUJA
 +aGakVr5+4NVUPOtQHwhAidqWtoV3qY4C5uM8ottEIGjUuhIwSv7N19q7Efh7yTjdui7QLVyE7X
 HnHTeOpQPEIPjCkp3UFC3nN9bvI+RpkAD7lJ/PqS0dzpGdBtK5MGvmQOowWW1yLqxvSrX8vrcuD
 KW2N+D+AUQgnpb2YF1IMchA7HbOQ/TyuJqOje+8+SqjkdRA92MwNNfr6StpAKBNRVPGk5q1WLHr
 DFx1+JNcLi6HdyQrLTDReQ0TkshkPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On Mon, Oct 06, 2025 at 12:08:22PM +0200, Konrad Dybcio wrote:
> On 9/30/25 9:39 AM, Neil Armstrong wrote:
> > The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> > of a combo glue to route either lanes to the 4 shared physical lanes.
> > 
> > The routing of the lanes can be:
> > - 2 DP + 2 USB3
> > - 4 DP
> > - 2 USB3
> > 
> > Get the lanes mapping from DT and stop registering the USB-C
> > muxes in favor of a static mode and orientation detemined
> > by the lanes mapping.
> > 
> > This allows supporting boards with direct connection of USB3 and
> > DisplayPort lanes to the QMP Combo PHY lanes, not using the
> > USB-C Altmode feature.
> > 
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> 
> [...]
> 
> > +struct qmp_combo_lane_mapping {
> > +	unsigned int lanes_count;
> 
> "num_lanes"?
> 
> > +	enum typec_orientation orientation;
> > +	u32 lanes[4];
> > +};
> > +
> > +static const struct qmp_combo_lane_mapping usb3_data_lanes[] = {
> > +	{ 2, TYPEC_ORIENTATION_NORMAL, { 1, 0 }},
> > +	{ 2, TYPEC_ORIENTATION_REVERSE, { 2, 3 }},
> > +};
> > +
> > +static const struct qmp_combo_lane_mapping dp_data_lanes[] = {
> > +	{ 1, TYPEC_ORIENTATION_NORMAL, { 0 }},
> > +	{ 1, TYPEC_ORIENTATION_REVERSE, { 3 }},
> 
> This is not corroborated by your bindings change ^
> 
> I'm also frankly not sure whether it's pin 2 or 3 that 1-lane-DP
> would be TXd on

If we follow the standard, it should be 3 (RX2, TX2, TX1, RX1)

> 
> > +	{ 2, TYPEC_ORIENTATION_NORMAL, { 3, 2 }},
> > +	{ 2, TYPEC_ORIENTATION_REVERSE, { 0, 1 }},
> > +	{ 4, TYPEC_ORIENTATION_NORMAL, { 3, 2, 1, 0 }},
> > +	{ 4, TYPEC_ORIENTATION_REVERSE, { 0, 1, 2, 3 }},
> 
> Would it be too cheesy to check orientation based like:

That won't catch weird errors like {0, 2, 1, 3}.

> 
> static bool qmpphy_mapping_orient_flipped(u32 *data_lanes)
> {
> 	return data_lanes[0] == 0;
> }
> 
> ?
> 
> > -	ret = qmp_combo_typec_register(qmp);
> > -	if (ret)
> > -		goto err_node_put;
> > +	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> > +
> > +	if (of_find_property(dev->of_node, "mode-switch", NULL) ||
> > +	    of_find_property(dev->of_node, "orientation-switch", NULL)) {
> 
> of_property_present()
> 
> Konrad

-- 
With best wishes
Dmitry

