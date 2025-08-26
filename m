Return-Path: <linux-kernel+bounces-787149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B098FB37202
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD93361527
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D531A57A;
	Tue, 26 Aug 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MP3y2rpz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922F2E425F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232120; cv=none; b=Z2/vfgWgGXpdVmndGQ81o8Mx12DXQ1uTHjggDJdNTnvQ0nz/IZ7I/pVE2iMHb8nIUnwKMbmu4LU0XGoIHfPv4bWzS8LjaCWFolV6mCl0HhnngQtTp0WGIGk4CIPVGjEe6proj9TJ+JZEz62EQcqGzg3ax4PB0QwxUtZIT/z6Hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232120; c=relaxed/simple;
	bh=CGQhTSMseq2qj3ydE5N9CekJ8RSug+pOqb24i6ooj/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PPtXRcIJVLwbbdXcS6bCaVO9n8TGLF0taBHPO6bjFdPKQgRSrEC/6KslDO6E32t1vMGZ10YLjt+aZBftSK1RQ3PFuoxfCjYfzL4vJ/04frLN2nEuYWgEi7AKFGbPVOJS52huAWEe2mkVncj3+FFLWZc4ITPrMcunQdpOd+gygg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MP3y2rpz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QBPG9F007563
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4qKaRv93h1EZgasc06wcC5
	9SjsAa9rH7JTGFWDeitdc=; b=MP3y2rpzz4nQnlzYzLYDXwYhPV9AqXjaNpLR5J
	Ll4N29CfrTG67vIW52sDPbGip06N9MDKidsIey8Pp70+3zebokDiWsc+lkflNatk
	RISlnHMxv0kqgBeeU8+0+njysLEQPZ/QRBcrd1jgmtLEjBByvSbDk22uM2sUi2X8
	z52t/xU/aFwfPuMhn4zKYxHHfZNiLg0N+2nkGVtPGc8EUv5S1LekdwwTlhnD7c6b
	NeNgvQD4SrefmB0Hd7xOD+YcaX1/1SS7S4sryqIwSg7PsxuTGzzYr0lvRO1p50z2
	qQB1U7jLSWtjZydbdRkMFsHBaIfXwgnRuHh9OOGyGkvcZZvg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x8a0tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:15:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c229e2a4fso263588a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232112; x=1756836912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qKaRv93h1EZgasc06wcC59SjsAa9rH7JTGFWDeitdc=;
        b=UMPkY7xS+6BViuj5ETcspfOtl4GSHfx94nswDKPj8zk/zecejD8RzB8VEuZo+pS7JD
         8YAXlBR+MIwvA+NlPrr3fuxR8pY+wolBbqCOzibNaGjHfLByR0lawHqc90eBbtYjZVFq
         +wxQ++xDepX5b2pubYQPmljLeZSZ+9ZNsBAJa8pXEWB7A2xOKjTZVTNm/crFHgbPghPj
         dwmsPn07wSd73K5LOb+RCkypIQCAj3zX6b2IbvRXLT41nZISkxvKihlHZaz3xl33wp6n
         ADmKUt3SU5/UIuPhzYfM1BvW0WGClYR7wXhbmsBxJ8Nx6hzyBXWIvLQF9D3RGEm1uhkj
         eUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG+cpvmNtOAKfxdqRAUjKMG66Ml+Xc0fLKcxS4znDC1/GPBjVoJy0Kzt/cdLODrbwrMKJH2ZzsbKkHZWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC0hA5E6Buxp3ovaoIRdQ80Tv4+WipD/d45uJDCyrEkHb7cwOP
	OSi68kodTgKDwS0MmfH+HTG0SigiHkO9/dEVonQzh1ZZaeVvypqVJbiZv6/ATXK4phaxigFToOP
	f7glu3UQ32mQdDdpFn3lAqP6KKGrxIJl/XpQeSCtubdAudr0gMu8UpLI7X10rcOaSCdY=
X-Gm-Gg: ASbGnct5Zcl0PpsOH3FMnXpGu0t7Bq4HyLPs9R7uxYv9/BR71HaUEjrx4Bn9X/NjUaS
	OR9ZZQ/XBHaIYTeGRHiHremN48gVKggZGCmaPKqJZMDrzflfFrurJB6G8+5nLrW+yhIa0H4aS2B
	yju5SlIvCLliKTdQwgUg7pHNiwIqstGns853+GanyTEFQKrOLJ6Gp3sOvzdrBMCqkpDYlBss9mu
	69XtNQ5849decW2JHcK/CI/S8MDevv5QjhMOS4zrhsCvWpFCrJPgT7i+795Wl4yTYjZ4EVk9WRG
	5WihQ6YxrsczTINT9AafWnAPLaiMfCfGon4IdWg4UlAe2BT6J9f+R4A2wgy4/78re5PrUnM=
