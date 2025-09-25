Return-Path: <linux-kernel+bounces-831523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29394B9CE5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F68B1BC1864
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB602D24B6;
	Thu, 25 Sep 2025 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrD18VF3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0462D1F5E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760357; cv=none; b=l+pKYiEyQnBAVHpwuAZRJT177joVk7385bcxG2Q/yNXs0PGEdmeABFEFcZxf9x27Uv2VfIfXk4rwg6Gd7BBhJ2vf6FvcPcwgEx4eHHBxg+YVVgRSD4e9I7XKq6NX5ZP9NZliQ24WhzbN5TBTTA3Ea4xydwaCNQ2dXTEYNMIW6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760357; c=relaxed/simple;
	bh=tquxESu/nRjr22uamAIgymAqRedGWmQ4uJ4GXogXU1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hMTFmlUiaxjzBVCJiO39TSnDKnVQTAlvohD/zxtRP5/z8eDsdstlfrQBfmQDHS4gfGAKEjtafy1f6SToowXsLrq8rQpew7PybYmpE8tptOiidKHppJHHAIZE7uIhbejFqdp80/MtJGHbCjA4/dbI1BUv1LJDlCFOoKXlDbxuPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PrD18VF3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODGO56017437
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m3yth0Er6BxjFFQbzZX4hu
	kLa5fd1ASG8+CklnfwgYM=; b=PrD18VF36TYdBNkFOOnrPbvo/WwjRgrD6MrYbR
	eUl8uSMnJsxQV14pZ8cwcf8qLYzZyvTnoHkdvEPRDWePJi5yh5WNmxRCscjuERkZ
	OFlNBJ+eHdP0R8fBOvTQ7ccPU1sF7nteAXNcQTAJxWR72gZA6zfbPQosGG68e7n8
	+wYCJzYPIYhilh3cmW0WkOWadowZ6puLNpyekTOU50Js0/O3r9rMory253yMX0e8
	wU2EMdDpSWw51Kz4c4XAS2D9QNjSVGIbY6rnPEH+eFXnIHsRjCB8F9OFU70mCb8g
	BdImhK2JFz4zu4bAe7VJvN3WD5CO1mcfrb9Hv7uEwIb6qCXg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjygwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:32:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d6fc3d74a2so11873401cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758760352; x=1759365152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3yth0Er6BxjFFQbzZX4hukLa5fd1ASG8+CklnfwgYM=;
        b=WPuTzuD1y7bm71vAG/v6o9haoMWnqtwpV2wjpgGaeL/0gWfYo4zb9zBRsS2HemNQU2
         9vGYzFI/SQHyWyhO1AJllFPJpHUDIGCVuh+X24pfBGAZ1pKzDQEcb3qxaSFEaaO4ptif
         5X4/GNtUk8B53NRY0jhu9KvoLEZZ+gsHH7Vm/oeDn39/dYhNlyyAQpk4iutSlug/GJ3A
         sbhAoiuxj8lQWag9VLk18t+hLY4xZLDb2IJQovco/2mylg8Easf7FprHYSElsK7ePE+E
         360jH+sBQCY0zu3mUDeYhjIcT/ys8yLN+y9foSfGxCF+ozsOQSdAx+eDOl7zJsxWFeY5
         E+XA==
X-Gm-Message-State: AOJu0YypM7LM5K3whm7fDoGwIeSp5JJcTEoNn0+xN7Kv334x8N50kfHF
	elFLgXsfuIvDwFtBxCdUursmT3flo2NdV5XCZgXJQ+j+RNEaPaUQTuZ/Hb+vAZ1pSFnifjU5hcV
	rg3MTsRgZLvW6UbSNOBU9fG91w70Y3vfk8enDGPTyXgy2xKyAbPMceN/oJe97eLT/G/s=
X-Gm-Gg: ASbGncvh+jyr9XoDLG+tkvXEZK2u9zwV08qq5QETLr9dNh3DL6QirUUuuK3ROWGxlE2
	Xkr0Its+82hPZc9V2f60fSXFF8SVUhAG2QnwSsSswvcwR2vwuzLAL2EQzRCI7P9nm5v0W02O86t
	RlsXDMI2Ch4zD/mmzrmuYOQ42PNzEm3DBOsQhB3gfYOXlk1Ke/Dz+983VQhDK2aZhKEb2KFssW2
	plRzGxygz/VU+qtnY15ZYf295WYRYUqcjwJlTKh1hc75djgwmy6Wpwlo6xpiOHpAfY2kOYJdpNO
	Uh0uBQCwDDBvhKgbUf6Nk0AKFnW+8Adf75/AJ/8sSlusSOuGASUvzx0+weRQD6nXwkP7iexit4o
	KjI1b3syqSvNA3iM/T1Zv4u+07qIMPnU=
X-Received: by 2002:a05:622a:507:b0:4b5:edd3:ddd6 with SMTP id d75a77b69052e-4da4dfa46f7mr21336701cf.82.1758760351826;
        Wed, 24 Sep 2025 17:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrcAkBbMUgBHYnvQL0jbnfNZVBsyYnhHLutUzQBJc2Cnxho52Aab7C2HMLQn64KEa3voKmdQ==
