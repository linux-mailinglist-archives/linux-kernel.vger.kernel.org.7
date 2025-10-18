Return-Path: <linux-kernel+bounces-859138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 992C7BECDBA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CA3B7D28
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1943D2FB0BE;
	Sat, 18 Oct 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaaEDefC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982032F616C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760784697; cv=none; b=VymEu02e6+jONMKFcHj+RvUItuM2qolNK1svO3zWXpZ0q9K2wcOBjG4nlPAWpLfFUqWXTzffFHRGwF/JJ7ILC9lv32rKzPQ8gX4kwy5RFuuPtDtdwvj4IT7U+FrgYysvQaFfIs3cmCF7lcL6vbBknsMi7rvRJ75QzhIdUDo2KmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760784697; c=relaxed/simple;
	bh=ed5lL1gkjwnLlkuOV+0QGkof9/2ad8yjGkPdNCG8zuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AR8PRhu3qLpmKlaJ++EE0b+WBwEzAM2/cJ3Qi3ujZ96iXRo5j4bwIsMgJHYCQlcErGJH8Tf8LNBpGm+ZntiYF/ZR4R/9t1ok+bSHxofEYlyZg48XV0NdtayGPvP4kpkt90qjNaW7EX4NZE+d0SvPG81fzl3NZqFrT0IbTsIa0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PaaEDefC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IAdpH3000652
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hqK+ktKn5p2Sycbk9Vp1iT146/NQ/MmzUNc
	kVlG0wMs=; b=PaaEDefCbyNFvnQNy6EA4tBaimxwQmb8uzgWFMvIdAvOvqK9UOc
	FqNDUbpniYz2UY37CI1KRMCkpCYWy/gpAB+mY+1DO5PkTy8S2CWaVenfeuNRTr+w
	inhMY+k8UKxbwm3xo9TCX0dKBD4ScjzSNVuaCJ9WGnMEbA43OpozF6bsf0VSheXr
	69fJmhOY4kKi8s6QQSQ4ixwGwAG2wNGBH/IX9k2IdFQfS8rSA2i+UztCkjHXsle7
	9gTyHth7Hjik36kEr+WuClclpZg0RIybIaD22b6jUP1DgVFvMZVUp+STPJhBbcbe
	EBkZbT1PB9Aai43m3b5F9ntU2HOg2JfxFMw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdrmdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:51:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso4335532a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760784693; x=1761389493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqK+ktKn5p2Sycbk9Vp1iT146/NQ/MmzUNckVlG0wMs=;
        b=H2GATQBUI82lmQ7N3WDqfrzkJwnPyXmyxzAMwWcBwApkYJHVKIKzHqLQxTEuY8ab6z
         d/shMaeBNRw273kBS08yvSQhcOseCuLqLaf9WxW7ZCE/G1Dfh+xoHdcY1+CY2MIBlrvP
         Bj+1Uf3TMGe+EG7MYBaOE3cXJXntOaBQHzy+QZHKSq8zKBu/ajvxzzLILoieap8fjemf
         r6MEmyWjac/xx6k1YlmacTDqBVaHVzk7cCNruT6gzT8w7L1Ob5ckyq2Y7yn3AXxnl6Ck
         9NlvCX7oFvB2fF7S/gdA4lncMqqQaGMFzMLXtAoUFw+3qUJB4k7kAhOigI3443lhGv+k
         hN3g==
X-Gm-Message-State: AOJu0YwcrwWh6ixbEMil99A6NrnUZWkuPwRvjBFuC0Hw64K4SSl4zSz9
	a+DYkuibMoHtuhE4hl0xnsELDy6xaTNH1jBKr4tBmCaqDiU98YniAg3OUz9PA29rzHTOOH75jPq
	A3vjCiry1DLIFlt0sxk/zj3P9iH9EqffBrwjYRozqUqu473/K6xYPBKRR7MH4ooVDY0c=
