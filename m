Return-Path: <linux-kernel+bounces-817262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071FB57FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884CB3B1127
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3B327A2E;
	Mon, 15 Sep 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VjQcyFpo"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1432EF660
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948677; cv=none; b=eikCNkhhLIfTtxN2Z9BfAUA7ecHSRVBFJn2vfq5qgb8/jgU8SgqoNT6t7g8Rq980Gb3WdVHwpsg1k6Hvk/fQ2tnooImAATh5KevQ5t/iOfr0L3khAPEcmJe2qX8L/GhEi5K7bH//7oPjzv6UjIAU7JMEDChF/FumhlC4+zFAWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948677; c=relaxed/simple;
	bh=AZ7b2JeJTAqtynIeaDLZVyjhP/pXsPwUc/fqJQVYrIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOm9Dlw42F1GYxjWIo5th995IAh/HibMO8rXgW0diflyrorRirFdehvDlYteXj3oNvXWyNZoZD2Q2qY9yaedJ2jxtwbskdeg76YexGi/vI7IgAMg1WVY0TEgCAfc40cayzlecIq5OUBb7hFy+2kR9C9gueL+KVBO0dQ8c7TnjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VjQcyFpo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9b9TH018951;
	Mon, 15 Sep 2025 15:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mw9l3ATox05SMSrOa
	VD6dql5/r3vydDIVDHsMiAYBH0=; b=VjQcyFpoA1Ov14qYqNziq/EnNCZ6O3cbR
	TdIKtbvqH0w180I0vqhxd7QgbpHnN6Lo58oNPCK2mRnce7VStmEMt7Ehh1m4oYr2
	/GZtcrWVI6LzcYr+nVehpSpEYTdAJEetQA5gEii705h/uv3YUq1deX7H0oCMvMGl
	JKzH0LX50OWJxwEqleXlr+m6lX0YLpJTSIi1RJyHSWn0Zlb0BByXlx6HjKcC65Fq
	Ok5A+0v2NUvVpL4zOnJOW2fNwLy8UPOooZR1LG5bxVkPjYU9N7ie0XdHjjtzpoV9
	yVg6dOCxfZ5Gv9oBtFbfhlxc+rWUpvfgXNNoVTqjBhouDdjnRUy/w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat1pyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FF0UUB032168;
	Mon, 15 Sep 2025 15:03:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496gat1pyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FBWauU027276;
	Mon, 15 Sep 2025 15:03:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495memxxr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 15:03:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FF3Kim51052992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:03:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C08CD20043;
	Mon, 15 Sep 2025 15:03:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01F6720040;
	Mon, 15 Sep 2025 15:03:18 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 15:03:17 +0000 (GMT)
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
Subject: [PATCH v2 2/3] selftests/mm: Added fork inheritance test for ksm_merging_pages counter
Date: Mon, 15 Sep 2025 20:33:05 +0530
Message-ID: <f07c901d4b6b1d1c15a8c1bbd324367d6135d0a3.1757946863.git.donettom@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=BKWzrEQG c=1 sm=1 tr=0 ts=68c82ac0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=kDUdi5sUuU8vu5WplE8A:9
X-Proofpoint-GUID: j3U2VRkqQn4XzAtJobpMyJIcM65S50IL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX+owsqfDsyOJT
 wra/dfkNFMg0Aty67SOAVFn9WPu+ZedniDZ1oBpVSg2IO4QeaJMdd1d8CABWjTR8imZ7wyY3FNY
 kcDXuTvCPt7L3gvm8I079Djz4yVUEKvkTbb+Egj2wXAX6UzpJi7CuWy64jl9eLjD7RcQl8KgF0l
 G9gLpuM1x4xYLKWKxbfSYOdKBOw5QXqoy6Ot/oy1RURKb9a/XoI3WwlivENzn8kd1Va+wVH/+qH
 x5oTE/kfbFC/KThIl7iGI1heWEj7V4tBBCTRzWJFxvrYexNIW3Gu1NkowN97kE3HNURwuYdpupl
 7tO2/IHhEy1CafLDNgUIlB0oPznV6OBo2rlvuO1lREtdh+4fKWDUqn2Cmiq4wxjuBqW8CXHH2VH
 XBCQKQj4
X-Proofpoint-ORIG-GUID: UVh9NO6MTXzI6hFy_IMba7QcotMBbCPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086

Added a new selftest to verify whether the `ksm_merging_pages` counter
in `mm_struct` is not inherited by a child process after fork. This helps
ensure correctness of KSM accounting across process creation.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 712f43c87736..645cefba2126 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -602,6 +602,45 @@ static void test_prot_none(void)
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
+		return;
+	}
+
+	if (waitpid(child_pid, &status, 0) < 0) {
+		ksft_test_result_fail("waitpid() failed\n");
+		return;
+	}
+
+	status = WEXITSTATUS(status);
+	if (status) {
+		ksft_test_result_fail("ksm_merging_page in child: %d\n", status);
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
+	test_fork_ksm_merging_page_count();
 
 	err = ksft_get_fail_cnt();
 	if (err)
-- 
2.51.0


