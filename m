Return-Path: <linux-kernel+bounces-886638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F388AC3620B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A09BB34EA95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709283254BE;
	Wed,  5 Nov 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkxSwH0J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MhRwUca9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF25310620
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353780; cv=none; b=LAfXR7Q8ZbqjoRXrlWLBHy/r7dnh/TomufTnwib2gpx+xWwg7fNv2GPvSjpcnlX4e+ru23QWduthun9Im14qZ3AellzPf8Su6VJ0MJSaPle2RemzeXiZBD5AwB1HK7f0UnRmmJr4lWx0U/opf8/jkQ9gTr4+5iYAEYBKPqiCcH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353780; c=relaxed/simple;
	bh=GwlUy5ylQ1Pv0lfKzslittEfdt62+GAqpjfgfGHQJt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCFyuEhTa58rygy7kJGeyXxdWvzUVjo9ahW8UsDP6TO8gKn2Vw0ivZnhjwo9AukkHqoiD/ZKRlHUqwT06m+3tBZwr1vKJXXyPB42xRYeQBsTQMmRsgyAyGv9mZLHoHTAwOTe2TFv1xtLtKjKveAmgSfu35k45DQH72Y9kiqeUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkxSwH0J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MhRwUca9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57uPPT159399
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 14:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=joFUIqRKiwwscmbjlOdGkL+oQb4b5DS+XtM
	xPC+GTEA=; b=TkxSwH0JJOlgpO2TARCUqT639eNjX+Ft5viIvOp0VoKojgptPwH
	BF5uoUg6SRLiySKLO5ka8q+a0GrJxb8OSP5S0jFArgVy+zwH/9efdCAe+WiKjACV
	E5bJBZcpDjqPfg1dy5M7RCd51osZw+AJlVSM3dCEP1lCyPDEW5eqhleZVMdTgMmY
	+LyU4J63vU6PQLjwzhODWSEhwwxckqhuewNj7xrfgCLqaXYJsd5g8uAMNP4hz04C
	ZHTaUcaLS356C9pHoe1IIZiH+xFWxq26gd+bk4k3/4zdk3FPDY9TJtETE4LRqFRx
	SLVbyMNqyFmzM57xm2wNXqoi6Am+jt/hTmA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a82mt13m4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:42:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29523ed27e0so67940685ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762353777; x=1762958577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=joFUIqRKiwwscmbjlOdGkL+oQb4b5DS+XtMxPC+GTEA=;
        b=MhRwUca9i00nlP07mX5ych9fzRX43IWvZww1T6ti1eSDv9+KMuj1tVGRUshe9TwdY4
         AnhL4LHbpsFiQCMbOf1Cvt5uJfZA4dMRnTWUhkFPtCSoExDguKvBKCs70Tp5PBzvZ5lz
         ieke6PHk9h4mHGrnmVBS/3KFMqkO9mcwGuGdglzyzQSp2gTPZe1QZvMdYDlA5Ktq5Itv
         0g4gGF0dYHz4ZZwEJxceLu02pyVQtdqi4Q+++xICq1BaYJdWPf5X5GSUHxrKrbN/SqRY
         Jwv2aXA3kFUs9XBbv4e7qis2WZqnilqJirtGku2waqgEp3oPZM6GMtdynz/VcrxqEM93
         wtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353777; x=1762958577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joFUIqRKiwwscmbjlOdGkL+oQb4b5DS+XtMxPC+GTEA=;
        b=N4BxrMNiIQ2ZpX8n+j8sE2gHIUTa261BVimIiU1PGiRI6+RX6nR1/lstkyWjoQyNyq
         d3RMjAi59oMW8OtxV+E03REgSAua0/ag/baRLLMnlf5lTTib1Vf1y7RI2XQB2qrtv78F
         lF8rMhliX4iBCjEwruk6IwuFz0RzaorTsN8CqHPRDMjnfWfThSZhqej0i3EgHTBN2WSh
         IOSDm+H06wp1Ul20vPO1vcu5YIJRv5ICZRBg0o/++75TpwmeMVntiD6NdngosQvMEDPP
         7VY/Ih4KwkgV5nzO3YQvLq/0wdFI8hSAET2QnK5NuFgu97vDlhV/+eXR9w9e1yxYSsJ+
         Zfjw==
X-Forwarded-Encrypted: i=1; AJvYcCVvV3DH0x5XjUOGAzk4NtFAyTRRyH9D9t2sdEgybflwUIN3l5LMB4OBxMmqjsxn8bzrwIs+VJ9wrAHmruk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrVTlgF4QNvTY3OS5wSUXtCs+WBTWQ6Eeoyc6oCS5zAc7IjZm
	2Y6HmpooiJ1KMptK4X+WZ80NKtoGPIopX/7ces857PMVgd0gbWT3HBhFSwPXEU7K+GpLSzthY8v
	2bVvkoBK9iF/06CfEZlDwvd3/3bDNdy0U/114DkeD8p5n859vsKRt1G/sG82rPWBuEBY=