X-Gm-Gg: ASbGnctuBzFPaWd4JJ4p5WEXufRy1KwSfz6KP9Mnpxl6W7n+UgY4VHhjuQKs7kwDejG
	41Yqk96RYPKOPofyh0wn51xmcyMFEDk6kR4oAsEC/xv3VfsEa2frHjfmeXGx89spRdokqgDxtGz
	cQxC6wsXUmp8JL5U/8TxVRyCmoNMgc+SBQHO7V2gdSnlj8OY1bO3Rf5Cr7iIObp8A8QKTpoAioB
	zH14YxR26zOcuA3Bi6GJC0nBsL3+yfZfHrK7a+hVd3rHGajOmzBxF2lfsuwTiuz2uOk7eWOGfHK
	a2AWzUZ6hTPfhxuQvGmvhZzvnYbqjtTe1zyYh+VNsDaClsdg7jVYz6hyixILTUnHJOd5R75QadH
	k0oE8hhF4IqSbH971ckHuIv/DPX88XHzQAUSO
X-Received: by 2002:a17:90b:5104:b0:330:a228:d2c with SMTP id 98e67ed59e1d1-33bcf899d55mr8717359a91.15.1760784693115;
        Sat, 18 Oct 2025 03:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxV/NIxb+N2l2C5TU7UEzNQCKR8nPpWarVQRFYGCeMTBGT7E1i6opXhydwWH6ldqHaaEkFZg==
X-Received: by 2002:a17:90b:5104:b0:330:a228:d2c with SMTP id 98e67ed59e1d1-33bcf899d55mr8717334a91.15.1760784692661;
        Sat, 18 Oct 2025 03:51:32 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bcfc15c51sm2832934a91.6.2025.10.18.03.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 03:51:32 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SAR2130P providers
Date: Sat, 18 Oct 2025 16:21:25 +0530
Message-Id: <20251018105125.1504302-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfXxZJPaC/W5a+0
 y+hMIV8S/QPAPovEVxyDqczQhr0FD/7TiomX+SZXQyI1pICGQSWKPCYb+6MTLSQ5qw5DlSZmv7G
 pu04NszNNW1NkRGm6D6PxIDzCIuPArwMLMSBzwfnn/1AULuCike7tsICi6opQD/gFxdxtxfZ+Ya
 iu4hDereqoh5vVdGkxpeACQzrZNBGmJiPCqrMj9H23IwqxS8NAnNookFAXZ1CcDhz0+aZTsYxu7
 E/QFKRUZo0VoZMijOSUbekuaP054cF7SIehN2EWdcZqPFUZq5GSt+QGh4elUI3q+lYszieu4AlG
 2qzYjqqRL546YIyIZrrGMfzUICiolp/TgU/u7dnkEgQ7R5voEfFmqPS4rPdk151y9B5XDiJtwsq
 Hoygv4im4imSfl9w+UDvuVGjwP5XiA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f37136 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=oj1PJgbav9-28Dx1e00A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: EEL2_bUrwIAw15i9Y4M6CbKcpqHV0prk
X-Proofpoint-ORIG-GUID: EEL2_bUrwIAw15i9Y4M6CbKcpqHV0prk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

The Qualcomm SAR2130P need the global clock controller, interconnect
provider and TLMM pinctrl in order to boot. Enable these as builtin, as
they are needed in order to provide e.g. UART.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9379cb230f6d..6d84814beb6a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -648,6 +648,7 @@ CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
 CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
+CONFIG_PINCTRL_SAR2130P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
 CONFIG_PINCTRL_SC8180X=y
@@ -1442,6 +1443,7 @@ CONFIG_SC_DISPCC_8280XP=m
 CONFIG_SA_DISPCC_8775P=m
 CONFIG_SA_GCC_8775P=y
 CONFIG_SA_GPUCC_8775P=m
+CONFIG_SAR_GCC_2130P=y
 CONFIG_SC_GCC_7180=y
 CONFIG_SC_GCC_7280=y
 CONFIG_SC_GCC_8180X=y
@@ -1770,6 +1772,7 @@ CONFIG_INTERCONNECT_QCOM_QCS615=y
 CONFIG_INTERCONNECT_QCOM_QCS8300=y
 CONFIG_INTERCONNECT_QCOM_QDU1000=y
 CONFIG_INTERCONNECT_QCOM_SA8775P=y
+CONFIG_INTERCONNECT_QCOM_SAR2130P=y
 CONFIG_INTERCONNECT_QCOM_SC7180=y
 CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SC8180X=y
-- 
2.34.1


