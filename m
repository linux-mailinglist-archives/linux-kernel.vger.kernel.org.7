Return-Path: <linux-kernel+bounces-857228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD3BE6427
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FA75E1EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8430BBA2;
	Fri, 17 Oct 2025 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fx0eexYe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1242AD11
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674092; cv=none; b=W9Z8dO6oTdKhIwJmZnYAdCDxQZR7vAJL3pnQT8XaR6VQkVcnnvdmsD46Kg5SU1DMCwllwejkQeZrBaaoyvkwZXiPNp9y4S+4UOBs/ahj0Sk/ACQlyk+KfA4vvnKpjDqlVomsckfQdAQJgJJ80xa2vA03Rb7IaEr/ednoZwGeu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674092; c=relaxed/simple;
	bh=F5lskrdIsNH61tGP+KaxN9hcT3B17+qf+2FmCdeHtUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gg4umgQVHnUV0WEfhwyUgOe0qzk0fcf0RLhx98ZdPUyKZO4keuyP4XTIxMxEjWw7hvWRczH0u3mPB0cCqFpONYVxXa8sO6PzU0M9NBKvAt4v8K3imQmHWwNp9FkisjVWE3JINFr7Zzvow/133kdi+pxilhEe9I29LJym5BfRWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fx0eexYe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLWpP020342
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eIh6QDrVuJ/d1GJLBquAFX
	9AU/PpEXWmpulGYO5uhxw=; b=fx0eexYeTDSLElR2Q5M6s2tDrfIUJtt05nzPJJ
	xedsYcY5dgiNRoH9TSncQ2vQQlUnB6EopAVry0fnOvect9rqBjhmJ6vdjsK2N8nt
	Eb10uhaGTvKZsVIqYvV30X9f0g3oc4cFgjEPQy7DdKIUMhFM8A2rfPTFLssJpUBk
	I5BKRPhVW4TKeHRGH/DCeWjLEv9DNOIMhZmrZPRUe2XTlgywKIy+U+sFVVJHgUWr
	uYZ49msIxbR46jATSj4ODo8JqKamnJZGCcE1G/buxxM7C4SKSSzOzO/LGpunAx6B
	CdXig5w2uSc9w0PQKvO06xzfoqUJq58ZhqteBRGwEeisqw+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpm643-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:08:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28bd8b3fa67so14378295ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760674089; x=1761278889;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIh6QDrVuJ/d1GJLBquAFX9AU/PpEXWmpulGYO5uhxw=;
        b=wMq47qSBM+ev8w9ZsjjZCAMesdJUtQqwLEt2qws1YLeLKwWVzmxXgRLqxylPVAa2Co
         eEmKD0Ix9Aow7F3aGEFBUbVt+pLGVO7rJsoyjzYEm+5bunzZ33k9xcwM1ZDAMUXmWYTf
         57+6GL51zRRUzWjHO31IL0Glif2Az1mAW3qUue+vDZ+wxqAe5UqIzqSKzqMij4kxR7VO
         MxDUWc8ePkX17VvYpUKMMGqkVq5E6Ea+QBu0jgb34Pf9nK2HJ0WmtsNwjriz1QuD1jWd
         ytXBA37grXiTd73FjB7jNvtc2qxEgt6oa+x1kQ+sTANZIbQGwoQt3+VQ6yd4B3XH5fae
         LT8g==
X-Forwarded-Encrypted: i=1; AJvYcCXAjEnRaqbeo7RZrnJSMSV6PjzolQlX2k+bq3SvFUX2NNOpIkFbcZU4Mg2WdRjCz3QEuJhGrIiGuPUgqJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrd4GRh3i3OAios85a3iRvxxD3rU+RSzuuxqu83L6LwMT/OMKv
	UcRWyyMHGtbsyPe7FVrFDkOyJKEohQHWPuaQXTpAvdxwP3x1Ed7VAiB2yIaWRiQJeVaST44kEHe
	tegjhnJxl8/r0XaS1hbECQg/mnsM41LUQXvLFfzYWyIZEpPAfz2C1sB4odyVfG7WUctw=
X-Gm-Gg: ASbGncubDZVPePZv5OLlkc4b5n2vjPiNxi0ovdkpdQ6IGeWhYElxIFP3YNO41b8YAv5
	m8zMeYxBwQBSzNmdVpRP6nFJnP54mo05Tlz2TTEtqjxCk62lDXuapQd6UA7COiJN8dg+iLKcXB2
	tnguL8amHjKZIPdKdE6XgFkR0wajagAPhEiizwBbTWevz9CQHCMO3tOt72B3GCj9IBq4IoOPN3P
	IJpzcs5a4VeE2SMg7hYl77Sz4CTQGHnhX6jteG3pjnTBBYH3Hn0UaKbtyC5HYic2xcLLiwMtaxK
	gk9x+x0fOQUsQ3BJoe0TRRo8HrN66IWlO8Cs7dOyCFinNnt+siMnWpDkWVcwKVpc2dzB2+EtrkR
	Z98DZESuWMbipIfIFcCdeYNgbagJeHVh3K6E7O/FdrG5OS4OFU+961EM1ORZ5lyEj/VIP76YUOH
	0o3OFutAu55hFh5ExoJeznXmI=