X-Gm-Gg: ASbGncuRbzssGuHumQaOOW1i13bAvcZJnryRCxmW0LSN1Pw9+UuAPts51Op9UX1Iw92
	+D2Nq0JyLSb4ZgY73zzmJJ6ivnZFyKOlugBKG5WDOGyQ//ol6KrFpr62uiZMceWYLQ1DCabVACB
	yn1c1NMXX4ypI//6E07kCNpRzIMFzZd1o5ZKiTGxFM9b2RE0iP7dLDLrqjvdDS5AS3Fd4FFKGHy
	8KwuIjFDrLuinSvDYan4Z2LGu2GgShHKErYRK9rUWBKPuN31gLb0z4DPetr5UMGSrBBd5weXmKe
	10EPDABHCXIdSIcOxIwjI56ydrvHioTBzU4B060CWgL+/ONNHX44Y5gF/8MO84Fk4dR8oAWQKOf
	/O7LZj6sYRiKQmSUuB0jxeD9bS2E7/Hf3LGrN32uyadnvfFOjyrDr
X-Received: by 2002:a17:902:f70d:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2962ad260fdmr46545805ad.18.1762353777330;
        Wed, 05 Nov 2025 06:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMHiWz7adnyvabUa3wdrjM7PdxTv++b6QonkfSIBs6/Ncps9VRs/OvuXKWRkYmATP0T9Ueow==
X-Received: by 2002:a17:902:f70d:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2962ad260fdmr46545485ad.18.1762353776807;
        Wed, 05 Nov 2025 06:42:56 -0800 (PST)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601976248sm62933075ad.12.2025.11.05.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:42:53 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: sudeep.holla@arm.com
Cc: jassisinghbrar@gmail.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jamie Iles <jamie.iles@oss.qualcomm.com>,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH] mailbox: pcc: don't zero error register
Date: Wed,  5 Nov 2025 14:42:29 +0000
Message-Id: <20251105144229.467089-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDExMiBTYWx0ZWRfX9DHnFQ9eX/d4
 cVu2KZH128wdGnxDFRsIXl0/8qiXtHiQO1fByYQGbDCLP720j+BufCRPbBgqESs7SbOpdhjkAtw
 RwqKR/2Q/BBmw4I0Li0F2QQ3yNtwJD2FJd+7/1uixFgUnCla+OuJC3BfFTeheyuf3xKyoS2IoUh
 L9jSYLrvjfaMbFA3XL283Gxtha3VlqvTUQ53JUqzjhB3Glf2YTOacGw1q0fv7ldN2XZu6jdS4fE
 eZgRPqTWM5aPqIKdg0t0pgNZRe/D+wF7mK1+aLnV49CYvfMZ7TP4wFtwPRcTt+AmaYYo0u/AF0p
 HD3f/k6lA5jjS2GTXyuf1JD9dN2Wd9D6TqsyVAF3w8JmtGx/EOcsJ2eDH2hkvit9uNfjktAg7NB
 jM1W2PWWO8f1Bj0/XRgnTYsIPc/eEg==
X-Proofpoint-GUID: C-KKxgTjUn_BNBQBxGaG_WcMYuabonNU
X-Authority-Analysis: v=2.4 cv=LLtrgZW9 c=1 sm=1 tr=0 ts=690b6272 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KhMsqpDh0VVKwBF6wk8A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: C-KKxgTjUn_BNBQBxGaG_WcMYuabonNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050112

From: Jamie Iles <jamie.iles@oss.qualcomm.com>

The error status mask for a type 3/4 subspace is used for reading the
error status, and the bitwise inverse is used for clearing the error
with the intent being to preserve any of the non-error bits.  However,
we were previously applying the mask to extract the status and then
applying the inverse to the result which ended up clearing all bits.

Instead, store the inverse mask in the preserve mask and then use that
on the original value read from the error status so that only the error
is cleared.

Fixes: c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)")
Signed-off-by: Jamie Iles <jamie.iles@oss.qualcomm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
 drivers/mailbox/pcc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 1aa3a7dbb7be..5b454769d260 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -281,9 +281,8 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
 	if (ret)
 		return ret;
 
-	val &= pchan->error.status_mask;
-	if (val) {
-		val &= ~pchan->error.status_mask;
+	if (val & pchan->error.status_mask) {
+		val &= pchan->error.preserve_mask;
 		pcc_chan_reg_write(&pchan->error, val);
 		return -EIO;
 	}
@@ -750,7 +749,8 @@ static int pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
 
 		ret = pcc_chan_reg_init(&pchan->error,
 					&pcct_ext->error_status_register,
-					0, 0, pcct_ext->error_status_mask,
+					~pcct_ext->error_status_mask, 0,
+					pcct_ext->error_status_mask,
 					"Error Status");
 	}
 	return ret;
-- 
2.34.1


