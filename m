Return-Path: <linux-kernel+bounces-878078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8AAC1FB73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A477034E333
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE56354AFE;
	Thu, 30 Oct 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0pHTEXu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FPvRDjsX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4000354ADC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822580; cv=none; b=Y9B09lCj3ztzRfHr9jLdcRl1Gmj07l/sIzQROfeI2+UruUqo6ihHgX1hqi92yoXQxOVN/bnSREZ8UxfGu4EAK5OBskeJdMzbwtyjTwNGkaQC9KRWu+qMTmWfN09Z8mJKjyGuGMldkMNh56V9x+wuYJQyAm00hLFmofAUlMgTbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822580; c=relaxed/simple;
	bh=bTF/HTJGitlCWkiCQBfUce6uEKcUNHO5/aywbfeUeGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kC5k/xAKU0w5xtv9EbREaHGSVIz7wu0uwjaBWMQ2PBw7TlmZTNIimwzTqpSMG69LtC7P8o/7xn9AG8HYOqYmoTlMM9YH/cT4u3JdyEPu6kTyxoxd9TzMfYu13zZLvcs15kAwg2K7PUJZrC4Qb0cDtx7hr3dMXUi87lqDWfpWXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0pHTEXu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FPvRDjsX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7i7p31693744
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZH115Y6hMMe7/X3DCQWnOO
	KT6D/4xCNNKZ88coPhSO8=; b=L0pHTEXu6DbfaUXu8yCX71x1NoVEiv51N9n8gO
	pY/rA31xwHQ3yChNjxEKqQHrQGVeGlnqPIKvPVnEnfX9Y2b+ndrlgyU7+XyrREZD
	7QN0Dv1yFGKSrbS1gvd5bIDNbOqAFdOEireAWNG4WA3iBgPfgv2q8cDqss6v6fY+
	tV7oxqAwQPT28TMhNa4sM+dsDRj9xIQKiQceQ8uu+mGUsSPFIelKK+wyBenL6v3A
	fDBSoDpu4cmJ+wI7/dguM0KGQ3mBMZbdeqy+ovSygNNfEXE/8yZlnZ7ccJRLgI4o
	2/3FQ1eHMumwhfoIt+TIHg9Xjemq/mIcXi8SxI/0ZI9LFzEA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv230u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6d53016548so1728395a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822577; x=1762427377; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH115Y6hMMe7/X3DCQWnOOKT6D/4xCNNKZ88coPhSO8=;
        b=FPvRDjsXs8ASZZ462KcNM7z1Pzr97E+NBnsfz3um0NUG3+bBc7W7NRCzgFei5e25C8
         sC4sT+7cPLiJiDqsuP+Q+jfdRygBsf84SfpBH5mbwSqDEbgeCau7zvC/RD9ykfB54UY0
         P1j76NAWT9bb05kUIrZRO6fyY1j67k7mi20az3eb0gtPsgHYFCtWHr318xBhd099r72y
         9O42m+esTuHNjPbg21Rdg1/jNsIVUXmcAHurTMc471IL0MhHEpxpVZa9rcPCGk4P4twj
         9tDAPOS+1BMliUudAygibiMNRl7aOKwd6RQBnAyZ5EdujDfxDDZfhhqlBJN+ulk2HdYs
         nkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822577; x=1762427377;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH115Y6hMMe7/X3DCQWnOOKT6D/4xCNNKZ88coPhSO8=;
        b=XceOLgq9YoY/dBt+5qTiDioNA4uvaRqBBS39+X3bOxrjYbjde4tzTNE08lJPTjQqeT
         8qD9wq855r5l0ugmiUoEb0cZ7GVaYcI2QYo9QPJbmhBJfem3O2BLm1mIeuvbEKhiL9VM
         HkEAGCilcamRL08Hf4v573b8i77l1eV6CPCWkk6t3OCSW6lS/T/+w+cnHqZ65NOodoEX
         hhd/qPmwh7tun1YYX9ufR3mAkLXNunEKIv2bg8hPQEcny8sOp7nWju52keysACc0B0Ik
         FyvJqAIRD2/+BKGhiS+JCt6c4yJGSNTux62uSWGQ0M9sOPKAsPAkNsp7M3Sd1+A7YRBc
         +y5g==
X-Forwarded-Encrypted: i=1; AJvYcCVTsf0WvKBykuRtVWbaOpTtwla/hQrjzrIjaq1ecDfodLkt7CqM8qFT+TXG5D2MobTNaV8rU17A2VYqJTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWcLzknZKnBdKUZngKPL3WGZYXZuFz8qR3j/M2M3ns2m8+P5W
	VuzalTbAUIMtwJTsrSUOmSa54LLj0uw/hkJ29WOj4vTM6ihLy0w4JDmAUr8aMAu4b4VexF2ioXI
	6zjDMIxeQpmoFp6+mulnX0j6FBOImAVooMRS4c51mTjY2ZDy809YglVvGdwiJe3uH+8g=
