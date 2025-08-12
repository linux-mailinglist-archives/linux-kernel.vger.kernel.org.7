Return-Path: <linux-kernel+bounces-765167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D57B22C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54061AA1C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C262F6593;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp+oupgx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75C2F659D;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=QSL5BDxBG3O10S0uQsy/D/6sz4YCF+RQ+8eIAMgjkAdUJlCFZ8Vk9JsB06fwLzg3DPrkNdNQTbdPvPQ7SiU920YM9YfiXcRFg0jj/cRCgkeVhFD0G7kIeZy1Ll6V/46XAI749slthUpZTASlQPyBfr5ZvLYwUkGIJFjFE6jaShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=lubWYVOEybDAGm9ORXVmoDyKTrHZrfWsx56TwRP66U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzRz9wc9NuqBQ9JSDjXjmwI+zYKF8eySsSc9RG7bToo8eFNIv8bDtt/eXEIuMDLR7NAPOfLIBjpjECXZQBGXY8Z4i1gHCNVdpieAmjtABstGlYlVaYgiUDv00q/QM+eYzw8BZxCGOTmpFYYOX053cI+vccFFnm5Y97C38qMTgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp+oupgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01B7C4AF09;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=lubWYVOEybDAGm9ORXVmoDyKTrHZrfWsx56TwRP66U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vp+oupgxm8UgYRAOwSaWBmmuBgju8QMbUrbGh96KGrFtA+Ix5HUKEjKbvJAtQ2Psz
	 36uRSQl5IyrFp/ypwcssSA0dmHRb5GkehDS+t3rp/7wijzIXxhvUtko8D1e3mARZ/h
	 5IpXvs7ZD3QbES0lWpIeKNyxsQ7xLVTpcPiOujVG3Mc0tG2iabXod/lgmKC12s/gIP
	 7Ez/CrD4yz7TM2UNqLx605vP52FJkCn/BqObmjohrwZZ1vF1PTaMskeiKknzVidlOt
	 y7GcfI3e6ikr5wx79GYmh0XtxgjINEgMJrVlTez90xPx/Vt/rCL+Tkh6EVbaSYA5x8
	 V17dFnt64OQ1A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWM-2Se0;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/39] scripts: sphinx-pre-install: remove Scientific Linux
Date: Tue, 12 Aug 2025 17:52:35 +0200
Message-ID: <dde5e0c95017022840f8a522ce44759e51f52aa1.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


