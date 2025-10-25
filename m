Return-Path: <linux-kernel+bounces-870142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B8C0A050
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A053B9114
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172B253954;
	Sat, 25 Oct 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpU4n2iG"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7386342
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426930; cv=none; b=MDRpMsrIMIPb2tTY4sZaqfxynHfkx7ZClZkLbvdiqp62unmr7ki1KEGOqKdGNE4c6Fu3NDKnVD9V6YQryW12Ls1sArLwMmjr3FQ21Ezg4MJ0d1RmNiyC2nLNg9GtBp43Ev74mEEdbPxtD+VwfAK1TMTp8AupR4vHXCpMTnOV9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426930; c=relaxed/simple;
	bh=MBjMsldgaIiM/TSkuWBEOTsI2nP0x92WNyJ4yUhqwwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkfTOpQotcwxgY/14bSawuqeNz0ylg3SpRxz1gWagi4dowDLUSbh2JKNGkpJmv7YivzQbdgnSs866NXSlN7nEjGjO52+GsbzKyOhNMSS5OAM4BGJmDuJqHYUDTkV+5liGTcFpnqcJ9EvLzY5ERZ2z+63A4vUHy1PAKAYx3agAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpU4n2iG; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-945a2c8e52cso8924839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426928; x=1762031728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvgigDPn5hSTt5i2KCB2XnlpggOEWVmeiGoEdjvNHgI=;
        b=lpU4n2iG+Ob7nvmv3yP5I9ucOGm++qJ1MzAMnwaS3sb7zeWtKthT9UKI8zayxASW0R
         N4WAtVreEg+ZNzmbba4beFSeb9cU1Q/BXRnpPRpQvZ1XKKArp68KD9kOOqqa0/GkJohT
         WgR9K9tc7JSgyZAgelTnjgjQgtqbm8Yra+9iuP6a7w4kIDPIJS7z+c8KQdXkS7lyKBAs
         RWH3GsiI98BXdc3tdTARL/0ulAsbIq8B08vAqR7oBK453Gj0W9YjeecuJmpFftyM/wMR
         CAD9FyYAyOhqXPboA2K4seA6VkPpszgJqG9IT9hum6RTAeH021xnMovCTbuSUE9M3JSM
         R6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426928; x=1762031728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvgigDPn5hSTt5i2KCB2XnlpggOEWVmeiGoEdjvNHgI=;
        b=llg6ls2eRNLsj6feZFp/OFyvuZKnPA8Qkcn91geW4E2q6Q2dutoTgR3p4OpN7kYN0J
         QlibP1YTVV4aykjGcWArq+lstl/1aeZxW84OQogf5pya89l6JZlAK2TwVyv3lr7qH/kS
         qZx684SLxUGiNuanVOY5wUibtzSq5tRazbw9kXwvfBHqC/6KsQZ8YK4R/i1yiND+dwhB
         m+2G/j7OSQFxWTDLnOau/QXu+fvqdZ/hoCNPF8ZJ2LxjUizIA0gkq2lDahTobYH+luhk
         J/2aPgJGbyLDZ+Vh6mnnWuhK6f6dOrmeoAb/N2+J3mH78JeHPT069PpvYpQIR80FQqaE
         jZ+g==
X-Gm-Message-State: AOJu0YycISGPNE2dyC7mTptEonK2mlztsPefVP7JZsHRg/NbUJI96HZW
	JaZIq+1gXbJdDjWRe7ooVbwU9jneh7wEYqzzkiJhJHT0EhD9/+RyqeClsLP4fA==
