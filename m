Return-Path: <linux-kernel+bounces-765192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B6AB22CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33FF6270E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23202FDC23;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSFA8CqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2F2F83C0;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=JnoncdWbqggsJ87t2c9Leez5x7LWAyK8uVekH7OHhHFNBEBlILSzGgBNV2FMpARbC3kgiY2po322zPVsDH2u8ZfSHNFtVNUMU5OWphX0VIHyhV38FgVxk7eRDckrgq5HgIfNIFLrNi5Xh+wzjB74KJdhrdDAZEHW8YjRYsuQqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=WebWcu8z+YevfzDBChtXNRkHwfTSu+wYncOqqxbNMio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tz8WbdB0YQbXhTWTtIIscJHzI//kAl5HYujlfZGuqSaxtk3X3YkPYqGKYGpr4i2ybD+tYyTxmhtIWL4L7uEfycn6lEzM03gJqraa26xEVcN//h8oGMpQq5SXPFy9jp7x1z7cUYhLBjgww+URAwCzobJvMPVM6vN9md+VObvZdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSFA8CqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F90CC2BCF6;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=WebWcu8z+YevfzDBChtXNRkHwfTSu+wYncOqqxbNMio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSFA8CqGgrFaRwZ/HyAv4vh89GoILlu7blWgntOq7dPUcRmI6zeZQwsOt35132bGx
	 4527Jh27mYQG18NI7HtoFkQ+TM8fFUbsXlO9Xr7ae+Uyobf9+ef3AN8kHiIzuVpKJW
	 /KtNN3SbPOUBiKg27LnbTMXmxNNkh6U1VY9lhMh6O2G1ToXP5ulXvVWbnGp4EuPVGO
	 t8mtIoA17sI+6cK8rpAkeTTrGdihYvtkxFMOgss8VqNUvONP89DTl+51CXZGkDY256
	 aDPGd+P98uJgt8UrBwB98dW+IIjVpcVPOpGZqZ1F02VFR3jX2ECUfA3fHhEugb/5P3
	 OeXsltw0frcaw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ9-00000006kXX-0Sbg;
	Tue, 12 Aug 2025 17:53:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <mchehab+huawei@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 36/39] scripts: sphinx-pre-install: update mandatory system deps
Date: Tue, 12 Aug 2025 17:52:53 +0200
Message-ID: <4ec979e4692c9e4acd6c31424c0e2f4bf5b80e71.1754992972.git.mchehab+huawei@kernel.org>
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

To build docs, gcc is not needed. Also, Kernel can be built
nowadays with clang. So, drop it.

On the other hand, which is needed. Add a system dependency
for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 7dfe5c2a6cc2..fc9dc45054d7 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -1476,7 +1476,7 @@ class SphinxDependencyChecker(MissingCheckers):
         self.check_perl_module("Pod::Usage", DepManager.SYSTEM_MANDATORY)
 
         self.check_program("make", DepManager.SYSTEM_MANDATORY)
-        self.check_program("gcc", DepManager.SYSTEM_MANDATORY)
+        self.check_program("which", DepManager.SYSTEM_MANDATORY)
 
         self.check_program("dot", DepManager.SYSTEM_OPTIONAL)
         self.check_program("convert", DepManager.SYSTEM_OPTIONAL)
-- 
2.50.1


