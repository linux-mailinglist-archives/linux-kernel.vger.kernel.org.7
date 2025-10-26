Return-Path: <linux-kernel+bounces-870583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33BC0B2E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327A13AFF0D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1252FFF97;
	Sun, 26 Oct 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4Xg86vv"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345522FFDCB
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510119; cv=none; b=PJ0yQle9wayPb4RM6VWWsFS41gvwEv8ufyZwF1WHqZay+wfxKpypT2ZoNWjUsVedjB7Xx4yGK4qt84CHhLfTx0n7Ilx9ieLeY6q9BIgHi63m8Ak86fdrwmjS65mL2fqHUUphm/rm0WWrXjPs0vtfZj6RW3+4I59B+RVrHD1VedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510119; c=relaxed/simple;
	bh=N3mn3jtqr7f8HNG2DIDfaOlSX3NGho6+CId/b6FYS8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WluNzcB1wJYzTLXy+VgDiq9elIEXnI9U1O9TQKLIzv7KSfPdssp2dc19ZSdcqwaHE54t+whll/TbC4KS1qF/HKNasJ7sBFfJCcSZdF5FjkYsKIsBiz+OtvSaIg6nG1Qu2luhVL9vq3UQzxhBeA/QSznzn13l7PemYXVPU+6DQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4Xg86vv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso40403855ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761510117; x=1762114917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMS3PI8XML9mSaAJp4Ws8nz4ou7XIeiRLoOGzBW6NzE=;
        b=Z4Xg86vvvDzfe3vEbk01TsrTd3ATHVxVjSJS1r3QilfZLlW/papHA1M6J40T2rMy5j
         V9Js2vaXTep+lHyIqD0M2Vmr+fwgaPwc2U1TJsliScrZx5X4sUcf6XBM9FwaQpe7dPn2
         NvhiAZLG7lD/VRpOCuNXUj4pkTP58KbVR0qKnhgQX2SKVZ3QUdJE6EAEqzvgIhAVRhke
         JkNmRqrBjwGKstw+MHFzBmkQoesLsxfZyd+aUOCDZCe7Vdz19beJm3T6Xkh9fWpoDjCR
         62g0Fn3Ki1wwjvcw5MRDt0bi4zSzZqMqNgNR972VveKku8Uou6ZUNlz6KDXFYCg1N6DH
         K1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510117; x=1762114917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMS3PI8XML9mSaAJp4Ws8nz4ou7XIeiRLoOGzBW6NzE=;
        b=Oohir7nOAq5B85oqbuphf78JUxX/mJonqN09GXB6ByDxwjyXTK6lNuPPH6ywL/B2Aj
         +kK94icOXIqa/rr72Qm8+AMcKEERF/uylJliLbOu+BSsEsN4eJc06hDUL1Zyy/37vQjK
         giUuLRrLOqBqlzjd5mEMrgouGJAGbMCTJ2upf9e3OOpMyuaJTWvKoN09X6jhV45PKGdh
         35lZuuBHKd6X0VJaxCivVJPwVuTvsGc2ay6QsXKzLEJkYNuWZRKdOG/k2wd68uak6c1S
         p3B3gVcO5yQzLONTZkOVm42DXk0SBBvHER2C9Tt/DC2PddV/kKS4FXqC0rGCB599oAfF
         pYwA==
X-Gm-Message-State: AOJu0Yze10wP/Ztb+qF5HKjQ7XfAD6Lcag6epy5l4IAn2x0YyNJ91rEx
	kYmVKdSG7OEn/KAjFQTU3Zbk0cWpnbmTs/6C5EP8d0X5f2/N+7sZjQvqgChjmQ==
