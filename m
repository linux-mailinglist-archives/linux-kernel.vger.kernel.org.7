Return-Path: <linux-kernel+bounces-818577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC6B59394
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD643A83E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D23054D8;
	Tue, 16 Sep 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEMEgV/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D94305E32;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018217; cv=none; b=VxSTrm3f/adJl0xh3BjfM4Rx84EInPhYEMl0Exr1iy3dViIXRnhupzKqUFvJmWC7HefhzXb0ugNOURZblFtibPaxCMmsWkPyoA+m2V17iydRnoa4AGAPSAm2XYmZEI0aSvW8GSnCtbVrYVdKsNhicJZ/kCqk0aLmICeiQxM7XWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018217; c=relaxed/simple;
	bh=IxCwBaqniEL1mqsUfHyArHWkZNqcFJPHqEQYTKFn1Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWw0m7GUXh9nJT1+SilW/JNsJWWTkIayDmiTCcP8A7a7lxAd4wnzqiCBjGi7h+21p342Vyx8zOB+7EG42XslUhqYxoIdK/fT5gN/+HkE4y4RxIIkWV08Rh8VawaRm+feQHFoun8t/TdjfL54/53y+l9oysegZYz5DYIn0P11TpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEMEgV/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4495EC4CEEB;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018217;
	bh=IxCwBaqniEL1mqsUfHyArHWkZNqcFJPHqEQYTKFn1Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEMEgV/qRBx2W6NVx3Nxrzv2YkWYR6DBbMQvEdkgUKXfETFEqJedWadysRwPjGBp2
	 xZh6GoEU/0TJIjCu76hWKg5taJImbfR+1FlwuumHpGja8zUmUC67Du+oKUwWjEryE0
	 niVSWCLPM6BbHOHNUfyq35g7VjuFU72BfpwExpKcBH0v8FJEZBjpIr9ALeEIAl5UMC
	 UjG6xdgFPrE5Z8i73YzvUNcJkfk6IZtOeJMYJ4PR0TUoZHsGEYKR0/0aVR+99zTo9U
	 oVaZncsQhHQ5klZJhobDDR/yhnegfc9gQa6/Qr5BgpsnE9MerIDkLGwfHdObk8edx5
	 BCmAVockA7F4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqS-0000000BBPR-49e2;
	Tue, 16 Sep 2025 12:23:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/21] docs: Makefile: document latex/PDF PAPER= parameter
Date: Tue, 16 Sep 2025 12:22:48 +0200
Message-ID: <61f692a8d015b977bcf6c1ac95986cc5e090dc33.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
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


