Return-Path: <linux-kernel+bounces-884264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F04C2FC40
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A467C4EF07A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7B30BF55;
	Tue,  4 Nov 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ho83yw9o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hUoU408f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795629B795
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243865; cv=none; b=T4dfEyoTjkOZRm2Qk/rgMD+KTuYWQQ2JqswrDfR/PH6g2UuQwT+0exDKlzFDk5JosCBuL5kFc1uygz+cE8nDEdd1oCd6ibVnuBamAG4nRY5k4VfGmrACgZq1ZA/6PLe5942PExdwLHgh962aVArGi24WHTFLQg/82DEqcvDo/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243865; c=relaxed/simple;
	bh=hY8QGaaBRDrmil3lFdEE6/N7Jlz3Z1TcLtB6hu4+oNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U5vIUcP6dQvtfbjxgu/W6y5DiBbi0RdmniR5tZyKKABzP+3OfudSBUDw/7u74iVNQW9noWdm0zJYVssI3UUIsd5ywrkSIBtF00p8P5jzdkk1Yti6tNmDoh9+RmkvREjvpXuBRp02UF6YCoUSYTWa725+XdegtooxEQH6e+Nk51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ho83yw9o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hUoU408f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42iZYZ3693375
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 08:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YlVpMTLZCIJT4QZ2eLCmWG
	pdnEz2lSRzRDI0TPUkxuI=; b=Ho83yw9oCl1hD8u3xtMx5DwtazU0uqEu+SLSlw
	lTE/aJ10NB/2k1mzV1jf1PjaSBZzLj4XVlRcB9geqDxWQIeikG+ke4hKamNwk+NO
	80ju+JhQ5hqQ7s6++wNlCkq6IQuUv1lGH2AS8vcwQfp9n+wEXHbx1mKomQnRAud+
	J/u3HC5VxhSYJRXDoQyUySp1gQfpVogJzMCqG7aHTqhKCGvHLbcJ9hH883Hs8w6Z
	pQCTf1qMluKDNnLcJid4C5xMOduKIeBhuC0ofcjLKC8zQ33DRX1ZOylHXezCaDhf
	mNFPGOG1Vm9LXrkGnipkOv45LhnrloreQ10zoARfzs71AdTg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b353r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:11:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2955555f73dso24132305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762243861; x=1762848661; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlVpMTLZCIJT4QZ2eLCmWGpdnEz2lSRzRDI0TPUkxuI=;
        b=hUoU408fpyI6zpArmKT76w/bwMfm7aTxNFWs55omyQ81JX87MLW96FE8y5YFZzFBTg
         o02/4S4Ablcgbk+/9Y3MLHvPqV8gePk+F2b9kI+D77ca071aZLzvTSoFeO9IuRXjRviS
         Yqa92mmOHE2Dxwraq8iTqerqW7nrjOgoq74qhSbtfByYZt0S/hxqbl58f4JN9uu0/dtP
         fdyifPKf4dnDptgQzExiB25nTqDJ64tL+5QbDD0y903GLEcvMGdUBvEbFDaPPdLiZiVO
         sa9D7uqDDOCFy4cmKmnhorVQtHfTmOimXmEebGoWpZs4QApgrJMb0WxJDOKit1HPVK68
         HMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243861; x=1762848661;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlVpMTLZCIJT4QZ2eLCmWGpdnEz2lSRzRDI0TPUkxuI=;
        b=vK/0dNC5vtzzZlGnjntTGdC18z/V9mMaKK/lt8elmCtKufw3/Ro/zC7l8kaPWt5Ob7
         IjbRRh9tN8JqDtZs2jL/yFEqU4z19leBV8WjYn8rHxja1r+O7DScPUeeVUV4ATaGPFL2
         eycDyjaS9Mb+28x/Z3JQauLDQMHVfhBuuMdT8/MfPqfcLSKZT5dlD4kb9NrIzxMx/fpZ
         21sFpRCpvKRVferwyATyqK4gM2Vg2f7r+qS1cPR0wbZVTrk3oT/lrGwsde5tYbrPwUNG
         9vGwMaLxA6UXS5rkzwG3n8JXIvWg7qRfoAvhd8QmYUB+s+Oh3R0kHrLHkRMA6muvySYe
         NIUw==
X-Forwarded-Encrypted: i=1; AJvYcCUg2EtQQqKS1F33VF+UVAD9ZniWMH2XFWoukipBjoH+Qe2VVSc0MPle1mT6xMDXXy5ckJpV+7uNe5QSqi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdLs4PtPZkKP0GAE4lqePKWq5V3vfl6S6Px2vcQZkajvkNyfb
	gVJroviWHdTyFg8OzocfCYNq/MwqrKHmOknl8IiFZSvYUInXSMjb4Uh7GyTo96uqj0rXC7ULIfV
	1Gi1JliCe98F2L56g0m3Lo6oWbX781sFB2z0X8PDAacPZ+AP3vu7L55/Ec65lXCwcbPzx6OqZmF
	zjVw==
