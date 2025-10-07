Return-Path: <linux-kernel+bounces-843770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A48BC0351
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738C61894F72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7D21CC71;
	Tue,  7 Oct 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zprfjm3E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF062192EA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759815903; cv=none; b=NHscp7/ko+mP/UvmwEssBa3+Kf5M1MtfKcid+Lu1yUsKjzNa8yefw1879VL9h87cmUimN3/nKjuXnj3PVuIn517zsQhUCCIr6CjfuW/AELvToSgtk6LoSoi6CUkFOkHNwNjcHK/n7dKSu+CE56AtLD08nTH2PWsrGLRWOnMO1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759815903; c=relaxed/simple;
	bh=lpVzjcBwOXM4SN23tt4fC4BA7Luy5Tc4dyql00/KvbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VhtADdjr2RzP3T2rX0CNYMpWz+uX3eUlBvIQ3DGaGApF9VEt5C80gbFA08wFujZzuQhBGBA7jaVIgXW0S5HUqR/+nAkweRj1ydoeqoqGAmq2G/MXomLYpLW0NPwpWF0X8wXEbQ5HMZgUg1qT4EB+qZ5DJsddpYzkR5KRisz+C18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zprfjm3E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5972hM46023118
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 05:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KIJxcpMYEnmG9XD1E/vZXymkquIdcw8T6Th
	rEVdfbdM=; b=Zprfjm3El4N+LzprHmpDA31d9ZXA+SJfAUUFr4zpz/RHl93B4Xt
	pko78uyV6E/E6izruKojrzlvmQEqPXSTIa42gFE2Nqm3pJJeX0g6PksGcHE+s+c6
	lIu6ncdY8kkuCqsqVg5fIAWbbaAGXMQIV5ICiu3dBDyPvVCn5XwDHsEwV1tu6YAu
	7U87cZDudEjLg99hmfp38O2fKrl64s45ZUQK6DgOquY7+vI9JMpNVfkRU4qN9YhC
	Zk4PqYgflilJzq0rgPoTzxGsrmO6JdMf3kAWNQFUTg3RxU/Pp80N5ggzRuXoX3oh
	EnzLnNtc8ZBTSb7fnMbBWIOuNmN/qmr317A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgp6qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:45:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ed9e38bccso1535240a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759815899; x=1760420699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIJxcpMYEnmG9XD1E/vZXymkquIdcw8T6ThrEVdfbdM=;
        b=NOOqSHvFYWw1r1W9ZWGihVhpETlL3fqeIhUB+yQ44AICe6ABx4r1noHo2X1840cbD5
         s3MKtRZS1RftkoWwIjEGZ6mr0/5kZYESyvQyZSP7y5akpKtwEYbITXz7hTiEkHTBUhpc
         el7/h0IH/sApyLRvWvS6Bh5kK1Ppe/6o0igUNGWl6zDDuIC+Rbutf5mhTwG7H/DFDK1p
         XSGujB05z9LNG0dIy7Ogl83MtkhOsGXLM9p59mDoVRhxnpZtpm1fE524onh7L7UKr5Cc
         aHXa5UZdtfh76or5JzFEdqmBkjcR1yXUYzHbc01tbammmb8shETJNhNlTV+5ULg6QXsU
         GWCw==
X-Forwarded-Encrypted: i=1; AJvYcCXDZFQdaXAoxfQdy6bsk9pE3UsKYvYzrMNLLVYxYsf4K1ddxEVG3rOzCzuH6YzcOGpglv5FvZcwIzKks0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsh3Y6VT1C2fjT83dey/XWT+7TgWS4q4L3TQ5qpGGllazgsgi
	FIbEygbNiCjwxu5kr2hgEUOqDrV7K4+G+OTWaz3GlzWjuYkO5OJDPE+WQLLO90kJbs5EhJRteot
	+x0czsO9z5knKjliXRrLoxJtINk2wn00PsnArIPZ3VMMx6l1EISLiL8iNzWJGGdYiIQ==
X-Gm-Gg: ASbGncu3G7tuUlgyNBGPdr3cbcswbWD80gJNMZOdT7TRR4GsY79XwlcKEKC7alq9hJP
	xJaidfAj7AnN3JHFgYYv+OVDJxWJQrGvlsN6nNjPAdlR4XsQ4SgZ9G5043jEoZCgLz1cEiod1y+
	EJ3FhvVtomPAElJTcPK/LWtNve9d+gTQHGg5FftjFTcF+hHdHHM5uSA4bSSZYszs2byOl8v69mo
	vhDpKnlEnWPX1DouIINXHhgzNRRi9uEK7LxIOg2750Sdy4OUEUutfe85WPep8ZmRLiPhDkIlpq8
	+0gVJUXAAf/ElDGIAu7LTwiGyRsOSuDsVlbr8SjdhFk654Xi7XERkjgJ/lttfrTNQb5oAKCAhY+
	i
X-Received: by 2002:a17:90b:3b86:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-339c27a2520mr9699648a91.3.1759815898946;
        Mon, 06 Oct 2025 22:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErGc+yIrFJKtSY7vYdT2RQdgafbYIfgt1qp3puRvmqRiLtMmkJVl+tUt+GE7S4w+S4kSKxag==
X-Received: by 2002:a17:90b:3b86:b0:330:7fd8:9b05 with SMTP id 98e67ed59e1d1-339c27a2520mr9699627a91.3.1759815898418;
        Mon, 06 Oct 2025 22:44:58 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee976b81sm502624a91.6.2025.10.06.22.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:44:57 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V1 0/3] Add SD Card support for sm8750 SoC and boards
Date: Tue,  7 Oct 2025 11:14:42 +0530
Message-Id: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX/+rK3oz67TS8
 p733A53vHbRdccTWzzlSgy3o6LfEKOAzmxJ5cf8CKKXHkBU5n7uYzaTH0vO0LhpvQuFGw/sB94F
 vMQMrbXERf61GVEqNh7ugJgk+ZYbEbuBaSZmybvdpsYqqlPw9a43NbBvAGR3wmhlbDz/P07SRT6
 S6D+O4nKimHQRpDhcN9/S47ZW2FgTOcrvg0a2+TkWTMpOzw8q96ULOIpHtlMiuStDRBDw1PlXfQ
 cLQz/RuL8H4RWmVhwp9e9lynTnsBLvteZiSkULJyIUPqMuzf5cxe5YeR5Wpz+yRvKwHB6Is8c6R
 vyvRLZRXX/O3prE+ZHZ0xeGPOSwcOoF5Tvmz4ku52FOC4zIqCAxWBVO36kYpPjPQ2V/5SX+kt/I
 EQCgddPprTo+8O/s6JYSzzjlPYEqIQ==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e4a8dc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=F0tEe3Y5rRK-XVa5dUkA:9 a=zgiPjhLxNE0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 1zT-65FPiQ3J8gVmBeJMg770lc7OGa6S
X-Proofpoint-ORIG-GUID: 1zT-65FPiQ3J8gVmBeJMg770lc7OGa6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

Add SD Card support for sm8750 SoC, including MTP and QRD boards.

Sarthak Garg (3):
  dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 soc
  arm64: dts: qcom: sm8750: Add SDC2 nodes for sm8750 mtp and qrd board

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts       | 15 +++++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts       | 16 +++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi          | 63 +++++++++++++++++++
 4 files changed, 95 insertions(+)

-- 
2.34.1


