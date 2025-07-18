Return-Path: <linux-kernel+bounces-737337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E171B0AB10
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DD45A85B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC6F221737;
	Fri, 18 Jul 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDIx5E8h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA121C9F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870030; cv=none; b=H0G+zsxMFE3SUjNF2dFECIviI7lv4/a0Zg+hhGH8petIEKc2YOvj4vwtByyxkvXaJB0kcAQ1AcKAI20vCrCvATUey7b5sY5whC/6vFRU/kqcBp0ONWoCfsNT+cq7QUUYvYI/jsm2E3cig/JV4HMACupay3UIiufJ8DUgF3J5uxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870030; c=relaxed/simple;
	bh=gL/Ib6V/Rr7s1q7a9+wV2U4ANTgm6sYkqvsTPVoZdC4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WvxhHAkeCVCD+EWEccINPtNaOtHe6kLUTI7p+4ueYBEYcvyEqNVuCUo1i8sfsS8RvCrhsbGVWDFi/IGL/Fi/xEzY1PBfHxtZVYQtCh2ZfLoPC+twoQ5+wueyjQPGjlVLoqkQYzU6Yx66UqTMetxtWGpsUuLBRLR/M2jAQLKZjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDIx5E8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD200C4CEF7;
	Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870029;
	bh=gL/Ib6V/Rr7s1q7a9+wV2U4ANTgm6sYkqvsTPVoZdC4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=fDIx5E8hAvFHAzfMAMbvGKQvKtd0zGC/Cg2JQ53qxsZQ166QkP6YDvbiW+0Fe5ThU
	 hXPUprWOTiSQz5tKuzlxWRCJPBoK84snIkXrrjALB11WFzXPS/KHHkSkdybPqMCnmT
	 VVkeDVtVh53QCbCxlRlRwUyLOy0lKCxzbO7NHdjR4SaZytKuotIll2zEHCeY3smiTd
	 nRFdPQvGg7XFro+2tWCIvzFiVbzqmvYnuNorr5oAXOho65AXu2ei1LG1sE+iESUTct
	 QE4Xl2M1aZzG7Qya8OoFPOewp5ZgNTn9re358CrH6k9KDlwzexyjoGRF6x299x83PZ
	 5jkiAc6tro8fA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucrZe-00000007QeY-0BIl;
	Fri, 18 Jul 2025 16:20:54 -0400
Message-ID: <20250718202053.898022631@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 16:18:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 5/5] ktest.pl: Always display BUILD_DIR and OUTPUT_DIR at the start of
 tests
References: <20250718201840.714067501@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

As ktest.pl can run in various different directories, to make sure the
test is running in the proper directory with the proper source and proper
destination directory, display the content of BUILD_DIR and OUTPUT_DIR at
the start of every test.

This can be helpful for the test runner to stop the test if a test is
running in the wrong location instead of finding out after the test has
completed.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index b2971430d7e4..c460838dfd6f 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4539,6 +4539,10 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     doprint "RUNNING TEST $i of $opt{NUM_TESTS}$name with option $test_type $run_type$installme\n\n";
 
+    # Always show which build directory and output directory is being used
+    doprint "BUILD_DIR=$builddir\n";
+    doprint "OUTPUT_DIR=$outputdir\n\n";
+
     if (defined($pre_test)) {
 	my $ret = run_command $pre_test;
 	if (!$ret && defined($pre_test_die) &&
-- 
2.47.2



