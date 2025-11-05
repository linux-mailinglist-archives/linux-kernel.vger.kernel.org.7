Return-Path: <linux-kernel+bounces-886950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E243C36C59
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1360D34EFDE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A681337104;
	Wed,  5 Nov 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VixT6fi8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RvzWKFxj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BA31D390
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361171; cv=none; b=n8K3Es4XJInmEkAX+gf3NIvsknXprfuh1UONP34ANzsjNEtdFf8HiiwnyE+eNhKgdh5rdpKHaMoUSHpZ3xcZEJKWrop6fDBKBj/LvMq3WyCYOycUzU6su4waA04URVs+H2c3Rrbxzp8Jvh1+FTpyoAnyDfmVbltGgKKg63Nq2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361171; c=relaxed/simple;
	bh=PcDDIBcEIGtNyT7znZSa4/D1SLEv+wO02puHeHxpSrA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ip3Plq7W/ZkItOAJo5vdNaM87WJmmQvZxYGc3pqc+TJ0cPnigFVelbXSEiIihi0ae2/zBQZP4sUXjlhLb5DXp6yajy65zjl/xvNFbm9oNhCUlfVxBEk7GuQTEU99QvByJCSgYznIJkQlFA7gcB2fe86XXLXMrQP2VPR6urs2Yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VixT6fi8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RvzWKFxj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A599igw356682
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 16:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/39PKwKFPjq6vqHlDBh03E
	gjb7S4PRc4fvYafgd61Yw=; b=VixT6fi8nRXeC0k+VrY2iTrZlvx1i5UG5Xncnm
	od/PfZETODOe6PkYnJUfoMKDg91TU2P60ML6wj6Ff+4vbo/PEAIK/L965gcwYnCO
	hmRgS87aJgRx5IGkAdQCzzqJhT+YXYn9+huiQZfhl+FlaB367K/7LJdF7mKEmy0g
	e7ckavKOSFHX/isu7bxAVQ5nyu9ayGaMDAs07bnHn3JSAceiR7RAqeQnV57PqcsF
	ZEQwqQ2j+pB7NaLjAKKIqDKdx7H+MtKsg1sNnq2WwkVqeh1F+szu1tt23a4LVq9N
	/wQ1FxPkvdNcX59yfOrtWQsteCnChHP6pGIzJ4j727eD946w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a83q5h96h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:46:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33baef12edaso115821a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762361167; x=1762965967; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/39PKwKFPjq6vqHlDBh03Egjb7S4PRc4fvYafgd61Yw=;
        b=RvzWKFxjt8Y6MsstIf1NFGhBXviHO7jd6MnuMlNhweHzCHbLWxu2yh8dza3X3bFpIz
         c/CR6qOlA2Bj7883fG8ZcvAnyXJDw37owoRGk1P9aInMM16/M0WdtAqktyW9SsAsg6jF
         cPnStNkzxRyLnqYcKEoiglCdI/cS3YjL7QNIqrtkUrT53s+On30gvK49nxjuMGQlzWnc
         tKbOI4rBSofjXRJACfhQpeTsfYvQSQVfMxVIw17peaU4LXfaupIhkzgTv8zGSOFckj9s
         pO6F7BNnMTZCg4uI3Z3Y5npweRkcgNJQto0z3tjiVmaDFLNY75ge46XuesSEmp7pZnd3
         /ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361167; x=1762965967;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/39PKwKFPjq6vqHlDBh03Egjb7S4PRc4fvYafgd61Yw=;
        b=EjBw0uXeCAWpt/6gfE+ziKfWLK6PtVOBRAq59l7wfv9aSh3kdEyZE0S8pxt7GtQcQp
         YmnmG0Fq0PdgsBaCp/lFEKFB6EOUF82q5ykwOHKFVqKryD1L1EpyPLzeAnzxTnAlvWvA
         B156Ye9W4KulEKsEtONFlhY/DqbbFRRloDajhXfJ+cjJ/AYXowplxmopCWKZxW+3TZLe
         SCuMdgviUagGWZK7B/3UCHbjI/FA4Pdd7lVnYaQ4xvffWQsV2nMHgIp0761JxhWzE0bm
         pU6U31b6MzRoCPasUCUyMi7dvxLtpUaE37tmubFhhIt6stZ8wMH2Cflk8/rC27c3YQAq
         DhpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3PbMGQv+iUgKVj/yOy71wVAhdpOg3kKmDBvk8bhorJ0297ok3TEVbi10e01mpTZmdYknXgsSnrfZnLu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqkE0hGAxiUR4UHML+vgnw3IfIx9lURyVCyJ7+uX4EXK1y1mE
	YPfnkPY2oJhZtRECxaCK5mxKRg2eHmDf8sNSrVRyRASoI7S2uA+UnU3BnbgxBU7BaOxvca1uHJR
	K4X4xdDHMmp/QsHje/145+jS93yvA8XSwckojzye8LPnsE5pLTeJsff0T2EiqjLdWP3Y=
