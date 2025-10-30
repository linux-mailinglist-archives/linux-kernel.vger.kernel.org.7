Return-Path: <linux-kernel+bounces-878207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39509C20077
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2037C46346B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EC1494CC;
	Thu, 30 Oct 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WaVoAw+Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BmDoVq2U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8F2FABEE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827408; cv=none; b=PBsc2JdrrtGUzvGxVzWh/ESf0zLFYlGJsq0JXWmR8o9VOd3Ie4mONW4bgV45LaduuT/8Oidvsxx/A6bP0TQi1HFLJZdCx3FmRvfOiXoiw4RIZfy9DZaN1cDLmxWO00/yXKd/KTOdUzbVV/dmdXCSPRx6DU5TbDR15FKtgOG4seQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827408; c=relaxed/simple;
	bh=KBkIIh374hHzfwznAC+JOUfupKMkxEXUerfy/ez662I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXiZE5JJgvKvCMmXU6+jQ+n/vyWjvUH4f0WGaMgku04uZ4ih72AC5m3zdoD9W0TP05J2mpW5WcC7saqdH4OtugqX1hqGFsjJurZULcHa4aj9L+Hp/MevIVSh10nl1I/H/1fDy5P1Mdzi2AgHbDAop35whJvIdCRW6i709HC/6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WaVoAw+Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BmDoVq2U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U6wRNW1504048
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dZ2IM0Bx4Z2NNgRDWVTlgbmQaB7Sv6/x5r9
	evmc8FK8=; b=WaVoAw+Y9a1tQPEPLTzV9+RqFUP3nWPtW8Oulwrg5hQhEYkk8v2
	bpTZzxFChDbJrN9rRRLTAtcc1m5LYQ3y3/seoMWE6AEL093uOT20VyyZx74yXiHO
	F+Egbh6iVCMd0UGkijnsP1GczJqpBjUW3+ICuLjINzN0TtDVWBQ7K2ikx0zKo2kU
	xhMbPUiig1MrVzB4LCbo2rdV3tuzFk4rXEsoPnXXoA9vrdJLLPz3sjdggnqBSaub
	2lQcmavaf0BUt4+baNgldj+2ItOzTUBb3A6v/xDyuNDH5yi4pZbA8HmXOcWyiUuw
	vvOhy0aNLP5oIhzgy+T7dZC+P/1GRRDWgxQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3t1jtedv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:30:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290b13e3ac0so10142715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761827405; x=1762432205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ2IM0Bx4Z2NNgRDWVTlgbmQaB7Sv6/x5r9evmc8FK8=;
        b=BmDoVq2U7+hDFMwU+T86G1eEUa4MRynhBYF0Dk6GxCBMPUDW+XqEwTSSyIXo+yaiH/
         T/77ECbvcqBGG44d+q2vxcuvMF5dFJ0yx6vWklsS5xE5KbiAZS7aQ1t7Yb9mkLPPZeqy
         B66zi1qVbTry/gOIDyOQDK0GqDg0bCjUg28l9O2bwCVZGcNPzXkPcwxsFFd9woOoU281
         uJZACg78CmEljb3mnpQzhyCFVb/BkjKUg1mOw7vfHCyJSPb7JC/TIOoF+bz5EBMX5AfZ
         ePEw5Y/nQDRt9spsX3jaEbQPPx1MjQXxS6vn6nn8EbmxaWi1erHcj52WpyvAWzxEzHNS
         eUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827405; x=1762432205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ2IM0Bx4Z2NNgRDWVTlgbmQaB7Sv6/x5r9evmc8FK8=;
        b=l0tsMdyk7g402eQ5ql4BFN9eOakKSS89GvNWxqyMGQtF9CucaPYXrjp/VY6VzFWksx
         RyFdiOFIFpWLEZvPPukTCQ2pbM6xR0dDnth/5bPrBiGsC8pMCkVloPxgSEKVjsfBv05R
         orXwrUzq9JrACAEkBMDazUqGE8uZNUCz+Gp4EfasXyF2ylw7PNiKsPbelHHLF+nKUE11
         hvAwNbQSSSNSiKlfbKEc0jVqdQ+W878CCPfb0rng344WObSNtUsWN7Lh2vkzvUBhr1vW
         gbrMjDT0mLxeWymUF+U5c1zfjwQ5jh/+U19SDZxoS7n1Ljmnw0zx+mT/0FvsqdEghH/9
         T+kQ==
X-Gm-Message-State: AOJu0YyNPSggvNpca8LPUAms4zAHye0ZgJqeoLX8x6mWy3y6TxZ48ptk
	iQqfVcYmeo4mB0ihQuPzSf/X2bDLyVxVkbj+3q8Kt35iRFDmqY6rTexo9Fy0QudOBDVNg9IgPkI
	TwNZQysEtvVrFQOGFE14degDxsFhatg4RIG9h3jcV4CXg7pqf5XwOXbsKlQI4+JzmgPqQt6UEXA
	Mdeg==
