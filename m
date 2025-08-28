Return-Path: <linux-kernel+bounces-789239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48EB392A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 748C94E1121
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2585D2652AF;
	Thu, 28 Aug 2025 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9abfwZt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDB259CB2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756356086; cv=none; b=Fxr/8yN44NF00sfLoImEDhVljrYjOinYH9wF6/uXGL9QmOVrU+B+AjssjUiKaG0muVXWStKcsQWTuraqbu6V2hcfdvFVb70IzH2NQNDdold6BOm3pq7FB8FB3mkWysHahjXpdxoj16rJjHJr0Cv7DLxTh4BjcmRiycPUdVEogfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756356086; c=relaxed/simple;
	bh=KEPGQ36iJNY4la2Vtsyl5h73b+KhTwqD1OvCFddUR30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2tx0DOq9nxGPyGjhsKJT84Qvv5fKryftgRhV/OTHOyfLCTa4ZI9ttcazkVl+3wMhGpHidHr03+L5qajJm3zCsWs48bRrhoVdjXJiifEPAxwtYsxf63yWFiVwMhgUbCUT2Gy7tSqf4wPJjHCDQGSYNo9+Nf/6XaF+cmE2vueq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9abfwZt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RG1WRR031773
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rSvxM+2fP76lLQdAFLs9nvAo
	o+WJU2TUDWvQs9kUilg=; b=O9abfwZtQNubHbT5lPWZgaJXhv0wtq9GAmoY3jJi
	EJk9sokHYwqpnUzyT2M8SGgXTLxMqd/w/2hOgF4HROS2rrlMUZxPiC4/XVGazQNC
	LTY3VmOUQzqtguhxBq2mHgYJnB/QhnPxzbLo86cpGnmL4qUyW/gf2QHAeMuouSOH
	gqk0dJmnRZobv2ElzCXQdzsqMmWs88f5V+0G0/wl+FctAZiHSQVlkKZUGD/chUuI
	6srcpO3GmnWn6M+eTmISwlraX44ZXe2xJAYfYXW/SlVoejdlyLoxuEVNHdLNajIc
	AXvpegoSgQGmsA5DSK0f7qsTTPSrlnViRI1XvJvTZlfAcg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpy3xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:41:22 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d7c7e972eso14544806d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756356081; x=1756960881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSvxM+2fP76lLQdAFLs9nvAoo+WJU2TUDWvQs9kUilg=;
        b=ClIZvPoARE53hur8XpLnQPHQT1zIh4p+c/4qfbpGpVjihU32hJryBT48Xu55Gz1+qr
         cvbm7MIG4H8lLVss9JJJx8+Qv+m7mHFqG/b758gbJ2kKe4K/wXji+qL4hdt9peVlq/zJ
         UTNaSRBlFopE8xKE0PMs8jHwINz6ywlu7VYT8pTwSvjNkl6mynAiIAJb7iSZscdG68ah
         vcVDPo5ERasKbrjSwWo640xI9RGbcq949C9BrEf3eLwrSqBo0nrfH/mhW1juQkjoUXja
         fZC9wEmVHjfvdcQXH24n+5Zt7D5Bm+h7J/niwewTnGNjaSeJKrZ1WryIbQJQyh3nHzAQ
         oGzw==
X-Forwarded-Encrypted: i=1; AJvYcCXcTl3U9wt50Qq8C5LNgm3I02ncphOfP7WX59+lZ8td34l44f1TCRtwAfMlpoSGqOYoR4VJPl2Mp6WU8ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrGtiIrcsoT9Fv/tKiaWX0RoLXPMKO8AnOMZ2v98O4ARSUow5
	2ZtYWQTKaJWFvTFvh6WwzWWdWCdFdGpdmuTaXudKnPLvzZfyt0auNfe4o+hG2Ici/PUmaxQge9U
	+oJ9TyjYNYvrfzoy3sCcrldUVxJQXQTK97Li04Bm8YjmOE5hbr6rMoniGNkkI9GjbFjg=
X-Gm-Gg: ASbGncu3zaHSgAmCFJH5DPsahJio+zl82DN/5GpIQpg9MNTPJKKUZkpYIBy0oqVJ5GP
	7cH08M8TvBq2T++dq/Rh7p+PVQktZ014TrRFVh1mavvQ2O1NxrfgrkEuz39GDtO8VE1EP3v5N1v
	omxh5X35YZOIzP2hWF8ldGGiGniTZHOcJMqanF6ppqDCikCSK0WuEEbHFEJ1gntBCz4cc806Lpn
	g5hSSBDFVvXCztOW3ObhmyYXEckezeMP7Jg2i1DsCqe3pWuD+VupgGLjTznYPUZKBeg+DDZYM94
	ca/l+kqTfs6HmOBjnOOZcryRMytDj0rZLhm5G7MQwDJficIDUgaytrwIBE+f91GblCEULosm66X
	2fOPqGDTEuerKTMEI2Smv4jg2+7TZzwX6wJdLMEKONbLMLRgKzAWc
X-Received: by 2002:a05:6214:268a:b0:70d:6de2:50c7 with SMTP id 6a1803df08f44-70d971ed072mr268768676d6.52.1756356081210;
        Wed, 27 Aug 2025 21:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0BRxMG/COFp1TgX3a+AyHbVN7DWuZI4IOa0jOW27XlSiJaXNy+HkuW6nAZGxiL5O+zhzVSA==
