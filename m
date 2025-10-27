Return-Path: <linux-kernel+bounces-871651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ADBC0DFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3371E4F55F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DE283FCD;
	Mon, 27 Oct 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="By4pgJEn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17827C842
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571152; cv=none; b=Afw0s+9dEscbNrNAG0vR3TZh/LSv/IdAdauVb5sI0+YbWTJ9j6FkCjJ6+CKB1deWlwvyA3u3HYEcblzMWo7mUAE+FiQNAmVv/m21vNVbZ6qivgKh+mU3EtJsqqHLzmWH6qH9Y6m0pVUv+OkNB/ktTMRL0OyEakqrmEOGokbJQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571152; c=relaxed/simple;
	bh=p681Z5rbaDJF06LN/mmHiGuUx0Jh34Fe6SopBwfasw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ08ac3gOEs/0AlFQOLb9mCfvAG6wqzbptvx0J/uZ7heftqb4YOzIY6xzAR4zM8roeiP0QU0F4QBTV59UX9JjT7CNTB2UurH+TTCIb5g7wuNmW1RyubrtuczHlJlX49JBLYKfg9Bkp20WyWwnga44VTJ96lDXYxq2lE0nLbet4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=By4pgJEn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8e18f1007544
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J2Uzmm4o+Wkvy02wbzWdLFd2
	fnNoKBhusnbJ+pfAWnw=; b=By4pgJEnETTbOjcnpaNXT/R2pezog73Wj9boC9dW
	SjNlmOsvywBlGsAykgQDec2HnAb60SzplAs86yk/0WPP81i7FP6ioNUx3FIud3T+
	QVeDTVfMOhbneO3Y1RNcGa0Vxuy3DSLgCfsBCQxYeBjJ9bgmhNtyXr8DX1jwp+go
	76DzORq/QLQek24arGszSgCkLlDoOxFkq6HnMuIwgMJVNoUsHEL5967NhK0QhMOz
	NEZSAPHJyQn1W6cNiu9fhtCKCoosd6qFZsnFeIJKIHJzvxazZ6AaR2koLcFe3cWz
	6HAjXqNpKolJ5d70tEitQ7HBXW4nWVGlTH4I6x9HJYA2xw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g4n7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:19:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5db1f7f4a36so2673293137.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571149; x=1762175949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2Uzmm4o+Wkvy02wbzWdLFd2fnNoKBhusnbJ+pfAWnw=;
        b=Qx83rZisT4h3LcZumZ/hi00pHyile8VDsp/u0H+T2lhvuBYS5ZVKcH5FdZ5pEtDWfo
         EVbOa6mSZqx3xFYSvsruBQPPnM4ZBI378l6Qf4NySG8FKBCFnAPLMkSyNUFuv2ABvRtg
         2TKpobj5+JPz0yXFBOrnYOQP4cujLF3xWlbMXCU1noEWIBCuIyLTQ/xoyhAtOAwIp6yh
         OiV8ZWaqw+ek0SOmOWecy7Cw42qgpXG/guVRWLnnQNuHBQch6oGNh8HMxl+zEoplQ2P9
         9O6h3G1AjdJUG/Pbl+SDtHefcTb7zxpiwjPy8NGIM4K2u+VqjzxgUp6ukfQO+8CM0cKc
         m0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqbI+VlpEjf9/dI8/RVsOLyEgl3B97i9E5TFjCyiENMh+xYNRjCUBdiYP9bFsH5bcaX9vMaFibGj2PQ88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvS5qWn/GQ8JmB7NcU5rEk3H8sQTBQUp9maTKzQf+hfLyIpBS7
	o72DAMhBggR+tJIE1BSeO4EKTcuWFTnto9syMyc4fuR2rtdtSSs9LMUoBeVa1fbdjj6tOdg3G3T
	R/7Xvperda5js4qdcAlXJ+BGSLyAtpdTLl2YMBB1ZJCD4RgCFQSpH9U8Nu5tZUHbiRiE=
