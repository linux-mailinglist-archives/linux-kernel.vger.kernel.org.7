Return-Path: <linux-kernel+bounces-776346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12756B2CC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42233B0C57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A418319844;
	Tue, 19 Aug 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkOEH+DI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5102E2295
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628771; cv=none; b=fQYTNN11i8gzg0GEPKY98EB2oHNcsfV4L5DEDZvSe74bYQQgFlqK0anr1TmDV/zO3ADhKjyCjNkfnsc6x5uBdH3qarnqUlClhUF2m9/8afeWlypMeII1YjqnbnBKc7neKGbUMKMBiOZtnTNAq8MzDYE8A5W/4UvY60cmAMkfGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628771; c=relaxed/simple;
	bh=DphpoI7NXovRpi/mf9M/ugrTSvVQEjkllTxUfrvVcAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmVz+CC/Np7Nz4svKLNkKpzStZ1vkwzcYDCJPxJxN0xL8f08vvt+HoKkH/6Ot6MHCRHPNSUmNPKEQiXirnZhmkKZxQMXdtgo/zlU5Wvz2SkP4alH3KTXEJ53lOoNqhDaRNYrQixB30UiJ3vn+lvlqRzpInQxcfNvf4y/yMuqnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkOEH+DI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHY2Vr008283
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lfYBgc3axqIAGUVU7JZyFsZe
	IIPCOJtWH9T/sg37IAw=; b=nkOEH+DI+y1tFw78E+OAqO/2Y28QFKaD0Jaoxznd
	kKsEGK1YG53mSeZ6IiE3ARCozJh4JO8oqH9o/L7bFC02e/RqD4MuGtXeGTgwgM1C
	NQZ9ualhAJMbsAtUuxQ/q7Rhssd/FnN+zWklmFritO61Xyusd26YXzPRj88bzTxt
	hDTUFZ3rlj7I+vRULOZne4wH+7IrzwFB0iFi5dmhNFZPuJSdYX9GGaMqtakn96NB
	4gtvnYN/JxzpL0pHJy9hAGXd2FHhMAO4ohjtlI8JXd3mOCF5oDWn1PDwlV5N5txq
	OofrmDEZ4niezWQxxCryW3/bJfLiJFzPbVZjt+pwB8IoqQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99skjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:39:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9289280dso121618696d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628768; x=1756233568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfYBgc3axqIAGUVU7JZyFsZeIIPCOJtWH9T/sg37IAw=;
        b=RXFXcOgF5LoByAWKcJLe5KPnSZZG9Kt2W/lBsweUF6Fzbh4YHmeoLbHk4MYn63bkDx
         lxvMBiP7lR5Rv6Kk79RxBh3+Sj6955sbw2zC1eoPWipQ72Pe9pUYLTdzJkJOy90Egbdj
         Aco4hGbi72s/d3OP0aa5z1o+uY/LER6Y1dcpZXOGqyHTh1ehZtQA/Zieiyc9DMlQsfcs
         J39e5KqVIC0J2IFwCu71iaJU4Rzj8WnlXbGpVMdGEA2RoI7nKkH8r5ox+j+tTdCrcrWR
         FJsuTtgKdgWQ28XqsyrM5/mqp6eongmskzd0/JS+ZPACngD86Las02Z5NLCmW7kEhJk7
         8xYw==
X-Forwarded-Encrypted: i=1; AJvYcCVy9aku6yRh/dgW/J+dw837p5SYpss3ymHHvi+CiUzuJSlKDiQNEQoawFpLBx9b51hBoFPpCvm9IeqK080=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXBZP1XfSLlitScgOp3kWL9ltvfNF9LwEIFO7569tG0dC1hfX
	YSVY2ZYkTxJyP+fUZ9xexs05844x1dYBps5FhRbZeLt16rh2qSX4bw3Vqy+cl0Ogd7oHkvsZwtg
	lkSP5CTBUDp4VDorSf39G73lIRFR79qHnP/3wNelXEWT6AlIyWPu7U+hyNWhGPArkGpU=
X-Gm-Gg: ASbGncsvJK5SUkJT6CAr1Pns1/I/3QkxxEkSGKYvnuLC1XVuuEE1b1m6/xIuD4VJ7hn
	K07yJmkKUk+Zv6dJtjV9Qb7EiTVv0CnUI78Rs9ItYFmxkv4torh77rP5bUiy0/BXq9xotYN1Qjs
	EpuW/oi9giETHYmUXmyYzP+wL2kcz8tnXwDujADIEJDTS+El5uZtBOQogWfQMEuF3JhSbAFT4/y
	YEoFXeJYLGZQFYjPW4pFRoFBCxKLwPk8/wHDmDm9+FPFTPHtT8moxepCqw4EqqifTjbaGuMfdho
	DNNqNtsxkQ/TiuGbjCzQVHqiXCQ1OBe61qst871c8Hy8HwbeJrh8U6L8PF9DtxLnXtOfipV1nkZ
	iVGhnVGtr5WtxM6/YafSrrlBLD+DOTx9BI1UOpRIAD+HIG/PW6ujC
X-Received: by 2002:a05:6214:1cce:b0:70d:6de2:1b35 with SMTP id 6a1803df08f44-70d771c9465mr190456d6.65.1755628768239;
        Tue, 19 Aug 2025 11:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNb7O7hD+Z7kJbkAR9HXYyXCiP/vd3BX+PGDI99g9aEsnVyz9Xn+VwVrQ4K1qsah2RnqEAKw==
X-Received: by 2002:a05:6214:1cce:b0:70d:6de2:1b35 with SMTP id 6a1803df08f44-70d771c9465mr190086d6.65.1755628767607;
        Tue, 19 Aug 2025 11:39:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a4758bfsm25175301fa.32.2025.08.19.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:39:25 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:39:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: qcom: apq8064-mako: Minor whitespace
 cleanup
Message-ID: <tkbyz4pyvcahoudw3xwnmate5hcba4jqrak5nz5a23kmkhv4yv@y35jv4bzmnce>
References: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
X-Proofpoint-ORIG-GUID: K9BJwEWMa7Bkp_WQ6CBZwW4Y8Qq4_Seo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfXxQfkTKb5hgez
 8KI59ulejhOfz9Lb5oX2MOQliKz41GIGICKAAtSiftEYHT4CSQ2SU/8Wnih8Y5uFJQF0woyQvoq
 3UcSmBkStfWQa80kIqdx6x3rxc43YqeCYDocFyVghglmkcT7Ic65DGJ4/HZ2U4hGaB5AvuMTQVL
 trQYoQ+MRcc8iAiJYEvTt33EqL45GdAYX/0ojgO3sCihWaDuvPuUoF9qNQnjO6WkxnDokMe0LuL
 qWaFsnccSXLFDD2eKytiwzMpzYA//ewRQOlFvB/+yTypsXw26v9PGngpwKLBGGTxtIQKkE/6Mrw
 vVuqvYqmFVARl7uwd//2J+w0CPRdpsoVEC+eqEFxuG85FyX5WHqdFR6n7nm6LJsQOJDWSXmezaH
 82AFd9+4
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a4c4e1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EEIZnOjFFfZb4VbM-nYA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: K9BJwEWMa7Bkp_WQ6CBZwW4Y8Qq4_Seo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

On Tue, Aug 19, 2025 at 03:17:18PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=' or '{'
> characters.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

