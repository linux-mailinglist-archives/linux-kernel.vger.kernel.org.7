Return-Path: <linux-kernel+bounces-894114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD7C494E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35FF3B5490
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC662E8B83;
	Mon, 10 Nov 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VV4ShlZJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB12C028D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807608; cv=none; b=cen119qL6MfknfoOQuuXZLIHyhbY8NBFB7CZ3WOsCkce4LV2TR7apsOu0CPx/jGKatoPi0prHqWLQ+mozIHXUxqMIK2zXN4FSQ+IyCnw/uEHzU/Ghy/QGK6+acQm2+Yeai1PLpoABB042djiqZV+Cea6vVy1SGmBk42kHtOfV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807608; c=relaxed/simple;
	bh=bDtYcr71OgalFhXjsq/M0epBO1v5ajAOo0i4lFgi594=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbuDpvujHzqgZ/w+iPodytZEe5iOLD859DJKe5kP/8XiHd3H6antEhnAtA6ghhfgnoRj5YmmL9qj9MFES6lxpS8ALMTpZkosyJaA236UzXDnB5FQ4OmQ/8Wq5AQmeTmDbepGW0444audDpq/z9cLRJSF8w4CJKZyaeM6tRYq7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VV4ShlZJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-298287a26c3so13045525ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762807606; x=1763412406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2RwmV+Plecc2y6KltRNG/pcHkH48NeEz4paebpqfts=;
        b=VV4ShlZJ97k5xxH92Icwb2JsJNkFPF7M87O2nUvgElIM/f9geNEnmTO384sM2Jp+kA
         Wq789PW/dRs20cAV10P265xJ31SoVCl0ABtIXNCIm9CmGQIOoWrt9IHxaJIoo29eZMx2
         R3b4EGHu2i5qHnp9dZC3ysa8eDLs0P4p9thlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807606; x=1763412406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2RwmV+Plecc2y6KltRNG/pcHkH48NeEz4paebpqfts=;
        b=wLJPfN2zPOb442HVZUKmOouieHkDN7Wnq6IbdZQYXUMBgTI3B282imDz+PpINUSVH8
         RY6CQol3SX7GLj7ghV5dz18E6NhLD42SOWjka8GM9FYT6U3EbL4r2oQQAFbN8MuU7EAK
         tTe1QTlF3yr3JNUXx70i8Wzq+NRfRKkYWC+wxAB6lWcs0y7AuNMahMB44jOcr8jaAYw+
         gbgRoidFt2FlEnX3g2FMDmqSEdTxjTnOzLeWYQSCeLnZQ6tuP97SrfSVqa7ToMwNrqxm
         XF+q6qY2quTGu4yFqqm5ciEX70x5Pht523NM1xvWSAzT/m2hlm7DMhR25btPIvyBRbHM
         KGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKJ2vThgz/uu6/TVDh40Z365RmNcYsCKHFJOicWhWYhjZXEfUj5rLdKRfvPa8G1lenzIUwRqHJ4y7ssC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYChiVYwmLOWIQGDNf7VLzbKqHDLAS6FczFxTo+63ZSGHSPVP
	PfZZ6x7mVmpkbhjmLDyRYBhi9Gf5FmRc8XAf+w32in3Tg/x7kS2wb2NJXXLyzk98pw==
X-Gm-Gg: ASbGncsLFKSDPcLvXBuBNTQ8E369MZNY5aIwmgaZqu/gc4VGxfjH9TuYjHkP4RIgnBf
	v4kSdHnuaue9H+nygiZCE8kXV2hFhf7/KhMoREZUM3ipL5mB1HKN2B+Qv1eBJn/ZwGdJvDabpQN
	oL6TE0Rhsr6gssGigo4qKhrlC0kZxzZ8NQwSjXUTA2S4ONuCS/YiY7CgZ3PTWdKB2sWkJyxXl3Z
	soRZONppm6vjCCZyiQVCmKNDFLOtI04JBgetlyM3/UVNC/AsfhjKih13kmZ6rRYwc4IS7jwAWt5
	NhiO20HBc3ks6lBXTo7zzT/naeofVYQd0rAcZ+FIqgCRjlgmvLmxjWyv6wTBP+QXSSxlYTPNAok
	pi3fAifAxhpxzSX+Ij0nr94Fak3nLHBdXBbdWeUOf8D4c6Iz96a97OJow2Fv+8RibuZPL1C/eML
	+GwIlIzTCa8T7RoglE/rkfxbUh1zlDpr5ylLimCCImm50baI51QRefxE0iwet8IteCgv5Ogw==
X-Google-Smtp-Source: AGHT+IEWkeVYOTxmIytyiphE95wWW2ERCqcvZC013CeVksHO653u902G5XjtKu0ZbNC0EvHGOvMNZQ==
X-Received: by 2002:a17:902:da4b:b0:297:dfb5:5b90 with SMTP id d9443c01a7336-297e56aeb4bmr117430345ad.28.1762807605810;
        Mon, 10 Nov 2025 12:46:45 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:51a0:4f1a:8141:37d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e5bdsm154992935ad.39.2025.11.10.12.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:46:45 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] checks: Allow "__overlay__" node at the root of an overlay fragment
Date: Mon, 10 Nov 2025 12:45:26 -0800
Message-ID: <20251110204529.2838248-1-dianders@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking a `dtso` file will give the following warning:
  Warning (node_name_chars_strict): /fragment@<num>/__overlay__: Character '_' not recommended in node name

Add the node named "__overlay__" at the root of a fragment as a
special case to not warn about.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 checks.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/checks.c b/checks.c
index 5d092164ee12..908df5b98ec5 100644
--- a/checks.c
+++ b/checks.c
@@ -192,6 +192,25 @@ out:
 	return error;
 }
 
+/* Return the path after "/fragment@<num>" or NULL if path doesn't start "/fragment@<num>/"" */
+static const char *get_fragment_relative_path(const char *fullpath)
+{
+	const char *p;
+
+	if (strncmp(fullpath, "/fragment@", 10) != 0)
+		return NULL;
+
+	p = &(fullpath[10]);
+	if (!isdigit(*p))
+		return NULL;
+	while (isdigit(*p))
+		p++;
+	if (*p != '/')
+		return NULL;
+
+	return p;
+}
+
 /*
  * Utility check functions
  */
@@ -324,8 +343,20 @@ ERROR(node_name_chars, check_node_name_chars, NODECHARS);
 static void check_node_name_chars_strict(struct check *c, struct dt_info *dti,
 					 struct node *node)
 {
-	int n = strspn(node->name, c->data);
+	int n;
+
+	/*
+	 * The node named "__overlay__" is allowed at the root of a fragment
+	 * in an overlay.
+	 */
+	if (dti->dtsflags & DTSF_PLUGIN) {
+		const char *frag_path = get_fragment_relative_path(node->fullpath);
+
+		if (frag_path && streq(frag_path, "/__overlay__"))
+			return;
+	}
 
+	n = strspn(node->name, c->data);
 	if (n < node->basenamelen)
 		FAIL(c, dti, node, "Character '%c' not recommended in node name",
 		     node->name[n]);
-- 
2.51.2.1041.gc1ab5b90ca-goog


