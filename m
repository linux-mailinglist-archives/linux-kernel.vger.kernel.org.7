Return-Path: <linux-kernel+bounces-860418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 699ABBF0176
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA92B4EDCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA82ECE9D;
	Mon, 20 Oct 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0bJxmuG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016DB2E972D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951259; cv=none; b=XWV4J7hgYAAPFwcxtDc0GEVv723/AxqBQuaZgh2k55UZpBU7/elM+OiLCSSONEI2w7Q1YVhY2cUyND7yqa+Yec7XBQEPOFX109Lr+JvG57OujrGxtysS07SzIt5RIxFxli6moFXNqWx1NzTqLp/mmvsprJsQtEQjon/BSCqXKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951259; c=relaxed/simple;
	bh=hVm1R7ia9T20tyT/Jyi2XcWRljw8bltMueR2LDH2CBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pJGbt7wszsQAk+t0VJWIxyQ+WHvwtKwbBIGseEC+TeHqxq2OfyHF1PsJIfaNNgZkx1QDZgMaBZmps2E9DNcnJDaka7A37NO0rPecWH+qZ0pYEWwK1HZpeS3SvGTQCiEidzDHc+UJqYuuLsaKc3ztkAW69oa/aqw+42nmGb1uup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0bJxmuG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNvVLK031553
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RgZkL/O5r39Ejg7wxsPlka
	6AUERHa48vlx4Rj2dD/t4=; b=n0bJxmuG5yQ348/N0RTNO0DItkZ9528dA1D4ny
	pi5nh4DNyHr0v/YuCVL6aro/1AaCj0JzJjDa9LZNuucL6kOG+bTvqEkyVW76EdCI
	AkM7gvAlnYI6UPFi+4gji3I+mWtoBayqF85WBSIZXL1vPCEb5fjsmydmPGKzIAei
	EqdGme0U+GwPlIHQ0EWY3DRiSuvajxUV9EC/QksUkEGAfR1swt2uyx/NNmkRUgDX
	/M52TJ8Cx9Jvz7VtdoehLdsid/hqsC1vlX9JX1JNSob4o356LUKIiTHmc8TvEjUY
	C1AifiwWo8cGx/imizBYR7UqVl6fjs2/yQq0a2EZoT2xuygQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdv82d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:07:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so8991798b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951255; x=1761556055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgZkL/O5r39Ejg7wxsPlka6AUERHa48vlx4Rj2dD/t4=;
        b=uzvQrK8JHu3lC1C0gFKl8Cguj0FnJGgMqkdbLU0oPzSNC7Sa2JsCi4jEAvulviD5Wl
         3l1HWRVtOq7U6Llu/xxsUTYe3vlqhnJwTbSchgXUFTVhr0OALzJAXghPss7DGKQQp7GG
         4gTV0LhSAhxDToC17UVY9q9FnbPnXFauxSuS0v0JqilfN5KQEUWNPpVYBozZfOeQAm/z
         fXWaRE8FidMsJfQtt6jCXg4I9IatS3PgIhnqY9nhI3g0q1PY06FKs4WRsZOB//H9lpjG
         VDlRZgMEEn93WHHYeZVAL8NXoLstSbupOof5pIhx391LfGQWN04iKc6T8HNcaMVOy+H3
         Rt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2zvKawFjwSMA8beTRja0Pxsb9haa56zYJEoliefM3sUuO+eK9b3ftHco1Rc96XIfL7BMkzytUbdpsVas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7P0xCO3zaB7HjVHt3FULlgJwuX5+E3F4dc51B0A5dA8HABouX
	zdLbRhfy55AOuTzV9dwMdwlwi39LasjBLT+RQsRr7TaPO7vqrkTAAZg371K/b8b1DhBk9ifOQlC
	9xu9TljpAMhUvsZgs3WHx4YmtfeV/SnuM1jzP43Pmg30twMe2aZ0VcdLypPfbJcDv0R8=
X-Gm-Gg: ASbGncuP2jlVjLYRi5jPvpOPQZE4yFtZHCZ4jDsZRs46kO1YcpbQAvCikX0Tw6xcI5F
	mD006AO4krMlY/DWTlUK6ljz1Urkj//0BGPoHtaRr5ZG7Hl3eYP8FQrgH3Zy3pXlJLAP4l+jkde
	zbu6h2ioqBzm/I4JXYFhU1903qIaIrxEUkJd1MRZyrEZPi4uRS5K6kPGByskTcYs4uie4yMvOlw
	sDyp+Sdo8szeip9QBj6JGnTJE6GTGXs9SyZhD0+PHKHPSuHa//wt/D9bDI/zsHXxt/CAP8aywKb
	rkkau8vKQIMyLpfwXEkguVyCquv2+sOgobsZsL+g/PbFt/ysGVKxUlDKhAQS6Lp1K+ZH7IlzQ0r
	LSqLAz9RXCIMvD+rgj2yVD3MjsprADh3JPhvzrkFnTrBLQMd+J/uWYe7qYMP5IXAB693Ol4O3
