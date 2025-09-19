Return-Path: <linux-kernel+bounces-825082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4BB8AEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A120189B7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB1241665;
	Fri, 19 Sep 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRnz2kIR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE85205AB6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306576; cv=none; b=dA3fqBB2lYt8jOi4TNi2v8qOJZdvqvejTPqxtzxqttGxjIKA/KKsIjjxQGaX15UwO71xWxnPF1/bcEhpKjGUBiaH3NdFbCQaXv5AQi44qdaWEHuiXxus/D4H2wcywJnNQmJ2URyd5e5FiE521nzHQmDlKA4HOfUxhI1R9nMNjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306576; c=relaxed/simple;
	bh=5HcGcJPfAGJVWwh47JGBEvlbeUbK69QuVa8rC4DOV5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHulKoUFqd6CieEdAx0PF4ArGYwIlnUtfr1fVi5tqUepGdhko373j/5WNLMj/+57pEeNXcpztkZ+AfM8bjzNr6TZF1c3Q1P7xXihI5/MR62jFVJQ27Gmax16BPIYP1PDWV4VvX9LfpvgSI2CyUfcnAcK9LE28y0+S1n3/G6CtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RRnz2kIR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDgFKP010782
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nELkMuG6G4b4hNEzE5++D+4i
	ykuQu225GTPV54pVjNk=; b=RRnz2kIRHqwrjQd99LcWnGKFoqNlJppKNVg6v/zN
	74LFRnDceaW9jKBreZkDEvDKElFeX749jroH92Eb0OinTtrVOK/OLHxnPyg52eqn
	z2yiikSeEf5Qq7G40h/HbIevhMsTjnvwsSXtlHkCl8eCOJ5myA94VAxTu8S02VAw
	tI5ZRPQOFDswW0M1tCn35ZNF0j49zKygeaWbk8y6GNlLGwAf0HzEX6z1J5ivyG81
	mi/zh+GtRBC8RgVZOexYC3lNhqsncw25aPQrOc4CZkbkTJ/DmTWG/hWKgV4UTe67
	+fgKPlWYvjtGzlVqaxWbVoDt/eFGzsZ0juSSyBzxc5da5Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxy3dkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:29:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7248ed9f932so35562436d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306573; x=1758911373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nELkMuG6G4b4hNEzE5++D+4iykuQu225GTPV54pVjNk=;
        b=tlzeN9n0xoCWBbrz6LHiAStHzepZFz/Cvrbfr8s0MvBHj0NhwRnYrm/x0StbwsLRBk
         foyr9ldzAIobvRA4zVDZGcats6OlS0U/VsDwI/h881YnAWH/LqKeqfn2Bz8oFglvF3s2
         /QAsFGCHHzIzDQ1cg8HdOqyLO4EqR/JZfXV0rGM2mykqIZ8mYwS63PGVDj7MVFAJfiFG
         Ys2sq8QjOsTnYsxoE4ammckMtykRtjCI+nAUaNOMPsRFRO0abarpmSElT8BuN7IRiI4V
         nv53B0lOuC0clHSgS/wbVZINAGFpSXp7zYOn/qom/3s5pH0wlMrWXvlxBEqH4RXKVP5n
         Gkkg==
X-Forwarded-Encrypted: i=1; AJvYcCWESM2LRJXGCZQmKWpstwV38kLgcXgcDilRtUugdal/va8vcxjqDU4FgSoymn6dyEMAggi9FDUlkaf6slQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TLaUb1vi9SVDP2MLcCZJ7Lx6XnMBizmNYgfqHROsGfdSjLSc
	Z0cnKTOOizjASgkg7bhYrKcTWj50SRgAw7uwXXc3/431QHUIPHyiUJ2U1AOL5tu6JK2k+vV/wRY
	vM1KkJB/jrrRlIFzxaEql0S/2hXMIY0pJ3VbStZ8z8RFMrZxeqtIXUct6OgPczpIBSO8=
X-Gm-Gg: ASbGnctIABHq01e3unjDOYsJ/dooY1miyaL3lZ31kH0IqMKd0Dk2ucDWAfqTDI3g22l
	xe7+qGcC0sicKGNoNNUdS5ksbdT039ovRXkzos2FRIIoIgrcSq0EUqVXw6xxeSox6CXT8541yDy
	SOTUN1Nqg5zeo0NC8jyC1N+JQA7l6aYOb9bMOCQV/0XciC6sXvi+1NGw8+2lknqLMTo9MiPaEaP
	aayRtCSGGm5QbQUrkTSm8yVY8p3nfkt/JIHTNrvx6T85YAH8p8gyGZMmHBbMF88/UFdtter2R26
	MR7hDUrHpN/eBKlqN9xPvAjPjnZ2Aung53SNBVCMPXe0rqaJ9jbHQEHVW18I94IajV0unRXI/0n
	CX99uFflm+FTFevTpDD65agW7suDKHnXBDqo1NYFSgzcN72Eqe5BV
X-Received: by 2002:a05:6214:212d:b0:786:8f81:43e with SMTP id 6a1803df08f44-7991a92b751mr45979696d6.33.1758306573162;
        Fri, 19 Sep 2025 11:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1heRt8eGc/n23vl3sA3KqPDKFH72DXCf2ZbAaB5smb4GgH0KGIrCssMBhJrzkGAMEzwdWYw==
X-Received: by 2002:a05:6214:212d:b0:786:8f81:43e with SMTP id 6a1803df08f44-7991a92b751mr45979186d6.33.1758306572586;
        Fri, 19 Sep 2025 11:29:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-579ae3d9c88sm958682e87.140.2025.09.19.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:29:31 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:29:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v5 08/14] phy: qcom: qmp-usbc: Add TCSR parsing and PHY
 mode setting
Message-ID: <j3e7f6fqeilaz4nek2hnh7obsvjwret42dkmwervcg3c74o7ai@pz244lhrwuou>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-8-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-8-eae6681f4002@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+OGezDCEybL/
 UzgMWa+m2t4qTmPJJkGMqj33eCO14WndJnnGjdBsuS93mDOcQ7UosSu9BL8cuVowtLqGbXWYGYQ
 0Fe90bx3OuSJ3U0Zf2WEJtFXv9bZcr8cSc9DBrGh+4K7E6ZSks2hVts3DYn6jyftcJZp5n+8P2p
 4ozOoIdGRFDAwkiCX95bwpbyUdvLGzfOZqNIxL32u854bzKmMzsN7km+djMS2BlfQBEaIOWLsbg
 RaelQVtCyowAAa6CFiMC5DsXbff7BbEMJivnLluxTQ5UA5Y80KvWhVWcr6qoXqY0Wgs9XfgxnOH
 AYRGcgvH2gbYK3/PeFHF9tlw4QXWIurqtrQyNMfjGRPm666+TI5QxRwjeBEE1AuS9ElKt1qsY2c
 dBal2HNG
X-Proofpoint-ORIG-GUID: QjZVgORY94Is37DMcyms3sbRBzNi4oUN
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cda10e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=fgmTnHYI-UD6AacMZvIA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: QjZVgORY94Is37DMcyms3sbRBzNi4oUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Fri, Sep 19, 2025 at 10:24:25PM +0800, Xiangxu Yin wrote:
> Extend TCSR parsing to read optional dp_phy_mode_reg and add
> qmp_usbc_set_phy_mode() to switch between USB and DP modes when
> supported.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

