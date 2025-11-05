Return-Path: <linux-kernel+bounces-886245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A28C35136
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E6944E8890
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA462FFFB8;
	Wed,  5 Nov 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE37hOhQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB612EDD51
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338045; cv=none; b=ZSSwZ9KhCfpdD07NiIOOoCGgsowfu4hrGs0BSdjluxIqxTFYfEOeA3EXNFWrhLV0/imrkFZ9DDC0SqXjkXx+5tv6FvmzhqVktt9py+ibPAga+G5ohMSF3f4TjA3k4c9neE4Cax3V2cXDySXJ5rqyA9wuA9bDQUyPe1EDb/td4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338045; c=relaxed/simple;
	bh=6FveslA51ZKW3pLjQVKvZG5cxo/vtJS7IwDZAhcHSHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+Zj5bvgec/kxxH/vf9bX6Ty4Tvr2gOQf38tum0r8qYGLtcfhZGmd/k1YFeQNpVD0Xn63uBtBQioZ1XQiuWM4l/POUuG1WAvdDEgGqxxX5eSYHBRRoplDoNSITi3kRM9uwHwwlLASX04liskSFZCNCXypeeUya3dOSDDHiN0xo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE37hOhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A592C4CEF8;
	Wed,  5 Nov 2025 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762338044;
	bh=6FveslA51ZKW3pLjQVKvZG5cxo/vtJS7IwDZAhcHSHU=;
	h=From:To:Cc:Subject:Date:From;
	b=WE37hOhQUGONWW1HuZkGx/QwivLViWcVBLBYY7/qI62GihtTnJ9iPrGkLCmPvhzzh
	 26BHCN7CVQSdC7Yoh5rvDVmfRgel3Ue4Kcmnq6ouHGs3jqTLiwSy6lx05mC/VczSH8
	 xS5KKvCDr3xEu501VMCArrdxnIExC5RMIjJaX6A5dTz2tIpTBrTr3vCxi/Klqcn7g6
	 PlK6acReLoZ9lL69NZfkqaPajZjqyKKkMi0cyrqkUxa7vbZrRwZZmMRQfdNkxC4Y8d
	 9gEvPs3K28qPrsaIfWmSofFO669wrl33Ul+L0+nXvdEHJWFCBTOMlgScd72ALGmGVi
	 n9cBKMI/WK3EQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add myself as a reviewer for KHO
Date: Wed,  5 Nov 2025 11:20:19 +0100
Message-ID: <20251105102022.18798-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have been reviewing most patches for KHO already, and it is easier to
spot them if I am directly in Cc.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ee7cb5fe838f..3c85bb0e381fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13789,6 +13789,7 @@ KEXEC HANDOVER (KHO)
 M:	Alexander Graf <graf@amazon.com>
 M:	Mike Rapoport <rppt@kernel.org>
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+R:	Pratyush Yadav <pratyush@kernel.org>
 L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained

base-commit: d25eefc46daf21bd1ebbc699f0ffd7fe11d92296
-- 
2.47.3


