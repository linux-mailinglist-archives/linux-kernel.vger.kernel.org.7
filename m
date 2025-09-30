Return-Path: <linux-kernel+bounces-838082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C3BAE63A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FA2172258
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC6284B2F;
	Tue, 30 Sep 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prJio/p1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C286B26A0B3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258957; cv=none; b=Cv3FAw6lbfs8q3hIV1QY82AIAN+YMK7NpNvMu9hjSiHwHBjo8l4uaSiv+SaBzZKIn/obxD25y3+HpzCJ0TOTEj1C70r8HzRk5UNuyNS2rsoEQxoH9Of16cQx08h/KAVm7ek2U6EOTmvIMy/OWzWEJ5ZNLf5fKt4b7zch+ZgsWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258957; c=relaxed/simple;
	bh=XaKjIs21h7X96FaSfZ/LjO9yTxhBXM+kXjoDRs+GPjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJh085ahTfxibsI2Wb1kXQ+7Q1jnsBxemXvdEIYjJFc+M7uvo5Meed6olbleYZCDZAbEA41VZf0y7XHSBGZo9Qhs4lXpzPGbMKn/YUjWxDCpB73bTGKIH2V0y7yO8go85lDHwe2L6/UlPDDmy7K7cpdsjiV+12Q+4OOYrRBstcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prJio/p1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBbERU017818
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GXlbr7M+4a1GxvAP+G3ZXjJw
	cK9AWRREeeh4emtmxmk=; b=prJio/p1Pa9iQoymrsQUzUwSwVlmy62rZ0boPOeG
	5Co5oHJaznpcAf7BJjir0I0ubdKav7gNDPOI3BNhzvNVU2u1G1uhd2a06abQovcb
	/saq/MhHYC92LvUIaaB4jaXLPQPJtLSaK0t5ErQB6rSk7JyAd3xDQkowIG2rxbUF
	957QygvR48Eomfe6HOQ5Stw7QNm7S+HdvSFGVn+tlzJkmY1II40Vvdyi9BTLN/oG
	i04nl4mMg1WS4TFSJNoHVcmPcipJi5BoYPhGwlfe+D8b8gnSbpNU1REPcDVYQYl4
	JGYK0P8WVNCLk9noVXZFSBzhqetljnENIu2G8LDgl2w9cQ==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80ttac0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:02:34 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42a076e4f9eso46551735ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258953; x=1759863753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXlbr7M+4a1GxvAP+G3ZXjJwcK9AWRREeeh4emtmxmk=;
        b=v1laR4tg+vaKeHoZ6uoCp1jmd9cynNocpTr7oMZhdZ4666B+faGBk8hIDi0cDEW80o
         2zXAVwViBhmw8BnUa6aoczbVcSaIMY3SDKsrB6PMjvRGYRePVOcxQ9JJ9sVINf0LjkPo
         C11hI4CghBGQBG1Q01bjC6Cb/pwi3yURsvVJXaXnG/o5OnFCCz5LJPGXOimyOy2c6B4N
         tsH4xwkV71yF+NQrlxxUaerziy87nEqvZCFQ5ZAjyruHEKU7jmlkijzm1QqfE2dHU4ui
         y130uFocGijQKelYQ/NNQ0605t6/31KYDdmXup95ynEeJlLDLxKgs9Mv0jI26noEfGMJ
         DPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVmV6aTAUIQO5oSnnXxIvR4lMGS9Sp7jqk2/Y0MAWAPF4C2IO1gdfRLB6K2yJ+CAQJEQOwPzaYJVjYNnOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTI/KefnzsSd5PLGJ7c3B/rm4MGrg0Ub2MH3+FWmRV5fMziF1r
	XLQSh3GoiwQr6VDi3O77tR6i4cx7TKvlu4t2EXaD3tCEbRJAw1KZk+pwaxZjG0/+PZ9g+2z9ZNy
	MWifbY5ix2jJOJfFSnqxLSWrnkX3Ysb2LaHgjhrMIrBMMvq8RItfZuhZqr2Iu81B31jk=
