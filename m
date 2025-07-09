Return-Path: <linux-kernel+bounces-723798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E47AFEB0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F265643AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110982EAB77;
	Wed,  9 Jul 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCbGNnc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C42E62B0;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=s6y+wTcvbIMXZtu8EPCUYZ5PytlMHUDKBJJwFOSCa3U+tHUAi+AL06DVmgImc4MUmSDTHlGytySWKtYl1x6jThHZtcjpB6LMWWJPrZiAUIdyKkxapqnm75Xw1cu19ZswjgfbsUOR23/Ozmx2F7lSuBk7tOyADSIjSL2tV6+5qaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=nMmas0XFZGSWcl0WU6+OSdCq5sNHfGhO+wgD68EYMNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qlnwf0IdDoymAn7qzejRtzwDrb0ShRR5rxQCOV8O4cOpDPaAj0l4MtCutYJJDXVcvT4a6MYe5VxDUjx7v2BzAvV5+vsBV+o9KaA0W+iH49X4i4p01chpVRyd72ozmUD9YWKqB7syhxM6p3OadMwpJlohMtKdGRGYN6P73Sztw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCbGNnc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1921C4CEF4;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=nMmas0XFZGSWcl0WU6+OSdCq5sNHfGhO+wgD68EYMNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCbGNnc4eHBiS4icjvDcah+C+/9cgh3OtNzY7hidLuBellcf1x8gqx1ZGuos0xI0B
	 tSxmu6lUCtZbH0SHQSDjUmA8LKNqQc0ifZ/9JIK/nr8AeqiPwc19lmGh2eBdELW/cr
	 LvpAMrPoz1b21/3G9vMqZE8QxttgGKbLr8tuCd3072PM/gkDzy46QUzIRXh4SyCxf5
	 7W+D717Eg5be3vb47W7ZfWAgyZDc+1c04MeNVh6ZerTh7vQtyLdy8jFHvvK0fdtHnf
	 GtOXpAzCV+xkowyN/Guy6ZmeGbe6PsbIUFEs89PlKuPVxqcnDjvL8u4wJ1Wp7SIfTC
	 yTxRh14VoRAew==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECv-23tV;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/39] scripts: sphinx-pre-install: fix rhel recomendations
Date: Wed,  9 Jul 2025 15:51:49 +0200
Message-ID: <0329c315b356c1b258dabdc889c1c88b716dcbad.1752067814.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 6b5f9eda91bb..1f64909953b9 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -519,9 +519,9 @@ class SphinxDependencyChecker:
                       "For most, enabling epel and crb are enough:\n" \
                       "\tsudo dnf install -y epel-release", \
                       "\tsudo dnf config-manager --set-enabled crb\n" \
-                      "Yet, some may have other required repositories. Those commands could be useful:" \
-                      "\tsudo dnf repolist all" \
-                      "\tsudo repoquery --available --info <pkgs>",
+                      "Yet, some may have other required repositories. Those commands could be useful:\n" \
+                      "\tsudo dnf repolist all\n" \
+                      "\tsudo dnf repoquery --available --info <pkgs>\n",
                       "\tsudo dnf config-manager --set-enabled '*' # enable all - probably not what you want")
 
                 self.first_hint = False
-- 
2.49.0


