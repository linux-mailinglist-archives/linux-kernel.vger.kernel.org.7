Return-Path: <linux-kernel+bounces-770843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA24B27F95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39009561F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2066301470;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eheRVI45"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62C2C374E;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=MqjkVAxkAcCuCKCx7t/ONv+Y70E9z36NAFfeoEVQN1E1hihqI0KpZdXd7sqCpPsymycQYjrCZyfi8K6YKX7fuj1WpfAeyfKtcY/4tyHoWiNoNElrCA1CZC/pmh0KEF55/GhBgXkSLbPMznZ1nARjrTsNRGkDIwSNdYOQcREl9eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=okAkyWYXR3GzaUm2kaZCuiY/fD0sE+ZIr5TU73IPSTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT/liVpgd+DcW8yZnFLlL576TFKxPN89c/aAokaP7Jw2mR0Px6Lyy+1olZ+kPKVjDe72gSMCz7Bgl0Pbt9cAiRyxw/Q7NXmW6RKSPSq/JPUjRhY0fNyRPF2rQuhiyUT81A12o3qc8nL812W9H6/qKKYs6bgGrL0oK4Sws1XY5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eheRVI45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AA2C4CEFD;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258665;
	bh=okAkyWYXR3GzaUm2kaZCuiY/fD0sE+ZIr5TU73IPSTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eheRVI45uZJxUcqr6HUgFEMqDTGPqz/T4XpWpCSly5bGpzdc7eEy7tAskXGJI2Ple
	 A5HGZqtuNcBNlTIwJbQ1n3UrWo9BeBAvK8kEza9yMD8p8jBPX9G3oV1jidKFyo05Br
	 00rjGrm2qD535eUPQoNdIE4bnJJc6CRN//p3/rSfB/34M4B4KaainHoyC8lyl+Ut9s
	 zAMrqLkypcFi57fqSWbhilvhsKLb2KdpdO7aqAqt8hZ8Y2+dS26SQpmUZlfPeCh943
	 R2cJxyya/PKBcNWp1ho7wxZv48c/55PAiGp6Ctt4+DBnmsldjNkbCxnpnaW+aOOOzg
	 Corps6CE9PPiw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042oe-0euP;
	Fri, 15 Aug 2025 13:51:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] docs: Makefile: document latex/PDF PAPER= parameter
Date: Fri, 15 Aug 2025 13:50:35 +0200
Message-ID: <70f03a706a01d1493ed3fe085b394cc15683fe51.1755258303.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
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
index 4013286bef04..280728cf78b9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -129,4 +129,6 @@ dochelp:
 	@echo
 	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
 	@echo
+	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
+	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
-- 
2.50.1


