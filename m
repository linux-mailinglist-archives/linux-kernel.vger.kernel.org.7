Return-Path: <linux-kernel+bounces-880091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DBC24DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84039465C19
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F51348893;
	Fri, 31 Oct 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O86p9YC0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YcYYIaUK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4B346E5A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911315; cv=none; b=fmTVIU9bnxwA1Qe5Kyc7tb/nZSR0RZdXj6YHc4p2ZaKHbRVatou6yx6em+40Rfw4TiOxkWJJLk04CPpUTDE5ELk5KFwXmGnqiQwZz8goXax6FVATZC9I13ZiaFu0Jtnn2rIbkm+EmP56FbXHPi/F+nnbChcDM/16fyUhytqaf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911315; c=relaxed/simple;
	bh=Af1tMCfkDQ1lQfRQaKUsYRHlEVRdIg23yVqZC+J8rAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVvN5muXoplX3taPug7XTTTxZ63iRCpDljyaDkiFHfc/2RrVb3yr8FcrgGR7TanYWS19lmY+3t0LXJ7uWsQslBhQMK4ugdfBXX0Nu2Y43Gc0eNdO0dJMLIHEJgByIBQQ72SOs7YGcUAXTaqJ4wabHLSVqHNP9mVOLJUnpiGedG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O86p9YC0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YcYYIaUK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73Ul32058979
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4E/WBBGg3Ro
	41UM204RDH20wPcFyThixToHapyaAtXQ=; b=O86p9YC0yydZYc1gQ4KVQHVEx+B
	5iWNJgUTwstuR0RcAo03uXagPh218nIJGfTAXznbyBLqY27IB2GrEr33GvC0nVYM
	FZsrtXr5+ywg7GZE964OuijP/TkSy6OBda68QSccxNQKDphHyDpM6FHXFYRFfh4r
	GGOQRe35Sq1iRI10vDtKC0Zw/02sNRsCss8LeZl5L6bC5DyfJb8hGWTUif2qz4Kq
	qil9dS3/CZmP3sEdFG4TrToNblrJhpmfwCkTu2fpH5LKy9D3lnWmfiptKIOCfgtj
	WqbqzIXbE0dQUHwZtQSdj37tk/H8JB5hoZJP92AOgwKGhx2rb8kttwiZ6mw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvgs18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8984d8833so95667641cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911312; x=1762516112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E/WBBGg3Ro41UM204RDH20wPcFyThixToHapyaAtXQ=;
        b=YcYYIaUKPLmretsRMDtRHMqA+bvUtap+t06yf6uz4JMp5+FDY8Jfoyh/Fg+raL9iVp
         HlnCwwmkDj/F1KwGZ0uPSECyFhnZlRSE00KtJtHClOgrTWV+WGE0NHdTbGeA9MniV1zg
         myOX0BlaHUUUcNh7FgfYXgL7cjzsPH5IpyakXhmbGI1jrZhjbZq6ABni+DOZGjE7CimX
         ehbccmdTU36jqoO7j/ralDbEvBL9/njTzDpMazxht5wYOqEf29UuNR9zS4QCi+8W0xC0
         EMYvnmR5ZW2WzlDp5lwTbcHjyr7q17/Xc8fu6Zq2k/NGeXfmYD/1xCVGfoP8J7W+i9C1
         kCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911312; x=1762516112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4E/WBBGg3Ro41UM204RDH20wPcFyThixToHapyaAtXQ=;
        b=bfV952TDaCVFaqT/KJPSSx6fmyEj6/cTuLUQY1j3w+/SuwOXshUMZMOKqsflQrxHR+
         y1q5GU+iCzCs6Ybk7haOKh23ypkEEnMZvz8D/lp9lGB7zHILsJEsbSQhIa5CkPfD0zSr
         09AuwQl9B0FJVxgVNc6p1gRvTRSqpzDciy1gDlDGwbezn+YdwpnuFWaZhv/y1PbQYqf2
         l/7wjq1q3NT+6VwT6MqdEjcXJ50kE5gkfX/Y7lZSFYygtEybIf7++4otCN+BeY24kYkL
         B+A22chdsT34281cAxqia1eTSTpwZmfFoFPIYQ9M0RLSL1xr2x9Aznu4SxlZ5Xdk8CsJ
         6ZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcrlH7g1K8S1fTRKeLvGaRkrNP3rcPst6zYiYXBTkweyv5TYIQduTm4cSq2PYT2cuxI8/+ckvL05OSQF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPf9G9z0dqwke90drfF4rxWW60RQB1fzwmIXaZQ4UFEAHwG43U
	mn4zNtxXiFLgbrjdMIWPUehHddy2EykQKnaRoTX1roc9S3Mjs+bW0FKIFwgu++4HWcBMuAVG8/p
	lYkgqpPCZ++p/7DcLFKdPYgz8RG0GlpTU9yE68wjfL9QM6zPS03rt99PweXd2FGR/N4E=
