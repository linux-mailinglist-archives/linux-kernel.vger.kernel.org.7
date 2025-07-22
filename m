Return-Path: <linux-kernel+bounces-740239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A35B0D1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1981884391
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE128F50F;
	Tue, 22 Jul 2025 06:14:06 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFD22FF59
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164846; cv=none; b=tnUEfDnv1ROfXmgpdVmaZ0dR9plxuTVq0RhFmvHeb2VvhFqM7CAoSBIW99k1a41FjsKDhWwhZJf4gr0aM4PVQhs1ssCG1qqoLrKNK3WFGI+ssS5zTAC7MH73vWWmxwMqz9yMCoEgUYhrLzXDSu8qhvUrNASFKGBinDuz1kLusXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164846; c=relaxed/simple;
	bh=Gj9QaybhIqly2/7J7gq7nUvOuxTueMq+b67/K+Jmcdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qEXvyknlVuVlNueqTYEWVlxcKtJED+8gOr7WvbNGg8D7BBnk/3vD8dV4OBaDGL44tClPQ8a3UZOCdC1BLwFfnMIxxOWLqsN/M1f3VIDLj2/ttfnnLOsJXa94x+X89GXBJpjA+Vk6dGzk2tF9aiOyGAtyyn9lZO1qG88qf+maGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56M4EhO63321257;
	Tue, 22 Jul 2025 06:13:52 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 481vqmrcuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 22 Jul 2025 06:13:52 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 21 Jul 2025 23:13:38 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Mon, 21 Jul 2025 23:13:36 -0700
From: <changqing.li@windriver.com>
To: <namhyung@kernel.org>, <charlie@rivosinc.com>, <james.clark@linaro.org>,
        <irogers@google.com>, <linux-kernel@vger.kernel.org>
CC: <changqing.li@windriver.com>
Subject: [RFC][PATCH 0/1] tools/build: Let link command read option from file
Date: Tue, 22 Jul 2025 14:13:34 +0800
Message-ID: <20250722061335.285249-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XhnvlUYu9HJwNByTt9Ov9a9y13MaSc20
X-Proofpoint-GUID: XhnvlUYu9HJwNByTt9Ov9a9y13MaSc20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA0OSBTYWx0ZWRfX9HbNTfco+/b0
 JQOwDDWhvxOaSHEOHM5ZHtM2qdqFq/5KbcCDbRCYHuCgSp7/GnH6ZhlWcAXf6WpCA250k+ZiCgA
 x4jM2HJP0qRB2/6xc0c2XhuiNPRL1OFfWaJjD++K2ptdeDtW9WnabB2UmMfDCX9bmeO/aA/1IfK
 YxsMgr1DfsaoYgHoFK/yn55Muet3Y7Xm7NMQZyQHPIwFWn0kWNinbI6nRJe4BY/KiXgCkFW4M3x
 E7u2/RNBwe9eiD9N9UhjO3q4PqFYVFXyoChUncIDiRHICDLtM5q4nELY0glSRynKKr4M+I13bf6
 CdbbqIhiJt1cU7KOC+4Ubja5aXCBiarOJPsZZa9qSyXCBbHrlcSrl+b5KSjtS6sUqP+XA9viTVA
 cBisTN6J
X-Authority-Analysis: v=2.4 cv=BbrY0qt2 c=1 sm=1 tr=0 ts=687f2c20 cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=Wb1JkmetP80A:10 a=t7CeM3EgAAAA:8 a=snzuE9bSp9PWNWwjNH8A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507210183

From: Changqing Li <changqing.li@windriver.com>

Hi, Dear Maintainers

I am building perf with yocto project, and we don't want to put compile
object files to source folder, so pass O=xxx;

When we use a relatively long path like this:
O=/buildarea1/wrlinux-10.25/build/Virtualization/customized-WRLINUX1025_Nightly_Linux_systemd/250609-044304/lxbuilds/Harcuvar_platform_up/intel-x86-64-preempt-rt-glibc-std/wrlinux/build/tmp/work/intel_x86_64-wrs-linux/perf/1.0/perf-1.0

perf will compile failed with error:
| make[4]: /bin/sh: Argument list too long
| make[4]: *** [.../perf/1.0/perf-1.0/tools/build/Makefile.build:156: .../perf/1.0/perf-1.0/util/perf-in.o] Error 127

The error is from this line: "$(call if_changed,$(host)ld_multi)", 
Since perf have many .o, and when above long O passed,  if_changed will
evoke sh with long argument list.

So I try to fix this issue by this RFC patch. This is the first time I
touch this part, so the patch may not perfect, please help to review and
give your comments, thanks. 

Changqing Li (1):
  tools/build: Let link command read option from file

 tools/build/Makefile.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1


