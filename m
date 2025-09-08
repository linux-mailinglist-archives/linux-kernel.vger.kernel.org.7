Return-Path: <linux-kernel+bounces-806654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E6B499FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB0D189B23C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E50298CCF;
	Mon,  8 Sep 2025 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NtgJlyc6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC828DF07
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359834; cv=none; b=KJfDfY9DjoUmWjajDBn3w38O+rrTb/iLTLRQfM98MeV+++bZCKj4oTPoyKruEwVc0urVafOJ5alOj+IUEYXO0IdTQv+dOw/CLjV1dcGsmXb1HSY8xQs7hIIeZlZm7/fqRDKRsla5za9OvLR8472st/K4ULtlM56m1dXnop4CANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359834; c=relaxed/simple;
	bh=r6ewte+QXBJPpj8cnQNpEV4UwDBHQ8RB9VsvMSfV3mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRHGfZfoksLSM4PTNH65cllFg7Xh8cNCgz5tV+oJOzrV4YsL1A8vy030MGm38X+gBpCu6aA+3ea2T5DxJyWCjRaHY4RmR7YZ/2JQmyuJOE6Gna1khrGJBY78IECIfCJ2wqBbjaMJBKHgDDFC88cecHUFGuw8lRfTlpcmyX7ClI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NtgJlyc6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Dv8tU005880
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 19:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1dRH/lT2me3
	Z6a7qND3TTo53lBcXKiMdwvBOwRXxAeI=; b=NtgJlyc6493cStiodyZRj1BBxxn
	AnRFOx5yDukL//iyajuz5djELscTX/hpTegBneOfHfu6Wako+bRzQ6dqst/n6Ko+
	dcpXZlBTcFygWB8KFUkYLSKcmO4MWvFdlOqAzAN1jJsmakw4bpKA6n0axT9Y1YCD
	GOUzqOSZ4oXFpgaGsc2VvIi6s93Yp0omEDXNTCRmhn6fi/fGZWYJKX/L3p/ICkts
	jBXyfWtYXVsfO4Ggd97xovqn3nIdhsmXaR2a1DJZWfRcY/+XWodqYcssQDvDEEaB
	UDX7zW55OwinprONeGeIawwin45JoH5GD8PMuozkEF1gntUt0TXNWIH0haQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37t7sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:30:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458274406so97295815ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359831; x=1757964631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dRH/lT2me3Z6a7qND3TTo53lBcXKiMdwvBOwRXxAeI=;
        b=RVVoGQBDVzHLho7acAVsztZqXrSs+Dm9IvcM5UZbCnFq1zVBKSxADsJLSB0Re7nO5I
         i5FSwdpSqfx99nlxTN1jrzd57/wPzjV/AhJyU2rXzr4XTA6qm9pLTxtSIzVPwRcBenwe
         N+tubRErjVY3sZ76fC4a3S8hL1+KbGqwz/2i+mCYbhKpzVWlj9C0mhI03D/otnUTlDK/
         gWvF5pQerTP3s3yJkgUugBCwgAChqt/SzbJIOYZ+v+MYhPtGdIXuvfW+n/SW5t8SD9Cm
         VHXugO2alSfUBr6eqrqg+0DgPTZpz3o92FKnZGCXGkYalMt054ZfoQkW30c7a2egeRPA
         UWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxMmO0OVuksjhWRyaoYW1bRdrJtGjpqd6KX6mFntX6W993E/nZqSlE34hWFzCuF7U6llrzlFwZlabnANY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOHdpMr6FCVoPcQFbblb9KZAh3L2y7zYYivsXDrKPeu0fdODk
	KD5LyuWsSOu8YbhVM6W5RvqudzBLdVpdR6syLhljSr9oNk9E9H5uUsWQuavzMAWu/VgNz12rCvI
	Jo7scTgDaixGEZmtiTT28P2M6II+Dc3Da8ks1t44TobxlHt+uQJA9IyVx4oTKpztBgxE=
X-Gm-Gg: ASbGnctHppVayChK9MqUOBOQweHNMqkcC8+BgQJxML+9zG3yANaNONCw2us8A7+rXzG
	rHeUrBxgke2PVgsijWQxi9rSunIwUxpUmTu5KlzMypnbM12NffqiN4tB4/n8dB2CaKfE28oE8WQ
	7y8Uc1Q0z3ZLvgak3uLhliq6vShsCMKfESLXJjhhYjThWXmmU05+0duWnbInFYRRtAnhYXBQgTL
	Ls8di5WCup2hVqKt914BgXE2a2wXiNCUabCPOWWTYVPyu9OQAkN8TMtMNWJ+wwZUHSgH2JNVdbv
	4kM2OXSneVLxiv0oTd6vgjdX5FF9KbFWVlDyhCznTIzGyvB9ltQ=
X-Received: by 2002:a17:902:ebc4:b0:24a:9490:545e with SMTP id d9443c01a7336-251736deeb6mr143046515ad.29.1757359831270;
        Mon, 08 Sep 2025 12:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLIdlvQXqWUV6AKuuRDP9+kqFt4lIskYliw2ng0ftyhMrTn2DkBqizO9tSwG1erU4oORzE9g==
