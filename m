Return-Path: <linux-kernel+bounces-728571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D3DB02A21
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633F8A438D2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E3826B975;
	Sat, 12 Jul 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLrBtGJW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD772FB2;
	Sat, 12 Jul 2025 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752309218; cv=none; b=d3Zoto/Nz5Pr/VlBE/g9ehSiHxNfT772qPHMAnJGPiwMJKfcI7pGGSFNVrVsgaR62d3X8jXdfrcVFcUtbRDEfihS9i1ITuvLp6WPStAlCgodOlEYBhRMeZ6tc//iJ+87KzYe6+rhmo5+YJ4yIrbPkkVNXxaLqdSAuuZoV3ow4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752309218; c=relaxed/simple;
	bh=6VWw+bBtOU9U2/e33hN+xWFLVR6yatLAPxZzl7SbJNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVM7y7we2Qs/twPdAd/fH5CJwUVANzS8FIu8HbjyoRTrrIKDEhhi9/lb5YOgBB6Fz+9LmK4JWUsPpiwYYCZ4CVK6FIDOKydV1tH/MH9uIVI3l11PgfofB1jj2YXzqrY2/t7aYX9khuiH9UGvlBa9qjwQe6aejlnTvQLoOlgSCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLrBtGJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681C1C4CEEF;
	Sat, 12 Jul 2025 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752309217;
	bh=6VWw+bBtOU9U2/e33hN+xWFLVR6yatLAPxZzl7SbJNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLrBtGJWr8t8EuUuF1KitSwtsdhjcVkm7yA3/9/v0SPnsfWTGsgArG0c37KqNC5FZ
	 Z37V4hCTuE2wtvT5T+1lKkmEWide4h7GDLgNjmYmZGscJgAPABaYhvWKq8fs8dGG68
	 hCNpNVmeFhYdndohsRc8K1MDbvyXuxyd4JuN6z+QWhxVTH1EI9cKdCTeBPzViN+dy1
	 Wf7EhAxuECXW4VY00z2WWJtOB4yLLOH86VsdFfZZGEE2Kxjh72zulx41D1Ey5THtmp
	 NRAuSk5U6nVqcUZ6FcbAX4k9NePoy4l0WMLB8nUrypDr0OqhZzWYcmYJ9EVs/Jbh0g
	 y9zTO6eQRTGTQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uaVfr-0000000GsSz-1qLn;
	Sat, 12 Jul 2025 10:33:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 3/2] docs: changes: better document Python needs
Date: Sat, 12 Jul 2025 10:32:38 +0200
Message-ID: <58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752307866.git.mchehab+huawei@kernel.org>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Python is listed as an optional dependency, but this is not
true, as kernel-doc is called during compilation when DRM is
enabled. Better document that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/changes.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index bccfa19b45df..6a7d7c1ee274 100644
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
+At least Python 2.7 or 3.4 is required if CONFIG_DRM is selected to avoid
+breaking compilation. Documentation build and kernel-doc won't produce
+valid results if version is below 3.7.
+
 BC
 --
 
-- 
2.50.0



