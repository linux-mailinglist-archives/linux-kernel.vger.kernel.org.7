Return-Path: <linux-kernel+bounces-739853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE51B0CC07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BAC1C2059F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE8923C502;
	Mon, 21 Jul 2025 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0Ge/lA4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302423D28E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130253; cv=none; b=ns/3Kh9tkhzOcFJnYBIjmVPs3X+IEYqEappO7awWzJuWFB4Asp36jd8KiwBHnoCmAaQJY0PucZS+jC4/0Kl469VBGrZf45KYFmS1sIp1Ez5obmLXDHdV/tB0BwuzHFVhBW2PqHpw/NpCwmvTAA4r/9uBxEh2XtGu8dJoRo5ZKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130253; c=relaxed/simple;
	bh=5geqAggurpwxkHUPjgRPgR//GEnUyyqKrqcPH7ocPb8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ndByyCYg5pVVxyjyNxgOi8Wc7ERScWvo53LoPhn1MlPjXtzYgvv0VRv/bhMpP6EYdEUsBVPrZJ04cBqA++PUfabQkbsqtLm8GT3yptE2weuu3AHE1QqLUJmfxWlF48SEinXG4OIG4tBd4eZIeNqq5et3ZhSirE5zno9b2oaqMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0Ge/lA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C83C4CEED;
	Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753130253;
	bh=5geqAggurpwxkHUPjgRPgR//GEnUyyqKrqcPH7ocPb8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=K0Ge/lA4qjkU3kUy9DfpJleQZUpOAP2a/SoWS0mauFBn3WrLDpWpx/gD8zJEA2mEP
	 JcqgqXBBaY+cNW5gsAzP+fUShUDTkfLNd5+0uLWuBWIXlqNsCFn/f5pyRsnAfxRv/y
	 8YYMW8qM2RgV0Tgh7nE7inRBN5y9RzKA9+4H49Kqz4bo+471MET/jgxlLCZr7MMPuw
	 NFBTUW8zMDKfEFOBe5JzVh+R1+bj5NsatMkRdfCHrXo9Lwq6MmUTwXZJTmnP1ST+X1
	 HBF7BsFLoSsuqxvwQCEMncOYkcRDq5ZgcsGE7HOyA0XzbqK3MKyjodrfDys3SGME5L
	 wEu5jMUyGm1Eg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udxGu-00000009p5X-0HgA;
	Mon, 21 Jul 2025 16:38:04 -0400
Message-ID: <20250721203803.920384166@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 16:37:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 5/5] ktest.pl: Always display BUILD_DIR and OUTPUT_DIR at the start of
 tests
References: <20250721203739.462938756@kernel.org>
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

Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250718202053.898022631@kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 3a679259f4e2..2d4ba097d510 100755
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



