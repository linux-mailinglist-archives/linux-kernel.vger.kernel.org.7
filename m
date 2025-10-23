Return-Path: <linux-kernel+bounces-866584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C0C0027F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF60188978E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353542FAC07;
	Thu, 23 Oct 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fshnsw6w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996962FABFA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210885; cv=none; b=GEN4vcJ0aWUo40EGpqAZgVF16ok5RU30axphLH84bKlv7VQMz+fsHOtYY/JN+3NgYitulpyQATAIo9IqFo3GIIk8WWWAFc65CHaQYz2YWL20SPVbB4j6juGVfrL+u/nsiHQZC+hGb74TrFNkemLtzgf+uHSYCsgs/pnRuxhKmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210885; c=relaxed/simple;
	bh=YrEPmcIFIFebYwVtbvXxJ19YKPIqsHVmXLp7MO7+XQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nG7BGI45P7P8TZXi2YTriC+uzSHhQoZK8ANGJ0D4CHxXOsV1TC7jBLwS6+UCJ60YVpHOoB21UtYWA8a+NOkeDLKYm9z9J74NplDBY+pU37rjhMIH8McfQ9bG0xv8Z+ULn+j+UpwNXUL0LBNwxo+bmy/XqFi3vGOnkgiga4pIhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fshnsw6w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N70jGG031863
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AcfiiJd1DaNyLF/tkauqo+
	1m4mWE9l4TegeN1PfK0pM=; b=Fshnsw6w0Y8+UdVN2fQr5rRKh3LX1NvaIg2A42
	8GJKGSidDm22KIBnWgDW8SKurDVPVLlAk0Ri6gA/HqarFhuYNyOet0lQxg4+sovA
	IzkRy9DhxP7pzdV45qsRUFdjRvDMCTb6ahjkewWzz7/DN/Zlf30NOmCtIQOHJQ+g
	oTubusV5Y5OxOTCKwBpPNFYJiG7yL7ubFq7YjqBuQw0xf2emE8mcvV9TQiTGYNI9
	80V+GX+Unc+gQEqBSg/UDslRip81Q1dVViZJOcWky+x5/M2YWGh65i2U7mVeJxe+
	/GF40eyBMwPKQc4Oz8qq2zLq8vWOim+tvVgx5J+jY8AT8MjA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge7ruk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781253de15aso1408752b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210881; x=1761815681;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcfiiJd1DaNyLF/tkauqo+1m4mWE9l4TegeN1PfK0pM=;
        b=hbnvogpnL9B+Y13jsTaxLJmdWuylCKhIS0boWYFbIW2SKjMk0zfxGfSk3JZk+iIeXG
         gIrYKKQOWeuB90hPQ5Qg47PbQZAVijYZVCsMon1Ir4Ygun0xPWRSyZbygqsNCoKEECGc
         xXbOSdUbagJ1i+IDQ0RMBzeMChLx2sLjwoNxQNWAYikI6RjsHXXyJQENKI/Nz1wVDVTN
         fdQINzThRN7UxR5O5wie2itoYhYNAXiEoD9y0AQfj35IpQnS6dMNfdFI3L8dhNNWoatl
         rj2gBABSgKQGd1Vwag7NQT7ItsMeVVpLrsBmDuuwx++y6fURhGDfPIouG2q2sK0gowTk
         8ojA==
X-Forwarded-Encrypted: i=1; AJvYcCXwOzi33hUPcXmdTIwgzEKXZWGFVs4aB3vQrBA5KhMZHsYbxIEoT2tPbXjoHgUfD0oEYUGv4qpoXpO1uTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+NFhk1pmLIAirk7awLrFvkegsy44vgVlYVNA6NAuVfem9Poc
	F2gKMmm8/9rzWJM+PLAKiMxivHbi1yJhD1vcvs0N5Kyfdu/aoDz1ymaa8qSgbU/AGydlaFOS3W0
	vEP5wICckX9JkyTke6t8Hy1ecmkgTVXvOaLlmzrbwQAQRBbHkBjjwGPQvqDWoncVxBgY=
X-Gm-Gg: ASbGncvpYDTcrpYZfP7WK1AG2gOIZF/j5HkWFS8nFGjA015BshfErKMXN6pIHA5vbEv
	gcDnjSz85uvcwuEjxBvW2ZJKvwjjIYKzSFwTOqqYgXwOp53pQrzoEmGtY7QE43xoyg65M1YbpNI
	J1YtVStiN5iK8ivFfirUNYHePB1Tlm2i7xMfLU40ggY8cL85RC4I4anTIKFdCukzPkfmRBleq+c
	+K9pWO0XfeWsLS/sHUTlTicw+jndAKPpp6R4J9DhV5/89k/RoNXfWbAvg6kZ/HqgclQzBLmmHaQ
	DI1VMhATE32KJy8vMAcGJ98qaZgOwKBxoGUpAJGFGUoyIJCHtLmo2lPv8X5mVVkcD/TgshI6rkd
	d1kmU2HTvIWxi5kSsJN/aLTpfggjDAVsqdvHk5DhcOeG0PEKGN5eYKg==
