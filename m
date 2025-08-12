Return-Path: <linux-kernel+bounces-765180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECDDB22C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99B91893722
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8FC2FD1C3;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0VUbw3w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129E2F83A0;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=WBK8Y+ya/Kxb/ZwqPJPFTmZtpTOAUev4m2kVJe5Gjv8pHbjBl90k48H2EJxPgFiIwmKC/lvYL/Wa2fs+FlzvihVBLvtxr4sGi7fzVNqq4F1qkoZOhJc4GyTnYdP6ms3LeIJT4kP1WVYGC8Dd5O3lrJKj5JcfQTjQAAHHesTJyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=H6jfXH3dWyR+l6WUYs4k/BA5+/vFZ9seox7HuHh0dvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXDo4K3c3bObM2uFnKycfVE3Fbl60gAD3kdiX0J2D7cbvApg3kr3a3kC+hzyJKLx9xzUXxHVs0CDeYZKq/0dCmQgjb3OY7midf4Z1INg/5x4HscYXsel1mLJj+Tc0wymv1aI+v6arWC1CihVVS2FGl1A5AGtCKgjDqiWaG82+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0VUbw3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4591C4AF10;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=H6jfXH3dWyR+l6WUYs4k/BA5+/vFZ9seox7HuHh0dvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0VUbw3wjjIW8Fd8gxZnblWtcviSvwcEtGti25m65ZNUVKInlJu//78y6I4yHM9ch
	 dxI259yaUygrP2+mEkZyBhO0dP5JfW9EJ2Bb3tBZOekm5irBqYdfUgA93Hfp518//1
	 XbACVFs3LIGF5PrUJnv5IPlQKtTN+2laPI2WDf0x36LLtI5xjbOtvPgtpb2MhrtHNh
	 mQpyUDX3l47d2snxup+AzPOvdVHWjL2zUPTPvGBC8QLzZStw1zToI4jt1cR2uIOZkg
	 6FnqJcu7l6V0Ql7Y9w6wzr0iDv0AsjprdVjojDJS9pFXt9EBD58So8AdgE0jcS9ho8
	 HXwF+nwbcXjbw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVm-1KNc;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/39] scripts: sphinx-pre-install: fix opensuse Leap hint for PyYAML
Date: Tue, 12 Aug 2025 17:52:26 +0200
Message-ID: <0266c5e28e136c62de33d2d7f7d5e69b273e0d01.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Leap, the name of the package is python311-PyYAML.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index eca42d90ed01..65438c198674 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -569,7 +569,7 @@ class SphinxDependencyChecker:
                 progs.update({
                     "python-sphinx": "python311-Sphinx",
                     "virtualenv":    "python311-virtualenv",
-                    "yaml":          "python311-pyyaml",
+                    "yaml":          "python311-PyYAML",
                 })
 
         # FIXME: add support for installing CJK fonts
-- 
2.50.1


