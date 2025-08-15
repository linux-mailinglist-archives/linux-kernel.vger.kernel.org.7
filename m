Return-Path: <linux-kernel+bounces-769895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A544CB274D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA57B8551
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF3F28852C;
	Fri, 15 Aug 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WS6Z9hB9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF828725F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222324; cv=none; b=tVZrSiNxvgBoVIt+ls8zluOU36JwLhj9/6EWIHBy83ogbdg2oBb77DitHiiotWKD44ldtsKYWPeCpkdsL/ySpJ6u7ClMJrelmKaxyuafHHTIik7iELAyyubDigeTARuI3eQD40HtbIIoAK3nq7GvjXXp2GMlfdhGUz+oSmWneSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222324; c=relaxed/simple;
	bh=9C+DX3EjRe1T7uh1I8bTX1sVz7A7ptn5lWEATQDBYMw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DDgxQh4cvE4NDF8CteKox24M8n35umXy8E7O4X+TtCVVgWz45qTWn2Q9aYhnrKq1M+zwj6iAfdxjgHU1ughdhljXp8Y4lkuCt4z2n2V0UKtd5wBynrzp83f1CeATzuKfmdRw7fYyjHksdwEioacOkXK38ASg/dna8JoMmN4cqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WS6Z9hB9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F0wZHl015746
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4P3lXv4/uPA7E/VgfMVu1U
	mSqEzdZA+CkvLhRV6TU5U=; b=WS6Z9hB9e8LqSb8eKL6cdbY78dkdRjMB29jJWu
	FhiSmMzhbfAU7LDHmHQG2Q9zA5/bGGUK4LgbRSlagB7QQTGac+8nd5EA9tmQc2c2
	Ab5pgA+3V4NxDkxRJ36D1Qtr7iA5gvOAaeB7YNi6Zg+oE8he9a5eIYixr/W9NAdI
	SHh7CqKgfnTBPr7///9hwabIeF63aOuGVQkKbsBSxDwrGB/4XXe7YG0wjuG1/e/b
	2y6vxjNC+KUI2Qd9/0Fx9aCcdOgAp3/NpnU1a2O+BQGl+45YlBDdHV2dOXyRkZtl
	4ZUomUKDLJAIZJamQSiK2D/AXbuhKpoXAkhiNompT9C6IE+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vvh26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:45:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244582c20e7so17407025ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755222315; x=1755827115;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4P3lXv4/uPA7E/VgfMVu1UmSqEzdZA+CkvLhRV6TU5U=;
        b=Obpf07FgZHPX9DSo7YEWYm1ldk6k82NLrtjeEqcO/A7E59nQpJkd4B0o8KO+fga3ff
         r8AI8wabRjJ3zmpOuwhVW6QABwDWS2nrV0NPAfpu29s2jbEiK4snbCEBK3XVu+tqlKFU
         iuT3QExtOuuD5sQId3VEWztyRAzfz5hzY/i2hqt6hoPVNgTGZ16FPaY855hVHh36FLI2
         7R686ISRY7UzS1tCmS2ZZ0XjFr/UhIXAtJ/zkUj+cdN+3EO1QG3Av6IWAyGTVkGZ2fCt
         QbWP+JE+5RK3xMHD9Cke71w3cdBZwtO1MOs1xaA64WgW9QoYl1OCMwAGi/e7ZaoPG19g
         y7jw==
X-Forwarded-Encrypted: i=1; AJvYcCXaAQ3oqA9Y1DOySIamYw537Qt5Y/gGjl9ObeDxz3U628LG1Um6ufpV4IMQNiNtgm1tIfQ7ai45U6CsGJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqW1QTjM1RTMML+rm0i2aau2PHlx+6vGBDBJso3NPWWpGPyAU
	Kpde3CRjQwUSDv1B4MFfD73vZaT5B0bkqalrGX+xp8z6UtpwuSfVFmqYiZmaR+YlRnkXEMS1Xx8
	6xIHKZeVeZ6yt9c398RE5WlgULZeFMH8Ox/0p/OrJBLJbvWS+R/7OM9ZjWYfVy/0z5IuOB6zbT8
	OEwA==
