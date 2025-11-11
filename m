Return-Path: <linux-kernel+bounces-895278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC7C4D6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FFF24F741E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693293559C3;
	Tue, 11 Nov 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EruHLEHD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EBF23BCEE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860416; cv=none; b=QVqugmtGaiNig1VW3ln69XQE9hiR7l0Qed3t98oFoVEz/EuMUb3NyMh8tF9daNJq7mQwuvBsEE3+PCnuuPiysz17FIUt/Pds+kyaiT7FBPrwjBNVMbH/dX1a3fF3oVh5nzwqMKSdbM4FwZ+AhVEHJVMrebZbNxMenmlVYo8g96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860416; c=relaxed/simple;
	bh=asqL7ibMLSTlwZc919q6O9EDx1/1Agjsnl14UHpxars=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCI8XTxTKLG7YmUe6ER366CJsGO2zrYtAlg610IW4UFK5iKXHpT4gezSAd2rxpv4QVAlVt9kVJOHu422eTjqDsL2ZUKqr8nKGInGC+GZbifyh2Aew/DhMO8Y6ghxZhOljGptvnP1bK57hNJHCEKhpqhJkpIPjSBTqGPevOZna5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EruHLEHD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b18c6cc278so4163061b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762860414; x=1763465214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNJVWl6v7EtgwRx2K0rZQkvZtHa5N+QiuQIrEktR/tM=;
        b=EruHLEHD+U+knD8CJfyJOh/VMfL9kSHz4jugz5o9xGJv7C2zLVWVCY+Um28IZdNuX3
         xFshbdc09DHk6vrV6bFn333VjwzCmRUJlAXJfTyg+uDbCUWKVMxnwGJ/8Ioy8gX/D5dY
         5Cg2xhdEtm+cxQY7E3rmu/WolayJr6ocLROGv+7/np7FI609S8bM2azmnob2kT3xmzgk
         QfjAyaBa9fUb7cq9z3w//2z7PJer161v8/A4Ej8Km86tkM1ZAZzAopGZzGPAYu8CQZUX
         84T4PmTnURLrRPDR8rjhKzMWqW1BBGjfu/oq5UhkY+hg7c+cJbUY2olrq4FlmPLc35g1
         xjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762860414; x=1763465214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNJVWl6v7EtgwRx2K0rZQkvZtHa5N+QiuQIrEktR/tM=;
        b=ovFRwcR1aLnSniLtBqbzi0Np8F+9I5t2FYF71b7se9IiG68EWfuE82KvoTsgS38wEn
         ENQCad850BYRziNoZacKB8beHPn+IOW0kjhGQ5XaSD3PVBSbuObWcgLadzCKp0s44lF+
         5oe3sE/aO29gvdkgwa6T/ELpgx+bX0XOopVBDl1+Wj/h2X8Pw17k5akcp/GRdYPMM/rH
         l4iQzFgM2vpFDlcpeUWhPZ1KB0j/0nz8NI2LErs3lPspgJRN9ch20ersUN6NaDtmruHe
         +RUNdRurTY5RJFVvfJ6SinL6RJKsD1AerizWVMUWVreEkl+PkQr4hnvcNXhHEJmTBYsC
         zKsQ==
X-Gm-Message-State: AOJu0Yz7SdlhSll5rfL3Y6SxNxD/Dxv4D6DMbamhIcmmutwaT5Z6j+5a
	jcGvoRM55MB+sdYI684FYx0L8mjHvyHsbWXPxeJAdmSeK3A0neao/SWA
X-Gm-Gg: ASbGncuaOZQkjmr+OVn6+OrGDgXr5Cf/qrznNz4qnExcYq/GJnj6kd67MlKlKvxGgDc
	BlAVqX+cBXdDyVvg9TWNQPgJGYdW6/Bxim3/LvAM8eDIKijOcdjoV7XzZYssAGm9zExp9xTctPW
	05COdnrVYjKf3vhX8jC1ibELMD5j6BEbXEyahBKFb4okifD8VnrKIKIjsqmI+3vGwDXYozH2N2I
	3GpNzW6H6wTJmce03sbOzIu9reKivtHzpFoN4AhAZRFiPTdY3xAYp57zNPIFuLk/yFfUz+KLKP/
	bzR82Vd/akmmkQaO9XZySacq+0kRie8jlecguo9iFGpUS7xv7BK7FRI178MXSY6HMfmJUGx1LSn
	WaS+EWvQt6e5n4bfEpankZ8KSzg21+kbWzHsdcXS7dzSmjfqmbebhEzVfuLfCSj6s5SwlgB11/X
	a8XH7VSeRjeMbK4pw1mNt8fu477Fc=
X-Google-Smtp-Source: AGHT+IG5qSFsUMc7eb4gQr8vOsY3plSC92qZHpHLEGKz9efpkF38io2vCrh8tOC1JrY3TyFuOTQBkw==
X-Received: by 2002:a05:6a00:270e:b0:7b6:e303:a85c with SMTP id d2e1a72fcca58-7b6e303ac25mr921569b3a.14.1762860414437;
        Tue, 11 Nov 2025 03:26:54 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5c823sm14920677b3a.62.2025.11.11.03.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:26:54 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nstree: fix kernel-doc comments for internal functions
Date: Tue, 11 Nov 2025 11:25:33 +0000
Message-Id: <20251111112533.2254432-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  Warning: kernel/nstree.c:325 function parameter 'ns_tree' not described in '__ns_tree_adjoined_rcu'
  Warning: kernel/nstree.c:325 expecting prototype for ns_tree_adjoined_rcu(). Prototype was for __ns_tree_adjoined_rcu() instead
  Warning: kernel/nstree.c:353 expecting prototype for ns_tree_gen_id(). Prototype was for __ns_tree_gen_id() instead

The kernel-doc comments for `__ns_tree_adjoined_rcu()` and
`__ns_tree_gen_id()` had mismatched function names and a missing
parameter description. This patch updates the function names in the
kernel-doc headers and adds the missing `@ns_tree` parameter description
for `__ns_tree_adjoined_rcu()`.

Fixes: 885fc8ac0a4d ("nstree: make iterator generic")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511061542.0LO7xKs8-lkp@intel.com
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 kernel/nstree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index 4a8838683b6b..23af5cd04c86 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -313,9 +313,10 @@ struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
 }
 
 /**
- * ns_tree_adjoined_rcu - find the next/previous namespace in the same
+ * __ns_tree_adjoined_rcu - find the next/previous namespace in the same
  * tree
  * @ns: namespace to start from
+ * @ns_tree: namespace tree to search in
  * @previous: if true find the previous namespace, otherwise the next
  *
  * Find the next or previous namespace in the same tree as @ns. If
@@ -341,7 +342,7 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
 }
 
 /**
- * ns_tree_gen_id - generate a new namespace id
+ * __ns_tree_gen_id - generate a new namespace id
  * @ns: namespace to generate id for
  * @id: if non-zero, this is the initial namespace and this is a fixed id
  *
-- 
2.34.1


