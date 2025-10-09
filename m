Return-Path: <linux-kernel+bounces-847314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A54BCA837
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4B318851CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813B2F5A3C;
	Thu,  9 Oct 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLWsTra3"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96692472AE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032759; cv=none; b=rOMqbS7qNA0ktx7UacDT2HhYAESxYzq8Up98yO6xcouzaGuR8dxsOifo2mJU/BT1dtX38dUUUfFg7JcXTvgksLx5J3syKfdFWrZUXth6ots4C93IL4T5uzy+YBRR9A9H0yfsil42qBmH8j3xBgXTaH3JglDVsmvatJ8f61Aoawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032759; c=relaxed/simple;
	bh=FtcFgwEejWjZvhm0rHNUUhymatBzn9CaDalgPyLWlVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcyO33x8n7mEbynJPh3/Dtu6XeTZH1nzIY8JcldHqZsvbG4lyARTIKDs2sA8GYzdApbpNf2Uq7qvJDT21oZqQH8QvqrXGPLnRg42SRnexCXf320cuPW1TSvlg26NXE4iBRmw6QhadGzzV8wCbkb6QrRDUfCLQkKDEJmMjNj1O7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLWsTra3; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42f67e91ae7so12346495ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032757; x=1760637557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2CgSP+i6gOirYRCe6SP5XNRa5WFOHuIeP0ROyizXdM=;
        b=nLWsTra3NwhT3uVNmT3v1sV5oiZotbe05cEmyQtX1masV+ozvFJLiDQ1MCa1inzm/t
         dWYrjF4oYAh3EN00mxnR72xEjpKhdhEm/eUogqOHmB/n5yJw6LX6v2lA5q2mzNdt62yR
         xcvMzUa+fR5K3clydxXoj63Eg0BK3odl0vlJ6ITG2LL+zEPWd9EDD69ko4zgRHjO6hlI
         SZYGlJpS3JhrDGGBfGkBWW8u09WXXAsFHA4G5Rehap+rONj/47yn6bTaosxgHd9p0jFv
         e6fP1EPc95hDJ/aCViLcjALo09CUN2CvDF3VaDaeUqHqm5xMkT3YQDDXrqyUumC4Ffk7
         30Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032757; x=1760637557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2CgSP+i6gOirYRCe6SP5XNRa5WFOHuIeP0ROyizXdM=;
        b=ul1rmQ6VN81vCW1/ITVjBcczfmSz9UzoGKEGB4yodNWCn3oOWNNNB+GDDvMioncWz8
         OZiZzmjN+HYLmQN5Pqn7TYaNbaxBW0y0VP9ef/ExxAaukQOVeCQDsVVP1orYZEPCew51
         /dd802Nod9HfHZHLZ0Ta0ZIJ1W8ec5l6zl4u86ScM5YeNeVb+wtCHxJ8Lkji5fV7zEPe
         OuAlc49lUhllS4OClQ0ITUPX8pc1EwyfV67Of+Js8ulMht2om1EMmVuJgxNmXCGekfM5
         UoPkoQD9IbaJ/5WT6Wq5ofQbXIq9JqUoU35eXqBhOL+v1EFxSEHoLBPOQJIK2uHy5Gp3
         U9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWd1XAE3gQ61lpbQJBX+Bxq0OVr+P4jbIPBQl2DmmODZ1ZjIIOJ5dOM/azWWuXR0/opekxX9yhcd1MrBdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLN/CQmhMXivFKhHfNSlqVGdH1pVSiOjrAHsNTj/0zAjLgEkMU
	NaAyDKuGb/8sQLcqYN/pQZJfGwtX/pLzv2fKRdit25rES4MpkqY/pNEr
X-Gm-Gg: ASbGncv+Q5ofARqFX3THVnw6E8VFpAgBPScr3y9PJMcM0PjoGwlG2vsMOGxEs++4LI0
	08Z7uXOlekaIKsXdxE5TQVAig9gk7d6zjzLuS+1QNaznnCd9U23/5LynX74gbYUzxl9Ofbnk9DI
	aWTd8ZC6QpSj2sD+3bLe7jE3ffE0TbITlNBjV71IzupK/1BpVNyS8KDSDdWhwATRKd4KFjDGep4
	3GRhnw0Fezh6UKpuv5HjAFUbogO31CY9MJXsQmE/XxfMZPyT8okWvZixe5T0tJohTKDStHDdsx2
	xAWL+ZTZsT4Sj4MeElxVfNUYaqT7BGEGXyUywg2ZMYrlSqCTN7A4G2ISBQsJ5Fn0XPb6fo/GYp6
	ntRveccMBWmQYBGe5Jtt+Cia8HouwCGnShjEY10UFi9yZZVbzZVNfmQo0zMdc64u7wbdcIdWLAb
	9gKIU7ollIXleLgC8UbZHhzoU/+yngGvvlKSU+mg==
X-Google-Smtp-Source: AGHT+IHHW7XXxj0sK4ppRb/LDzTgeN6fkIFB7y2JX1QNjPDVNsmviia3UE4J533K6nBq7vvvPw5OpQ==
X-Received: by 2002:a05:6e02:2501:b0:42d:80fb:7347 with SMTP id e9e14a558f8ab-42f8736998cmr88482295ab.12.1760032756630;
        Thu, 09 Oct 2025 10:59:16 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:16 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 27/30] selftests-dyndbg: add test_mod_submod
Date: Thu,  9 Oct 2025 11:58:31 -0600
Message-ID: <20251009175834.1024308-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
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