X-Received: by 2002:a17:902:e543:b0:267:99bf:6724 with SMTP id d9443c01a7336-290caf830f9mr30438595ad.31.1760674088613;
        Thu, 16 Oct 2025 21:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyYc6twQnPndhA3cfepRvywyPP4rwvgYtifdeLoXuii2ItyGwjzdw2RWmU5anA7cCujXlqdQ==
X-Received: by 2002:a17:902:e543:b0:267:99bf:6724 with SMTP id d9443c01a7336-290caf830f9mr30438275ad.31.1760674088123;
        Thu, 16 Oct 2025 21:08:08 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7afcbsm47635345ad.76.2025.10.16.21.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:08:07 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH ath-next 0/4] wifi: ath11k: add support for Tx Power
 insertion
Date: Fri, 17 Oct 2025 09:37:56 +0530
Message-Id: <20251017-add_tx_power_insertion_support-v1-0-f08feacfca93@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzB8WgC/5XNTQrCMBAF4KtI1qYkkwZ/Vt5DpDTJ1Aa0qUmsF
 endHbpyoaibgcfwvvdgCaPHxLaLB4s4+ORDR0EuF8y2dXdE7h1lBgK0FGLNa+eqPFZ9uGGsfEf
 1TJUqXfs+xMxRA2jcQGkaxwjpIzZ+nAf2rM4t73DM7ECf1qcc4n1eHuT8/3VkkFxwraST2FiDD
 nchpeJyrU82nM8FnXlhgBdViq8qkCpMo6BUaoVoPqjqP1WR6oyyCq1AWOs36jRNTyTI2bSJAQA
 A
X-Change-ID: 20251008-add_tx_power_insertion_support-e5225e924bfd
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f1c129 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Tb0W7XID7D5ug3WCqewA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX6ppexwCyMMv5
 Vow4bxuVdQW7GeOMd8EjXmOQk2QcEUuupxrKVfQDMIT4DwdssWtn01o1TBxHNi2UlSv+vDQKtW6
 kZVB+Ao1RxO+vRENc9iZ3nBhaAV96Us8lCm1Lj/ChPXlzOeB+nOxTxAlm0/52fPhXfRgZmHYg4j
 95f0jmsBnobvw0sRdTjksQCetQyxeRyC5D1NwkFCEDSZLiahk8tLZ5HB3pIXfP9yS/C8MRJ9G2r
 ZnvhaEedNkdpsqbi5kVxt3yaVuZSWG7ZenSL8FOi/OYRwXqeADtgewzsNcjh+J19dLWVDizq0Iy
 SpelamFDAO+hXj36XolxmhNqFCcX9aV/lv0xdURorCSOkGoGaM98V+h7h4Q+4jqj9OISqSvErg+
 l1NFtOJ1/m/x1lYD+0zzzn0liNVXKw==
X-Proofpoint-ORIG-GUID: 7BMafMzsnwX51DU9UBOi25bmFLtMe7od
X-Proofpoint-GUID: 7BMafMzsnwX51DU9UBOi25bmFLtMe7od
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

For certain action frames like the TPC Report IE in the spectrum management
TPC Report action frame, and in the Radio Measurement Link Measurement
Report action frame there is a requirement to fill in the current
and max Tx power of the device in the packet.

Add support to populate these fields in the relevant packets. Advertise
this capability from the driver using the feature flag
NL80211_FEATURE_TX_POWER_INSERTION.

In software-encrypted cases such as PMF, skip insertion since the packets
are already encrypted and cannot be modified.

Patch Overview:
Patches 1 and 2 serve as preparatory groundwork.
Patches 3 and 4 implement the core changes described.

For context, this ath11k implementation is adapted from prior ath12k work [1].

Reference:
[1] https://lore.kernel.org/linux-wireless/20250630-support-for-tx-power-insertion-v1-0-77f45484d5bb@oss.qualcomm.com/

---
Aditya Kumar Singh (4):
      wifi: ath11k: relocate some Tx power related functions in mac.c
      wifi: ath11k: wrap ath11k_mac_op_get_txpower() with lock-aware internal helper
      wifi: ath11k: add support for Tx Power insertion in RRM action frame
      wifi: ath11k: advertise NL80211_FEATURE_TX_POWER_INSERTION

 drivers/net/wireless/ath/ath11k/mac.c | 447 ++++++++++++++++++++++++----------
 1 file changed, 312 insertions(+), 135 deletions(-)
---
base-commit: d5ce93f136fbee2b7afbe221f34ca881036f8de3
change-id: 20251008-add_tx_power_insertion_support-e5225e924bfd


