Return-Path: <linux-kernel+bounces-826034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB9B8D5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB77442715
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E8B2D29C6;
	Sun, 21 Sep 2025 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dmrbgMz5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C746C2D192B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438700; cv=none; b=cNzreAVjnbFVtrWsM/eEWaJl2NcN3B56cKrmMZQCREy8/ddClyIAVdo0N/M3txNoRALtthZkKX/jGRUDZeT6F4mAe2S4krsufFhPPYys6sxFtFUGJ8UMWIEcrX3gVxtPgLUtDkRX5ZdWFOsvmJ65NTpo60+IFBnoprloO6DAjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438700; c=relaxed/simple;
	bh=gkMfNWX7UF1qoXPLmQBXGIhOGX2CqmoLfAcVoTTxvTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1MZgRJCufkjjEJxbaFylzhu6/93oL/hcCFaq+gPurN9VkKNY9D1uB+AT6oyqaB/616dtVqc+sGafR64yTPLI+dGXt6P9LgYFwdqRs9Q06YBAuXQ2YUZjhdlwQga91VDLjWXf6IrcdSpe87kNII3Bj+yddaga6he2IQO++/a7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dmrbgMz5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L1xjxt029097
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hjSUqNHOwcOgxyTiutAx2CcM6pFy+KzH69E/2l64SVU=; b=dmrbgMz504vy3ARa
	p7+ySv9FffxK6p3vyWL5nYHaMrMF9AUeBJ/8laa6UIEMxcndOTwpBKm2S/0jSiwX
	1BzvSrkT11d+xCOLhxbOHoPY2XMw6Fh4raNFmcamNEu4r2xYzjDSLiWcxBoj572r
	lGeFUZD51yZRFs1QkbuY7m5GsLPdpMbLQZpmpMeSLyW0UHBRoyQ+F7eSCedUepfq
	ccX0HV4py5+dvHxBGrdk3O3R3KWS4cwWtcE+auTVyvDfS8AWwCnkOq9mV+oARBId
	gmxm1hlWedUNJx4Krw94cm7vDGkAyjQ9wPdYWkmr0j5HJva2nJCcBznQ5fytA8dh
	FofNBw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8spxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so60276511cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438694; x=1759043494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjSUqNHOwcOgxyTiutAx2CcM6pFy+KzH69E/2l64SVU=;
        b=rKEX8R4PjGa59IrKmzhRoofF5sho0oEq5A3EplcmkMFQzPu3QfHmSVDmlOotv3VUKg
         lWXt4CDSj5Q0jxzL4J3BPAOSofLHZPGgpHlE0iRlFcEeYa9KtKM5Fxd0N50zOHzCfmeC
         19BszbC5W5wpy7pkzLK0tDjsCJ1p4u3e/oldT/4MoFVdeyQe4LIYvLVgoi+0bn3OFE0Z
         55xoKaX23jtp6TycsNAkhXd+Q0AhQftde/mZ8nejxv83AWXeOR5UjXtiorLxXQpaiXxe
         BzRo7h91c8m9iRUkSwWKoI1rAwCCLncPXjZRxN3jAvjpgOAPE9NgUVCZ30nfe0sFQ8CS
         a/dw==
X-Forwarded-Encrypted: i=1; AJvYcCXk/XaW/Iwl5p20++6LFUqFGfYd6fFvts5/ikBR+OJtrY6AapZ/+kDLnBIsah8C/doQeSBtXbAmnL9eOJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFolBCbBROAyzWXf5cyOSC2HE/4s5P5xaocqTsr1lkFSlGuwZ
	XyUWoxRrjEBEjilZ9VVJQbURK5cksXaSjhsQ9GGxRZaTWDIwmbpnYBIYeTrNkaUHlzNVbCnoOF1
	T52iynOsUzewMmgqihWR2E2QboMMmVt8xqW95e7dZ0+JusfZy0lIY94mxd/dChVWzL+s=
X-Gm-Gg: ASbGncsDPDgkcIT2E8b80i7Gyy6TEqO13qZQSXqkmS88u6wsP6ml3u3mHafqN8Um+IN
	+ark9fY0TmoxEtBodIF1nfOgYYi/0rdCJzSo/8LqMkV++wUM335Ruk/n8VOJ/hgM16yseaUf0NF
	4ZgdjKXCgWLcseFUKls/J8wKgJSjFAiKrtgACcKFoZXcW5La1CDVmUg2EOv+5uAb5FYdXUG/w1i
	rWJfxrwfQ6FmZhTD5eTZhzDDPyQcDIW0yIcfLIXgm7YsBgJEMekCrHLysanUWn6i+RFQ9HmiuNr
	M8JUQZDkj5CEOAzc66GuB1VHwxWL+6uKoDxNnSRl1U/dDpBZJTiFMQB0nNoD1BJnxVdcaLUgl23
	6vB3I4wjlvZkOifmf7rWNePn4wt7LWFYN0It3MBryCNH7dvITDjSo