X-Received: by 2002:a17:902:ebc4:b0:24a:9490:545e with SMTP id d9443c01a7336-251736deeb6mr143046225ad.29.1757359830839;
        Mon, 08 Sep 2025 12:30:30 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11becab2sm183669505ad.61.2025.09.08.12.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:30:30 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm/msm/registers: Remove license/etc from generated headers
Date: Mon,  8 Sep 2025 12:30:04 -0700
Message-ID: <20250908193021.605012-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
References: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7b5hWbpuhRgv7NmLWX2jls51_BP4HqFx
X-Proofpoint-GUID: 7b5hWbpuhRgv7NmLWX2jls51_BP4HqFx
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68bf2ed8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=24meVJ-eaxx8ovD9fTgA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX4Rd8NwakFl3E
 3/50trwDSGrfi89WlolDXRvLYE98iiLFfISQhCaJRGwR95Vdr3Al6+Gy5XGW3eRZYxohTnDwal4
 I3uo968dmlTNsf2YgD79dB1f4wdQvjkJWHxZuM7DHk5hOC52AgiGVzqhZZt0ZJRbADjIXR52LxE
 L8uqHV6iut7NHeu3I/t+i9RWm6uCl4SCALkxGQtmOSrygNtC1Pt5ur/ACIIfqNwA8nmgU6K3MSc
 zTv/aVI7m5UFaGdZq0Wnzw1H/5V8qkWk3EH4ZKJMSWl53oysis4aG64dQlu8pxbkxzuhTr8o+Cv
 R84Lru+gQgXCpt/DELrhHGI/LWJ8L/frmyv5WkpLRAZ+Bo/BO8YaFytitUKKFdcx5F4l7zJwWK7
 TXRthrIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Since these generated files are no longer checked in, either in mesa or
in the linux kernel, simplify things by dropping the verbose generated
comment.

These were semi-nerf'd on the kernel side, in the name of build
reproducibility, by commit ba64c6737f86 ("drivers: gpu: drm: msm:
registers: improve reproducibility"), but in a way that was semi-
kernel specific.  We can just reduce the divergence between kernel
and mesa by just dropping all of this.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/registers/gen_header.py | 37 +--------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/gpu/drm/msm/registers/gen_header.py
index a409404627c7..56273a810c1d 100644
--- a/drivers/gpu/drm/msm/registers/gen_header.py
+++ b/drivers/gpu/drm/msm/registers/gen_header.py
@@ -444,9 +444,6 @@ class Parser(object):
 		self.variants = set()
 		self.file = []
 		self.xml_files = []
-		self.copyright_year = None
-		self.authors = []
-		self.license = None
 
 	def error(self, message):
 		parser, filename = self.stack[-1]
@@ -686,10 +683,6 @@ class Parser(object):
 			self.parse_field(attrs["name"], attrs)
 		elif name == "database":
 			self.do_validate(attrs["xsi:schemaLocation"])
-		elif name == "copyright":
-			self.copyright_year = attrs["year"]
-		elif name == "author":
-			self.authors.append(attrs["name"] + " <" + attrs["email"] + "> " + attrs["name"])
 
 	def end_element(self, name):
 		if name == "domain":
@@ -706,8 +699,6 @@ class Parser(object):
 			self.current_array = self.current_array.parent
 		elif name == "enum":
 			self.current_enum = None
-		elif name == "license":
-			self.license = self.cdata
 
 	def character_data(self, data):
 		self.cdata += data
@@ -868,33 +859,7 @@ def dump_c(args, guard, func):
 
 	print("#ifndef %s\n#define %s\n" % (guard, guard))
 
-	print("""/* Autogenerated file, DO NOT EDIT manually!
-
-This file was generated by the rules-ng-ng gen_header.py tool in this git repository:
-http://gitlab.freedesktop.org/mesa/mesa/
-git clone https://gitlab.freedesktop.org/mesa/mesa.git
-
-The rules-ng-ng source files this header was generated from are:
-""")
-	maxlen = 0
-	for filepath in p.xml_files:
-		new_filepath = re.sub("^.+drivers","drivers",filepath)
-		maxlen = max(maxlen, len(new_filepath))
-	for filepath in p.xml_files:
-		pad = " " * (maxlen - len(new_filepath))
-		filesize = str(os.path.getsize(filepath))
-		filesize = " " * (7 - len(filesize)) + filesize
-		filetime = time.ctime(os.path.getmtime(filepath))
-		print("- " + new_filepath + pad + " (" + filesize + " bytes, from <stripped>)")
-	if p.copyright_year:
-		current_year = str(datetime.date.today().year)
-		print()
-		print("Copyright (C) %s-%s by the following authors:" % (p.copyright_year, current_year))
-		for author in p.authors:
-			print("- " + author)
-	if p.license:
-		print(p.license)
-	print("*/")
+	print("/* Autogenerated file, DO NOT EDIT manually! */")
 
 	print()
 	print("#ifdef __KERNEL__")
-- 
2.51.0