X-Gm-Gg: ASbGnctAUIkHdF+MY/RRiwHCmp8rverNae/G3GA8lqcdXptcxNNqrBlTeqGgYq6Yx3d
	wxdQUxr/VKmQFZHDBXBjS/eGuA7chMDNBJXDZzPjM9MqksAO65N5ThRuDwcf11Vrb0zHFHiuFiY
	jwtjHw0dbrM5CyVaWNW+Bc6vTeKKhkXYwnQhvegonrMk1egv10LxanTV8R4fuJgdNF+2fSmhquV
	KyA5rKLCW/+F0EP8Jkw+/LZiwBslm2hw3RFAx1iyTOJTjzDjo6yEd/RmZdGLAX0hET9/w64dAlv
	SWLLrKeuHq3PiaA2xImbHb2DHTrEYDJjTipsKLzBTh61kCcueERhX0EyuSLfx2qaYS2XJUaHEJa
	h+W/W6BXi5x/4Qbz6QD0Dkq4YVjTpXQnGqIxXy/l/1oulSGAvUlqwiVbvesgWLAwy3KleMJpWfJ
	6j4dvktIVjswmi
X-Received: by 2002:a05:6102:6cc:b0:59a:79c:f277 with SMTP id ada2fe7eead31-5d7dd5af38fmr10917105137.17.1761571147671;
        Mon, 27 Oct 2025 06:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvGPuBFXFMD+s+AGYLbzxQPLMqSCxh3xUpq4ZLUYKahpArKmvvv89qv7QYWkqo9JVUBMy6qQ==
X-Received: by 2002:a05:6102:6cc:b0:59a:79c:f277 with SMTP id ada2fe7eead31-5d7dd5af38fmr10917084137.17.1761571146949;
        Mon, 27 Oct 2025 06:19:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59302335036sm2326984e87.70.2025.10.27.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:19:06 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:19:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID
 pin state
Message-ID: <34atfkavrxtv5xdekrlhhkxx4rxs3ueclxrmou5pquym5fsycv@i7mv7ssdlm2v>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-3-krishna.kurapati@oss.qualcomm.com>
 <aP8_oZlJ4466BEf0@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP8_oZlJ4466BEf0@kuha.fi.intel.com>
X-Proofpoint-GUID: BomLCFDhgN3lAD2jlTtxawGK875rUTSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNCBTYWx0ZWRfXy7l9bMhEjghP
 K6PtKk7AzxsQYhmrF2iga2SYT4ess3K1igFucPXFjIoK9sDlx2NuMfxAEI/2DcUZiRH9HUACsOQ
 t8jEO/kBAPNmL52GaXtAnB4HON42V4hSXyHP/tt9rIFZSz95N/zRkFWRESXQjoAUlxryWAgv0TB
 SQiOv259USQjLw0TPDr/Dg6lZv15B8uFBu2COonJFtalbombhvo6YWobe1cLsBkIh7kwdBG4Lvo
 Vj04SXFY2WwnC3Vy2YTHJNZv8Q/jHEyGNOQK2fha3Kah101LLh4tVo5LWJFQTdct7Exrjq4uRru
 1RI2lEEYqJuJiNBQIBrl/5jLTDovH0D4SJUO06rmVC+MJ39bJy+9EkYKG8jLSbSsqOP5GC6nSEh
 lrBNWfaX4gqvzY251yh7vmr33hYo9Q==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68ff714d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l5K9N5hKnuDr3Ur03xgA:9
 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: BomLCFDhgN3lAD2jlTtxawGK875rUTSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270124

On Mon, Oct 27, 2025 at 11:47:13AM +0200, Heikki Krogerus wrote:
> Hi Krishna,
> 
> > +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220)
> > +{
> > +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
> > +	struct device_node *np;
> > +
> > +	np = of_graph_get_remote_node(hd3ss3220_node, 0, 0);
> > +	if (!np) {
> > +		dev_err(hd3ss3220->dev, "failed to get device node");
> > +		return -ENODEV;
> > +	}
> 
> So I guess that's the connector node. Why can't you just place the
> regulator reference to the hd3ss3220 controller node instead of the
> connector like the port controllers do?
> 
> That would allow us to do a simple devm_regulator_get_optional() call
> that's not tied to DT only.

But we have devm_of_regulator_get_optional(), it was mentioned in the
previous email if I'm not mistaken. If we need, we should add
devm_fwnode_regulator_get(_optional).

vbus supply is described as a part of the usb-c-connector schema, so
it is not that logical to describe it as a part of the Type-C
controller.


-- 
With best wishes
Dmitry

