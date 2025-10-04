Return-Path: <linux-kernel+bounces-841963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB6BB8A23
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 08:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95C14E1C95
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 06:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BEB17C21E;
	Sat,  4 Oct 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jRDARAtj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CB2C86D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759560401; cv=none; b=WhV0sXXHyRKcdFwxVJcY52aIFfdam0lJcyNi8evm2czfnL8gv6IahCIlpa8DqAhUb5eCpcRWljm7htArbAxKbdhbyhPT7kTHNUVcI6qf4x3QVCWvNRXBd4hyShkR9MyrLYkkt8hjdismlKm9SQkkn4Ke2KqbBPpwbJoNoDhd8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759560401; c=relaxed/simple;
	bh=5++0P7uz052KSdAfnQftmsr2lS2tYCz4teFtQ5Joy7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohieu8w9IrTBafwFVSewuNrey2YXhcqn87fsjPcGxtMs0uCAz/1bGyX/Eis+p7/pxTur5EuL+tJeFxDwdG1Cbzfd+7YAdHgfqQ97Sco0Jnj4PlkKesLj7Z++79tYJDtH6533DByS5OMWEcQfUeWzhbvkOG2v2Qn9OnpX1OToU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jRDARAtj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5943QQkx026797
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 06:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SxgQPHjjkx8c1JmVgGvAmy4X
	988IpWVIdlbWqL8CFH0=; b=jRDARAtjbq1gFjlUyxD12R0QuUfkOgrk6+KqdLVf
	+fWmZWHod+zsco+B/5ABnyRJ/ITSHHBm7Zk7yrJiD81xjkkNd8ls5vT5DOQcxdWc
	uu0f+iDA94oeWUjj+2fRV+ht4luJSUjrN/7n9zM8vlDeYr3G9S2H1BcnWHtx9XC+
	l5sOEEoKO8c4CeCjPblMezVV1CPAsX1MaDv6GDIfP6I8JjdUSeKlXK8LYM/qeuIn
	73HJ/VlSyT3sPX5kbmSuR5ALzJ+YVwI+xcicBd/AwHts8p7Voo3oZEJCzD64PjYr
	tGTdnEef4yFfu9YJObPWZSuurQUdXZb1ZkDDVxMvBX//pw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu09k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 06:46:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d91b91b6f8so37637961cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 23:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759560398; x=1760165198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxgQPHjjkx8c1JmVgGvAmy4X988IpWVIdlbWqL8CFH0=;
        b=Mx1lBeePh8IyRKKH6zS3soCx7za2MJBGsUX5L1inQjh+bfvFWMc+oJquEDUk7WcKnj
         /LXsEKfF3t9zYaoR4djWkjHlSaBfBdj8kAA0sG5VxlLeAlQOU8zXR9TWa99Gc2323aYQ
         qSSNJ5pACg3l7sX5SNN73hkgzm3aR3lt1yaJZv0lfvP3Mpc/KGgO6a6ofrLKH662d+ca
         LmFIjy91FiWO1BXDiWr1sCP2De8rp5gKz2E9CDVstbRQWPZu4NRbLkq6Z0HYut6Z1MWx
         +v+uAPcEO/2xQC2/0W1qFG2SmANOj3Mo7qGg5bwzc3Y+cbyvR5qAesHEWCEbaTeoI6XK
         cBQw==
X-Forwarded-Encrypted: i=1; AJvYcCVMEd3DM4LiJMXXMC5tcg2NhPbharZqv/bfpCgTb16OH4zE24dfFkI8+uP1jpEmewuETwVlmY37nQ3CciA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57tM5PAcY7U3jYyJetXtZEass8l2geMueYM2wQCwHt0rH9Wy0
	jBCUEXGBsn7dKZ2UgRiojNLd4KIVvTVxHsA7H36oLkxCPIH33GYG69XsgIU0bxGqztPcOBbvToe
	+Ry/86E+W8EelSsdu0irUZYF3iCpbLQoXL7DVSqGTT2w7Ni5Dlwxyr6ke/R5iZbZ3Kas=
X-Gm-Gg: ASbGnctO3Kb7tLYEi3C5vbtg8ViKsqA1b28aAtvr0I/mExCA7N36ZASdxfBBRf6BoYB
	EUMZ0T2TWYmfjL0Eq+wfx0qGOZRxgeUCVThtHNY245dfABAnPo/WKB9W50qov57S7/3VqCUxnSv
	sna27ac8FbkNaIQE0Mvhal5geuds8uRzKTxmIAAmnxbhADzheBNNAC4UcZl9ONMnKrTtPBIkjk+
	YuCBqlLECuDXJxgvz6DUVXRkSL47zisoc3Nnz9FmMO2KHOYuttVI3Htd8H/Wzc/LOsKE9YUko/1
	1ikG0r+taL3y6iyo6I7df8e4nrIQHvTrlNLthM0Uo/bfIM8eUKyTyA+uEYI7ntNnLFMEvqOq9Wi
	E/g0TwdmNaEaUb1q7C3l85Cy9h7pGIAU0JFrKzBZVXNg9SVBOy9tdmWO+Yg==
X-Received: by 2002:a05:622a:1445:b0:4d0:7158:b18f with SMTP id d75a77b69052e-4e576b1372dmr72499341cf.63.1759560398169;
        Fri, 03 Oct 2025 23:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQvslGGL2S9yvJwcUTY/EvgxyUZIovyV0WIRAR6wT5X3G5XXzp9YE1BKwE2cINLOH+uPi89w==
