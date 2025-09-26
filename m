Return-Path: <linux-kernel+bounces-833938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF054BA35F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47143A291C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77E12F3C05;
	Fri, 26 Sep 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kwgxakVY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17F2F28ED
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882901; cv=none; b=PrzNZYvQHIBDqB+pmmSS9FKmJ7V5CsMLST+bi9Tg6tO5WH5E0N1DtorePuaIBR6UGRqOWvTazwg8d5naxbRWPySwwKgnKZqb8MozYCMZ6ZGRU3VF5R36PckjC4jElYgihfqyJGkwXYC/8sJJKSxXdlDxgyj+CSNNk41h33HzaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882901; c=relaxed/simple;
	bh=FI5Aqb5Hncruftjrq5hPvo3De2xiWzPiqqLPdNVDbSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhq5QWqkI+FDHjzgdjvXD03B6Nb/J38mmXpYUZxkspNYDwq47a/GfeGJxrIEDY9f3GQwDJ1tFE2F1DVAIJOsaRD2lYAFRLLwovXLxr8cBVFsqK4sLPmOq82EGHhkeeskATBO6tUXJyVbzqa3VTGA9eRKysDIYeAtVHkySB/rR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kwgxakVY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q9k3Ng025866
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tQTRPI00t3Iwcmj4XDoWtrkyxihGEGFGUxvVEBrBIuE=; b=kwgxakVY8KcJifUZ
	YeKnMRVPZGZYGdy/mZ0NunAsg78nX9sR8/OeYqsD/HaAwjgvS8Gnsmfah3Jg37hk
	tDG2kTHR70cYCa3T8DBu53eIGRTZdoYBAJzw5A24pkE3130H1WBj5d/4ZB2geH4z
	Co2jg30fey9ptb46WMMgkwnBQFo54RRje+FsBa/EcOeD9rk1gTOJkcxn4NrCJjsr
	V0PYx57j5jtuIcrJGcxNdOC4fd/xhR/SH0MGQf+dDI1deoaN+EAdGZYr130Ml24y
	IAFLOb48W5s3wFgEf2SaXNKr52sHWc6p1cIvMUqJW70JWAmM41A7ShLjJYRReZEi
	8htJPA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49drfwg4xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:34:58 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581953b8so22304505ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882897; x=1759487697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQTRPI00t3Iwcmj4XDoWtrkyxihGEGFGUxvVEBrBIuE=;
        b=U6j6fnaPwyzV5UyQYHGc8fCdJFGscdx4eytZi/wfI2GA4te8h8ql82Ufit4+5IhsD/
         CQ35PAGb8PjBkbmzRbh6LuAr4p0xOno5t2AMRHFzj4GqIioHwBCmqzqJb4eenv3gPr7R
         AtKyXCusWdLpI+XJHQm7ZIRcphSTV/gSa8yTpTAUqlBh5+jzNc5kHiQ+myzUc+1gfMcm
         JioKHHU9JiLzkYg4jKjceesJW/IES33V4x2zv9YsH13jCJI/xWj5OTCdxwMo3qDxKqIW
         2Ncict7tsByCUdQbT8tFyREe1WkRqCXVzJY2ADDuNuSxpWAh2e4COU2LicfvmLiJrhDf
         +t2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYQWBM/e7glUucnR0/H6ugGZKTEWnxsSMPwGOB+5TUKqTzTYsbCx2lsYbyW2voHuqCEVI0nSzPCX1iKck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eSsjU7wvHAa8MvQ+1KZ6rhB987yL2WQ/nVR39OEzPs+TCzuZ
	C9SlqCl7u/5ln+fxWpfnxbindioIJ63tOurz8CYxWMELWT0ylNNkM7KuWngu7nQYHsAJfKOd6lh
	y5TSv16b9P6caP6OkX0uVbT5tJDbms6CquZzzj0NhfCz9he0zv1488mj1hcucSlRusvaiG1WV2x
	4=
X-Gm-Gg: ASbGncv/3ffeUCSHGMMttmAD1/1JIKDix9IxPxec8XW12qiCvAkz28L9LDS2+OK9xWE
	5efIq3yWIUvn1Q6EFia/fjIBdODZxPZDNxUaj+2P1DlEeCzI9484ejPO/csvo+49iI26PHcMvnf
	/3i4PtpYKy09ELTSDyKy+KMDffkip+uAkI2S4TfqGWZRWSSwPOxoyTlDb1Iszu/J4hFmvS9HsyI
	M4AI8Pyoon62v6kkFV8+Y76AspUgRdt+9q6nk8Km17QN/joc5ogMrU5MwzoGiIdz+XjE2GfKnLA
	i+2qoAF7QbVdu6tM+IDc9iCEKa3WGAq6qOM3vmcpZwI=
