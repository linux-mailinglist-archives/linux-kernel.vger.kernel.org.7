Return-Path: <linux-kernel+bounces-800162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27EB43438
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8267A7A28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F52C158A;
	Thu,  4 Sep 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFjmlsip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5E2BE050;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=Ztqu9/YqCRDk5YAyqHtIfk5SnOU0+LfBxi9flCZhy8DLlhk6YP1fV9gI1nBu9r+pg6qYVJrnplE7SW4o21J18MlQC6DvVBCUQFW/752K137JPRCxKFnGga1PIYmc5z9Lv+KMKxY3FHZJiVUWdVi8SxLceCtrrRKSdF0ENyyqxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=IxCwBaqniEL1mqsUfHyArHWkZNqcFJPHqEQYTKFn1Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8+t/lJ7ojrQO7Io/7XGul5Ta1qkxXmbAczAKYH3fg3aQ0v937jsi85zdt8axhMPD4Yk8+1hfJi7WrYHAzgc143YvHgIIpsLfRDKAM4vWVLqWaG4L/phaTokglxK3s0M9y0rcMH0cR+iZSYJ6WUgoQHeqpbPWL7eH+bDBTTQcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFjmlsip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6B7C113CF;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=IxCwBaqniEL1mqsUfHyArHWkZNqcFJPHqEQYTKFn1Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFjmlsip2g6V/CfCM/eh6jTWiJiVyRk+4D4f8TfdWQsooKZhaqfUs4W8sON3uk2jY
	 p30Weihr2QnjJfZktd7n4CHdCwE5Y9IqhrTumQkQrmt9loESqeXrvlLxdiCHq7qmum
	 FKdP2i71NWPKSlbyzu5gx6f2vM6Z1PCSzXGUQVQcYdlNVfykxe47S3EIpv25yZ69sQ
	 pmFZ8+gXHrT2NXg+JS9SQMgpDBeUAUIKXUtxTw8UfI8a5RJMvp1nP8TURajYFhMWz5
	 li3JG/076XwV6mH9WXidP53teIbuOP80g/C3O8X/x5J7yN39VAWtfH3lkvCUee242g
	 4Sw/nmT+633qw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jPv-47la;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/19] docs: Makefile: document latex/PDF PAPER= parameter
Date: Thu,  4 Sep 2025 09:33:12 +0200
Message-ID: <52411bce7bf0d068bfc8e33b35db3259c3ae0c64.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
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


