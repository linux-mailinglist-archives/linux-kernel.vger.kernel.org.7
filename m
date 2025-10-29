Return-Path: <linux-kernel+bounces-875158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D29C18568
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 950564F5820
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B052FC024;
	Wed, 29 Oct 2025 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9iu5U/t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q0+1Zafs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13382F8BC5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716679; cv=none; b=r1y5pJ1pPSjlR+rbipE3fLveQ8PdUHquGz47ietMg7148YV6Ex8LYYUsavfflc2FimY30bQ7o3dhUY34r51RA4pc6qT39HZgrSX3rnXQ6qwZpfFaG8USjH29IDKeCpJACWSxJguzOhRCCr3EpnlTgBcaXS9+T1lRYA8ZIL9aV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716679; c=relaxed/simple;
	bh=bZnoqdyFY3pu65TwtNZzfCsh30CpB8ikyYZgkjinaCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KurcEjDk6fAcQbccOlMdeXuQXKuQJTxifYG7OWG0aNP5Nhdj9J990DXhBtbxWqSM6Mpq0YTwYLKjkA9OA5whbnV2VtxapgGJBDSGlqR2rWVtCbM0BWp27+lIg0PPwdOrZL8G+3BM25kkjV8cKJdSifI8yCkokZgtL5/pqeNH9pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9iu5U/t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q0+1Zafs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uxnu3676883
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LipVLE24QMA8YmFHCyk8Jk9meuXazMzb1E+JswV0knE=; b=T9iu5U/tYAD9ZY6p
	zbJX/Pu+o30ClNdz3mXyCw0qXCz52cNIkpirvawVcxCmCjFTBGK+of6TRHc1s8vG
	2laP3V+jKbvKPRIDnM6fIprtsHxogo30YIjoRDaU2zvdjpSb5Bznj4HTwRwGocZS
	xc6EejKnsmcu/f1cgStlmXQ7RExQrdetvli6ip87DIbX3mzvxCCxczesUllMtLca
	tD2wRNWz/8trrl1tMtijbqGJ90X64e5UGIBU4+LQf+DmBLPF3vdN4XurYMXXty39
	MsmvijhN7GEOHw7lYJbDuYSxPlM09YWIyZBDPdZAdW4PIiDCgZ9k0p+PLsWJgukC
	91lA1w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1ha69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:44:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33d75897745so16049023a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761716676; x=1762321476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LipVLE24QMA8YmFHCyk8Jk9meuXazMzb1E+JswV0knE=;
        b=Q0+1Zafs5QfRI2YDSI5CcssQ9X/kop4IvhC+FJr+Q0yXl+3jybRP/iNYR3Nf4TD4JX
         LHTceAevpA9IhuXXCyoh2w7dukDnJCCOSgbGajm7qQkHo5bv3DcLdcaUUAYINQ652Bv/
         RNA07OHI2RE6jNG0notPa6MakclJ8xOUprUPVM3o8G8GV8Lj+ITH9KeAeUTcJbKVMXWG
         IIEWO9dUNloIa730Gz993+suifYyJIyQNvrQSz2pcCJqVv2RSc9B6buih4xt8gMhq1wx
         UrXgXGJIUYDvve+8T8HiRrNOH7Z71+eyfDINCIQZ+c1NMi316IHv/nWmHm3BGS+Akhwb
         vcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716676; x=1762321476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LipVLE24QMA8YmFHCyk8Jk9meuXazMzb1E+JswV0knE=;
        b=ZN4mD0kHXQdKL7pfFwbSOVPOq5cmp1ogyXYd7QA2+aAiwYe9JY8IxDGaIsjp0C36UC
         mXMypPNOM/Zd1hmaKKE72prGlFsfirE07QymRmz7g4nGEVOT7ixBI7wZ/pP7j0dvPXCV
         7sg4AZCFvCsfKYz9Ug2JhaLAMHDWvhQhE4fZJY4w1jb7e/u6jdfwEnZrdoElWQDQEMZT
         SmMwhjG1jtpnRMiqVg3QuZEhwNX1MfD2KJqhJh45uTBjXrfh8BV9/FINGrbaWNCjPbNj
         eshrUR3VX2EAfnq+3AcIctKFCPxrapt1D/XrFdI42h/BUx/4/8BO1kk32nfmmhoOD6Lh
         lFZw==
