Return-Path: <linux-kernel+bounces-737335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074ABB0AB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A12D5A832D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690AD21CC58;
	Fri, 18 Jul 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuTiaZH2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3F21ABC8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870029; cv=none; b=gnPu/xE8td5QZVJcRpZPEMpMy7xo7UeaeiO3NwGypVFgUskUwM1WcFDDhxJ4cgu8h5UUgEGe+DpY+7reG6gpPfU3V8IYXOA7SYMVQSPfsGaxiWPDAD7f98TTrbu81aK9chUGlqzETUAjs6Hb/UZb4fPd8pDdoPfRrw9Zzx6UyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870029; c=relaxed/simple;
	bh=jRP/zOTvSPvZdc4E51dkUoMDxpQIXxmewk+hZU8kexs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rQzlXXp61bEwlMZJUL7c4iIKOVSyylMxts0ePUgxsYKsgf5HPZa6P7zkGnoCVFWJzayjmGcct81Yljpe/aOP2jDlv/BdCqc1weVwfZjzcf952ztBlTBV3p846DvIyEHcgOJUeq0pgCfuDSUHlxIFjnjeEr20ilMtId5MkHrkCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuTiaZH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859A6C4CEED;
	Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870029;
	bh=jRP/zOTvSPvZdc4E51dkUoMDxpQIXxmewk+hZU8kexs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PuTiaZH2EPR7k5rcXbpwCv2aT8efgnn5ahadooWRcNcc7Zso6PHFbe1Gzx9yyv54y
	 0yz6SJdqHuktZO3PmT6O5jK3cDB8/Tux8n7E6k63rioBLOPy82bgRBwHQhT8ofs9Dq
	 sdeu0qu3hHdI6p0u7C2TUCSZVK/R/WUoD/d7P2f1sqVHLEPg68ZoyWcuPKWeJRJYjP
	 leEkEUDOz4Uk0ISfwATbJaLDtX130rwSybH10xfwm6+uKBPrErmoW+MS63pHjUrASg
	 jjaQNS08Ul5A7CM7084qe3ApC+rMvtIlZcO3mGA0MaTeJiXPcHA7qs7EWE5gTXHkZM
	 L8Yt2RD7K5ZIQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucrZd-00000007Qe4-3ga8;
	Fri, 18 Jul 2025 16:20:53 -0400
Message-ID: <20250718202053.732189428@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 16:18:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 4/5] ktest.pl: Prevent recursion of default variable options
References: <20250718201840.714067501@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a default variable contains itself, do not recurse on it.

For example:

  ADD_CONFIG := ${CONFIG_DIR}/temp_config
  DEFAULTS
  ADD_CONFIG = ${CONFIG_DIR}/default_config ${ADD_CONFIG}

The above works because the temp variable ADD_CONFIG (is a temp because it
is created with ":=") is already defined, it will be substituted in the
variable option. But if it gets commented out:

  # ADD_CONFIG := ${CONFIG_DIR}/temp_config
  DEFAULTS
  ADD_CONFIG = ${CONFIG_DIR}/default_config ${ADD_CONFIG}

Then the above will go into a recursive loop where ${ADD_CONFIG} will
get replaced with the current definition of ADD_CONFIG which contains the
${ADD_CONFIG} and that will also try to get converted. ktest.pl will error
after 100 attempts of recursion and fail.

When replacing a variable with the default variable, if the default
variable contains itself, do not replace it.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 075c386af5e5..b2971430d7e4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1394,7 +1394,10 @@ sub __eval_option {
 	# If a variable contains itself, use the default var
 	if (($var eq $name) && defined($opt{$var})) {
 	    $o = $opt{$var};
-	    $retval = "$retval$o";
+	    # Only append if the default doesn't contain itself
+	    if ($o !~ m/\$\{$var\}/) {
+		$retval = "$retval$o";
+	    }
 	} elsif (defined($opt{$o})) {
 	    $o = $opt{$o};
 	    $retval = "$retval$o";
-- 
2.47.2