X-Gm-Gg: ASbGncucHKvsqS2KcNxIWOCvmd8OuSzWSdnHc7/UZuyf7DhnLjM1ygQjsuakBkC3h8T
	ERRWir7R/iF0TLIYt0+g5SS9/WzC2QNgzQ38RQbwGIgwfjw0XGi33dKpEaJkt0N5WlhFAUBoQjm
	8AbHpXqYw0dQX8E1mQdNg6OiagyIqqdK3fS/7Jo+ALsfd3O6wxK8I/PXcDBL3c+eU/Z7D5MKcLI
	89CFbJJE/o4OB2+40H0yxwtsk1TwE5f5TBO2gOJDYhU4Tbb6ICDpOKqTHnpdtmzLDKRX/RD9jVU
	9M5GKWwWqnyJhYGOh7/zmUaFMusgzG8eK3N09FDRXSb+ms+AcIH0ju5/86xF3FpfUeRLV9Emtao
	dEoqbeLV17WpViewxJxjVXOI85s3qjGpto+RnPLJ95mtJrCd/bNiXddaOkFCIoTeIfnaVDnKwhG
	3saIYDZ2zZ/fqESWaqA0PvCcIor3KAWTDd6KIVWMuP9QiWDAlAzhZhnTAf
X-Google-Smtp-Source: AGHT+IFdTJBJnniBT1VyCsmSoPwsnUHSZmhhfrz0AmO3mQudQoRuUKKBrvRh3m67apUZpRnZo5mZWQ==
X-Received: by 2002:a05:6e02:2183:b0:430:9f96:23b9 with SMTP id e9e14a558f8ab-430c5245f56mr479611335ab.3.1761426927798;
        Sat, 25 Oct 2025 14:15:27 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5aea7ce584bsm1212138173.27.2025.10.25.14.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:15:27 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/3] checkpatch: add --drx option and drx_print() helper
Date: Sat, 25 Oct 2025 15:15:16 -0600
Message-ID: <20251025211519.1616439-2-jim.cromie@gmail.com>
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

checkpatch has ~235 heuristic s/$patt// statements which strip
code-snippets that are "OK", leaving the remainder for further
heuristics to apply further "cleanups".

Many of these have obvious purpose, but surely some are inscrutable.
For those cases, add drx_print($reason) helper, which is designed to
be called from a s/// or s///g statement (in the 'replacement' side),
to "explain" what it is doing.

You can use it to instrument the code to "explain" itself, then
validate that explanation by experiment and exersize:

  s/$patt/drx_print("why")/e;
  s/$patt/drx_print("whys")/ge;

To activate the "debug" output, pass --drx or --drx=why to enable all
(or just matching) cleanup heuristics to validate the "whys".

Here it is in action, on a patch which triggered enough noise that I
wanted this visibility into what it was doing.

$ scripts/checkpatch.pl --strict --drx=builtins ../linux.git/pt-1
drx_print: -builtins-
  >> Matched (`$&`): <__builtin_constant_p(cls>
  >> Capture 1 (`$1`): <__builtin_constant_p>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

fixup
---
 scripts/checkpatch.pl | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..2b0275dcc5a4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -74,6 +74,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
+my $drx; # enable s/$patt/drx_print("reason")/e; debugging
 
 my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
 
@@ -169,6 +170,30 @@ my $DO_WHILE_0_ADVICE = q{
    Enjoy this qualification while we work to improve our heuristics.
 };
 
+# call this from s/$patt/drx_print("why")/e - to see whats happening there.
+sub drx_print {
+	my ($why) = @_;
+	return "" unless defined $drx;		# --drx or --drx=
+
+	# avoid regex test to preserve caller's match, captures
+	return "" if (defined $drx && $drx ne '' && index($why, $drx) == -1);
+
+	# report what was matched and removed
+	print "drx_print: $why\n";
+	print "  >> Matched (`\$&`): <$&>\n";
+
+	# Only print captures if they exist
+	if (defined $1) {
+		print "  >> Capture 1 (`\$1`): <$1>\n";
+	}
+	if (defined $2) {
+		print "  >> Capture 2 (`\$2`): <$2>\n";
+	}
+	# The subroutine must return the replacement string.  For s/$pat//
+	# statements (our target use), this is an empty string.
+	return "";
+}
+
 sub uniq {
 	my %seen;
 	return grep { !$seen{$_}++ } @_;
@@ -348,6 +373,7 @@ GetOptions(
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
 	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
 	'kconfig-prefix=s'	=> \${CONFIG_},
+	'drx:s'		=> \$drx,
 	'h|help'	=> \$help,
 	'version'	=> \$help
 ) or $help = 2;
-- 
2.51.0


