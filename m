Return-Path: <linux-kernel+bounces-864340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDA2BFA8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F30254F66B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B790B2FABFA;
	Wed, 22 Oct 2025 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJkSjQyn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E92F90D6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118143; cv=none; b=D3mciQVVyI7yMlFsdgfuqSk+TlKLkwadeKoPkNF1E+FN9nJqvDFLuDpR4PZt2bxBhZ/10X6tny53wrRqlaW7VPNkSq5nd/JYkGBdmui2zbB5an9jBJgVZOhrrz2tjt4cHprp/VyMYKbwcP1Dae9GpoLyTG75orPJzwqE1bwsm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118143; c=relaxed/simple;
	bh=d6LoZRVEAeqEPQShLGGsaUfprEVuMtrCJ2M3G5JH1Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfYDLNNMudHPoUcyOm8HeWvxxmF+U2LXXN2ROD0mEis8dI/d4dvwu7Y4/EGTcNPv0sR9fzKXYkcBKjxXJybTX72A1dGdRToxhyvzpORpJN88Zrr2vow2wpBmHMd5eClX/GpuVvC1Sv/eyYg4khC+0E4wnuTlJpe/GzyklZGcOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WJkSjQyn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3Sstv004439
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1vYcux79sr7GRCh2xTNc3z2z/N537ViNEGo9Mt+EsHo=; b=WJkSjQynnCMVHOlv
	LZXwnT5nQhLdVfJI5EUFKZvs8UNAkWV7UIyItyHw15jbvLq1vuPqiSlRSYD454uh
	U8cowu528qvmSSZHCqNyn12PCeKOjhexcNpoqW0SoyIlFIBUuFyLTj9yGm+ulf4Q
	/ccVQtQBDQIFwhgUAFdcY2m/Te5+iVDgvtUI2q0Cj236KkF8jq65W97ePMuDuVHv
	T7Lg3qffTeQVfP7HQF5f/3/jPJlbtta2dW4PHMDJIyFVJHfoBd7COy/hXd9x6jKD
	rccUKjCw2xRtMZ6lgUHdRpnlyiUI2/vOCZRMVjHGmLkJ2k+Th4AaJE2A9Tim0k1V
	D+noKA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfkmrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so2426900a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118140; x=1761722940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vYcux79sr7GRCh2xTNc3z2z/N537ViNEGo9Mt+EsHo=;
        b=pgYOqSN/tO+pJHAw2P+Jtt+77De5N1MxpDLoB8hrGBuA+iVyDxn65Ynp0cd/4zATUG
         pMH7CoBsZKxfxbv7WCFZWapJP45mXCB7un3A9UKfiRd6TPL+PLOHqUas2GcUcVhRPtBW
         zkZsknInJLsNvYUHn7QsghHmrF2GyKlFfoYcnk744+fI3eSTDB2ZOwcRY0+Zkxn6MAgH
         14h3lR1GKhPCH9LMhXd0Vcwayg56ipZZ99VKxEomxe/FsFS+/5foOpez0B7AtuZ8MQDE
         RHDZZFyzi0DuWL401s9lGXOlkcFu675B5FBCLtWdPwYB+woyoqPYrV6wEe1CPJehRpFL
         HKWw==
X-Forwarded-Encrypted: i=1; AJvYcCXzXIiV/U+TT74n+nfGernS5iL/igcfSvAb709UAVed8vP56lzY15lLkVxG8ZwepdYD5fSUc0rdDlrlRtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76RlX8Cnsw5BKIpS4gqhOq4u5ybU0e+NjzT6kRynq3HwoVSHb
	Oowoilgbi53RAbXWPCypgfgmQf8I/ZjBLMR6sr5zPVef+3hMT9YTBUwDnFfb/u1aVrVeZ9rUvTe
	9VFtd5vKwZmGEr0Lyhqos61YNV8pucIneKHUaWc1y0oAygGeA6KIQ1zJ1VQ0jtzD4h38=