X-Received: by 2002:a05:6300:2408:b0:334:a23e:2dff with SMTP id adf61e73a8af0-334a858f4e4mr23615704637.25.1761210880963;
        Thu, 23 Oct 2025 02:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcQtPNYTrKwEw9NmmRgLGjO2gyc2u1ZStKHxbFCfXSfweQmqrjZTAJnEvUIndYhOxHnOgmkQ==
X-Received: by 2002:a05:6300:2408:b0:334:a23e:2dff with SMTP id adf61e73a8af0-334a858f4e4mr23615677637.25.1761210880509;
        Thu, 23 Oct 2025 02:14:40 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e318a2sm1490081a12.33.2025.10.23.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:14:40 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Subject: [PATCH v3 0/6] media: qcom: camss: Add Kaanapali support
Date: Thu, 23 Oct 2025 02:14:32 -0700
Message-Id: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPnx+WgC/42Rz27DIAzGX6XKea6AJE2T095j2oE/pkVNIAWSt
 ar67nPSatthk3YAZMv+ffbHrUgYHaai29yKiLNLLngKypdNoY/SHxCcobgQTNScsT1IYyBN4xh
 iBhsiaDmkBMHDSUovR9k7wFrtjDK1YC0WBBojWndZRd7eKT66lEO8rpozX7IrnrWigpMfFyTMH
 BioRpidQZSsrl5DStvzJHsdhmFLV7GgZvHVzhmv/jPdLIhs66aqlRTG2vYX8v0xdcTzRI7kx+j
 fhnSbp6CAKSEMMuoAOYBBHzIVDJLK1GQtRvDToOjRCjVruNpX5a6jpX/6+wO3zO/xA3Qf9Amch
 9ku/KyPzh+gJ+NA1FZxLJu9rtq/SIJT0wlBJzcer5CyzFOilI4B6JAlYy8zGTRAXbbMaC72EvG
 JU5KWWsxwudt4vJDm+j28IWfun29bxJwzAgAA
X-Change-ID: 20251008-add-support-for-camss-on-kaanapali-e5b6dbd5209e
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfXyqEWmZ7fCDsN
 2+xTbfQrnm4+2wDh8dJc557+PMHCD5RyabD1vkGSh3bUL8VfX3IvNk/nYMFRc3wDna5iIufLFlh
 +MKqzqCKSfjhywqoZUrHEH8i4nlpZq0LwaijcAHH5dFYNh0WsX/+1MUVbz4tmZjzksP99B+mWoB
 kZdEKPpE9v88MYBCwZyolmpsNm9d2/IsfC6QxUb6TF+T1FlKYrYsD7i/HvUQ2gWR+gKbXMC37md
 HlWyS7wKbfOA+tgr2wkUhkEj3Rqygx7X/SkOD/12Gj0Y9fU4jjTCZjh3EX2Qa9GG1hy+x0ZW6z6
 Eu0nDGY+Ks+DviCiJR5wTK9JFKngbl+MbIVUJ7rovkPP37mXFc/dIBJ7lzNYx2JDck3qB6ZBHXI
 j5vuw5aMSpx0EzvLXUeDOGD9YqSdZg==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f9f202 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AVJvM5lMoBLg5W3HYfAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: -Ku-T74USnAe0Qrv81epOG1XKfaI_MQn
X-Proofpoint-ORIG-GUID: -Ku-T74USnAe0Qrv81epOG1XKfaI_MQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Add support for the RDI only CAMSS camera driver on Kaanapali. Enabling
RDI path involves adding the support for a set of CSIPHY, CSID and TFE
modules, with each TFE having multiple RDI ports. This hardware
architecture requires 'qdss_debug_xo' clock for CAMNOC to be functional.

Kaanapali camera sub system provides

- 3 x VFE, 5 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE Lite
- 3 x CSID
- 2 x CSID Lite
- 6 x CSI PHY

This series has been tested using the following commands with a
downstream driver for S5KJN5 sensor.

