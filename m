Return-Path: <linux-kernel+bounces-750009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10280B155D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3F43B7781
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1A285418;
	Tue, 29 Jul 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIQvXo2P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7E2905;
	Tue, 29 Jul 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831106; cv=none; b=pw7tjNOeYWx9ssilKNg6BAE3Y8brucIsrQ7xhJ9A9lsVDHLWkFm5jPAeyJPknxYFLtVnjFlxMuNiJbvr7w4bD4CILYEzTiQNlqOHncsX6W6Xz0gqa6X3T31/4+7RA7kkPimYjVf6mHUpIO60SeR4v+Ptqtoqai9osJ6YCiH30f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831106; c=relaxed/simple;
	bh=kHibng5QQzPxPxIVLy8D5Syie53OoQVsjHdm5Mk3nn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h1jRhr2eprBUnp+Ca3nUPRZe+KvFf6LpDGNxSVn3ODMwArQPpjKh2X96qZLTz8dRlvUAj/bJh/0hURCFnpeRBLylETHx4hEP/4WO5hh9X9POBRC8TKHifoqO50uCi3+Sr4GJxcSIhOBQPqHYbn1/5cRQCS2Bbs28ftHNEoeczSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIQvXo2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F098C4CEEF;
	Tue, 29 Jul 2025 23:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831106;
	bh=kHibng5QQzPxPxIVLy8D5Syie53OoQVsjHdm5Mk3nn4=;
	h=From:To:Cc:Subject:Date:From;
	b=rIQvXo2PpxZ4GAsiOsNugJHh9lUkb0/vBcPp3TQP+tkIpIySa0v1hzA7qPJMXTX5b
	 GVFBivXhf/RHq6J5pcy9XAkxX0jA68G44h/0MBd7t69rLjVAEOrCP0u/PUYHNnW7st
	 QTeDNFC6zqD99Kht8fBdpXAAmcD9Fd7q4ImE2TNeYn1n8wrQT318IxCGUhNlnlndvm
	 mMf5dp9EO2n50KRtRisOSmn+7IY1BRu4HeUCKjit90rrc6NveYT/2HDgMy2bu1g1PY
	 ARuYwlHVW0Me5sXQf8JjfSmIgmXIC1+DRQQR4fQ5N1DWzEKWA7c/Wb9wDo/8wc3yz0
	 yZx7zIQx/oH1g==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Fix incorrect reporting of read buffer size
Date: Tue, 29 Jul 2025 16:18:25 -0700
Message-Id: <20250729231817.work.023-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=kees@kernel.org; h=from:subject:message-id; bh=kHibng5QQzPxPxIVLy8D5Syie53OoQVsjHdm5Mk3nn4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmdYQcCbPbsPNjWdNTGw36GnnX0XqEeC2bRg5NVp1y6t 5Jrl/qejlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIm8SWJkODNbw5KxWdDvmftq BqlTYbLfjwp2Vnfw3ftprWbqXn2shuGv2Mb35v4zCg9ffCpVmT71LvdtO+tJ7NeLDVe92GlwbqI yCwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When FORTIFY_SOURCE reports about a run-time buffer overread, the wrong
buffer size was being shown in the error message. (The bounds checking
was correct.)

Fixes: 3d965b33e40d ("fortify: Improve buffer overflow reporting")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: <linux-hardening@vger.kernel.org>
---
 include/linux/fortify-string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index e4ce1cae03bf..b3b53f8c1b28 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -596,7 +596,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	if (p_size != SIZE_MAX && p_size < size)
 		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
 	else if (q_size != SIZE_MAX && q_size < size)
-		fortify_panic(func, FORTIFY_READ, p_size, size, true);
+		fortify_panic(func, FORTIFY_READ, q_size, size, true);
 
 	/*
 	 * Warn when writing beyond destination field size.
-- 
2.34.1


