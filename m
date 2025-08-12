Return-Path: <linux-kernel+bounces-765176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BFB22C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A87504215
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B2A2F658F;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTbzYx5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949E2F8BEC;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=f4n3b5FiwunC8J97pZdW36rCffh7BfXdqm/poz56NQaNJfPD8W4OguIBsSH8zu9Ypn9XgR5zJ8aInf+LSduyVUEZFVoWQcCdgtXYeuHTz8TBx+MDf2WGv/lppNPcnWoSOGZAjzbeU+U0xbjwOZUT/6HBQ+Y5yOHxBAssY+flvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=6213I1YGIhaAMSl82yuZqy7K1JDcqwNqRPbmxLRGh8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ma/2+LBCpc+bGm/bIIHT5xi+oyzzGh/PGutFWMfY6yHDFNpkhsMqFQLXtRGiNOG5rRUIxTuPdN5FyXzQfjwQIG4RfdXbufWFPoVUgauFDL8ubi8gqcLCtB9reKyy0QzivPuwoJhGIOT1HjAueG6r3Ud8sKVMwOwLHQwwLDZ8iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTbzYx5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7CDC4CEFA;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=6213I1YGIhaAMSl82yuZqy7K1JDcqwNqRPbmxLRGh8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTbzYx5usqNc8tDJUk72dsA35+q+q8EvkiAJSbLo0ymHr4hCJ4m4ePp2RnNn6e3rf
	 /hn7kyxma85yroK5mNSQLaB78QTOaS8Nvon+7FmknV6Gags5l131qZxBiSjZh0DauL
	 2kbFLmtQu4WDKwr/ZeMyFB12UQB+Mwiycap+Crcpcr3BD/tB4pQFKJJmSd6cB8TZD0
	 /SjnOM3DL2ZQNUbeF7So3ZT4cE+AvVuYcq0SVzbHP+o6PA64tWGmHQhY36CiL7LUQW
	 qtc+7wPbH5wJSgM3whxX2BdyXbm1wB1HB7NDitDcNTTqz7cSAT9iQ8w+2zEYswT/3B
	 bRy+1Hq2OhicA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVG-0KdN;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/39] scripts: sphinx-pre-install: fix version check for Fedora
Date: Tue, 12 Aug 2025 17:52:18 +0200
Message-ID: <9d1e5c9906534e2bae586f891770066346463146.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