X-Gm-Gg: ASbGnctCks0JF/+znjYXoXFIIOouIWc/bO677ONX5f4Mr2SsAHV43EiJy9RZLjnkggM
	7JUr2T13Nhb6CirYJfYz6ZIqmVCx5EezHch+AlUP7QduWLAGRHQOd2lhJN2t+miTnwN7s6gSLkT
	NjRQ5nazGTUGVqdeMLtEW8s5cFjCoNDmsUFC1VEifTDSm5v/Sbe70HNyzmSYbBQi9MCANpnt7Fb
	TecMck77zKmeGQlJnCDd/45GhU1zfrxqmmZZ1kUw/l2/NIYbsBw2RqwBeBDdzGg0C3NrTyLVWDJ
	q9Sa8v9UH8UL2REklkLQaKd6pe9WKqPRyKoridYB+S8eNpooDGc8QoFF+Mf6TnP2nb7WwZAIoDg
	zF2m05aA0CkWN5oHIhwt0kLCP630mqhNQmPQJQkTADYBo7L6ALYWzyNFVWYug2kr1Pw==
X-Received: by 2002:a17:903:41cb:b0:295:62d:503c with SMTP id d9443c01a7336-295062d55femr17996395ad.16.1761827405178;
        Thu, 30 Oct 2025 05:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl7o79WVnwgO8nRUmt/BANjLHXczAOpzhR9N9+f5pbtDgAARwMnbQ2lsE2cFJjdRj/ib8g0w==
X-Received: by 2002:a17:903:41cb:b0:295:62d:503c with SMTP id d9443c01a7336-295062d55femr17995515ad.16.1761827404374;
        Thu, 30 Oct 2025 05:30:04 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d27345sm183660175ad.54.2025.10.30.05.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:30:03 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: alexander.usyskin@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] mei: bus: Add newline to sysfs attribute outputs
Date: Thu, 30 Oct 2025 20:30:00 +0800
Message-ID: <20251030123000.1701700-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rRh3zI3UBhdy0n0UfhMKrgDeF-jusnU4
X-Proofpoint-ORIG-GUID: rRh3zI3UBhdy0n0UfhMKrgDeF-jusnU4
X-Authority-Analysis: v=2.4 cv=M/lA6iws c=1 sm=1 tr=0 ts=69035a4e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=g8fQD90qLBClZepE2MUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwMSBTYWx0ZWRfX03WNxCfo9Fe4
 aX/Z997J7gUt5hOv1euoVi2SYXGmF++tCtU8vfeFIx4b0NbeU9Pc39lz55oS8OY94NV2zu7coAt
 3dMmQnHYmrR44NDIuZknMeQlpCy+LP4bGejQTokC+//39qhi7oZfMPxqvKDgZvFp/v4A+NlOgGs
 fKrpK0pAZ0c7QCOpuRoephD4zB/xQ62uM1xVFbuFSgsg0QFzWFUgnHeVps3Gj6nY0XPuueP3ap6
 zvzDZSp5HXEgo+vue8TvjivTD0Y2rYkyv6YEF0/Qb9D7Nb/QUJv57Mwd82monydroR5VRRgh2hc
 pg0TzzEptr5ll4MFrcqNnPtfNk9Sx51KBCqdCYJfmwU7TUiPH7HNKlYGR8DbvzvVCflJuyof6HR
 EPBghNpc2GM1LWRTyMatCZrrJz5Hfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300101

Append newline characters to sysfs_emit() outputs in func max_conn_show(),
fixed_show(), and vtag_show(). This aligns with common kernel conventions
and improves readability for userspace tools that expect
newline-terminated values.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/misc/mei/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 2c810ab12e62..8876c79bacfb 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1210,7 +1210,7 @@ static ssize_t max_conn_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	u8 maxconn = mei_me_cl_max_conn(cldev->me_cl);
 
-	return sysfs_emit(buf, "%d", maxconn);
+	return sysfs_emit(buf, "%d\n", maxconn);
 }
 static DEVICE_ATTR_RO(max_conn);
 
@@ -1220,7 +1220,7 @@ static ssize_t fixed_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	u8 fixed = mei_me_cl_fixed(cldev->me_cl);
 
-	return sysfs_emit(buf, "%d", fixed);
+	return sysfs_emit(buf, "%d\n", fixed);
 }
 static DEVICE_ATTR_RO(fixed);
 
@@ -1230,7 +1230,7 @@ static ssize_t vtag_show(struct device *dev, struct device_attribute *a,
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	bool vt = mei_me_cl_vt(cldev->me_cl);
 
-	return sysfs_emit(buf, "%d", vt);
+	return sysfs_emit(buf, "%d\n", vt);
 }
 static DEVICE_ATTR_RO(vtag);
 
-- 
2.43.0