X-Gm-Gg: ASbGnctbFqsmGkhYs1tnt76QjvwmtUfk3suFuG8KpcGek47zlfVy5ScsfAwmxFpSB4j
	5PhrHv3n4igxUwfTvt3WUjrGJLw1R8K8ETdb6cXOgLOkS1uznHsj3saaRms08N4dvc9Qis+wbSg
	3EcbHa/Y3sG60TrXqgR1yDpPFQ2tVKpE5+ov6DKXUECQqSRIQM02pPs8DiZFKVzEclaMD06olbO
	bW2sgf1s9gIyVONqo5R7IiUssw5va4jXg+zLdyQKVbgSO7azNcuAeMhQ6QkDKhPYiomgEnain1l
	qeyzYV+YRQugWtRq2GJLY/AYf9dfjyAikipUgo7sPgBDzkRomE5+jhnu0v3A/uZgZ0ynzHZpl20
	6F2ok7GaS79CAQgcWiKfI1GA=
X-Received: by 2002:a17:90b:4a49:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-341a6dd9c48mr5286915a91.17.1762361167407;
        Wed, 05 Nov 2025 08:46:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgcT+6/XLEEYHAFLkWWkahGQ+87zU0D5ZMUZde6qTS8n4Sil+15JEtBQZqISHAL207X+eFuA==
X-Received: by 2002:a17:90b:4a49:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-341a6dd9c48mr5286861a91.17.1762361166876;
        Wed, 05 Nov 2025 08:46:06 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm3426249a91.8.2025.11.05.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:46:06 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v7 0/5] DRM/MSM: Support for Adreno 663 GPU
Date: Wed, 05 Nov 2025 22:15:44 +0530
Message-Id: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADh/C2kC/3XRzW7CMAwH8FdBOS8odr458R7TDkmTQqTRlqatm
 BDvvhTEQGp3/Fvxz7F8JTn2KWay21xJH6eUU9uUoD82pDq65hBpCiUTZCiYBU2dUpweupHmsev
 afqAehJaVQaOYIqWt62OdLnfy86vkY8pD2//cJ0wwV5+YWWITUEZR1tHxmgclwv48pio11bZqT
 2TmJvwjgCGuEFgIboLjBrlQVi8J/kZwtkLwQvhQQ7BVVAxhSYgnIZlZ/YUohNUBlfcIQsR9m/P
 2PLrvQpxejnw5ltkVRxZHK6gdc0YrX//jqDcH1lZSxZHBgTSoPQq74twe1+tj2Tan4XFC4l2Od
 H6Uht2miZeBzlMAmCwdt1+HLkdsQQIAAA==
X-Change-ID: 20240917-a663-gpu-support-b1475c828606
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361159; l=4315;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=PcDDIBcEIGtNyT7znZSa4/D1SLEv+wO02puHeHxpSrA=;
 b=DuupHbe7N+zgImOfEL0Mmxrj/O9yI0sSVA4F4Hd7ZxpYqyp/SqnhHNYP7OhmBvWfjsvx6O2Ag
 /PY4o4zW5ygBu1PjX/PO8U9J13aJYEbw5dXUwP9djL4KnHY+3hSS4pC
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: LJPCVK7pAx5_nzwyFV31lLHepJ1HIIv7
X-Proofpoint-GUID: LJPCVK7pAx5_nzwyFV31lLHepJ1HIIv7
X-Authority-Analysis: v=2.4 cv=YZKwJgRf c=1 sm=1 tr=0 ts=690b7f51 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=tVI0ZWmoAAAA:8 a=QyXUC8HyAAAA:8
 a=e5mUnYsNAAAA:8 a=jTv6lf4Jh5MpNzVl0_IA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyOSBTYWx0ZWRfXxw27VTJGb3iR
 xah1oiJJ+FcYzO0r13Ul4H7B15PffxpKU3Xrvv3LDjAQjiBKm3mCOyHWAroqXXsCVbMYYH4vK7W
 ocO1dSIyzyGkbAY4J4m57ixPR160JGc2+4kczLNY/PeShrWoVyMYTeAja0ovuysVod5d2c6fmEI
 sdgKn78QNIIpzgnwPspBYFq1l3zxQUJuAJjs8Br9KM2CfHK1eQH6LMlffsV+l0Ru1EwhUQeN30I
 ER+uwc4YL79fBJXmiigSBiHvN2opU5QfGRR/AYxrt+fQH7hcA4ygHR7x9/HehnDovoZ1YEyZkZK
 2GGc1SfSeMi3GzJpHqT8IwBYkaUFE4h353BGiVodxEJqDE0qpe6gubNSQtJNI+M9nj9yxus6PVr
 G5XLTpFbThk8WSavBV1vHrDCJW1fvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050129

