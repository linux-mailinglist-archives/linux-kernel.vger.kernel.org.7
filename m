Return-Path: <linux-kernel+bounces-855019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CDBDFF23
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F631188A0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFEB3002DF;
	Wed, 15 Oct 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njnggtlX"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5E1547EE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550719; cv=none; b=SOgWg2URU1Ab+5UNXm5fPDawKrCIo1rOYvuwLLtcCQ9Aye4swCtQbFCb9IMjRCxslXmOZw1JzxV6hx6d4jkN04vix8BFkF5Npq6uzbQPNC22BVz8tNzaG2phsVYuBl6VIp/vK532khlqcMhn9sFxiJNG5ptBpT222fCrfM7kD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550719; c=relaxed/simple;
	bh=lPYMbvNrCKwF3KYux8mZ2rfVctaCAtZ2gSS3vkjfJko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqMcr0S9WlJn8Cs/iXI9jbC27DmxYvM92pl8EVgdFn15WN+imL8GrNwYZDd0kg1qtmcP9swaNlySBtdA9OYm35cysGviDvQgf0uL0opxX687T1Jhc+Ww/sLs4XAGaxlGTYZYeiEJhpDThE999RPLSVxCHpdO6Xi5rGSIca7Vv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njnggtlX; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430a4bf6b6dso5948725ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550717; x=1761155517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jkbuW2RngRwKTXR8TmZtG5NMUGcZxQdiAE8KdN0MfM=;
        b=njnggtlXsbPc0xwGpEHj/dwi+u72IlmTZ/t0BndM5bsDwlDSJ7kK1JeUpPfy4DUD5T
         QzBAHxwlETqn6Kk+HmiLSJVGIxAy8MYlvev2OP9p+Kqj0/wkUxdp3XbZTX/vb/19yzwD
         TJvonwUAd4A9oloByqHZtLZ64LecbfSBMT7O7qzPPCH+T3S3DPb/bmqNZEwthT8q54re
         X/UvK8mUaoLd7bD3NnUwHbGCXBxnaoLWk4RR/Rz+/MSnzeocpuhyp+pgaM9WRovPjDM2
         RIVDE8FUe6GezUilofwMJBaxkB/cm5uCK/94eYkeJ1gS20T3WVaMwcispljg1WCHqn+g
         lVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550717; x=1761155517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jkbuW2RngRwKTXR8TmZtG5NMUGcZxQdiAE8KdN0MfM=;
        b=RX0T/z2RkSa7lsHiwSyYe7hCn8JjYNxcCAVI5M57d+hcl4XOpTWGhKEot85VsijNYa
         mAtDXflnxUzX1Kc/NXf91f9brFaGA0Ww2BSkXKJMaoAMTYFEj9H1NeCHs152F+6LOPHE
         A70PZW3l0RrcahZy56CCPviv42nirdbnIWZUnvuHX6fRQPWypEmsN2xVGXzjU15sZo4/
         w7RiuEP6ohi8NucEgWqKDocEUV+0S8txE4cKATN+j87WzCi8gyY3KgPUiB3kV9dzrodB
         qu7c8+5+kOcOCTpOvCu0NNNxMRTL5IT85sZqnvoFr67clmVpODpPpXdkmzbOGv+1Bozt
         VxgQ==
X-Gm-Message-State: AOJu0YzyLNbFByb2RijllfQGm1RlULCEd76LAibeSQBAlivYEAIcc3hZ
	RiqdygiJABGBftEETCT4g1sDYbbGV69caP2Dibu1SjnCZzqNhrGyOGLjYHJ7fg==
X-Gm-Gg: ASbGnctvI66philz9TBAOLW5SaITxPpnRH5lCJPLIHLi34HQRd4rSK3V0IDEeilo7eH
	c6KDsUQ57iYVjJxCO6rZN4EDGgcxu7eMkuiHQVXWhHItfO4sHVP4PLyQcINehT1p+dpnP0R5xdt
	l/YE/qS9yGmosn9SlF/F/75JmHnJ45ybO+JQk5QhFKFEDECoBGbRZ5ONfJKY82y9kWwbhfq4DiF
	b1SJ7pBN6kE+xwYv4lSCpr64m/G/7QCT8bA4Tt6oDy6Fw7kTTbjg28CrNiR54EdZmMbf92J+fQ+
	kntYKxihwr5BJzSoklVAsus6dXqhsOu6ZLQFH7RVE4PBtozvexWucpAEWWSNPrgjf+OkfvYs5TQ
	ckM8/P7Oy2hcDOv2CsdT8jEDMXSTEkoN7pfXIaNgog6lqkCeNg2s4V44heu1lmoa/+gn48hVrPe
	ZX35t9sxl8FDU4BjLRNdYHgw==
