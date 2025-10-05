Return-Path: <linux-kernel+bounces-842482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 490ADBBCCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 00:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DED5E4E427C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 22:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFF23D7E6;
	Sun,  5 Oct 2025 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/byXwH0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D61534EC
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759701932; cv=none; b=MjzKr/7l7zXrDPPTPw+Nj0dqnEFGpR52pB1GrLZbXgUZIE0eT7Os0ZIN87uw2wElJ8qzmxIsD5F4TIuUhjzzkzv+Bta6/zYhyxPTbKH2/0M5vaRprC+Lg/fWSlZoDqfXUKvnlIlONkU1QXv30JlVjbZdJ6wgQnzEq1gJtwl9wiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759701932; c=relaxed/simple;
	bh=hNTObQJ/BsZJoxgMmd3qjo8J7+vl7iZP+T7OGKXxBws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnstIGgY9FIYwW5jO9shWmvHXLbJVNBgQHRmeVBQ1dCM2jTMNqgc9e18NnYcIZuKmKwNdMUmdD7r8vPa0QfbSVCP4YiI/ivQQErYRlzb08Xf6oHBF39nf4EGlCn5DDGlNT37ECe/OSWnkv+8crRtXhz3Xec9nLkhWvOfmLb953I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/byXwH0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595M05Zo013760
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 22:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YLLQrA8gIYr0kPOAaAByOZtF
	67X1Nm6784e/ECSQZ0g=; b=d/byXwH0rt2gBEvULpARCyoIDJ+xBd4zhMhY6v8Z
	mGvY9TUE4CvvErwk4lmK3H0v9Ohce3hgeaiScWNWJgw/zZkUM8bk+rC46QCU6fiH
	VL7zkpa7+ivBgvMkK4O2baqaS3TECTkgzf1Ej/AJ+xUNqr/NFPZoO5kBleC/Rbry
	PyiV0NnRu4Z/25Ygr+oRJp7k4C1TItIlu5ev3paHsiCqIS+l/PcpmBNAzciwdEbB
	R0YkAvo2Hs87Gaqf/ZbGbxxZkJc9mdtB7hNoNbVNIItj0dW8IUa5oFHtH/K2q9B5
	HtKaPgvf0tyxdiumJka5CngyCHRrldYFIPfhw2h++13hRg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1jfxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:05:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dec9293c62so106161471cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 15:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759701929; x=1760306729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLLQrA8gIYr0kPOAaAByOZtF67X1Nm6784e/ECSQZ0g=;
        b=WhY+f+I6l5mHw0vsFRaKCtH42X8y4BGi07jj3ctzSlHoC2+Fd8h1ySTR56gkO9dcu3
         bRez/6gIcJRN9BDJ66IS5i44Wwvhhkcp17M8QFYAHxlkm02bJjmxBcYX9PizjOWuALnb
         F+byBcB1mknR9zYQOi9sAW7wK4txwAcIsn675sdloYvb1wPolUCJ4Anh2mIrZYd7ye8p
         UKFfE9axTrOUH36YKU3tU5HY1da4j5xe4tVnHh18/QTCIpi0N0B1p0gAndcVAJbKphEP
         FdHVrz/YNgA2pdqRTRBajymjszCRFyBuZ/bUZ8nWQ1mtykcc5t8/ci1WXGUlfPSX5HO+
         qT+A==
X-Forwarded-Encrypted: i=1; AJvYcCXVOTyAcdoqk9p/Djl8vAJdl8kmiw2IBCTXDFpoD3noqyFtZaF1ag61d+/zRA829gmxIwyuUXaGgFQay+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WQbL4oXpa539q12mff03kIM7SC//k59PbwKZFF/8Jb1n0EAH
	WgHcK7YM1LjqhcSDoIL/X7GpxccswFSTxwKDNm//Png5RLjXjbaFTRlI+pORYkDV8LwG4ZapSP5
	XYONO0WkQG2TLwQiOozyLHj2vM7trGJNfZn2dqZILOlVVHXsBMmOCuGJDqQXWiW9l0ZM=
