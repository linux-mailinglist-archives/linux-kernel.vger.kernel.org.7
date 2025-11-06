Return-Path: <linux-kernel+bounces-888784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E524EC3BE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D8D1AA05B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DFA3451DA;
	Thu,  6 Nov 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="obUKVrPB"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52B21257A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440745; cv=none; b=tvq/2RcoxfZ8iB2CRwqcz6299CFzCzYsANaDEkYbCS6VyWIlP6e3lictghv/9wSY8x9a5Q2UMCOV3WfQC5seLvBBc/6q9+/CdZiJR+Zvg6Cf0oDmKW1NhsZ5XNZIx5PsJLKGQvOVKKj6yszuDjTYg7K6u3B66mX3Tg9b9EAePFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440745; c=relaxed/simple;
	bh=LJGO1EFISHsoJp+waIuIjo3akZR52MXApU7v0jNMSaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cM9X+l5sfpTufzSHLxkkvkzvscZfKFoiozsrfDUl9OVg0Zd7P7rzjJZ/tnpB5XLfg81oi0Xm19cm+ZrSiqMt3xXYoQr5FEutXJ36v1bh/dp3j5KEDecc9phpuPnyFX9DjMYto+0237fsbbCYwE0BoJTb4NbUJnHu8eyPXQJSGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=obUKVrPB; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762440734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4R+9Ob+hbRjK0HBoBAzVyU/bk+mxiL9d1ujtEwngm2c=;
	b=obUKVrPBKtRQxQ1eSjIMNX9QlThWkVT1enKd5VRldVSDy4kELar299dPpeotu+YCHXdqdN
	izcZ0OqvhVezrPBTJziZuZF04LIw58NKFj/akqODr3NLAwNhsIa3cNRh2C7EIYrHPoK/UC
	MtNmZVK+pQGbfSanccyQqViv7JgaCm8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Replace deprecated strcpy in d_namespace_path
Date: Thu,  6 Nov 2025 15:51:38 +0100
Message-ID: <20251106145138.2123-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; replace it with a direct '/' assignment. The
buffer is already NUL-terminated, so there is no need to copy an
additional NUL terminator as strcpy() did.

Update the comment and add the local variable 'is_root' for clarity.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/path.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index d6c74c357ffd..65a0ca5cc1bd 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -164,12 +164,15 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 	}
 
 out:
-	/*
-	 * Append "/" to the pathname.  The root directory is a special
-	 * case; it already ends in slash.
+	/* Append "/" to directory paths, except for root "/" which
+	 * already ends in a slash.
 	 */
-	if (!error && isdir && ((*name)[1] != '\0' || (*name)[0] != '/'))
-		strcpy(&buf[aa_g_path_max - 2], "/");
+	if (!error && isdir) {
+		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
+
+		if (!is_root)
+			buf[aa_g_path_max - 2] = '/';
+	}
 
 	return error;
 }
-- 
2.51.1


