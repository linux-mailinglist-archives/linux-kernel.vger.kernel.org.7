Return-Path: <linux-kernel+bounces-737336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE071B0AB0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F1DAA4BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901B21CC57;
	Fri, 18 Jul 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDDSq6oc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D9E21ABDB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870029; cv=none; b=TWdiYkO9oSxJkTs3jd8xdCFiJ1tCm96z2sxi6Ej1Je6/DXIRvPxNghfCQQtafq87UIu2O17OZJRdPGSp4fKemW49aoYDxCwpcxmhhteG8gfj7qyz+0RlfeWyTiTVzPqNcjdbRfS/7jO1KwD3iKkrpJM2LdANcjeinFfn0Qn1QQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870029; c=relaxed/simple;
	bh=rg4fTUaMM/kHfvtLxs2wKzoNwqSYHAn9IkmBpAPV87s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=N7ZUEn0vLzpuqS79jr21WITT07+WH8mjrZJddMKUMWRF0dzR+R84wTKyG1hulgCnhe4ZKjOlXwM46oIt+0OcS7Ozr8j4oGJqyyrf64L/mFRkbV1DZ4r+EF7TxzDCWQ9t7cV3cEqKFSTLbTMtVMiKycOrmYiYEzjeP8LEn9fk/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDDSq6oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728B5C4CEF1;
	Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870029;
	bh=rg4fTUaMM/kHfvtLxs2wKzoNwqSYHAn9IkmBpAPV87s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qDDSq6oc1efqk9N09duCFCYpAS8bzegdnO0gIVnSz1IAoothZQn1ePUw85vAAjsV/
	 SpokLxs7ISQljk0uVsyP754ReBghxJCp8Ue047nTkjEovtpBdhj0wZYLHTi3L2GnyN
	 EivREcsKnSWFEvvWPTdTv62tzMoz2MaG3xZEP6K50k8B3/8nh3CkFk4mhi8ppq0H13
	 J86M/sYN7lJbwtKQ3v9gFvkFhEW4pIVTnUJg4A6icdFVWxMRj4lRv5RATAtRJXSH/h
	 91BT2LtKzdtLVOiv2JqrOoYyTXa8m10EyXv+GsNkxho9r3mhDV6DzY2FVcFYkAoMuT
	 Bg/tx0qxA6dgA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucrZd-00000007Qda-2zIM;
	Fri, 18 Jul 2025 16:20:53 -0400
Message-ID: <20250718202053.567246162@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 16:18:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 3/5] ktest.pl: Have -D option work without a space
References: <20250718201840.714067501@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Allow -DBUILD_TYPE=boot work the same as -D BUILD_TYPE=boot just like
normal single character option does in most applications.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index c441934f1def..075c386af5e5 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4297,6 +4297,15 @@ while ( $#ARGV >= 0 ) {
 	    $command_vars[$#command_vars + 1] = $val;
 	}
 
+    } elsif ( $ARGV[0] =~ m/^-D(.*)/) {
+	my $val = $1;
+	shift;
+
+	if ($val =~ m/(.*?):=(.*)$/) {
+	    set_variable($1, $2, 1);
+	} else {
+	    $command_vars[$#command_vars + 1] = $val;
+	}
     } elsif ( $ARGV[0] eq "-h" ) {
 	die_usage;
     } else {
-- 
2.47.2



