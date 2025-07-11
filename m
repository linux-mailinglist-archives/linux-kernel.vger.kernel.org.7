Return-Path: <linux-kernel+bounces-727067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48039B0149A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAC91884A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4AE1F03C9;
	Fri, 11 Jul 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onJDwMIP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAA1EE7A1;
	Fri, 11 Jul 2025 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218837; cv=none; b=QoyD1Q8tbch44NwZco0Mmnf86XVHWy53pAZvIlJh71r+WM0gTjpI3Y41n/3UEH96ji3tJO0rE06vbgFnqeZR8ZVjTSVTxv6IquAkv1ZyhEyzdg3LsHv+Tq5KJ1L5D9i75esJ9w1iVa7J0UPSm9z1qyhRzPOzszelviyvoAGtE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218837; c=relaxed/simple;
	bh=eVTLcMK7oKgBVI6TDwgs1/kzz/4Jkz57v7A2+Jm5cPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cON3DQ1towwTFu0SSjlEkY6JAaW+Kzhb3j1LNIz21zzif41aclBQpm1K44zBoJha35jNfkphQsLdj0qmgn3urflY40qX67g08Mb6mgGODWPtwVtv7+5k4IYaKfLOu0lf0iQX1JlHROvLXOhN0rCSQKqhb/CEcUqv3SxdWjZOjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onJDwMIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39C3C4AF09;
	Fri, 11 Jul 2025 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752218836;
	bh=eVTLcMK7oKgBVI6TDwgs1/kzz/4Jkz57v7A2+Jm5cPQ=;
	h=From:To:Cc:Subject:Date:From;
	b=onJDwMIPE2FjhQn4a//t+Ukrip+5u1HeCwnaphNhgElu2hJ73ZQryHaKF9jW55xzS
	 Y/9YkzYYZFYLsuQADrotcPreKFteikCk1l3JwM24rYooraU2sH6pNec9RhO7sQF++/
	 2ZjFp9VVUPqwls6ctPL2lJRq+gw65g9pee+/vHTxdh76jARubqhUzSzs1+sHDyugDi
	 osdnVqQu1GO6EGC921/spYm6CGfQfRxpU5RCBW2iwAzXL390FNkYtmu0WzEZibJ/PJ
	 BC7lpxNCGs6oVhgRjIUWkYGGjsQrjPt9uTCDpkxK1ogmIWZwKunOU3ozXvVy+sbtfp
	 ikSfKTPhoygIg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ua8A6-0000000FSSo-3HIr;
	Fri, 11 Jul 2025 09:27:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 0/2] Restore kernel-doc support for Python 3.6
Date: Fri, 11 Jul 2025 09:27:07 +0200
Message-ID: <cover.1752218291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

While discussing patch v2 12/12 from your kdoc series, I realized
that kernel-doc command line should not crash with Python 3.6,
nor cause compilation breakages with older versions.

The problem mainly affect builds with CONFIG_DRM enabled, due to:

drivers/gpu/drm/Makefile:                PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -none $(if $(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \
drivers/gpu/drm/i915/Makefile:    cmd_checkdoc = PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -none -Werror $<
include/drm/Makefile:           PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -none $(if $(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \

This small series prevent Kernel build breakages on such case,
and it is meant to be merged after your kdoc patches.

Patch 1 emits a warning wih Python 3.7 siilar to kdoc class,
but on an early stage. More importantly, it emits a warning
and exits the script for versions <= 3.6. 

We still need the kdoc warning, as it detect troubles when
calling kernel-doc as a class.

Patch 2 fix a backward-compatibility issue that otherwise
would require Python 3.9.

With that, building the Kernel with older versions won't break.

Regards,
Mauro

Mauro Carvalho Chehab (2):
  docs: kernel-doc: emit warnings for ancient versions of Python
  scripts: kdoc: make it backward-compatible with Python 3.7

 scripts/kernel-doc.py           | 10 ++++++++++
 scripts/lib/kdoc/kdoc_parser.py |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.50.0



