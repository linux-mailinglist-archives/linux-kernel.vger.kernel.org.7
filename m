Return-Path: <linux-kernel+bounces-839693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2EBB22B3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC1617034F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274EFBF0;
	Thu,  2 Oct 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUCYIKS1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61BC120
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366233; cv=none; b=eSLBc2S1elAr1Z69d3lDtcLZdT+JdsoFsYN/ZxAQdQPQ3qb8s6SMOF1nVwmmUUzzKIQs0u3W/Z3fOwTR5hzVYxVZCILrR8uscF/wvJrv1thuJjoHNozMsbk5Q1mZtpSkRYHuPcMeWDTqEbNqNBL+MBcvcoUkf6b1VveFz/xaRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366233; c=relaxed/simple;
	bh=pcLhHJCXTY8Rx0ZoTvbpeKJuwGj5s/9zbvQnYMx6r6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5TH/COHHBwBjT2VFsUrSB20zPc1duvBixzsZrwpQA0USjfpxvLmw62VAAbrdvujCe+7JJHqb5CYL+Knn7kUC3sbsVQM+0gwHfMo/t85jYGrydXRXHGbxc0hJJ8LoZG6+KdOPDK7G0cIa+/I17458zZAx/e+zx9ghHvwm17dtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bUCYIKS1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic0ss009721
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 00:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7ulc+vZjEzPbgWCzpmuRHchS
	Qw8CDsC03VwUjnWv2pA=; b=bUCYIKS1qCqINuoUlonGTpaDrnrudeOj9rri13av
	08u3b+JgNuAU5NWh+No3hB+UN/tBWMnQQwgJh4nHwhMRAE+RVK/qsuwKu9rX3He9
	pQYKsoR2BFMo4VsfFzgQWLNRvW0auWICrOfi5osNG3bDzqjTAmjcgLbtbO7DjxZu
	vSWQ9a+9+GuUAHrn8tjxNR1CojFVesqF1gBjnYuVJimbWwZD+7Ih9BsLmgWOIem0
	c4CpC4nU0CYKeNXRoGJLqe2Q0sqeUZLtgNxUKOnraLhu6bcmW4eLcMQMz3Tp84es
	WEi1iPdxGc6sCfh2uX/2wchoobsSbsTLUzufQxC41aFYxQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hp0yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:50:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dbd8484abbso6884131cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 17:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759366229; x=1759971029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ulc+vZjEzPbgWCzpmuRHchSQw8CDsC03VwUjnWv2pA=;
        b=AhaL5aP0sA+u+BuAHK2mmbHzrpIGhPZsuXCeOVvbXvIhPRZtATnA5xO6z8mGHHwSTp
         A54EexPHSToejS3sYmugIAofSQYGtwjW0UzpQcSqTQNoqmZQCgfBWz1+AwW8y+EsblfH
         cH18vDfglss2a3qV3CaZ0lORRLsUGJmP/ILNxZT4WJsCA+9E49BxEDmpc4uuglRIlpS2
         IanzVwTZfkb+y2p0HVxrG+q/jpx+j0Sp5qaLA7jNvWUSwKjtWcxSXJdcYvld0BuRLml7
         l3buZB1EuNmmND91a2fMQA9ilG3rDamOo8GVXV+bAgUS/bfQves/eNHY6lUa9PJMWKrY
         t3uA==
X-Forwarded-Encrypted: i=1; AJvYcCWh2Ez70CH5ZA3Ssf3+9OZra4URvhMti8GywZZkjPsmkFsL3h2D91Z1/jzh0fHZ6B2QtuybvO3PC3Mbr9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdWeQU8iA5AZC2ezy4dg+vBZFPv7yZppssblk9EaxcXk5pclh
	6b6OaruvGxnXhpqRZpEPmrL6pKkF6j2SJRI+IA1LZpckZsGzdtPgfP3iTq6HCGA/QOADFi6D5m2
	DQN5CjLLPtxLDMA/ZWr1kTV6Gfshd1fHDpcwY3dXQeXL25EE7rGnVZaur56si5EfYVCA=
