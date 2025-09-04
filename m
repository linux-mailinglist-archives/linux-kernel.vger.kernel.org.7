Return-Path: <linux-kernel+bounces-801561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B5B446A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29AE585CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FC2727F5;
	Thu,  4 Sep 2025 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh9I5D1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559726E153
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014991; cv=none; b=JZtfZASvyfcXQay17EE3RcVQFgq0LuRXPlBbb2tklgfQ4F3UBL8DewtidqmJPXf3FBtogSCFVIWACnvKRdZrqlrslhSKLpP59TzGIz8+bCEOXbxj2iFe7+HCRe+7/i+Dcvyz9id5H4X/8+0LTCSCBrNt+uaapK7iFdpJGVQxfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014991; c=relaxed/simple;
	bh=EgcCdoVY7H5eM6LGqMKfnYcO9qd48zOeMmaW+lVEsGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPqm2dJxexv8r/NHSEAalfjzsObbq9RxtqdmEtv6Z/mWZHFcrdJq13FurjDjfp+Nt71+mOS/818w5eJPZF69bxfnMlvtQaIzYAsrqW1RZtIsCseTllqmcJ8n7P24R7txcf5JiYO9HCzCbqT/do/A/UUKjQFWO6d4irfjxQ8c6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh9I5D1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDDAC4CEF0;
	Thu,  4 Sep 2025 19:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757014990;
	bh=EgcCdoVY7H5eM6LGqMKfnYcO9qd48zOeMmaW+lVEsGg=;
	h=From:To:Cc:Subject:Date:From;
	b=uh9I5D1/y3ZWigmWW9560supzi1UOyRXNSm1X89sHlCZl5KMwv8OxE6PBoO72sETK
	 kroJAjNJlBGBSdQA+v8seSr2c2/tobbmMDkfpSUAoji2TGwj1ZjhvahdrktehBRkVX
	 CM5s0Xj1m4LLPJxQINokkKAOrRNdpH8rcYbegAEShzRHB7ywRNmxxqWYe5qVYFqmNR
	 AXrGkuW7xH5Nrb36EYKCVgW967Oz57l1KddFcMvDnbBtYBkch2y3J9GuFtsp183RYu
	 tNid5Dhj5iIQAlQYItkXSSJFnaM7EFkXGJVeOyA/fpYJwYfgNaAgO5jgO51ulqL9Bw
	 JHZYofIRqdH1Q==
From: Drew Fustini <fustini@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Drew Fustini <fustini@kernel.org>
Subject: [PATCH] MAINTAINERS: Add RISC-V T-HEAD SoC patchwork
Date: Thu,  4 Sep 2025 12:42:48 -0700
Message-Id: <20250904194247.82655-1-fustini@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add patchwork entry for RISC-V T-HEAD SoC support.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..9e0c149682f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21745,6 +21745,7 @@ M:	Guo Ren <guoren@kernel.org>
 M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
+Q:	https://patchwork.kernel.org/project/riscv-thead/list/
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
 F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
-- 
2.34.1


