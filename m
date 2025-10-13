Return-Path: <linux-kernel+bounces-850005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F81BD19A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519511890BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4392E03F0;
	Mon, 13 Oct 2025 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BX7bU1Fp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E82E040B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335901; cv=none; b=W9HRwSx0IRj0lw5vFHl9uYrnS0MBOAhbUWSgjMOHe9Ehu71T7fQxoUFIwxWyK1VoGBomP75+U1weJ9ZWFArjjfVVhnxR/UHfl9gkJbM3EBbeFIy7t/O6YqpGXJtljOzc1BUQRbt78GA5OORf5bZofViNZmZTMcv+rudMmioTcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335901; c=relaxed/simple;
	bh=m3igMj4R7s1y9FpKNJWImJDhwhMcIhXy+s3EIqKrm+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N10RQfH2tcZHb7aAGJvMYqSE8VMT4EFgVSCFlTmHrALWgN+uygonm6NWvidqj+pmwwgaEtdnGWjZYaVqSMhT/RN4UanM3NgwRYxvgoYY0xz1KQrHAWIOjv8f6y5xFfyU0jd9a/JE3HSNXDbA4Z9TzYrdb/5mM2VC3AMvoiBKD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BX7bU1Fp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n5Fj010315
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GrDvM6oXP/TotZ8t4JES1P
	UvRpzDQj/VgtwmagjYzTo=; b=BX7bU1FpfzEFXW5zNUpNNdrG9L0/i3KXwm4O1T
	E0NGwU/L4O/BNOsBvMnoNRvvXChnRHi9po6gqLt5zQWDExhFd3Drqe4dRe+kEfG2
	zblTOoWZEqeRDbeLa4ErC4p1uXcg9oZzxOXKqT2xmPF8lJjgHzmkYHk1arqLebbY
	90eoRJU7JoXy+bs6W39I13EJ6YO0n0iydgFypAIhitUYPAD9uu6F69meBalRkLBP
	JrVO4yBD5Yio2jwQrtiiezdIMbHC5TDREIzYoOb3VNIJVg1dfva66TvlZxsWE1bb
	BwTKL1Z8Gw7+Nk3RJqGj86MuMLe5RwmKu/UIYO7DUrXt+cqw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0bucj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28eb14e3cafso138279115ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335898; x=1760940698;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrDvM6oXP/TotZ8t4JES1PUvRpzDQj/VgtwmagjYzTo=;
        b=EkRcP/3WQ0/3xUZ/FU6F5e/+4a2PzZClL2f+cGCx8yj70KNGJ4F9jKkIAbmSxqiMv6
         HUUUVOs9eLTAO32NfM1ZQ8+21BVo9AT7s3Fg25YWnmbJcemtW0hKEtFcu7Rccuq7IDrq
         mohKAtObDTNxNyKzDFEZg71z2tgLXlfv8oagYNi036xA2pHX38iuFbBp6NhZMQW+Whuy
         NGI330FYTrgsLxzjNUCkfY1y0u0izu9rI9wVs8Z2oiYgO1uM7YEh3yM6QP3Rk9ROJ4pR
         mvWOk2X7izX2bYHJ2sIoaGd/27l/kbju3P6WF1+UgIz5+hqe9K7Cmsm9udDzkJnjV4hQ
         AuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFqTzG7V67jNkxSOl68anOxHM50EHKv1XIyXnrBd2nsrm4o0+2uug4puwlHgWfOAOlcOhdkFu6iqeMujk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvNFwQ2YJ6iERY86eNRfFjZFAU1RphOKfVNVyiRtCbZ+ZgrjD
	aoWe6pspBanhZt2V2DXQUE6JnSK9erBK1MYBqbN5F0J4tJChDj5yR8mxGJhkYI3t2Uqtxakf8U4
	vKV56yBhyqS7RPmBniU7AKONiWAYbjiuviAmPRZ/Z/koFglD+id0TpV55VIegVvixVjE=
X-Gm-Gg: ASbGnctknXKGzLfMwZ7G1euQhvZ+yTtSogZ2dvgVg9vfDcqYKiZlenbHrkeZgSRQYR3
	uKO1lINVQeQEApgOYPrRFdJ/tjO0IZIpUzA6eydwRb0LS/nOIXezJD0xjtwMQPYG8pnOWhVfM2H
	1zoBfwaosj+A6Z6RZDE1WQ6tDImVhGgsHIEHPEMUpVNPczfjDvcUJ+ag7Y0RR83ec6uLMWzMLEc
	OxtrvhvcsZSgHthgfVag+Q9dwUnH42nzCCiEsHjZq4LtI/f4wJ4pkhbZIA49WJ4c8ZSZ6eauNP/
	Kgj33OB45UVmmm/ih5SeHhAldxeCdCBgP9DCLJMgEsAE5PkSGcQ7s0hHgVlEZcWEKagNH177fJW
	hp4hPh2IBjqq8Fr+28Ri/epoYVg8=
