Return-Path: <linux-kernel+bounces-864525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF0BFAFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B0619C4C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1EC279918;
	Wed, 22 Oct 2025 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dRRREcwC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C44266584
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123024; cv=none; b=PD4D5HF4upFcNes+4B5+Pzd4nQXeIFBulPi8kyLk9LiINnGWIzgSTn5j7jSrP28AZTn4SEC7/XD9U3dO8JX9lACJGKKuYXDddE8Vziu0cOJqShcEeNibLyBectUX75tiFTY4+7uELJfQSyMmcBLnLCu1xO/ShJykhRp58pYLpb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123024; c=relaxed/simple;
	bh=JDm9N+ZZYfrAMtYqK4bg2YFnElswdFezxf3RSSNeCGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPxsbtxSL7q1J3DFj7Nha0vxL2A4es/ybfIWy68kI+zW0kVh2XqqM6WYcOXG08ebNNQaWzBIQjK8rRuYvw0BMxK/Mi9Fh1cPP6G03MF0a3BpXQOSYVg0w9MDukHMAop677Ysc6f/QnWfxU0CjlCTXz8WOGhGP+GexXozlaXj2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dRRREcwC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7KtJj011570
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TbaujdcrH9oIG7aCXpiE2nPE
	Oe67QDofbGAPoiaMp6w=; b=dRRREcwCY+vhWsr3Zsnn8PNPiod3OhjZVNNcJUiU
	ABEL/kVxcGm4CVbcthK9YQax3K4DBGA753brgCtgx2JPA+X7BS2J+zbJikeL/rWM
	RJgK6/4Rgo+YC3mw6grYmYzN5+mIqJNAiH1rhIHpNlTRLjw+aoIcNixsLz35kYaA
	+f9FKV+ANZN8y2Ti4S+n7ttsC/oy/xa7r/jHo5AoT9aA9td2votv89qqDc2AVbPL
	e7ACKmVzHCCEyInrH5McD5WemCjQgeFpfa26RQagy67pi2+DSi5G8Atu7SpVJmTo
	YtXADFp9QvyRGisTIMilRTyS1YdadzDIi7tX7a8oByBywA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0hsp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:50:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8aafb21d6so26894491cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123021; x=1761727821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbaujdcrH9oIG7aCXpiE2nPEOe67QDofbGAPoiaMp6w=;
        b=CHpE939pudSR/d9hFlq5wqFRt3SB5hBPH2kywDGpzXTA4RAIW65bZDICw1RJKCueN3
         tVMtw/Bd5zc8vOuHO2K6sS/xWztZ9vsKVBgqB9SwGzCzbIP/07c/K7Q9DM2CVRJO+R1C
         ynFu3p/I7q7hk/I9eNfE/PaS9NUoRrOTYbMwNfFenuE4PUm+76zGgYDmZWta6f9yU9KU
         Z9N+c6Z84Svnf67OvUEfIgCAs7XKpqqFixfXrOtyWO4OWuVVL4VXQQ47KMlOj3ivH0e4
         EVaQLqFiXM7b12Y/NO2xilph00o3aklZUhWdcdwW2Dzw7w96QCDytwSWRT1xUSzVeKx0
         8FzA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jX0UaxJ9ZaRIlts+ZZOu2wcEAEq/j/O4sNIrkewLx9JbsLwZi2tHbzoochMngDoWvTK86oq/U7MsatM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYDhDW10K5ewZa1tIYnekJ/HVdIs09/9mvF4KhaeIlbzK6JbW
	+qUVSi5dmkSFcYgcnhB9vIPd5Y/uF4Nrg6Ljalhars3FkTr/Vw2b0ScfbPHbJCqHMPyxnKueM6c
	zQjhycXdjWmq1l3pLpEsEhcXazFz1loHva+dP+v0lOpMuUQblZBGlqFkkSnFh7JdokbA=
X-Gm-Gg: ASbGnct9sDz15nuIIpvAUZ6seAh4xxlcbhDur8UPDiKdVL9lZanSv4KafGnKIBVt8yk
	R/OWdk4zmqEKPq6+KYNBRM691gQe98b6+eliuVzCdsnTmHCIrRhwUWCRtGmBmdleoHravv452Se
	RDX9NzKUHpaFUKFmjuH/REitbMlT4B9PHcnjWiocM+IhhCWEegZwpehQV25qtc2Z4k+IbTryKgH
	LzsR6g31ibYHjuZzdzvj7eLhzUyY6OckLCI6gwqzZ2wnwIITVyn1lItjpjetWOFsVP2bbyxyPfi
	9pgJNlMtzyfuTb2i97XA7s9y2mitwHamHhRBd5FkzZq5zofX1eKml4P9+ovf3ORbnzMi3/mG0cy
	AcvD7lEeQy5LmzAYUVxbKfydjEIU51+OkN/zMVVSnsSTSLuC8mUQf/o7J2aX1XLxyBxloTDqZLj
	1dHfZR4ZjwrJU=
X-Received: by 2002:a05:622a:310:b0:4d9:dea6:4ff0 with SMTP id d75a77b69052e-4e89d3d5924mr282823641cf.56.1761123021179;
        Wed, 22 Oct 2025 01:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTgZJr+cT8SYLBmVZl/Y7kdrpKwF6g2UFgH1obyMySI0IqzuVaSJtc+hYHspSX6Jc8FSJs+Q==
X-Received: by 2002:a05:622a:310:b0:4d9:dea6:4ff0 with SMTP id d75a77b69052e-4e89d3d5924mr282823311cf.56.1761123020589;
        Wed, 22 Oct 2025 01:50:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950cb2bsm35458961fa.27.2025.10.22.01.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:50:19 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:50:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: firmware: qcom,scm: Document SCM on
 Kaanapali SOC
Message-ID: <jqunb52dy2kyygpolf5ct72j3uktln47qppuhfczazowykatt5@3bg2c6umqw52>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
 <20251022-knp-soc-binding-v2-3-3cd3f390f3e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-knp-soc-binding-v2-3-3cd3f390f3e2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX94YblX0A1ToN
 2KWXBF7kbZdc+sttbDn9ymvjKoP/9a3CvvaPrQV3egHK5HqKqBwM2Crx/C0ztib6SkOt3Mx8QKf
 tLRDzYURTFUmIZ5p4q3P/mGb9bjzyyb4qAeo2670yh9WWAcXkpVrlU/ro9ykdNG3gXWBoApEbJb
 vLy+SBxGSNWnUEr+xLvj3JdAAP9Anvn/3Fxs+AuqBeiEsVhxqzrwpybgdiut+ZiDjLhm9ZiD5I5
 5SBNBOMPr5b5+ygydTa1QebSOlZlPqUScf9F9iD6GeHEPRk9vjjnjrfHPE2O9MheY4nw8qWAUwy
 DuE4yJ/XXKTxtz4y6M4k70AgVi1BbsqbO6oVlPkOYVNXIeGupd+T706VQDNVNmWqIOzUS2DrPvq
 MC67LZvhzS0QCI3+pRGvAwAd7t+JKw==
X-Proofpoint-ORIG-GUID: IaAQPMEg7QXvnrrQABOWSdApiCBU2-xn
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f89ace cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=BJkMSRMYZAcFcGSszd4A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IaAQPMEg7QXvnrrQABOWSdApiCBU2-xn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On Wed, Oct 22, 2025 at 12:28:43AM -0700, Jingyi Wang wrote:
> Document scm compatible for the Qualcomm Kaanapali SoC.

SCM, not scm

> 
> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

-- 
With best wishes
Dmitry