This series adds support for Adreno 663 gpu found in SA8775P (Lemans)
chipsets. The closest gpu which is currently supported in drm-msm is A660.
Following are the major differences with that:
	1. gmu/zap firmwares
	2. Recommended to disable Level2 swizzling

Verified kmscube/weston/glmark2-es2. This series is rebased on top of
v6.17-rc1.

Due to the SKU detection support in this series, the device tree series
technically has a runtime dependency on the driver change in patch#1.
But I think that is okay since we never had GPU support in this
platform and  the gpu support is enabled here. 

Apologies for the back to back rev bump. I am hoping to get this picked
up for v6.18.

Patch#1 is for Rob Clark, Patch#2 for Srinivas and the rest are for Bjorn to pick up.

[1] https://lore.kernel.org/all/20250803110113.401927-1-wasim.nazir@oss.qualcomm.com/

To: Rob Clark <robdclark@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Connor Abbott <cwabbott0@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

-Akhil

---
Changes in v7:
- Rebased on next-20251105
- Dropped drm-msm speedbin patch which is already picked up
- Picked up trailers
- Link to v6: https://lore.kernel.org/r/20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com

Changes in v6:
- Keep the efuse's reg range 4K aligned (Konrad)
- Update GMU's opp table to bump frequency to 500Mhz (Konrad)
- Link to v5: https://lore.kernel.org/r/20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com

Changes in v5:
- Remove unnecessary labels in the gpu cooling patch (Konrad)
- Update the RPMH corner for 530 Mhz
- Wire up the gpu speedbin node to the gpu
- Link to v4: https://lore.kernel.org/r/20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com

Changes in v4:
- Rebased on top of another series which renames DT files
- Enabled GPU on IoT boards as per the latest definition
- Picked up SKU detection support
- Added GPU passive cooling support
- Link to v3: https://lore.kernel.org/r/20241030-a663-gpu-support-v3-0-bdf1d9ce6021@quicinc.com

Changes in v3:
- Rebased on the latest msm-next tip
- Added R-b tags from Dmitry
- Dropped patch #1 and #2 from v2 revision since they are already
picked up in msm-next
- Link to v2: https://lore.kernel.org/r/20241022-a663-gpu-support-v2-0-38da38234697@quicinc.com

Changes in v2:
- Fixed ubwc configuration (dimtry)
- Split out platform dt patch (dimtry)
- Fix formatting in the dt patch (dimtry)
- Updated Opp table to include all levels
- Updated bw IB votes to match downstream
- Rebased on top of msm-next tip
- Link to v1: https://lore.kernel.org/r/20240918-a663-gpu-support-v1-0-25fea3f3d64d@quicinc.com

---
Akhil P Oommen (3):
      dt-bindings: nvmem: qfprom: Add sa8775p compatible
      arm64: dts: qcom: lemans-evk: Enable Adreno 663 GPU
      arm64: dts: qcom: qcs9100-ride: Enable Adreno 663 GPU

Gaurav Kohli (1):
      arm64: dts: qcom: lemans: Add GPU cooling

Puranam V G Tejaswi (1):
      arm64: dts: qcom: sa8775p: Add gpu and gmu nodes

 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   1 +
 arch/arm64/boot/dts/qcom/lemans-evk.dts            |   8 +
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi   |   8 +
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 174 ++++++++++++++++++++-
 4 files changed, 185 insertions(+), 6 deletions(-)
---
base-commit: 185cd3dc1a12b97194a62eba9d217d280ef74135
change-id: 20240917-a663-gpu-support-b1475c828606

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>


