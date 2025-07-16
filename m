Return-Path: <linux-kernel+bounces-733851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0EB079E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD0A1887A37
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B302F4303;
	Wed, 16 Jul 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vtbc4OJ3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE72F2C54
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679698; cv=none; b=WsXgTI8UkXeXvzcEmlFaeKFkia6IVCLIg2uhllDrtQ1QtudJhVnTuX5muO7+xz1k7FJE6ZFwWY+zuOIJ0Yo6E8pP05sicZpKIfygqXh2ylvhvnR94dkM1g/dWT2k02Gm1tqjXUfiFUHiUDhxUytPVEZ+QjyeA7v51nsP2KEJo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679698; c=relaxed/simple;
	bh=awJhqK9vZx7HfSJmr9fd7vWzKJvnlam9KSwzA05jp7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+wMKWgdxT7Vl98TZKKe33BZ9dXAWTzzOkbbTlIGizxiJku8ds7faQCS083NFSs8NSahqF7WO7TdLXR7W/sGg8VJsPfXtYX1HrLrx+4qd+UPVOVdBx1BtKCCIuYt0RKxSpT0KTmnluqNjqAWVilbUquSBTy85LcBXQ6U498z9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vtbc4OJ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD4oZc024486
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eId7Thpi9XZ
	dt0UdhQINAu7XwHMfKszVh+XHIOlEnig=; b=Vtbc4OJ3gC+WqXbqSbAz5OFi+Re
	932uuNUJV4X43NhFdYr0TIfI9s6nX/IRCHIxUooAqPSWHeAzPZlozHzPVosugvw/
	UDyr7afk4IWMlinxR/OGcNCDePpoH8PtiOsGe6JzIOC2cAaV287DUDcWQahHVYaD
	ddO2QO5ajKhv1gq2xL1xpoX6W1l6hZC4RPOV3VRht2wl8DlDm5+yu2ubYx9RMmxR
	nmuJ01RhahDKys4N/8sMlYzYvssR21hmWZWUxTjtpVo+3JWjCic8L/5WdImaCyy2
	OeS1lEBZ9TNuX4AmXnfIE3rquFLVicDbYe6UHjViPtfIk9fN1mlLMhe0Q0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpff5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso64496a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679696; x=1753284496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eId7Thpi9XZdt0UdhQINAu7XwHMfKszVh+XHIOlEnig=;
        b=jLpAyj3hCo6HfnXT+mVWYKgb6gHCxEwF/TrUhS8vzujlJQyeHKK4M4UJSi+h9QkZPN
         zjpPbvZX8f1mpK1YxNT41zJKXAdLXFEg15HYDOF6QhSFsR11fZKxFdOd5q0Fg+vqzET6
         jcap2Og7+uIC5THG82CWmSsf5prMU7og2Q8A/JKkjxmzJ+x37OQMPA/TgZAj5FvTNhdb
         3DWFBzGUYaf90kIl/h9l2rorseE+UR6Sgw/fTFfvG7XYlT3MZBsrzz7j8UpNvSxKrc/z
         OtgcQN0vQALuVAVUijxrW0R0PWrvyEV8XfujBfiDdeS9K1J7mdtdTzgIBIogEv4FcUO7
         OuBg==
X-Forwarded-Encrypted: i=1; AJvYcCWyLcV5Q122VFkYWGQbWi4NO/WuXB0hFejLpusn5J3CGsn4Dx9S1wBDjtQP8JOCqcaTx8oEG/J2BK92zhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRDSYLS/ZIewYIKqsxwAYAQG3YgQY7LhxHhRQsr8fVHYroObI
	9ipRUn+z8hP1QoLiCfVTvuGIaw8/OP9EmP0SptkeLVTUm5CY6zD/eI7ByQPrcThFeBinxoRgz2K
	lzFctRXuP5JKSkuhWqT/b53h4RxaWZgKlEGu+U7ONoduhcgQqdrh7osBkx4gTxE2e1cU=
X-Gm-Gg: ASbGncvzBKJ5xsAn5UZNLBiLi1NG8MjLDKMYSPjoe/L5WGETuFqcqtsRxpoJcpC/Yf7
	OOGzl1zYCzOwkLMoRR6Syt3qiVvARUFtvM9OEbXY/xWIrOhRd6Sg8MaM3SEytrYwV0h3iyy7psK
	CQvPXgIFroI4XxJpIMdHT7Ho/xMTpGt2nTTtXG65Dclhgu/PxVWcCoNkTfHytswaUmybyq/PUgB
	GvQ2Va++X/fJQVA5vujaOwsvQ94QgECgBL2uc50XwK6xoCKdoAnr8GGJ/UenUoPLlriLkxhW2Rk
	SARRvpaNults0HcoLf1ZES6A1wlT25xx5mliGVrxUJKjjATXxv1tK8D90O6zuzPqKH3yMGARqSC
	pK9IsVGBUpKNnti1uvXmWuyI86sL4swVftBSikSZxQuoAeYqjRMcU/t2x3Q0e
X-Received: by 2002:a17:90b:3511:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-31c9f45e1c5mr3880526a91.21.1752679695713;
        Wed, 16 Jul 2025 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtxskSX4ykowgYW6uvYkR4w5BMuKXIb3nL0la8MIwNTod9JbY4bqqI87oJ/MQXKSnNbpjtsQ==
X-Received: by 2002:a17:90b:3511:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-31c9f45e1c5mr3880481a91.21.1752679695170;
        Wed, 16 Jul 2025 08:28:15 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f20e87bsm1688563a91.35.2025.07.16.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:28:14 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, konrad.dybcio@oss.qualcomm.com,
        quic_tingguoc@quicinc.com, quic_rjendra@quicinc.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: rpmpd: Add Glymur power domains
Date: Wed, 16 Jul 2025 20:57:57 +0530
Message-Id: <20250716152758.4079467-2-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfX50lQ1dYc1rrP
 6xb4b6o/XeD2tzTWka5fMFCv7M3YjC+yQrZEe+dTY8jhA47j5Ea6sJtZ0NPsBL7pBh0IWXtJ0dR
 c7NaU88myg08s43o2aKqlpo6BiMLGehToEj2sQJaUWcMJo0fyCDjSrjKWDHahFGRs1nVbE8sh5g
 iiGebGP6tt//epCwWXI+npWkCel7kUOPzOjeOhflt8P+YGjTCcPzs2T2Rd+we5FttNoNStPE72B
 ZYlk+xZPsqZGdGsddj/nBYYpeCBObHgHhjSpGweA2FrUiD/Nf2nl6tx0V/U/cUPk9OdehdvdneA
 7YHYp3YClbqOro6m48t9KlCBPPiYEgVCJ7Sg3eJ5E3SqM8A5I2HdawioK97/v/Qj6I7nzpZPXy4
 Xo5BYaBOf530+qggXwd1xr3CPTTUxYjNva1BMz2n+wGhCUa6jDxWWGxuq6hXHQFgz+5FWDJW
X-Proofpoint-GUID: rTXp2fUKVav0TuXsVObqcOYneXAe4I_g
X-Proofpoint-ORIG-GUID: rTXp2fUKVav0TuXsVObqcOYneXAe4I_g
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877c510 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mKLVYdK_SoQD2tn2_ugA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=941 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160139

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add the compatibles for the rpmpd power domains on glymur
boards

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 7d4394a3ccbc..af5fef872529 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,glymur-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd
           - qcom,msm8226-rpmpd
-- 
2.34.1


