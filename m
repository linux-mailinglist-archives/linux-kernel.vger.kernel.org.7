Return-Path: <linux-kernel+bounces-885831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F68C3400E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5701B420C56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50C26F289;
	Wed,  5 Nov 2025 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hP2v/6CJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eizNSG8V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE73263C8A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321671; cv=none; b=gAEzR+VkVBlPjWBJ7ZkdsvZ8AkdUi0dv2DLTGPe9YGtaIqkXP1E+CYOEXgWyFPu9/D+5Psz4D6bq2Hijkcnkd59p5Zd9QaSvMNn3EzvTmoGi2qHqSJkL+0kcXTFtKEqgcl3jlu/LNkJgK4Inwqx9GK6sOuCWvNP6CbYdrzlvcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321671; c=relaxed/simple;
	bh=CmCMkFGdjKimc4a8I9wySoXS+kBG+D4uHqlvimyNf3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JSH4tLlIYH9gQ6rHpytzQojblH11v45SGb6YWOPfot8NSgrDlbfxUedZfGhU5w5nlmQ/dVBnVSDLTlEXbXzGRPZI30Grb2YybIQUVcHqrl2E0jn7akD5S+HCn8e+zk8DyapiSiASepDDE87QUt8yai7anCXjaKqqYk6IzwktQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hP2v/6CJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eizNSG8V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Kfwwn2996894
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 05:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=83MHbwvzUZdEq/T0F1dNJV
	sVheiPbFtUJACtWCcmOL0=; b=hP2v/6CJoe7LpamhAy8MczphHmxktuMddW8dJq
	GH0RDq5yfTT9+Jcf/Uf1vyB6r8RJybUJhqetTLrO5TwWyc0fdC3eN93Mxg7iiMpY
	2aLaxqPMPTyLiFzWlSxUjlhYIW5fLqsielQVtyvwJQfuCdyRPF8iA36DfwSssvFm
	lQpTPwNQr273YTn7Lv+UMEYo5Ykvw9H3U9OhuacETCkx86XBcv94Owv2598dnuoH
	UGqEl41oojuUpKWcQSx41MXSwbX34cRC1Bqup8x1URdc5yv+nF+52VCtPjl4C8bT
	UdEqTblZ9CK5yMQzOIaQ9wqIupXOxnrmq6fiRiL/wGZDmH6g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jkps7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:47:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-781253de15aso15198221b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 21:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762321668; x=1762926468; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83MHbwvzUZdEq/T0F1dNJVsVheiPbFtUJACtWCcmOL0=;
        b=eizNSG8VR9Q4PMPnlEHUQ6YQdE8wct3JY4jpB8i2aNqlyI3Qw/k8x0GFpWbjYjep1L
         rQAEDzSQo1BQmB4YkIeZZvhk3T09csUpjV3Z1XmOs5B2jCdu99v/tav5JjUBcO2RigwP
         oS79aIAGhe+dDADHFBuV0Do5DdlQQ7z1zQOkD1QDw6fFok3qDIn6pBTFYJp1TeyqLObZ
         9xEFLDa+OBGF/AnKSuVgONqRvX8UZV6ayBKJabIkC1YIgoq9r6OvvvWsEOp+Ugpo702T
         2l5+8D8x4tm58WnkH5su75AgfhnOz9TZBG4aMqxYkg21XblTlf17LA11wlZdFlYrme3E
         C4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762321668; x=1762926468;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83MHbwvzUZdEq/T0F1dNJVsVheiPbFtUJACtWCcmOL0=;
        b=OydhvWmjiZLrmdRDVTa8KTqxjGZQDla0CDWkTiL6LBK1HFZRSsWMN5WCNIOFaQ58KZ
         oiEhU44KjjhJWegJWMHF52y6WurWc5rhcYpdgRpVgDuzS+yJxxLRkiBisu5OPcT5rEzm
         lvTA4MXr6Qeh9EhbHWd0RyfdIV7kw0OP7pfC1MgfEP3StnEq6K0XB9N2POdnN33YMSAs
         SmdaV88GXl064bJbzhWDsaZVg2XPc8m+7noi1vT/e2jJweAA0iwc46w5XJr2JF5x8+s9
         9zug+YLxRk8U1QBIiJL4fzhMwoUnV5blKItTGYzMoEqFGcX7/T3A9CkUhH0XpqO+9vwQ
         EZvw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Z9gVI7cYT0FCS94Wfl2eLS/InYSde7sFkQo8fIQ/5Qys49iuzIqTvxxrtuts01OacXOaw01ca1RPois=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3R9fqxf6DTD3aoZulOPUya5GHd2lfEuD1lX1CTsdy7LV9wo5
	GKHD+fdAmHV6DHaKGs5wuSyWdDWya4JpxgPWX9bgGX897TehPHCZ5xY3fcFXlq6Vt+t/TsceAMh
	nBYzHQClfrqPyuQ4qchkDZAhd39CCp42ik0rMwpmPYISE8FUEZnhrCAbUDBN6N0+0sLc=
