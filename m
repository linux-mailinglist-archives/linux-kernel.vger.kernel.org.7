Return-Path: <linux-kernel+bounces-826431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB74B8E82B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93868189CDB7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333DD253359;
	Sun, 21 Sep 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IddOChXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888961805E;
	Sun, 21 Sep 2025 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492459; cv=none; b=X7+xJ9bRCvL+NXCo3TmrUblRGDhVQDX9PvEcpkvt2alejxfq0ic0sSTChV34I2okCGl+0imCSnJD6+Zv/nsB3aDPdwXni9J0lwoHP0K3EgLSUN7EngjpZQOJgQcNkoxgWp1ONSD9l+QIOD+pydnXUj3UET8H8Pj+lEmEHv6l4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492459; c=relaxed/simple;
	bh=z1mNSQz3UrZbcale6Wt3b20gF0+3YdPSmgihFq1+T40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rio61sDgW8ZhrQqUInu/2triYapU3H+OZ0DdsDB/VVZYMQCI6IbYsmDIZbQ/47cQx8zEU1663XEPWrpQOcarM/I044PxUvnMLIHj0VOCXyhrXRjOKXiTZNax0FGmTno72quyT7YWAcJGmuWAthGBlkzsM9DJPFJKMXMgCorhMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IddOChXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB07C4CEE7;
	Sun, 21 Sep 2025 22:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758492459;
	bh=z1mNSQz3UrZbcale6Wt3b20gF0+3YdPSmgihFq1+T40=;
	h=From:To:Cc:Subject:Date:From;
	b=IddOChXOeDhxmCC6HPs7Fq+Tw0c3iEv77SRhjfJew3ZPn2pFPlzCaTw49Q9n5F39+
	 Qmpywn4bkxo8xxFLBf1FzQEU3qILUyf9z+g/AMcsWzV/t2haszTIob1e1v/NH72r4i
	 RXnK955t3UCJVEA+nQEhtzQwsnUUZ1R8AV82suW9aQIBw2yMQMJsedlY+3DbiQmCD7
	 tqLdApZd7Vz1i33Rxek6HlGRRSG1kgk/mhQysScuIiGMHyv9nn/sWFBqtpBbxyrF8f
	 KjrxDWq/3qVXV3SekJQ2R2DqFWXAvCDsAUnoXW9xYrlcA1xmuO0yVWM4rGgU8to50X
	 Q6Px9pss+2zFA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0SDZ-00000005bCS-19Ax;
	Mon, 22 Sep 2025 00:07:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Makefile: fix rustdoc detection
Date: Mon, 22 Sep 2025 00:07:28 +0200
Message-ID: <8db0faccc31c283a3ed9353e71ad396af17dd123.1758492447.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

During cleanups, the logic checking if .config exists were dropped,
but removing it causes false-positives. So, re-add it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cc4ee55c75ed..c60db1038c9c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -42,8 +42,10 @@ FONTS_CONF_DENY_VF ?= $(HOME)/deny-vf
 # User-friendly check for sphinx-build
 HAVE_SPHINX := $(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
+ifneq ($(wildcard $(srctree)/.config),)
 ifeq ($(CONFIG_RUST),y)
-	RUSTDOC="--rustdoc"
+	RUSTDOC=--rustdoc
+endif
 endif
 
 ifeq ($(HAVE_SPHINX),0)
-- 
2.51.0