X-Received: by 2002:a05:6a00:929f:b0:77f:620f:45ac with SMTP id d2e1a72fcca58-7a220a43630mr15859216b3a.2.1760951255602;
        Mon, 20 Oct 2025 02:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRpK7inrjbHzeDY+riy4KtgH1OnfykJvAHgUiLsEci+dm+CxA5GBz2hSl8e007SY4h4SVHyA==
X-Received: by 2002:a05:6a00:929f:b0:77f:620f:45ac with SMTP id d2e1a72fcca58-7a220a43630mr15859186b3a.2.1760951255199;
        Mon, 20 Oct 2025 02:07:35 -0700 (PDT)
Received: from xiaozhua-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f25b0sm7742999b3a.49.2025.10.20.02.07.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:07:34 -0700 (PDT)
From: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 17:06:46 +0800
Subject: [PATCH] coresight: ETR: Fix ETR buffer use-after-free issue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-fix_etr_issue-v1-1-902ab51770b4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKb79WgC/x2MWwqAIBAArxL7nbAJPewqEVK61f5YuBWBdPekz
 4GZSSAUmQT6IkGkm4X3kKEqC3DbFFZS7DODRl1XqFEt/Fg6o2WRixRq12LjZ9cZA7k5ImXh/w3
 j+37Q5yEPXwAAAA==
X-Change-ID: 20251020-fix_etr_issue-02c706dbc899
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760951252; l=1599;
 i=xiaoqi.zhuang@oss.qualcomm.com; s=20251020; h=from:subject:message-id;
 bh=hVm1R7ia9T20tyT/Jyi2XcWRljw8bltMueR2LDH2CBs=;
 b=c8mtVKvbPgSvvbkWfaxGoLkGyv4LzvBRAZR8R4pm59YaQ/8wH+igbBq5YqHGTcBsosR1fbi+p
 oqIflqpxmHPA09itaBiXyWa9znBvCi4SvqEf1ktMCIQeGiMcheY+qlE
X-Developer-Key: i=xiaoqi.zhuang@oss.qualcomm.com; a=ed25519;
 pk=zuq+lkjngHYEDk6qmD41kiqDaQuURxgU/sjQuARnCrs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX/c0juotOMe4v
 9dymr/zX7+INoKm0qUQI0nLe5o/RQrcIPaifrPPxd7kgITL/BaZiTGmgloSGdf+6VYmxPSrLYQx
 w96mtQP8+dwesQjcHSbFQozGoUcp58M3vG/3WO7H5tinSA96PHgm1gO7d61TjKgK+dnK98lP3id
 N3HB4hya1VrtKxVSvjY+e2MEFu1AG8UYVvtYnqgAqEi2rKn2M80caaAVfDq5Uz5VLZwsDUOnINQ
 B2eOGNsLVjxFeexsY8cYC85uyuGvdXeVgHFOPV9w5+DmhePdK9+rJA2bWY8dvUJBDE1zaocbqZZ
 VE/kp7pW/6aZlVS46mMR0T+RLX17W/hox7cOcp4cBkK/+fEI2dqi4M1AbA/tpExJ0Q3mVvmelvs
 JQddDbhSjqm/oTuveu4o0Ai53rV6PA==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f5fbd8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=oKJ9ntOD2-YCvPZDK-EA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: G4Tb6OihOakIYSqbrBDFWBebRT_4ivPX
X-Proofpoint-ORIG-GUID: G4Tb6OihOakIYSqbrBDFWBebRT_4ivPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

When ETR is enabled as CS_MODE_SYSFS, if the buffer size is changed
and enabled again, currently sysfs_buf will point to the newly
allocated memory(buf_new) and free the old memory(buf_old). But the
etr_buf that is being used by the ETR remains pointed to buf_old, not
updated to buf_new. In this case, it will result in a memory
use-after-free issue.

Fix this by checking ETR's mode before updating and releasing buf_old,
if the mode is CS_MODE_SYSFS, then skip updating and releasing it.

Signed-off-by: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..3e73cf2c38a3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1268,6 +1268,13 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 		goto out;
 	}
 
+	/*
+	 * Since this sink is already enabled, the existing buffer should not
+	 * be released even if the buffer size has changed.
+	 */
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS)
+		goto out;
+
 	/*
 	 * If we don't have a buffer or it doesn't match the requested size,
 	 * use the buffer allocated above. Otherwise reuse the existing buffer.

---
base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
change-id: 20251020-fix_etr_issue-02c706dbc899

Best regards,
-- 
Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>