X-Received: by 2002:a17:902:dac5:b0:27a:6c30:49c with SMTP id d9443c01a7336-27ed4a56ba4mr63933425ad.27.1758882897481;
        Fri, 26 Sep 2025 03:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQZLoB0i5e5XB1V+W3mUt+1umIZGLDWuoQ0hIt8CzKfmnNTqqtoyFHRmb5QyB9qvjJ+QBhzg==
X-Received: by 2002:a17:902:dac5:b0:27a:6c30:49c with SMTP id d9443c01a7336-27ed4a56ba4mr63933185ad.27.1758882897053;
        Fri, 26 Sep 2025 03:34:57 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6aca043sm48950175ad.138.2025.09.26.03.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:34:56 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Fri, 26 Sep 2025 16:04:49 +0530
Subject: [PATCH 1/2] mm/numa_emulation: Refactor NUMA emulation size
 handling to use kernel macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250926-numa-emu-v1-1-714f2691bf8b@oss.qualcomm.com>
References: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
In-Reply-To: <20250926-numa-emu-v1-0-714f2691bf8b@oss.qualcomm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758882891; l=1355;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=ue/wwaSB7KvvFXy+GEu4nRnNm29RUiSGecg7GdoqSrw=;
 b=rjyExsBXaBOIECk/ZHMmY/egev5pzKf9AjufBaupNC0pYEf6wHCnJRoekDqNNspeRaYzk5wor
 /ozwiImd7n8Ab8OEnIwEVnA3SS9QKuVy7/F5CGHPTiIbSS+NqZ+1cZw
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Proofpoint-ORIG-GUID: sEmqdhnz1tPRWh-18NhXmCoaBtUm9fEp
X-Authority-Analysis: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=68d66c52 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Mi5Fj5UnNtvaIr5cJzMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: sEmqdhnz1tPRWh-18NhXmCoaBtUm9fEp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA4OSBTYWx0ZWRfXzxgyzRH9ZAl4
 wzLySEDcTtEUwO0J/GovauTR6D+Vm+gmv5uOtZufbWPLTuYrAbnX4/DnXVca+T5GjYImTvbvL9i
 C23Y4SfB15IIkbyF/djHKclANzyMgtKiTSegj+VYOjGaVvTpg4W3l2AdpA/u5/VEg+tc15/MxPE
 nmZzpm9zn44V+dP6T864AGCwfseba48fsUx1BvETf7pJ8kCUBmpwEmlwiBS8xJSQMv2f8i4E78C
 3JlhsF0UqXDn9UqAxvQ/NYJWnLqVQhY5u17y0iaQCv15tyisK++3OE38TstzYUlzh/aIoR8I7ri
 7geJxRU09bEjhnhJzEk5vgCEFmtypbkVu52qCeVHjE4HqRQqhZ0WldKXcPrk7Yrkt/9kbx+/h6Z
 /TSqoK09Zrkt9wv2IFC5z9HXQ3+mgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509260089

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Replace hard‑coded 32 MB constant with SZ_32M and apply ALIGN_DOWN for
clearer calculations and maintainability.  Update the related hash mask
usage accordingly to improve readability.

Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
 mm/numa_emulation.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 703c8fa05048..2a335b3dd46a 100644
--- a/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -10,8 +10,7 @@
 #include <asm/numa.h>
 #include <acpi/acpi_numa.h>
 
-#define FAKE_NODE_MIN_SIZE	((u64)32 << 20)
-#define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
+#define FAKE_NODE_MIN_SIZE	SZ_32M
 
 int emu_nid_to_phys[MAX_NUMNODES];
 static char *emu_cmdline __initdata;
@@ -112,10 +111,10 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 	 * Calculate the number of big nodes that can be allocated as a result
 	 * of consolidating the remainder.
 	 */
-	big = ((size & ~FAKE_NODE_MIN_HASH_MASK) * nr_nodes) /
+	big = ((size & (FAKE_NODE_MIN_SIZE - 1UL)) * nr_nodes) /
 		FAKE_NODE_MIN_SIZE;
 
-	size &= FAKE_NODE_MIN_HASH_MASK;
+	size = ALIGN_DOWN(size, FAKE_NODE_MIN_SIZE);
 	if (!size) {
 		pr_err("Not enough memory for each node.  "
 			"NUMA emulation disabled.\n");

-- 
2.34.1