X-Received: by 2002:a17:903:2d1:b0:277:3488:787e with SMTP id d9443c01a7336-29027356933mr247429415ad.12.1760335898264;
        Sun, 12 Oct 2025 23:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVYUXzidkgUFrV2iPv99/ku+8bVfeLUvYnCfbn4pDK8/n2MNSkCO63ZBGJ6gT8lPzqENwpIQ==
X-Received: by 2002:a17:903:2d1:b0:277:3488:787e with SMTP id d9443c01a7336-29027356933mr247429035ad.12.1760335897783;
        Sun, 12 Oct 2025 23:11:37 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2904f61a1desm64388675ad.82.2025.10.12.23.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 23:11:37 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Subject: [PATCH v3 0/3] coresight: add static TPDM support
Date: Mon, 13 Oct 2025 14:11:15 +0800
Message-Id: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWY7GgC/x3MQQqEMAxA0atI1hNoLergVWQW1UTNYrQ0VYTi3
 S0u3+L/DMpRWKGvMkQ+RWXfCtyngmn128IoVAy1qRtrrENPhJp8kglToD/qEcIeEzpnxs5SS2b
 +QqlD5Fmu9zz87vsBw+t+Z2kAAAA=
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760335892; l=1812;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=m3igMj4R7s1y9FpKNJWImJDhwhMcIhXy+s3EIqKrm+A=;
 b=gcdfQfaDmMEaFKBEjYpbgmeW/uSoRcEwX+ppPkiBB+DRMJInxmaqgMFqFzaBJODKMmWiMVmkx
 F3Gb7ccw0aQBZkip7Tv53zEw0TTgHXqtUdvnmKX2l6NPxUNo//ABJ8y
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: mu8dNRU5gTK-BrNnnZ8sz_-HfZMFEt52
X-Proofpoint-ORIG-GUID: mu8dNRU5gTK-BrNnnZ8sz_-HfZMFEt52
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ec981b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=nhnTKuEOM_5bWBThM9gA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX37Zs8jJQxA2g
 Pew+mOB+15LSReBHtqOUut0L2LSO9uP187HiADMETa4Ua1EBjbpWOxENnil02utboq5VRDtxc6h
 jWbxEJw3VlmHRyJmyb1MLhUCfz6fsFT1t5BT7hTdLEsJHge9Af+9bMobvHvmbRCrPJPKKHWkxW6
 /1pi+nugpgECiQBTftwNGv8YaFgBNzLGFC5zcPg+GOP7N9woMu+sHbzDh7OXEFhXUaeLaXn7xWV
 NdKNIuC2KmWMFnfcf14WlVJJa2+aRIh8zzRzWLsHTrcFFX1aILJiWDPf+oE6IprYHXsnu+U4ksi
 SiMtvTwldKlGvoWU6vb37sl3o6fdponIABJfxjEEVpq0OFcSlLD5RpUMNuD5DI7XA2xHzz9X8A2
 r9zKUgcZYsGNaDYNJiE7lTzYCO5EkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

The static TPDM function as a dummy source, however, it is essential
to enable the port connected to the TPDA and configure the element size.
Without this, the TPDA cannot correctly receive trace data from the
static TPDM. Since the static TPDM does not require MMIO mapping to
access its registers, a clock controller is not mandatory for its
operation.

Meanwhile, a function has been introduced to determine whether the
current csdev is a static TPDM. This check enables the TPDA device
to correctly read the element size and activate its port accordingly.
Otherwise the TPDA cannot receive the trace data from the TPDM device.

Changes in V3:
1. rebased on next-20251010
Link to V2 - https://lore.kernel.org/all/20250911-add_static_tpdm_support-v2-0-608559d36f74@oss.qualcomm.com/

Changes in V2:
1. Remove the dependency.
2. Collect tags from Rob and Konard for patchset 1 and patchset 3.
Link to V1 - https://lore.kernel.org/all/20250822103008.1029-1-jie.gan@oss.qualcomm.com/

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
Jie Gan (3):
      dt-bindings: arm: document the static TPDM compatible
      coresight: tpdm: add static tpdm support
      arm64: dts: qcom: lemans: enable static TPDM

 .../bindings/arm/qcom,coresight-tpdm.yaml          |  23 +++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 105 +++++++++++++++
 drivers/hwtracing/coresight/coresight-tpda.c       |   9 ++
 drivers/hwtracing/coresight/coresight-tpdm.c       | 148 ++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tpdm.h       |   8 ++
 5 files changed, 256 insertions(+), 37 deletions(-)
---
base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae
change-id: 20251013-add-static-tpdm-support-330b71d6d0f8

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