X-Received: by 2002:a05:622a:1445:b0:4d0:7158:b18f with SMTP id d75a77b69052e-4e576b1372dmr72499151cf.63.1759560397681;
        Fri, 03 Oct 2025 23:46:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01134eeasm2555271e87.34.2025.10.03.23.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:46:36 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:46:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Xilin Wu <sophon@radxa.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
Message-ID: <3i3euwqqvtqgyqgxbylbrj3dk2cyyavinb5v7ocevi4x6o25y5@66fodqy736kq>
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
 <20250930-topic-x1e80100-hdmi-v4-2-86a14e8a34ac@linaro.org>
 <uozgwot7yuwmaiwmqoo6ickblpqe52tnj44tnxcorygqxwou52@hksvktgq5zp7>
 <9d020a8e-22d8-4f1f-803c-d00bb912f699@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d020a8e-22d8-4f1f-803c-d00bb912f699@linaro.org>
X-Proofpoint-ORIG-GUID: C24OCDeA-SSzPz-94RmPP90W6W2tfRcz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfXx5pDd+86Eyoy
 d6D2KV+rB6bw6uFhDKl/+ZSLO79YiRkovhlbcCsU6O71yxzq72FtlzeoQCwATrHz/Fpun0fRWXI
 fZXVAairOEO5FbXQbzf/YHXqJz7nozfJN7/CeNEjWFliTeFgOFbjOZ0I6THEEVnU+8soRfz4AmR
 k40LUSma58WyZ3h00JrIGn7QL88OoZJR1FYUAI2vIIlqwPBUu/rAtyzIy0kq/nqsi3lZ5BgCVgy
 E4HkUc6Xun5LTWmeDydvXTdEBB9yFL9yA0bNkW5tT1hqoSfl1sE84pSOv1986Q7kAbwtqy27BxZ
 FCSeCRp81VMhHJ9N6g8kZrBgdTBLYxS7v6BcsJQYKamle8PH/CCs2jKGmF0UG0b+kdNr74RRLFy
 j8Cirny7mprz3z61ldM8sqesMa/GLw==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e0c2cf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=P-s5V6jcMkwkI3aNiSkA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: C24OCDeA-SSzPz-94RmPP90W6W2tfRcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On Wed, Oct 01, 2025 at 09:06:10AM +0200, Neil Armstrong wrote:
> On 9/30/25 20:56, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 09:39:48AM +0200, Neil Armstrong wrote:
> > > The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> > > of a combo glue to route either lanes to the 4 shared physical lanes.
> > > 
> > > The routing of the lanes can be:
> > > - 2 DP + 2 USB3
> > > - 4 DP
> > > - 2 USB3
> > > 
> > > Get the lanes mapping from DT and stop registering the USB-C
> > > muxes in favor of a static mode and orientation detemined
> > > by the lanes mapping.
> > > 
> > > This allows supporting boards with direct connection of USB3 and
> > > DisplayPort lanes to the QMP Combo PHY lanes, not using the
> > > USB-C Altmode feature.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 145 ++++++++++++++++++++++++++++--
> > >   1 file changed, 137 insertions(+), 8 deletions(-)
> > > 
> > > @@ -4167,9 +4269,41 @@ static int qmp_combo_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		goto err_node_put;
> > > -	ret = qmp_combo_typec_register(qmp);
> > > -	if (ret)
> > > -		goto err_node_put;
> > > +	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> > > +
> > > +	if (of_find_property(dev->of_node, "mode-switch", NULL) ||
> > > +	    of_find_property(dev->of_node, "orientation-switch", NULL)) {
> > > +		ret = qmp_combo_typec_register(qmp);
> > > +		if (ret)
> > > +			goto err_node_put;
> > > +	} else {
> > > +		enum typec_orientation dp_orientation = TYPEC_ORIENTATION_NONE;
> > > +		enum typec_orientation usb3_orientation = TYPEC_ORIENTATION_NONE;
> > > +
> > > +		ret = qmp_combo_get_dt_dp_orientation(dev, &dp_orientation);
> > > +		if (ret)
> > > +			goto err_node_put;
> > > +
> > > +		ret = qmp_combo_get_dt_usb3_orientation(dev, &usb3_orientation);
> > > +		if (ret)
> > > +			goto err_node_put;
> > > +
> > > +		if (dp_orientation == TYPEC_ORIENTATION_NONE &&
> > > +		    usb3_orientation != TYPEC_ORIENTATION_NONE) {
> > > +			qmp->qmpphy_mode = QMPPHY_MODE_USB3_ONLY;
> > > +			qmp->orientation = usb3_orientation;
> > > +		} else if (usb3_orientation == TYPEC_ORIENTATION_NONE &&
> > > +			 dp_orientation != TYPEC_ORIENTATION_NONE) {
> > > +			qmp->qmpphy_mode = QMPPHY_MODE_DP_ONLY;
> > > +			qmp->orientation = dp_orientation;
> > > +		} else if (dp_orientation != TYPEC_ORIENTATION_NONE &&
> > > +			 dp_orientation == usb3_orientation) {
> > > +			qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> > > +			qmp->orientation = dp_orientation;
> > > +		} else {
> > > +			dev_warn(dev, "unable to determine orientation & mode from data-lanes");
> > > +		}
> > > +	}
> > >   	ret = drm_aux_bridge_register(dev);
> > >   	if (ret)
> > > @@ -4189,11 +4323,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		goto err_node_put;
> > > -	/*
> > > -	 * The hw default is USB3_ONLY, but USB3+DP mode lets us more easily
> > > -	 * check both sub-blocks' init tables for blunders at probe time.
> > > -	 */
> > > -	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> > 
> > SHouldn't this still be a default in the 'normal' USB-C case?
> 
> It is, I just moved it before the added logic, but the comment doesn't really
> apply anymore

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

