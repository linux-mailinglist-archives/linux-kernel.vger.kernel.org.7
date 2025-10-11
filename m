Return-Path: <linux-kernel+bounces-849215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0C1BCF868
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1B21897DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42227B348;
	Sat, 11 Oct 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rWuyh+pR"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69C25394C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760201262; cv=none; b=fbaSID2z6l2q8ScpUcsRUkbW5FQKT5dATGpcBisNQjUbCDS6WgEJmfySluDDT51UM9FEdZZjcVqUa7/UbESoJkRklayjeXYoJdle2N+1A+Hbg5z2Eklzl3oCHKZT5kOG28Lqua3F7Eoqdy+G+jU/XxxVIBB8hQH4Ir4U+noGtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760201262; c=relaxed/simple;
	bh=fGVG52Y82cUySorCGcOkBgiHgXECV1mKxqVtfWSLiRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIITPVaPOnp9S5cwNcro27ktj9WFf5yJU9otzqEtI1xZHjQqGslHWtk89mjYE19wYlZiDx8N70NEUQIg+SyH3dwndHspQFipj1UFziCstEIyHNSCwYOiw/4H3QmmOaVGrXePaVG/GbCYQGIYXsqD/plRwfFrO9uDWiY6ugMwBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rWuyh+pR; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760201246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gSknqdlTSyHOTAHT7zBoyDdcwa8l+G5IO//pKKOLLb4=;
	b=rWuyh+pRZiywyah6/wlzWCvVMmH9EeSiUFu6WWHX35PO8B2CpEJj/cwzv6D/NBtY43EuR4
	mxhO/UfihAKPKMANbX8ZXhOu8PyGdTdcbUOop4M8TS5ZCwiobT+ixvFy034/FmIxHEuNLd
	wjzlKXsstil402Syviv2Nqp+Ns6D+Xc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init
Date: Sat, 11 Oct 2025 18:46:46 +0200
Message-ID: <20251011164645.46822-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated and sprintf() does not perform bounds checking
either. Although an overflow is unlikely, it's better to proactively
avoid it by using the safer strscpy() and scnprintf(), respectively.

Additionally, unify memory allocation for 'hname' to simplify and
improve aa_policy_init().

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/lib.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 82dbb97ad406..acf7f5189bec 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -478,19 +478,17 @@ bool aa_policy_init(struct aa_policy *policy, const char *prefix,
 		    const char *name, gfp_t gfp)
 {
 	char *hname;
+	size_t hname_sz;
 
+	hname_sz = (prefix ? strlen(prefix) + 2 : 0) + strlen(name) + 1;
 	/* freed by policy_free */
-	if (prefix) {
-		hname = aa_str_alloc(strlen(prefix) + strlen(name) + 3, gfp);
-		if (hname)
-			sprintf(hname, "%s//%s", prefix, name);
-	} else {
-		hname = aa_str_alloc(strlen(name) + 1, gfp);
-		if (hname)
-			strcpy(hname, name);
-	}
+	hname = aa_str_alloc(hname_sz, gfp);
 	if (!hname)
 		return false;
+	if (prefix)
+		scnprintf(hname, hname_sz, "%s//%s", prefix, name);
+	else
+		strscpy(hname, name, hname_sz);
 	policy->hname = hname;
 	/* base.name is a substring of fqname */
 	policy->name = basename(policy->hname);
-- 
2.51.0


