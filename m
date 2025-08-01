Return-Path: <linux-kernel+bounces-753435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A52B182F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC091C836CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1763C2E371F;
	Fri,  1 Aug 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bi/O9ZFI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65C35977
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056325; cv=none; b=RoJLUUudHVR9guhUnI0sLJTJhvuORMSXrTD7acRJMPmJPMrn6RxIJve3phRA7tG6l3zpRJv9dHawfM7KxPcrTr5eMSWmm9m+33IvAYPNgdTojXBKETxSZCD76OnPz82SXxSncQj7yDW7Qw9L09N7qBFQMZ45wPTcFf3r13vHIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056325; c=relaxed/simple;
	bh=vhTrP+GJIoA6ydMovg9Eb79KfHnKL5N79rl9tjjQND4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwta+96m5EjRTwBCTnYh4yZIYezLbnYM00Ib96wrJTRF6nSYarorqzzV4DVITBy0CaEI8y1p402O5l0sk7iY/8YMMaMha/EeWf7itqZtn1G1ZBwuuJsNjBf69UEE0iA9MXDJweukW+WuzwBA3cK1/c0dC3RpKHZ0oWAahHsZS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bi/O9ZFI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719AaUE006860
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 13:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gN0kT+Wo9uqVQiZqrtrMEVeC
	TpUgjT6nfQXr88CiLMA=; b=bi/O9ZFICWERMwdfqU3CSHhfOZ+dZ2SPf5u4IBJ8
	STMrTJ5V5x0GInC3QxbnkNiC6D6/zlLBj7wADw7+31fOJAr318toyHs9qsOx9SYw
	wgXbsKChxFQliYQnXco4Hgr0XpStXktg7NH+HoSEFtTK/tqH0R2dzpd8kRESIIQf
	qaB9pTSng4G71fuxDFPFlb9qfCixlu/v68HdTroTU4Rw+ShNTR48SPgDI/tyNKO5
	oAl6t8nuZ831scdlPytVI8qlsllaM7Hln1omTN811t23/u7m5aEsZHBbfGEzC0Y7
	TWcNQLn4t46fnbuh1BzqnIs8uZ6TT6nDBkMRNMdtiMoQqA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2uvkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 13:52:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab9ba884easo7097261cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056322; x=1754661122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN0kT+Wo9uqVQiZqrtrMEVeCTpUgjT6nfQXr88CiLMA=;
        b=T/h3KVU39GyOwcf2M2cN7Vgb0kfLDtHN7Aq2Bu/5u/R92Im4ECRFk1qBlwPmZr8Hp4
         CFM9bKT5npaEMhJ6ANLTPV0MoF4LFdpBMRjHp0aE6UI6BHmd24h7DwJujM67wiqA9Nnx
         CKNDPWK6LQSejJRv+exUN0bi8cUxWErckUR/Dn/hAc0BXt6CoJ+EJ6lpNdXm0bQs97yn
         q6jXjaoUeEStrWMBAXNuvmPTp9+SCEMPEdlTwK4rcsgqjMU6p3XEYOXFqx+A+Z9Ip1wQ
         DRFEFXg4AI+sYk7ObHkFhnGR1lAvRFOQLMXLMXJ0N4Adm+qrC7BqK0Sw1AuJ4zMNnyzj
         yhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAh8E7W+9X9FGxFFpyKpjDAAIgyIF8RJnblg6qWReSy56zbnN4JRSinECdR1/D44dGjndY0Arf9rYfqsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFMu3U29LFi8nZaMu2ZyK2f9fY/WmzNDDX44sI2mGn3vYN13H
	Sq0hRJHkC0pUAnHUgM521gnKBWGl0l8aK3XEcf3b01UuAu+4XoqEYxQGn9LtnpMv63QgZlszx7g
	vQZhREbd26xRd+64ReZl1UBZPWfpEmy1QVnFjOzVZRTvxecf4LMuCSzR0LDCmy4hFdo4=
