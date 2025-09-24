Return-Path: <linux-kernel+bounces-831441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADFEB9CAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1683A26C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89583298CDE;
	Wed, 24 Sep 2025 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwuBS3cz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627328E9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757356; cv=none; b=tv4fApZqoo4AHybaQV3uVilLN1BnY0U0pIbq94G/XKveeZONsElkESg61HRRsOUsAKuqoO+IlvV6IlXy960vKpcIlvbMeEtH9/7lMF7A01nr9IQFNy8wusEml4lI7agZ3ssfSAuClGNUL5RdSqpOoqdTzQnEoWunrAsSO7aO6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757356; c=relaxed/simple;
	bh=jC4ARk4/BGMQkPobGqNsBp0H9jAmYJqjCkipkBKj0c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oF4+B+fn4bFdURj0z0iizLAemkniyP/nUdXFtVzU046P1bpUptkuo8FssYeyeGe51GkcyTrCRK6IrtGBBazAgo2IvcPyKvUDs+kg5PCg1hzfppG+Yt58T+RZDepNcVlnb/K5K7sdnRcenlbuB8um7mhEF4biQl+aZgAQZRqOEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwuBS3cz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCoZHc016452
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Qol0uJ/DjY99kV2fcBZLPu
	bkOcStGcswt2KRkk/UfFk=; b=NwuBS3czIexMJitB1kHr3SK31DeAKjuitWevU+
	dccuDvx3KE2EU8surtCASLGqVOnH5ARE5tKjlsZK6zVQs89nKkMy5wnZ4AOBXtxM
	bL++h+ykwT0vAu8ABnI1GUEpl8Wohb+JFM4b9PuDvzhiBh0MpmFj9IHDMjJ1p6jW
	xrQCiF5JBN6OTo12JkVThw/41RAltXCgMJWrA2Q/gCN5NCTQZAyTicavoabzgdjj
	Dgf+TOPukQ52Kjk5zXqc3ZOrrKnMj/eww2oplCznrlm0EuokPWskbs6DeN3UgnXK
	3nLM04z40MUzfMEKewtxzvLEVaqEhA9ProopwBmG3IonQ44w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhvrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:42:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2711a55da20so2347565ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757353; x=1759362153;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qol0uJ/DjY99kV2fcBZLPubkOcStGcswt2KRkk/UfFk=;
        b=jSUa3e4FWkmWSFRq5phqmJkZZ4fhHBFbJ3AHd+nD97aQgJJykvxhuhPA+lPayCM8Xp
         gtENd2Z3NWiy5o5sYpYDOXO5EfScOxmM18ZKVyBMizLkQ72tkUmMj1kTT1qbY7GJfW+i
         X3+xwLscqY3lYVaQEwoLkSg4d4Cg5ZGrrT7gtj00A0TfVFIYzbcuqVHgGdxjMI9hUwWL
         XWl57jidUcjERMPpgPvsXhrh7CSoA2LHqOgoBrjbr0+I8elE1eA03WF1N8PiOWZHE0ns
         WPJ1M3adYkXQSO3n4JwB895zxhs7LBfxIzcr4e3olwE3yeRaCmrgCMN2YKpAXINClU/0
         /F8A==
X-Forwarded-Encrypted: i=1; AJvYcCUpLg5yhDhDr2kGcVv3ezUi2bzn8fpn33W2ZHJK9Ni32bduOq5rK82+Wvr9vE3rA9+4GGR1+fZfzeAn99w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Zr6dXwfqKBkeq6rGoVA50cL9CAQRhaYMLrd0oUOmd/XYMg+8
	o1YfUpTUIGXO3yeMQHd9ElS9t9TOHypv9i2l1CywpSC07JVfYQGmk3z2neWMRbl+DWWO4q+vm+A
	ArUDNyxH6RI941VD2eDIVjmRwoqcVrRkf6rf6sS3vihmwVFVFnlkfBzymaytfR4hpyZo=
