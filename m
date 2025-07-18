Return-Path: <linux-kernel+bounces-737107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C992B0A7CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C783A9F63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581882DFA54;
	Fri, 18 Jul 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ELDrK/Ul"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBC2DE70F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853125; cv=none; b=H+h6vuusmf0NuhCmgpnqety2e6FWL7QkYZGuTTc4uop1MCAxuLfhzyyOEC+b+xgFw8wO5VtAMRNZTmVEua818JPcjGrE9ihkppiG8mXL5fK+NnEKU1JwhWImkr/E3qTtcvvGvc5dn1nHQRJkwxd33uk4/YHjWfi8/8ul1HswDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853125; c=relaxed/simple;
	bh=7Jh0ApwfVeGj8KwNOzX4awWIjsQMmQqcBIrdHZKDbRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CtDipG5jWzDkPQYRXS/Vda1LyC+ZIcS+EcZ1T2yP+eQ6jj1PMm2ODOvQoo1PnihRzJoJwM23KX0NjiMdIs8TB6wWIW850NAq4Nb8EFZc3zoRhD5tkXYLYdeIL9KlbhryEtxte4zFp3If6Jn2Daq0sVYuek6VjQ+bRP6/TxXyunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ELDrK/Ul; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IFG81C030459
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=drqirIeVXXEfxAW1fu4y1d
	zsapDY7HV4N/7yaGv5Sls=; b=ELDrK/UlV5KqmHOaEMB3WvW6dsh1Fch7VEfHNo
	AIkkDSvuZgDS+O8Hhn+12RsSlAkNwEupN3d1yaiway8zOJVFkYV/+O3z7oRMu3J3
	ojxE9T6J88TGY3ZCJ7LdNHKw8+3anUuXIKi0K/l9BjmxY6Mni/5yhkNGKylkUXuv
	0BpsgEh/M1/oduE1HzJ56AX0O8FNFopPbE3r4Wl4sUs+Ipf8TjH+qeXgNo77E9lo
	xuWypD/EkbGIRd5PcpVRY5clilfx5gAjbpCl9KD1sG3rXP4VZvSD5sV8+O3gCnuh
	3xiCLMSoLn0NldiSmJxa1tvzo8CNpAO+3Y9l2EbIq5Iw6HFg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7rxxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:38:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab76d22670so41741161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752853121; x=1753457921;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drqirIeVXXEfxAW1fu4y1dzsapDY7HV4N/7yaGv5Sls=;
        b=t/BmM/YnXV2ePE+8T1Sih+H50omoFZysWpAGBByZOcWMjNKspK7ff19BW3kpb83GGl
         XBKP13Qec8gwgor5mS6SmnAz58gFGI82vAOg1UBZozoyv/FGc4RHgFT005Q6BvEeEHQ7
         +8MC6gzgWvMeJeMN0eT2xOlCLosCTU5wwP5xILDPNsKn0HXj/5AZh+/qu1LwWMbwhojo
         2eidjZEAo00Wd16GjJnR5aWE0Y8489erK0sphOsi+8vptFOSe4R02C0nzGVRRNcDfJKr
         tgQ8TwMuwb/mJdJzznuoSPvBCNIy7Kftp7hUTGTZb5t1RdtE286LNHcS0M9EBbuaKGrC
         k6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWyY/7yh+kLQgOf/lV5XazSz2YKjsX6EZNRkTtFdilUprh6ckqVi2EN30LFZlOvwg8N4cZ2K2DRMSESxDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5osrrD86kiNl0mQ/ajZnD3z9gMGMU6BdLGaxePj1oXNIb+GE
	hXsVmRARBE1FKPgbZkGREmOXCp/8D39Od3QFhChaZc6cyMmVM94cgsZbj4mCf0OmYR7X43ZtCjW
	+2RvVnrVnh/wo+DR9qh0gplLFyZfwGbvq6dmPXWeB4V3CfUHWgBDXDwkA0VAqPwDLEU1i4g6qFl
	o=
X-Gm-Gg: ASbGncsT9JWQs29Oj19uFkLfi6bpumPK+L9+g1EypTLyn9iT+K+i+p5Z/oMDEkyK5ot
	Jc8bQzcQklfKkCcZ8yVnjYqifMkEN0lNQpWVEOtLTXYe9KjE0AauHr5XG/AOGFRjvHepLZgZCjN
	yk0vJe2nYs7a0wMWTrWThwzoXKEC0BhEHAOo6B+p5k17TpkVSI7PYTmt7QfqhN4+wUHxbxFHyiw
	+QzYaLXurwAL3q1olzeQw7pZvllapI32A3kwcWBQ83/V90l04pdkfTYAyYO/7wZXyguU4ZzeHQg
	5wvLxIWy19d2AoXxfm4Ra/VbbCFmSGILO2QrfCADYiSbMBD9l0V5EYAoAik7bVSCQiUx2Vy+Dtf
	6yJUPAQKjnYIGZmglZWqKslifH8rjr0UGN5zQ8azjjAzwMepPMZN5
