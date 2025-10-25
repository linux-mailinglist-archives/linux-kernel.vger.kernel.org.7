Return-Path: <linux-kernel+bounces-870143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C628C0A053
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7BEE4E5C67
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE48274643;
	Sat, 25 Oct 2025 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeeePxaG"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ABF221FBA
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426932; cv=none; b=VyxZm0AO/2P5shTCqZS/lzcjshSLj0a6s94afo84hoKPYux8idwDZG/jQDP5wVr6/WZsSr4YsaZPbWj4Fu9srUaBUYUHP152w/aXFPEgUGl1GqKIzL6t7eDsze6+3hZBtIuU2Dfe4KpA6LYuTdn352+bh4HStwXMnVFoZIyuFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426932; c=relaxed/simple;
	bh=sSEUhz+mbc7CNC+cT2dc2OhAbsKC27gwDz5MBlN/oAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGxXOrn06p1yj/FqeQuO1lYyLlVA1tS/j4DjP6Idgvq5Vi/8h02om/+imzUsvVp9fDVhpvU41363N8ChsesqwOcEKzFSNLmL21bqbDIM6EfIurtjsJal8uYyX2SUuPKScApui6pAu/zs0zzfeCQIAvZoyuoVzRbboUcHSbPaIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeeePxaG; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430e1f19a1aso17284095ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426929; x=1762031729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fkyib152otQl2jwWzh+5qLwAlw0aGs/wM5SDuJ8W9g=;
        b=AeeePxaGAW7jzOicBjMIuXlB622gbNNVT9vhhrHF8HUsrS4aJrx+QFZXXitIYiJUnV
         BD0YyCflAdE5gHD0ucth3gkm5zqO5jEO6r9wkOqlvpGndBcmzp/+Xid1aqZbexYtXbAY
         UyD/N9uYHIaA1Y6Yi6wb7nHTq44uGhEf3JEZrR1Vw7iF3QSifyjvkPHwsF7j0xiFS18q
         UucHdissJXB3Qhe0ZH07iBQrBiSy9jZjmXRS1zy78N4jq2zR5wUzuDtS+XFa2+iGhnIk
         jJTss5vNft+tCpDIN4BqWznUWR03ETZJ9qETNMYnAdSzY3K2X4lye6meuveD2h76sMwo
         2wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426929; x=1762031729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Fkyib152otQl2jwWzh+5qLwAlw0aGs/wM5SDuJ8W9g=;
        b=jFKcb8r1DGgihn9Uo31/wqNrOMh5flH1mspckl+TXe/6cSx2ByP3quQaV0d6qp2qo6
         KdwpIIN4y4BpGmCyr5mUoR4cFyWnm28msd/azTlg0evOuw8kMKlxiw4n3qclJW2WLWHA
         6ruNXZWoowqojkfz7O00NiexbPt5OmNokH8ANtnOo3MYNaxKGA0kggdxKzUnWSunp1kl
         Y2p0uvAlhG3JbcvnAH7tnRapm7xVL7dHgh5HiA0O6iwHyBBK7+Uofh28sEL5tHKrtU7b
         bdjEc90BkZQ4Uklg4gCbqYe/m6wbfeydFqHJAmeBEpQZ+kDdqsI00xSOoE8HXZBDUxU+
         9aDQ==
X-Gm-Message-State: AOJu0Yxu0p8aioMQBmEz15GCDhtAig79lGrLcQRkjbj8E7ZWO2KIq3hd
	ksP9DeR+/9pqtEe/f2CYLop3X8+Im/RcEsgZYHXIMnX+VmS2JkpL/ciC3gLy3Q==
