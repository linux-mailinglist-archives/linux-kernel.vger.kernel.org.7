Return-Path: <linux-kernel+bounces-723770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B100FAFEB00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A27D4A2471
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99B2E8DFE;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRwI7Y9z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF382E3371;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=Sk6IJlCzKIf7Z5Q1CNXKHujx07/tr9YB3T/1jwICrzz2v2C1pMArSJnEHqXUKlK19vmdYU28eJv/IDXg+VTI4Bw5pNWroL8HkAy0mTNPj03DjuywVqp78R7gc02wqm9JMoec53NpZ2OUyi+SmuBixXhEeAp+/1xod9X4JBoLrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=uqL7Npn6nD9bQK26qpQdsjFctfUmYoahBmjchL/UNkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGSUcnMVj9fZszfLyK5R2DEMFQdsTYnM0szjQr2U6hEzPBb7rsse4OXtumfbGZXoqWgfPyP2Iac0AZtM+cxJfEnIKUga3FafWKe8R/XuT6vlmn06BCQzQ2QS1nmtOy8YrxBDrST9SakkDGZm8yhv2GLUZQXqe+dg1bLMr/Oqy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRwI7Y9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF46CC4CEF8;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=uqL7Npn6nD9bQK26qpQdsjFctfUmYoahBmjchL/UNkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRwI7Y9z7TFQix1xzuMlCBm5faxFZ+9T0lsEsbsjAdfpRcC1/B5HjjCvNHxQV0XF4
	 d2T1vvBsjQP0TRq3r55z0OQ4qElJIVKPui16xR/YoHyez68JepExZqVGL5YCcnd2Eq
	 Ywwf1lV7UOHu4Jw6RvYwg6xKWIVSrTC8aCje0OHjvx1GhEoefC3ml1dejU3KCsjm+Y
	 FmY2AFNCiUSsXzGkIemnZUMIirvHKFAkdvno3+hhLbzQN/xPqtN2PTrVFzoyQhtcaY
	 pcTN3BPhKnykQQVI5nmIkIGSlBSStu14OFuvgxJeqsx7LZMAQze3LQogLQ72f7Bwhl
	 j1FohU2BhOxLA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EC9-0iMH;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/39] scripts: sphinx-pre-install: fix version check for Fedora
Date: Wed,  9 Jul 2025 15:51:33 +0200
Message-ID: <35d114bc75f6044e68dbced77c3a5cfed0da2b43.1752067814.git.mchehab+huawei@kernel.org>
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

The script is now picking the wrong version. Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 3f8d6925e896..07234d482fa8 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -413,7 +413,7 @@ sub give_redhat_hints()
 	my $old = 0;
 	my $rel;
 	my $noto_sans_redhat = "google-noto-sans-cjk-ttc-fonts";
-	$rel = $1 if ($system_release =~ /(release|Linux)\s+(\d+)/);
+	$rel = $2 if ($system_release =~ /(release|Linux)\s+(\d+)/);
 
 	if (!($system_release =~ /Fedora/)) {
 		$map{"virtualenv"} = "python-virtualenv";
-- 
2.49.0


