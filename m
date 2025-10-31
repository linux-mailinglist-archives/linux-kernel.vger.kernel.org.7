Return-Path: <linux-kernel+bounces-880035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8BC24B66
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E868735093B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3AB3451C9;
	Fri, 31 Oct 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yl4gSjhc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XFjNrrIS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6C3446BB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909116; cv=none; b=rIg52+/6n+ZguV5ObCFfa38qZp/r/MKSMn1n5vCWN87C57p5Wu36D4R2FSwz/w7D1seI4ZmZoK4B9/qR3QSlkFg17w2RlVyjW2bt5ic/MtaH90UdHlOl/JjxvWndBUepqrOLJNvWLnzyETJEAXCy8jJRZXgLhac9XEhXL6kux3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909116; c=relaxed/simple;
	bh=unNi4t4O8q41lmkNdxcSBwfBebh68e4XTvaE0mO1t0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6mJhPRY0EYAYJkJUhlTopTgicbulmOzGkdInNGzo/eatbBfBv0y/LZl/L8m1JdAbSbrCPvtdqj390m0N0SPswWXduVGDO018q+EOowY+coxRqUhHX6KdMbOLpMX/SXU52YBSqj+XdpW53MrEECL7trxjKOdiRX76aqinQgynvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yl4gSjhc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XFjNrrIS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9jGH81417233
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7Pr9wEMej3X
	2o9II7gEPo6cZPBiBkldPgx1QeDQKEGI=; b=Yl4gSjhc7vyON3z3rQZJfLHPIG2
	vS7lgDxM925dy+7Gl8MRFRwu5zIDHqkdFAIaUqOI4hP9BG2aUCuGxzBpRuPwE8BS
	FaM6S1UD3HRiOCjue1SAFz39/0nE+P/5G0ckQLUULJibJvWs2VIiqwgAmQiG0aC4
	9mTchwfoPsXudyX5utprBdVfB13fAV0IrODzWTs7+2NkuZbqXdYHXUP8RNnzZ5O4
	gWG1SWIX22D7U2T0VORZYPe98LpcfGid+JjOvlC/TWVZF3cW7LcPMC8JN0gBkJ+S
	/ixef7JIpw6dzjkXA3iVCpfD4XDyRHVUQFeefGsAjqUKVmy6Cgj9yh9wOLA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4k69hha0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78108268ea3so2845151b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909112; x=1762513912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pr9wEMej3X2o9II7gEPo6cZPBiBkldPgx1QeDQKEGI=;
        b=XFjNrrISZ0ZtjzlVz4PHxsS/2p+XmOU+MexfNDheZvzavnGm3T/eFXzGF/oAIIOUS/
         bf8GD3fngA/X9qq1Lose/sMcu0nPpDYD7VkyDA8bmPTpsj3qK9dAYAcytxYC8xjfaPe5
         rmJ/5yiGQd6KUAK9Ki8UxPJQ4SYLD+/teo0F39heMXId4SlBAxRq1hlfj6L8n2RHOagp
         ynNIS6ESD9/7QSw1NBjRE+yh/vlPlC3TVmtoeWGvtMabBnTEM9O3nlkWHbqujX9gqx5O
         sja9+Twu+7tqaN0B4IXgcLNON0gSt+TPNUjMYozApXJOPYZN6wEBT63hZDKen9gK+2cr
         Cx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909112; x=1762513912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pr9wEMej3X2o9II7gEPo6cZPBiBkldPgx1QeDQKEGI=;
        b=X1ygKgg2ZSEceWxIbA2UrJyiBq1JzJnnYWcOAhYqVRV3YYfx5DqUBXBVSlSRl4aHmz
         YPsfy5Uqy1xrJnTsd1yd3IRj2N8qUJ3xKrCSjvNaUPQzc6Y6t+h+P9X7l9PeJIdVBvFb
         Wp8J+hKqUWSZ+c+EKd3MV60cKH+rgSqA4XojkQqGqWra/EfeVkzR0quQOjIDedWih0GC
         AM4HyJSY16oV8UovLQ62N7wM+6IYrjD5JpkHtSvTefnQt1V2CcF+8nGRJOAIIYfJMwbG
         JtxtxCusZJpK1jwbs6Yp8YXPyBB5mFoaG31rxyM7ciXOKYGREEaoMdTXEbUXuH69lc3S
         lQBw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdYzJ/1cgfJ0JHQI1OxaaPoiN+2JWxEJVk0dQQjaQdng6v0IAPJirLs18YxHL+6A4IptEADIZ8IQPD1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLw2z28611Ter2DsgQQZjtCCWjQV+hZbTgBtKSXPlYIo3mof5C
	fbwMWjZl9Lgy7GJonAhzEjzrjCvzxs9UvgYzAKa8Yr9YpocnIT4sGKFUEzgabj0+qURBeJaJ5kQ
	fWaR/ZDTzfQ4FeWH8laEB8MG8IhZFJtwuohyhkmWIFTRQ3BfYdeGvw6yLsLGwknHrv88=
