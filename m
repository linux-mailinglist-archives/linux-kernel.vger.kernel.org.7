Return-Path: <linux-kernel+bounces-735318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B1B08DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8519F7B2A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F72C374B;
	Thu, 17 Jul 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSxIg45F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1E1114
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757252; cv=none; b=WMB10tHT4dQ6Jb0KfFe8D10kjk2G5dCW7bmyxOI9Q/UOMQdm0g4lshcrX7IN7NPt0WHfnCiuUYvEoFTKPVh/erJqKo5Fw4XZE1d2QWZYJRQp2lAqhQ0SLEAuSK2g8pGl2b2BiDeVLqEFMe10+0Oxm6EDHAe+W3YOXrpML3auBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757252; c=relaxed/simple;
	bh=0F1kHARcqcek/JZk1Kigy9uIt+1rYuJ4Elk2jvl60No=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lsJN9LE3osG1pP40mujC4qjVdDrAjZcU6GfjyTmk9enj6hdXA3xSCOul5wtpGdcd14SYF/aFyYwuW8s2T/DMRZYLE/O97GHXgyrzITUfqnENZgKZysLik8oqh4lXGAkskaFPTpY54A0lSJZvheFo/u0SCwId9pkZv1jfik5IQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSxIg45F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCNMnn025177
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SGYhux02JkDeCa7bIXWDqxESSxZrWDxZm9RthkuLWPs=; b=dSxIg45FvwQM5cyM
	axuHeEj0+95O3CP+FBMh82/SlkonuknNg2NiTC0R0VKT6iIxFyR2fswcBjEkIJLd
	YWrni3OiCLe0ROTyk9VUDRce5lYuf/bdiHQfGq2uWGvpSRVUj4l25soBsld/T/HP
	H4Mk2Fx/QV/OCXPI9ZKZ898ZmTYcjV+sh0vyMCb68e25xLbIIDnRRMkAn+hHBH/d
	vM31IEIfPdJDLkzAAoelrkgwQC7CrYYevlwBabL/hovkVZGaB7e3U2jU2R1SR20g
	YwLXfdZjL8pi2nhAGX+1DQBH8+rJ5irehQx6lo5laQq4EorZOcqHYYNOGFIG45lP
	JoSQkg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqbwdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:00:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e7550f7bso9303875ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757249; x=1753362049;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGYhux02JkDeCa7bIXWDqxESSxZrWDxZm9RthkuLWPs=;
        b=elJK5ddqiuepz/o7gVTetKuLapClJQav9PgJcDe0lCfiwwRQu+Ixi3AkgF3jr5old6
         y/qJMMC0d7G20f7fE+12X+nQ8osCYvvVuvvecwyCvM9ixK0UpbZ3hkhVLWur9qzhM6mj
         3W6ZumkT41FCnXP5rgHgIscoAaZdGgRBG+I+haHcFQ8eNKCZvhpAI7DbOv2tM7NTn2qF
         1kqvmeVbuTsgG/oPy/InrfDiN+97YSHM/QmbGJgVw+hEuBxuImdpST0anNyptUDS26SN
         Q8QMVYVg+qqoMMyXULM3mawZjFH2GsVle/BJHocYCdLRMV0Dsd4/L/tI2Q+4rjF6H8Tm
         CzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWttezXc3udE1ae/MvkAxWwmMZbLOa1Zfi+JDxrxKjRZz/vD18I2wNLWY4ldWTCLTIdpM2gRjndTrhV0rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVe1f7jBpg05Npv1TCqJJrtV7A13xHOs3xx68zHsG//a5pUNa+
	BDVFjzO/vIdgA3Two8+nseKB3DrvKePO79L8u5TETrQv6sh2Tl+M1otF3HL5QLdSnoLlF7RHR5Q
	Axr+tV7nlBITKnaYw8sBg9oWtWcfYlBWIbSwgtkN5kJBzLSlvq1sH502iDA+AlBpIY5k=
X-Gm-Gg: ASbGncscsFo+g7FBWsQ8M5pv/XBETgmdoeJ94u98kVfoll7uKvj1GtZv1x0+U6hwmtW
	aaGLHZVDrW4xou8Cd0d04qx3+cvdGQKuxXbawoV1zKKrCDRQ0LYB0cbi2nugvlK6GTDTCh2bPXa
	PmX2S87jfaSnZbP0ySiD41c+YpWhUSeVkkYcz6ByzsrSsgXu+c8XOGg/RNJEA7iFtOCExsrNynY
	l/5zaQI+m8Lv6SllJuBhGYcazojXhnmETKQwb/bqaBItj7R4smmAFnwC/OhijgvyRYfs/qmoHY6
	NjLAnC5OV67vQ3QbtK3uYc/XpTcJvfB3EGG9
X-Received: by 2002:a17:902:ea0d:b0:235:ea0d:ae21 with SMTP id d9443c01a7336-23e24f52331mr113997205ad.35.1752757247679;
        Thu, 17 Jul 2025 06:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1kBVO2Ywe21J3crd9hiessDh7ZOs86Yr8mTkNt3GXBW5oVJGDQah7i85OKCnPnB58K1SJkg==
X-Received: by 2002:a17:902:ea0d:b0:235:ea0d:ae21 with SMTP id d9443c01a7336-23e24f52331mr113996235ad.35.1752757247142;
        Thu, 17 Jul 2025 06:00:47 -0700 (PDT)
Received: from [192.168.1.17] ([120.60.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm147179855ad.14.2025.07.17.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:00:46 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250710180731.2969879-1-robh@kernel.org>
References: <20250710180731.2969879-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pci: Convert st,spear1340-pcie to DT
 schema
Message-Id: <175275724382.8776.542107390528988557.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 18:30:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6878f401 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=A4mJK6/VAfRUM2WLv3bxlg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=DHq1HpS8T7VkJ5FY4o4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: b6OEP3THnCvwk3YMQxbXFsb2rF_Kjk-N
X-Proofpoint-GUID: b6OEP3THnCvwk3YMQxbXFsb2rF_Kjk-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX3SED6TVvVqTM
 xIp3nuw1j82X7m6F8v6qIhKE8mzIV6Ul3cefHfNkrxKEAxXxfrF40uB6ScVhhkRjiy2hrjWn510
 V7aeDS2q4+nYohO8C0t24RoVf4ocbYRLPDSSwg+uPwAkOlVHbdgpmT/nCilRb5+QWPdGlNGjQjA
 BFNwjUDywISC0R3lHlv8xBRfxXRLQ3Wg1Fr+Qisw2Ik1WD4C+2RKfNbCb4vELv6ekggWBXbFZ0f
 6rSPnEkUbOE7QySCHX5WI6Hn974RCvRYOfOJiV52FUjn6TRyEOXQhQPraJHSEyr/v6yx1u47lS2
 2CjmpBQbbLBXJCOzlvl6gOTdWfcMwkespV4S8LyZrztevZdLIDUgUY0rcupQ8xxWukcxDJeOFbg
 Dgb47cOKPeF4YBBFHBu1B1tv6ZoIO0j56C6NmGZqNVWAqWHK6wPRaJeoni41JmKwmR54wunY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=772 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170114


On Thu, 10 Jul 2025 13:07:30 -0500, Rob Herring (Arm) wrote:
> Convert the ST SPEAr1340 PCIe binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pci: Convert st,spear1340-pcie to DT schema
      commit: f8766fdbefef2b0ac4c068c03ecba55a111051b0

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