X-Gm-Gg: ASbGncsMA1ZlprWq0NEVIqs9bNkT3txuxZIMOHGe7k+dNdEBq/8CfGufAQ/89sw7UcE
	++6GVwWoJuGkaZJLv/Rb42cvAWWGgCRSUNYSnOcWTgP7eGoavVHpdUAF3UW/h2J4VhNv0UD0iqf
	w3m9zjdM0f9ixkaHuVyXI9GcLSpddOt2Ee/ByDpCX4vXuBZFHFIR64gpnPCBG8sXdySHKLeRfb3
	0RT8CZZr/kzU4fK08SSwXfFhNFqBpjM3nWH8RevpITa6ZLaQNdnlyzEdSlh2r6U7q0g284prNh+
	mAawDjnLjz4ZEANPSNAGLSBrTGEK08zXpnRqabH/F7geg8MaVk4xCxqXQcPwwHjNtrtDzSejHha
	zEUJnZit1OHiRkRrzOZN4N80rRUnBOnZWCj43
X-Received: by 2002:a05:6a21:338c:b0:343:70a2:bca9 with SMTP id adf61e73a8af0-34f863015bcmr2554560637.53.1762321668410;
        Tue, 04 Nov 2025 21:47:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHox9k7eKy6idJXRpDoSZegqgrG1eKq8dcvVFuh9rbDGp7JdOle1rYXMTc1Nt5mZN8yZZBYzQ==
X-Received: by 2002:a05:6a21:338c:b0:343:70a2:bca9 with SMTP id adf61e73a8af0-34f863015bcmr2554527637.53.1762321667890;
        Tue, 04 Nov 2025 21:47:47 -0800 (PST)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417d40da83sm2090203a91.14.2025.11.04.21.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 21:47:47 -0800 (PST)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 11:17:37 +0530
Subject: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPjkCmkC/3XMQQ6CMBCF4auQri2hUyrBlfcwLko7lYlCtdVGQ
 7i7hZUxupnkf8l8E4sYCCPbFRMLmCiSH3PITcFMr8cTcrK5GVSghKgkp0CRR8Qzd/TkjQalHYD
 TClj+uQbM8+odjrl7incfXiufxLL+k5Lggm9tp5xC0TQAex9jeXvoi/HDUObDFjDBJ1J/I5AR0
 1ptULZdLe0PZJ7nN5K6X6H2AAAA
X-Change-ID: 20251103-iris-seek-fix-7a25af22fa52
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762321664; l=3061;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=CmCMkFGdjKimc4a8I9wySoXS+kBG+D4uHqlvimyNf3M=;
 b=/iFaMOhCzLvfIlk8VviJtF0/+OhwhDKTGibbWsNNI5IWpqKCpPs8jIxaHpqoL81h1K9ORp80m
 wtfel3d5xtbAbV3c2ILDXNRq7K3CcdT6BhZN7I/JWMbXqdVTj4NZM8p
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAzOSBTYWx0ZWRfX58P8lDw5lYIC
 +TpDqllkx3GOvG62jQS15xrtyHlktr2WJSzgzTviK6M4AyVnqsw/qmd4K/hkd/wzr5Q+xco4oT7
 G0eEhIKnbWA4CyjYI+Eyy3uMYH5OeFm3oyLEB27/i72/OwmXEYMFTO0Nb/hXbfEfdYxzWtcPK32
 aTwneG8fVpTJ+aPXpirs2tQhk6z0B0Iv+3+gyOWAOwzUj2I0Otg4ZcPJtl6KIoLG2fLw/4POpKu
 x616Pg0P6sMhcOASqzTlf5villFP6oWIf5A7/770vmJ2NZ070cpLKTMVe/SZA0jyuR6cWHk443O
 ywPWUlA0Fp5qdntV4aOMCM/tH1nQP0P2q7uWU0PJEBAVy6CkTnc+XfSr4ioY8XTXpY5dgqyRFkD
 ++sWpAcJHeWargF9MRU0JgI82NXU5w==
X-Proofpoint-ORIG-GUID: 0Jo2TrUcyf0KJQu_2Ynb-QdrPeEyKJWe
X-Proofpoint-GUID: 0Jo2TrUcyf0KJQu_2Ynb-QdrPeEyKJWe
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=690ae505 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mRoNVkTk4HY_DrcNXJoA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050039

Improve the condition used to determine when input internal buffers need
to be reconfigured during streamon on the capture port. Previously, the
check relied on the INPUT_PAUSE sub-state, which was also being set
during seek operations. This led to input buffers being queued multiple
times to the firmware, causing session errors due to duplicate buffer
submissions.

This change introduces a more accurate check using the FIRST_IPSC and
DRC sub-states to ensure that input buffer reconfiguration is triggered
only during resolution change scenarios, such as streamoff/on on the
capture port. This avoids duplicate buffer queuing during seek
operations.

Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
Cc: stable@vger.kernel.org
Reported-by: Val Packett <val@packett.cool>
Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
Changes in v3:
- Fixed the compilation issue
- Added stable@vger.kernel.org in Cc
- Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com

Changes in v2:
- Removed spurious space and addressed other comments (Nicolas)
- Remove the unnecessary initializations (Self) 
- Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
---
 drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
 int iris_process_streamon_output(struct iris_inst *inst)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
-	bool drain_active = false, drc_active = false;
 	enum iris_inst_sub_state clear_sub_state = 0;
+	bool drain_active, drc_active, first_ipsc;
 	int ret = 0;
 
 	iris_scale_power(inst);
 
+	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
+
 	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
 		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
 
@@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
 	else if (drain_active)
 		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
 
-	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+	/* Input internal buffer reconfiguration required in case of resolution change */
+	if (first_ipsc || drc_active) {
 		ret = iris_alloc_and_queue_input_int_bufs(inst);
 		if (ret)
 			return ret;

---
base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
change-id: 20251103-iris-seek-fix-7a25af22fa52

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


