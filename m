Return-Path: <linux-kernel+bounces-723793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7D0AFEB07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C84563FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64E2EA17E;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT7LQyYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248D2E6131;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=YRiX0YMfn5QMuXogT0uvVZjq6ZPqeYpt9yP1HCwS6EJ6iigpWfCtO2FikKp3XS+bI/RiMKarGgZx455x7NkY2to3aUDYI56MyQv31OGe7n7mOx2aIihPCG2Cs+2LTW6R30qGTyMaZ1vHG0aT8RhJnB8MelMZjJCzZN7qZUBRm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=g9ChELiDAoUSi7gu90s1ywGkvYH8DY5gFmnDVs5kcKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh9yBqENX5wDg/LL119ngLlFa5IllOA35mC3tjxtitUdWXBMiN54GvFJXuQqaMaxtAi4wLKq3eTdWiKmCnIkmUNpjPKt5XM+0RbuPKG1KWbxo9gFbLXTCyPn3Dk+CN8KTDyFRtz0dnjcob3Dk1tkKsLvfqYyj4x5hE7Nfi3di5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT7LQyYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E7BC113CF;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=g9ChELiDAoUSi7gu90s1ywGkvYH8DY5gFmnDVs5kcKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fT7LQyYEnPz/6q4knFoSkUzv60kkEAU1K8mBYsHp1jBJCyWje8PEsR3mrq5XW9Eji
	 NWcTxt4CvXs6WDnMuRbLaY1IxfpqWB/EvZtABM/ihJznMdvg42iTBFdCqdvKx3+c2K
	 Gi3bAtfofj4f8jrgKDWLD1ptK/Lp5R5QgYzU6y/jdPXfRdUn1VJ8vs6OR4NyXijVpG
	 +SnNeNB6CI9XslNOwBWrrfCILtOqaDCobmQykWlzlqhFydEL+41N9jjaQB6Wj3wA1e
	 d+HtTfzz0+TI64kDn4O4rz0p8o8UqscsYvWCO/lkAD42DnJnSLUrP2T5LdFyig1F3N
	 IVjXysDzM2Sow==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDA-2Thx;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/39] scripts: sphinx-pre-install: adjust a warning message
Date: Wed,  9 Jul 2025 15:51:54 +0200
Message-ID: <38e2b4db70c105f24500507b07ec9ad515924538.1752067814.git.mchehab+huawei@kernel.org>
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

There is one extra space at the first line. Also, as now we only
support Python 3.4+, update the text.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 2360ca2ed21c..365590f81551 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -1081,8 +1081,8 @@ class SphinxDependencyChecker:
             self.recommend_package()
 
         print("\n" \
-              "    Please note that Sphinx >= 3.0 will currently produce false-positive\n" \
-              "   warning when the same name is used for more than one type (functions,\n" \
+              "   Please note that Sphinx currentlys produce false-positive\n" \
+              "   warnings when the same name is used for more than one type (functions,\n" \
               "   structs, enums,...). This is known Sphinx bug. For more details, see:\n" \
               "\thttps://github.com/sphinx-doc/sphinx/pull/8313")
 
-- 
2.49.0