X-Gm-Gg: ASbGncsx/PwY6Y1O/z02iOaYQ5J7Ps5h6/dSc4wRsjqSQwoe/IhUsIJJ7t1YGYJMul2
	KEt8/hvLkOc25zwjMMJFYtbRWXsi7oLE+C57KLf4QBf0+kJKUycnjFibwEUx2YUlL+T6vTXvGls
	gk4u9lJ2uDnlOeFxKwAQvcgu+jj+6ckrrAWQXxkullzCXUcGIGdYeFI0ufgaXvcCLUrXR/HGR3F
	slT6yrvc+C1qsvGMAMiidsIzRYkPhMdhACmSQFLcOijMjlyu1SDVWLn8t8osOcopR120fwPAkG9
	fuQo/rH2LKsqLBhD+WvOnIADIG4Kg3kHG0fgrzz/dwlkVeH4pdcu6ZFmOkrVVSqrgdKkWCNwUyw
	Y/86zDI/Za+p3I0Y+VzVnQOabgVOIeCC7A7ALRzhjJDUxWoGaErtskm9J6zQhRky0/kpIy74sGI
	OqH8N2zXhjCfy/eWwWwD7d4Y6k6ZN6XJANSdsf5g0EwtFbDJ0UTgWoZkkR0Ju4hOsUSmU=
X-Google-Smtp-Source: AGHT+IHoD/E6/7S4XtlsDVYIgNQ2fcmlLSJ+sViycIXbntq167DJGyVxGCHUMpBxeARcNlYgNcasbQ==
X-Received: by 2002:a05:6e02:2488:b0:42f:8d40:6c4b with SMTP id e9e14a558f8ab-431ebee1b8fmr126908725ab.11.1761510116921;
        Sun, 26 Oct 2025 13:21:56 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5aea995e766sm2278412173.51.2025.10.26.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:21:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 1/2] checkpatch: add --debug rx=1|foo option and drx_print() helper
Date: Sun, 26 Oct 2025 14:21:40 -0600
Message-ID: <20251026202142.1622060-2-jim.cromie@gmail.com>
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

checkpatch has ~235 heuristic s/$patt// statements which strip
code-snippets that are "OK", leaving the remainder for further
heuristics to apply further "cleanups".  Many of these have obvious
purpose, but surely some are inscrutable.

To help with maintenance of those harder "cleanup" cases, add a helper
fn: drx_print($reason), which is designed to be called from a s/// or
s///g statement (in the 'replacement' side), to "explain" itself.

You can use it to instrument the code to show its work, then validate
that explanation by experiment and exersize:

  s/$patt/drx_print("why")/e;		# maintainer's best guess
  s/$patt/drx_print("whys")/ge;		# note the 'e' modifier

To activate drx_print() output, pass "--debug rx=1" to enable all the
instrumented cleanup heuristics.  For more selectivity (in case usage
grows), pass: "--debug rx=foo" to select "foo" cleanups.

Here it is in action, on a patch which triggered enough noise that I
wanted this visibility into what it was doing.

$ scripts/checkpatch.pl --strict --debug rx=inspect ../linux.git/pt-1
drx_print: -arg-inspections-
  >> Matched (`$&`): <__builtin_constant_p(cls>
  >> Capture 1 (`$1`): <__builtin_constant_p>

Also validate --debug KEYs for clear error:

$ scripts/checkpatch.pl --strict ../linux.git/pt-1 --debug foo=1
Unknown debug key 'foo', expecting: 'values possible type attr rx'

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v2 - extend --debug key=1 rather than add new option
---
 scripts/checkpatch.pl | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..c174e3bef2b2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -169,6 +169,34 @@ my $DO_WHILE_0_ADVICE = q{
    Enjoy this qualification while we work to improve our heuristics.
 };
 
+my $dbg_rx = 0;
+# call this from s/$patt/drx_print("why")/e - to see whats happening there.
+sub drx_print {
+	my ($reason) = @_;
+	return "" unless $dbg_rx;
+
+	if ($dbg_rx ne '1') {
+	    # $dbg_rx is seeking "reason"
+	    # search w/o using regex, to preserve caller s///e context.
+	    return "" if ($dbg_rx and index($reason, $dbg_rx) == -1);
+	}
+
+	# report what was matched and removed (in caller)
+	print "drx_print: $reason\n";
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
@@ -451,7 +479,13 @@ my $dbg_values = 0;
 my $dbg_possible = 0;
 my $dbg_type = 0;
 my $dbg_attr = 0;
+
+my @known_keys = qw(values possible type attr rx);
+my %known_keys;
+$known_keys{$_}++ for @known_keys;
+
 for my $key (keys %debug) {
+	die "Unknown debug key '$key', expecting: '@known_keys'\n" unless $known_keys{$key};
 	## no critic
 	eval "\${dbg_$key} = '$debug{$key}';";
 	die "$@" if ($@);
-- 
2.51.0


