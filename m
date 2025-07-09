Return-Path: <linux-kernel+bounces-723790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63BAFEB1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BCE5617A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE002EA753;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3k8Mo7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10272E6121;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=T4KSs/EcVRHRhZSSM/VOLU3KpD+7I/2LjEcgrODNhKwFuCOKoiU5xLDvouEShtqTiB3MVjAUmuAmBcM6l8q+BlJeaVSSfc+0G71P8GA3xkP/CJQciA/ewQkI0JIvZ3mONtsSwnE63Dz33V8Qc23Ain3RM7HJtrUIMUtbOdLjm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=YayXrWU4dgHM/g5FisQRZpECv8bW1QpCFl2U0h/pm6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlJJsHcErZxzcxhEccXzoX67DbY2pBLHlxD2180OnmAa5lOJ1AD/wu0wpk+asa1hZ7WVaNyXNMXFslmEiVX/v2P/yLhjhrkzMyR0t5kDeZxEtBk5U0CFHjzFS5xecJE7NLWOOs0xsxJW1wtPtsTzUTkwmuvVHMOMVgn0cwSrYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3k8Mo7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95091C4AF11;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=YayXrWU4dgHM/g5FisQRZpECv8bW1QpCFl2U0h/pm6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3k8Mo7kqN27YxdZ/tuY0H9VSU+iH36Q/VlT2ibgoj2lzwQxLBctI8xVtuWrzzxx9
	 i4bY3Q49Z72Z1kz2cnWX+newzgaXC2s1BznMOxCY/gT9TIwdB+r7gjlue8Iasvvh12
	 yN53ivuy4Gw5lolGJj1Sv2GEH1AnxS38gLmFQeEcPlTZ/S/WarLrI6mtjaWkg+sBBs
	 VENKzbbqB2X3CuqCQIByjrwCkvc98FydCys2AySaBRez9jZ4G/iJrU/ifeCAA615r7
	 WECLDIKP1eusMat/TzzmCfqUuJ30vJnzfKGMrbVq6gv/DMVB0Y5iG+TIUEl3ay7H3E
	 RNRibi23D2F1g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECy-29Bh;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/39] scripts: sphinx-pre-install: remove Scientific Linux
Date: Wed,  9 Jul 2025 15:51:50 +0200
Message-ID: <d82d596e3b4454d603fd5c178e303b786a24b348.1752067814.git.mchehab+huawei@kernel.org>
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

According with its website: https://scientificlinux.org/

Scientific Linux reached end of life in June 30, 2024.
Also, it was based on RHEL 7, which is not compatible with
our build system anymore.

So, drop support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 1f64909953b9..cd9c83b17971 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -769,7 +769,6 @@ class SphinxDependencyChecker:
             re.compile("openEuler"):                  self.give_redhat_hints,
             re.compile("Oracle Linux Server"):        self.give_redhat_hints,
             re.compile("Rocky Linux"):                self.give_redhat_hints,
-            re.compile("Scientific Linux"):           self.give_redhat_hints,
             re.compile("Springdale Open Enterprise"): self.give_redhat_hints,
 
             re.compile("Ubuntu"):                     self.give_debian_hints,
-- 
2.49.0


