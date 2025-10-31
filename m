Return-Path: <linux-kernel+bounces-880034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E1C24B63
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6517A4F0153
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C13446A2;
	Fri, 31 Oct 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ITBqfrD9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PSOwJcf4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C910342CB3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909113; cv=none; b=FQYXKW8cPhrYkrh3dHUvKvUCVz+XZpRwMhAEunsTFrv5Ran1W0hKKkgJfQg28PZt9r/WLjae32aM/0r+9MpAMcgH24qjIhVJQl/IsurRSwv2W7JN7pSxDxJC9yBNATNND3vPWp3xUN9IpuECAQaPAWLvZowa6mPpkwWJ1Xc+VT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909113; c=relaxed/simple;
	bh=ufRC6nya+mXIwr7nremNqg64sqssA/RBRc870UrHPG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZbVkcTDJUbZuVdMSki28wgM86YjmkS5KDqrdkohoOhEfBKKA/ulK010bQBcU8a/oH2rj5oLLoGBuTF6k5P7zK2Yd0xU95qIoCxAGk2b33GBOd9T2Cb7J9hgLPBdSkRSRiLXdf0RyGZqi6Qja7ChVy0KNDGDtyGvCmjOxnin6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ITBqfrD9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PSOwJcf4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VAL1Ua1572197
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g9goarKXrej
	cnptWKL1a4RoJCaVf4LyjRaPXNsQdL7g=; b=ITBqfrD9KSC1P21llYfAt32W55O
	4SLDJRJ/OtP/QbpirDdxwVOgbbKgAJ+9roauPKElJ/PrmiZyApVfa2fPqIiceJEt
	e2Lt6cd6IH9fwotdxfFyWNuq4vU3gOUuByBYVcXOZy0/s9TULR9ZLsog6Ab8cZUN
	AvxkjxUnlfOpwzogxGbcC2ND8Z4JO8z/QRMEQYqNNd6rXYLr0mswwKZmOAsk8v5E
	bG4SgtRqmmhyKJcc1x1+h24PsAkkD0Eb/q95lpsZEgDzBTsQIgCEZohMUy8GIDxO
	q9bMPZIKH9ThULkQkGtq9+v8la5HKziODr1EpOth0pBWvv6T4c96DXzr2kg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc1cvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3408d2c733cso870774a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909110; x=1762513910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9goarKXrejcnptWKL1a4RoJCaVf4LyjRaPXNsQdL7g=;
        b=PSOwJcf4gs5eXoOUo04bWnSqg1ioJqIOSE1UJqzEfR5sm+qdxji4Hs2nxkb0ooVu2n
         XcN9cKP9MlEZtXOl0dCXBd2JTUk3W6J0JK20GOAJso6n0suPpQLoDdz+8oj2ftslOpsO
         hdc/8LHcMHEZBxwFFyu9Q+0myCh1XCOixDZuWJWf9c0BM6GyYV2toA/3xPp8/CssAMbz
         JX6wMlWYb5mqv+4Wpf3zFNh4LBOqW/WVuLPyI/im98LAheRTyKnXTVXLtgmWbWf3meak
         0gwtRcZY29JRlrRW/7eWpumgqh8CMsU6jp0F75pP0wwSLTCf0sUDXKjJNxcd5hDdQFWt
         /guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909110; x=1762513910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9goarKXrejcnptWKL1a4RoJCaVf4LyjRaPXNsQdL7g=;
        b=J4wcPMq9/nuLSFQ6THF5cUi8yzWiGJdiaHGmNvynnfhYmeuUfoaAEfTf3Lyhjy4z0E
         cMKOG5VVJ5BlAXh4kiQEzgfwu+CzfSupvh+Rt5U4fKIcKieLrWtYO+XsgS9rnP0wx0sA
         9kSrKdAwVaRhHo7qqcL9AQLijMcw2I9C2T87kU2SqIvQudBhAK3IbuXbSenINEnGTyHd
         6yXKkl4adnwLChC9/igCLeKi2ImWe3gCHHfuO3ubWb31ryqM2yk64nY+LSieonz+uIK1
         O/BAnD7Tk1SHRIf0TTaExXvSAlgDrKC0TCITOTdmGQlmpt9Pa74urP1wcGtcZmzpK6+B
         y5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfrNuWYg+IL8gpzX6jTfSqQjIgPMJDQHIxdhf7jCZ+IKFZP3/wvAiugrXzlC0m9F2nWBBoZi4k2ZJibQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWq9Yde+w0Cwn26tDJt0bfJut3jAVeTaf2gn4aN72AvLvJ5Q9v
	isGckhmw9xQXVIHg91fqXqJ+zYC10V6K5luiGrO5PkMwo0BpxmUM3SiLLDJWUNW+I7B5XLZh/HE
	hEnegDjSPbIrTVF5oWWrBhlDopRYloDWH1Y20knsdItBizQ2xX3xxNP5gtooq8Ub01JQ=
