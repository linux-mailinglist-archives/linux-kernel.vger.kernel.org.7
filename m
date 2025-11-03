Return-Path: <linux-kernel+bounces-882384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A7C2A515
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 415C64ED72D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E129BDB6;
	Mon,  3 Nov 2025 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="csGGL16V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aCCHHFHH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38D29ACD8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154744; cv=none; b=CfWuA1cps4hWIQQAODhdUtPfi/gry8D6WV2Ltdk3AW6wJ94EO2w1zBYOkrc2F9/opLg5cBOG/PJ+sfrwYM2DTCbeHAJfQUoAC4uxZc/qC/mH48O02b6sZi4lCj7XX+8VZJprlGfO2cSt6vXSiEu+K88r+XVD/s9kuEM6utiMIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154744; c=relaxed/simple;
	bh=DZHDaet5H0XPWYXMQUHXA/gE6KYkGCbnRYLfNcGq9Bk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=agfg3d8sOuVkI7d5XAPsjDxJxSu9YxQsEP7m7mtTkKrMdgEKIsZAZHYWiiTnlbFrSLmOt9VTXW2A5UbgFowmqxEnVtgx+S6GvJoLip5y+m0glMVshev5kDkPkslMxL1C1F6nOywap085RXIRLap+tWjPjWdMtdM2k+UDLdyp4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=csGGL16V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aCCHHFHH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A33DcAn1941372
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 07:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6mARpm0uTWDa1LpiHjtXdo
	8OkpNCqBx9yA2DYaEgi/Y=; b=csGGL16VKc41O2xkoj9r0PDkzrBD1bBuvcCi6o
	P6KvBqD+h8CfkFh1DdPbXwrsNBzAm1QQixmh2RXPcQ9QzPBzSDEfPU11NrnB3VNp
	WvZOXCG2GeCZwMAnSnexagS8K5P9fYG5XxwCMKjWkdoscdPhTbIezFABmVoOeENF
	Xe4YA8KhymAfYMwSHK9sproIawXF+l9D2sEv9LQe6gyBbAhIjqG5C59ZurXjk9kP
	PoWwJCWB5joZTGI5sANyU3ZU2QyKKrRWp1jATdIdC4c/o2tEF/FoOhom/TJ7b1zX
	Rirw+f4aFM77kLqtIrGX9t6ZcStN6Wjp9+6oURtGfHHMQ9SQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6m9w8hn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:25:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33dadf7c5c0so4933469a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762154740; x=1762759540; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mARpm0uTWDa1LpiHjtXdo8OkpNCqBx9yA2DYaEgi/Y=;
        b=aCCHHFHH4zLJbmxSWZ2jbgkTcB9aDc1vJU3QcdxLpVJ+TP47FtlcmZqjligdCALPGD
         Dnn7csnxEL7qn8a/9zCccZQCLDUa1Eu9bNmjCuVpAMF9FxutUUgeogM10sW8Hn9CnaK1
         TvH55OLutLVmebGHPbLJbKzFNeCaJ1p2tZOyM6dFJyJmZN1bDihrWe0TN/caZms7z2In
         cAf+dT/FeAKx5x+B+8D8KqX5EElMz0QO8vW76+Cm8zLnHuVlgaGdf8QbJKjG5cbBJ/+e
         ZrYvGQnz90H/HuzwQGCdPKF/YASFyVR4xCvSd6pzkolgSqf/eIbsPrilyqAK7kb23ugO
         R1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154740; x=1762759540;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mARpm0uTWDa1LpiHjtXdo8OkpNCqBx9yA2DYaEgi/Y=;
        b=RpN89VdH9dEOnxBvq4+qQpmmV24T1W1iSobuFQOZQgW3LUDk4wMTYBUNWqcTahQfbk
         e/I4awmMwPP/ujSyQ7WDCBMShoxFZ3JJ6uxVoATZpv/Eo9tjAOH8jwmB0hm9vAUVaje9
         X8/Uas+39LcZ5dZpkQgyi1yAVeo+6U+aa3mTm6f7TL4cmbOiD210zbOZyMlu92TfXbfH
         1W1i5jihYgoz06ImT5ot9zVDpaONC6bn+kftgCZZBSFMfufKVppu+0qBLpsNg9y0WWve
         sTHe0z0S3EAj8fsG4HZfSU/JV8zwtn3riA5U4FJrqhG7VcDrZ1PD/F8WExxYAauTQTC3
         XBqg==
X-Forwarded-Encrypted: i=1; AJvYcCUBBPo6d9+i5iOn3M1zlf/nnAIEWDiFLe5nc8QFOoBC1Qcz4XjldOHFmsBevku0T8PjpI/6rHIj07B6OPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKbFzf0ZvnuUMxqf5g+sYrljRJ44Nuik9VpstkmYKC/tRtdAM
	Mb23d2YTBaf3Oug3H04CdAJ+S0BQvn4ye/dyYpGEE/s96g4Ecg757aHJOJgWv7UHR+pES51NGDd
	ZrGglvoMA11PKq5x0bUXGuru71h26bKFQ+o9H8RfILTlo5E5OvRXopIktDHnPpX/7rSw=
