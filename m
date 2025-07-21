Return-Path: <linux-kernel+bounces-739851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A9B0CC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3B93A9326
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56CB23B61B;
	Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6Tn7885"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257323C4E7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130253; cv=none; b=hetsHDXdnmKJl9VE2J0F74DVTrfKDvLnE/JK/v/UrA8wlAyav5ZpbkfBveC6gloenxoZ5LqGICBiFT4QSdCUYmvNv/bW/sSXC1D3sjELmYlBa9XVV2FG1gnF1ehgyfgwW2P4ubbX71OzSnxAhpP3j4FcBpOGvyACsxiZWOMzyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130253; c=relaxed/simple;
	bh=47h6/gzbv25xAVIKLH1Nb7C8dT2KYdtCReAuB8pu30w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BvQdWSt2JuM3vWFYfMsE26C1eo9tEqsnRGNHaRNwmWxufCjhFDHIdwd2pn4tdWgnay/XZDLwbvK2cpyW2Eg8+cIUHBLOPx++meHSKHzGkXwA8mohsY0yql91XK0FoBbpH5wrqj9YeJyDk2R7ZUKaE2QYKyVhqvr3RJSyDkMcmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6Tn7885; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE63C4CEF4;
	Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753130253;
	bh=47h6/gzbv25xAVIKLH1Nb7C8dT2KYdtCReAuB8pu30w=;
	h=Date:From:To:Cc:Subject:References:From;
	b=F6Tn7885Tj/fXxU/h+2FvDNn1OR1EDa2EotKmVuamETms0ikQy+X+FGrD6IB++KU3
	 PsB3A7qfD+GzE4tDFU/zla73vMOw5fz+/aZr3jWHjArmH+GwYBTr62ryNpt/RvYD1I
	 1WPZLImbT+XXlA1L8mNX2xAmpGydTYjUfuvVTBoZRiH+imdHMrsE7Iukl3iPA+kpkR
	 baG2cIrfx/ej1ylqsoB6wLlRzQFkXRZKx3LtrwNegmET7SFo0LAt2yd+XZFomPMfUQ
	 2Ves7+AjgBBLimFWb9g9+e9oQpP9xC8UW3NjlWuqbPvi7XyBcE7dL4ZtwIdcx94Ppo
	 KTo5z8kVlwakg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udxGt-00000009p52-3lsV;
	Mon, 21 Jul 2025 16:38:03 -0400
Message-ID: <20250721203803.753889067@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 16:37:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 4/5] ktest.pl: Prevent recursion of default variable options
References: <20250721203739.462938756@kernel.org>
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

Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/20250718202053.732189428@kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 95e62929cda7..3a679259f4e2 100755
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