X-Received: by 2002:a05:6a20:3d89:b0:1ee:cb87:79f0 with SMTP id adf61e73a8af0-24340d095e7mr12851690637.4.1756232111998;
        Tue, 26 Aug 2025 11:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAOUipjrhtI5wo5iCy//W00zdRD0rUuIpHC7OEY+INkwu7tSLAVDPeyoPyPkBf94Oh1aR4bQ==
X-Received: by 2002:a05:6a20:3d89:b0:1ee:cb87:79f0 with SMTP id adf61e73a8af0-24340d095e7mr12851660637.4.1756232111359;
        Tue, 26 Aug 2025 11:15:11 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb47b9sm11065536b3a.3.2025.08.26.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:15:10 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Introduce support for Monaco Evaluation Kit
Date: Tue, 26 Aug 2025 23:45:04 +0530
Message-Id: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r7HA6keMZIiTVT72eMC1E_R9MHRxqP_v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfXw1jg8zV2OhHN
 RcvjClGyUbMCNDPiDk41OvdWxJwkr8JFe9wEZCsjT5GqRgKVTl2tq/qe+W64ay/noNcGN+6D8LT
 taZGBT90HU5dWV2ioIMDKfVihk5DjzQl8kfY488YFHS4vSIBsMrkc7q75nmdIjsKS2465QDVDDS
 FCkvIVw+c9LQmN4aVF/3owZoEkFn3eHv9QGf+ipM8AjuNmBdNwoSMk8nsZo2BxH4sFdX3xZkLR2
 OhKL/L6AdrG02J9TE012VJM/zuSmtvI7h83pG4pS4QfQSj8s5kww5SxmIUphZ/hs2Yzhqy6NnCz
 SKeW2idDdfsHUv/J45JCj7MF4MeAqEL+1OGxzIeoUzF1IQToI0Y6jssD175Z2MW78LmJ62+bPLF
 Z0Y5pTI0
X-Proofpoint-GUID: r7HA6keMZIiTVT72eMC1E_R9MHRxqP_v
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68adf9b4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OP7YlZzrarwTRlDwEmgA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

Add support for Qualcomm's Monaco Evaluation Kit (EVK) without
safety monitoring feature of Safety Island(SAIL) subsystem.
This board is based on Qualcomm's QCS8300 SoC.

Monaco EVK board is a single board computer (SBC) that supports various
industrial applications, including factory automation, industrial
robots, drones, edge AI boxes, machine vision, autonomous mobile
robots (AMRs), and industrial gateways.

Dependency:
  - Revert commit b5323835f050 ("OPP: Reorganize _opp_table_find_key()") to
    avoid regression introduced in linux-next (20250825).
  - The ethernet PHY QCA8081 depends on CONFIG_QCA808X_PHY, without
    which ethernet will not work.
---
Changelog:

v3:
  - Include changelog in proper format and make it more verbose [Krzysztof].
  - Fix subject line of dt-bindings change [Krzysztof].
  - Move the H/W peripheral information added in cover letter to commit text
    of Board DT change [Krzysztof].
  - Include 'qcs8300-pmics.dtsi' in the Board DT [Dmitry].
  - Enable below peripherals as suggested by Dmitry and Konrad to include more
    peripherals in this series itself :
      - GPI (Generic Peripheral Interface) DMA controllers and QUPv3 controllers
        for peripheral communication.
      - I2C based devices like GPIO I/O expander and EEPROM.
      - USB1 controller in device mode.
      - Re-enable Remoteproc subsystems ADSP, CDSP & GPDSP as fix [3] is
        merged.
      - Qca8081 2.5G Ethernet PHY.
      - Iris video decoder.
  - Update the Board DT change commit text to reflect the above
    newly added peripherals changes.
  - v2-link: [2]

v2:
  - Address Bjorn's comment to rename the board filename and
    compatible to monaco-evk.
  - Include the bindings for monaco-evk with the existing qcs8300-soc
    itself instead of adding a new SoC binding.
  - Drop remoteproc support as qcom remoteproc driver is currently
    broken in upstream [3]
  - v1-link: [1]

[1] https://lore.kernel.org/all/20250623130420.3981916-1-umang.chheda@oss.qualcomm.com/
[2] https://lore.kernel.org/all/b376d130-2816-42b1-a8c1-1962ee0c2cd7@oss.qualcomm.com/
[3] https://lore.kernel.org/all/20250804-mdtloader-changes-v1-3-5e74629a2241@oss.qualcomm.com/

---
Umang Chheda (2):
  dt-bindings: arm: qcom: Add Monaco EVK support
  arm64: dts: qcom: Add Monaco EVK initial board support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/monaco-evk.dts       | 490 ++++++++++++++++++
 2 files changed, 491 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-evk.dts

--
2.34.1