X-Gm-Gg: ASbGncsxKhi1/pljYy8qQrdFRaUxntijN+BSipNvxPJy2MfvuMWEMG7j5/ClS1XWhyu
	J4q9kShqYxZOjbd3OCYQYFesdjhktFpNYXq3aoaLveg31Vky8cuOXrD2CtKHn1vqfBTQphm29AC
	BcexsBM18Jkw7HrtRp6JzVfxHsyw6CWE76yQU3OWYZ9BLgmwG7nJ6EckfZvvxgaK94OCxV1wkHB
	swi2xBCJJVykE97LJli/MdWtq2htjPlupwpvYbTUEu42meeDlDo1giGrKLkj2f2s+CgCOEC/nyt
	sm7A64m6GwGoNaL7CL1AC2drQ4jNPTbXiyTIqqySyjLkbG8zli0/6JEtdHteeZoisuzOQ4+PjIc
	2+LssauHQkySGTD4BHOuh5/jtTm7XzcmN90Djy8TWgjiEtagB3Jr9WohXZw==
X-Received: by 2002:a05:622a:598b:b0:4d9:5ce:3746 with SMTP id d75a77b69052e-4e41de6f81cmr73081171cf.46.1759366229520;
        Wed, 01 Oct 2025 17:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCclp98+N6Qg6dRWsktO9GaXOQng3cW+YUBThiQY3XzDHdMc4J/Sf5gh5nJ+36guSA5Lv/2Q==
X-Received: by 2002:a05:622a:598b:b0:4d9:5ce:3746 with SMTP id d75a77b69052e-4e41de6f81cmr73080981cf.46.1759366229120;
        Wed, 01 Oct 2025 17:50:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119ed45sm320922e87.104.2025.10.01.17.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 17:50:27 -0700 (PDT)
Date: Thu, 2 Oct 2025 03:50:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] pinctrl: qcom: spmi-gpio: Add PMCX0102, PMK8850 &
 PMH01XX PMICs support
Message-ID: <gnutyscz67spmu2nmsiyptcqsp7y45emirdwlsldrgsddfwi7l@rm52ogzmnorv>
References: <20250924-glymur-pinctrl-driver-v2-0-11bef014a778@oss.qualcomm.com>
 <20250924-glymur-pinctrl-driver-v2-2-11bef014a778@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-glymur-pinctrl-driver-v2-2-11bef014a778@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX2RmlhSoKlkOe
 ThhNPKX+XgnDaYodDVZNTqb1Oy/OzOy3dcVimPeqNp6Oz7Cgy/gQhHhjsUKax1FC8C84rDjGsXu
 UEKJC6ylnAPpjzyaJWu1Ghmu6/G4n19nUyvVxsd5eYJ0yfQq9TVkBvAww0UAAq/UxYo/Sw+EAlR
 cXiJwKHwH0nQubbeI2XNYXrlKYXmUWCmREaZ8p96ezMhHZruqzk1h1yznkGOGqfl08i/2Gm8rUH
 taYyeh3mlcfHw0rE+R7zKxckIVR4wVnjFPSJYRQaAb0l1FyNQfY9Dte2vaamxYhKtFE2EHxtE89
 UrlO9oogiXRQKcmQjHNF+bOdDs1ZAuCoHCmtHhR3BDxsiGKSQq1FsG99D2zx+3vu+1WkVPURbUy
 AZuxqmQlUbZ6BIbjYw8nBLfNpKRvTg==
X-Proofpoint-GUID: 2o_FxlARS0lLZrTxn2kOTfELu2-R9lrM
X-Proofpoint-ORIG-GUID: 2o_FxlARS0lLZrTxn2kOTfELu2-R9lrM
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68ddcc57 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=rQW_yBrpdR-Tfh0GWmIA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Wed, Sep 24, 2025 at 10:31:03PM +0530, Kamal Wadhwa wrote:
> From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> 
> Add support for PMCX0102, PMH0101, PMH0104, PMH0110 and PMK8850 PMIC
> GPIOs with adding appropriate compatible strings.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

