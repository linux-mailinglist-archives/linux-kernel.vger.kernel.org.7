Return-Path: <linux-kernel+bounces-817264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979AB57FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCB94881AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE92E341655;
	Mon, 15 Sep 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UW0QNoai"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018532CF6C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948679; cv=none; b=OvgnDq4tSRb2oC1FtiAmLifS5WdckB6oQ1vx9Zeg54khFtR0I6kHKkdp9rb5K3sh3GiV8F7AF/FKn2kTyWs3SlMP0dibKDbWGTgUq0AHBjVdwf2gVKdPenDYeoALBE0f/qlvbN0E64dSzw8raPpE2gQ3PwzftcnhFAfwKLxOkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948679; c=relaxed/simple;
	bh=vzbUEIw2iUn2B4Ydfrx8OSuU4DUygCaImhIiVKOVNa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af1JMM+1fgGNjMY1aqRKRfr/zPaanWUthpqIubAJxZyMQM2lY+m/D1YIIi6h5h0jYyP+tA1wr7seTTK17iRBnatnjvhbHW6hE1L/qEoT9xSEeceeQ8xHhPts3B12PIqP2DSSb60lyYY9qqjHAmIa5J8RXGcZUh0oSxPPsMkF0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UW0QNoai; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9OwQu018078;
	Mon, 15 Sep 2025 15:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gjwWWY9wvYaNKY8EA
	A5KtNvgSNU+KKcZ8lUbtsSE45U=; b=UW0QNoaiPu8PZn8HDb8Zq2028URKtOZIq
	IjrLxDxa2AW7gTsIAxuVm+JggSRMg5dANDJcnR69NVkIUSWuZvVCBFCyoLtVSjiz
	azMEZzMai+Ie6nawEpB6CEpM3wDgnqgcXEXAubRpengn5r9qXB+BzRwQMZaTfCZa
	4lelEt2ytcvqwUhIYNplG8A5+Jzp5d8uMtlibjWNVS8FGGD7ZfmxqNkgEN3Jk27h
	8fLkPerTN4ilKu+DmZMlXYqk0bvl5Z8AHoUURZfMW+TP3AB2yo7RavfqTmfoFqmF
	KJT3ZE5O+IjmUb15oUXrHGv6Zz9bR5uZ5PHzOapYuxceIhiW5NDjw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g531rdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:29 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FEnJdb002136;
	Mon, 15 Sep 2025 15:03:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g531rdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCQYO5008988;
	Mon, 15 Sep 2025 15:03:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn36pm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FF3O1r42533242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:03:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D841E20043;
	Mon, 15 Sep 2025 15:03:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0371A20040;
	Mon, 15 Sep 2025 15:03:22 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 15:03:21 +0000 (GMT)
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
Subject: [PATCH v2 3/3] selftests/mm: Added fork test to verify global ksm_zero_pages counter behavior
Date: Mon, 15 Sep 2025 20:33:06 +0530
Message-ID: <5910cb6bfc7c43b169b679a0108667a56d7ebdb8.1757946863.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757946863.git.donettom@linux.ibm.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZXyxwX1ucZr2gUZwipFy9t7yA4Xbn7EM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX4G5L7Xf8orpF
 YrFigQN0bXgzJCxVV7kr3vYqAtOCkAMRmoN1Dyi/zv3wNRrgmP3trUgqVDAf1zqGeNwlwGLpkeu
 sW7I7G29lLsmw4sCAE+SacaAQw5FN41DCLe6/zO5GVY+0EZMl1hc2jgbrwm3PV9ALJd17QMz7a2
 nGZ8RIX37iwnTfBMlbh2jMXIYTkAJT3tgL7jv54g4UB6KHeMDNFzsQhn8L3fPb0p1qyssitq1BE
 GV+Sf000ZYaLxcJjk/DaWmUM+Rch/YFTFkCzcx570hdk+4vHdrYCEJhyiBlPhP0v/MvY/U9+Rhs
 ppXe7x+TxswxlYPGVBCL9gyXgJk1oXg9fqp57LO+1sP6Ca5RF9t+2MN6JtyjJHmcM2Zg0MiJWBg
 l4WfQjmd
