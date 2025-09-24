Return-Path: <linux-kernel+bounces-831408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA6CB9C94E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765334A6708
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864529BD85;
	Wed, 24 Sep 2025 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awWAqg4n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BB7262D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756704; cv=none; b=QNAuHAIKg3SV3HdtdIQF4iU7kNKup6SXeQ+kefcjhnXuRC7mr8DDbJwWEEclSh9jd9cTUzy+7PXKdfccOOpxnFcP4zfSbtxfxbbLhWM8RZJ7dgWNnqnTjwTF1VBq0VC99NHYXKSC5K0PjY3gKU3E+jrRZQ8K5F4kV4SJ+akvZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756704; c=relaxed/simple;
	bh=otknaPiEgPCDQetk4SzSeTofpJhMuWSTYnVr2MNp7n8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oEwdEbtdVjAgEP7DTrR8aS0ISS7VG8qVxpxlBx3gTgaP3aFI3d8JCkiuokdKO3DswUJ3GpvBJ+hvKFUK2eN/4TgXgfZEhOc+FW8LSoV01ad66bX1dpdd81s3MHo7wa4utt7zRG6sY0LeD7Jzxsy1BiSBEcxfl4d8wdj0RqyQT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awWAqg4n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCl57s016458
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=23y7ZKBGeMd6lj+VSF6lS2
	f4pAAL+cqtAVWcFUxP8LU=; b=awWAqg4nn3TFDPtv62excKiONOW3qk4bX0NZ+A
	OY7JnZt8UtairjsGOBRncZ8RFDx3f06VYlKmItWFnp0/iOyqLq8VrgkvU6sBapt6
	j29KfRyyW/cp7xueg+sH05eQS1Mirrq/l8eE34Q4tYCOt+x9P6Pp6M2WZRiQi1WM
	qMwOjVLKjG+nUrebR01/YkmdWW+DJZ/L0R6rPbOYhljk/hNt6VkjsN3iJELavPIe
	UjT4WsMmyluNgHAs+PdE08a8rW11uUZfSA4Y+SQmsluCzjWnLaFQXfBph5+fzHUb
	0E0FKKtAI0bm6kKZELvYH7jqZiHpfH63rGy3vgtfSmD0fq8A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhuv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so281301a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756701; x=1759361501;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23y7ZKBGeMd6lj+VSF6lS2f4pAAL+cqtAVWcFUxP8LU=;
        b=II27Cy5HIKYCHVpgRH0YoUdeP5vuyOTZwd23AuURRAdZ5sn0hjy1Z3lyKUHBsv4O6d
         oQFAvY/u8bAY/S7mj6hYsP/iONlypHSNl/tBdIn2FYNpS3j3W1asrD0WPGgWSXVntMKJ
         +Sr5vJ0/ltCDGebSH0UPDXKx+vl5HN6zDJuBgFjf/9iDfHM7ziP4wv/NxqT1LQT25qg1
         stAqjrnDCiyt/hZqjbOesciU5aw7RgdyyWinxRd0wjub4ohuvlG/Fp6ATe+QNU91Q8aL
         v7HNMeqwUbtTxVtHJM84T+5+GQ37rpDrBOv2GmAkZgSw8C9DHdD6j0KGY/69WHWF8Sa8
         Jj8A==
X-Forwarded-Encrypted: i=1; AJvYcCV2z5dbZUKvXgWmBE4JEkDy0+WreIFJdJs8fDZRnDmBBKrgVEseuvB9JEqw8Opbh+uD8PtRC6xsOstTVbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwheY2DEBvmrHiLnxcQiptANG86YgEOjF12L6t/GM2OIObFYuOL
	uFuVtP6JekQDOF08Ag4FeY/VteP5Tg/Qe3KeRVZcFHguAqoayqc0DbljojzrMwD6NNYs2axIkWX
	u/4fLvylA00GXCyO47gaxi9EvoY1I4GIB04ZPkR4BH/XWUBTDv20rFC07G0gtlVqCM/hJOneHfD
	QWNw==
