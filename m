Return-Path: <linux-kernel+bounces-780025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3270B2FC97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DAA1BA320B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A1288C20;
	Thu, 21 Aug 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTKeLVys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E527B35E;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=qlrojwn1sOB75QGDOA1zlG/ne6LEXxKDmxaK2s5UuVjqrpYBRxKL369zCh9vdIL2c4l+cooUL9QDwHce47MlXh3GQ20Tnnbje2/HDKi7F835UVOYZYC5GnjOw+aRlHg7FY71IkycPOiLHpz/0m6lEbficIR6+TQAdSbdseGZI0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=RsM+00sJ/1A8GHlMF3o/XgMw54KHkYT1Q+rNZSrXntI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izW+MPX5QWIZedR/vIZid9GOV2mEOkx5zuQmRC57zUjevOoLG6Gm98VyYoVr9b+kjDUk9h3/8F2evTRxT5YpvGL2Rg00QmmkF2XN0jlz2A2gQbIPhGNWgK+lshsCBXopyX5ZiiRrW/GLedv/iJBCDS6hcxL7NEKygVpbe5vY1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTKeLVys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19066C116D0;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=RsM+00sJ/1A8GHlMF3o/XgMw54KHkYT1Q+rNZSrXntI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTKeLVys+hrJbhlfnDpW0iUYE59ReSib+zuyv2bmcUgIpK9WCpiyzLRRWTwUgntev
	 jdeD6gj7Lcp6DNZsft3iwl0pEJ4C0SxSyxa/6jFAM7fzKy4t1nDvWUXR2+o/CFFZpt
	 lCpDJ38kXUi1cgZVpBwS+KadUG0hGwirF8S/kXqYb4iePNKtjlmHwZkuPjn2N8Vr8y
	 gcR8tXoQz0G6xfFv20oho+lf0imqytWMN30AgZxNCsT4Mrf5qx3GCG64fFsXgWdOnU
	 7EFqYBYvyA6llStOvxrVhKV0qZOb+UoyS1J26GZgRT/kS8A0Qaf9jGFM2FmzOLZJUe
	 tlaEeVOh/TddQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8W-0nXw;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] MAINTAINERS: add files from tools/docs to documentation entry
Date: Thu, 21 Aug 2025 16:21:14 +0200
Message-ID: <c29c9d04d69eea431d2a4ff7bb65b4465e38187f.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we now have a tools directory for docs, add it to its
corresponding entry.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dafc11712544..ef87548b8f88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7308,6 +7308,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	tools/docs/*
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
-- 
2.50.1