X-Proofpoint-ORIG-GUID: KlHLGoZtd7BO7u8AJEiCdnV-7phG6b92
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c82ac1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=2YreOkuNpnKIDl0BDdwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

Added a selftest to verify the behavior of the global KSM zero-page
counter during fork. When a process forks, the per-process zero-page
counter is inherited by the child, and the global counter should be
updated with this inherited value. This test ensures that the global
counter is correctly updated after fork.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 74 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 645cefba2126..f23597ac8066 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -602,6 +602,77 @@ static void test_prot_none(void)
 	munmap(map, size);
 }
 
+long ksm_get_global_ksm_zero_pages(void)
+{
+	int global_ksm_zero_pages_fd;
+	char buf[10];
+	ssize_t ret;
+
+	global_ksm_zero_pages_fd = open("/sys/kernel/mm/ksm/ksm_zero_pages",
+								O_RDONLY);
+	if (global_ksm_zero_pages_fd < 0)
+		return -errno;
+
+	ret = pread(global_ksm_zero_pages_fd, buf, sizeof(buf) - 1, 0);
+	close(global_ksm_zero_pages_fd);
+	if (ret <= 0)
+		return -errno;
+	buf[ret] = 0;
+
+	return strtol(buf, NULL, 10);
+}
+
+static void test_fork_global_ksm_zero_pages_count(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+	pid_t child_pid;
+	int status;
+	long g_zpages_before = 0, g_zpages_after = 0;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	/* Unmerge all pages before test */
+	if (ksm_stop() < 0) {
+		ksft_test_result_fail("KSM unmerging failed\n");
+		return;
+	}
+	/* Get the global zero page count before test */
+	g_zpages_before = ksm_get_global_ksm_zero_pages();
+	/* Let KSM deduplicate zero pages. */
+	map = mmap_and_merge_range(0x00, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
+	if (map == MAP_FAILED)
+		return;
+
+	child_pid = fork();
+	if (!child_pid) {
+		exit(ksm_stop());
+	} else if (child_pid < 0) {
+		ksft_test_result_fail("fork() failed\n");
+		return;
+	}
+	if (waitpid(child_pid, &status, 0) < 0) {
+		ksft_test_result_fail("waitpid() failed\n");
+		return;
+	}
+	status = WEXITSTATUS(status);
+	if (status < 0) {
+		ksft_test_result_fail("KSM unmerging failed in child\n");
+		return;
+	}
+
+	/* Verify global zero-page count remains unchanged */
+	g_zpages_after = ksm_get_global_ksm_zero_pages();
+	if (g_zpages_before != g_zpages_after) {
+		ksft_test_result_fail("Incorrect global ksm zero page count after fork\n");
+		return;
+	}
+
+	ksft_test_result_pass("Global ksm zero page count is correct after fork\n");
+	ksm_stop();
+	munmap(map, size);
+}
+
 static void test_fork_ksm_merging_page_count(void)
 {
 	const unsigned int size = 2 * MiB;
@@ -659,7 +730,7 @@ static void init_global_file_handles(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int tests = 9;
+	unsigned int tests = 10;
 	int err;
 
 	if (argc > 1 && !strcmp(argv[1], FORK_EXEC_CHILD_PRG_NAME)) {
@@ -692,6 +763,7 @@ int main(int argc, char **argv)
 	test_prctl_fork_exec();
 	test_prctl_unmerge();
 	test_fork_ksm_merging_page_count();
+	test_fork_global_ksm_zero_pages_count();
 
 	err = ksft_get_fail_cnt();
 	if (err)
-- 
2.51.0


