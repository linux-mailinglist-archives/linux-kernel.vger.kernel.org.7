Return-Path: <linux-kernel+bounces-723769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2AAFEAF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A14163B84
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8452E6D1E;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvML0MAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6CBE4A;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=ZWisCdQRuWFyS3q9QktFDXD0Mf96DNBHyOArQixWkA8++zHMSeuWqYP4YwXcLI1bCQ7mOCruMibDyHWu+cZ7ftKNIwpWOZaFlrFbZjqKic1GhhfsqClSLLtETyhcHguJ/65G5oKIrVxfHWAu6YZYXHQYiZGol0ULbJgyKN5XnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=WqD40lDNIRl5QDZ4vfq2ncB8gramfpJAfziS8iPSj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAluByWElTMGk3nE/FJFOdeflM8JxjiqGlcM4252opTXlMfLiRC0Nf2tu0S9bI30Ob9502eezv/nEUbOVSUvy984aqb1PPoK+sOD8fp4o99o5E9vkpBKPwNSwy4AsjLNGbe9mANo23lgdJiVaY4Pmdt9/lIgKuW8Xwc9mjPJ6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvML0MAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8F1C4CEF4;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=WqD40lDNIRl5QDZ4vfq2ncB8gramfpJAfziS8iPSj9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvML0MAKQMQsmQ/lCkHC5ni6MoG4nXfgOmhj21/0NtfRApx5oZIEf55SJGcDuzqgE
	 Rp9ejqibUi6sBoSlMktpfsVqZpTaTG0DGZPMU1lu4mnmGpMKaNOIwTKIkiF9x/gzOK
	 wvshkijZfNYmtWxkriqXXyV7bmwtvOF6Y77w8qLBXrAvT6AkyUYV00bGpVkIXZRSkn
	 IotDzDcrfZnJ1av4vrMBNOJ+j/OAYSNCmvEtXrw7XBCJRdnWeeA2HAkBqfx4DkK5dS
	 xYbFNBGTc6/Lm0K9T4Z3meGIHrEHHmYBw8Fx4WpqhYHRlSeFXW2T3LzjcIWzvhrT8N
	 B6+HEqwOqBsZA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECd-1ZKE;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/39] scripts: sphinx-pre-install: Address issues with OpenSUSE Tumbleweed
Date: Wed,  9 Jul 2025 15:51:43 +0200
Message-ID: <cdff2a07f61201a061e882a4cf92944e11fb1f25.1752067814.git.mchehab+huawei@kernel.org>
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

On Tumbleweed, package names are named after python-313*, as it also
has older python versions on it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index b793796329c8..0e165ad05fdb 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -571,6 +571,14 @@ class SphinxDependencyChecker:
                     "virtualenv":    "python311-virtualenv",
                     "yaml":          "python311-PyYAML",
                 })
+        else:
+            # Tumbleweed defaults to Python 3.11
+
+            progs.update({
+                "python-sphinx": "python313-Sphinx",
+                "virtualenv":    "python313-virtualenv",
+                "yaml":          "python313-PyYAML",
+            })
 
         # FIXME: add support for installing CJK fonts
         #
-- 
2.49.0


