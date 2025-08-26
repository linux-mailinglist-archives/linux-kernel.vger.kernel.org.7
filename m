Return-Path: <linux-kernel+bounces-786645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3560B35F89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09431BA4182
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754C12CD88;
	Tue, 26 Aug 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bUFhIR/D"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FF770FE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212601; cv=none; b=GFW3pWaGZS3ekftyLgWaOtJzOM7TbroyroeogVvjtWFG0KiiGss4MoSrmkh2QR99dBhBBH43WkLZTeKb6M8d+mIxeus8pytOzkzgcOIyR7T26L7h5EpGXiYmg/gTMUB2VTmzDzj94PdxOm2JjACPIp2LZXAZlqK1D+7kKedNGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212601; c=relaxed/simple;
	bh=m4QO/+99GlsZDCOiRlBo9cvlA1TD3QjOBvC6i+KvjWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdDr8WvZxRaGuBivvCLnKEFe/1U3jTEckjmczRJGXo2+QkLwpkX91Ad+uj0eASMdghQsZyEDQqZcJbq2cAhCTxHq14KdF9WdVvw175HfT+OrbhYQgQYljdDubxt5ANCWSUqw0XJ7chw0z+A0AaKB7kufOOBgxb1Nb3+mgbmebzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bUFhIR/D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCAhZC024902;
	Tue, 26 Aug 2025 12:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+belWiZUDk9fLOgXU
	HzO6ceN18vMAuWZJInY/ST2zkE=; b=bUFhIR/DQv/8PzoNRFyj5Xc4ZknlOgBfR
	4U9jjSlERU42kpXBspa+ZiBefz8SUzNa3ysB7mMzv6KNpzkmeZy26Ft0nJKXlAdI
	LGIMkuTlTuhWpwGq+iUPPFJZGwmsaIcacAuPHKtbydGb8fMg9Qn2VFgFCHWzcJIr
	hOtiXopV2xoyALw4g+HdLly4Q6aNf5WVUFlv7OLQ4dOcnefjLxkAE3nkOtWoYzrA
	IWCKBbAer7qUi/Z+mfjf/XYTN9+BXh3R9BMl6bYB87SZXzITBpRTGRKmRXLqECkh
	uJMb/BZ1TBuOgjtGIVrUr32Ldzrc1DeQORD3yJ4jSW72kbrXUVCkQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q557xk8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 12:49:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57QClRbG014723;
	Tue, 26 Aug 2025 12:49:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q557xk8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 12:49:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57QAVQGI007514;
	Tue, 26 Aug 2025 12:49:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyuax0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 12:49:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57QCnWOW48627974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 12:49:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7375020043;
	Tue, 26 Aug 2025 12:49:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3056920040;
	Tue, 26 Aug 2025 12:49:30 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 12:49:29 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH 2/2] selftests/mm: add fork inheritance test for ksm_merging_pages counter
Date: Tue, 26 Aug 2025 18:19:22 +0530
Message-ID: <88d6d5f08ff119625fa9accaa7b849dd77f9df25.1756211338.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
References: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VkolPkvh0DsD7H5lXlA_g6Umvua8Zct4
X-Proofpoint-ORIG-GUID: vWrApFb4qKyKmWTUoxuW81NgIsitET3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX+VxFFVNdJwl4
 2AVY4r8Aycp0hT8Fv3v5EEMog5yTYcFmj08ERY1G+7kHPoG1EOInsASwjaUgsU+RqGxjW469Qh5
 BVll4w45+mDSf9l0Wk53ekNYqXfmrOOLwXEZBt/VoYKwppG0C+8Bo/W/I6uGkrRdl2n43f3P2Gw
 z01EpUMVkMeccByikiQHFkpNEC0kUXeXo3Z/hJebPWQSnl2i7sIMn/xphIwd9wfGu7ipWm5BO76
 kKPD0KA2jEO+gXr/1EFSqjy47W8rGS7i1le/xtp9Bm7EyoQJzj3oRlVXJ5Cyt5zEd1jnT1rXdPT
 6aTd/mOZP9py9TNQtjXyp26tnC6OQ+dJxbIDkQ9Wsuk/jmf4OS1skcqgg/s5Hvwn0STrI/jXiv0
 nVpOhPWB
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68adad61 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=mq3xLqhzurGmh3fbWqMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

Add a new selftest to verify whether the `ksm_merging_pages` counter
in `mm_struct` is inherited by a child process after fork. This helps
ensure correctness of KSM accounting across process creation.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 712f43c87736..d971394c9567 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -602,6 +602,45 @@ static void test_prot_none(void)
 	munmap(map, size);
 }
 
+static void test_fork_ksm_merging_page(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+	pid_t child_pid;
+	int status;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
+	if (map == MAP_FAILED)
+		return;
+
+	child_pid = fork();
+	if (!child_pid) {
+		int mpages;
+
+		init_global_file_handles();
+		mpages = ksm_get_self_merging_pages();
+		if (mpages > 0)
+			ksft_test_result_fail("ksm_merging_page in child: %d\n", mpages);
+
+		exit(0);
+	} else if (child_pid < 0) {
+		ksft_test_result_fail("fork() failed\n");
+		return;
+	}
+
+	if (waitpid(child_pid, &status, 0) < 0) {
+		ksft_test_result_fail("waitpid() failed\n");
+		return;
+	}
+
+	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
+
+	ksm_stop();
+	munmap(map, size);
+}
+
 static void init_global_file_handles(void)
 {
 	mem_fd = open("/proc/self/mem", O_RDWR);
@@ -620,7 +659,7 @@ static void init_global_file_handles(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int tests = 8;
+	unsigned int tests = 9;
 	int err;
 
 	if (argc > 1 && !strcmp(argv[1], FORK_EXEC_CHILD_PRG_NAME)) {
@@ -652,6 +691,7 @@ int main(int argc, char **argv)
 	test_prctl_fork();
 	test_prctl_fork_exec();
 	test_prctl_unmerge();
+	test_fork_ksm_merging_page();
 
 	err = ksft_get_fail_cnt();
 	if (err)
-- 
2.51.0


