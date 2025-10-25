Return-Path: <linux-kernel+bounces-869925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2CC0903C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AC1188D816
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85F2FAC15;
	Sat, 25 Oct 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UyG+RMzO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD72F9DB5
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761395350; cv=none; b=S4Ep/rOuc8xGburiJjrmbRjISHFHLTeYukEcfcGFNBjxZOKjqIRDKQRDZ2buNhP1Q4cxIfCkzUqWmBHUThPqSi0nVAKeAtdD6pGrMAMmI6CRVL6f8cSowHgikp6nSni797mVDPjLc8qaz3dA3afZSTDbgzt3IQp4rUZ1OCgm8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761395350; c=relaxed/simple;
	bh=DdAra/cZ1u9bNfmmdm5GVrfXJUXNr6ACdJxrNyHNLJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lP/UsYKEt2YemQPxJ0ilW4zCMWXxp6d+Q0CZwO+DxrCtyfSE2jVnZpNY2SySTCsahGgHLpiFDCYNVyaQou4P7O+dM0rkBnr7ZY6c1OAQaMG7XYjv6RO3d9s3ijJEaEpDmbYWk3IsGGJ0ak9M8Gydd72vtHqu4CN4Qq/aqNFHbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UyG+RMzO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59PBesYV1144215
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jFjL6anUYqjYCKqp1WFhPwx70zokWMYl2Sb
	tHR8h0po=; b=UyG+RMzOvW2FfswEKKUGeXZBMILVsvyLsFBXUlyj6ZYjy7+LPE/
	Zj1Zpy9gbMAtTlTH8tY8AiB87QFEYzDjPXc/MLT8wlJfOBqM3D0+nNp5LOoeElJG
	9LNEXheZqbBi//iHKnFT9yCsdijb6wUdcT9ZYnNbZX+iA4TjTouuUPES+TlXsFsf
	r2u0njbRjCU4B5jktN8gkcqbsSGsNAb9bQlSSQFYS/zr7aXOKwhtB2QgQptZ/UXx
	NFLbdyBRLA4pIK3oIpwmMGl/JqLVa/b0WkTDwkV8HvWE3XDH9zDJWzCHyCC6NyAB
	ryoRCMQJxJphqBuEGt7q836ro7y3KvyfBvg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0qqgrg6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:29:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2930e2e8e7fso26846275ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761395348; x=1762000148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFjL6anUYqjYCKqp1WFhPwx70zokWMYl2SbtHR8h0po=;
        b=QR9ar/jEk79AsaSQB8ZmLRD/5cH6MzcEZT5+iqaBZMMD2vSCiLYrb6NaqXhVSLsqBU
         ZQ1kR6ixE0PPY9OuKYGx9hpNLd6minBx1KgcGF0MVWothGvYUev5cHH4JjoetMb5zIis
         Fi4hftmz4MByHrJD1jZxCiUcTsRBLgwaciaDppUad9EQ8VCF6139EFud3x4xfYCJP5bD
         PR6VQaA9f7OKaRWVoNoQaH3lL7ItkINuenjZ1sspcCb2r8B6oEf98TmotsBIKm/zgx/b
         /5uoZwz873inj3WEdLR6+pAk8DHxMG8ESYkrAyFN1+LCDoL5aZ2JU2D43JCBp0Ox5K1W
         9huw==
X-Forwarded-Encrypted: i=1; AJvYcCUDxnSGSoH6168sdl3YUEkMu4St9iXBiBftag/jNjRBknHDJ+aP6LFfzyvnJWZnFXxnLKu7zTRwzjpuvoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NbpVVUjq+l+T5hTIGRoQh0al/YAFsQbQyDr+yohgLbywv/lf
	NKncpfmxROp4ndiz4kQ9F+EKTzmcxx+mFQEgR6E+1aeb6gjH3uKqgET0r0iWWEXTArbDyirACvQ
	tMrhDslF86jC6s+3BWH3MUE/2estjvxkpFcF8Y75FtmmMGheHp4idhWssWyJNoxq+snA=
