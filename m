Return-Path: <linux-kernel+bounces-860231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262DBEFA31
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF38A4F04BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37198287258;
	Mon, 20 Oct 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mjwSR7D3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E622D6E67
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944356; cv=none; b=PDDq6NaVcmUvBtnSYkiHViwuFWU3vETldgUqbKm4fHQuY/Dm10+l8WhQt0/FMD3ICN1ZlaH9BQiXKTIvO8MjEeA385Y1bsK7TywEr6Jb2GJ9F8cRKzKDCj6PUR556LSlevK7HnKH/D6OohI0lqjMhnY4xDw9mQ8yabm0EgXFYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944356; c=relaxed/simple;
	bh=yhbzLWKuK4Svb/ypqnYVgYxI5JXJOXYx2TNvuTsDn84=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hcZk7qNadt+LbgVawsEnfLia1gSFbhqYBo88z6G+DIvEM3OTJ0xjbJ1ozxfGdVqaWolEXHMPRtWHClt2wXvw/50CZbpLB7mk/9XP8V9fBGgzZOG/MbfP44OsGt9RA4St8B4ItT1tRcW0QHUePn0x6CJUp1JXgB9mWTvNhyi7rLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mjwSR7D3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JLjEKt009293
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HhMQHdyowb7xUpeNi0bgpj
	T91L88WXtkBbN1nNa/hus=; b=mjwSR7D3E+p38VdFNr7MP4UDXEmPCb85YTCVtD
	y74EaQVHssAcC6zdL67x6HBSjakYS/FiVe7hU3n0+xSUuDZxo2XzwKrHRlmxLvpR
	ZO+72Rju+CdNUaQ/eVPDC30cf5hPy9HoMmPnNHUQMGDe9CPCWySnjy3S90SNRrdB
	dVNGpp08PrtNhI0iHLwooKrLCfjqkkeM4xDDtA2NpqZTDeJ3EcMd0nAZ/30DSm82
	3skZofXSWNle3YLlow8f+czoWSKkIuYQW5pkF0DUlrT3g8HtVJlQyzDY2N8RZEQy
	ig7i9mhi+HOZbKfhDp/R4wn/bcWzPzmYTCRwkQVOv35TmZAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfc5ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:12:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a153ba0009so7516489b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944352; x=1761549152;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhMQHdyowb7xUpeNi0bgpjT91L88WXtkBbN1nNa/hus=;
        b=HD/UODI8pTbDpyltFMj7CZmrE7GqgFhVANZXAuyu4ThInKwXjtzmXbL9H9/CfLtNjb
         9XNfy//njCqR6wIgqlWYDJV+U5lwX4RsQ0XW2QOIC6YVkTAdds6fD42SavdzGKNU3aIL
         l0ddvshJhACKm/phkY/eIvVZorcBA+ScaFDmKE6UTPTWxm9+81E941SRPVk0AzvhwVWx
         NMTYoQHrQ3fRZAQOGUs8cDlObFjNqQnROcRcC8NYDfHv/D/ukdlHAvd0zi368FGCogQ4
         xFTabyTfnF+X87G1Bc4uTCIJN5vReFKLTjevngtQ5tgdA1iNiF7xWkcZGovoKNhcWjOI
         oxAw==
X-Forwarded-Encrypted: i=1; AJvYcCX0n6l0Db16Tx7pAaxAXp8rFabRsqoUTTBLMGadvjMIoNhcl5h95XEpZIHND9iywvbwIRhijqocb/Iz41E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLV+0glcvHOgeuKIzPsP/K+EiUfehquQvAKS2+XsK5Gs9/1xPD
	j0GGGBEtGj4rVusVuhXL6UmMfEAmN0RLZ4PnDq9n3gGIrWyeNmVafVaoq4LOnrkuxgVY0vT2sbu
	GotZArsjCfFEw9KfpMdYZ8NhTxCVFjbe9xDJw8Do2y1pXldTuz9eP++4f23xy+QKk2OMY5C7ZkM
	E=
X-Gm-Gg: ASbGnctPfIK0o7v9euml/1M97nsnta4JTmIdhBmPojKVoPiu6TXVzM9npPd7TQvfsZY
	RkVdj6Lh66rZLJEqh/yjU+csSneEmsNCcQ2iccI6GrIKyy7iw/MXLCdQxL8ThFEUCHpZWOST+U2
	NWly9f/sLHgeojzQVW8D5TNWcWrvV2OQ2AnY0rbqZGyI7XLYr/SKXMPb82T542xh/2/XFW1rwZZ
	qcVriahGG1Njymy6eoKriLZh2eX90mpLGMenb3akrD5b7HKKK5FSHpN6IY3dNdTJBbQKqXfR7Nj
	dgCIlS2GbYMMbwZDLU7Sraci5BTviN2VGXPPAG60LGgpoz+E95bUwLOJxvukvPE2ygLukjbgsXa
	M2Y/lH532+KiXjmxMplAmEU1FudKAi9PSH/BBBUBxhoA5m9XQhIBRN+F79AtdIBaoObw=
X-Received: by 2002:a05:6a00:a589:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7a220d2328emr14099368b3a.19.1760944352509;
        Mon, 20 Oct 2025 00:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFID509bQvDFsXjXcGYMaFoQ+T7rxmZHSka4oAHjXjgLq3rPIpVaEsQB57crWkg6D+gsbiDA==
X-Received: by 2002:a05:6a00:a589:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7a220d2328emr14099350b3a.19.1760944352083;
        Mon, 20 Oct 2025 00:12:32 -0700 (PDT)
