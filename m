Return-Path: <linux-kernel+bounces-871811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117C7C0E6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851E1426A27
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC4307AF8;
	Mon, 27 Oct 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NOAzgqD4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB401307AFA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574789; cv=none; b=NDGgDz/8YHxgeS9jQSt+ICDSkydSgQvJ0XvzQ9uYBur3nKU/7qs3nkK1mfm3Ug1zR/WIRd/hF9XslqVB4VRTptGeNDq/qZ3uV7kgGyZbRzL3ngbrG/VMiLHXnXD8c9qGdhoddGmAPpzNrgp9GfzBvxhs1P5Zd8+Q94K0YeBgnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574789; c=relaxed/simple;
	bh=/7facjdCL08Vbw9gdN+xnvHVtCxamtX6fGVaVoeFdB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XIlMD/bsOyKkLAXpfhqB8tMdUTSeukv8URIABQdxM93p9+gQG5LJWP8yFSs0xqs6IbzghcASZSutUAavOiJorVjtRW9rt6QwfiYxJP8KYvKFaugFoO+dr7yNR8EB1G8qbSiO6VXQiwmIzfV5v3Ay6VS/8hi9INc23xiMiW/1Fnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NOAzgqD4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R84ulV2232337
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Qx3IUO2E6Fo3l/9N3ni/fAxMLk1Wml7tG2+
	eTCjaNAo=; b=NOAzgqD4d3Qm0rgFqW2gYYImaUgP5bAXwQAokDWZ8d9tZ0EHpl5
	ac0CwZLOT6HFA7iP1vvjzII4xDZDf8InxfuT6Q1Kb+LbBa4NG0cLMoyiL41w9Ds7
	x+5n4n0+FuM4bUNbEnbgNj5dDXEta8m3/t5yrCWCww/q15zrBUlIN+1megJo4Did
	gI4nBp/cH/zRw13TaHavPBqWCQjk65VLpLiRAZsGNuQodRDGllfwZ6zSQ2SxBbza
	QBDJeqqut2j8WWSiQKrCitgRF34zXOISWMeuPQEVxexYI6csE+p3f641piEorLjK
	ed18vEous8Kiz8Ms/oEcg5p3RDeMsDhvsPg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wn926t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:19:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340054800dcso1871800a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574786; x=1762179586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx3IUO2E6Fo3l/9N3ni/fAxMLk1Wml7tG2+eTCjaNAo=;
        b=TxicWVYmDNJipoyKWtvXaeE0+LvFqesWj411C4cLY+KXCtcqKrQlsOkPKqHaJqgI3l
         t1/thQbL3WkxNwDmmZiF7jTfOISwcbrf37iKs1nPmPzTbR5zrBT54SCRo83gQiNqd+WL
         NPP3Q3UaY6kLT/oEs9bfq7lV5qNnuMwc0ALeP+7zfuE5VGoVYxpBkM7jK4EMmuDqIejA
         Ki4yBia+y++Xy5If9p6nN4XgWOQgOPo9IOatiAddxAqzD4Fb/PlUZwGQYVH7bRmTshvL
         P08YRi7XOqlaaO58PX7Gg8D+CishsBiu5x4o8esVvDccK9bWeTPziWCXU8ZwWrPrwJDC
         c6gw==
X-Forwarded-Encrypted: i=1; AJvYcCX96MhLb/Zw8jY3JrFW/WbJH9pyavLy9qMYd0M+XWRpcVDelTfcJW1+/7NQmmjoX1DsOEMXxL3fZlHu4JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytZwzqYJ6Pov5jwA5qjTlLffe4GOW8+1nhEN+2U1YTVOw4Jpcx
	+ZGN3h/MC3AWb2Nh9drLnH6qPHBBFGBDYrlkP2o9vtsHIKc8TgbnYBtcr5ZY/PZIv4sfLnLZyCC
	XdLOskoYGM3G8kN4z/Gk3XSr0SMviJemKAa55GtTORPOrd7S3cORGWtAKzn8CIGTCDcCYJwxaLK
	4=