X-Gm-Gg: ASbGncsuoiGx3rAzYVRdXSxTn+EUXg3mjS7H/0NTF+eBzXks56mhwMMfQ5sWeUO9zZ8
	dJY3JsTKH36rVTp3lVPYcNArYNmPj8dognSt80qHIXLHESjRM1T+6jp1YtPkGszY9OFskoCHvcp
	k2Ehu41hF2F94eRkWiG+4SFn7D46J8uheKA8+WK0AONZL1nxKXVA5Wnc5gCw+stqqtteaS24TF+
	20smGq9QzhtMcWIxY1SZk9ysedFOUG3c4tucfqFPImNxOyzfwiPrXcT206BoA8HVLKgy+PhkYXZ
	+5j24mUTeLggiXWE5yi76VJGRfqJ0X7b93NL4/jkovhSwCmjG/UhhtpADS2A8kS1XhvXzPKw8wG
	8ywoP7g9AFxqpKELpxf/b3ZgJGYch4BatJAvaedW0oR1YY9rS91pX
X-Received: by 2002:a17:90b:4b10:b0:340:2a16:94be with SMTP id 98e67ed59e1d1-34082fab1e6mr4180238a91.4.1761909109567;
        Fri, 31 Oct 2025 04:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmS685dYTX2Y+vRXMEBcBVp+sEwzT1rSO7RCaXFn4wDl/YpqjIRecwruJfsazVGo4M/YO/YA==
X-Received: by 2002:a17:90b:4b10:b0:340:2a16:94be with SMTP id 98e67ed59e1d1-34082fab1e6mr4180207a91.4.1761909109094;
        Fri, 31 Oct 2025 04:11:49 -0700 (PDT)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e197cdsm1804407a12.4.2025.10.31.04.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:11:48 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: Punit Agrawal <punit.agrawal@oss.qualcomm.com>, chenl311@chinatelecom.cn,
        liuwei09@cestc.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Revert "ACPI: Suppress misleading SPCR console message when SPCR table is absent"
Date: Fri, 31 Oct 2025 11:11:37 +0000
Message-Id: <20251031111138.1262202-2-punit.agrawal@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMCBTYWx0ZWRfXzI5r7HEqOYmx
 0JqGT7K5p42h9PCFTVvoHYHkuYKyja4ZjmyBoXriLl0azXoNfbUb6fZOpOjV1opvky5UbJEQIW5
 iUfnn9dnw85Gajp9ghonsfzwPa7H/I+ZGH4NUA6iRZtdRveKG/N4+g6Xma7P/C2y/RoMcsn9Cyq
 E5/lkmupzp6LoVQgMFJwpvEcu0Uuqg3dWrgdgsImYYwVBNlIgqh5FcyKCwn2M6i+jW+xyh3bNd8
 OqjXpHLNJbI/06Ps9REowhBO5ln4Gx3ijFTPUQxet5TuidP+X8/ByLcOOSBUBf+MEEJcmEfccvE
 ZICxBGVLwLhTZhegCJSnXPk6t17STgGLUaV429wI5rVqjb7ekwW5uZqIQoxKol+vCbjnk/JHe3V
 pqVex/U7X7jUbYsb0PrmklogjadUoA==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69049976 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j6aNjNhqBAspAJ6NNroA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: L1sJBYGSt9wHlaf_bO1Elp62PX62cfNh
X-Proofpoint-GUID: L1sJBYGSt9wHlaf_bO1Elp62PX62cfNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310100

This reverts commit bad3fa2fb9206f4dcec6ddef094ec2fbf6e8dcb2.

Commit bad3fa2fb920 ("ACPI: Suppress misleading SPCR console message
when SPCR table is absent") mistakenly assumes acpi_parse_spcr()
returning 0 to indicate a failure to parse SPCR. While addressing the
resultant incorrect logging it was deemed that dropping the message is
a better approach as it is not particularly useful.

Roll back the commit introducing the bug as a step towards dropping
the log message.

Link: https://lore.kernel.org/all/aQN0YWUYaPYWpgJM@willie-the-truck/
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
 arch/arm64/kernel/acpi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7aca29e1d30b..fd164e8a35b2 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -197,8 +197,6 @@ static int __init acpi_fadt_sanity_check(void)
  */
 void __init acpi_boot_table_init(void)
 {
-	int ret;
-
 	/*
 	 * Enable ACPI instead of device tree unless
 	 * - ACPI has been disabled explicitly (acpi=off), or
@@ -252,12 +250,10 @@ void __init acpi_boot_table_init(void)
 		 * behaviour, use acpi=nospcr to disable console in ACPI SPCR
 		 * table as default serial console.
 		 */
-		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
+		acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-		if (!ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
-			pr_info("Use ACPI SPCR as default console: No\n");
-		else
-			pr_info("Use ACPI SPCR as default console: Yes\n");
+		pr_info("Use ACPI SPCR as default console: %s\n",
+				param_acpi_nospcr ? "No" : "Yes");
 
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
-- 
2.34.1


