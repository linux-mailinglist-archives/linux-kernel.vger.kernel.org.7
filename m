Return-Path: <linux-kernel+bounces-820581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A5B7C5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88EB1894B10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F884370593;
	Wed, 17 Sep 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="XkKJ3tj6"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E7284886
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109795; cv=none; b=L1cXocFCaKDiZyN683RQlYX35aL+0chqvvgHC3EeqaXBKHF0inDeSaZOnI4b9AXao9+3VGvJfs1R26qDcnzbeDUI6/SiECtrNiQa6yq5b3XET7yK9FkETFLR4AZeAmQg2iOst5nw/vGrHwbXfF5f0HlfJHlYeDTpgNSCrZjhRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109795; c=relaxed/simple;
	bh=BjNgs3u7AaeqcRW+5e9NeOLlcacR6S74LKkdYyjyjkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P+T2qE44aC/TdD263f7Q3UY4O8P0quYogSnfLy54B7TPH3R5upqnPkgkFYA6P6wrcXBH3AjB7t54JrG/ReXk4S6cds1gjNABKaTsrmqKvdf3R2wmXV65Rcn7JCwFH3bJ13Oi9EatVDbYXTDEeMN/MRFqGfT7zUKuYLL5JY9Tc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=XkKJ3tj6; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:149a:0:640:77a6:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9453E80CB5;
	Wed, 17 Sep 2025 14:49:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VnPA4b7M0W20-cxi65zQ6;
	Wed, 17 Sep 2025 14:49:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758109781;
	bh=m33lJfHtMKJDuHDxhPbYb1HqKcrS+3xFCkuNddL5Yu4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XkKJ3tj6/4WZmnhUbpITG0Z1VCF+rZVWxJFP2B9x/frHnqjDttglKpjGWAmF8aWbg
	 sWC5CU/mUYgspPJ4lpM4EyWGHQWVAFNbJGmvfA5vGMbqKfVMSo2X2jORq+CBo/G9A9
	 +hLBI2zHK1QaAanbJD/ZFUQVV913uq8HeD13zkX8=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] checkpatch: warn on unhandled placeholders in cover letters
Date: Wed, 17 Sep 2025 14:49:09 +0300
Message-ID: <20250917114909.7678-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds a new check to detect unhandled placeholders in cover letters.
This prevents sending patch series with incomplete cover letters
containing auto generated subject or blurb lines such as:

    *** SUBJECT HERE ***
    *** BLURB HERE ***

These placeholders can be seen on mailing lists (e.g., searching
for "BLURB HERE" on lore.kernel.org). With this patch, checkpatch
will emit a warning when such text is found.

Example output on an invalid cover letter:

    WARNING: Incomplete cover letter: placeholder text detected
    #4: FILE: ./0000-cover-letter.patch:4:
    +Subject: [PATCH 0/4] *** SUBJECT HERE ***

    WARNING: Incomplete cover letter: placeholder text detected
    #9: FILE: ./0000-cover-letter.patch:9:
    +*** BLURB HERE ***

    total: 0 errors, 2 warnings, 24 lines checked

    NOTE: For some of the reported defects, checkpatch may be able to
	  mechanically convert to the typical style using --fix or --fix-inplace.

    ./0000-cover-letter.patch has style problems, please review.

    NOTE: If any of the errors are false positives, please report
	  them to the maintainer, see CHECKPATCH in MAINTAINERS.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..9d5ded376112 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3339,6 +3339,15 @@ sub process {
 				$fixed[$fixlinenr] =~ s/^/ /;
 			}
 		}
+# Check for unhandled placeholder text in cover letters
+		if ($filename =~ /cover-letter\.patch$/) {
+			if ($rawline =~ /^\+Subject:.*\*\*\* SUBJECT HERE \*\*\*/ ||
+				$rawline =~ /^\+\*\*\* BLURB HERE \*\*\*/) {
+				my $placeholder = $1 || $2;
+				WARN("COVER_LETTER_PLACEHOLDER",
+					 "Incomplete cover letter: placeholder text detected\n" . $herecurr);
+			}
+		}
 
 # Check for git id commit length and improperly formed commit descriptions
 # A correctly formed commit description is:
-- 
2.51.0