X-Gm-Gg: ASbGncuBJPQqpMNEiVlEzap4BaiipElfeWlo2EAuGwNLSfvvaSBTe3VLdTd5YyzqZ9p
	k3ZAwjiwfAUAcilWKJLWsJ3SCS2Cx+I7snaBCAQaZEBXKDRutImAIU2z75RAbs/q8GpSLPZ/TXJ
	YSo6AGmbfY97S4ZgCKu1vBis39vAAO+5syX5s8P3rNSSJEjSKfu0oWh6CDq1retfFtC5xrPXVNV
	TtSsrHuPIhZ309IaLyzgxLgxnBxBH5TFT4K01UxhC1kSG+SkiR1claqAUf4Qw2ZXoA1UUuEHCaQ
	tmjL9QaQqOmBf2qUEgnGSc7GXOETEHy4Qx88J1TKnOuAwk6W+GvS/9/NaDH9V5JbNV6/OdhLCG9
	MHxRFUeUBsk/tkFDS3x8NW3oo8k4lOlGC8m5GmUjIiTHetcj7ue9Uh1hmleiCdg==
X-Received: by 2002:a17:902:c409:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-2951a3a63a8mr243445805ad.11.1762243860844;
        Tue, 04 Nov 2025 00:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVDe/NA67RNDYoNV6Fh/VpwhJBC1Qs5jI1D9PjxLgSztMXaR8aWzZLebyst8NkIBj3iMctIA==
X-Received: by 2002:a17:902:c409:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-2951a3a63a8mr243445365ad.11.1762243860275;
        Tue, 04 Nov 2025 00:11:00 -0800 (PST)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7afe3sm16755885ad.110.2025.11.04.00.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:10:59 -0800 (PST)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH 0/2] Enable ETR and CTCU device for hamoa
Date: Tue, 04 Nov 2025 16:10:16 +0800
Message-Id: <20251104-enable-etr-and-ctcu-for-hamoa-v1-0-af552cfb902c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOm0CWkC/x3MQQrCMBAF0KuUWTvQtAlYryIuxuTXDmgikypC6
 d0bXL7N26jCFJUu3UaGr1YtucGdOoqL5AdYUzMN/RCc6z0jy/0JxmosOXFc44fnYrzIqwiHFP0
 UJvjxDGrH2zDr7/9fb/t+ANTUJKxvAAAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762243854; l=845;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=hY8QGaaBRDrmil3lFdEE6/N7Jlz3Z1TcLtB6hu4+oNA=;
 b=F66Kby4OhsustC4D0QuoPkkC+iYUFKXQWqpvtHRuOU4XCeJS6LUgIAdOxn0HgFDxNvJPvK8nV
 qGc21kxe/kSCXT9vioMLZDhrIhez2X1ByoVb7qMZFZ9uy6GWNqxD597
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NiBTYWx0ZWRfX5D6hhhL/mgKu
 u8Rzrc2iTnjhJZVYvU2a8iboJXuMY/9D3nxIsy2KaMETYnFNXEkMOX22PduwQ2AL9+NeFd5eFkB
 xtLi6QeRpCEMN17O9+yif5NvcNNV0PnoY0ZnX/uQ9UlTcYSM8geWVejBFNkeuL1CXLgjNlpc7i8
 c5b5d5K/8T5MM8QlPXwt2P59H39PwbgZPAff+ga0UnZsvrR3Md5m2UGfnkygiAhYhAzQgJlqRCi
 /PLKgl3C7GCIAuYw7faKVN/IcB0a6TSE8VMN+Z2QkXMZV1pg1xL5msqOIFcbLCGDXHdLOUI9yW5
 UU+F853crxpNFb0+46RpFbPGNQrF9Urw7Ay/6WpKlMqUCBsaY1+ZsyY4wES9pgP48vO33NDN6EJ
 5IKf1TiwFhR6c08sm4NO04QAnnGdLw==
X-Proofpoint-GUID: vp9eV2H0oQ1ql7-JAtLyh25AoLDZK8WB
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6909b516 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=EinoZS_c4zY4h5tRugQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: vp9eV2H0oQ1ql7-JAtLyh25AoLDZK8WB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040066

Enable support for ETR and CTCU devices on the Hamoa platform. The
newly added CTCU compatible will fallback to qcom,sa8775p-ctcu for device
probing.

Dependency of the binding path:
https://lore.kernel.org/all/20251103-enable-ctcu-for-monaco-v4-1-92ff83201584@oss.qualcomm.com/

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Jie Gan (2):
      dt-binding: arm: add CTCU device for hamoa
      arm64: dts: qcom: hamoa: enable ETR and CTCU devices

 .../bindings/arm/qcom,coresight-ctcu.yaml          |   1 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi                | 160 ++++++++++++++++++++-
 2 files changed, 160 insertions(+), 1 deletion(-)
---
base-commit: 23ece2b586cd740840b5b9359a767477435e94d0
change-id: 20251104-enable-etr-and-ctcu-for-hamoa-5dc4959e438e

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


