Return-Path: <linux-kernel+bounces-820627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED82B7D0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 020207AA043
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49499323407;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb73G6p/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47631A7FD;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111355; cv=none; b=nUlgpdC70A9AgAHSHSFB4SbWestd3il1zsn90e7wRBHPt5MCTO9FpcwWn76N2favJtxXYnFN0lmBII7PZE3byxjnUDSzsrwvFMa7ZqkHArP9SlIRBJZM5ChffRDHiuRL8PXm+UJAFk6LlwAtRUpfaZ4HxMdBcVCQJo6Usg37y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111355; c=relaxed/simple;
	bh=mOGPpjFInnJF5ficZgf3c7TZFdWiehGB3ZFVn3w7fEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YppNsrJRsL2aCthDwV7FcFEmgfoLzUi/nP5fQoXIfIlDagUIFT/UJN/ideUPksvnQ+DtJzGSI0o4hUHZW4kt7JEovpp5SY0cVJxrgdv8BaMkOfibK5Vr3K4nQ9dd4PwTynvcoG3e+isd3muKyJ9IXat0gmPhXQtJGbTgo34cLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb73G6p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB6FC4CEFD;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111355;
	bh=mOGPpjFInnJF5ficZgf3c7TZFdWiehGB3ZFVn3w7fEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mb73G6p/MvHTbaZemWskx/A9k3EmwRPf8L50Vgu916lpBnMg97Sb6QnzyuKLVBhd+
	 5BOI61zeGUS/abs3dj+02VPFeW4Kr63K54vhIlU94glf9tYxMw91/BQBsm959rqVAA
	 DKTkrMcl3gWTv6FqsAJDrvbxVSFPeTj7FnyNcxpoeqUPwWJk2mHRNt7dTPI2iU792U
	 yKT55gGq9ZAlYkmWnicFDvNhkgp1GRVuXtJZUrtzEu/sx5g5KSmanRzGIKfaOgwjaS
	 zxpaNu97+uBKsms6vYnsOA1+d/4CN15VCsw5yhIAVTOQKBWhyxWnawIMngcK6dLdTi
	 AL/txEBiydQnA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGe4-1jQ5;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/24] docs: Makefile: document FONTS_CONF_DENY_VF= parameter
Date: Wed, 17 Sep 2025 14:15:08 +0200
Message-ID: <e26b0a4421a0ff05f5e18d46606e6d5bda7bb502.1758111077.git.mchehab+huawei@kernel.org>
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

This parameter is there for some time, but it doesn't have anything
documenting it at make help.

Add some documentation, pointing to the place where one can find
more details.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a52b311cdadc..05397b9d844d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -126,4 +126,7 @@ dochelp:
 	@echo
 	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
 	@echo
+	@echo  '  make FONTS_CONF_DENY_VF={path} sets a deny list to block variable Noto CJK fonts'
+	@echo  '  for PDF build. See tools/docs/lib/latex_fonts.py for more details'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
-- 
2.51.0


