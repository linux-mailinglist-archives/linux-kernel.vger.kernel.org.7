Return-Path: <linux-kernel+bounces-831368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12203B9C79B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753E117F45B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155A02C21E7;
	Wed, 24 Sep 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UO1djkn5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872382C11CF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755772; cv=none; b=Jg8qZdMPmGTldNGlfE7qMw+PDI/Nh3p+AgPJYMJFmuGiy6dXP9CqdmFadatbNBIjykxCq9U/Sds2xtYlhS12l+zOl6xWuNLnwUUuXI8Qkc0p6q41I5DcEPMY7LFQNcBmhpZnbf3m34+bYMOAz3rXVYJqviejPesUvXlr99dCt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755772; c=relaxed/simple;
	bh=ivlwUUQlmRNXZlh7F+6fYULgHiWE/9fkPiEhxumB3rQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tSsB4S4Qhdv6Je82m+1EN2VOGP6zKlcJEfkL24ifFFypwgLjqBfvm0RlYi6XN1CnqhzETzXiULjlNtmvIacKJHi69smwAf76hJFu6HN0WRLfFPA+S/VNaoR1eYYbWtH9eTn8KblBSVRbRnNVJaFyAIhJ5i/YDm+GJa1YK4SY6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UO1djkn5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCexDO019034
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wTJiF4BIPwE/2c1eTUxFT0
	H6zXGwpZWLXUqTjd5z6pg=; b=UO1djkn538dFcbyhVvFC5DZEYy/t3S/yvEa+Ta
	nzEx+tVehw60gbo/6pRY6yt5vuFwHJRpmAxTuwCoqOwcRaMAhSeBZSqQTXs3OLBb
	VvOhtih9uqtaqT98375KmIrLEkr2CihZhsWhB1IIiaiqi1CO+7IR8o6wtoOgFOSy
	aVEunlcQqZYBoPb36fCEYuSSbn6vAYF0ctdq3JTYp/Vi4F0Udqi5h7k0k382pVnl
	DH8JCi+9slkSGnYl5A/WiqPKvA8vVukpIZdE6gPWoTiFsA2YxyG7i4fFNVFqTpUx
	VrFMVlbE6VF0Ba8LfR/Ip2k9QiOqsolzfFqTGXRlePO1OnMw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhtqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f68c697d3so276409b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755770; x=1759360570;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTJiF4BIPwE/2c1eTUxFT0H6zXGwpZWLXUqTjd5z6pg=;
        b=ucDb/2jSGEVzlFPIGxeaBPS2uBhDjpjYxIOh2J0OctTkPmUfYHqBFF4x7bdy4o1WhF
         0GZk2NsJjc1eddj6xExGDqxWORCR1ddHR1rCwlqBOkdlau9/FOs67eksP1ztfchqe7a8
         i5bgujr96An0ZKBjxK4snqti+Cf2c0MPZqDdhcw1qJG0VpN0C1Uk1U/0+ElnKoktUCog
         aJSSA9f1B97KuWRZnRtAhsQmDQlB60WBwC9ynHcdJr7Arl1emmdJWWo0fjOm6dMmo6fL
         wEsvX1dTE5W9/gm4NwdEvQZ5/spvNgn9+I4rVAq/45CiLUeWTx4jW8NrdnyEzo7Jwy6r
         73+w==
X-Forwarded-Encrypted: i=1; AJvYcCW8aVhdgOcgBRxMOdsON6ZmTHIOyBcmKQjyefYjrfIKwQt8Vq5UnXmamUGMs3dCGDQKr6jdXWizW7OYuUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNE8LJlqKSn/8YIxUPku+zexKpnvb3Z/qs+QsB6aFf1Nyq0Jtv
	zRlOvpTJAbdbNvxz5Fcj94L8uxeoLxHYBIEkwDTMRHH/q52Te8Hkv4Rnx8TWahVgHbSjvSaXV+F
	lPSr1pQnQEJZ0Rl3pzIGuM5P8lqJ2qH98IPOd2JCaaSbz7tf7S8Zj5116N5S5+eTeHns=