X-Forwarded-Encrypted: i=1; AJvYcCWEKWlCK7JoWT7WJ1r6zazS/IIKDQmhgwi1LIY4JXEsH7NXwsXs7b/KSiTsnbjpueZkFNZxEEK4xRIBNt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPYFbKtW00y6QqicQG+X/GZakcyLYjd0vFvLPGh/x6VQjCIGA
	XcjoXHv4Z8ViEnzwSGQbwHboPFhOknTCC9X2aDhf+7t/OhbBOEgM0dtN9dKkNcdyuUYUOUYtply
	rADxrvyRVHdb4B0nL3RHFUmambItV+FHforUOTk35ikvP61Qt7oAWzoF7sqi4wggyzAM=
X-Gm-Gg: ASbGncsmKMbYM/FI6ObivYe6G87KQlMbLIRbFW2obtkdzfoapgNPJHHARWuOOOa5ZGN
	9OfW6IGzni5i900UVBKKObrq5joOn8JfIJgaorVUuBC27NRppV3uMrlfa73ct+t8MLN8DQAI4ZV
	d/8dnLZMBwQ0arYC3vzALKoUbfQQsI2onzGEl9xOgwM9qNQan3QhBMRkffD9xwqnNiF4aBhB5Bz
	lHneJcr1yz9TeGjrzyxGR8CF8MHjuo2ox0OsW7wGa5GQdm5lIFF+JX3i+XtID0s850pCHCl0Po9
	jeOXRE1wLTqkN0CoH4Xpw5oLCW846jbbns3urtDba8c9B20Feg6n6+YHF0vqunyHJVRmn1Ii5mt
	CYg99SlLEsiZe26ap4pAUKXa8YPVnwgofs4vxNsIh8Z18OxtkdtXR8Q==
X-Received: by 2002:a17:90b:4b09:b0:32e:e3af:45f6 with SMTP id 98e67ed59e1d1-3403a265529mr2007788a91.10.1761716675797;
        Tue, 28 Oct 2025 22:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh8rloteq7WeuPBaOFrjDmh+ZqqPoQGP+YRbt29wqi8injOzt+ncXOlRtdj7cS1pR/EjlmQw==
X-Received: by 2002:a17:90b:4b09:b0:32e:e3af:45f6 with SMTP id 98e67ed59e1d1-3403a265529mr2007753a91.10.1761716675284;
        Tue, 28 Oct 2025 22:44:35 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm14280643a91.5.2025.10.28.22.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 22:44:34 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 22:44:10 -0700
Subject: [PATCH v4 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-add-support-for-camss-on-kaanapali-v4-1-7eb484c89585@oss.qualcomm.com>
References: <20251028-add-support-for-camss-on-kaanapali-v4-0-7eb484c89585@oss.qualcomm.com>
In-Reply-To: <20251028-add-support-for-camss-on-kaanapali-v4-0-7eb484c89585@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Nu/cssdJ c=1 sm=1 tr=0 ts=6901a9c4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=j9zjN4cs5acD8dv8RPMA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: qvT50wOkFLJpSYESlcLG2pL0ZGJspBUg
X-Proofpoint-ORIG-GUID: qvT50wOkFLJpSYESlcLG2pL0ZGJspBUg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA0MSBTYWx0ZWRfX8T82GTNdUvTE
 Xnj6WkTyXDcqtJ07obFz4yUc46smR1z5KcZ85ggPyZtaOaOgzKAe8a+R9Eh097unr4ixx49s4R7
 BQPdsPdxrbBXwqLx3yHP0rYob9hUDxxFiiiVzHg3gsiy5GasMndBXxv7p6SJCSAHANCHqKf7Rmo
 pS3YRQcykS906vKPrNNDaMf/L1qTB2asZCpzeKlsDg/YCtQFsr99cMtbsAzqm0SmL1fjuW7fIUg
 LLpuASoI7voJOTezs8xvW1E/H10EXfP3S5IGsoeunPV/lFmQTcItQkfZzzTdk6mr6+DIv3p+sUU
 RQvlGG9c3c0kOGQkBa9P4RAA+6eF3ei+Xe31HQi+ec/jAZjaxHiuHxqqWjGfK02jriPn8tdXruq
 x3f5MIj88zWf93rPyehoosFxEocgCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290041

Add Kaanapali compatible consistent with CAMSS CCI interfaces.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 9bc99d736343..9b83ec63e124 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -25,6 +25,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,sa8775p-cci
               - qcom,sc7280-cci
@@ -128,6 +129,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
     then:
       properties:

-- 
2.34.1


