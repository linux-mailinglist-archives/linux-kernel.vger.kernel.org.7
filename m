Return-Path: <linux-kernel+bounces-829509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE3B973CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C52A5FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAE2E03F3;
	Tue, 23 Sep 2025 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BVC648B9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A0F20A5C4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653276; cv=none; b=P/1r37oD/5dy8j5Zv98DQdJ/klqjZpZVGjr55NKoiT9Bwd88mSi5Mm2GYeFK2th66RWLXODpIwQKdRV7VNb36Qd/EyK+DzSM0XV9c+4jqaMhMhGnyQwFss1AMIGdq9QoMv6mw0eSuP4UTO9NL5rsOcp9TK+NhGO+AFwPD9c5ZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653276; c=relaxed/simple;
	bh=cy98AD+VvA17EAgjEI6Mid/6jxyY52MxEfyhK67L+9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO0wvIGhgVp4v9i2qNbJYwWTCPB3fUzSc/P4TrkqaG5vQ2OB4LiVhlRfVe3qnXhMR6TnMxYCpAjUl8jabTzaRBtpfE03voal4xcw581acyDMusdfSgzAoabfMtTGYLOtClDx6wu2lThtprfTvRY1iaUf/rzCyRkV/InPGroOd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BVC648B9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NGWFMC001810;
	Tue, 23 Sep 2025 18:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HWyBjhPVJ9kEj0HOT
	4mbQ4gfG9Y9bTTGVqTNTNBk6tY=; b=BVC648B9HlQljWqjRK/jiReSAc1o886UC
	YyS4reWADYAbpByN/hQpk0FOGhLHWM3h5mps2AngAFiOXIY6Ppveu/SuDeeq1+65
	pTwCS2l+OLnSA+ImWCG2IY5HVeHJ6jziwJu91G9PiT1XWLxeCiVZerRMnQIBdqDb
	tHcZGt8ynYUyd6N/5rML0RXSuAT9z/ppcAk3BIyv8EAydbqy9ufKulJRDXpWgHNe
	ZrQ1YV3jN/V4N4sLSW1yMk/B+6IGvd0HZzcpqYbOAByqndiqOd4uSa0/b8IlGEAN
	PHbkYnqoMXTZ+hxGuD2NsLymWctm3hiPcrKeu5Y2L1N84jjQZp7rQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqavsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:35 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58NIXptq026441;
	Tue, 23 Sep 2025 18:47:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqavsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58NHB2KJ030356;
	Tue, 23 Sep 2025 18:47:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a14ptr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:47:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NIlUPG31850796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 18:47:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E33A20043;
	Tue, 23 Sep 2025 18:47:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D66DB20040;
	Tue, 23 Sep 2025 18:47:27 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown [9.39.28.7])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 18:47:27 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
        Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v3 2/2] selftests/mm: Added fork inheritance test for ksm_merging_pages counter
Date: Wed, 24 Sep 2025 00:17:00 +0530
Message-ID: <e7bb17d374133bd31a3e423aa9e46e1122e74971.1758648700.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758648700.git.donettom@linux.ibm.com>
References: <cover.1758648700.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d2eb47 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kDUdi5sUuU8vu5WplE8A:9
X-Proofpoint-ORIG-GUID: vlt0YarwwCCxvHbw-JMZk4CEYbXmuZA8
X-Proofpoint-GUID: a1KWKaFoKTLeUCEZkN4FVGuLStWLiyIR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX6m/w6mNclBpP
 mncaMBnW6ImU+kpNZquOQScJDv76v9VLQr8mDpW0eDqVf5ekUqARuljD6GzslFba1aOngp8Biau
 q7z0UlD24w+YWAHqcKGjL4txIWGFjzJEu3H1dXtG1kGxX1H9P1khPgUBYdkjxoT4tAgSk+OLu+D
 mW+ipyyXalQqM2vVisSNC8hbgB+PEP9OFBX2wM8lmbQK8cfE0342o1X/oH6TJBwBUS3Wig/HKYA
 7wYM7PqByMsMsAKzCro3Esm/1fRvh5IHwHjcXtSw5Ea1PPqLLkhh9OtntPfwa3PGFLud6EuT/QK
 sQtK63L1Hf4v1dhC4uXJ5WaEIoDArns8Kz9n9qF4rGV6lXXzw1RfEjMXWGtD8ugkzjeLkn6KeB3
 S5w+AZrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224

Added a new selftest to verify whether the `ksm_merging_pages` counter
in `mm_struct` is not inherited by a child process after fork. This helps
ensure correctness of KSM accounting across process creation.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 712f43c87736..ac136f04b8d6 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -602,6 +602,46 @@ static void test_prot_none(void)
 	munmap(map, size);
 }
 
+static void test_fork_ksm_merging_page_count(void)
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
+		init_global_file_handles();
+		exit(ksm_get_self_merging_pages());
+	} else if (child_pid < 0) {
+		ksft_test_result_fail("fork() failed\n");
+		goto unmap;
+	}
+
+	if (waitpid(child_pid, &status, 0) < 0) {
+		ksft_test_result_fail("waitpid() failed\n");
+		goto unmap;
+	}
+
+	status = WEXITSTATUS(status);
+	if (status) {
+		ksft_test_result_fail("ksm_merging_page in child: %d\n", status);
+		goto unmap;
+	}
+
+	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
+
+unmap:
+	ksm_stop();
+	munmap(map, size);
+}
+
 static void init_global_file_handles(void)
 {
 	mem_fd = open("/proc/self/mem", O_RDWR);
@@ -620,7 +660,7 @@ static void init_global_file_handles(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int tests = 8;
+	unsigned int tests = 9;
 	int err;
 
 	if (argc > 1 && !strcmp(argv[1], FORK_EXEC_CHILD_PRG_NAME)) {
@@ -652,6 +692,7 @@ int main(int argc, char **argv)
 	test_prctl_fork();
 	test_prctl_fork_exec();
 	test_prctl_unmerge();
+	test_fork_ksm_merging_page_count();
 
 	err = ksft_get_fail_cnt();
 	if (err)
-- 
2.51.0


