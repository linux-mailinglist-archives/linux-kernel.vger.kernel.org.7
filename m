Return-Path: <linux-kernel+bounces-782133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028C3B31B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AD6B2534E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D34322A0C;
	Fri, 22 Aug 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzcnIl2n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7351311C12;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=c1KjvMo6O9WroKMXEpT1Ks/kqXLKjQq0vqzl6ggU1BTRtUlwJas8x3luDiXuNVEQsN6gYvxpZpovmc7oGPKPkWNGgXxtSsjX/Nvo2EVRn3BdjoioVP3UZhosEPTj6YwhiSt+7dID23xrRagjjYdMLlFAmENlfcjmd5Vk1ls8Iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=RsM+00sJ/1A8GHlMF3o/XgMw54KHkYT1Q+rNZSrXntI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK/MCVPFpRJHNzYLHUTfUl8Jm4L1IHH00Tg9wJeXP75bTMGAaOUEIwK02ok6jELETk2VN/yITOjdlvjjNZrJNAcg2jjfueoBG5umIW21yJJz1dQVJWdPgShQybu54MF8PbYDYFNVDawgzpoCcwNgrtcO5FWcBuDeRls8TXf5Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzcnIl2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20353C19424;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=RsM+00sJ/1A8GHlMF3o/XgMw54KHkYT1Q+rNZSrXntI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzcnIl2n8lSxnrpuxK5ZsmOjQFgBoyGiGSSc/CHbeXizoJKZbva+5Xo/63tYgL2xv
	 3uYkcgKWjmFKVaB7vOEU/mNsdqIUxZ5WT/z0bdvZ9DFl+MMUJdw9S5STLUeSIb6CVN
	 fITzBmJVKBHYemHCftxjGxWOtswLkVAvaJs8e1izCJNXerIPLF6Xsnb3Vnh4uwiBSL
	 Xf6H76jbXvp5soQqPPoduv9BL9Net6skrxhTWtMHuraszTLdDqo3dMJGmruE3r3zMl
	 Lmf1jMf8zfQeg6gbenmxSxBXoUXUvx9MkXd7igliRa+Y90NvXYPUK+FCSjkPhi49Lz
	 D26bZF03UPk5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrN-1LLz;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/24] MAINTAINERS: add files from tools/docs to documentation entry
Date: Fri, 22 Aug 2025 16:19:20 +0200
Message-ID: <87bbb94e442fe747e24f801d7685856b392b2568.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we now have a tools directory for docs, add it to its
corresponding entry.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dafc11712544..ef87548b8f88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7308,6 +7308,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	tools/docs/*
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
-- 
2.50.1


