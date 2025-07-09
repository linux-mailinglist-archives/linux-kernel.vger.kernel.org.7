Return-Path: <linux-kernel+bounces-723795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A5AFEB0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF156563F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9C22EA749;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+tgUInd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775B2E6136;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=OcygWRLbWXpRfV1AAbKOPCVkgFDBbAWH16BAXzt180eWlcuQ2DQmjDmIJsGtkbWgMYiqFc/Zv4kfVlDlxD1xAZqKHUiP0EVV1lomI9d3xinD4k+LELAjA1UOQ+YcS6ZVdNIB86m3XSqyt6T5mhJiEIfqRstSkPiNyakWB5wfcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=N7BK29GwfAOZ3YwW51dAhPYfYECxSH+jGCCV1ivhuZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMF/yh/jG0oxYc22Y4aIscZLqdtjvIPSRO7vWNk3Q9GPBbrGKZ/O30PLrWaur1UWepZc0hutVPaY94LoOX0pQQTweY5srnr+qlr7BtxmyXqT0sk728Uuvuz8dB6RuOZgFzAhZdRu9F4YBcn4cecexEjsg0On4NnoqSqDxQrJdEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+tgUInd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3457C113D0;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=N7BK29GwfAOZ3YwW51dAhPYfYECxSH+jGCCV1ivhuZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+tgUInddmqT6/Nzaoal965lcYUEqITGSERg1bjN6Feoy2hbRvGpS6rNLdvAexkqr
	 pJCNSj91+HpWfaIB7nzjiYgK4zUiOuYBpVXcOqsWrHulmWXbEYqh68WfyA/L94Eqjv
	 /0dnG2f4E2bxUEeQkcAwGzgNYG7rD8QThWIzyNS9O+AfOeA4EAHjbu4aX+pf0IN/0f
	 TsZ0FMK4cO3wguOcaAtc3z7x44tzobR6IZVcj8GcVInfUj1B7FYRkKNRIlVI9cBwet
	 ZDqlr0rq2Dmw5Fwsy9nKedY1Sfg3vyzGlxIZ8+Z6LVkVK8xPENDqfekHtaZNyn3f87
	 0uKzecDuut8gA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECX-1O7f;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/39] scripts: sphinx-pre-install: fix opensuse Leap hint for PyYAML
Date: Wed,  9 Jul 2025 15:51:41 +0200
Message-ID: <3ac82fcdf6ea61267615bf85058913ebcdc49238.1752067814.git.mchehab+huawei@kernel.org>
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
2.49.0


