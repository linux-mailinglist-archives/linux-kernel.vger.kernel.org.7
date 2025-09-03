Return-Path: <linux-kernel+bounces-799086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72963B426D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB851BC0B29
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521E2EA48F;
	Wed,  3 Sep 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaZ9P6Eb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC372C158D;
	Wed,  3 Sep 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916671; cv=none; b=HnICFFQoJ3u9GPNl5OiZePFOBMXHAoRWaiLmTuy6WDTuh2rtzeUcTn+S/WaXm0AfF6laPqF+KNu3OP7D8tW0kF2Xduydi6aTQeBe49TBWgu+CnkOHKXtoP6GzHi82DEPNR1yti5zdNwYWd394vmLwVEwglAp9O8Aw9AVdxYFJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916671; c=relaxed/simple;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taTIfuSNZgvZTJTCfdUZ3FYh3fqJ+yAOvyiH/H6dEdya6bN4vDFRj4MouJYJXBEJyeMiU/3bJOe+riK9Ps3k6zsvIAzSfz8nbUSXSOHdRI5AaIphBmn6QmClTe6tlHIcvjBRnqjhF1kpY6iOrXCydEa6YADa310ynzvurtM4iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaZ9P6Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB77C4CEE7;
	Wed,  3 Sep 2025 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756916670;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaZ9P6Ebmy/gzRUpaykcZlZlqonMddP6lxt0wW0eatVGo06HIXx+ITUxXJCFr2I5V
	 IQiJtyVnUVPbDz5SbIPGl0uR6GN5ITrWf1L8Ic7gb5F7Y0/tTw1r+KKGRhZSTund1x
	 P1oGupNe83xrhNSwg0i7IN1VYmXHCQ4+fTQSRFC0LvCPHNQWMH9HoWSuOgo/YzLNw7
	 Bnj+OBhlPS/jUwXlV3rchrcn1cnBam7+Oeft9WH83T7dNI+nx8IIDHlqPoH3WJaYby
	 nH7xqyizLY1pCE+mhAhGBa+pwj5t3HJLAmA02870ZO6ZaGyvPKyUofl46xAjJQZYrV
	 Fr3ebH9KbIpeA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utqHc-00000007Vom-3Wa9;
	Wed, 03 Sep 2025 18:24:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tools/docs: python_version.py: drop a debug print
Date: Wed,  3 Sep 2025 18:24:14 +0200
Message-ID: <623f783ca31fa33e71d700f1c5c659f7171acb51.1756916565.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756916565.git.mchehab+huawei@kernel.org>
References: <cover.1756916565.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The version print at the lib was added for debugging purposes.
Get rid of it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/lib/python_version.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/docs/lib/python_version.py b/tools/docs/lib/python_version.py
index 0519d524e547..660bfe7d23fa 100644
--- a/tools/docs/lib/python_version.py
+++ b/tools/docs/lib/python_version.py
@@ -109,8 +109,6 @@ class PythonVersion:
         cur_ver = sys.version_info[:3]
         if cur_ver >= min_version:
             ver = PythonVersion.ver_str(cur_ver)
-            print(f"Python version: {ver}")
-
             return
 
         python_ver = PythonVersion.ver_str(cur_ver)
-- 
2.51.0