X-Gm-Gg: ASbGncu9vUpSP6TAH90V6W5kK0jN2RmI3GyQX2MeAO5RYULX2vbF6oxFEyQUNCNZeD7
	dLIn8+ysKVSiYlQrCTv8BkvYk2v4s7B3vSJR+dcn0fi/fhsAbzF72To0+tKuQH9o9JB2VKTrrnf
	djfMACJJAYXMugnQfPI16U6gcLZsKsTapZD050liRp8Ldn2TNx/Cvtrumwlp5O0gHJ2hOfQT1GU
	sQwFYwquKwMdoN4KdzvMHG4Goey70OePUzyFf2MMmKrCdgEmFTgbhUoWQbogMI2gUOC5eJAQRhc
	LelE4cYiWxYVQ8pazJyHZiiP2Zwn7pwmGUeasKCWDJYy97W03l9jxGRWmTbKRaDzqRC2kY4q7tJ
	VMax7xMf1gGrr2kXJSRJuxbtwOlMfgI1apceTUB8ousI0aRzYOdSIAJxnuhxPc6Z2mtjAGpSmy7
	wRasyeRo4IIHtrUkR2PBbzVMjxtwDrM0e7/tXnyWeA/FZIbCw6VWGaEG8L
X-Google-Smtp-Source: AGHT+IFHODqIKZ4NVlQBiQsVgEpqNd0nlVARyGeIx/pSPW5vQYdVUvNRQe0KjOwMpN0ZebpJ3f2kvA==
X-Received: by 2002:a05:6e02:378e:b0:430:db6d:30f8 with SMTP id e9e14a558f8ab-431eb5fff30mr104251015ab.4.1761426929513;
        Sat, 25 Oct 2025 14:15:29 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5aea7ce584bsm1212138173.27.2025.10.25.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:15:28 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/3] checkpatch: recognize __chkp_no_side_effects(_var) hint macro
Date: Sat, 25 Oct 2025 15:15:17 -0600
Message-ID: <20251025211519.1616439-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025211519.1616439-1-jim.cromie@gmail.com>
References: <20251025211519.1616439-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach checkpatch --strict to allow an author to suppress specific
var-reuse complaints:

  CHECK: Macro argument reuse '_var' - possible side-effects?

Consider:

   #define module_param_named(name, value, type, perm)  \
  +     __chkp_no_side_effects(name, value)		\
        param_check_##type(name, &(value));		\
        module_param_cb(name, &param_ops_##type, &value, perm); \
        __MODULE_PARM_TYPE(name, #type)

Without the +line, this kind of multi-statement macro-defn would cause
checkpatch to carp about name and value being reused.

Note that it wouldn't complain about type, even though type is
expanded 3 times, because checkpatch knew to strip # and ## constructs
on an arg before counting its uses.

module_param_named is actually a named $exception, amongst a ~dozen
others, so it wouldn't draw the complaint (I said kind of above), but
this approach doesn't require further checkpatch tweaks, is specific
to the _vars named, and is author initiated, not a carte-blanche
exception on the macro-name.

IIRC, trybot kicks of a CI pipeline that calls checkpatch --strict,
this hint could help reduce CI-noise going forward.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b0275dcc5a4..bc807c20fcde 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6070,11 +6070,24 @@ sub process {
 			        next if ($arg =~ /\.\.\./);
 			        next if ($arg =~ /^type$/i);
 				my $tmp_stmt = $define_stmt;
-				$tmp_stmt =~ s/\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
-				$tmp_stmt =~ s/\#+\s*$arg\b//g;
-				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
+
+				$tmp_stmt =~ s/\#+\s*$arg\b/drx_print("strip '#|## arg catenations")/ge;
+				$tmp_stmt =~ s/\b$arg\s*\#\#/drx_print("strip 'arg ##' catenations");/ge;
+
+				$tmp_stmt =~ s{
+					\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|
+					   typeof|__typeof__|__builtin\w+|typecheck
+					   \s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b }
+				{
+					drx_print("-builtins-");
+				}xge;
+
+				my $no_side_effect_vars = "";
+				if ($tmp_stmt =~ s/__chkp_no_side_effects\((.+)\)//) {
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