X-Gm-Gg: ASbGncuxfbGCS3wg3861mH8T2UCeAXxObAr+DVfVyK95jAx0RE/yc83gjxYwZDW/1Ua
	60Uw2A1PQSgxibVY0lnrBBpk0lcz3fdSDu/oblSi4HKGuOD2m0ZBb1XUacikajbv/o/aP+8OkoN
	wZOUO7GKVWXB7KIttxFHmp6Xijt3R4WC6jzc9FcspoOu9txVIdzX+se3tb8+sfHAE04gxtgW9l6
	FuVwLK88Q9g97FA/cVdAhyXKLtJK8DwNVwGPjCiKtfqlv8bHqF2JNcbW21wOw5rtCIkmkm0lhTi
	FMLFwKbtrvoKkEMmFaO5bHN3kfRvetEDYzf6UoLz8qg3ew8Sk3Qd+5XsO95mJdWZM3lRQZCemU/
	i5oBcX5XXPT9KblcwvJkUk6DmGZW5x48z0+w+FJM8MNCTU2u098Ru
X-Received: by 2002:a17:902:ce12:b0:269:4759:904b with SMTP id d9443c01a7336-294cb6a76b9mr468685ad.58.1761574785264;
        Mon, 27 Oct 2025 07:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExvrfR+k2bxHu4WE1FcWWwIJx/pEgGfmAedtlb2r0MJvVY54fZi5aQUGEv1i6ShpGJ4LdyIQ==
X-Received: by 2002:a17:902:ce12:b0:269:4759:904b with SMTP id d9443c01a7336-294cb6a76b9mr468395ad.58.1761574784655;
        Mon, 27 Oct 2025 07:19:44 -0700 (PDT)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d230basm83818175ad.46.2025.10.27.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:19:44 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: guohanjun@huawei.com, chenl311@chinatelecom.cn,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH] arm64: acpi: Fix incorrect check for default console message
Date: Mon, 27 Oct 2025 14:19:41 +0000
Message-Id: <20251027141941.3089914-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=68ff7f82 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=EWBPczn9GtEGnfwowZAA:9 a=rl5im9kqc5Lf4LNbBjHf:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: hD3pJCn1gSelhzI12ILdmQf4boy3m04o
X-Proofpoint-ORIG-GUID: hD3pJCn1gSelhzI12ILdmQf4boy3m04o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzMyBTYWx0ZWRfX0TY7AVaibEPX
 uWJ0gd+8KlPjRQHsPGwE+WBBMfXtCcdKbzhZ5t8SrcH/GBIwLITm5TdKixKblYHk0Ioo+ZbPrCP
 +sBPrRfpoOidt20yeBfQ7UzHP0qHcf85ywe8lJFKm4HWZR7j+c5Nd5Y1076rwkr9T6XKypjgpuB
 BLt00F7JvpBKhVmnSpz2Er0eCGVwU5K/Jr0ZWpYy/jkaCSkEfheUL0dqBCpk3Wljvx/qThDgzMp
 V/SbC0OKZXwkF0RrkocsV/JTjsdfG39ZUWg8BhEJFCQPwPMB3312pwD0XvTM+5UBH4u5UiIC5Aa
 EGT9eAmtV2ZGx1tAJxJ3noyFc7oTjS25DzHCzjk9vjudzueoiUFuDVn4XDwF8xnfb6z/XpKcUeA
 0W2oXPIaupPjQnFw6dXHieZVuQghGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270133

bad3fa2fb920 ("ACPI: Suppress misleading SPCR console message when
SPCR table is absent") mistakenly assumes acpi_parse_spcr() returning
0 to indicate a failure to parse SPCR and prints a message to the
kernel logs accordingly. In reality acpi_parse_spcr() returns 0 on
success and -ERRNO on failure.

Fix the faulty check to output the correct logging message.

Fixes: bad3fa2fb920 ("ACPI: Suppress misleading SPCR console message when SPCR table is absent")
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
Hi,

After sending a patch to fix incorrect parsing of SPCR[0], I was still
seeing inconsistent logging on arm64. The result is this nugget.

Considering the pointless churn - I wondered if it isn't better to
drop the message? If others agree, I can send a patch (and revert
bad3fa2fb920 while at it).

Thanks,
Punit

[0] https://lore.kernel.org/all/20251024123125.1081612-1-punit.agrawal@oss.qualcomm.com/

 arch/arm64/kernel/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 7aca29e1d30b..2fba72d51d71 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -254,7 +254,7 @@ void __init acpi_boot_table_init(void)
 		 */
 		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
 			!param_acpi_nospcr);
-		if (!ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
+		if (ret < 0 || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))
 			pr_info("Use ACPI SPCR as default console: No\n");
 		else
 			pr_info("Use ACPI SPCR as default console: Yes\n");
-- 
2.34.1


