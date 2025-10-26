Return-Path: <linux-kernel+bounces-870584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D40C0B2BA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19C018A1F11
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49053002A7;
	Sun, 26 Oct 2025 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw0uP2WT"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED02FFDD8
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510121; cv=none; b=tB/z7A59WjazXy1tic82wp8q8UgnDHArhWc+ZcdF65ZYWUTtwdUZ6Agjfto++ip4aD/Xc3Wg7iEH5umsaWy5DkfqeKO6KjlyPDSUGGIWvH3jpw9U8bun3jMrQKk2L3rK6Ce+cRuweOSkGSVNDtG0cBqGhhAquoTy/XyEkSmwtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510121; c=relaxed/simple;
	bh=e3VGKCjUxHn7nzzSTsB0ej6NckM4M6wwFuneBTXLdyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMhMXLRGSyuR2fOk7V6KxWdqGZSAhGE4cR02nlXYwbWVoMfW43TG2BppMBS0PS0wxW8DypGTQSchcw3QX7FEsAVFxk1D6KcFTLbHzrp2Ei3/GHZAKiAV59avejmjbpCOkn3Lgp9tHBUh0WJDZVCnrxdrbWuwXplc12Q5HJKcWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw0uP2WT; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-431da4fa224so40250915ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761510118; x=1762114918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh8UGtr25ZVdzNwUOEe9kMcrpoR9dn5kWpAcgb68LcI=;
        b=Dw0uP2WTD3jKgtyAfpeKl6gUlZqaiA/BJ/Crq47mqA1N83U6DINSfPcQTQzm7kII2V
         xwaxAqi3My+Bdf6FWe5mDB0qidN9q12Lx/eMoprNXcc8AqM05xnrc1ksUUIh2KDPi3XS
         XSg/+uotEo/6eYr+iZzmyGMwJXE/ojDKFiQ/0sXmEVajK1m1SzDTIZZ3OC6Vb7LJgIhR
         rildczJ7ZU1t4dkl4Wjgym1/Y1InvBvq0yreepGPF/LtXDxz6weQuT7G8OD4MfNUoPff
         xqInKICKPt3g7mQM10UVZ1yVQ5Zz3M2vuYnqXc9RpGx0Yzi6KGbwmTOeg0/weyROPi8r
         WY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510118; x=1762114918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh8UGtr25ZVdzNwUOEe9kMcrpoR9dn5kWpAcgb68LcI=;
        b=W+0d/Wgtt2nsdZieIeodFl926SBJHa7atcH8sdAobL7GZ4h6qY+7y3ssRJdMhJ6aBr
         lQ42F2ppDpwpKg4jAZmEfHjXeSnvKkd3VwVpO9HW88BCMtpBc5i0j6/s93gWhvB1R+HD
         tIYsYxK09H7CJvTS/pRqroySLLCzd+zwMPECHPcGH76Dwv4x4XGFzCgkzfzUr4c8aOHm
         kT0p/qSSO6Ehf/IkdEh/M+0j/YdDxpszA1L1MKwv362gbL+QZdT5LdsHUSdWDY2nApNG
         x+nUhzF2pVXxh0F9Uwry9i9DcrzTGCfTgiyawtXMjMsGJQS96heemSLNYR75q1BCuLTW
         kgBw==
X-Gm-Message-State: AOJu0YyUHlt5Cy4NC/4zMhx6UaIz938vYfgXfgbpUkcsuJ4swzMu6OhH
	A+rEdUG0+v5hL5D5rn2INw0x8WWpwuieXfk9/rFYcXPb+/3OSWbxLaKBlrrvaw==
