Return-Path: <linux-kernel+bounces-856898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B9BE55DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276B35E476B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7813B2DF3CC;
	Thu, 16 Oct 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQ1Ca7B5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9E298CBE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646140; cv=none; b=Oq9g5qIsczs/mlLhFayqJ8nFZPatqAggYyVjt9v+RuuJDhT05JeF9vDZO8Pqg7RB5K4B+X9cwazadmeDnb6NvztoNrwH2eiu7SdSVYg3u7S5fgge0f5z6MeoNqcunFGrzp6wNF37l2peiTNCILDtcW9rpw1fqNoiC6yua1EDxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646140; c=relaxed/simple;
	bh=/BnkzLG7iF5vjjsEuhMhpnk3gLf1GEWGWf5wGNVMGhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGhpJkJ2t7EMBDYaKnlZQWzvMcVUNBflPPCODOHjyFKdCxZw4ePb0jn+xoakhKhiGq0gdIg0UtZ4fLY7H1pMgkVjwFO/TSBjZLCYXGjMVt3m3MyNAZndB1EeOgOKKvqCouLAOO/AozyfjF8USfntvLcb7SXG007D+E8gcNuB9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQ1Ca7B5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLNkF001691
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t4XeRTtk1HhmwuJqivoNSUwm
	vc5y3nht6ULpzG7FoOU=; b=EQ1Ca7B5u3ErYhxM5XM/jZbhsVuk/QMCZSm4CVyc
	xvzCG8WsO7+QXMbVhlvWscHFpQepb6mr97s+9iKjaEEr+/0t/HXRNd9xEXXftf22
	tD71PbW0BQKQSzSycxYvagZ6q4t+B037vCE+8K8NL4YqIyQH3CIoPDWgd67c/ZRZ
	IGt754YNOSQsPQCLqSa/pw23WZcU0QrosaE/67i1AuFLUUz44/Jw0e50DW5TQ8eu
	v0nZJShbWqeG3lgcvLkPEXQxenDkMw90Vhe8fgx3hCKfcM8rYFLFp9YWGPSf9nxH
	iuOFoYwooRrICLVHlfLzpQ6axkIXcIyRUPvj0vSfZEDRIg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd99smf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88ef355f7a3so434203785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646136; x=1761250936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4XeRTtk1HhmwuJqivoNSUwmvc5y3nht6ULpzG7FoOU=;
        b=a3BDZP7CMOyRg85Mmhy+zKwOfHUgbJ2LpqC7tFtU3vqd47tsbB9sqRSxxxOdxzKmwL
         yfqeGxuZkIH9erfTM+3boNd7wOyZEGvPoRuC+VNxQueToBNtYgY5579ipxrx4LUI387I
         OTFRMfdfK1ifEeQ0opybFsNayH9Db5aVDh3PoGzMOE22kOlqZpQq0q8IwlS5U3+OQfv2
         07QlRcDUfRBk5y3x5P1Kn0g6k79QnYhx4yeOj0kO2cglJQStq3rNYAm6CIRmmsoGWYZ6
         KRW06UyNKaROxDMlY7m2FmYl4uCdrF1dyw+fxL4/3BYAxO4nbegwLrUutMMRMjXGgz08
         8bUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo33VM+jq0HiHDTQbpuQ1NJ0EXhPvP0ZiDTqtojjScdaThP7KR1pBzcr9/T67p+oH+P6FEUP6z0jTQdcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4M/NHmrD3zerMufINjJNNO7jxPR1mKsPRFitMwXOm+fQ4+rSu
	gtpZXn9h9hzNwet9k67VEWraPSKyryrxc9HMoN3m9IVZ+aLRTxQjG3YLcg9nnegsgwMlzViIjXy
	ipzievyNfDSucHRWO86CyxrwKLsKUTjgzvzMIBcSOK+Qb8vmBRwdETSuZwUrKEr5rgJk=
X-Gm-Gg: ASbGnctmmc+o8BWpnDoAuOUx/cmsxrH1kWZJPjbJYqVGOVA0kbcVFCrcBfOXvv0IMg3
	PpUhJLkK9AQlD/yULRhUx6p0M9dyjOTfnEIJSGQTJvvvWrZ9p+mzkacSIb2pU33D6dniiOMVJql
	i1Zn5uVKfzN0nRzNehQrTXSM8S1nvb2TyY5lLxESuWyqqtuH5RVpyIFGIfzaqJPoBaToB87CsNt
	jzDB4g+9TN6T7LtxiW09lLiw23Ey7FuSFCQiCnZWN6W5xNOOOnQOoL9WmN2sb1V3we1OASEwn4c
	mX879Wiit+3tP70uKhQfToF+88dxfYAuMBQ3rKL2mW/ksUeT7MbxnxBQLyK4IjM3Ra+1vwqEZod
	JDEtzCh3xqSMoXAviaEqozNd9gYqTX0abEjq2lI79vvebtoK7WW7ugiokWc036iTfP2hEx9yn9K
	3LDuPr1UYeutw=
X-Received: by 2002:a05:622a:1101:b0:4e8:9601:37f5 with SMTP id d75a77b69052e-4e89d05bcd6mr20995821cf.0.1760646136061;
        Thu, 16 Oct 2025 13:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrcAdKJUHa7P+g75kVAeMcu1GBVw0vLJXNi7Bmcd+TwVbNriITJu0bKiz1xjIXDkX2pPHaqg==
X-Received: by 2002:a05:622a:1101:b0:4e8:9601:37f5 with SMTP id d75a77b69052e-4e89d05bcd6mr20995271cf.0.1760646135519;
        Thu, 16 Oct 2025 13:22:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f9148sm7376487e87.44.2025.10.16.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:22:13 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:22:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_pavir@quicinc.com, quic_suruchia@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 04/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks
 to use icc-clk
Message-ID: <yegaz22k6jpn657tyuiavbchgc2unaoqgvsjn54dzdhnb6rr4s@twg5yrmxx7ot>
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
 <20251014-qcom_ipq5424_nsscc-v7-4-081f4956be02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-4-081f4956be02@quicinc.com>
X-Proofpoint-ORIG-GUID: ghMR0bElQKBEtRwQMZ5sBpSdhFROgZyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8tZQK6F5YQgq
 jjpIuCDd+1s9fdlaK0kFcIMF8bosd+cWRvseXoumkJhcNf0R8+zBqTjkCbQ+/zrRa2MrjuexGLQ
 16cHbOU4nhn1vawp/9IkwBanEymsFhhJg5PPmedEjqHW26zZwj/UcmkObpxYzSn6nDgbFFRaNqi
 aENbktkmv3J7TdJyr8KQxN91ufd3pq/g7fuqU6v1MNrfyNGhG8E6RECMd4ur4It0ePj8xVQze4E
 FBkz+IkX5G5BXgkROMEy14tkar1v/87ME5U+GFGdzJ8vkHTi7yMh+BrWKl2XPGUXuhHL7CzMY/W
 Jqk05qFWcC/0x+j1NJBHVb55opUyVMEjDt+pzswJWzFsHZdVPWmmJ59c/ejUkrQsmqceKv5TsU2
 Id+isMVaP9zgWOEh32+RV/0BBq/W1A==
X-Proofpoint-GUID: ghMR0bElQKBEtRwQMZ5sBpSdhFROgZyE
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f153f9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=DdE-_dUAR9VioeaCo_UA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 10:35:29PM +0800, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.
> 
> Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
> interconnect path.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5424.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