X-Gm-Gg: ASbGncsdx72V4nhBBUa1gpdYIlfk9yUahZiAMkaXAWchk6TGztJkglI30NxhetbaxJf
	pJr96iC+FhyDrMY8UptZ0kvM2U8TeYdqcpsJEjuVFBlfkq2cnLuvXVBrB4szm3RxadELbnU6Ris
	m0HrG7IhRIXhxlNOZEZ0bh3LBrt2wIyLUoqy7RjqxP1nI5wwaaSATS2PIXfrFJgJHzEijBDCw2z
	lKlRuEHsw+Bnbno9i6J5YiWTGa5t/yXavTh5aT5m6uZbh5KiRsr4FKgcziKknMiOfBQKJcfnHwa
	g8F5gJbZ8YzQT7ZU9+lolz3Yu5opNPsLdpIh42MVtLAIKSAXr5ZPUHNg6kCrGMcXD+xyp6F4PXo
	DcVf8cb0I+1an91wFTf4xO+fxb4u6zwdEXZ25huwMMcYbuGkfttSkKZ+bsQ==
X-Received: by 2002:ac8:5aca:0:b0:4cc:9fa2:f3a3 with SMTP id d75a77b69052e-4e576ac38e2mr124543711cf.60.1759701929037;
        Sun, 05 Oct 2025 15:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQaaH27LewBBN8pAy0wFq08LRB80W7t0WvFe+8d8xPJGr7fWp+GYQfzyZVGrPGj9rwvYf3Pg==
X-Received: by 2002:ac8:5aca:0:b0:4cc:9fa2:f3a3 with SMTP id d75a77b69052e-4e576ac38e2mr124543361cf.60.1759701928549;
        Sun, 05 Oct 2025 15:05:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm37768201fa.30.2025.10.05.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 15:05:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 01:05:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingzhou Zhu <newwheatzjz@zohomail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
Message-ID: <ysmkpdicoxuspqe7emzqbbdvigs7yorawgmc3ccebghahlyfr6@z4b72icdnp4p>
References: <20251001142107.21860-1-newwheatzjz@zohomail.com>
 <20251003131925.15933-3-newwheatzjz@zohomail.com>
 <pbrrkfjrqoyj4qspdrordksfueyqejxcsz2oxqctczeoll6ywn@ixpaa6v4mwlv>
 <5021717.GXAFRqVoOG@debian-vmware>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5021717.GXAFRqVoOG@debian-vmware>
X-Proofpoint-GUID: mdDfwfEK9mqpyY8GlW8pCJ1FVxU3O2-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX5XiTWfiBMG3R
 Q86Mvi98v094maMyxSYJ7XOb0w0fa29BzsPAbabF8jUKxBpTXmFcI3bD32DHkOi3Z+L5/A9Gc9h
 XJiVkrLESqhKxQP7XGZY1OZ6SMmerP1C10Wyi6Wre5GnRb5w2dFn+me/FnhGFI8rpv5CP+n3xo3
 mWZLktLJxgHSZGlBcI0ynImygynDSb7Cm2sq03FCf9RmxN6swxyhiPPQa0z6A/7IDOZquOxHg5+
 Es8F2sfB3gXlEzOVacgI0+svHK5eFGzrHoKSLOR6xuVJaqyPo2Ghhrq1xVPPpef/LpGbBzOtcUU
 WqEZA/webcjk0EEeg3gS63DAx/jZrC+MCPtE1oPwZHQ+O8cw90hYA9hFeG0SO3nRX9oxTEiymMQ
 vfKv82ZEtT6aLQDXDdI6vgeBLMw0zA==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e2ebaa cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=1XtEOhATCJ7woTDKNc8A:9
 a=CjuIK1q_8ugA:10 a=dK5gKXOJidcA:10 a=bfahJYbJofEA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: mdDfwfEK9mqpyY8GlW8pCJ1FVxU3O2-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On Sat, Oct 04, 2025 at 07:53:13PM +0800, Jingzhou Zhu wrote:
> On Saturday, 4 October 2025 06:33:27 CST, Dmitry Baryshkov wrote:
> > Did you post the board data to the ath10k@ mailing list?
> > 
> > See https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html
> 
> Hi, I submitted the board file several days ago (see [1]), but there's no reply from the reviewers.
> Is there anything wrong with my post? It's my first time to send patches, plz let me know if I did
> anything wrong, thanks!
> 
> [1] https://lists.infradead.org/pipermail/ath10k/2025-September/016495.html

This looks good. It might take some time for Jeff to pick those.

-- 
With best wishes
Dmitry