X-Gm-Gg: ASbGncuhS7wgkI+dRdMFrW4GTj0IETSDTifZYqL+6XHAE6hqpLFNzqgcQMgjxEqqNAQ
	1KssCwqOMrXWPwlGYqIi0BFf711szYA4IHM3atDgGVhzIrDsAQ1QLDm7QzhV9mEmOQPxhMc5F/M
	kQ5e05DKr3DOeum6mPvlJsyugZ8fcVjIEbzKRAX+rbU4d84ST05n3/uiKkhgMYFQ4EFKOBhhHaG
	axpQwjPd465yPpYdYCnEWSTC+w/u5MAxlfX4vUMFGsIcH4xMnbOq4AAtMuYohnUnLlLsMMk2U56
	Pi/yo2rNbipOPL45vVEDyv7K4ZS/xDRMvR1mKXysRTSq0kaxWNULsaD4ah958Gk+zmqOJ0MH/Pp
	hacl37pJnlEpW9F2+aVnAJmB2a5C01zK5DA3CzIkkcPJw0SyhFExw
X-Received: by 2002:ac8:5fca:0:b0:4ab:af74:e0be with SMTP id d75a77b69052e-4aedbc59deamr162312791cf.43.1754056321925;
        Fri, 01 Aug 2025 06:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbJ9/UfCMEp6ALYbfsnGI7L7qxlBrcJTulkDzMGsNnw0pPYnM9xZM+cCoRA4uOKSXu3GzEkg==
X-Received: by 2002:ac8:5fca:0:b0:4ab:af74:e0be with SMTP id d75a77b69052e-4aedbc59deamr162312451cf.43.1754056321484;
        Fri, 01 Aug 2025 06:52:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac5f5sm603568e87.64.2025.08.01.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:52:00 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:51:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Add rpmh-stats node
Message-ID: <nn6p367tg4l2qi6277rclxrbk5zxzoelzeoxvl3exgbjabjoxd@pujfujycift7>
References: <20250801-sm6350-rpmh-stats-v1-1-f1fb649d1095@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-sm6350-rpmh-stats-v1-1-f1fb649d1095@fairphone.com>
X-Proofpoint-GUID: 3MCIIUisF2Peuc6T60_9X_eiqQlFuK2v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNSBTYWx0ZWRfX1hv0utgAz+Ki
 K69g4Y+l6czKzIrdAkGiqbMQU3FeDyZFYT7mU6h+RWaHeAa/vCxM9BdhqFdiWzakG1wM4C0RXjv
 k4JL7mvju0JjHqDjWF9h5v3XfDpYh06Wa5XB7mYC5Nm+z0nSbFXv5SaH0QXMF6jy9M+8rAHit4f
 p9CMxaMR2Ck3kPkzofm3GCccXBYokYa1YUeOxj5ZwZdVGG5EWNfJWSUcGXpGsvpq5lQFU6Tmm6E
 mr6LW3zTPDfdFpJp8Sf0NU5cwcoWoqwaUcA5GTHnM1PsHoBHjf8/jbV0BfxHh9Gc8S2+ZNmxash
 JTHMIsouCNQtYNH3fuET/++GsvW5PnWhSMfNpYDCGauXjTLzgMQYCx8PjyXpm8J7QM/cGGws4vw
 zdnLQFGesY91kDDGbrv0Fxmi6xvC1O/6oGgxbIALBfs2MEeoVi28ImmHD0brjwW5SvNvcBnL
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688cc682 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=NGnrDkvxLCtUz6Rj-iUA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 3MCIIUisF2Peuc6T60_9X_eiqQlFuK2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=883 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010105

On Fri, Aug 01, 2025 at 03:40:59PM +0200, Luca Weiss wrote:
> The qcom_stats driver allows querying sleep stats from various
> remoteprocs. Add a node to enable it.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

