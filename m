Return-Path: <linux-kernel+bounces-821415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B4B8133A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8324E3138
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19B2FF14E;
	Wed, 17 Sep 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="SelNXlLX"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB92FCC02;
	Wed, 17 Sep 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130668; cv=none; b=NivbVMr6I564bKg3UNQzL8olhMEXGDTnAZBkN4Ja+j0ns0HfhCevBrPevaa7n5AJjyFofULjiCUKkAnWoVyKaBnqh/PS8bNyAcnby2WiGFRdFtnZ9Z5lTyV0/xPaYSzYpZ2mWGV2dcuD5gW44s889W0H52TfSapDeIpE/3TUeVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130668; c=relaxed/simple;
	bh=FeHc2ONr7s04G4Tg/b/11N/b224Jf+60qRqcE40KnqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afjvhpAsBjeqSQ9HaKzYRA6Cc/xtIhdEYsLyY+buyKAeKZlyS0QbPAHqvtnTV1HUHmX6Z+ziONP+XGuoPZvTPPPbYQ6cKPgoXo63+UkEpkwL/3Pjk5rd+zD1rlz3tHGNdjcudDvfgWF85EqmW0A77iUelPWwVb8fKRx6+k52e4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=SelNXlLX; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3d8d:0:640:b127:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 9D33C804BE;
	Wed, 17 Sep 2025 20:37:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QbVY4BEMvqM0-mtIkOX9L;
	Wed, 17 Sep 2025 20:37:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758130662;
	bh=FHA5v4PLTpxfi6OmrXgAH87gu7nGTp+EMy8vrMv+SVA=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=SelNXlLXJNz9b+6uAZEwM/oAtoQmGYYKpI0/IQgMgIHlB9l7yzyLcMoO5eHj7sJwc
	 27yywaPXA2L58QhdMC7O79bR0filHEo+WsfsJg2QFJxTj/FRQrUYRZy+QN6CSB2TZR
	 6ltc6A9rjIgEhg8AhQq3eoVx5NefY4buASypd6Zc=
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
Subject: [PATCH v2 2/2] checkpatch: document new check PLACEHOLDER_USE
Date: Wed, 17 Sep 2025 20:37:25 +0300
Message-ID: <20250917173725.22547-3-work@onurozkan.dev>
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

Adds documentation for the new check PLACEHOLDER_USE
in checkpatch.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 Documentation/dev-tools/checkpatch.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324..4dccd1036870 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1245,6 +1245,16 @@ Others
     The patch file does not appear to be in unified-diff format.  Please
     regenerate the patch file before sending it to the maintainer.
 
+  **PLACEHOLDER_USE**
+    Detects unhandled placeholder text left in cover letters or commit headers/logs.
+    Common placeholders include lines like::
+
+      *** SUBJECT HERE ***
+      *** BLURB HERE ***
+
+    These typically come from autogenerated templates. Replace them with a proper
+    subject and description before sending.
+
   **PRINTF_0XDECIMAL**
     Prefixing 0x with decimal output is defective and should be corrected.
 
-- 
2.51.0