X-Gm-Gg: ASbGncuttLMHtolrgIviR7n1lp1IMsbbTeeVUO+q0vBe/U9Yr6OEYA9OB/Bbz9Wh5Nn
	OUJPyHh0VLSt8IY+a3IfuPJYvwamn4caO42ePxIx5rOaKXtEKeX9Iu1yBMhrko8xrgeAeYK9kYK
	9ZQBtUg9WjhUf7TyM8c4QA3L8hezAfiRUT8ugqFZPZx8AtJvbGiT9HfeZSbT3jFtgUQDFMCR4PY
	9IUt6DFpuL1FzYApW3qWh/D7Hdhg7mF4uBk2kpLnBl85To6IG8eLLZEjg2+a5NCx9MuJ5GQA1qi
	EzAWuCmc7Y+XfUa8Vy98dPk2u9WZxiW0vekhlCnx82bBnMDW4NJOdpJQAMdE9SHFtze+oul70Wp
	soinpfAjKbs8O
X-Received: by 2002:a05:622a:1495:b0:4e8:9140:f3c8 with SMTP id d75a77b69052e-4ed30f8905fmr36356941cf.53.1761911312604;
        Fri, 31 Oct 2025 04:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDChzCSezmrewUSkYzqXWcdMnKFB4ONqHBKyhQ6cV/ocS06pTYFwWKhXF7J4KIgeDRzOT0CA==
X-Received: by 2002:a05:622a:1495:b0:4e8:9140:f3c8 with SMTP id d75a77b69052e-4ed30f8905fmr36356451cf.53.1761911312068;
        Fri, 31 Oct 2025 04:48:32 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:31 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 5/6] ASoC: codecs: lpass-va-macro: add SM6115 compatible
Date: Fri, 31 Oct 2025 11:47:51 +0000
Message-ID: <20251031114752.572270-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904a211 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sAbSznBxNPymwqveVGQA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfXxromTdY7LQw4
 ZYQXueGMQ6jMctK0LaoIFcnmVWf78encNUZaaL3VCb1tNkOIfao51O53N+JSklIMnyRjYzXekGq
 umDhkEh9sjZJwlnSi4d6hQhZjA5srpbc6ICAepzPPJZsqgoa51Cb4lmVAHR2CvChx0NGteDzLF0
 EjBMSIfecnYOheLUQ/MWwG8riOYttM4g0F9UPjH8vWNZbd1SgUQvddIkXA34k73YCURPJ5WseL3
 jgxOfYdxRvhfu4H8PUdfy6p2/JvFyW5pAVQfikNkyzQ5V58fDZMuCHaJ6PN1tLp6REZRppf/nCl
 6AWzbM1BoxYMbrUEmgsuMA+sf1lzNGfu9pzLsFbZhbcvmCLdZ4UzfeEOCGJH+j5gM4Z2zEmjWkR
 Bfz8M/edcngvLTafvmW8GH1NJsFmaQ==
X-Proofpoint-ORIG-GUID: D23BRWrV65i1q4UD_Iis5Lo85Ne_184U
X-Proofpoint-GUID: D23BRWrV65i1q4UD_Iis5Lo85Ne_184U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

SM6115 does not have "macro" clock, so its bindings differ with existing
SoC support in va-macro. So add dedicated compatible in both driver and
dt-bindings to be able to address that difference.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-va-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index fbe5ebeeaa80..902abc9843fa 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1759,6 +1759,7 @@ static const struct dev_pm_ops va_macro_pm_ops = {
 
 static const struct of_device_id va_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-va-macro", .data = &sm8250_va_data },
+	{ .compatible = "qcom,sm6115-lpass-va-macro", .data = &sm8450_va_data },
 	{ .compatible = "qcom,sm8250-lpass-va-macro", .data = &sm8250_va_data },
 	{ .compatible = "qcom,sm8450-lpass-va-macro", .data = &sm8450_va_data },
 	{ .compatible = "qcom,sm8550-lpass-va-macro", .data = &sm8550_va_data },
-- 
2.51.0