X-Received: by 2002:a05:622a:507:b0:4b5:edd3:ddd6 with SMTP id d75a77b69052e-4da4dfa46f7mr21336491cf.82.1758760351398;
        Wed, 24 Sep 2025 17:32:31 -0700 (PDT)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10872687sm1774501cf.28.2025.09.24.17.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:32:30 -0700 (PDT)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Subject: [PATCH v4 0/3] media: qcom: camss: Add sa8775p/qcs8300 camss TPG
 support
Date: Thu, 25 Sep 2025 08:31:58 +0800
Message-Id: <20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6N1GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMT3eTE3OLi+JKCdF2D5MQks+RUM2Nzo0QloPqCotS0zAqwWdGxtbU
 A9m34+FsAAAA=
X-Change-ID: 20250924-camss_tpg-0cab6ce6372a
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758760347; l=2713;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=tquxESu/nRjr22uamAIgymAqRedGWmQ4uJ4GXogXU1M=;
 b=dTJ9DHs82T6UGBGS2Y1ZkQ0opZ3yYHbIFv4Rhi0SASI4ievWKIsLOMODVz0OK1WOl+HEC6qre
 rBMLP20PdUDCiJeLrSWYOiEDjYLBJYm1/QcZ5ID7Csx++HQzRd219sV
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: fo9iVhW6nocIrJN1io-fGjo2neqYSA0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXwk38tFCgl58e
 csdLLPAkGVOgQZD7JYBIDU5xdZ+zxDHpDYbjYvrTVKU8TjCvjFlvmNTr+JbDVDBaMd1YWrSPd/+
 EM+MIdFapDCPymHR8g7Pr8qOL3QOO3cL0rriVT6osnzTYd66ORIN5fNO/SLbY4o0qZoRLQ/PtJ4
 litOxYigSvv+UCsWv656vAPDGvXV7BSyNKMSq/bsiVYMDLmQgzrAB/VVDvAUm34EzWfkhFVU5Do
 cnnHN85naU6MyblhNjNydcKe0x2NfWMObNWlBjJALZvN+GEKlsVEXStbevz2oBL3WFcCUQvRBFu
 lrIrnQuRWEQ754Q+KvpX5n2cEuMyEI17f3SKjj/gsfnp+Q4/Fg9x0yOXP91rPqeZSUW+5dfMZoe
 7Uupc4Or
X-Proofpoint-GUID: fo9iVhW6nocIrJN1io-fGjo2neqYSA0u
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d48da2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=2kMP3QB-8nRYnlZXCZMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

This series adds driver changes to bring up the TPG interfaces 
in SA8775P and QCS8300.

We have tested this on qcs9100-ride board and qcs8300-ride board with 
'Test Pattern Generator'. Unlike CSID TPG, this TPG can be seen as 
a combination of CSIPHY and sensor.

Tested with following commands:
- media-ctl --reset
- media-ctl -V '"msm_tpg0":0[fmt:SRGGB10/4608x2592 field:none]'
- media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
- media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
- media-ctl -l '"msm_tpg0":1->"msm_csid0":0[1]'
- media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
- v4l2-ctl -d /dev/v4l-subdev4 -c test_pattern=9
- yavta -B capture-mplane -n 5 -f SRGGB10P -s 4608x2592 /dev/video0
  --capture=7

Changes in V4:
- Rebase changes
- Use GENMASK to define bit fields and avoid using tabs. Use FIELD_PREP and FIELD_GET uniformly to access bit fields.
- Link to V3:https://lore.kernel.org/all/20250822-camss_tpg-v3-0-c7833a5f10d0@quicinc.com/

Changes in V3:
- Change the payload mode string
- Change the method for setting the TPG clock rate
- Remove the TPG IRQ
- Format correction
- Remove unused variables
- Merge functions and eliminate redundancy
- Modify the register write method
- Change TPG matching method to use grp_id
- Encapsulate magic numbers as macros
- Link to V2: https://lore.kernel.org/all/20250717-lemans_tpg-v2-0-a2538659349c@quicinc.com/

Changes in V2:
- rebase tpg changes based on new versions of sa8775p and qcs8300 camss patches
- Link to V1: https://lore.kernel.org/all/20250211-sa8775p_tpg-v1-0-3f76c5f8431f@quicinc.com/

---
Wenmeng Liu (3):
      media: qcom: camss: Add support for TPG common
      media: qcom: camss: Add link support for TPG common
      media: qcom: camss: tpg: Add TPG support for SA8775P and QCS8300

 drivers/media/platform/qcom/camss/Makefile         |   2 +
 .../media/platform/qcom/camss/camss-csid-gen3.c    |  17 +
 drivers/media/platform/qcom/camss/camss-csid.c     |  43 +-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   1 +
 drivers/media/platform/qcom/camss/camss-csiphy.h   |   2 +
 drivers/media/platform/qcom/camss/camss-tpg-gen1.c | 219 +++++++
 drivers/media/platform/qcom/camss/camss-tpg.c      | 696 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-tpg.h      | 125 ++++
 drivers/media/platform/qcom/camss/camss.c          | 131 ++++
 drivers/media/platform/qcom/camss/camss.h          |   5 +
 10 files changed, 1227 insertions(+), 14 deletions(-)
---
base-commit: ce7f1a983b074f6cf8609068088ca3182c569ee4
change-id: 20250924-camss_tpg-0cab6ce6372a

Best regards,
-- 
Wenmeng <wenmeng.liu@oss.qualcomm.com>


