Return-Path: <linux-kernel+bounces-864194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C3CBFA245
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158DF189423B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C162E8DE8;
	Wed, 22 Oct 2025 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RZhPjwr2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D281DDDD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112834; cv=none; b=b16lRbpGzVn/bsNKGhC0akxYskzF+qaQgGmnCL+wlNsy+HThL9zIYZBFNu4Eh+RxAtTXLh4RrW+goWlTN91sg3aU2EDb1skLazfYEjdX8S5nVRuUafmw9UCS8A2OZBBX6m6vUpdZwsomCiysP9CY31UGE+s6fQ/vKueGkcL/3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112834; c=relaxed/simple;
	bh=yQXrAqjTG7BN0GCsnlOIGGeXITJFR61e1qODGkTt/HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gwLTSZJcLcg2A+Fplzc1jryWwF76V+wQbkKJGvKxzIvwD3Y6MWbavFr4m+gSphhCyStbcl6IGXOevUwQf227bM/d13qLMFTkQZDgwpyfY2hSOzxxyA3W/8UeTv2yfoezKn00BK2ecl3JSoqaBn07J9sY/q2gk+uxY+C6kYDtNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RZhPjwr2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2pJrF005410
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KiHfETugvxtw4u23LQt/a1
	R2Um1zLYjRMwuZfIZP8GM=; b=RZhPjwr2AS5FcoPchY1w4vkn2lFjTmhT0U/9kZ
	Sxlyh+jo3DNgkCy18N45wVqFaUucT5iXD7q9T2nylY8A1qQk0+Vvj2o5kimLVm0Z
	tL6QcDOsnaxYu5AtmI4GoDMSPIF4JS6/L3+tiPlUZ2MYOTy+zseaRCK+fy0q+Pqz
	yKC/x/eFxZfmJV5Kl22tGouhn9/3A4M0IB2EM1Wo3Q0nD3IJhb+wXFWVi9EFKiK7
	jI7Q8oPvWk2+aMcZNmsAyxbgfwEKwUzIPTHCFKZ6i3wWKZxYy6PERu+1yL9bK0jy
	FuYXeDeZdqcy1PNSAvCK7cmI4Aq9N1hjvTMG6l2V01yVBRzw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfkc7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:00:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2909a67aed4so5294125ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112832; x=1761717632;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiHfETugvxtw4u23LQt/a1R2Um1zLYjRMwuZfIZP8GM=;
        b=hecqyS3FwiYYCHMHEng0bwoDlRDdXsVloOs5GghvAREgG3YEijYH8MYKa//8Ax9qvI
         jhJMqwSvE1Wrs3QHtMEG0nHeRvnzesH3X4pOpY1RhEoPYWpgR6IzAIpnmPrNj8Hk4q2h
         ui+WG6HwuxWtw2sbH0moXK8WaSBJtBAXZ8KUKL9deiNlONukpauohQMMJXIdpt74YQjX
         +FVpLkaSaekkAK6/vMXJ+2rV9+fQbnihUyrehEuTAgmflxKaBA8ef7W2zrr6x+XdxbPh
         XXZW4xdrNYCkOo9qsUKv0FTEU7svozkcRWGUU3/3gqDVSORL3qsgGctToxLO6eLvXUAk
         A00Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv0ZzTW5YyQFK65jq3s1kiStR02CsHIixLt/vkueDrJ5Cs1KUp+PtJBYlGnVYlxDz8sGrJ9oEkPO7n8z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRR6MA1Q3IugoeMrQ77KdswzPDou2ogoRkeK0PGR4sx83bvVqf
	FgUWaRhdBLOynGdG9zoLxT+FQgLIjGckc+46r7w/Wu+u45WwxXUM9ZQy/DLL12ttLxfd/NHGoxg
	ANwDzgsZPcywbfVpFC2fxzVGbHh0CNL9XpAUrJ+cXyncU3Yjx6VM3uYGocWiDKjsd6hg=