X-Gm-Gg: ASbGncs1XOkGG9C4ok9Q9DHQtoVmNWc/+RuB2INjupUPm22hT/UymCc/xKk88im1FF0
	plFwZ9S3ehfl7N3OPRh1M0T+xsemrEaaZa1+vNVMtyfMfJNDcfnEAbXUZXAeHlX8cIrptb3PXAp
	j5ig1dVDrekgmgnqyaakF5VmJ2lYt5yAGclrmMlsS8DEFzikuyGpf+C/JriFimsN9EmC6CnGAr7
	w6589zkXUgBIAgYxt17VJ8YTVGu8xH8wk878rWGAuYzsY9riLw3RSTuhshZ2CBf1OWx6yOwJqpx
	O7Ndrpd3zb1L6Hi7IWBoPITNxFuhWGdlnoinwWsVA91nG//FVJ0v7pbZtbiqxteuUwuAOzF0PnL
	QTacb8StbNrZnhQWg7UdwfELtVI1keEb7gj5xOTDqiZDJFF5e7Am3/6nHTA==
X-Received: by 2002:a05:6e02:230a:b0:3f2:a771:9fb3 with SMTP id e9e14a558f8ab-42d8162461dmr18055325ab.27.1759258953246;
        Tue, 30 Sep 2025 12:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJV3txOav9sQu2ukayU7ugj9yuYkFavKZlUgXjEWPN2HKtbR36iIvOChi6ogqZ1DDolHbXtg==
X-Received: by 2002:a05:6e02:230a:b0:3f2:a771:9fb3 with SMTP id e9e14a558f8ab-42d8162461dmr18054575ab.27.1759258952745;
        Tue, 30 Sep 2025 12:02:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7fe6b29sm35412471fa.63.2025.09.30.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:02:30 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:02:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Gantois <romain.gantois@bootlin.com>, Li Jun <jun.li@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: switch: split out ports definition
Message-ID: <hio5xdgjb6oxejrnk3hy7ylro75p2ebqa6oczyuwuxk3xsbp5l@aewbvmuk3ldk>
References: <20250930-topic-sm8x50-fix-qmp-usb43dp-usb-switch-v1-1-060568de9538@linaro.org>
 <vwlshz5li23xlthn5delxwxdsdci5nc22iey3xih4qf5uhbory@clskdsy64xpx>
 <426679ae-03c4-47d5-895d-7c927b2c3b07@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426679ae-03c4-47d5-895d-7c927b2c3b07@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfXyVTfvVVHKz1O
 fTgpjG0SSbKFf3kEdZ/sTd6zUo1rlrqDn7RcsUIiAIbE3JKoQAmjkSv636rmdx1DVJ4DjL2hz4y
 qz7srmZq3EzI9gMXVzcWS5QhEniQaK+H8+foHZAZu3UnXPNBgQ+FGHHZVlwi/wV1wjXQeV+RYxA
 xAeb02EghsQ+hYcAb1h7nl5DJskNt1xOS0GbJZTS5h9FWQG0oMB9pKqpAdxRNT/Qt4UoH5Bw614
 0nfxAWCMeMX9jB1kfJDz6WLa25VH6CVL301SnQiw6Y/Ue0CxshnzRPwDG5t3LWDe53j2EPDhgvB
 EVzgPeWm8y2DU96SDzIyikuEP+thktrGBFWnOUTsX8hqhJicaQygWfYTy2/eNs/5frqX7gQdrBZ
 NHI1Y6hzxg1lI9r8faVDc71AXdWqiA==
X-Proofpoint-GUID: 6esyZnZXZcGmi94DmFeo2f6jVJbdQlEh
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dc294a cx=c_pps
 a=5fI0PjkolUL5rJELGcJ+0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=jIQbB08qyBSz40biqjoA:9 a=CjuIK1q_8ugA:10
 a=HaQ4K6lYObfyUnnIi04v:22
X-Proofpoint-ORIG-GUID: 6esyZnZXZcGmi94DmFeo2f6jVJbdQlEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On Tue, Sep 30, 2025 at 08:48:13PM +0200, Neil Armstrong wrote:
> On 9/30/25 20:43, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 07:17:21PM +0200, Neil Armstrong wrote:
> > > The ports definition currently defined in the usb-switch.yaml
> > > fits standards devices which are either recipient of altmode
> > > muxing and orientation switching events or an element of the
> > > USB Super Speed data lanes.
> > > 
> > > This doesn't necessarely fit combo PHYs like the Qualcomm
> > > USB3/DP Combo which has a different ports representation.
> > > 
> > > Move the ports definition to a separate usb-switch-ports.yaml
> > > and reference it next to the usb-switch.yaml, except for
> > > the Qualcomm USB3/DP Combo PHY bindings.
> > 
> > Isn't it easier to make QMP PHY use $ref for port nodes instead of allOf
> > and keep ports definitions inside the usb-switch schema?
> 
> Rob asked to not do that... see https://lore.kernel.org/all/20250905175533.GA1000951-robh@kernel.org/

I'll respond there.


-- 
With best wishes
Dmitry