X-Gm-Gg: ASbGnctZBPbSW3ls6ubofOaQ/IwYY4iSd9V4g3kQPzKNaDwBKl+JhwkiNxDIxm6wnYZ
	N7sxGY6Q0n8btL+PlFMIu+MBaaD0rGVGOqYqiqyAG4PM8K2k6SE8wzPAByijStbBfuYy8pOLXbB
	4QAu4LkdR3oYPBBO1vV0NILtWT81RKWUYcEe+FbgJ1s2Wt0saoZw17Zedt99w5krFqAbTVj3Xln
	LL8L1YKCyuXEaj9Kpup6bnt2N3uCzhE5i2iuc3xAkY6IF1AUTuyoUcwq02oIQOcI1PI+AcNdDN4
	q3Cglo2o5KGSNFIW6R8Y+XIz5GbJmQ4kpoDS8L+f00A7yPfllbSp3RZ6owG457CNWDop25rFT1v
	l7MGf58Ai4537//Y=
X-Received: by 2002:a05:6a00:3917:b0:77f:472b:bc73 with SMTP id d2e1a72fcca58-780fcdc7f7amr1729489b3a.6.1758755770083;
        Wed, 24 Sep 2025 16:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+6K/1ZFPyR/zAwkK0azv8gcDU7cAcbMQSe3Bc31YPHGam1kxpHhJxChPuGrl7oC0rfnontw==
X-Received: by 2002:a05:6a00:3917:b0:77f:472b:bc73 with SMTP id d2e1a72fcca58-780fcdc7f7amr1729460b3a.6.1758755769659;
        Wed, 24 Sep 2025 16:16:09 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c27686sm144845b3a.96.2025.09.24.16.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:16:09 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] pinctrl: qcom: Introduce Pinctrl for Kaanapali
Date: Wed, 24 Sep 2025 16:16:02 -0700
Message-Id: <20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJ71GgC/x3M0QqDMAxA0V+RPC/QCkXcr8geokvXsLVKIjIQ/
 93q44HL3cFYhQ2ezQ7Km5jMpcI/GpgSlQ+jvKuhdW1wve/wWxZcfzmjc32MkUKgwFDzRTnK/14
 Nr+qRjHFUKlO6BplsZYXjOAEsexcWcwAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755768; l=769;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=ivlwUUQlmRNXZlh7F+6fYULgHiWE/9fkPiEhxumB3rQ=;
 b=/G3wgQ4QYN4y/BRvhzhGFePmtWPvBXmc43/t/mFWyQxQdB1XEtMwNHtqxJgw/bMdUHyC7v7bw
 Tk3WuLolbEEC0M+kbTG8Mr59QbBhD6CvoK1JxyYn0aECaGLnwhpleDB
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47bbb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0wRmexETLPsNm1jg2zQA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: PIxJ9x0zIz7mjkWGdhKEQBeD1F3k4YC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXzDDQi8ASS6ur
 t2c5Y1gp/Dj7umm84MmeAPwonp49vbBlvZ9sCK1+Dc72LleqhBEvJgcmdy9D1v4pCKxA4ZmeDSM
 zOEeiIwWCNf3SqdHsfH7a8iS7VkjQ9BglZcHomw2oTo38un71DnX4BuuJYK5zyo9wn0tWyCCFNF
 /OhW1A2C6BxZL+nX0M/koD32i3iTenA5bhHckGEG0qurW7MSQgfKfq2Tgo8p8Sz0s5VciJvgRoP
 zT3ko3sUvCPfvpZZpr08jAk8Ry6qKzYu9bs6XU+mDlnRemWyasjL6Cb9bZD2qOnXyPJGIcNupt9
 yP3HCtN0qvtYJ3JBD1QIWbu0kTcfdVTgF4qLuTj4+pWd7qudCHQ21hPgcW+ZKPEC9sJGZcvHAAT
 +I2D60Pj
X-Proofpoint-ORIG-GUID: PIxJ9x0zIz7mjkWGdhKEQBeD1F3k4YC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Introduce Top Level Mode Multiplexer dt-binding and driver for Qualcomm
Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jingyi Wang (2):
      dt-bindings: pinctrl: describe Kaanapali TLMM
      pinctrl: qcom: add the tlmm driver for Kaanapali platforms

 .../bindings/pinctrl/qcom,kaanapali-tlmm.yaml      |  127 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    8 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-kaanapali.c           | 1803 ++++++++++++++++++++
 4 files changed, 1939 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-tlmm-009fffa55a5e

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


