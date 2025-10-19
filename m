Return-Path: <linux-kernel+bounces-859636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD33BEE2B3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1143E3E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A72E1F13;
	Sun, 19 Oct 2025 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOk/pn2U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE41FECBA
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760868441; cv=none; b=D8Yzet5a6LNodZp6/veoGeFw/X11t1vjfa423v66bVYOGUrtY2zmjT/mX+XCRwRuJzMSEHn93C45gHzC1shpJhnujycHU2Cm+Q0r1imYBb9tax4SE6ZOePuAKFmz2jcUhMmq5KYkVR8iQXS6LYhLjn1FMhcFFYi2RbwIOT3Uc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760868441; c=relaxed/simple;
	bh=Z9wn+M7irHGk3X9J0GlQej6gqejoN4sRM5ZhbQI0GmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKk2UfJKU5OYBn+sWQBiIo2MzjVLeG853QR53MmGFIuvHuvMPGX3wrg+TAN13xAOJ+vKMAZ9MhPKJToGaRrInUw9R6Vb3j7W6Lmq1+TitY1qoIu+yKYvlfQlHBRMGaOUWaSgFjbPWsxIUIjEDaG+ck9sWAt6BColJFqi+qoUDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOk/pn2U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JA18c6016360
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xmzL7KRfQC16hQMPRrMbIpgrb/rzauc9dZ2
	jduSZegQ=; b=MOk/pn2U1pXNkTrsfUleqnyUMqw3gg81Gk/A1pSB0kyYVyhkkWO
	HLXAc+DOB2IMHTstKcT4WELfBEB+J2mumYB/LcU0RLZ87l9ZZPgpIDh7dSSPIw30
	dguGQ6XWclgCCkqE5Fgayfw5c71Q83fXXP2M0weTfUSzYinJd+RMnGDogliK4J25
	lLXbdx7azL3UZtMMYPpS151L6ERIc/FcjjOf2JoGIFS7BzDH2IBe0k3FIW0jyHx/
	RK9P4xoHpTJ4aOM2GaW0UfIoRbJcSJobH0YyC949Q7UwfIfc2xNkQ5BeEMFk9kFr
	Q8gxihYn0cfWHw7qUBMVRiYWHRUp25F641g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v343t5p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:07:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78117b8e49fso6435492b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 03:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760868438; x=1761473238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmzL7KRfQC16hQMPRrMbIpgrb/rzauc9dZ2jduSZegQ=;
        b=bTACN6GQToS8auIvjG7NCXrt3c+0uHlyoA8H3zIN2nCxzb2GbXcpfEuJRgxRMWgCyK
         1wdUYpfjUYBhj26+TL/B74oENMkwJ/iBy91KIiOALhFa+xIaiIDCMIdACoZpVVRbgzJP
         Essd0tAK55cHQr/N+815uaRUNJBmnZHwvH+tMBEsvdPlDIMF1Qk5mPgdtedqjTArPL9s
         Pox9zYBBxKcA7LmqssKq77Fv9bw8nKyegIZ16tQakoHkNonzLfiGwF8w5HC2DD5nBIIS
         1QgZYmdRXLmSrSkrwZPg8x6RfoDtEkrXDSu0PdQJXqFYL8ZkOhGf3jmrrXwRQ4qM0ujk
         CvYg==
X-Gm-Message-State: AOJu0YwsB0idXmu+e1Hqsd2P02hk1K+BzERdzXxaXemnvlFduwpok4X0
	UyudstdZTSS8THGhim+oWAy7jecHd99EuNtbfBkZ5VBXrnTTmYt++SaVW84+fRCb52Px69JkC1F
	Vir1zSJpNGULMu3C3YgrXIYlZTQgM+iPPkommysmcaNTxSrjpUpVhWF0GtrOr+DyOfPQ=
X-Gm-Gg: ASbGnctOgIHNhY5PtOTfv1f5zv9HHZjC9MHLxQwLoSxXZDn2K8ujoHhYPoc8VMmkK9C
	3HokLVJfilsjuroFms7oo7IUBdyr+PcRapQU0BpT3H3VKQpEUwyTSy+o8ozDPSJWB2BQRqwfj39
	mIhH5CiZw2pqhRF9ZN2HppTKH+lVnZu6MlxMOTk9G7WZuY7FEl2/JCiiS00vQSzeN3cH2p+VPym
	cCUeF1oVoFjgymYfs9WfVbkD8Qv+0xP+RjqeYuHr1x3kNAXkwf8dENy3RJ06AMgQiI3pfTklYlB
	lOrdL544ptcTRnUL7Rj7HPluEyU+kyXX2UdCf3oBGT76JOVPlVaeqhtpjqnlhNfymN5Ge+K97E0
	qN6hxd0Bu2HyRv3aZkc2RZG0XbN29A4K1g5Ms
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr11603248b3a.14.1760868437955;
        Sun, 19 Oct 2025 03:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLogKpusAUqi/ZrPWUptF2TZzAyVlU9az+bAsle6LUhGFG6N0MgmqGg8HumSlAUKosZqg/Nw==
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr11603224b3a.14.1760868437401;
        Sun, 19 Oct 2025 03:07:17 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f252csm5034223b3a.38.2025.10.19.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 03:07:17 -0700 (PDT)
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
Subject: [PATCH v2] arm64: defconfig: Enable Qualcomm providers for SAR2130P QAR platform
Date: Sun, 19 Oct 2025 15:37:07 +0530
Message-Id: <20251019100707.2077664-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XEUATHY8ZMLaBuWTIT9k25fWnt88KOqr
X-Proofpoint-ORIG-GUID: XEUATHY8ZMLaBuWTIT9k25fWnt88KOqr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX3nnAxyEe01hR
 OA8PODxX7/FMxZeuZ03nN6BwQSlAw2nTezsA+nJjcNzFJIQmKfDYmlnW8al4ZT6LNjSPs27dxC/
 ibmdq4gyNOSWQrGU2V8q+E4gUOS8/410GVV5fiQi1wNvjL8VgQRlJehUH/tdMTESxgpJROkI9JB
 bwAbduCYrVQhgxBEinwlH1XQwYDDy37zWH8YqwaZ2j3WLLLgACTE7J2vaPfqs7U6wX0AR0DaiK/
 s+lzR3BjpnTPpbz6H7nPMui5TkRWqvPA4kq7UpFKwi7Pf4dbiNZ7aQzwPDrdAKMkOOHSS8uwXFP
 bq+qF8Fd06qvCUyv/smG818H9ABm4yfHye0y43fQiCYRWuS4AsREDuce+R3yODJV3Pe12OrOEyJ
 RH+acm3QnG1eq9a076a72kOsLJsVpg==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f4b856 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uDsBS04G_8_smW8TLqAA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

The Qualcomm SAR2130P QAR platform needs the global clock controller,
interconnect provider and TLMM pinctrl in order to boot. Enable these
as builtin, as they are needed in order to provide e.g. UART.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v2:
Update commit text.

Link to v1:
https://lore.kernel.org/all/20251018105125.1504302-1-krishna.kurapati@oss.qualcomm.com/

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


