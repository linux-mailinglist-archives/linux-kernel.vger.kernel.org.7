Return-Path: <linux-kernel+bounces-827120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E96B905B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9993B5C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF3305E3A;
	Mon, 22 Sep 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYcun2W3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25B30594F;
	Mon, 22 Sep 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540496; cv=none; b=HP67Wyj8gqyChpDLfuyWPfNDoVkMvIRB3cuCaqMOBnZVpq7stq9DlSuOtQ1fMxAtCrsjCS1fACGDMDwNQ5mThohBZcIqB6MlCADs4bg7UNqDggT6ibY5jYlOOEY2ZrZjlsq/VM9M2WrGjKhQlBhiu0E4FEotC1gZpPWyG8WySzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540496; c=relaxed/simple;
	bh=z1mNSQz3UrZbcale6Wt3b20gF0+3YdPSmgihFq1+T40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkFwijwKC7Sg+Q9xFmoiax+QIjq4e4TdbO+k8TNBJkBECfy8B8y+t549mMWyGmeO1qM30aZrb/U5LX+S0TLpTLJPVBY5jGyk78X8qwE547og6x4WNFnpjbtE3cB5lq/T7HQ9oDAD3AiTBpkvx63fF00lz9r/U4Xi/muXMD53gKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYcun2W3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AF9C4CEF0;
	Mon, 22 Sep 2025 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758540495;
	bh=z1mNSQz3UrZbcale6Wt3b20gF0+3YdPSmgihFq1+T40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYcun2W34cgPDsL/2GWEpP9h3opIyAgjVRcIW3cfBXtDad+/gXaq2ZSBvR13dujtS
	 vvY1dft5iqw0UGiC9zC5YS2uZkuALGln9Xb4XNZVODwhG1x1RFixtEK+O0+f7Xwz9m
	 lW3XvvZAwT39ngbmJ6m+tbpATVWbnHTvC6xwAiNClaL8mQuTIaZIBQQ+Fv04EwXVyC
	 yn6ZV2sPxZZTv6HkPXJknxpX56fCUJ9XRvAN8vCVuoGpKJNKBOaQdMUWaJ/uQgWVpg
	 lzan7zND1Ss+3L9GHMopDThVkQth5WXlyZJUd4cSL1p/amyuCRWrWGDl+B0lMQweaK
	 LiebEcrIHrCgw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0eiL-00000005vOt-3UZS;
	Mon, 22 Sep 2025 13:28:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] docs: Makefile: fix rustdoc detection
Date: Mon, 22 Sep 2025 13:27:39 +0200
Message-ID: <f414ff9b21eeb770ca1f57eb1496cc064c9bab15.1758539031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758539031.git.mchehab+huawei@kernel.org>
References: <cover.1758539031.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

During cleanups, the logic checking if .config exists were dropped,
but removing it causes false-positives. So, re-add it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cc4ee55c75ed..c60db1038c9c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -42,8 +42,10 @@ FONTS_CONF_DENY_VF ?= $(HOME)/deny-vf
 # User-friendly check for sphinx-build
 HAVE_SPHINX := $(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then echo 1; else echo 0; fi)
 
+ifneq ($(wildcard $(srctree)/.config),)
 ifeq ($(CONFIG_RUST),y)
-	RUSTDOC="--rustdoc"
+	RUSTDOC=--rustdoc
+endif
 endif
 
 ifeq ($(HAVE_SPHINX),0)
-- 
2.51.0


