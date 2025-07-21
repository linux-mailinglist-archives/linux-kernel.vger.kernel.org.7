Return-Path: <linux-kernel+bounces-739852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85917B0CC00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566EC1C2016C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9A23ED76;
	Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTqhjVxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984A23C502
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130253; cv=none; b=SOwgMd49HCY/gVR5SlDdjEwzauuzZWqXyXY6F/IeAhFepjWxwc5bpC7jD5FZrIrH8357sqcnLCHlPDyFnVd0K98sx2ItQhNpf8JAQkrLw8f8K8B9gonYWmXWFhY97yQH/k0j2yLWtFiotC+cM0QIzn1ZtgeQ0iOG8zECOcDpyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130253; c=relaxed/simple;
	bh=p+5PwjEc555AtVNzBRcMCkoW7EoDC9oTDy0rdmx/P5k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JjONkjO93yW+RdCBGliMS4NLG9F4mg3pWF/zzeqXxl9wWw1kDPCgqR8CP4ImRFE33nWdlfg4nz9NKwQt+SAhsB/Jlq0QWWPNFEequpTSQMSrlA6kI5k08vco3lhlXgZDtPoYG/CHJJvKlkjF1X/5W7dSJwupaCz2JWpVy3xVMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTqhjVxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1122C4CEFB;
	Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753130252;
	bh=p+5PwjEc555AtVNzBRcMCkoW7EoDC9oTDy0rdmx/P5k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=sTqhjVxIyC7a5zRnrYDWqMxu4zjJdjhmY0vEkwzgJtRmsbVENqabXRQYM/IznE3s3
	 1Y1+4AYWFRv/Getl1I361ZCihYYvUjbWlVea5bmBYVdYabkawPr3iFUq4BJtovIP1X
	 grg2aronIOYA/Lne4e9Ch/2maooHiYiaMgbe+PRwtcdE5aASmV2XzcmIRI6mFon/zc
	 khJ6AnHa8YuaXu9VBOmTYxef4jwfR7OSUS/PsFimC65BVsKKylH/gF+H/SF6vcMmqZ
	 d8BQkmWQ+0enN7B6/wTD8f6hN8w84B7wjwr2Vhp57IKqcB5gW/65MmOrtSookMSGp4
	 2fQxM9wmHS33A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udxGt-00000009p4Y-35Sa;
	Mon, 21 Jul 2025 16:38:03 -0400
Message-ID: <20250721203803.589718077@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 16:37:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 3/5] ktest.pl: Have -D option work without a space
References: <20250721203739.462938756@kernel.org>
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

Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250718202053.567246162@kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 7b94b9b83ee7..95e62929cda7 100755
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



