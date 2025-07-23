Return-Path: <linux-kernel+bounces-742497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5BB0F26A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857931AA8162
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED26248F69;
	Wed, 23 Jul 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDhmv4d0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6726C3BD;
	Wed, 23 Jul 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274324; cv=none; b=Obnm97g/iohfRe3FxRJPb1L/07l5hKGV1Zwa80ejxshfgF/+wdbcwxLF2a2VCmBdl7Fo6BEIiiPoHkuSZQAmBlsWjsswqkMQfU1xCpwz4TdGpbZppg/pOBY1GmlvvIkBucikl2u6orUWjuJOkgqAB+pqBAMQPJf/RaeLFcLQL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274324; c=relaxed/simple;
	bh=OrTb+KcHqT4ajdsH1ypK8FaKVkgJa8ksvVRgB8HRm9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fQ91SoOF2r1pSRvvvAtLAL/P62/WNObPc9h0ZAqAJiYLo59ioqaf3EOl6Fm4gWP6iIq9rIJcmX75yZ1DCCz2c81fC/P7GDgDOubJA/9M8BvzXpSTSnuOLZrc79xm393s3QLQbEBSMy16cZSwih6kDUl4pIpz2K8TcXgS/Ar9qlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDhmv4d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D940C4CEE7;
	Wed, 23 Jul 2025 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753274322;
	bh=OrTb+KcHqT4ajdsH1ypK8FaKVkgJa8ksvVRgB8HRm9Q=;
	h=From:Date:Subject:To:Cc:From;
	b=RDhmv4d0mUWTFu/k6l+UgHLvejZEHBBcCvuOIo8nKodYeCvy+R8vxIiOVsm1q5JOQ
	 UsrRTEdNNtnDr9n1eqkSUf95LHjki0r7NChsEJc37EiZPy3FZaXpOp1USxa78ZVWv0
	 tuyMocSaFBl7WcHl3c/07K9XCpnUq66Esftj/19hyYg68nLgz5Xp9QwZMsSCjS1E0N
	 5x0RUI3Igu7319Us20lfGHASKXT91o9pSK2yUANHXbKAU3KGRHreHXiuXbYKbbU2WU
	 ErW0ksZ+wacNF9oO4SiESQeC7UcafWUVHrfIo/8BWzh4d9dAcYVlXHWEwqxu05EHoB
	 QBF5TpoFQ+Wog==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Jul 2025 13:27:45 +0100
Subject: [PATCH] arm64/sme: Drop inaccurate documentation of streaming mode
 switches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-arm64-sme-mode-switch-doc-v1-1-702bb484b4f4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEDVgGgC/x3MQQ6CMBBG4auQWTMJTIsar0JcYPsjsyg1HaMmh
 LvTsPwW721kKAqje7NRwVdN81rRtw2FZVpfYI3VJJ0M3VWEp5Iuni2BU45g++knLBxz4Bt6J97
 5p0ek2r8LZv2f7/Gx7wfH5ah4awAAAA==
X-Change-ID: 20250722-arm64-sme-mode-switch-doc-8e132434b4ed
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OrTb+KcHqT4ajdsH1ypK8FaKVkgJa8ksvVRgB8HRm9Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBogNfQPuSRx5nolzVnWzO3f5C+iSWPt1ou4zVoV
 QuR7n/k3ZGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaIDX0AAKCRAk1otyXVSH
 0MvbB/oDMKFjJJgkmKz5aDIP9D9olw3VGOkisOZtq2L19yAa9LIBaPWqfS+u9NiffrlmpSi2adO
 Ome5zhPsryc5XH/0b+eDJIcu/BaqhePrwNg2u0IlIwjm4Wn3YrtR3cN+HjuobeHawVeLM48T5jS
 J2GPCXLn2yG81L7/hWfPqXfIqyEqUTYq6EmojjpfL9OKelTZi9MDwI2Bil9NC1I/WwQ+3vOXXho
 wajoW9rC37ZFRdXv0bzPkeZ01YcPaqUH1gaJAt9yMwhHkeHnil5+omwXdskK809wqSe2SypOlzh
 YyUqU4VVrdPAXYbic0RXO4NhuMJ7tIPmfvqvq3NNQtAhZnT7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The SME ABI documentation contains an inaccurate description of the
architectural streaming mode entry/exit behaviour, just remove it since
this is better documented by the architecture or with the rest of the
documentation for the specific software interfaces concerned.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
The rest of the documentation needs more thorough review, but it seems
wise to remove the incorrect statement to avoid confusion.
---
 Documentation/arch/arm64/sme.rst | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
index 4cb38330e704..583f2ee9cb97 100644
--- a/Documentation/arch/arm64/sme.rst
+++ b/Documentation/arch/arm64/sme.rst
@@ -81,17 +81,7 @@ The ZA matrix is square with each side having as many bytes as a streaming
 mode SVE vector.
 
 
-3.  Sharing of streaming and non-streaming mode SVE state
----------------------------------------------------------
-
-It is implementation defined which if any parts of the SVE state are shared
-between streaming and non-streaming modes.  When switching between modes
-via software interfaces such as ptrace if no register content is provided as
-part of switching no state will be assumed to be shared and everything will
-be zeroed.
-
-
-4.  System call behaviour
+3.  System call behaviour
 -------------------------
 
 * On syscall PSTATE.ZA is preserved, if PSTATE.ZA==1 then the contents of the
@@ -112,7 +102,7 @@ be zeroed.
   exceptions for execve() described in section 6.
 
 
-5.  Signal handling
+4.  Signal handling
 -------------------
 
 * Signal handlers are invoked with PSTATE.SM=0, PSTATE.ZA=0, and TPIDR2_EL0=0.

---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250722-arm64-sme-mode-switch-doc-8e132434b4ed

Best regards,
--  
Mark Brown <broonie@kernel.org>