X-Received: by 2002:a05:6214:268a:b0:70d:6de2:50c7 with SMTP id 6a1803df08f44-70d971ed072mr268768496d6.52.1756356080597;
        Wed, 27 Aug 2025 21:41:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20e98fsm29438851fa.12.2025.08.27.21.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 21:41:18 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:41:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fange Zhang <fange.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Message-ID: <zoogyjua4l6e2bgsvxx7w26n6v2hwnp2pvkizzzsds3c6cgaag@2bvqdl2z5ds6>
References: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
 <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
 <yutyrfb73wbxlweoq3mc6ezyqr56snzmznw3k6mcbc56fpfayg@3h5jwymlo3ol>
 <0c2a4877-d63b-4650-b7d4-a06a2730c73c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2a4877-d63b-4650-b7d4-a06a2730c73c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68afddf2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DN4yNuRjLBB3QJd4LzgA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: nGfTLPE00flvZE4eTiQBT2Key2E9F4LF
X-Proofpoint-ORIG-GUID: nGfTLPE00flvZE4eTiQBT2Key2E9F4LF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX5+dx8oqTkJMl
 1/mLuUFzsLIqRqcAE1WWN2HvATIP+frvIAK5jZM55y3SjlQUAqVO8hGGNOEG2O7KHdQPFBqri2k
 qK9Wd0QXUuw7+DDprcye91zssDCnylvXWxamlEdt7pAJgEVgp+eW1K0+ZpsYFgUdIsyzJUP2BQs
 eRA4GXDYnDIescaHsfqIA4HmJMjGXprMEb0BX2klK2qT2WDx65P1d9pK2XE6NvFCZVk5KeIM1tI
 ZXtaE53jTYf6n9qlF6hvdPfRUmg9jWuDZsU+QB8qXnPVSVVNStx0EgdcC5EHWbJg5z45h+hxEWu
 7uFfOi+gTbrLnXQUHbEW0I8Q9jVN0gKyVQA0OrQZxX1kIyZa4pyYmxBQbY4A2277UNhcXJrIt3h
 RqGme8Hw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Thu, Aug 28, 2025 at 10:57:41AM +0800, Fange Zhang wrote:
> 
> 
> On 8/28/2025 4:01 AM, Dmitry Baryshkov wrote:
> > On Wed, Aug 27, 2025 at 09:08:39PM +0800, Fange Zhang wrote:
> > > From: Li Liu <li.liu@oss.qualcomm.com>
> > > 
> > > Add display MDSS and DSI configuration for QCS615 RIDE board.
> > > QCS615 has a DP port, and DP support will be added in a later patch.
> > > 
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
> > > Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++++++++
> > >   1 file changed, 150 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > index e663343df75d59481786192cde647017a83c4191..f6e0c82cf85459d8989332497ded8b6ea3670c76 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > @@ -39,6 +39,76 @@ xo_board_clk: xo-board-clk {
> > >   		};
> > >   	};
> > > +	dp-dsi0-connector {
> > > +		compatible = "dp-connector";
> > > +		label = "DSI0";
> > > +		type = "mini";
> > > +
> > > +		port {
> > > +			dp_dsi0_connector_in: endpoint {
> > > +				remote-endpoint = <&dsi2dp_bridge_out>;
> > > +			};
> > > +		};
> > > +	};
> > > +
> > > +	vreg_12p0: vreg-12p0-regulator {
> > 
> > I should be more carefull when doing reviews. I thought that it was
> > pointed out already and didn't some of the obvious things...
> > 
> > First of all, the nodes are sorted. By the name, not by the label.
> > Second, there are already regulators in this file. Why are the new nodes
> > not following the existing pattern and why are they not placed at a
> > proper place?
> 
> Initially, we referred to https://patchwork.kernel.org/project/linux-arm-msm/patch/20250604071851.1438612-3-quic_amakhija@quicinc.com/
> as a reference, but its node ordering seems a bit unconventional.
> 
> Would this revised ordering be acceptable?
> 
> ...
> + dp-dsi0-connector
> 
> vreg_conn_1p8: regulator-conn-1p8
> vreg_conn_pa: regulator-conn-pa
> regulator-usb2-vbus

So... Existing regulator nodes have the name of 'regulator-foo-bar'.

> 
> + vreg_12p0: vreg-12p0-regulator
> + vreg_1p0: vreg-1p0-regulator
> + vreg_1p8: vreg-1p8-regulator
> + vreg_3p0: vreg-3p0-regulator
> + vreg_5p0: vreg-5p0-regulator

While yours use 'vreg-baz-regulator'. Why? Don't blindly c&p data from
other platforms.

> wcn6855-pmu
> ...
> 
> > 
> > 
> > [.... skipped all defined regulators ...]
> > 
> > > +	};
> > > +
> > >   	vreg_conn_1p8: regulator-conn-1p8 {
> > 
> > Tadam! It's even a part of the patch.
> > 
> > >   		compatible = "regulator-fixed";
> > >   		regulator-name = "vreg_conn_1p8";
> > 
> 

-- 
With best wishes
Dmitry

