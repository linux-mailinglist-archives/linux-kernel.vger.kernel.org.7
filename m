Return-Path: <linux-kernel+bounces-747745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC6B1378D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763A417076A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCAF1A316E;
	Mon, 28 Jul 2025 09:32:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DA31E4AB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695138; cv=none; b=JJd6GQ1tpWcrZ2wynIjsZozZsehlHZsnnscolGRInValXszB/2o1aFopsydrpVFYQbnGdGboY24aHHAdiBsTnslvli7WQs3uoayl/gV+a57A9Pi/4+tDJ5vtG5HO9s9gKehH3KOqCWovWXiamZvF1h1wwFHGfNQobQXRBayeP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695138; c=relaxed/simple;
	bh=eksEz9DNPzwUs8IiRgjj2ibqU2hzBNPGLV8Wa4eqZ7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdO84tw85YTYbudGaFa4r4MitN+FJy9wYIkp3qKT1ax21QJn2x5ony/YLuQTvbUzmkRFpAP5PFFm4grtYUQAbcMZa2OZwf8tGqzFSimaLJlr99q+djFwt8D8Mmfdi8R5eJbF9RXDsrBTVzt2hfYbK1MBwpI2FVYG5ryLjP+5tGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56S5t1AH1480006;
	Mon, 28 Jul 2025 02:31:57 -0700
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 484ta1sa8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Jul 2025 02:31:56 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 28 Jul 2025 02:31:55 -0700
Received: from pek-lpg-core6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Mon, 28 Jul 2025 02:31:54 -0700
From: <changqing.li@windriver.com>
To: <namhyung@kernel.org>, <james.clark@linaro.org>, <irogers@google.com>,
        <charlie@rivosinc.com>, <linux-kernel@vger.kernel.org>
CC: <changqing.li@windriver.com>
Subject: [PATCH] tools/build: make in-target rule robust against too long argument error
Date: Mon, 28 Jul 2025 17:31:53 +0800
Message-ID: <20250728093153.2330009-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R_EhvhvK3IdvKDr3Z04dM4x5PfYoPgRY
X-Proofpoint-GUID: R_EhvhvK3IdvKDr3Z04dM4x5PfYoPgRY
X-Authority-Analysis: v=2.4 cv=OYOYDgTY c=1 sm=1 tr=0 ts=6887438d cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Wb1JkmetP80A:10 a=t7CeM3EgAAAA:8 a=ZsBBRxGF-X5fSI_XCv0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA3MCBTYWx0ZWRfX9BsPh3RwjaXf
 YlRnJN80V9rrRCi88//aT7rx5ktK/l6TsEIfeUXscT24bZPICde/n5e79zT8l+aWjGX7nC3T3FH
 c+Y2XP79tuV/97UbuqD1KkfEBDhqNxr95N9aknpqm+zV4boKGxjQoBtW5D0o0J9m/N0aO+bC1jl
 dv9woPhhXC4BvT0Za+96B4Qdkgr8T4gg2dqP/5bKlHKopoWacMK8/ebGQDVSHtcpLMXp14PD4PF
 PGGTdk2MGMc4dl+s+yJUkLzQGOpCWwHg46olEW6MUAmhaCbFJwKPNxrwgUtQEZQT7zy+90ecn2C
 2nHwY5C8UOKRy/ThDk1ACpcikTw+eumOrGJvX3NqSxb3Bi37UNIrTlGDElk77cB6GD2E30aZaOG
 /RoaULVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507260059

From: Changqing Li <changqing.li@windriver.com>

The command length of in-target scales with the depth of the directory
times the number of objects in the Makefile. When there are many
objects, and O=[absolute_path] is set, and the absolute_path is
relatively long. It is possile that this line "$(call
if_changed,$(host)ld_multi)" will report error:
"make[4]: /bin/sh: Argument list too long"

For example, build perf tools with O=/long/output/path

Like built-in.a and *.mod rules in scripts/Makefile.build, add
$(objpredix)/ by the shell command instead of by Make's builtin
function.

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 tools/build/Makefile.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 3584ff308607..39066a3ef2fc 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -70,11 +70,13 @@ quiet_cmd_gen = GEN     $@
 # If there's nothing to link, create empty $@ object.
 quiet_cmd_ld_multi = LD      $@
       cmd_ld_multi = $(if $(strip $(obj-y)),\
-                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(AR) rcs $@)
+                     printf "$(objprefix)%s " $(patsubst $(objprefix)%,%,$(filter $(obj-y),$^)) | \
+                     xargs $(LD) -r -o $@,rm -f $@; $(AR) rcs $@)
 
 quiet_cmd_host_ld_multi = HOSTLD  $@
       cmd_host_ld_multi = $(if $(strip $(obj-y)),\
-                          $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
+                          printf "$(objprefix)%s " $(patsubst $(objprefix)%,%,$(filter $(obj-y),$^)) | \
+                          xargs $(HOSTLD) -r -o $@,rm -f $@; $(HOSTAR) rcs $@)
 
 ifneq ($(filter $(obj),$(hostprogs)),)
   host = host_
-- 
2.34.1


