Return-Path: <linux-kernel+bounces-723792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BDAFEB16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BBD545B81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814D22EA74B;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgzYVTa+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41412E6124;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=aCpTto3pzA/IAOo8vMoAnBQbHplwMHPp2bSoRMInJq2AT6lrADM3dx0jN+arDdgcG5133MQXaXiC0gwePJCdwhPBOEeOpJMEJbN2UPngoquO82dL6663GafPDLgF5aSCCF3lEJDrfC4g4fV/+jEQxTIh/AX4yFkhdaIY2xYkKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=aokS0IkdFRhl4/IFo4+l7/CezIwWib7/d8o4nBBDwqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9jW0g8s6wLje01jDIBQsT9QU0ps20JtJFviFuUyheYfVNBbgMAETLN7RgOw8bPwzoPCcPF6+J+/dDSZ79bzobL8RhOBQP+m3XcPhplFEkk361z666dRO74s8MVK28yMGxvEURjAdrl1o2mD/bguaXbm2KTGoSK0+IBbgu9M7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgzYVTa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9153CC19423;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=aokS0IkdFRhl4/IFo4+l7/CezIwWib7/d8o4nBBDwqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgzYVTa+SZRJcCm9p/UD8nA+WfbEfm4AmyIJ+zKLTQoZXMD4/krtekYPTkjK4jBGl
	 Q1oWklJvjz5vn4P1rHzJD75k5w5HwGnKtxz8ZYxiXJCtAebgS8FYBEcNxyYo1I/izE
	 bR/FMCkWYj7xvOo3yHJ/tYVXIkxqrxSWZfo34XWtqdH/4qkcdu/iuwamBCQnkhtJ8H
	 nJT6UQL8VmKvrIyo7iyYgaWg0SG9wOdWPnJYTJe4RRwGtgyTt+/ExAwisPDsob6rpm
	 pW6u/rkbbsTvNSor1NT3XgfFIZ4JAovREhGh44Y91uvK57JjYNv9HdcbbGrZ1xAxqo
	 0KHWj0rVj9bNQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDm-3WaE;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 34/39] scripts: sphinx-pre-install: update mandatory system deps
Date: Wed,  9 Jul 2025 15:52:06 +0200
Message-ID: <301781a3839c500ea0dfebc7eb2d528d54755fd4.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

To build docs, gcc is not needed. Also, Kernel can be built
nowadays with clang. So, drop it.

On the other hand, which is needed. Add a system dependency
for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 7dfe5c2a6cc2..fc9dc45054d7 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -1476,7 +1476,7 @@ class SphinxDependencyChecker(MissingCheckers):
         self.check_perl_module("Pod::Usage", DepManager.SYSTEM_MANDATORY)
 
         self.check_program("make", DepManager.SYSTEM_MANDATORY)
-        self.check_program("gcc", DepManager.SYSTEM_MANDATORY)
+        self.check_program("which", DepManager.SYSTEM_MANDATORY)
 
         self.check_program("dot", DepManager.SYSTEM_OPTIONAL)
         self.check_program("convert", DepManager.SYSTEM_OPTIONAL)
-- 
2.49.0


