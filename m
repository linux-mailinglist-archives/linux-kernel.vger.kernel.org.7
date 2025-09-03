Return-Path: <linux-kernel+bounces-799054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85DB42666
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C7A189CD46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB4A2BF3C5;
	Wed,  3 Sep 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8G4ebPH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105002BEC2C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916088; cv=none; b=J1uvtbNbALBD77gRuHeimQcnlDBWEHsJBye57kPzDVXiWFbELOe+5axNRDdUYm8CN3l9uL0xmiTeDDlT2swFrR7+IFPPS21nrqvs1DCYIF60gO5qO8P8OgciehlRgRSAlLJrnVHHHQaYY+gQzDfJSU6nZ4faqkgdBpSiE7eX+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916088; c=relaxed/simple;
	bh=15e4KV2uKHJPOVsBfG9vaA4N6uUsqxcFksJxJYT4tQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlMeETCkGT8Nc1YL98XCFQaPmbrEsvg7Khb+1Dkm5IENDlHTTPsK9J2bFAtWlUIwQ56TGO3CxzKXvrIgnyTHgi8G4FQvJo1zZvsWICuzugtReUkLN3sgIKmz5Z2BUfEt72xTQM2pyT/7drrByfWGc7N/7g0zeA2BRDD7MLO1crU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8G4ebPH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx6EL005564
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 16:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p7A2A36WC5hNzLUFGe9+5GUr
	6YgZGXzB2kAzl3I+Zec=; b=m8G4ebPHfdBWbfEBqrnyIXVeXIkMcLttOwjhy+p9
	aESVUv+N3OBwniKB9YFGpLkV2PwYTywpf7MyIj71SeDf3kj8yNPBkT00pc41zXhU
	VCxJqpHjxIe/P3S2LmI+Xm1C6x7EZlQoftYl1Q2w1FFFdoW3u6q3B9kVBcvBjrS4
	mPTc7QQYjlIyTRZdDOa61TLUg8zSnmEQFHoBfrDMDT9NQZ4r+xxFwkIVZMKWuFT/
	gZeukkl6iEqfIKHBriMW4REe5Xn0OFVvAU9d3lXy8Dnb7VF1VbUY42CAUYWAoPHy
	QVbC8Idg5WMreuITfpxMbiLE/FldfFDY06dtJyktrAQrLQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjm9rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:14:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724bca103dso51753b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916085; x=1757520885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7A2A36WC5hNzLUFGe9+5GUr6YgZGXzB2kAzl3I+Zec=;
        b=XxUKbrTC0LLXBC2WPZlR+Q7qeloTfBTLXeDkWny2hEQ9NBNdvAjfET5tpsBkD8DC+v
         cZkawDrL20YKqKro3cRenZ647bVMgfeHT5y1sygPDdEFL/BSZyOkhW76WreqWqGiibEe
         /ancwTjY5JqytbTa1mH6NXn6Skk4TXaPGHCyT8NWMXk8cUbnVmJdfc3yRCkXC3yjCNtl
         KVAGehL2NdYuy2x6xm4C8saauxo7DzCPj1ozoHxwA755EzBx71HrJG+9eLxJGhK4X8Dx
         w4DaA7KZ8InKVvRwm3bLnx1Agad4St0usH5VwwHTLrLcHjFQfvawdTwLdHLS0uFeyMxd
         W0uw==
X-Forwarded-Encrypted: i=1; AJvYcCXSezXk0OVuJ7R2fuLBBW63K1Z8gMcGiNI9AMy7eIfAjwIkqgVplMTC0kUVnpyOlBR1kuTYJvhR0TF3aP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUN8m2k1JGgwDXnj+wl/Sx5kFKLWQ28aSOawTH3VsgQ4Z38V+
	YvLMvKI8GNM4GqDIz04ZT/uPgDRNKFMNRCA/KRIQUdLnM+Gm9LcGkMq423HaxmC0RX4SF7BvQGx
	fRG2NjVJQiqXY/iraVzIVciJrrG0T5ZasnIIKz9eyglZzL5Ou3EbHrbcSl/W7vIvhg4s=
