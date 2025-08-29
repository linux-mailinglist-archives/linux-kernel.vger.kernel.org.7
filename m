Return-Path: <linux-kernel+bounces-791356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07281B3B5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DA5B60291
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26032C21C6;
	Fri, 29 Aug 2025 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTCnqjY7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D97262FC7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455356; cv=none; b=uTBLXtKlOSzefEMv2V8VToF5tqdlrSdqKCJPNSjItL/uywBGbVBqjJ52KL+l83F/REST37xeESat0ZGgjx4RZbCKogQxY4iPTWAj51+NHGL7vH9T5/ovOSnXpDYFel1i80FL7C/v4z233/QjVDgtjN/mc+r/h95lmbdrELj5ZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455356; c=relaxed/simple;
	bh=JrE8rTg0mogycbu6/gTDLoIOWx412mSSUvbfqKnx000=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV8op71rh2KMBEIxclYnoL86Sb+IxxHBDufevmTx3RZyAHIhTTzfBwVeqPW9yT/tcxeaxhxA2tcvGUZKtcRw2mZPq5BzWL8SvXA7w2u0l7FqwgmnFBbqDoioWwEETN3cVe3UjZMYZ1fSqKOywVVz8xQXpf9wNLmqsV49vvvUfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTCnqjY7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85EU0018588
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Sa6+BmSTVQ/SHN0N7L2jpZkX
	/bOZEoJbiAzVVSiaj4s=; b=cTCnqjY7nC+ZxpkGS4jhKDvVTEK6XsdAfqh+Wlcc
	rBzSon9ls8YXlvBQ10LRW6K28X1cnX1495nuMsRSEkNbqaO3pASLIvg4iXnL9WAL
	fCz6u6dug1iNEPA9xEajnXByJ59WvNd+Be62g0mcDimjP8tsu9K79RnpAwtrW9yE
	y2eNT6ySM2o2bkbmDqDTSMUPb/MZzSxwog5uZM921EWSrvT6pp6prPbNNxJlu9HI
	4TmjKJq9YDFvIvFQR0qp6dvmD6OZmshsYYROpOd13fDa8KGxAZOhJmbsDmdGlDUV
	Eb9hpfIHhcDu5iVXe+SIqxeLHlg+cNp8jyz6cPTaSZS1CA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67kdv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:15:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2ecb8e64bso23699031cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455351; x=1757060151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa6+BmSTVQ/SHN0N7L2jpZkX/bOZEoJbiAzVVSiaj4s=;
        b=QPDb3+QqfyrXzvV5jGWWopiUhnGHdwjO3hsExTeC53mf3qLxWj7a2IC0SJxDNQdDDb
         yHxrr6f5YubM5WruDhm5ZUPddMwSfzf9Di5Z2KilJCoLYhsa/+Jh5Nnw9nu6w/RvrPV5
         iCNDDH0eGutQyIbi5BRVpjHqws6tmUFGJW6cnEBDA/Z39wUEI0O8Dv07cT9koILAizo8
         zptw33dxF6YSfQ9Rt5sNsxQkoz7K9zBitRk8+EnEJYWcqSAly7zr1GFEYYAN0kOBDf9K
         mUE8OqLy6GEXKiBCXn63XYhNmOJ0PSSOc0DJoi2lmHjCaE6xUfZANtIcX1Wmks3JXwS/
         vf4g==
X-Forwarded-Encrypted: i=1; AJvYcCX3JJe4kt4n152hf2vKCrpdI/sNqBCJrv8D17A2VMN7J2treGoBKoOXeiJ2B/xAKX5E18snkVap0/1LLoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTYE6K0G7jxFlOaJ/yG//0QD0ozwpR6o9hrFRRRSBa4fAvKws
	tuJr9SQbMiQKrgSB6bsf3YlcZgJWKuk0R1QbqvmJXqmrND4mu/qIOSBjejABjOKAKlfeQy1PX+i
	om1KNkVW+9CP1ZRLHHskuFZezbgS1iP1LPDU+2TyJS7wvzdIJsn3FjR+WKqZ4FUWquG0=