X-Gm-Gg: ASbGnctX/SYX5d/ccFwgalhyCe99CUBBsr+/uUmNSKZsHSz9o5iu9APKyQl7mnEZvcK
	84TxIWuS/K/UFixLb0PCEsCZAcTQVNuqOgJ0xzWS1R8zdjlq7v3acI13HwoUiiPjOuclwV52vK4
	MgmyBybOvUbiNw8jir9v5sf9E6mHXjFO21ex2UlBAxOZmZNYaW1hnjapSXvwtE97ow2nn65dwnX
	+P8jyKKVDsR8clqsXzvxFfVSGnoAOf/IGGQTClI5ABDSsQUgZyj179wleq3WvWQVlLCL9jUAjYi
	+RJQ+JRk+2UkakjhlD9aRj2kGn/HrvRvs/pYEMbp7eUl7U+F/YxvJlQTWPvyPRWxfXiZcqHtpRP
	uTRwyngs9oQYWNatF4ydVLCTvNKFIh607+4Na0YYt4AzIBNoEXA==
X-Received: by 2002:a17:90b:2692:b0:338:3221:9dc0 with SMTP id 98e67ed59e1d1-33bcf91f1dcmr24381146a91.37.1761118139840;
        Wed, 22 Oct 2025 00:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeAy6LGQ5ragdIjJI48LVf4NMUjtC7IuDfdWsBV7Haqt/Ymfy9bfKowNu0VlG3/QwAd7mG3g==
X-Received: by 2002:a17:90b:2692:b0:338:3221:9dc0 with SMTP id 98e67ed59e1d1-33bcf91f1dcmr24381117a91.37.1761118139416;
        Wed, 22 Oct 2025 00:28:59 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff4498d0sm1687342a91.11.2025.10.22.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:28:58 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 00:28:42 -0700
Subject: [PATCH v2 2/4] dt-bindings: soc: qcom,aoss-qmp: Document the
 Kaanapali AOSS channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-knp-soc-binding-v2-2-3cd3f390f3e2@oss.qualcomm.com>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
In-Reply-To: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Eugen Hristev <eugen.hristev@linaro.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761118135; l=931;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=d6LoZRVEAeqEPQShLGGsaUfprEVuMtrCJ2M3G5JH1Ys=;
 b=QmAA0XesK6oX0jh2aKtFroITSokVtnP/WidJx2NR1Nz90BayYXnxJRWDlHSbfoiU/A5hsR53G
 Mrj1r7XzgLPD/Np+IubFoKQnk79zGweVapMrYV44uMlKSzHVyz3SYza
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: -8wnIvKblbGdGWk4bd1CLpc0IvgH30hT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXyrWyvhHTOcPO
 GaDOMSUhxZ1k4F8CMFMkQ30qeBl1lbRD5BuqRrpkp3WenC/dkZT6ljefsAgqf4RKQJQNV0nEgpf
 z7lHRV5Z+R0bbI05o2sAveFjGAOjEqBn7474AHgd/w+wDmof0ww77pWhgDvfOkYs3oHAjzUbxZu
 ekKXqDnf7q37sb1uCV38FWtdI7rvQCoDkdZW8nKRrrzZL3PtnGpoF/cSD8jH32HltoALa5X8MAD
 L4mJFn+GprQzy57EzFSy+J+lsRVpD3alyyTHGyCMCq2u8mh5UKiEe9n+sDey7dYW7PxpbiLnxvd
 0NMukNTivMtaX5yjhaxAort5VgVoQV6QxGedQ6qToEx8qDfsT9YNFcQNmFKpYxz2tmnAj/sRo3w
 mWzyp6d829CZZSkUfnvNqbAeEwlNnw==
X-Proofpoint-GUID: -8wnIvKblbGdGWk4bd1CLpc0IvgH30hT
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f887bc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XyoQbdpzVujUkJi0dowA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

Document the Always-On Subsystem side channel on the Qualcomm Kaanapali
platform for communication with client found on the SoC such as
remoteprocs.

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 851a1260f8dc..57aa819939f0 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,kaanapali-aoss-qmp
           - qcom,milos-aoss-qmp
           - qcom,qcs615-aoss-qmp
           - qcom,qcs8300-aoss-qmp

-- 
2.25.1


