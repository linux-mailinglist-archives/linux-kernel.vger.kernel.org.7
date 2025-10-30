Return-Path: <linux-kernel+bounces-878233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E1C20137
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9186A34E763
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CC33358D3;
	Thu, 30 Oct 2025 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HKl7agbJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heLW9pFu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C71A9FB5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828483; cv=none; b=AJSic1ZwI/E7Gb09JxSaswhk7xpl6ic24/xGk8BJ+ubIpkItiFO1T5TQgHh8LQoy+wSLmP+VV96BSln9CzQGBVI97UNZ8OoJZubVfCkO0gry8enD/rHYCF/f5Pg/UD962gUoSOszy9BHyNSRAUU6KePf6SLWoobhbjmHY2Fk9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828483; c=relaxed/simple;
	bh=KOV6nt558CzNaBIDVg03/RcWMJwL/QDMHKjAkreK+8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0YM3NfC39p+HUG+rs8YuOsxI8jSKvPY51bMKuxzedkJbKA4/BH7+W2/sFXgHJq0D+OuMFsYJU3xLv1BpkHisqRp/8n/CJKmLaeEJrDwj0QW+46pmUAgDK65vymHA2nv82rvlFjb3Y3l2WsN4wmqLqq5PSq7z6nCMzEMFuQ1gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HKl7agbJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heLW9pFu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9P8P31994640
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=G+IU4YveKf5LqulcS/K0IX7jygnBSHY3LH6
	3KY/K2BM=; b=HKl7agbJD6YDerN9a9TrrRDzFYGIP6rFoVIaIGxfEuFT73XZKZD
	Vnhb1rDNczNOhjHZozM0WgaChkM3UEqLhtSTUC9SIYSv/WPpd3jpM21ORxLSXpnd
	xb/Dv4koxT8BfeYdHcBaMjldhFS15Z6o7EFP7yIflUSVpaeA9iNg4moXwY5bmgwA
	hWd+sWWnJHv+im8sk3At2vNCbdOomTRI3toL59yFQt/K7oRuC56T4LNwfLBhNMJS
	UrK1CL4vN4lgKoO0urrCZpvD8udegY/0CHztuED2ZgsO7GLk/5H13/dahF9wOLAW
	K2YIMVso02WNTuRkec2AGRE+Smwy+qRY/8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3wr71v47-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:48:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so786769a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761828480; x=1762433280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+IU4YveKf5LqulcS/K0IX7jygnBSHY3LH63KY/K2BM=;
        b=heLW9pFuq3J4nBDSvf6xAo6Onf79uHrVxyE/sZbG9vWWQF3ga0IqhdZojUIWgz7KZ/
         ebKwNqIWZHBxlorImpcm+zqOIhYRHxZSVLEgfEfRQXllHQhpgox67pkY/P8l6N/mRyVB
         fdE84aoexqAN6p0AmKFafw7xCnME3SJPK5Gtph9wrTiO4rcnBUhqQarWG9obc0L+E/LD
         GpTkCAtY2IS89gIWz3r/UwD75DFQwKb74i3zjtaZKALzsOqQKevbLQc4SB7rzYnBkZIo
         WMEHsyV2k4/YZtWM13eWs1r4+neNcCkOZxt1D6WvwmyN7h8Am+w0BsQ219/Had/rMKb+
         5C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828480; x=1762433280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+IU4YveKf5LqulcS/K0IX7jygnBSHY3LH63KY/K2BM=;
        b=POZh7uYpZ38buiS1wMxbfMato/u/VkOPk/h+twgfCDDoeh/zJrt5kPDEZMZlZAhHCZ
         RCUHm46tvN8llDOh1hwPSHAqFtHkD4Xjo6gaRckrkM5BUwmDutDEYVma0P8mj2LxfW8t
         z2IwybgkfGZzFAzksl6HAJMImhN8PD6sHWA7qRKwCxDMROIh2XygIWcz+WbLOTfYa/lA
         V4a/MC0q/U727KDcaAznvzGeybWvT4SQvJBV6G9rfhcSBz3DrO1rer9a+9QDIhYo7FBO
         8CuZcYOUapk0xVe5PrjTFDTIgJdd1SoSggc6JMhlrpCffM/Dn5YkS6C4RKaJPNNO7jWi
         O/0w==