X-Gm-Gg: ASbGnctee1/OT3e9dJKeRMHidIAPW6SdeRo7cfeY3hBsP5CLQ+HWEZp6ONwnIfPQ0rl
	eAF6j0/Wk2DOwY8Q4R7ZHot+TNlp3g4eqI7JeoWVeN8r6xnZfPrEHGu9nezt95T+Qzz8OhOoOOK
	j97TrAdeufMP0ILx9eEwM1gR6E6qZ33c1oX0X0xCA/2Q/zv6cuf2sdiTalSzJxEKXVOWqdX3MxA
	cgUWnWHrcMiojngrtZ31NkNbf/ud0Mwd7de4XYslZlQM6Edj073eqyT8ZY2sfh0vWJjWIM9wgqf
	DM8ixQZ/Cqjv4WDvMA/LMR5SBnSUrroq1FP3oDO9gGBs0Ucq9tLmZji8WN/qS81yGKQePpF9obm
	ovHBSFgynfwmFCv0nbZcuHw1lqL9NO818RCpCbNAbW+bxDhEM7Pay
X-Received: by 2002:a05:622a:548e:b0:4b3:a73:2d5b with SMTP id d75a77b69052e-4b30a7332a3mr33990771cf.11.1756455350893;
        Fri, 29 Aug 2025 01:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2K+f3QGOXMzVuZ182apan0UZ0FGuT2CzVC7IkNGuxO5ayQO7W28gftKE5/UHpSe0BD/Uz6w==
X-Received: by 2002:a05:622a:548e:b0:4b3:a73:2d5b with SMTP id d75a77b69052e-4b30a7332a3mr33990531cf.11.1756455350473;
        Fri, 29 Aug 2025 01:15:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a41910sm434735e87.130.2025.08.29.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:15:49 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:15:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: dispcc-glymur: Add support for Display
 Clock Controller
Message-ID: <lzn5tn3a7sclqp3bg25k7tf4l7kosoww67bxnvlyazdrtblzfx@p7i3rycihtzm>
References: <20250829-glymur-disp-clock-controllers-v1-0-0ce6fabd837c@oss.qualcomm.com>
 <20250829-glymur-disp-clock-controllers-v1-2-0ce6fabd837c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-glymur-disp-clock-controllers-v1-2-0ce6fabd837c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfXzyoj3ZV8wPsS
 lA8haH2lz2UruiLDLv9GCYsE60yVIpZ0SrKH4QPXyfFHx9BtXBRU+8w8YcnRP0sB604gwXXKVcJ
 6HQcf1+MuRhKzhIXsWTrrAPNS4raUFjDwtIvTHwX/qSpaQAD7SnyLKx8zdCECbmAvoUclQJJR/k
 4GVarkEeuNYIdpu3LIyUMptYUbLOWu9FdpcwZYVJTdlD1GQXIJ9jaNXMvzKJUuEiuZ8+QWA8IwG
 Rva3Or0TKRJP/pLb+rHpUWO9AL5Y8s12R6ym4vbHar8RvKIuJGGXmppoPYnSDcij8vQ9jK2jjUK
 gcRlyW96GEIs5+BV0puvmTgIM5S9D4ES+2JJaDU3QySG/sgLBCn7xHZnqbgD6LFb2qjU2Bk1A9k
 j3z6+dqS
X-Proofpoint-GUID: GZuWFPFvpS1VvLfQPV6Wo1xoCQdixQkM
X-Proofpoint-ORIG-GUID: GZuWFPFvpS1VvLfQPV6Wo1xoCQdixQkM
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b161b8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=0pr4t0U7TAZz76_aorIA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

On Fri, Aug 29, 2025 at 01:28:04PM +0530, Taniya Das wrote:
> Add driver for Display clock controller (DISPCC) on Qualcomm Glymur SoC.
> This would enable the display sw driver to enable/disable/request for
> the display clocks.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig         |   10 +
>  drivers/clk/qcom/Makefile        |    1 +
>  drivers/clk/qcom/dispcc-glymur.c | 1982 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1993 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

