Return-Path: <linux-kernel+bounces-812895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E35B53DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393B9AC15D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7472DFF33;
	Thu, 11 Sep 2025 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyTfMJ45"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053A32F762
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626757; cv=none; b=IlZnZSuWwTNybHkSD2tcWj5K+rpVW1QgMfIJC6PWq9bc66LRX+qGWq7Ot3WjYmp2X4oBovwIOvPYcrzgBhtgsclKLW5JahBgcOA7r6IbZ6z2grjDI1O3bwy/NYtza1DJY8p4pD7n/5q7Zgxi9bm1AzYErtaAWcznh0fMLsU6AEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626757; c=relaxed/simple;
	bh=FtcFgwEejWjZvhm0rHNUUhymatBzn9CaDalgPyLWlVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LD4zcGCz8saAIRbIXZykx3KbPVW8Ffag7YGixIP8XKbxAh7DRNv63WOEqEzgrudwLhGL2jE7hSppbg3G6+NlqNG5LsDPdP3I5wEe8ib+IrxlON88eXEAN897DRixDBVW5M4OK8qc/VWoUHqNz8jZPdHPp1ONgHciF0NjjhSYRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyTfMJ45; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-88762f20125so88079939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626755; x=1758231555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2CgSP+i6gOirYRCe6SP5XNRa5WFOHuIeP0ROyizXdM=;
        b=TyTfMJ45LetbzlY4gpt9IY22KauBZ42mC1Vcn9buHxnCPodgLFdu8uNN+QSz8oZv9B
         AUNS6WLHtszUjTnPPy8hDuOOmBi9DstO216ooFSFSKfqh+w2kljss1p1xa+ilIPTP2h+
         HOpSFiMlROUUvvjL/9r6/WIOshu9s3DCWtgmr3r6H/kPc1v3PeuL7fJ26lfxYr3/FCkY
         hv3x6YFSkKxZ8SjRMkTR0/dKmDqseUePWohUtJUCCg2PsVJCbzn9MNRmuYT1avOkz8BR
         4OsD14hEJpJDoEnvDgyE5yDDdG/ahhngWWfXc3oGyUR5vswocFqLtL4MDfC0oXziMFkf
         67tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626755; x=1758231555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2CgSP+i6gOirYRCe6SP5XNRa5WFOHuIeP0ROyizXdM=;
        b=OJxXdkLtC8oANN4FSf2DWzxyagN0xf+9ib4J72TLHpAtOzH+2qnQ+J4g5FelqlPCZ8
         wWTZy3o1Dg92gvO0OlvZ84/HQq9eqGqnvaBP27TrqRbPrCk5cEnhnO8gPIaimIlpZ8LQ
         JNt8T5Qp3UXyi/nAR2+LDQRPV/ya0AEz0Iq9yVQ5sRPkvwr0861tfB2DBQEoxs4z7QQ4
         G5MHSn0VymFA4neJ6IizYlJI0hPsQAtXOOQzgG7V8ElfFCwDB08egVpIMF3QEro1kTxa
         fhGX7Q9iWdnAvBXbkNzebCqr5dUs2KStWq3OjdGK1tqMFzrfXPRmfzo3oJ1ZO/RlmksP
         3vSw==
X-Forwarded-Encrypted: i=1; AJvYcCXwTdwnlKZLKmzZJ7x0VW110BKGdSoMDd50yfZHA1bEGE/Fw/tFQ2okuoHqE9TSnmYkHc4ndhuKj5/xbIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrtQTQLwmNF+Wg1wrJl3GZS+M0MsWmfs+OdZkgLcXV/HFHIn6
	j97O2n9h4fbppD2/A7c0l0Cjg4F2N1SzwfVYhCvQaCOQ8bDumbu4oIb5
