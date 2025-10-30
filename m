Return-Path: <linux-kernel+bounces-878214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FA2C200A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE433B3F62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ADA30F804;
	Thu, 30 Oct 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P6RbXfU/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eCYJs8wD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42FF4F1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827706; cv=none; b=tZaejbGAV/iltLUHJgaDMMnZYlI6WE8SJvDdNq6wWGOq0AIiuzsuTAn0lTiMsNAchxSCPO8cqBuzGSu+8rEyIQ9lsIaifevCwaA8LoKMZo7p+88Mz+SKqhaq4g6b1siK/Bv66UNo25Er7Wh28DR3LbZYEmkz6aIbiJry4cBUrPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827706; c=relaxed/simple;
	bh=7RGhyi502KoWvsFNQGjszwvvFapTut6/+hdSexSVNZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpcldVPYyjA9t97d0a9+RfgOgARCyG4kJ/Ogqi07Hhrt9XnmVZrknjXWUbJyb4KpPfxAJHbi7IypwtY9E3e+aXNw9Jtlc47qPV01VpdDS1YWczasVaHoC6VY2jauT8WUS27eJNu5PJ82XQIHeggv2HT7dXzUM3fU+GX0h6r2jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P6RbXfU/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eCYJs8wD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U4xgTi2622985
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1a83WxM45yVcvOFj1pAxfquPc/HEWlp0bdR
	ZFkri940=; b=P6RbXfU/326Dw93gO2HI6+2e6hHYdDDK9NBQ28PDPi9QvMFmeNJ
	rz+X6MkXQN3gjoQ6nrjc+MUykw0A6jhJWi9zvlMFw+VkDYZm5YUBHmqQb58Kd644
	BNXmhSzDxTXwOr7ir8O9QV5LJmlgLxhrw4kp/dThETzGIhjQnqScqK+k+b6CA/P/
	vxXv37yOJW5nzXbqxZoYy238P+4tufNI9IhruvdGtkltRVJTWHlMubI47oII4K2q
	mxvJrGTvKAffhKh0CwgvL5GMbmaiWWMLueAy9RCugGFh4p7L7r8dFpJ7je7FDp5i
	cY3A80hp3wqeBKGNjwhkPPN/8Xq/FxuUDaA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a41fxh8u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:35:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294a938fa37so18881285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761827703; x=1762432503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1a83WxM45yVcvOFj1pAxfquPc/HEWlp0bdRZFkri940=;
        b=eCYJs8wDjE0GgfmkCNs1lqzZyQf9EqiZ50TsIQaYgcXIGfYyT7p+JV3taITyvt5G6N
         ejNzlzJXyF9ja/79CWjwaT1jELzLZvx//esx8zeGUtpkAGD9TL0nh5eK82D2jHMI7tDR
         fAfIWbYJty6vXKVACDp5xbpchALTO8caZ62r/Tjl2zK97/xVb2/R8+HjnJOIDNjAnQvM
         l/+6dyWfJgLNsXb6NRR46KyIHFhsRio5ilBDZIJC1qafCdtLFEtHBpPqhKtecgWuvq5e
         bhHymWr6JbUzm0RZE6aq9u+bgzcxZPRWr7mvTvZTdbIwKzFZb6EG0FYrmNCTU6a1be8W
         KKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827703; x=1762432503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1a83WxM45yVcvOFj1pAxfquPc/HEWlp0bdRZFkri940=;
        b=nEYqgAWKpi/aoezFsYe9EeqeJtcYL7LkxY8CPuXb4eYoMYawUDt5AlyaUf0ClGgn1x
         hdTX19MdDmWY5XforNpZkfeMxnNld6BR89wgqx7a0d83OF3aTRfu/kIAtsQ9QJbFl3AR
         4qM4hImubzsAxO8+PnUg8/RAcCDGdegLo8Fp8KJhj9e732ZwbiM+Pz39HHE5UNNk9/pR
         O2ICo88i73XTxc0bdCm0Gcfpc7RfezmKUVeHbWuCKiaiYwIJy9/q1JMa5d9SPzXAsq7f
         4w7Tso9cVsqmxXKetP/vqawfi4s2IUjG2QasyoHIfG3Unku3X6cfVABbzClSSvEE/ZJS
         /OWA==
X-Forwarded-Encrypted: i=1; AJvYcCWuvRtZBgXkB0mC2Z5B9nAARNvtRM3edb1kVXegMPtiPj9wQ00694ybPnqD8inIxZF+gWvA2mv3h8ZWtuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8Jc4GUVzJPCdJ4sNrcuRGCJTi+9W2DQZRrPfZ8E9/WJHocfp
	8LfsKKDkGoHGYxWJpThIFRXSM1ao4cavXOJp8dUmQWqYVqV3ICrzZEWwZ6wlrKcX1dVjMZ3LNqW
	qJISbE4oNjP3BlHRZL8ngdHa0/4iPFx8w8NguIhvnWxvAfupBL3oYA9tHWiSsxn9vF4DPeMvUYC
	hnMA==
