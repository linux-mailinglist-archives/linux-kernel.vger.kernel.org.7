Return-Path: <linux-kernel+bounces-820644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4184EB7D1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C104653E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D991B333198;
	Wed, 17 Sep 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/KWGQ9N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE9333164;
	Wed, 17 Sep 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111362; cv=none; b=JCbzqb5JyDu0Or9zaMgpGLvYalQ9+uYLHggSXUBepU7BNfTmD4qgTz5z50qyWXodMX+zUL69H30TVQSqpAI1h1GB2CnLWZWex+JW20T80w227zt630wtPPTniBy/tIEj9WXF7dHrFrepiS7K+iSKqz8FMLdyOUkpFlbQ1rL3LCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111362; c=relaxed/simple;
	bh=AH2lL83LG/MCK6GW00LCQjiXUczLYQf3wfFtphqsZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oek5Dfd/gaGEA3gnhw/RJ6G7I+lgLu8JtabptyFVOXs0aFTjB5IXYSPm+byqlO2dpOMqsXllARzjfKmuiQNP2+D0D3BBmpSCBwKjh7D+RYBBPU0p3K+g3c/u+c/irXHKjzwPVa1oMQ0qctDs0gugo/knJ/22EFFZL2SbU5iWEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/KWGQ9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0866C4CEF7;
	Wed, 17 Sep 2025 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111361;
	bh=AH2lL83LG/MCK6GW00LCQjiXUczLYQf3wfFtphqsZ6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/KWGQ9NcAN9v6oSebFVQKvDDRIiCgXAx6UF6meul7UkQKm+T+GMXz/fcPpnfd+Dw
	 bv+uihK7Jay6uSkXK1NgkVjYHHFzglgEiQhe7ooDET7L1Ct+vIM7zS9zDip4yOBrr6
	 75JUNuKBr/v5oPmRdBqRr5IlRuUsPqIX1EFgQ2EuQUQDR1zQR8fR3U2+taYEo3TWAe
	 kfisWtscV1pa9rbQlzxVxsNBP3Qvv45qWYq7UPRlvqyDA8W4HPBLI6LMtj46T/EzNk
	 YG14mBPj9CLHQmsJwZllP+9iMA3dlXvswT5T+Que0ru4dkd0/3T8rOwj80BXXNO4k2
	 WxIdqzCe6wQ7Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGdg-12aY;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/24] tools/docs: sphinx-pre-install: drop a debug print
Date: Wed, 17 Sep 2025 14:15:02 +0200
Message-ID: <4c7375298ce9aa1f15e0be42cc7e6fa7e8a54c1c.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
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
 tools/docs/sphinx-pre-install | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index 954ed3dc0645..fa12e01fc7fe 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -285,7 +285,6 @@ class AncillaryMethods:
         cur_ver = sys.version_info[:3]
         if cur_ver >= MIN_PYTHON_VERSION:
             ver = ver_str(cur_ver)
-            print(f"Python version: {ver}")
 
             # This could be useful for debugging purposes
             if SphinxDependencyChecker.which("docutils"):
-- 
2.51.0