X-Gm-Gg: ASbGncttVI42hm9qFrS7iUYOeWN24danIniGzYBsrMjoJjrzJICEkz4i3EjsYc/BeK/
	W/+UMe91zyjlQAPp6f7KPIvPRQ0bVUlly0EzO78OpI7YJ0Wj3uLVm2zkG3I4JLcFQTomaCVGgBe
	fyRBrvt0AzsW0jdby+DItfNXuinS3QiFktJmfxw85m1cheDLKdZvoijx6bCk4B807d3uPFMJX1c
	nmUz8SSEKtZ5rrU4npU6AW1Vm1eDSGTeDUbSPjfep02uBUiaXbSnCjQsFyhr4SQuUW5dzbCzTZo
	sG3AB2OizOZ44hLgpebLB/cxQ1t3zWyQ/JhbeTCuo3ijil1vXQ06zgUiaRdTvPV9bsm3
X-Received: by 2002:a05:6a00:80b:b0:772:50c6:47d6 with SMTP id d2e1a72fcca58-77250c660aamr16685507b3a.2.1756916084639;
        Wed, 03 Sep 2025 09:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFN8Fk9FYilCvfsVTUpXK3eaQZpWzMaZJtyrt/idToT1wN7680TzLMcXUUYYpYB/Pxpe/CGg==
X-Received: by 2002:a05:6a00:80b:b0:772:50c6:47d6 with SMTP id d2e1a72fcca58-77250c660aamr16685461b3a.2.1756916084165;
        Wed, 03 Sep 2025 09:14:44 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77285bb2614sm1757820b3a.58.2025.09.03.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:14:43 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:44:37 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Subject: Re: [PATCH v2 06/13] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
Message-ID: <aLhpbRL/mNfIMg/P@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
 <facc2270-e700-49e4-a7ab-3b473e343ccb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facc2270-e700-49e4-a7ab-3b473e343ccb@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b86975 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5vNF0T9NdgVroHtUm1oA:9 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ns-I6dn1QRIwZzttzPlfJACTj2sN3xKk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX1UNllFxgIOb8
 QIlSCYqG/Xw9ikasdpePpONGFeHsY65V+mwcaBeDuCGhnlFxFyF57rXx7yRdwCchl8Com9HYqqg
 5Yl7TFj00DIN/P4olVhQBmy8Z7zR+XTym2qCVvoqIRmvsB0ELwDEtgbsoe1ozIHZP1a/9ZT3wqo
 4c1+2SfauAciTnPJ+gDFE/7R+7Lu23QswC3eK6YRI2fx7LgIhqoub3xlKZ1gV6Mf1SF5PrBz1D7
 3bzC+5fUBrcV6i5b2fdcoihYQg6xWHbR3XW79BbwHDfE8V5o+vJ0M4mhOw6onQtlyBLNnADcZi1
 QgXznfooXWzVLX0ZIjBxn/6l32LjTjIHZUsjy0GhLGnH9w0cwXo9B8jyCNQUEe3ADspTQpUX00l
 oA+9Jo3k
X-Proofpoint-ORIG-GUID: ns-I6dn1QRIwZzttzPlfJACTj2sN3xKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On Wed, Sep 03, 2025 at 05:50:00PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > 
> > Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> > 
> > PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> > attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> > 
> > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > index 196c5ee0dd34..7528fa1c661a 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > @@ -379,6 +379,40 @@ &mdss0_dp1_phy {
> >  	status = "okay";
> >  };
> >  
> > +&pcie0 {
> > +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie0_default_state>;
> 
> property-n
> property-names
> 
> in this order, please

Ack.

> 
> Konrad

-- 
Regards,
Wasim

