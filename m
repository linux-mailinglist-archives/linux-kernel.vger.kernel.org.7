Return-Path: <linux-kernel+bounces-799004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C46B425C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B3D1894A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3A286416;
	Wed,  3 Sep 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWNTmoU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01B1FA272;
	Wed,  3 Sep 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914302; cv=none; b=oPIX7dLB6XpS8YVnLnvvgdaJa5nhZVdTFcpNRNC7SEb71d7Ru+ZHUyOlCpghzUIM+lFgL8wW1DLTcRgj+A6GLw5IyXIaqVAsP/6ZLKXSG0V/fkt7aOs7CIdkFesXUqtgwXEvCtQ2jbeQRS05pDddal8wX8RhN8WNJTWDkGF8zOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914302; c=relaxed/simple;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXwhu6k0/T6MevsnTzbBXC3LxPUawA5YpxvNKZ3k9AqdYW+Mbm3Uy7Yb/e2TVigyFSe9z5i7uJiY7ufdCn5+d8/cVd9b2624wIjcGVoX+13ovsQJ5eY+93DQ5a30cqUlQs8MFuhvHctCwtFzcwl0QZEv0eQ0/jF404NGzWIlgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWNTmoU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4DAC4CEE7;
	Wed,  3 Sep 2025 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914301;
	bh=/dLIDswzK4KrvEpdBfQvdI/IqyHPjqk3TcTvIyNvmfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWNTmoU0ZOD+ndmT4jIR7jkei4i9P6Ueh3zbbwnwPV6+43eyxRH7+LOM0Xpps1OK4
	 Zp2pqv7NaIdtB6RRHgziJC5BQI1iXXhuJngkqBwKOddCYwp8AHKDF+qIt5eD6J1OH1
	 ozyoQ7jsMjHfaBdgNkM/sPV4BPoNhzNFIrm1vNADh/a3lz+6z/K5mAnG85P4W+MUt2
	 AsZpucUUmspcPGBxe3vsNJJsGxt425GtePEq//cxQvWIzmddRKrb7qA7/bT0Bj+tLe
	 9Fz51AJJ9rHfebMHqEGSyxGlRxeLO+l/tDvFpl9aBM2oqEo7jfH4MhTQCCkYj4N5VZ
	 6N39+nCmEYfkw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1utpfO-00000007N6Q-409i;
	Wed, 03 Sep 2025 17:44:58 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/3] tools/docs: python_version.py: drop a debug print
Date: Wed,  3 Sep 2025 17:44:34 +0200
Message-ID: <623f783ca31fa33e71d700f1c5c659f7171acb51.1756913837.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756913837.git.mchehab+huawei@kernel.org>
References: <cover.1756913837.git.mchehab+huawei@kernel.org>
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