X-Gm-Gg: ASbGncsaXP/OSpldxu8Ji+2oALZhT/7PtjvxewhBHsuOsVE3DuV4AS9kC2qRRNwfv5W
	bqZWXfvLSzTS4Wz9O8Be/i9T1+bM6Pjezp2RW+lj+gk9boqt6C1MZGz9lDnGmiFyMR3ZiaziGyY
	MZ0uCugjK9FrTJ+mDUuGdAzTW1sKJkRlosp+DPcKWHDZn+ABjTRWIdJyN917j61ISTem0tlsaFh
	DQyCFEpGiV7GrJIRj0AdoY8zvz6JS33qCbPp/d8hmbiE7BKM57wICpZe05s/PySfLzU3Oiz+VFu
	BqQrXzpe2S0ufVIYf+Fhi6XBg9RY9JvzLyNl9NYuJlOl7Te7zPNzrr/yyRrUHjbTVr7u8iSDl4j
	s/RprUIlblehggpDpVYdT/NowcaQHsmff7yXTCf+r7INneWa8K47CBZ5cCZh0BiIjtw==
X-Received: by 2002:a17:902:c24c:b0:25b:a5fc:8664 with SMTP id d9443c01a7336-294def30f56mr58159405ad.51.1761827702847;
        Thu, 30 Oct 2025 05:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNGixP+si/DlsVvTgiQP9OzahR4n7X61dy4b6eOj9gfnOPjNvXX+09qONXVilXrQrSPbiRzw==
X-Received: by 2002:a17:902:c24c:b0:25b:a5fc:8664 with SMTP id d9443c01a7336-294def30f56mr58159075ad.51.1761827702220;
        Thu, 30 Oct 2025 05:35:02 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0987fsm184384005ad.25.2025.10.30.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:35:01 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: dmitry.torokhov@gmail.com, krzk@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] input: elan_i2c: Add newline to sysfs attribute outputs
Date: Thu, 30 Oct 2025 20:34:58 +0800
Message-ID: <20251030123458.1760524-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GfV_FANQdx-I2RnjGOcHMPnGh_sL0xUG
X-Authority-Analysis: v=2.4 cv=UJrQ3Sfy c=1 sm=1 tr=0 ts=69035b78 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I8k-m_L3aHpefXCHYswA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: GfV_FANQdx-I2RnjGOcHMPnGh_sL0xUG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwMiBTYWx0ZWRfXyk59R74f6xgC
 RcFQZbfW3ra8foWuGFFbs0CqvJRHyRoFD14Ka8SQAiAJXj9E7Lo+VYDeGpM29PcuIDgah4bGJdS
 +PndqrvAjK15pI1/2piZ8p8H8QxSeJJcpjubG8bWsRakT5WqM7ajF1CAVMRZs9Az+jYia5KPcE+
 0bq/rQr2FZl59Sun/yPUp+na6Za9kT/XVJhHgXn9/eDZzs+kWd2Np57F7/A+P+TnSW2DMMPZnHs
 452w8/bdiVmAMUDL4+BVbAMMR/3oMdRlS8mG/QtvnL72G1XvLynh5UZs+1F7z71mhjIoVj5lmr7
 Plj0JhGNYiMai7fmzSjszGPGuA2uezWP4kgIuaxSMKDILKwVxXiOdqlHJufWkIA8PWdYCoeNzRk
 3m33FKevI1cz5KSXaC0RT5TxGhiBtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300102

Append newline characters to sysfs_emit() outputs in func min_show() and
max_show(). This aligns with common kernel conventions and improves
readability for userspace tools that expect newline-terminated values.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/input/mouse/elan_i2c_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fee1796da3d0..14b6cfd7a6de 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -861,7 +861,7 @@ static ssize_t min_show(struct device *dev,
 		if (!data->baseline_ready)
 			return -ENODATA;
 
-		return sysfs_emit(buf, "%d", data->min_baseline);
+		return sysfs_emit(buf, "%d\n", data->min_baseline);
 	}
 
 	return -EINTR;
@@ -877,7 +877,7 @@ static ssize_t max_show(struct device *dev,
 		if (!data->baseline_ready)
 			return -ENODATA;
 
-		return sysfs_emit(buf, "%d", data->max_baseline);
+		return sysfs_emit(buf, "%d\n", data->max_baseline);
 	}
 
 	return -EINTR;
-- 
2.43.0