X-Gm-Gg: ASbGncvHJ1Qs7xBWiw6WB90T0yXdUFZgznOWtU5olCobduf6FgkBGhXJQ8nZermHfMH
	tURZhWn0K1+ULqVe32/Jr2yh+ooDTzogtSk+cysdVmxpl1KIkZkVer/G3dET+C/zmtCFxisDJhC
	Unv/Vk6OWSXQJMyfdXK317yAAdse8AX5B2q+00k9t1IsGWKb0n5rLIHtPHIKc4GwoPA0pheHYL6
	guUCjWNRjB5XnRalzl69/9JfsbBWVw7fBf3Sj0pojGGh3wTBMV8lSxe2UbiExpFyJc6LCMzYUs0
	dxhcjyiFOQv5ao1SYx7pVYf934zc2Im8J5yVQS55DFnFH73Twc3OfWc782zTE/WyrgJ89GWhb3y
	ActQvMC2fCZ8V3Ww=
X-Received: by 2002:a17:903:3884:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27ed4a76e00mr13607115ad.37.1758757352995;
        Wed, 24 Sep 2025 16:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp0ELExHw39ifx72JdOIvm51XVaQYe4XvSjpj7wId74sWV9ba8kb7eCIuoI3H4RYdXKNqZcw==
X-Received: by 2002:a17:903:3884:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27ed4a76e00mr13607015ad.37.1758757352572;
        Wed, 24 Sep 2025 16:42:32 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed65e8e89sm4984905ad.0.2025.09.24.16.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:42:32 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:42:26 -0700
Subject: [PATCH] dt-bindings: spmi: add binding for kaanapali-spmi-pmic-arb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-spmi-binding-v1-1-b4ace3f7a838@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOGB1GgC/y2NQQqDMBBFryJZNxBH1MarFBdJZqJDSbSJLQXx7
 k1rlw/e/28XmRJTFkO1i0QvzrzEAvWlEm42cSLJWFiAglZpaOQ9rjKvgaXliBwnWSO0iOigdyj
 KbE3k+f27vI2FrckkbTLRzd+jYPJG6S8mejxLcjvtU3VLCLwNlSFAUKp0+w7hqhtyxvvSsg325
 HWtlXHKdmI8jg9VEEVaxwAAAA==
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757351; l=1290;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=jC4ARk4/BGMQkPobGqNsBp0H9jAmYJqjCkipkBKj0c8=;
 b=bUOmbq9O7Hpb3ld92WPfktpqQhKSchaIuN4V/NH9ki9iiYHe2NOMscIvmZ74sqhTYAcAyAUdv
 DNjGcAJpk9KAFn7Ja8qj3RSgxcuYgaBewlHn0xoFi9kHwCv4YHKPBco
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d481e9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TXiNhvdN9S-nxoxCruEA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: LsHw4c1OWefam-EPz93iKaReoWA9XMky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX4ki9c8ZpfRCO
 nWAHSiOw9HAkkER++EGrxWBVpDZpiN+VxxTpoSjOJKi4BZJMJso8tLjGuqQGvcltRgj61IVucUI
 teJCVqpkKC80uDppHBS44pv0hQRjPiKNBWFcO+1Udo8t430zthqSFPzNnGHcP9/UUikc4TpAXxn
 LJrFqwavDEm/8ViipAujEugsio5GXjBbOfBeGN8FxdpqaKzX9ZUOwZJemakarVe6mJXYtnABhGy
 WX61Sma0wWEMU9wMVEHGchveqNe2HSkM1gd96SDThesQ/Igx+dgSndqLAFvU/9ShD1jnfQ8B9vi
 Dp6txhGiK2FY2O0DjH+F4XEAQWof1csN3xMAdTm0SXU48MdMU1WhccgxortGanEoXz8I+rS20ld
 ry0bM4f3
X-Proofpoint-ORIG-GUID: LsHw4c1OWefam-EPz93iKaReoWA9XMky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Document SPMI PMIC Arbiter for Qualcomm Kaanapali, which is compatible
with Glymur, use fallback to indicate that.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
dependency:
https://lore.kernel.org/all/20250919140952.1057737-1-pankaj.patil@oss.qualcomm.com/
---
 .../devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml
index e80997a5fb4b..1d2424f27b65 100644
--- a/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml
+++ b/Documentation/devicetree/bindings/spmi/qcom,glymur-spmi-pmic-arb.yaml
@@ -19,8 +19,13 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,glymur-spmi-pmic-arb
+    OneOf:
+      - items:
+          - enum:
+              - qcom,kaanapali-spmi-pmic-arb
+          - const: qcom,glymur-spmi-pmic-arb
+      - enum:
+          - qcom,glymur-spmi-pmic-arb
 
   reg:
     items:

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250923-knp-spmi-binding-1d25dddc27cd

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


