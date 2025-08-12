Return-Path: <linux-kernel+bounces-765178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AEAB22C90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240CF1AA26F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C42FD1C6;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2GZoDuR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711853093B7;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=NERRwJPjC4CIn7rwvhGXOi9FdNu4r8T/0aWB6MTLvNd/TGyb/Yf85g8jExwUa6cYUnWd3aq+nuK6j5zv9WL1PSq6Xx5xm67ubPrdZOCCo9ZvT8P5Qrwv7EOABSM55T2W6GOa9boR7/uO38+P2N7YxUqso6EHPbbvj3myuVc4uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=RQNr/KzcW0oNe7IfHfuHatT3uQ+/hZf9xD7Hq5Cp2QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P54t0O9Mv0DaWeyXaRIPxeiOvPmxmQEfE0mIcHzzP/xKUFnDYrgtHT8VDPbYTtjiklC5VgsmkjPlR5jdKO0DTW7Fqa+cjQo36/KTVpP6ToyONYSLmsWQm+ezL6h2AuKcoisiohvMRCygGIEg3kZvm3TEg1xig+qtoViQbejNpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2GZoDuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D004CC4CEFC;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=RQNr/KzcW0oNe7IfHfuHatT3uQ+/hZf9xD7Hq5Cp2QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2GZoDuRbAQ7u2QyHRK8Vmxjf4deHBGIjBWGX7aC5XiCFGDBzvlgXefR1zO0FPSLG
	 PqUG6fe8A+9yQozmB9X4KsLf0BnazixETE2qdxifnh7bKE1cyHSsHtrE77kWgLlbkO
	 VX2j+79p5Of+G3rRjKDslnxwLCALO/QUGzXy2rl4ZP81u7NWoqkG3BeK8AlcZ+MTWY
	 IB+6xbm5FHBg305r2zSCLmpvucMDABuZIT9tbHTXCeZ0m6sNivgmv0KoOOQxHHISyQ
	 3RvMB4w16aJ1/muzJphfAXYKwnTTCfcxmiHxncaABnw6OCIciMX0kYyZLZCM5pm3L4
	 ZndtLFX6n+m4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVu-1YZJ;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/39] scripts: sphinx-pre-install: Address issues with OpenSUSE Tumbleweed
Date: Tue, 12 Aug 2025 17:52:28 +0200
Message-ID: <fe0b5f7c18d7b32e0229c0890371e1441ffea294.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


