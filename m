Return-Path: <linux-kernel+bounces-765172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840AFB22C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438507B976D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0ED2FA81C;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg9+phgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B572F8BEA;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=hFP3mtAhZBGDl+vSw3b0lUO+iv7nsFxdJYYKDHyh6/vvmYuaFPanznuIePCXKMJ/EAxJ+KlZ0liWVSo6Nh6dX4LbnlVqUvOJYbWfWRLs/fjNSv6ZfR4bk9/syWkQXGOSHpi9LpTeDjI9HzN8dEiUeJG6d6lcLbk34drqD85yxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=vRnsNCgM3YDMxmN+8rNiF2tJ0DjUjMBLbtkTm4kNDsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3NS4/Frr4zXQIToyI+3jfp9FjAWzD6UN+yWXZ9pps+tdiJ7uVh+07HWaON4Hqro+9sGXpU/Rni7EIbTKnpjGuWTaqpYeeSUn3Ry7CRutKyIPu2MT8khuTVBv7d5kI8ProCygLq1VulEwiMr1IWGaepqwchtTplUsNuZJBRSdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg9+phgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30CCC4AF0B;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=vRnsNCgM3YDMxmN+8rNiF2tJ0DjUjMBLbtkTm4kNDsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zg9+phgPZLhUffMRUl030IJ328z2sfa3qoqxB+/JmkolJDwbax5Di9rzzstuO8nBr
	 mnLVMBbC/ce4olnSO4h9kqbdDXrQiFXginVneHRqf0f5a+yubvA5Ryddv/WU1VHfuf
	 GARm3lIU5SECBI+teXCJF8zT8q0tkJ9KKJgZqKO3jfV8n6YKez6bcA7FspgiuZ61IR
	 sExHOZJvaqhWCiMH1BcTsS2aEqTdpId6DB0EHXr5IlnCzOzse6Sbm30Y5qyB4279qD
	 47qcMp9v4Muj2mLxT571EzzixWVt1wtyCKi6bUTUF0KGd/5m56z4TrAXfSzsFxh8NI
	 HxFDbdGy1aq/w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWc-2yPm;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/39] scripts: sphinx-pre-install: adjust a warning message
Date: Tue, 12 Aug 2025 17:52:39 +0200
Message-ID: <74a17edd70364ca623a54b62bd97a344bb474988.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


