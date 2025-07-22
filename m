Return-Path: <linux-kernel+bounces-740258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED50B0D1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068E51C20DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E27228CF41;
	Tue, 22 Jul 2025 06:37:08 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48346BF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166228; cv=none; b=iFsuom8L1+8CY/4Wn/Ktm9cMsg4tR5QmfaoD5ZLsmbOx8tw+Ml9dyTMA2gkqGEZ6aWDVgsrQ6YgAthEX/v2DQigaTdFfdVsN5WzcXSJbRLRDQy2mQLai5hg2Ji6u3YU3BArHxcaLc7dY/NB0LsM+BtDoq6W4jpST5Sjhci08Yrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166228; c=relaxed/simple;
	bh=jCVxSs5/ByMnfGQFjYimCBNfjmeace0P6sd54K5DxyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAJJlJi2yjccSEpnJfEVmGa816+9KnR7+uGKzFHGSPvoM+n/Pt6wCwVM6ckU8kDSDruX9p9rsb6FKxE+05wYL+m92nfbmy+0i5mPMRXMTksjOuOl9ez5fvuu91C4xunWH7/u0LIwESHYeBmKbtTSg7I6sRJuS44oV1SaPUmRPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56M4OXdD3385850;
	Mon, 21 Jul 2025 23:13:53 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 481vqv0cxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 21 Jul 2025 23:13:53 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 21 Jul 2025 23:13:41 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Mon, 21 Jul 2025 23:13:39 -0700
From: <changqing.li@windriver.com>
To: <namhyung@kernel.org>, <charlie@rivosinc.com>, <james.clark@linaro.org>,
        <irogers@google.com>, <linux-kernel@vger.kernel.org>
CC: <changqing.li@windriver.com>
Subject: [PATCH 1/1] tools/build: Let link command read option from file
Date: Tue, 22 Jul 2025 14:13:35 +0800
Message-ID: <20250722061335.285249-2-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722061335.285249-1-changqing.li@windriver.com>
References: <20250722061335.285249-1-changqing.li@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -jFbBqqelArViv3NDqMmVQQg6IKzQsjv
X-Authority-Analysis: v=2.4 cv=coubk04i c=1 sm=1 tr=0 ts=687f2c21 cx=c_pps
 a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17
 a=Wb1JkmetP80A:10 a=t7CeM3EgAAAA:8 a=qdclRBtFDC5OSZBgxNEA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: -jFbBqqelArViv3NDqMmVQQg6IKzQsjv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA0OSBTYWx0ZWRfX5uCl+xKuUeMa
 LU4oU8ZmJhNPqtAeSW+BEFZpnal4PxIUpPY2hMfVcLWcDemur33zbUsVb0pSN15AeLxntqwFceD
 QC0djQGwQbmjHM7tujmkMKl2IETFvwfln8k0d5+3Jx3Ly10Qz7cfhsglRtrFt0kT4y/XFXuumEV
 VToT9uercVEsQvQC5z/OaQzjvCCOuXtYeofO8gMg3UYTUb7VTS0roPedjf+r4JylqXMbvnzg66Z
 mABi8WoIgYEbZKMnwnrZzxuD/pAWOC+kJuSMOTUVCSXMjaBwjsVGkYwXhy+RyjMzm4G2Rx3FVeO
 EUEPU5JiL3UEH/oxO8TcxV3ISPmQvCvr4TFREZ0WeurdQpYN6JUzjpe5E7mhxv6t7lqmG947u/y
 vDrr++1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1011 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507210183

From: Changqing Li <changqing.li@windriver.com>

ld_multi will link multiple objects, when there are many objects, and
O=[absolute_path] is set, and the absolute_path is relatively long. It
is possile that this line "$(call if_changed,$(host)ld_multi)" will
report error:
"make[4]: /bin/sh: Argument list too long"

So make the ld command read option from file to fix above error. In
order to convenient debug, write the file content in dot-target.cmd
as comments.

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 tools/build/Makefile.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 3584ff308607..e57ce8c34685 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -70,11 +70,13 @@ quiet_cmd_gen = GEN     $@
 # If there's nothing to link, create empty $@ object.
 quiet_cmd_ld_multi = LD      $@
       cmd_ld_multi = $(if $(strip $(obj-y)),\
-                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(AR) rcs $@)
+                     $(LD) -r -o $@ @$@.in,rm -f $@; $(AR) rcs $@)
 
 quiet_cmd_host_ld_multi = HOSTLD  $@
       cmd_host_ld_multi = $(if $(strip $(obj-y)),\
-                          $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
+                          $(HOSTLD) -r -o $@ @$@.in,rm -f $@; $(HOSTAR) rcs $@)
+
+output_ld_multi_dotin = $(if $(quiet),,@printf "# %s:\n# " $@.in >> $(dot-target).cmd;cat $@.in >> $(dot-target).cmd)
 
 ifneq ($(filter $(obj),$(hostprogs)),)
   host = host_
@@ -145,7 +147,10 @@ $(sort $(subdir-obj-y)): $(subdir-y) ;
 
 $(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
+	$(file >$@.in,$(filter $(obj-y),$^))
 	$(call if_changed,$(host)ld_multi)
+	$(if $(strip $(any-prereq) $(arg-check)), $(output_ld_multi_dotin))
+	@rm $@.in
 
 __build: $(in-target)
 	@:
-- 
2.34.1