X-Gm-Gg: ASbGnctRwvKffc53RJ0DtByoVh3ckn8H6sjX9vTFBApcc/Hp1zSI8piHJ1xnsq8GtrC
	IjHbHv2SGdBik8fetIkp8m/v22lnSMQwh0b6oKXpPKMaWZwgw+i21DDHYSAGpt7MKcBMGNrTH5T
	vxhjFTEEBKQn0jthBlo0kG5Fq9bblTXouu41YuUNWOZPtsyIovuvQlzjvoxqE6o/YC0PQwy+yZZ
	es4MnprOfLscCTafBlSltr50ZApDrZig1VO6ai5/DOvmgP5Gjbj/W5koxLIqDKOJW1S+2WQrpfZ
	/6nWGesCTZrzOrUyihNDrYemKIt4agEYIxodzyGd/v/sHG5Y9f1VN0sFSTf2i0oBwW8SDFHYpAM
	wWbmkTG1hGEF+THdbUzyyN7PKUejHIv9SZEALMkA/Cutxi197ig==
X-Received: by 2002:a17:902:f60a:b0:292:ffa2:776f with SMTP id d9443c01a7336-2935e0b4f92mr3968245ad.14.1761112831503;
        Tue, 21 Oct 2025 23:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHGcNB9dXXCmTz01IciMyYl/TMG3cpDkUXuT+VDd0s9/0d0nie9Z1Rw8YNrEYSq2MqvMJ4MA==
X-Received: by 2002:a17:902:f60a:b0:292:ffa2:776f with SMTP id d9443c01a7336-2935e0b4f92mr3967575ad.14.1761112830815;
        Tue, 21 Oct 2025 23:00:30 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc78asm128857445ad.32.2025.10.21.23.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:00:30 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:00:26 -0700
Subject: [PATCH v2] dt-bindings: qcom,pdc: document Kaanapali Power Domain
 Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-knp-pdc-v2-1-a38767f5bb8e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPly+GgC/z2N0Q6CMAxFf4X02ZGtSgg++R+Gh7EVWZQNVyUaw
 r9beDBNmtz03NMFmHIghnOxQKY5cEhRAh4KcIONN1LBSwbUWBmNRt3jpCbv1LGpCI3W3lQ9CD1
 l6sNnN11byZ1lUl220Q1bX7q4YUPgV8rf/d9sNnhX6wZPf/VslIwlV5Pzcq0vibl8vu3DpXEsZ
 UG7rusPC8CqPrwAAAA=
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761112829; l=1114;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=yQXrAqjTG7BN0GCsnlOIGGeXITJFR61e1qODGkTt/HY=;
 b=oEn7Mzyvj04DD14Hb0ypY0Ca2zNr/t4mQzgu+lJDOMJQ5ki76NYBngbjpIw3UtnfNHRmMwEKQ
 0JGMLud1iaFDDd7MCU3zlczY3fJyon08Onj6QD5QQBrNnCeS9hQVhM6
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: rqFCYFDphPPsInbZov2m6t3efF3OW7oA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX2b18MD+xGgzR
 4dEwcPS7zQ0GcsvFaRnunKnk+hsQCyIcrW+ZKFvH054MHylahKGeZY0Ev5dKxpfG5aqK5YgWo9O
 1Se1vGmos0rvMg4gqud+GOMkWIfOLDQk7M39xa27qYadjLYe+a4vARA42yl1flt/IU+jzhxhfMs
 Sbk7KE3zfXIXalROi9P+NIOwlrTsD6iM1z8BUk+aTLFYOMpTqcf2sb0+6aAuEenTflnSDDc/n/N
 wbWBgnm+tMlzpiw/uMar4+igqqAUuu3qYOnSgGsrWFgJKsWaNXLtWyueKbm3s8A0hKW3mTLgw9W
 V1KnI2DU1gCIPc3o0IuBxHmur5StxPxObbkef4tFG10fVQRsWnufd97cIojjYQ6dg2tS+NIu16r
 YIhaF+D+OSjBZrYWMm/biZqrFA6rHA==
X-Proofpoint-GUID: rqFCYFDphPPsInbZov2m6t3efF3OW7oA
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f87300 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=D5gLrYdNfuu7_6MvFCsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

Add a compatible for the Power Domain Controller on Kaanapali platforms.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- rebase patch
- Link to v1: https://lore.kernel.org/r/20250924-knp-pdc-v1-1-1aec7ecd2027@oss.qualcomm.com
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 38d0c2d57dd6..b26246de3186 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -27,6 +27,7 @@ properties:
     items:
       - enum:
           - qcom,glymur-pdc
+          - qcom,kaanapali-pdc
           - qcom,qcs615-pdc
           - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251021-knp-pdc-395e2100d15f

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


