Return-Path: <linux-kernel+bounces-813844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E03B54B79
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386D56865D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A613054CB;
	Fri, 12 Sep 2025 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNn/sPlw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4930102D;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677595; cv=none; b=tF6hKCNazpJgxOpptMwDg+a+EDIfU3Wo9R/Lc1AEUgPHg1VAlSkfDKtiGS3vPYUQ1+gcI6BXDPeSAjvcjX/EbhxOvFnaP4ntJH91Xvub1aF8+wd70HNdN81GaDPHGiL3GeLEdG+EqTZarGUquZ1Usb5nsMOmGQ+C77KNkmb7Iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677595; c=relaxed/simple;
	bh=IxCwBaqniEL1mqsUfHyArHWkZNqcFJPHqEQYTKFn1Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bM7YAyYVYMMDkqwe21T+x3SlzpuWnro4AMXk0CHS3e5i1zhc2IQjaC4sAfokX5wnQom8iis0Dr8L7WmlLbnpksgna07QW4YQywVfnbuJuBoFped+9c+Cx54jTs5HDDjep5k8DUI6giTa+m/Lrv1lMU18TvrbbBPA6VJSQBgXlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNn/sPlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BFFC113CF;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=IxCwBaqniEL1mqsUfHyArHWkZNqcFJPHqEQYTKFn1Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNn/sPlwM1y+8JRNFCzVAijCAVcvu6tvrrN7bhEDWD0R5kwt5HzYs2h5d0a6MvM0G
	 ZEu48AiJ1u5ppffYfIFdTV6vGkZH8cdugGiYOWyG21KS0fg715h685gsN4gMPVgGvT
	 BvdK0dLEax06BvqotK2yoceB7s1SbcjzVC2GG+S7Yoirsb+gAk28Yucz3AoOZxWWmd
	 Jom4yW5iXHBYA8LLzlBFAKPWS1a+OTP+X4oH92jsESOvvmFIcdw5539bSAf3wsggY7
	 7OoncQvZySSPlVz5xarfgP4mt67YJjyKlmefxj8F2Xy9On3gYrXP7OV00SVvmmnyNw
	 lQJe2Gnrsz3mQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008Rsb-3Dbe;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/18] docs: Makefile: document latex/PDF PAPER= parameter
Date: Fri, 12 Sep 2025 13:46:18 +0200
Message-ID: <a574dcd9e8324844dbf0d7852556c7731765a82d.1757677427.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757677427.git.mchehab+huawei@kernel.org>
References: <cover.1757677427.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While the build system supports this for a long time, this was
never documented. Add a documentation for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4736f02b6c9e..0e1d8657a5cc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -126,4 +126,6 @@ dochelp:
 	@echo
 	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
 	@echo
+	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
-- 
2.51.0