X-Received: by 2002:a05:6e02:16c7:b0:3df:4cf8:dd50 with SMTP id e9e14a558f8ab-3e282ecaaf5mr115300145ab.19.1752852717973;
        Fri, 18 Jul 2025 08:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcnPvBctrIOobI5Y6udYDD0b/geBcKaa7wSMklKLg8ppUEyhKsXeNxAsmArw0cImYApnAJxA==
X-Received: by 2002:a05:620a:27d1:b0:7e1:68e3:712d with SMTP id af79cd13be357-7e3435f77d2mr1326292485a.31.1752852340559;
        Fri, 18 Jul 2025 08:25:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d994csm2466821fa.84.2025.07.18.08.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:25:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/4] arm64: dts: qcom: sort out RPMhPD domain indices
Date: Fri, 18 Jul 2025 18:25:37 +0300
Message-Id: <20250718-fix-rpmhpd-abi-v2-0-0059edb9ddb3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFnemgC/12MwQ6CMBBEf4Xs2SVltUA8+R+GQymLbCK0tEo0h
 H+3knjxMsmbzLwVIgfhCOdshcCLRHFTAjpkYAcz3RilSwykSKuqKLGXFwY/Dr5D0wqSsbqtWNe
 l7iGdfOC02IXXJvEg8eHCe/cvxbf9qap/1VKgwpOtiUnzkWp1cTHm89PcrRvHPAU027Z9AOrlt
 V2zAAAA
X-Change-ID: 20250716-fix-rpmhpd-abi-2ac5b7e5865f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7Jh0ApwfVeGj8KwNOzX4awWIjsQMmQqcBIrdHZKDbRI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoemdyXisrXLgSiWLqKDSy19GhFXIva6Bm/jmVf
 mwBqMiWncaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpncgAKCRCLPIo+Aiko
 1Z1LCACGrgR9N6FbDNEby8b4CBiYzcdPOouKFSsS/EGXZtqsZVOrWBbyWryRC76OdFlRm3vuBxt
 hg9hO6yLQbOIP+2Y0CX0z/fzB5E1xkvGHJWJv5CySBljPs8+nAZuIUBNuDhbLYDxCcrrM2kek21
 csaOMxuk5YEsODJ7xJOteotj3WxcBEDbMllauC1f2ltTz0s8rtTWKm399LCV6GTKcWHFz8NlM02
 +oGbTTPEqHUC12MIBPGSgcB+KJKzULIYhEwAriwXfOtuoE+GnBIVCA7rOouCD1C6SILGYqvKhKV
 rhhyr1rIwlfwRNtE185CNUkpNLBoa0+/mEYKGg2wJYUHY8PD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDExOSBTYWx0ZWRfXxBYyGuL2pWse
 GRJ3K6mb4vrOGLfaZXKHWRILmj0d7RCTjjdHTQgn5n1xRbMJ/9m9fkMQ/i5vgXOiLmal+yo7Oey
 5mBMrGL7iETIAOlIFudVHGOlewnSk9ZVFHwQk7JCG2nUrCCRaJJ+FlSUIoxp/qtBBVYGSMITUSt
 a3qdvpt16siMk3AsmKjQsGm+o6p3H8RpIGcSalknAkogChNVN4sDykodz3reTct2aC7nePBRHt/
 lHhlXOxTc+pn5V7zOy+W6iYhQWz80DOPSdxz9iX479mWASiucch++GS48bU3tt7GlXpSJl38hf5
 hHiPDRENV6y+GG3D0DUTd6xbPGFSNZavk4peNJa7nmqSC0x+YK6Do2t4Yfh8ffdky6QQz2BDRhK
 tnGZHPEUdA3XC5iG15XNLFK35Yl2X5lUUICZS/VsURRVHVKydLWVp7px8tz0uVYlLrGHoY9J
X-Proofpoint-GUID: x8u2d1ojKGq0q9l6GLygVQ6bjuGk8lhB
X-Proofpoint-ORIG-GUID: x8u2d1ojKGq0q9l6GLygVQ6bjuGk8lhB
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687a6a82 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bJKr_GLULl7BGc3kRxwA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=595 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180119

Several Qualcomm board DTs either use incorrect power domain indices or
use old defines for RPMhPD even though the platform should be using
RPMHPD_foo defines. Correct all those issues.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Fixed SM8160 -> SM8150 typo (Konrad)
- Made corresponding commit message more obvious by specifying indices
  (Konrad)
- Link to v1: https://lore.kernel.org/r/20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com

---
Dmitry Baryshkov (4):
      arm64: dts: qcom: sa8775p: fix RPMh power domain indices
      arm64: dts: qcom: sm8150: use correct PD for DisplayPort controller
      arm64: dts: qcom: sm8250: stop using SoC-specific genpd indices
      arm64: dts: qcom: sm8550: stop using SoC-specific genpd indices

 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 25 ++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8150.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 42 +++++++++++++++++------------------
 arch/arm64/boot/dts/qcom/sm8550.dtsi  |  2 +-
 4 files changed, 35 insertions(+), 36 deletions(-)
---
base-commit: 78a8f8d4ec2bf09266a03a0a8cb0af82da0766d5
change-id: 20250716-fix-rpmhpd-abi-2ac5b7e5865f

Best regards,
-- 
With best wishes
Dmitry