X-Gm-Gg: ASbGncu6clXAjQsKoQURXQrvLN6fMBt/vwW+DvyhuKcmnKpy1+6BEs54wCXzFdZc7sQ
	UJ26yd7QfTqF1Qb74YjIfvtsmfNiFCqNae8FboQ4efyWmtZ1vK7BOkqiObAcFeD5UodZR8AkKOF
	kwD3ONj5m+OBm07LKehF/bh9FJfYF+BczmJK7PLND9qgVJgi4D2jskyjXwjOCjGu8eUnkYJ4yR+
	EgTMZdx3QnyRWYHmC4PZuEq41VXUEI5b0QMkput7ASEVvMXbuAoXpQWrVQSMBJoOBIPChQFlAxW
	0j1BUk3gVHf+YVvJ606uCLwTGVCxW8HMprfbZiom2wNjQs0KZui7RfRa/XbQFhEQUp7YhazHPp0
	Kkf+YkS9iiIvPE54=
X-Received: by 2002:a17:90b:4983:b0:334:3286:8fe2 with SMTP id 98e67ed59e1d1-33432869004mr1085523a91.10.1758756701007;
        Wed, 24 Sep 2025 16:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtORkDSyEBh0p7+g4y62c1D6EhvzJ6cOeEDKqrvpOJ6GR6ILAAtp6OjtcvEuAknWFxquO62w==
X-Received: by 2002:a17:90b:4983:b0:334:3286:8fe2 with SMTP id 98e67ed59e1d1-33432869004mr1085489a91.10.1758756700469;
        Wed, 24 Sep 2025 16:31:40 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33474f14e4bsm194322a91.28.2025.09.24.16.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:31:40 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/3] dt-bindings: soc: qcom: Add Kaanapali soc related
 bindings
Date: Wed, 24 Sep 2025 16:31:35 -0700
Message-Id: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFd/1GgC/x3MQQqDQAxA0atI1g1MZ6pgr1K6yIxRgzRKUkpBv
 HunLt/i/x2cTdjh3uxg/BGXVSuulwbKTDoxylANMcQ29DHiohv6WjCLDqITUkht6FJJ3Y2hVpv
 xKN/z+HhWZ3LGbKRl/n9e5G82OI4ftvizFnoAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756699; l=804;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=otknaPiEgPCDQetk4SzSeTofpJhMuWSTYnVr2MNp7n8=;
 b=NiUXXvA0pi0wEDXjXfqcoiXeUo2PEdIFJzoqMWL66deRAKqxlnbzyQOmjnnsHHAxUW6Ol7jvO
 mR5BHUlF5KED6Wb7t2HjP5lVRx0FNIDmqVeVpykvCVnRJ23+MB2XK5F
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47f5e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MEM9KrPBMfUx3s_cz2kA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: FCedXw6AQdW7kfY8OuRvZ8F5T53QBKgT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXykTH98SzyIMm
 Ov4sF0KYt/4MGcn2G1N5MBi7vQkR+jN9HEaN1zdeKc691uZL+ppeeWgzJQpxeHmmehvVbYS43Lj
 C/gXGo7YTvN5sRYDhGiIB/E2Rwz4DfgTuX4u+ngjOjWcsOYDYDxEGWqXlTDeL+CZlEy/+kFLqVM
 QUO4LYho8Pku4z7JsDRAJA4LvZwhu3kb4l9THZi0/6bBmG8AvLSuqVZO0rMNqYXalGG+rthf1qe
 64kzAFQM88AalW7A1gaJqXTNyfaaJEKcmaMla8jAOMhdBRlC+JJff0h6PMfBFhLDG6mZyr7U986
 Q5g+izXCTrr5ml/+O6ZvUSRQ7qYjPG4c5jJ+0UxCpAm7wlbVV35d61rYjjhIICYRr3uYbL/NTEY
 HCh7A9D+
X-Proofpoint-ORIG-GUID: FCedXw6AQdW7kfY8OuRvZ8F5T53QBKgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Add soc related bindings for Kaanapali Platform including asoo_qmp,
imem and scm.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jingyi Wang (3):
      dt-bindings: soc: qcom: add qcom,kaanapali-imem compatible
      dt-bindings: soc: qcom,aoss-qmp: Document the Kaanapali AOSS channel
      dt-bindings: firmware: qcom,scm: document SCM on Kaanapali SOC

 Documentation/devicetree/bindings/firmware/qcom,scm.yaml      | 2 ++
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 Documentation/devicetree/bindings/sram/qcom,imem.yaml         | 1 +
 3 files changed, 4 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250922-knp-soc-binding-a035063c364e

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