X-Gm-Gg: ASbGncti9D1cbDMll+yzKy2NRyTX0lqKQY6fMi0JIkUa+Lz0whBYkpoRU6EqHYzYtEI
	QqYgVjKoR2/vlnZqeBAbQQnv5RASGmSi7ZvQ4vhyKysAG7T7Sj2mZauXYh7QnW6flCdgYgAxHS+
	1gUl21Ibol+x3lmE/lcAkL9dYOinhHBexB59oVmeii57ranfmr4pYumH26DdDqygkfQB9ZTQkS7
	zWEx10qOILISb+loHXoT3NIB5dKNgTwIhZSRXTEShxsRMTNgKuesEUt572SPgVUslKvS9i4UqwA
	Z4WpdIXouV6g5AO3pX6+RsUNvHvqmNVduEwJTfN1KgCMBn5FqKa6M413J5Y0C6RWEYvdm9F38Mf
	cPqTXuA2/Bz4RYlbAdB6rtbgF/wnJEo9avUG9DL1YGiaFgubkUg==
X-Received: by 2002:a17:90b:4fcb:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-3407f4f4f2dmr15252055a91.4.1762154740323;
        Sun, 02 Nov 2025 23:25:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIogl4z44jezViAAx1MU98InfK5jfa4aPzqrgAbWCjMClQmth9zjC0AqN3FEPEem4xkSQvGQ==
X-Received: by 2002:a17:90b:4fcb:b0:340:68ee:ae5e with SMTP id 98e67ed59e1d1-3407f4f4f2dmr15252022a91.4.1762154739842;
        Sun, 02 Nov 2025 23:25:39 -0800 (PST)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be5ed9e6sm9350951a12.27.2025.11.02.23.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:25:38 -0800 (PST)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH v3 0/2] dt-bindings: soc: qcom: Add soc related bindings
 for Kaanapali
Date: Sun, 02 Nov 2025 23:25:05 -0800
Message-Id: <20251102-knp-soc-binding-v3-0-11255ec4a535@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFYCGkC/2WNzQ6CMBAGX4Xs2SX9SU3w5HsYDqUtsFFa7SrRE
 N7dgkcvm0zy7cwCHDIFhlO1QA4zMaVYQB8qcKONQ0DyhUEJZaQUCq/xjpwcdhQ9xQGNa45eGG+
 FNFC+7jn09N6Nl7ZwZzlgl2104+YpDr3NRuJnyp+9O8tt/EsI9Z+YFQrUzuteN6LXQZ0Tc/142
 ZtL01SXA+26rl8WTFNvzAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762154737; l=1306;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=DZHDaet5H0XPWYXMQUHXA/gE6KYkGCbnRYLfNcGq9Bk=;
 b=0OtIOaj6TzUuFhNonhwpLng11jHH4N9beAet0/Y6eb/6Z5r4Wx2xwNaiGqfkrC+gvXOINzmBA
 tW+CsJgL6EuACCwLA1RpIF2RguVa6H1SfjzWYSUO8Jxl+qOoavTC4+9
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=690858f5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=aUypyU9Tpf83F15FXRYA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: erQ4zHVhWHx7uN1fP6yHsIjBmWFQ6yRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA2NiBTYWx0ZWRfX/2M3jnPX0cM7
 sEWTqc2bLkFvwqli5Gz6is8zbdGYtKWOBpbp+Gs+7X8dQDwdq7WyOinV/c/ZWETHCSYIwan0qha
 G04uK1KU3BW/9KrGM2obPOM/Q2j/x+n+kcmLX1DSsw+6XRPbVETjQKFXku1DYEaiIPovGVIqkjT
 JFLcfCB1co1p3O/hTvqIJwC7iM0vM/ybaFSKa9JsVhhrK943Yp10V0Qv3P950PQxKjxz+pLe7sD
 HbcbNCDESh2yNQURaNrtSOQd8XRuSYiZczWYRk472AEEQElw8SGpD0CRqkQvZsK86SuEarHNKRZ
 Wpdtdkw1ZYWYAwSzMix3aA/luNKuqSQiQfvhuSzrmFCCtKvvEWleCPG2zTmJDkiwNeH1nCs+j4p
 +z89ycI2avpc4OBdIvvmOhHbuLiUHA==
X-Proofpoint-ORIG-GUID: erQ4zHVhWHx7uN1fP6yHsIjBmWFQ6yRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030066

Add soc related bindings for Kaanapali Platform including IMEM and SCM. 

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v3:
- Fix capital letter in commit message - Dmitry 
- drop changes that are applied
- fallback to a no implementation binding qcom,imem - Bjorn
- Link to v2: https://lore.kernel.org/r/20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com

Changes in v2:
- Fix capital letter in subject and simplify commit message - Eugen Hristev
- pick aoss_qmp change from https://lore.kernel.org/linux-arm-msm/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/T/#m4bbee2db112a471cdca7aa63477b7147691e6852 and rebase
- Link to v1: https://lore.kernel.org/r/20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com

---
Jingyi Wang (2):
      dt-bindings: soc: qcom: Add qcom,kaanapali-imem compatible
      dt-bindings: firmware: qcom,scm: Document SCM on Kaanapali SOC

 .../devicetree/bindings/firmware/qcom,scm.yaml     |  2 +
 .../devicetree/bindings/sram/qcom,imem.yaml        | 77 ++++++++++++----------
 2 files changed, 43 insertions(+), 36 deletions(-)
---
base-commit: 9823120909776bbca58a3c55ef1f27d49283c1f3
change-id: 20251102-knp-soc-binding-5c96d05da015

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


