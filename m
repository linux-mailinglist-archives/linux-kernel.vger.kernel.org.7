Return-Path: <linux-kernel+bounces-794953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E8B3EB1C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753EB17B015
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6542EC09D;
	Mon,  1 Sep 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwhGapx9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15452DF139;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740838; cv=none; b=J2L3+KZHBFFVsS8IMs9OSCLsrsSsb1Rn9Sy+9v2qwQy40vVAPf9O1sFYzqNn+J9G5pqqrJXoEQwwZS2vEdvaV4/AkvC/eAnO+IB2zwL4bkdW7zyc5VYJACRkECrI7yAhlxiF+aNws6ZWkyJB1AgT/uyMolsha/CVRYsJCCUcAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740838; c=relaxed/simple;
	bh=pFn4aXuekiJ4nWHYjOpMDGZDzWz9r/tmySbqoG1yg7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Di814B49vwjBenJwZtO8B/25V/0HlnM8IUTb+99ZaQ/2iX04BFbqD3DM701EMgF90dc9+00BsMZPg5n4/jdg18Eb8Hx+nxzb8aQtyILUPKWubJKwYFiIq5TEMOyZNKFjmdpx/Bi0uizUAAdkyBmCf47gJ0xrIkL5TIl1IxLbwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwhGapx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECFEC4CEFF;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=pFn4aXuekiJ4nWHYjOpMDGZDzWz9r/tmySbqoG1yg7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OwhGapx9XtmqfMDihDc7A0Dr6jDGsMqJk5m29JpXlImmDF1HFT4Q7XmN2r19mTO9P
	 36Aml/7cKmJdKkW/9DY6J+RqyFCEXpFtYjmCUVhSTURPgGrnsgh8o9w9OSN7BkalEH
	 eotrHkKn49RYpZ9MLMKdgJI6aNo40ejCdUZC2javWrQvP2k22qt5wY8F0GSj2JeWxG
	 WLgct+FRNzpnsUrYITI8Wa8xZCTmrbzMVkAmXymAWbJ+wFxyhvcRyRapzmg4IGgaOB
	 fFTPBsThNYDdV3hoOQozOb7kmXTIgkDcQcPyMn+oa2ObJgZTnFt+fVzg7Ub0adsMo0
	 GLEhiBVJ1Xe2Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HME-3Hb6;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 10/15] docs: Makefile: document latex/PDF PAPER=
  parameter
Date: Mon,  1 Sep 2025 17:33:45 +0200
Message-ID: <bbe7cdefaf969c14762359b2f96b312c33a7960b.1756740314.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While the build system supports this for a long time, this was=0D
never documented. Add a documentation for it.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 Documentation/Makefile | 2 ++=0D
 1 file changed, 2 insertions(+)=0D
=0D
diff --git a/Documentation/Makefile b/Documentation/Makefile=0D
index 2b0ed8cd5ea8..3e1cb44a5fbb 100644=0D
--- a/Documentation/Makefile=0D
+++ b/Documentation/Makefile=0D
@@ -124,4 +124,6 @@ dochelp:=0D
 	@echo=0D
 	@echo  '  make DOCS_CSS=3D{a .css file} adds a DOCS_CSS override file for=
 html/epub output.'=0D
 	@echo=0D
+	@echo  '  make PAPER=3D{a4|letter} Specifies the paper size used for LaTe=
X/PDF output.'=0D
+	@echo=0D
 	@echo  '  Default location for the generated documents is Documentation/o=
utput'=0D
-- =0D
2.51.0=0D
=0D

