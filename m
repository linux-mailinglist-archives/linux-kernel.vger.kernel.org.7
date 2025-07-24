Return-Path: <linux-kernel+bounces-743478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F49DB0FF27
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C01C237C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338B1DF985;
	Thu, 24 Jul 2025 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ2WrsoC"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F81158535
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753327724; cv=none; b=tYG8hFZ3cI1VmbHrtnonVBeEYI5IHqcFu83hcR25iX9fgjU+udRn4lYwaUITuzLT6h3XtSJZm480loS23v5Aoq7kZkv20nyuCvSDTozzxULbmXT/4Scw6KDjdFtcZjRxyF+BZJYKsdwSLCrEgp0wQCme+Yi72xPfjrhx+SUkE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753327724; c=relaxed/simple;
	bh=FPZKBozteJg1oOw71d5/PskhuqR6GazPsrPirjVLmJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQvRgabXqOA30E/ebLNeL/MRU/Xhg9wN9nko2R8ryBDqhpbNK5WPXi9kClsccpXkd5GcLeB+BH5MkszFoONTcWWuxbhFkXUfUJQtMNcqQX1Wb0R8Rqnop0F03ipDlp1hqwjK6SJekHcg7Zsv1lyGJ3mnaW/9/rK0qFospczzQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ2WrsoC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e1d710d8so6030095ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753327722; x=1753932522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2jhyGdZeXG7tNFJqddE9PYgZftHVlfeYx0bTDSoEuY=;
        b=GZ2WrsoC7acWx+UBNOMLn9WKr6peUgFBqon8XvZAev92fLDHRSUgi+XCQ3kQPyc5pj
         J1n750NJfTULVgndXFRmg59kOsoY80WkJF68mqcIfnESw2ujl+7D3CRzlDhFuC3qp/ih
         3yRpLPNVlza2suBGMCGHwAts79z4N5cEF0jhou8KDQWbr4ySq1A2hTdMrZrHvmzS2HvF
         X39jnIybTo/6iMqg8QmHyladI5KiPIHy+R2I+aca39S9qJ0CDdaL4X2QvnJ38pwZqU6h
         Ra4apwHAZ0YRSHsthBrl2FwD2GOAwO2Dgw4aJVfOKbEqpdgSC++n72tF33tsov+KBVOv
         lnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753327722; x=1753932522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2jhyGdZeXG7tNFJqddE9PYgZftHVlfeYx0bTDSoEuY=;
        b=dQBNrxch/his8Av2ydw2VeLM1tz1V0+LiUYIC2QZDhDbt3x1qfvTemgxXhbra3DrxU
         /HE+zX9FQRmOdy6SvPlbVyam3uKrWrmzd4xXa1+1kfYh6yxLVLbxsInB2CGKLV5U5DSa
         QlbydhuStYSp+J367IWYDdvL+LxVTz1KJoSjW18M4/QGTtR7j7h7zyIqfTSz8zRXHft5
         Gy1tr0PuD8l6Imy5lYRJYf9fM1mgE3zheCI7R2A5P5+nID0kbx4cP+rnPk+zLmVlfmHQ
         KvKUyOVs19uxtH6WXnh+BEhgh2FGbl3ihUe6NzQuF+LMloSFeO5UR3sQhvcun7AsK6yU
         kdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjiAEgObCPNL4LY+ju6D1fMIRmAP0tbqftxNu9XruIuQyJr4Oh5aL7/WWWwow9egj5t0zRdu/75eJoX+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWnvq5U50ps0QffpW5EJhqQrA44i/P5ySVphYfepnaZm/ghmbL
	Yb8DnyyGZ17J1Yjw3OOM4cU3xM54/SFDRDz5ciwcaASdCBKLMnWgEpOR
X-Gm-Gg: ASbGnctUzg+daqEfdoCd4ygvJHM1dqIuReSRKRtwtmIbiyge4q9oIahWL0mAbEskNcj
	iccqKY2sPjbYm9HN25aBN3xl8ENDTJlyUwqt1IfI6An/2hQvy3EZXX3bTpCsfzMCE/D9eYqWIiG
	0iiWcuQbvWyF6qXBxgiuAp8APFUaJANjfJdBcNrEOdy4FguhN/Xlewb6ejLseEOObsWGf7kpgiy
	FQ09xI51SpmaDTLahIC3VLzEUNpm4AkXV5qb6+eFeSXjeKvno75xq1SsA/VysKyZCu2z6X1BI3+
	D74fQBj297ZF1o5h9JrHqR6Pcccm1py/h0HxV4coC+CCfrJmACZe6h1mWPvc6PK+MXablZVUCc6
	t9vtBbjzT57vkTCpsT2PuXnJqWtKxeLzKCLTwn3lwXiHSla0eAs5yhkYj
X-Google-Smtp-Source: AGHT+IHi6DcCdZuWuSGfkyX9CENPLwEdyy2vDOPcHkmu6XWXV7TEyCB22TdWyK7lVX5zTf0OxfKgEQ==
X-Received: by 2002:a17:903:1ac7:b0:236:8db5:7e50 with SMTP id d9443c01a7336-23f981305d4mr73069465ad.9.1753327722129;
        Wed, 23 Jul 2025 20:28:42 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc71csm3911015ad.83.2025.07.23.20.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:28:41 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: warn about novice phrases in commit messages
Date: Wed, 23 Jul 2025 23:28:42 -0400
Message-ID: <20250724032842.69739-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723030257.66560-1-ignacio.pena87@gmail.com>
References: <20250723030257.66560-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add detection for common phrases that make patches appear less
confident. These phrases are often used by newcomers and can make
their contributions seem less professional or uncertain.

The regex uses qr{} syntax as suggested for better readability and
potential pre-compilation benefits.

Examples of detected phrases:
- 'please apply/merge/consider/review'
- 'hope this helps'
- 'my first patch/contribution'
- 'newbie/beginner here'
- 'not sure if (this is) correct'
- 'sorry if/for'

This helps newcomers learn the expected communication style in
kernel development, where direct and confident communication is
preferred.

Link: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
---
Changes in v3:
- Use qr{} syntax instead of // for the regex (Joe Perches)
- Remove comment about the suggestion (Joe Perches)
- Drop the SHA enforcement patch based on maintainer feedback

Changes in v2:
- Combined multiple regexes into single expression with non-capturing groups
- Changed warning message from 'professional' to 'confident'
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa..ac270f35b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3266,6 +3266,14 @@ sub process {
 			     "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
 		}
 
+# Check for novice phrases in commit message
+		if ($in_commit_log && !$non_utf8_charset) {
+			if ($line =~ qr{\b(?:please\s+(?:apply|merge|consider|review)|hope\s+this\s+helps|my\s+first\s+(?:patch|contribution)|(?:newbie|beginner)\s+here|not\s+sure\s+if\s+(?:this\s+is\s+)?correct|sorry\s+(?:if|for))\b}i) {
+				WARN("COMMIT_MESSAGE_NOVICE",
+				     "Avoid apologetic or uncertain language - be direct and confident\n" . $herecurr);
+			}
+		}
+
 # Check for Gerrit Change-Ids not in any patch context
 		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
 			if (ERROR("GERRIT_CHANGE_ID",
-- 
2.50.1