X-Gm-Gg: ASbGncsxHBWAn42Kqn7UkfxMmVxl4R6klOxtqPLzf+cEaHYyzZ/6rxc0WyCaf9wxJQ7
	YdvwEl0Cw2NdH/TX39aGU72lFgieiuLQg5PyeqZ8HknE5+syMjx1hkP4Y4P0o90sm6SF2HWlsaj
	FrqGjGRwoGf5vZ/4EAenZRhRLCiQ3df1O2sgiz9DbmlHIdnaQb9wJU3DJtvjhHwa6ajtSI13t3n
	QO17YvCiYO2CKdLeX2+CYxpw0rz5kchSK0hColB7qd0p7WWtsPYu5Xi61cTYA9yGdlyhsM7bG6z
	SCPRvYdflNChnezvyG/jEjY5q+3vJ8FV3UobvcBTEA7TszUwb+gAGqdmT+/WBOz0qErAzF7c2ES
	BNCR5GaMnhUGu619a3ynYvggLprhzRzkEuwzFMBU0DuSLm+w1A0XS
X-Received: by 2002:a05:6a21:339f:b0:2b9:6b0b:66be with SMTP id adf61e73a8af0-348bbd8efdamr4486608637.14.1761909112326;
        Fri, 31 Oct 2025 04:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWLfj2x5i1qCeZnJ9GwmytQhhel2oOQF2WbszwiQBtawm++B3zKJRR7yy6T3mF+lnAgGCuLQ==
X-Received: by 2002:a05:6a21:339f:b0:2b9:6b0b:66be with SMTP id adf61e73a8af0-348bbd8efdamr4486574637.14.1761909111790;
        Fri, 31 Oct 2025 04:11:51 -0700 (PDT)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e197cdsm1804407a12.4.2025.10.31.04.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:11:51 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: Punit Agrawal <punit.agrawal@oss.qualcomm.com>, chenl311@chinatelecom.cn,
        liuwei09@cestc.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: acpi: Drop message logging SPCR default console
Date: Fri, 31 Oct 2025 11:11:38 +0000
Message-Id: <20251031111138.1262202-3-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031111138.1262202-1-punit.agrawal@oss.qualcomm.com>
References: <20251031111138.1262202-1-punit.agrawal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMCBTYWx0ZWRfX64KoepbjAsBT
 bctdLhsSpfSnFnMOh4BaEWPxhMyrEK4BUa6Yg2oXzJKjHHS4SYMFjXVDFPCJD31qhH2ugJl4bs9
 iDxkd01+fS9TsrQD5UHbklmf7RHKmSTTrq0ys1//TFQRpvbL7hAuKqO6dEfPbfigenYS3Lg8EYc
 YbHC0DUtWwbbrGUfbbhl0K7rGmo+YED4rLcsvKtcHbOkDEXhcdaRnRIdn8tbMMAIKnezsg0LH0S
 Dz7gUva9S3/FGQD4z2ROICw2Jo+c/r6m8Oak4jRScvD2qj5w7lGIs9pqoVi100BBnxafXqPPjMl
 UcxWR4+OVA0IuRbAz7th5X31m54imjbR14s6Acsup/iZ599BQPrsuJvzk6pK5w55fxWhB+pA2XI
 OPkuoDM4QQHwacMJM0qqln57QtdmGA==
X-Authority-Analysis: v=2.4 cv=Bv2QAIX5 c=1 sm=1 tr=0 ts=69049979 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7d2iCxtYs5MYwnuMALYA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: mfU817o4ZZwTK9t45swiM1HaDBUYvjhU
X-Proofpoint-ORIG-GUID: mfU817o4ZZwTK9t45swiM1HaDBUYvjhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310100

Commit f5a4af3c7527 ("ACPI: Add acpi=nospcr to disable ACPI SPCR as
default console on ARM64") introduced a command line parameter to
prevent using SPCR provided console as default. It also introduced a
message to log this choice.

Drop the message as it is not particularly useful and can be incorrect
in situations where no SPCR is provided by the firmware.

Link: https://lore.kernel.org/all/aQN0YWUYaPYWpgJM@willie-the-truck/
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
 arch/arm64/kernel/acpi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index fd164e8a35b2..c022c1acb8c7 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -252,8 +252,6 @@ void __init acpi_boot_table_init(void)
 		 */
 		acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-		pr_info("Use ACPI SPCR as default console: %s\n",
-				param_acpi_nospcr ? "No" : "Yes");
 
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
-- 
2.34.1