X-Gm-Gg: ASbGncvTo70vUHF7bvXd+PTXuB5+PimbnGHsCt6Az2IgTjg/j7U6je6K45O43JhQ6LR
	XOWH/daP7/lsNhcpYcUXNFjTjD397UYH7xJ9JnnEPuxYpKwZf++xwN3UvmoTRy8wj2WD05O97ZY
	g/lzxqS86NWsHo9GspNG8QKCNiHxjI1tXZ44NnhBrAAF59R53lfN3Ps4WWOMwzeu80EdsGtNwck
	2TgAc8OkokCuUrOrpnBrMAVdcB4h1lelvpX+nQIXo4iU3RwZdsCBiwLggV/lxD7+LQPmlhaN+m5
	abfnf9pqOa2fml915CJ8wyQkm5P9rx7pxvzlG5pLp6lnVr7y/51CCq0fztxcDCp8wZu7cG/fTdO
	TAY06JcTUEkAuNTFDSk0usKvZlVJay/u17U1c2rYVs3z5tUMzzkg8pR8/FThkWTmNEku9jEG2/4
	YZwE5MhgTejAsX1lH5c8q0CxYTnT2ZU2KJg5J0MvGCcVVSEsyqMAH5BJGo
X-Google-Smtp-Source: AGHT+IGX+d6dExac3obZdDxdgt08jybd+8vy337PdLfb/WjCbOR6uhXViML4/bPAIKNbW5oDHxiaRA==
X-Received: by 2002:a05:6e02:300a:b0:431:d864:364c with SMTP id e9e14a558f8ab-431d86438femr195317155ab.17.1761510118154;
        Sun, 26 Oct 2025 13:21:58 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5aea995e766sm2278412173.51.2025.10.26.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:21:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 2/2] checkpatch: 3 use-cases for --debug rx=1 option
Date: Sun, 26 Oct 2025 14:21:41 -0600
Message-ID: <20251026202142.1622060-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026202142.1622060-1-jim.cromie@gmail.com>
References: <20251026202142.1622060-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the drx_print() helper in 3 cases inside code which counts macro
arg expansions.

$ scripts/checkpatch.pl --strict patch-1 --debug rx='##'
drx_print: 'arg ##' catenations
  >> Matched (`$&`): <_id##>
drx_print: 'arg ##' catenations
  >> Matched (`$&`): <_id##>
drx_print: '#|## arg' catenations
  >> Matched (`$&`): <##_model>
drx_print: '#|## arg' catenations
  >> Matched (`$&`): <##_model>

$ scripts/checkpatch.pl --strict patch-1 --debug rx='insp'
drx_print: -arg-inspections-
  >> Matched (`$&`): <__builtin_constant_p(cls>
  >> Capture 1 (`$1`): <__builtin_constant_p>

NB: see also the extended --debug key=1 facility:

$ scripts/checkpatch.pl --strict ../linux.git/pt-1 --debug foo=1
Unknown debug key 'foo', expecting: 'values possible type attr rx'

NB: I moved the 2 #|## strippers above the more complex macro, because
the latter caught one ## case that it needn't have.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c174e3bef2b2..240ddab17d89 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6078,9 +6078,17 @@ sub process {
 			        next if ($arg =~ /\.\.\./);
 			        next if ($arg =~ /^type$/i);
 				my $tmp_stmt = $define_stmt;
-				$tmp_stmt =~ s/\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
-				$tmp_stmt =~ s/\#+\s*$arg\b//g;
-				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
+
+				$tmp_stmt =~ s/\#+\s*$arg\b/drx_print("'#|## arg' catenations")/ge;
+				$tmp_stmt =~ s/\b$arg\s*\#\#/drx_print("'arg ##' catenations");/ge;
+				$tmp_stmt =~ s{
+					\b(__must_be_array|offsetof|sizeof|sizeof_field|
+					   __stringify|typeof|__typeof__|__builtin\w+|
+					   typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b }
+				{
+					drx_print("-arg-inspections-");
+				}xge;
+
 				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;
 				if ($use_cnt > 1) {
 					CHK("MACRO_ARG_REUSE",
-- 
2.51.0


