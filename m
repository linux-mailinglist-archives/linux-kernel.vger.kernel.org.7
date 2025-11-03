Return-Path: <linux-kernel+bounces-882536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D57EC2AAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22784E5A71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669C2E6CD3;
	Mon,  3 Nov 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FV7nAraB"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1102E2851
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160863; cv=none; b=sIEbBZ4C/WjCIX0xHlWwrKUHcZ45Q24Z6Mt+k40QLn/SMp8+hQTZeMLWYEkbO7EZ4IcXrTqTj5HL+tN0ba2I4iOMtJqUAFbEI00BPZ1ExoRJUNZ7imk8c2FmilGVYoN6wLFDZs/ER79egpi4ZgR9q/AwKu84sGudKwolsDaMN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160863; c=relaxed/simple;
	bh=HeGonjT1HwnQwLofOy4+RTsZ2YOng/CLAnRlBNw1iSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYVSZweYjiWrO2P8C1zQJYytQW+uSf54ZccEQC/Ska/BkAxbEYaBQ+IZ1mXB6TmKE6IZAvbzMNPZkMJ9L03I53zHP5lPYri0Lg2zA51K9SXcwoPW90OEKBl7lR60Vzt9pVMmmSYhmfl/mvIGRez6Hls/WhtG9pYr/cDBYSCZdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FV7nAraB; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762160860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCIcUpFDlcU0Ee2c787K9yU+98dCYjbjMA3KU8RBIWg=;
	b=FV7nAraBFyX+4SO6UNRkxU9YSvnGmermiWJcSeFKNhgVPQuC0ct5lj3+aOGDjQp33Wlz2T
	ZLoHvsjKlS/NSEzGsbyOkJpUmDF9ACGYr6EyBsSHdj1SJ8BwaEDrScziuhhnhd9iBdZFcc
	HGv2c3GP9wfZjPeqhXunZAniAXbZyME=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Replace sprintf/strcpy with scnprintf/strscpy in aa_policy_init
Date: Mon,  3 Nov 2025 10:06:01 +0100
Message-ID: <20251103090601.1737-2-thorsten.blum@linux.dev>
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
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
2.51.1


