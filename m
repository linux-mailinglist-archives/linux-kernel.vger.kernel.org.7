Return-Path: <linux-kernel+bounces-739740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C25B0CA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5D616D95F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29572E2EEB;
	Mon, 21 Jul 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGOl6RnX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A92E2670
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121277; cv=none; b=EZzHGmfgFzrDJM1Bxc+3X9TjpgmkwkQYMH+VzzJunjk7FPqQ89NO5u8yXnTsUshQI14r/ID8Rt/nFrJwc05lXuIy8ncsqk9oGNeqRImcXvj5lTGSo4mIfrudKG649GvpyRRo10Edxphdq84rIjpzUAbqS7rEsawqOGxeiPglhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121277; c=relaxed/simple;
	bh=lDa/Sb1w6KFI+FNJXtDuKtHmWZNl6AVbVf3fLdNqOU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnAnH+l4lbWOFEM8ofFS3E+E1Q5Z9l3goUng9kJ1lYZMulnVmWrPSLLgZ/AyBvkf2kxGQHg+Qnc2jQKczCdohnw2+hZ9q3bIRjs9m/FWyZIybRj3HYNndTyQCnuu+CnPFtE1vtxH0v6oVSPNGByiaWtEZTLDTJcOn24JTUXUbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGOl6RnX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236377f00a1so38346265ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753121275; x=1753726075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg3avSwgvK5mW0N/w/dAHjIZ4Y2pxR27ldWjjh7eGpc=;
        b=kGOl6RnXTW7C3NKvo594Lz6Be1T7Wm1c5bj5jY+3cKFmHpcxe6jrJe2ZWl24WIGtAs
         VBekE3pBtCp+cy8kGmfKHNtEK1gArHE7IMcsZaUfW5Ysq0+sdvn4yPlIMbHYKoYr4IfK
         RlIj4uSXR/xbZgygvKOsxo07j45IQNko+FHsbwl93uz1VtZHtRFSwqmTWr6aC97LffZa
         Xy6mjdoH/nZHcWYCxtGEXZviLmvi8Zgv2rEbFLjS9z0W8Hfae+oI5H8OhcXZij8xbO7s
         q1f32TSnfMuFskkmfaLFBPrsfF194jxIN/cE27Z+CVXfAltZQh5rA4br25/tIXW+CZ/l
         YOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753121275; x=1753726075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hg3avSwgvK5mW0N/w/dAHjIZ4Y2pxR27ldWjjh7eGpc=;
        b=w710xVCQh1kqCFiH1wwXKlMZPq2s+yWDYezS4+bWQHthMOZPwczxaKsrF7euZFKCiA
         hjT3WVajqC1Q4HU7rIF2pXrgAFknmm4tVQLonMys7f0+EyJQoKL5l1Pd/Dd2NDBPLeTN
         hy3dTLjKwuW//khuGruO+HVuuZBKZ3h8Ma14kT8Sdf7TUbEblxQWhc7EviJ8MrJpLC4L
         uvtMAFuuMrvnX/D4wrueS7dQIDejHpp1LHL0dreZPZUoidIigpZW35+lQez4rZDqI2Us
         gDfdFmYfnbGCSLB2wBnqbBp76oSwSnxnH/qnzW3MXxBVAHGST7fUE8u7qtnwLAhcZyFa
         y4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0RNuwiz4bv4v0/1L1zlhXYrpv9vGKItNmhUUd0sMk5UScZ7MGv3mABFjEby5fnp0ZH2I16CjUNezyHQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2Y0SpAs5x7MaIIpBsuxkm9JRlznwAMhXswhOb/61fJis6IDS
	gDwU0QO4vG26pkxNwTA3eJbg3/KtpEzfzTUbXxyEzr0LY1OWZqqACfFa
X-Gm-Gg: ASbGnctuK0Bwg8lVfy1ZipdfI2MPa34UkMYWRUW740hybFHS6K74eqFuVl+hXZ1skCy
	yXXc+/42SFsJ1z9EcLhdP1HhJ+N6jC2Xj5nuwJZ+9RRLayeM3MeeQGlzjPmITQS/kAu35h+tQ68
	Vm8CEhYkZxmbLNNZ3lpVJ3KAM+6nM4Nu7VdKylz+bPKIcN/9MT68pwbCXfF/+fRInwhIYsW8L+f
	AeMtHafpOhX6xFaww9GtE/Ky7HNBZHIAydmsi1Uo7QbFUjXBI8Awpd/gUizcsUjnslTXXqH/1J3
	RYycncGpuMnQJGGOCTRHdr9ONJWHYL7obzekT4NRUF4s0HClYHenxmPrSnnlyBwiX71K4sSZZVE
	Sx2hhuAv+qMFBxp0MmcxsK4cmYRDLQeSlyVzSnP0HYofh
X-Google-Smtp-Source: AGHT+IGoaGBshrBohD7ctfdEous/W/UTcfCjyU4xa/CoWGUZQvZWBHJIvbeHeJSpp0BtQOSb5YOvuw==
X-Received: by 2002:a17:903:a50:b0:23f:6fa4:1567 with SMTP id d9443c01a7336-23f6fa41586mr100632125ad.8.1753121274968;
        Mon, 21 Jul 2025 11:07:54 -0700 (PDT)
Received: from fedora ([106.77.158.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b612232sm61325965ad.66.2025.07.21.11.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:07:54 -0700 (PDT)
From: Praveen Rajendran <praveenrajendran2009@gmail.com>
To: jpoimboe@kernel.org
Cc: peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	Praveen Rajendran <praveenrajendran2009@gmail.com>
Subject: [PATCH] tools/objtool: Fix typo in warning message
Date: Mon, 21 Jul 2025 23:34:22 +0530
Message-ID: <20250721180422.24656-1-praveenrajendran2009@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 67d76f3a1..ff26f94dd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -767,7 +767,7 @@ static int create_return_sites_sections(struct objtool_file *file)
 
 	idx = 0;
 	list_for_each_entry(insn, &file->return_thunk_list, call_node)
-		idx++;
+tools/objtool/.check.c.swp		idx++;
 
 	if (!idx)
 		return 0;
@@ -3944,7 +3944,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			return 0;
 
 		if (!next) {
-			WARN_INSN(insn, "teh end!");
+			WARN_INSN(insn, "the end!");
 			return 1;
 		}
 		insn = next;
-- 
2.50.1