X-Forwarded-Encrypted: i=1; AJvYcCUx+WbUqmumKRBXxS5nrdrvTpKkHmHfB9ZplUSGwDEsSXK8lzRmNVTT8EEzzcmaUE/5j8OE7IrEQCu2gY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mvHh04bZofp4vaHY0LrvtbpWuFbeyxh1hdrQ0VrCKhf5K5QW
	zPi2pmExeljvNyRexotkhVyTxYfe6YwWY5IiPevaMQOzcUKuWNbz0F5NZm16MQLE2Qu0NdwAy2N
	x+2mAcHK3bhVB1R6HP/QIeK1xM7aE97KXcsS9imDW4vJaqKQR/AVES4uJuhQKqpcKxMc=
X-Gm-Gg: ASbGnctEE6uamPVQQ2BXRDWE3Js+kqL8AXZ5XYmVG12OcwMS6rkXWt7hetyvgGrI9Bh
	M8VngDRDm4GkHeb+GPB2HiGVxGz4Sj0oVTy/oMqrV6VMT/ecXVoL7TfHTOjuDcbMJ9FIGd0pXoG
	3SxdDzvPEoMW9s8vFtiKbMkQ9jiNmPqA/IGHKDthbgsghxDd32D00Yo11tf8bdXdm2ZByDKnjlV
	RkOl9aK+rPlAfr6PJ34huprjAmaABXQKVTieFHaxiceZuVbOk2aYkW08ID7ivajWqo/Y6AIj+EI
	T2UWvFpiajgMSErDkYostOLzpUiXp2nreaXhsnCTYDbUGLuqPd4DKmUIe8jkcaUjR6QQm8FJ8vT
	fjLMW7Iv8K27mRChBJsnRx2bx+lrffBJM+PjG2gngxuLhbNKRIsBCN8aszfiY1zPHrQ==
X-Received: by 2002:a17:90b:3bc7:b0:33b:d36f:a20d with SMTP id 98e67ed59e1d1-3403a303640mr8204851a91.37.1761828479693;
        Thu, 30 Oct 2025 05:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDpF2hpNsvy3jo/p/F4BKHpGq/32sA/EDX9vwxwOYby1CaPhDXXPX6GW3UIRk6vGiHO26Jvw==
X-Received: by 2002:a17:90b:3bc7:b0:33b:d36f:a20d with SMTP id 98e67ed59e1d1-3403a303640mr8204815a91.37.1761828479202;
        Thu, 30 Oct 2025 05:47:59 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509e9f2fsm2555028a91.20.2025.10.30.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:47:58 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] spi: tle62x0: Add newline to sysfs attribute output
Date: Thu, 30 Oct 2025 20:47:55 +0800
Message-ID: <20251030124755.1828434-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNCBTYWx0ZWRfXyNtNBP1F2ktx
 8qfqZAZKInDPD2SHTc+yoiG+jnNCYlvnlYOA7qLAgx5G7VZqZ9EClVO/n48zosjjFBxDAWSLEKY
 28Pzb/AM2Qb+8XTgAv7hf4HKEQPgyg1X4f8GWd/J2YO4hxKbcEsa9jsHTLGpcsTPJ1kSemjTVs2
 FxKXtJu5nBZy34OPew/5JKeUSkY9agex2luY7aqua+dCsdOMPLydsSWMs2MQTCkw83hOIbM0RJ3
 xlqwa6vd2HvXFnzpn/rlEKWpazvbKWX9UZ7L/VE8sNx76lWyDNt7vtWSjhQ4oMwekoNk6qtpDun
 YlgRu95iA7w3JaTsbo//tXJVYnnq8xCCHS/Ac91PefeRraCQo0ilJQuuYMtJpHyFXyk0kV9bgGO
 0Ur230zt9JYio5+VzN7NhMOfmJOkqg==
X-Authority-Analysis: v=2.4 cv=P+Y3RyAu c=1 sm=1 tr=0 ts=69035e80 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GurJJKL-EhHNLGmuHs8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: -pZGBUMwW4kmTH7md9XEcvDvn-LegrzP
X-Proofpoint-GUID: -pZGBUMwW4kmTH7md9XEcvDvn-LegrzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300104

Append a newline to the sysfs_emit() output in tle62x0_gpio_show. This
aligns with common kernel conventions and improves readability for
userspace tools that expect newline-terminated values.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/spi/spi-tle62x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index a565352f6381..663c0136d119 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -141,7 +141,7 @@ static ssize_t tle62x0_gpio_show(struct device *dev,
 	value = (st->gpio_state >> gpio_num) & 1;
 	mutex_unlock(&st->lock);
 
-	return sysfs_emit(buf, "%d", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t tle62x0_gpio_store(struct device *dev,
-- 
2.43.0


