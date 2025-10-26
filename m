Return-Path: <linux-kernel+bounces-870342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB30C0A80B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB72818A191B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892322E6CA6;
	Sun, 26 Oct 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="BsvtbpIR"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDB2D97A1;
	Sun, 26 Oct 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482555; cv=none; b=OaTv8WjQDcYHn/+pRUVPH6mB0ics6LUtYtLOP5hLo8YAdbpTVlBW5QjFkhpy7PfFGAY1KgVmF5vjpnEoF7b4Ru/i6AB+2p611gEz0/f6K7lTF5rArytXR1kCpAoIAVyn4p7dO2EiOpDQeYPx+cblR78Fd9yNVopBvOs8j7Ho1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482555; c=relaxed/simple;
	bh=v3EcZfTQH9yUaeLOyiACtSLQBw4OfVXYTDSPYRHxRtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUiTxN6uqQSNjEl+H/EonXI7pqEkbzlXudI191M9WCA2ZN8FkDT+GdCQUwqDYgW6Ctg3BeuX7CItlRAECryuPiziySO5awsXX3ci1QrxHjTR4Zpdda+QGwvyTsp8+PNpPJJtRfE/1NEVtoFwMhykagMTJ5Rad8qccVkeW1PDMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=BsvtbpIR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=1lpe93ywVbepQX5TMSIxLuqlkD6WIX6nms0KuNBW1jE=; t=1761482552;
	x=1761914552; b=BsvtbpIRcESSr/nD5yaH/WqU2nrd57K96YrH+cPYJb0Ub2a1Elau5SyfxZPDl
	QpHqw8Bl0100Cqzl4X0IKXklDQsd/pLvnQrzF83GQktFycsvbeL5K3WLQ8T2Fbkf/OWEDYVKzd9ny
	PVKG5DNOunRQIssu2C7AIgAo9G763Aej+L7c++WSdtJ0EWqAwvzr1Ok+TCyI4MZlpXYvNlNhMpUeS
	U9RusVAjfofcsehyIhSwhfPFHZMhzrqE6/SVfKAj09OV0roJQ3sIhqlXx+oZbIJ6PthmNIzfkobjM
	4zEi4DwVCh/zzaFv3da10+InGamUVFfZKpgr1MOs3IfwziCSRg==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04n-001mXP-1b;
	Sun, 26 Oct 2025 13:42:25 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/30] docs: reporting-issues: tell users to check the kernel log
Date: Sun, 26 Oct 2025 13:42:00 +0100
Message-ID: <a5be8e9822bbc1268efc3cad9485d8d926261a90.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482552;81a32109;
X-HE-SMSGID: 1vD04n-001mXP-1b

Sometimes what looks like a kernel bug is actually some local problem
the kernel's log messages explain, thus it is best if users check it
early in the process.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 73b7792d84cdf1..63ce6ae51df266 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -77,6 +77,14 @@ following the others is usually in your own interest.
 
  [:ref:`details <multiple_repiref>`]
 
+.. _checklog_repisbs:
+
+* Skim ``journalctl -k`` (alternatively: ``dmesg``) for failures and warnings,
+  as maybe there is just something wrong with your setup.
+
+ [:ref:`details <checklog_repiref>`]
+
+
  * Perform a rough search for existing reports with your favorite internet
    search engine; additionally, check the archives of the `Linux Kernel Mailing
    List (LKML) <https://lore.kernel.org/lkml/>`_. If you find matching reports,
@@ -368,6 +376,27 @@ entangled or clearly have the same cause.
 [:ref:`back to step-by-step guide <multiple_repisbs>`]
 
 
+.. _checklog_repiref:
+
+Evaluate the logs
+-----------------
+
+  *Skim 'journalctl -k' (alternatively: 'dmesg') for failures and warnings, as
+  maybe there is just something wrong with your setup.* [:ref:`... <checklog_repisbs>`]
+
+Sometimes a bug you face is just a symptom of something going sideways that the
+kernel detected and logged -- like a missing firmware file, for example. To rule
+such things out, check the kernel's log messages.
+
+Preferably use 'journalctl' if your distribution supports it, as in contrast to
+'dmesg' it always contains all messages since the kernel started.
+
+Especially look out for messages in bold, yellow, or red, as both tools use such
+to set warnings and errors apart.
+
+[:ref:`back to step-by-step guide <checklog_repisbs>`]
+
+
 Search for existing reports, first run
 --------------------------------------
 
-- 
2.51.0