X-Gm-Gg: ASbGncskhQhZJJeQVU1OFOdA3oZ0x+lys/S4jRLOed3YtZpOm1OjzVAoP5elq95MLxJ
	UJ1AbsoC2yFULYTy6vaSeS5eUVAPjIj6d4dL7dmHnuiemQLV4XtcpFHArMBohQFh1yYMoN0siUI
	/u8A8js4/sA/mxtBvkGx1891coxkVP+nxFOTN3hb9ru9VxEAPKk6FpLnCAe2Rs9y0Bov4FTNZye
	5zEoeg15F6lzJyN8DrPH+NCl8GpIN6PT7b7retVqGiOW6zs/mfwvWGKiKNaWYy7MweYT7SZiDlR
	qFxAdeEBGZtjbWECVyCHYeQSvYOrMlKrCfXuANAf6s0DWqueQ2WGXm5cpzfKarPWAPB6nAG5B6E
	Sr2G6Ei8WOUBBjKaA4PTiKdKvu8hQX80PoxL5iI0shLoLW7s9NL033tb3Wb+YdfLwTKYrRsxYPC
	Fdpkz7jx1Crem1Lw==
X-Google-Smtp-Source: AGHT+IGi0DsBkN4i1rRayYbwF56OCzmTqb1akdCBWnBpmYXeEm/h1+7sigjLQw1NfYWzcsMIU86vZQ==
X-Received: by 2002:a05:6602:2d92:b0:88c:34c1:810e with SMTP id ca18e2360f4ac-89033c6af2emr132171639f.14.1757626754773;
        Thu, 11 Sep 2025 14:39:14 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 27/30] selftests-dyndbg: add test_mod_submod
Date: Thu, 11 Sep 2025 15:38:20 -0600
Message-ID: <20250911213823.374806-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new test-fn runs 3 module/submodule modprobe scenarios, variously
using both the generic dyndbg=<queries> modprobe arg, and the
test-module's classmap-params to manipulate the test-mod*'s pr_debugs.
In all cases, the current flag-settings are counted and tested vs
expectations.

The 3rd scenario recapitulates the DRM_USE_DYNAMIC_DEBUG=y failure.

1. 2 modprobes (super then sub), with separate dyndbg=class-settings
   check module specific flag settings

2. modprobe submod, supermod is auto-loaded
   set supermod class-params
   check expected enablements in super & submod

3. modprobe super, with param=setting (like drm.debug=0x1ef)
   modprobe submod
   validate submod's class'd pr_debugs get properly enabled

The test uses multi-queries, with both commas and percents (to avoid
spaces and quoting).  This is the main reason the test wasn't earlier
in the patchset, closer to the classmap patches its validating.

With some tedium, the tests could be refactored to split out early
tests which avoid multi-cmds, and test only the class-params.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
r3 - skip test if LACK_TMOD

older
  drop -v used in test_mod_submod(). V=1 does it for whole test
  ifrmmod at test end (Lukasz)

test-mod-tmod
---
 .../dynamic_debug/dyndbg_selftest.sh          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 513f6cb1db1d..09937dca3056 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -279,10 +279,83 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+function test_mod_submod {
+    echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    if [ $LACK_TMOD -eq 1 ]; then
+	echo "SKIP - test requires test-dynamic-debug.ko"
+	return
+    fi
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # modprobe with class enablements
+    modprobe test_dynamic_debug \
+	dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    modprobe test_dynamic_debug_submod
+    check_match_ct test_dynamic_debug_submod 23 -r
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct test_dynamic_debug 46 -r
+
+    # no enablements propagate here
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    # change classes again, this time submod too
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    #  submod changed too
+    check_match_ct =mf 1
+    check_match_ct =lt 1
+    check_match_ct =ml 1
+
+    # now work the classmap-params
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    modprobe test_dynamic_debug_submod # get supermod too
+
+    echo 1 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 4 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( V1-3 + D2_CORE )
+    check_match_ct =p 8
+    echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_CORE, D2_DRIVER )
+    check_match_ct =p 4
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
+    check_match_ct =p 6
+
+    # recap DRM_USE_DYNAMIC_DEBUG regression
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    # set super-mod params
+    modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    check_match_ct =p 7
+    modprobe test_dynamic_debug_submod
+    # see them picked up by submod
+    check_match_ct =p 14
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
+    # these require test_dynamic_debug*.ko
     comma_terminator_tests
     test_percent_splitting
+    test_mod_submod
 )
 
 # Run tests
-- 
2.51.0


