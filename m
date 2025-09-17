Return-Path: <linux-kernel+bounces-821418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D1B8134F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053FB626942
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D42FFF96;
	Wed, 17 Sep 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="AGUQp+yT"
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006F2FF154;
	Wed, 17 Sep 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130672; cv=none; b=G37rjTFiTFFCoZWukyiCzApUbOsjuq96z02sGuYbzm+xIgir0evQvz9eR8FvOqemBE4CVYLIkgI6L4Iztcjp2ADYrIKoenZDrJnis6Sdlan2Bfs2gd8Fh4XWTsKzgfVxYCMqh3yCQ679cZRfsysAFCubm2Fjg7MLMkm0WqvImXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130672; c=relaxed/simple;
	bh=tfk4fqPBXMxRIaTR8JVHfpkSvMMR2GkGexE4r9khsXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQ20S7iRSASY0dEqpHn3XKtUwlds/dJ1e5Q1nehGUkC+5aeBe28siHkAG51MlZefO41Twd/dN9Cd1f+Rv8xu2eHpDvAAoQTU1ISbfl52qamlcgu1sfYmTR6x/C8ejb2oG0OUuu17Y//4RUaS9mFmhF+ZvKF4dx0z9dVFObsBYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=AGUQp+yT; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3d8d:0:640:b127:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id BE8D8C0066;
	Wed, 17 Sep 2025 20:37:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QbVY4BEMvqM0-PhpswjxX;
	Wed, 17 Sep 2025 20:37:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758130660;
	bh=hjZ+juQ9tvN1nhjSWM62sYVPVXM0kUendq49dvZ0/Qg=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=AGUQp+yTQXYDPj34IzXXOyUNDxkWGRTVJ3V57yiw2alNANnK+VLYJKSFyA1YXkqph
	 k8/PJa1yLxafhJja+scOEMTrCDDwnTYbkpPp6ckM+e7P+FTiDKs6zdwU1hBvNaI2HI
	 oEVk9vrYk1eXa+xePloHXE97xWaaoQ6Pqd4/Dn70=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 1/2] checkpatch: detect unhandled placeholders in cover letters
Date: Wed, 17 Sep 2025 20:37:24 +0300
Message-ID: <20250917173725.22547-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917173725.22547-1-work@onurozkan.dev>
References: <20250917173725.22547-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds a new check PLACEHOLDER_USE to detect unhandled placeholders.
This prevents sending patch series with incomplete patches (mostly
in cover letters) containing auto generated subject or blurb lines.

These placeholders can be seen on mailing lists. With this change,
checkpatch will emit an error when such text is found.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..965faee71935 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3340,6 +3340,13 @@ sub process {
 			}
 		}
 
+# Check for auto-generated unhandled placeholder text (mostly for cover letters)
+		if (($in_commit_log || $in_header_lines) &&
+		    $rawline =~ /(?:SUBJECT|BLURB) HERE/) {
+			ERROR("PLACEHOLDER_USE",
+			      "Placeholder text detected\n" . $herecurr);
+		}
+
 # Check for git id commit length and improperly formed commit descriptions
 # A correctly formed commit description is:
 #    commit <SHA-1 hash length 12+ chars> ("Complete commit subject")
-- 
2.51.0