X-Gm-Gg: ASbGnctuF1V/VW6iyJPHnJSeGZmK5ISqTEdO4AxPOnBqgiiOTYY0IWof4yJcwuZ5gyP
	peFfipsHvilu7yCiDiEYIQozPqFh1XzUsj5LPtbnNuCyvpg5x7W1pC/E9Sm0pI6ffzPBFGYQhuK
	SQgu8r98+laWFwCs5Z4JPAM7uQSfC66Hvez/O5TS+EbeNaaAqtxT5mLzIxP795zfiUZBApjrdWe
	98kDlKj7ie6OlVUiaiM8f2py4KJehPPKo6iA9rXKo+/0yWdLz0XC9XY5ga3ygd32n15IaA8sy8w
	x8XGs40zPZF8HBUBnQMhe34UjCjTFdBoZJjQwt3ScIIePAn7YSjhvN6pkxGGVIND6RJm04uNvma
	tGAGw0K5fodzfRKKQyBkPSTo=
X-Received: by 2002:a05:6a20:2451:b0:343:70a2:bca9 with SMTP id adf61e73a8af0-34787577cacmr3578915637.53.1761822577074;
        Thu, 30 Oct 2025 04:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHatE8uROAdnCWiw8m3mzuGzWhz3CpHUlu9lY8QggHRB5tUmuEVy8KbUaCVgmVdYIa95m2z6A==
X-Received: by 2002:a05:6a20:2451:b0:343:70a2:bca9 with SMTP id adf61e73a8af0-34787577cacmr3578880637.53.1761822576558;
        Thu, 30 Oct 2025 04:09:36 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509727fesm2262839a91.4.2025.10.30.04.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:09:36 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH v2 0/6] Add support for Clock controllers for Kaanapali
Date: Thu, 30 Oct 2025 16:39:03 +0530
Message-Id: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9HA2kC/x3MQQqAIBBA0avErBN0QKKuEhGDjjUUJgoRhHdPW
 r7F/y8UzsIFpu6FzLcUuWID9h24neLGSnwzoEZrNA5qc249iCIlOkXdqEZtPAfNhixCy1LmIM+
 /nJdaPxM5/s1iAAAA
X-Change-ID: 20251027-gcc_kaanapali-v2-901def0e1a52
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com
Cc: aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: 1mIRjwbxmn7xvmQ5bv_Qf70e_JZ1ObCA
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=69034771 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=pU5keNj5C49EkLXuPzUA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 1mIRjwbxmn7xvmQ5bv_Qf70e_JZ1ObCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfX2LAnjMvZucHa
 8+NSoRXp4LLbh0f0jzfbWIHDlfVVwcEl6K1WxC9hTtIlTq6bKysioBWuYOFSzu1csyE1ClAuCNu
 vmtL191+zK5hdu2Mbdl1EQ1kVPXsBgDZBGnoJWMCfP8n9kjWssm2dq82vcMyUvYIlEeAabPq9mv
 T80xOMynv0X/H+xDZWmiD5lr+zbBhtwecch0Z0xlCWh2fwMJQZr0xmzb3w9qpaygPZsoh7hkqF/
 F9HbteUlpQMpw13BgQJDy5LezkDu1PqrjZoOdVDQc6AyviIckieRAQl7mksadJqFVmFIbtfKeFN
 db9O7kzXKxEXn9HQWbvss4h15YEXggkicaE5yAi6oYRSdkqytLOROvcV/FxN+Z0wa/89XP3Adyl
 +EM57XeB+riL1tGWRIA0nlHGUcr88Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300090

Add support for Global clock controller(GCC), TCSR and the RPMH clock
controller for the Qualcomm Kaanapali SoC.

Kaanapali(Snapdragon SoC from Qualcomm):
https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5

Changes in v2:
  - Update the commit message for all dt-bindings to incorporate
    "SoC/platform" inplace of drivers [Krzysztof]
  - Add RB tag from [Krzysztof] for dt-bindings
  - Split the TCSRCC to a new driver instead of reusing the SM8750
    driver with offset updates [Dmitry]
  - Update the new RPMH clocks to use 'clkN' convention [Dmitry]
  - Add RB tag from [Dmitry] for GCC
  - This series does not have any strict PLL code dependencies [Bjorn], thus
    drop them and will be added in the Multimedia clock controller
    series. Drop the following patches.
	- Update the PLL support for cal_l
	- Add support for controlling Pongo EKO_T PLL
	- Add support for controlling Rivian PLL
  - Link to v1: https://lore.kernel.org/lkml/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Taniya Das (6):
      dt-bindings: clock: qcom-rpmhcc: Add RPMHCC for Kaanapali
      dt-bindings: clock: qcom: Document the Kaanapali TCSR Clock Controller
      dt-bindings: clock: qcom: Add Kaanapali Global clock controller
      clk: qcom: rpmh: Add support for Kaanapali rpmh clocks
      clk: qcom: Add TCSR clock driver for Kaanapali
      clk: qcom: Add support for Global clock controller on Kaanapali

 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 .../devicetree/bindings/clock/qcom,sm8750-gcc.yaml |    8 +-
 drivers/clk/qcom/Kconfig                           |   17 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-rpmh.c                        |   42 +
 drivers/clk/qcom/gcc-kaanapali.c                   | 3541 ++++++++++++++++++++
 drivers/clk/qcom/tcsrcc-kaanapali.c                |  141 +
 include/dt-bindings/clock/qcom,kaanapali-gcc.h     |  241 ++
 9 files changed, 3992 insertions(+), 2 deletions(-)
---
base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
change-id: 20251027-gcc_kaanapali-v2-901def0e1a52

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


