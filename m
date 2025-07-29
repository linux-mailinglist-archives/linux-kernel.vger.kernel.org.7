Return-Path: <linux-kernel+bounces-749682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D23EB15192
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CF23BAB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646D2989A5;
	Tue, 29 Jul 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2z2aTR0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EA295DBD;
	Tue, 29 Jul 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807445; cv=none; b=qYYI5Yo0mVEHUI4xHXg8+bQMfrTZqOTFsv6B+Ggv2zKB+ZDKln9+NpfbfowRAmrrm6R474ZdHDpQOlnx13gNtg5xTPzA1Df2cVxZXFtL+YVm8Km/a9+UkHh2Vr+CGoCO0htUxrQqUOlzBcpD7ddXUEeRxMRmx0ZR24BGJN8geZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807445; c=relaxed/simple;
	bh=lOU+N6iFtUxmqWL6eqLxeLa6+vrLLwnK+Ndej65rQCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDJnOAJ23N0p14UUayMTfSXv5A0M41vSveAQtrFvG+tJXZrjhbElFjipMXoc1Ph1puIPqmuExEuAqjMS6nq0I7Ph8t98YTkMuTuvlOJNalMwHyhpTh3zexTGk40q2+pWKNLvcc9gKQmlDGQbEHI+GXPvQUNMA+LUHkw74hzUsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2z2aTR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9469C4CEF5;
	Tue, 29 Jul 2025 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753807445;
	bh=lOU+N6iFtUxmqWL6eqLxeLa6+vrLLwnK+Ndej65rQCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2z2aTR0ykKrDlA70tWXjh22sefKXYcctAXlQbLqXv+QhgVyANlVEEb69tPCNJjaE
	 jG+q7zpAT+3Gr2HdQE7YAHOzDfW7VPMD/4NzKMm/D9f+n3LjRbHZp0EgZkho7g9KeZ
	 Qm7/soE9Mptjt18kwAx/jdPZ90gRkQhldAybOPMYI0yjOtKaEKO8yf69HD4nr//q+e
	 ABEyMZ+qyyYutK6j3oMX2tH1gT0/XIcWdZx4y6KuUVc8iPk7q3wML4L/iaq/qCEcgD
	 bePU0mD8htFGw4ieiXXLviEB/o+IJXxy77w1tSdIARlYEN+tLgvtPlR/EP2K92rARp
	 uqJNq+iuOUpeg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugnQo-00000000Liz-1dmP;
	Tue, 29 Jul 2025 18:44:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH v2 2/2] docs: changes: better document Python needs
Date: Tue, 29 Jul 2025 18:43:04 +0200
Message-ID: <b03b95b8d09358e81e4f27942839191f49b0ba80.1753806485.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753806485.git.mchehab+huawei@kernel.org>
References: <cover.1753806485.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Python is listed as an optional dependency, but this is not
true, as:

1) arm (multi_v7_defconfig and other defconfigs) and arm64 defconfig
   needs it due to DRM_MSM dependencies;

2) CONFIG_LTO_CLANG runs a python script at scripts/Makefile.vmlinux_o;

3) kernel-doc is called during compilation when some DRM options
   like CONFIG_DRM_I915_WERROR are enabled;

4) allyesconfig/allmodconfig will enable CONFIG_* dependencies
   that needs it;

5) besides DRM, other subsystems seem to have logic calling *.py
   scripts.

So, better document that and change the dependency from optional
to mandatory to reflect the current needs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/changes.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index bccfa19b45df..4c9088e429c8 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -61,7 +61,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
 GNU tar                1.28             tar --version
 gtags (optional)       6.6.5            gtags --version
 mkimage (optional)     2017.01          mkimage --version
-Python (optional)      3.9.x            python3 --version
+Python                 3.9.x            python3 --version
 GNU AWK (optional)     5.1.0            gawk --version
 ====================== ===============  ========================================
 
@@ -154,6 +154,13 @@ Perl
 You will need perl 5 and the following modules: ``Getopt::Long``,
 ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
 
+Python
+------
+
+Several config options require it: it is required for arm/arm64
+default configs, CONFIG_LTO_CLANG, some DRM optional configs,
+the kernel-doc tool, and docs build (Sphinx), among others.
+
 BC
 --
 
-- 
2.49.0