X-Google-Smtp-Source: AGHT+IEvaQe82SwDWzcV90P2IirCokgb7oZvT7Bl9uSrEXZMkppw6Ma++mOxFMWU1eCIzUncs3ivNA==
X-Received: by 2002:a05:6e02:170b:b0:425:7788:871 with SMTP id e9e14a558f8ab-430b437e76dmr15724505ab.12.1760550716774;
        Wed, 15 Oct 2025 10:51:56 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-430b50b692csm1194115ab.5.2025.10.15.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:51:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 1/2] checkpatch: add __no_side_effects() hint/assertion macro
Date: Wed, 15 Oct 2025 11:51:36 -0600
Message-ID: <20251015175137.2178263-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015175137.2178263-1-jim.cromie@gmail.com>
References: <20251015175137.2178263-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending upon your macros, `checkpatch --strict` may issue many
warnings like:

  CHECK: Macro argument reuse '_var' - possible side-effects?

In (at least) 2 cases, the usual advice to use ({ typeof .. })
or do{}while(0) does not apply:

1. top-of-scope (inc file-scope) declarative macros:

   #define module_param_named(name, value, type, perm)                        \
        param_check_##type(name, &(value));                                \
        module_param_cb(name, &param_ops_##type, &value, perm);            \
        __MODULE_PARM_TYPE(name, #type)

Given this macro-defn, checkpatch would carp about name and value.
Note that it wouldn't complain about type, even though type is
expanded 3 times, because it knew to strip # and ## constructs before
counting args.

2. #define for_simplicity(_i, _lim, ...) \
   	   for( _i = 0, _i < _lim; _i++ )  /* your loop body here */

Though not a compelling example, it should'nt be impossible.  ({})
fails because () detaches the expansion from the following { block }.
And the do-while adds a ';'.

So allow a macro author to assert that (_i) is safe to expand 2+ times:

   #define for_simplicity(_i, _lim, ...) \
   	   __no_side_effects(_i)	 \
   	   for( _i = 0, _i < _lim; _i++ )

This should help reduce auto-QA/pre-review noise, even though its a
homely little macro.

It has 2 parts:

1. compiler.h:  #define __no_side_effects(...)  /* nothing */
   so no functional change from its use.
   authors add it to "noisy" macros
   readily reviewable, and marked for it by name.

2. checkpatch: suppress the CHECK reporting:
   a. find the hint in macro body, capture the safe-args (_i, _j)
   b. strip the hint, reflecting the /* nothing */ above
   c. before issuing CHK() on arg-use-count > 1, skip if /safe-args/

3. --drx option, which enables a new sub drx_print("reason");

   a. used like: s/$pattern/drx_print("why")/e;
   b. calls it on 3 existing cases.

Here it is in action, on a patch that prompted this one:

drx_print: strip 'arg ##' catenations
  >> Matched (`$&`): <_var##>
drx_print: strip 'arg ##' catenations
  >> Matched (`$&`): <_var##>
drx_print: strip 'arg ##' catenations
  >> Matched (`$&`): <_var##>
drx_print: dunno
  >> Matched (`$&`): <__builtin_constant_p(cls>
  >> Capture 1 (`$1`): <__builtin_constant_p>
drx_print: dunno
  >> Matched (`$&`): <##_model>
  >> Capture 1 (`$1`): <##>
drx_print: dunno
  >> Matched (`$&`): <##_model>
  >> Capture 1 (`$1`): <##>
drx_print: dunno
  >> Matched (`$&`): <##_model>
  >> Capture 1 (`$1`): <##>
drx_print: dunno
  >> Matched (`$&`): <##_model>
  >> Capture 1 (`$1`): <##>
drx_print: dunno
  >> Matched (`$&`): <##_model>
  >> Capture 1 (`$1`): <##>
drx_print: dunno
  >> Matched (`$&`): <##_model>
  >> Capture 1 (`$1`): <##>
drx_print: strip '#|## arg catenations
  >> Matched (`$&`): <#_flags>
drx_print: strip 'arg ##' catenations
  >> Matched (`$&`): <_flags##>
drx_print: strip 'arg ##' catenations
  >> Matched (`$&`): <_flags##>
drx_print: strip 'arg ##' catenations
  >> Matched (`$&`): <_flags##>
total: 0 errors, 0 warnings, 712 lines checked

This should be useful for hacking at checkpatch if/when the behavior
of an existing s/// or s///g is sufficiently mysterious that a few
s//drx_print("wtf")/ge modifications seem appropriate.  Some of them
will be worth keeping, since the "reason" can be inspected, improved,
verified by using --drx as needed.

NOTES:

This adds to the stack of heuristics: cpp doesn't mind expanding i++,
so checkpatch is paranoid; this quiets that paranoia clearly.

The macro call must *exclude* the trailing semi-colon.

practicality vs aesthetics.  Is less QA-noise worth the ugly ?

TODO: The "dunno" case shouldn't really catch the <##_model>, since
there's a subsequent rule for that.  I could have hidden this blemish
by moving the other rules up, but that also hides a maybe over-broad
stripping regex, and is -E_TOO_MANY_CHANGES.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

fix
---
 include/linux/compiler.h | 12 +++++++++++
 scripts/checkpatch.pl    | 46 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 64ff73c533e5..a348b45eacc0 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -379,6 +379,18 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+/*
+ * tell checkpatch --strict that you know the named args (a subset of
+ * the containing macro's args) are safe for multiple expansions.
+ *
+ * Prefer ({ typeof ..}) or do{}while(0) when they work.  They would
+ * not work on module_param_named(name, value, type, perm), or on a
+ * locally useful "for_simplicity()" macro.
+ *
+ * NB: use at top of macro body, omit trailing semicolon.
+ */
+#define __no_side_effects(...)  /* checkpatch "annotation" helper */
+
 #include <asm/rwonce.h>
 
 #endif /* __LINUX_COMPILER_H */
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..27299f326804 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -169,6 +169,30 @@ my $DO_WHILE_0_ADVICE = q{
    Enjoy this qualification while we work to improve our heuristics.
 };
 
+# call this from s/$patt/drx_print("why")/e - to see whats happening there.
+my $drx_print = 0;
+sub drx_print {
+    return "" unless $drx_print;
+
+    my ($why) = @_;
+    # The magic regex variables are available here.
+    # $& contains the entire matched string.
+    # $1, $2, etc. contain captured groups.
+    print "drx_print: $why\n";
+    print "  >> Matched (`\$&`): <$&>\n";
+
+    # Only print captures if they exist
+    if (defined $1) {
+	print "  >> Capture 1 (`\$1`): <$1>\n";
+    }
+    if (defined $2) {
+	print "  >> Capture 2 (`\$2`): <$2>\n";
+    }
+    # The subroutine must return the replacement string.
+    # For stripping, this is an empty string.
+    return "";
+}
+
 sub uniq {
 	my %seen;
 	return grep { !$seen{$_}++ } @_;
@@ -348,6 +372,7 @@ GetOptions(
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
 	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
 	'kconfig-prefix=s'	=> \${CONFIG_},
+	'drx'		=> \$drx_print,
 	'h|help'	=> \$help,
 	'version'	=> \$help
 ) or $help = 2;
@@ -6044,11 +6069,24 @@ sub process {
 			        next if ($arg =~ /\.\.\./);
 			        next if ($arg =~ /^type$/i);
 				my $tmp_stmt = $define_stmt;
-				$tmp_stmt =~ s/\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
-				$tmp_stmt =~ s/\#+\s*$arg\b//g;
-				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
+
+				$tmp_stmt =~ s{
+					\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|
+					   typeof|__typeof__|__builtin\w+|typecheck
+					   \s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b }
+				{
+					drx_print("dunno");
+				}xge;
+
+				$tmp_stmt =~ s/\#+\s*$arg\b/drx_print("strip '#|## arg catenations")/ge;
+				$tmp_stmt =~ s/\b$arg\s*\#\#/drx_print("strip 'arg ##' catenations");/ge;
+
+				my $no_side_effect_vars = "";
+				if ($tmp_stmt =~ s/__no_side_effects\((.+)\)//) {
+					$no_side_effect_vars = $1;
+				}
 				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;
-				if ($use_cnt > 1) {
+				if ($use_cnt > 1 and $no_side_effect_vars !~ m/\b$arg\b/) {
 					CHK("MACRO_ARG_REUSE",
 					    "Macro argument reuse '$arg' - possible side-effects?\n" . "$herectx");
 				    }
-- 
2.51.0


