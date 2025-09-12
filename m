Return-Path: <linux-kernel+bounces-813033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2659B53FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0187C0C70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238316D4EF;
	Fri, 12 Sep 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="genpfjM7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B22AE66
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641062; cv=none; b=NFwydQ9ZsJMeatwO1pgBOXpcuF2t+mryxNOWt2QoRuTLP1annEtYhYpIH4OABeXznXW91ZnZ+aihVSX33MzV7LNU8qNQg1Z7sy4rulp9k9pxe/Jt8P0uQAKCeAVUR1UAypwZtnnPvCAbtODFBYetlndZ2yTIX+gggD5a7qUV4Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641062; c=relaxed/simple;
	bh=4HrrGmqVM/vg+BX6pOxI0I039vN+RBjhqWp2mScOXYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVVToY1o8LWsBmyPJYFw1N7yXnjFf44Que2qATNEiVFLAlrQPyBXB7SOUT92/2XNracFuxrvSI3t9pcy6/QXS1iT6bgCEsNWcGCi/JPVrLBLNY02ApF+u7hanl+Hi6weNoLgTNmsYl/bDZPSkYiohG8lKzAi2tFxHMUKqht4L8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=genpfjM7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757641057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5xVT+DP3d5xsBvfGpUvEkXmr3BNbIxY0gg2qMRV1Cc=;
	b=genpfjM7X+wx0+ZlZUlE5kB1HTpkpuF1mwcBNKLkXjDvShkNQTyVWVUhdUoBxyMYrvlcK9
	QeqSnd9t4yYb21t5E775do8pZY7PTaAfkTV171oWG+kXkfe5GDxpBUOEEXtJZbpgVitAnW
	IgI6U95+VGTYhdhtgZPpkQvLAgz9Wrc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-VSqiy1hoP32g2QuHsqAzrQ-1; Thu,
 11 Sep 2025 21:37:34 -0400
X-MC-Unique: VSqiy1hoP32g2QuHsqAzrQ-1
X-Mimecast-MFC-AGG-ID: VSqiy1hoP32g2QuHsqAzrQ_1757641049
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 283EB1800562;
	Fri, 12 Sep 2025 01:37:29 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A72E1800452;
	Fri, 12 Sep 2025 01:37:22 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org,
	linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	chuhu@redhat.com
Subject: [PATCH v3 1/3] selftests/mm: fix hugepages cleanup too early
Date: Fri, 12 Sep 2025 09:37:09 +0800
Message-ID: <20250912013711.3002969-2-chuhu@redhat.com>
In-Reply-To: <20250912013711.3002969-1-chuhu@redhat.com>
References: <20250912013711.3002969-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The nr_hugepgs variable is used to keep the original nr_hugepages at the
hugepage setup step at test beginning. After userfaultfd test, a cleaup is
executed, both /sys/kernel/mm/hugepages/hugepages-*/nr_hugepages and
/proc/sys//vm/nr_hugepages are reset to 'original' value before userfaultfd
test starts.

Issue here is the value used to restore /proc/sys/vm/nr_hugepages is
nr_hugepgs which is the initial value before the vm_runtests.sh runs, not
the value before userfaultfd test starts. 'va_high_addr_swith.sh' tests
runs after that will possibly see no hugepages available for test, and got
EINVAL when mmap(HUGETLB), making the result invalid.

And before pkey tests, nr_hugepgs is changed to be used as a temp variable
to save nr_hugepages before pkey test, and restore it after pkey tests
finish. The original nr_hugepages value is not tracked anymore, so no way
to restore it after all tests finish.

Add a new variable orig_nr_hugepgs to save the original nr_hugepages, and
and restore it to nr_hugepages after all tests finish. And change to use
the nr_hugepgs variable to save the /proc/sys/vm/nr_hugeages after hugepage
setup, it's also the value before userfaultfd test starts, and the correct
value to be restored after userfaultfd finishes. The va_high_addr_switch.sh
broken will be resolved.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Chunyu Hu <chuhu@redhat.com>

---
Changes in v2
 - rename nr_hugepgs_origin to orig_nr_hugepgs
---
 tools/testing/selftests/mm/run_vmtests.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 471e539d82b8..9866e4221bc2 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -172,13 +172,13 @@ fi
 
 # set proper nr_hugepages
 if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
-	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+	orig_nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 	needpgs=$((needmem_KB / hpgsize_KB))
 	tries=2
 	while [ "$tries" -gt 0 ] && [ "$freepgs" -lt "$needpgs" ]; do
 		lackpgs=$((needpgs - freepgs))
 		echo 3 > /proc/sys/vm/drop_caches
-		if ! echo $((lackpgs + nr_hugepgs)) > /proc/sys/vm/nr_hugepages; then
+		if ! echo $((lackpgs + orig_nr_hugepgs)) > /proc/sys/vm/nr_hugepages; then
 			echo "Please run this test as root"
 			exit $ksft_skip
 		fi
@@ -189,6 +189,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 		done < /proc/meminfo
 		tries=$((tries - 1))
 	done
+	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
 	if [ "$freepgs" -lt "$needpgs" ]; then
 		printf "Not enough huge pages available (%d < %d)\n" \
 		       "$freepgs" "$needpgs"
@@ -532,6 +533,10 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
 
 CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
 
+if [ "${HAVE_HUGEPAGES}" = 1 ]; then
+	echo "$orig_nr_hugepgs" > /proc/sys/vm/nr_hugepages
+fi
+
 echo "SUMMARY: PASS=${count_pass} SKIP=${count_skip} FAIL=${count_fail}" | tap_prefix
 echo "1..${count_total}" | tap_output
 
-- 
2.49.0