- media-ctl --reset
- media-ctl -V '"msm_csiphy2":0[fmt:SGBRG10/4096x3072]'
- media-ctl -V '"msm_csid0":0[fmt:SGBRG10/4096x3072]'
- media-ctl -V '"msm_vfe0_rdi0":0[fmt:SGBRG10/4096x3072]'
- media-ctl -l '"msm_csiphy2":1->"msm_csid0":0[1]'
- media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
- yavta  --capture=20 -I -n 5 -f SGBRG10P -s 4096x3072 -F  /dev/video0

Dependencies:
- https://lore.kernel.org/all/20251014-use-marco-to-denote-image-buffer-number-v1-1-f782e4cc622d@oss.qualcomm.com/
- https://lore.kernel.org/all/20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com/
- https://lore.kernel.org/all/20251023-make-csiphy-status-macro-cross-platform-v1-1-5746446dfdc6@oss.qualcomm.com/

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
Changes in v3:
- Use the name 'ahb' for 'cam_top_ahb' clock in cci binding file - Vladimir
- Reduce and simplify CSIPHY supply, port properties in camss bindings - Vladimir
- Resolve the dependency issues in the camss bindings file using ephemeral
  DT nodes - Vladimir/Dmitry
- Update hf mnoc name and bandwidth values for icc module - bod
- Split CSIPHY status macro changes into a separate patch series - bod
- Add clear functions for AUP/RUP update in csid and vfe for consistency - bod
- Clarify why the RUP and AUP register update process is deferred - bod
- Clarify the necessity to keep NRT clocks for vfe - Vijay
- Link to v2: https://lore.kernel.org/r/20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com

Changes in v2:
- Aggregate CSI2_RX_CFG0_PHY_SEL_BASE_IDX definition into 'camss-csid.h' - bod
- Remove 'camss-csid-1080.h' and use 'camss-csid-gen3.h' header instead - bod
- Remove redundant code in 'camss-csid-1080.c' and align the namespaces - bod
- Slipt 'camnoc_rt_axi' clock in vfe matching list into a single patch - bod
- Add whole vfe write engine client mappings in comment - bod
- Remove hardcoded image buffer number but use 'CAMSS_INIT_BUF_COUNT' - bod
- Remove SoC specific logic for vfe ops->reg_update and add a new variable
  to determine whether ops->reg_update is deferred or not - bod
- Add description to explain why 'qdss_debug_xo' should be retained - bod
- Add the procss node in csiphy register list comment - bod
- Rename the variable 'cmn_status_offset' to 'common_status_offset' and
  align this with macro in csiphy register structure to avoid ambiguity - bod
- Aggregate Kaanapali items into the definition that introduced by
  'qcom,qcm2290-cci' in cci binding file - Loic
- Format 'kaanpali-camss.yaml' binding file
- Link to v1: https://lore.kernel.org/r/20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com

---
Hangxiang Ma (6):
      dt-bindings: i2c: qcom-cci: Document Kaanapali compatible
      dt-bindings: media: camss: Add qcom,kaanapali-camss binding
      media: qcom: camss: Add Kaanapali compatible camss driver
      media: qcom: camss: csiphy: Add support for v2.4.0 two-phase CSIPHY
      media: qcom: camss: csid: Add support for CSID 1080
      media: qcom: camss: vfe: Add support for VFE 1080

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/media/qcom,kaanapali-camss.yaml       | 369 ++++++++++++++++++++
 drivers/media/platform/qcom/camss/Makefile         |   2 +
 .../media/platform/qcom/camss/camss-csid-1080.c    | 382 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-csid-680.c |   1 -
 .../media/platform/qcom/camss/camss-csid-gen3.c    |   1 -
 drivers/media/platform/qcom/camss/camss-csid.h     |  11 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 124 +++++++
 drivers/media/platform/qcom/camss/camss-vfe-1080.c | 197 +++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c      |  10 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |   2 +
 drivers/media/platform/qcom/camss/camss.c          | 352 +++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 13 files changed, 1449 insertions(+), 5 deletions(-)
---
base-commit: b09b832c719df5e10f2560771fd38146f2b3fd7c
change-id: 20251008-add-support-for-camss-on-kaanapali-e5b6dbd5209e
prerequisite-change-id: 20251012-use-marco-to-denote-image-buffer-number-cbec071b8436:v1
prerequisite-patch-id: 3ac5d6703a9530eda884720c146b9444f90cf56b
prerequisite-change-id: 20251012-add-new-clock-in-vfe-matching-list-25fb1e378c49:v1
prerequisite-patch-id: aacb03b359fdf95977805f42918c0b6c39889e32
prerequisite-change-id: 20251021-make-csiphy-status-macro-cross-platform-5390dc128aee:v1
prerequisite-patch-id: 27c2ef96f0e747ec6b4bcf316d8802356e4cc3f4

Best regards,
-- 
Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>