Received: from jinlmao-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm7421705b3a.22.2025.10.20.00.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:12:31 -0700 (PDT)
From: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Add Qualcomm extended CTI support
Date: Mon, 20 Oct 2025 15:11:59 +0800
Message-Id: <20251020-extended_cti-v5-0-6f193da2d467@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL/g9WgC/5XM3wqCMBTH8VeJXTfZptPZVe8REvtzloN05UwM8
 d2bQhdRCN0c+B34fCcUoHMQ0GE3oQ4GF5xv4+D7HdK1bC+AnYkbMcI4JTTHMPbQGjBn3TvMZMZ
 yLUSZKYoiuXVg3bjmTlXctQu9755rfeDL9x0qPkMDxwQX1ljKMwNUiqMPIbk/5FX7pkniWfIb1
 kpWCmooqML+a7nUqdIlT601G5aRH1ZlnGmVRsryb1vN8/wCiTU5aGMBAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        quic_yingdeng@quicinc.com, Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Yingchao Deng <yingchao.deng@oss.qualcomm.com>,
        Jinlong Mao <jinglong.mao@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760944348; l=2524;
 i=yingchao.deng@oss.qualcomm.com; s=20250721; h=from:subject:message-id;
 bh=yhbzLWKuK4Svb/ypqnYVgYxI5JXJOXYx2TNvuTsDn84=;
 b=j74nyX9FlZ3fACAGB0SEF2T6/NpdepyK6MotE+or3WzBWOv+hMLcqiEn+jcmjgsyoMLCOO+IH
 EFhzLZo2hgVCeXWJonoomAMqOn9+jN/TTBSnI1eQzer/UFBGAukXA0M
X-Developer-Key: i=yingchao.deng@oss.qualcomm.com; a=ed25519;
 pk=1zkrZnKgKCu3VxiiiGfzpW3KL9RNP/qun1frl0ozUIc=
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f5e0e1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=nlyGTqwaJupNnBHl5SIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SasqvBgmn6a5QRStZzvLrdinrywyCMAp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX/N4hB8oicMcS
 T+KPyzGpgTvIhh7XCGKPli3tzWv8nj8E9LNMoixoYDCl2gPYehRT+npeMfaYZVnXuk9pofqtMVO
 KoAfGvMKW2RjVxAkf/5eQ4Cyqu12bzYswtCYlRNUde2/Kcjd6rk20SlS1iM7Xa/JaKvzzieelA3
 Qsq9SP2ClQqoRkIkUdmdoAGBc04/xkGQrUpRi7l05coLTkwxYc+9uGU3L1MCIQNcfjPLXqlMQ8F
 qqbW63hcXjGBsj/NkhL0C/TfNXilvRm9cGfVS5KY78cntrPTUZSCDgRp1quiXuh1dWnu685Rfiy
 lO98C5n90XU/6Mi2RTGVY+7b36qlUVWnNUt09iLQe8weLgwCJSmuLFOTdaC6rVjU3AIJXoYLkD8
 IfA06uD0AGa3kcM/x6lgI2N0/4OhDg==
X-Proofpoint-GUID: SasqvBgmn6a5QRStZzvLrdinrywyCMAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

The QCOM extended CTI is a heavily parameterized version of ARM’s CSCTI.
It allows a debugger to send to trigger events to a processor or to send
a trigger event to one or more processors when a trigger event occurs on
another processor on the same SoC, or even between SoCs.

QCOM extended CTI supports up to 128 triggers. And some of the register
offsets are changed.

The commands to configure CTI triggers are the same as ARM's CTI.

Changes in v5:
1. Move common part in qcom-cti.h to coresight-cti.h.
2. Convert trigger usage fields to dynamic bitmaps and arrays.
3. Fix holes in struct cti_config to save some space.
4. Revert the previous changes related to the claim tag in
   cti_enable/disable_hw.
Link to v4 - https://lore.kernel.org/linux-arm-msm/20250902-extended_cti-v4-1-7677de04b416@oss.qualcomm.com/

Changes in v4:
1. Read the DEVARCH registers to identify Qualcomm CTI.
2. Add a reg_idx node, and refactor the coresight_cti_reg_show() and
coresight_cti_reg_store() functions accordingly.
3. The register offsets specific to Qualcomm CTI are moved to qcom_cti.h.
Link to v3 - https://lore.kernel.org/linux-arm-msm/20250722081405.2947294-1-quic_jinlmao@quicinc.com/

Changes in v3:
1. Rename is_extended_cti() to of_is_extended_cti().
2. Add the missing 'i' when write the CTI trigger registers.
3. Convert the multi-line output in sysfs to single line.
4. Initialize offset arrays using designated initializer.
Link to V2 - https://lore.kernel.org/all/20250429071841.1158315-3-quic_jinlmao@quicinc.com/

Changes in V2:
1. Add enum for compatible items.
2. Move offset arrays to coresight-cti-core

Signed-off-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
---
Yingchao Deng (2):
      coresight: cti: Convert trigger usage fields to dynamic bitmaps and arrays
      coresight: cti: Add Qualcomm extended CTI support

 drivers/hwtracing/coresight/coresight-cti-core.c   | 144 +++++++++++++---
 .../hwtracing/coresight/coresight-cti-platform.c   |  16 +-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  | 184 +++++++++++++++------
 drivers/hwtracing/coresight/coresight-cti.h        |  60 ++++++-
 drivers/hwtracing/coresight/qcom-cti.h             |  29 ++++
 5 files changed, 346 insertions(+), 87 deletions(-)
---
base-commit: 1fdbb3ff1233e204e26f9f6821ae9c125a055229
change-id: 20251016-extended_cti-2a426c8894b1

Best regards,
-- 
Yingchao Deng <yingchao.deng@oss.qualcomm.com>