X-Gm-Gg: ASbGncsLnxrBZZSvZFk4UBwEan6+QAvSzrJbzPVD/0YG2RYIDWJ3Pso1w6Ygj2PydjO
	MAWSM1GmTjaOzd+LM8oiwOpBPq8i81njiU4DhJyvYVVHu1c6z95JON/0oUaTH1JH646ZimKISzt
	eW6u/xm+XugMUgQN17DbN4LRWPQ4DJ7LQ5zOyJ+qsACAfgcsoe3UtpZt+X8AT2yqJbaIeC/Cq+6
	eDmF/fmcCTJlRBYhpCXj5r1YtFwamKgOU2gQewdBFXffBblnPD5VYt7+tprJUMwMvBbksY+wVap
	cAxdOyNXmhEzd0o3aZORaQkyQ1oWQSu3vfTIdE2HAPgYGsULumXhlHb5Coo4zLo/E32ogHVM+Sc
	WDw8f7C4Tr3NSmmBhAMF3TCdqrrKtfxGiN9mh
X-Received: by 2002:a17:902:e5c8:b0:27d:6777:2833 with SMTP id d9443c01a7336-290cb18415emr438839005ad.47.1761395347594;
        Sat, 25 Oct 2025 05:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmK/7XH8hwV+wlEEuVM2Y8daSy1zdYSeunyjNJlaPwPnI6EiEv3JrxP7CA43TGJk//ZbV66Q==
X-Received: by 2002:a17:902:e5c8:b0:27d:6777:2833 with SMTP id d9443c01a7336-290cb18415emr438838775ad.47.1761395347097;
        Sat, 25 Oct 2025 05:29:07 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm22381325ad.48.2025.10.25.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:29:06 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Implement vbus support for HD3SS3220 port controller
Date: Sat, 25 Oct 2025 17:58:52 +0530
Message-Id: <20251025122854.1163275-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UChiRTJtg43uufsSeZasmvJoQ-RUKljT
X-Authority-Analysis: v=2.4 cv=ReKdyltv c=1 sm=1 tr=0 ts=68fcc294 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gs8g10pPhjI8XjwtQ3cA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDExMyBTYWx0ZWRfX30K5j/ZZaIVT
 4/udIMiCFuh6QF3gDDQtGxT4zisjy4ijiYyfiw+glARaSB6+imHvmZ8dyoDsL/8IIXki9H94y8s
 mVEK+lbX5Ogk1FSIUxz3uibmV1iDFONdk7bbexPsonab6duL6g+PLGUJojTuOJzKEUnu3FTIwfF
 k3O64k0IHu7raxvmkHAzHGFlThhO/RZMw+n7JNMAO5ayJ+UeSKTJLUmTDR7lWACLj8bxRDW1kzW
 eV2eQcEVyFPu8GwMrbwiHg/7OwEphB8Sx5wjf1CIXeI2LAvSJD/OgqBHRLSuukGLlmKEXjJ27uu
 0wcjHgkAbZ1GigDw9J1Z8vGzszHlpTPNc1QAplhVhl9GmkM/LooyjrMh3rV8Ir/viZNb/0wW1nv
 5I3mIGBzL9Gv+m17xtMjUujqmgib7w==
X-Proofpoint-GUID: UChiRTJtg43uufsSeZasmvJoQ-RUKljT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510250113

As per the data sheet of HD3SS3220:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

This series implements support to read ID pin state and accordingly enable
VBUS.

Changes in v4:
- Modified logic to check for vbus supply. Directly checking first remote
  endpoint.
- Used of_regulator_get_optional instead of of_regulator_get

Link to v3:
https://lore.kernel.org/all/20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com/

Changes in v3:
- Removed vbus supply from hd3ss3220 bindings.
- Implemented getting vbus from connector node.

Link to v2:
https://lore.kernel.org/all/20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com/

Changes in v2:
- Fixed inclusion of header files appropriately.
- Modified commit text for driver patch.

Link to v1:
https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/

Krishna Kurapati (2):
  dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
  usb: typec: hd3ss3220: Enable VBUS based on ID pin state

 .../devicetree/bindings/usb/ti,hd3ss3220.yaml |  9 +++
 drivers/usb/typec/hd3ss3220.c                 | 79 +++++++++++++++++++
 2 files changed, 88 insertions(+)

-- 
2.34.1