X-Received: by 2002:a05:622a:1ccc:b0:4b7:89b8:d09c with SMTP id d75a77b69052e-4c0755a3fd2mr90590541cf.74.1758438694368;
        Sun, 21 Sep 2025 00:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo+1aQxqQMBxF96A7LIXaDR0BfbSj6EHV9y/IvDyLt7koCg02jKaYp+23rpZ76kP5uPfRFbg==
X-Received: by 2002:a05:622a:1ccc:b0:4b7:89b8:d09c with SMTP id d75a77b69052e-4c0755a3fd2mr90590351cf.74.1758438693861;
        Sun, 21 Sep 2025 00:11:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:17 +0300
Subject: [PATCH 01/14] regulator: dt-bindings:
 qcom,sdm845-refgen-regulator: document more platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-1-9d93e64133ea@oss.qualcomm.com>
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
In-Reply-To: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gkMfNWX7UF1qoXPLmQBXGIhOGX2CqmoLfAcVoTTxvTQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6UgL0gkepLUc10qUCM/pJa7MkVq0ADnvx594
 VmJ24wYFTyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIAAKCRCLPIo+Aiko
 1fBJB/4hVPU4rixEFPDWJrldp2b6LfQlU82ZVppkwMnrRpfqXuLbdCuh9nmgiQeFylM40Hepq8W
 1bFc1YmSRKWUPaGSBYHpIsBMX3GlDClYgMjW2jtnSwuLJyztlzG7no/CrSbH4V6DuEm8V2yMu5F
 f3YLtWWgdq8u3vEe+JAZim4isqF3OqrpYr2xsgCFs2Evxa1czaP1G/xc9a2cp7cRNvZxrHJ02KT
 9qCVoskArsg05BvEwfD/If8NHIMA5v1yZBOy9p1zRRgPqVeabA4TEbX0lmRli+lnG0s4bHK4E1g
 kaq2sRqxYYcgZLctnCaCOf8LTLfu/V84ZjClIaRnOF+NlndK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68cfa529 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Z0kpv9XV0UCBN2vuPzcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: u_sHwTOgy6axRcknxDe6bguY4UAi4NJ9
X-Proofpoint-GUID: u_sHwTOgy6axRcknxDe6bguY4UAi4NJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfXwswFiEeUDOwp
 uMDsK2eAlu619xADVzW8vjYYqBXUD49jKiyrt4MqDWHcMA0sPvzuPY4AXwhnzFJERZ/TLR2Gc+X
 7Jugk5EDXG6a8aMxCjs645oKsi6OB7ASsQXfn7IIhfe5crEEbad3Obw+wdb2sVo7+ZegFQqS+V4
 FDY92rE3FH5Mh6HjjUb8Ir9ooQAQnHQNK7XoVh/7u7num2Sg3Q411dSbiUKB++lw7GjeX9/A5jg
 iMh28fKxofWCXzbMcdi89qCnyCAra8q9f1kSmT5+xRG2YKgA6uXTl/ihpm8/b9QD5rWu+eXWOAd
 Ow7/Wt0u2tGNYPe8MtiFABJnseyuzljp9WaGxiZc3bdN6JtEpD5r2Hng20ld6iPwWQ15P0qSI1J
 1jJD17+r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043

Document refgen block being present on SDM670, Lemans and QCS8300
platforms. It should be used to provide reference voltage to DSI
controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
index f02f97d4fdd215f3c83f851a5c5713488051e58d..40f9223d4c27219222a1036dece3b53ce0334a1e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,sdm845-refgen-regulator.yaml
@@ -23,11 +23,14 @@ properties:
           - enum:
               - qcom,sc7180-refgen-regulator
               - qcom,sc8180x-refgen-regulator
+              - qcom,sdm670-refgen-regulator
               - qcom,sm8150-refgen-regulator
           - const: qcom,sdm845-refgen-regulator
 
       - items:
           - enum:
+              - qcom,qcs8300-refgen-regulator
+              - qcom,sa8775p-refgen-regulator
               - qcom,sc7280-refgen-regulator
               - qcom,sc8280xp-refgen-regulator
               - qcom,sm6350-refgen-regulator

-- 
2.47.3