X-Gm-Gg: ASbGncuoNF+K62Ej65OyoH77AP6wdQKTyCYrX36LetV0PGLzCg2VrtdOO8ImslqajSo
	iQbhhmWlilWviYoQIr3dEjm9+/xHeD5J3spML/qP0DP6ZC0MWNlLLemDHTx8pZPE1VVRfvAQqFq
	ix4K1vcleFpjDr0kAdrfpKaPGxP1YutO4U8oF03yCt//WLZHOaxWUQa5AVcd+fXib+cwgkHLmCV
	5HsSx+1tSCa0NB9cIcqOP6chvz+5W8sxjNYMGcVNpF1BsZ7bYABv2nYFUSa/Za+Vf/8VPGETY3f
	OG/HSITSu8K9QS/iPpQpH+nBSKZazapWYTkN74Cy86DsYXQKcydsAZTOSV9q5on2Jlg4T4n5o97
	kSwIHR+nPW/FXKVT8
X-Received: by 2002:a17:903:3c6f:b0:23f:df56:c74c with SMTP id d9443c01a7336-2446d715b0bmr4580175ad.14.1755222314624;
        Thu, 14 Aug 2025 18:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqjJ5BnUL+tpWpRnC86E4QXEbco0IbzESSL4M5fmEVPbzVuES86olfGCLzLuwlUQ8m/AAbsQ==
X-Received: by 2002:a17:903:3c6f:b0:23f:df56:c74c with SMTP id d9443c01a7336-2446d715b0bmr4579565ad.14.1755222313913;
        Thu, 14 Aug 2025 18:45:13 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm20273a12.48.2025.08.14.18.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:45:13 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath: downgrade logging level for CE
 buffer enqueue failure
Date: Fri, 15 Aug 2025 09:44:55 +0800
Message-Id: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiRnmgC/5XOSw7CIBCA4asY1k7Do1p05T2MCwqDJVFQaKum6
 d3FxoULjbohmUzm+xlIwugwkfVsIBF7l1zweWDzGdGN8nsEZ/JMOOULKhkH1TZggm/hoqKH4EE
 joD932CFY5Q5QKqmQW22YQpKZU0TrrlNiSx7XHq8t2eVN41Ib4m1q92zaPzPie6ZnQIGu6sWqE
 lyglJuQUnHu1EGH47HIz9To+b8uz67Of6+MZrYq8YMrXt3yB1dkV9SCLtFaI+v6jTuO4x3/AR2
 UkQEAAA==
X-Change-ID: 20250812-ath-dont-warn-on-ce-enqueue-fail-4a8ae2fcd1ae
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX2RVgApueB8w7
 8srJd+pe1suSgeD4fRIYjjOmbZ8s49UITImv8FOTATv2Popi7VjV59D6HlFNCpW7MwYXDwvWRWR
 MmfJpkZ5NWAt74vEpAFBWgmxXMaBGBkG+pERnUrDirLMUim7zJJCxhbKvKs3MckbUZjTawOQ6ZR
 p/L/5URHcjUofX00qQXCG0PYS0quGpnhHLNkrQjaZBmV8xFL5gJrlvsTqbTRK/CZ+yl9j9XZ4d7
 a3l779YJmd08e8DGoGW6btUPhorDhsV0M7lNApzgSYTrr6ZVGrCu2VNmbzz/ECNCzRwvmO8EKhw
 v8w9JLK99oABGCTKZ00YDteYzv1Qw24Y3CYq24Face3OZsgR/L3uJxS9c51K0PtaKw2RC8iNvyg
 q0laOZsR
X-Proofpoint-GUID: 9ShZD5LFKLQNr0NvDTtzN9RTjcuMbZVW
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689e9131 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=nBwn2dWH28VFQPEByrQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 9ShZD5LFKLQNr0NvDTtzN9RTjcuMbZVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

The CE buffer enqueue failure won't cause any functional issue, downgrade
logging level to avoid misleading.

Also fix an incorrect debug ID usage for CE.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Baochen Qiang (3):
      wifi: ath11k: downgrade log level for CE buffer enqueue failure
      wifi: ath12k: fix wrong logging ID used for CE
      wifi: ath12k: downgrade log level for CE buffer enqueue failure

 drivers/net/wireless/ath/ath11k/ce.c    | 3 ++-
 drivers/net/wireless/ath/ath12k/ce.c    | 5 +++--
 drivers/net/wireless/ath/ath12k/debug.h | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)
---
base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028
change-id: 20250812-ath-dont-warn-on-ce-enqueue-fail-4a8ae2fcd1ae

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


