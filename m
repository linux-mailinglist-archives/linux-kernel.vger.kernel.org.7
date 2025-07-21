Return-Path: <linux-kernel+bounces-739621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D6EB0C8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8541884E15
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52132E0923;
	Mon, 21 Jul 2025 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGdPS2+o"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2062874E5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115090; cv=none; b=fD/iEKhQsszUztiwHFmIQedQU14MRp4PRP9okk2TMCBFj+d71zXbLjDuEygRonviOG6/efH4xFZA3UNaL79sG4E63oc+Rr3bdDW9EVoHEuI26LhYyRyQnMP/NuDsg62ZdIjluI/5I5Gf6LTekdxaFpYGIbP+oBEy9PIksF9lXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115090; c=relaxed/simple;
	bh=8sEbDj9vBNHEJKpspo97OgS9mpSwc5mjELVu6i/LY0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAO88BdPeCXOjfFIE8Hky24PwIdz2/+OoaXGt7HZaH2tokVCWb8KSo2Jxhn4U8HMSVVieOd2Mac7wz8ryt4axnSQApyhiBOqTZ+XHI1Zmxe9N2+GPA5AW4Yo34hoHJon5QT2Id5BRRBOH8q3i7UiDG80dw0zFpTAJ9YSeWYV4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGdPS2+o; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3005517e7d0so596689fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753115088; x=1753719888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBR3LC4WKfNMqS8rfmWZXatbGdDNbgY7SzZjI1phRx0=;
        b=RGdPS2+oGmw8d0p09RxrtpLFJVNBq0SeqUsqhiix2aQeX7LFJ12ElL3J5FBqNQX4uj
         BKFzTqvfiPF6NDYGCnbxbyW9cyl/GDWPOzBEier3gKahur6fxehrUFk3On+tNlpQ2Z10
         Niv7JUNq9dlkwg472776XwtQNX+vS0f2na+v5lKfIOgAKx8fgZvSVDhHfuaCtmXc+7s8
         0H+n3rJJ6RGrYygWtjZZ+rB/gpDtB4umkI8gQNBlo4fF2X2q5RHF1UuThUw8XpzocCfC
         jYz1MeL1hrwv9Lp+W2/fLECGykzMmyo3Yk2oTWWFA9StU7pKWkwm0IvCGzCx+oCP77UN
         v1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753115088; x=1753719888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBR3LC4WKfNMqS8rfmWZXatbGdDNbgY7SzZjI1phRx0=;
        b=toLHceG0kUfMlO07LvKOESIjKy0ioULSb5ZVjwKc8Md6qXOXc6cLfRGoDftn12qRbZ
         JVcS0SsznwJZJNkH8RBH/CyOd3U6O8OkNO0swIpe+TtTrHmel07yl2Gv0um7K20fVZnR
         B6Cx1GwmU/cb0mzmas/oCPx/sb6gfXdovk2Gj2rsH2H/mXrUjObDGzud1EBZOl6XFZOv
         w/gPhwaTT5cugUsN8W8IqAmM+wxrlPpZAot88HyUDFepFopFo4gGk7gP+wZfwydJ0nHu
         gsjlMq1vktPCVDghmM98orVP0TZtyPPBw/WheUzIUbD2RiBB+yVmC6Yry4B/TNBQvll0
         nTTw==
X-Forwarded-Encrypted: i=1; AJvYcCVoy93DT+Q5Ka2pruqOiod7NNeRrjEfynvdEYolRQS6SBYJK6Rn4QLoffLgmTZo20Z4jSSMc4kCUK/7SXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjoK2BxTHvUwqmtW9p4xvtAEPzulVlXPy8pQvOOpf4Ic6X7CAx
	AOuAKhOHEDATaweBsxAz/wJBWHKcQ+uBte2lc5gU0tih2XyigtO2M1dU
X-Gm-Gg: ASbGnctHyLcyu04GWT/toK/D5qQ2Kc0Iy+faaY968g7BUZNuyi1Jiq+OiYRmgttFqdR
	bs3yZagz0yirQjKfBjM33YHLtFgyZf2Ov05X2K6sHYRzOoKuAvCJjcO0oEOwNmFjvFzLP8Bf7BP
	5afBMNgycmfE566qmiA1YVikJMi/sUaWTH0kZf/o/sHOFQCDlnOVyEsnB4e/5ntG6wzasJ3SbXr
	UQwdFCP5Yy4SKp+KQ2T8Bc7CPM2Egso2vbvAJfbUlK/YLORNtF0H0tMNgaOg+/ghK1xasdSdzPn
	iULFfq50J6TefO+RthJl9R4tlKIVZ3kIV9RBsKAeUghzVFN1J/KR35o28O0XXtey0dMMlsBw+Qh
	17ygmWnA8zjFDzeZrprHahSByTxAR0oZiuRiitzrQVVY16HuMTq+kIw==
X-Google-Smtp-Source: AGHT+IHDSvqNybpPEMfV+g79QhobKBbhLnABgDuSoNZ/TP8oY0gaPWVqti2e42Rny9LG10TLf7rdjw==
X-Received: by 2002:a05:6870:7059:10b0:301:a823:9cd1 with SMTP id 586e51a60fabf-301a823a7cbmr5488137fac.22.1753115087586;
        Mon, 21 Jul 2025 09:24:47 -0700 (PDT)
Received: from fedora (181-162-150-76.baf.movistar.cl. [181.162.150.76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83bca6b5sm2935120a34.59.2025.07.21.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:24:47 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH 2/3] checkpatch: enforce 12-char SHA for Fixes tags
Date: Mon, 21 Jul 2025 12:24:33 -0400
Message-ID: <20250721162437.6691-2-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721162437.6691-1-ignacio.pena87@gmail.com>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel documentation recommends using 12 character SHA-1 hashes
in Fixes tags as the best practice. While 8 characters might be
sufficient for uniqueness in smaller projects, the kernel's large
history makes collisions more likely with shorter hashes.

Change the existing check from "at least 8" to "exactly 12" to
encourage consistency and future-proof practices.

Link: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7ccdc774a..204800232 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3242,7 +3242,7 @@ sub process {
 			my $tag_case = not ($tag eq "Fixes:");
 			my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40} ($balanced_parens)/i);
 
-			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/i);
+			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12}$/i);
 			my $id_case = not ($orig_commit !~ /[A-F]/);
 
 			my $id = "0123456789ab";
@@ -3252,7 +3252,7 @@ sub process {
 			if (defined($cid) && ($ctitle ne $title || $tag_case || $tag_space || $id_length || $id_case || !$title_has_quotes)) {
 				my $fixed = "Fixes: $cid (\"$ctitle\")";
 				if (WARN("BAD_FIXES_TAG",
-				     "Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
+				     "Please use correct Fixes: style 'Fixes: <exactly 12 chars of sha1> (\"<title line>\")' - ie: '$fixed'\n" . $herecurr) &&
 				    $fix) {
 					$fixed[$fixlinenr] = $fixed;
 				}
-- 
2.50.1


