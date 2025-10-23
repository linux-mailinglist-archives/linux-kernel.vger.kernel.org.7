Return-Path: <linux-kernel+bounces-866962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3CFC01343
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DCC189B738
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C288527E1D7;
	Thu, 23 Oct 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPmwVnmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFEF219E8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223594; cv=none; b=m/DncoLpg00MlQg253rGoXyViAq//98e33stlcIBRX/h12dxLIWjTqTpXmdh86cdsdwMECC9+qFoF46cvlz3+43wtCa3qqXs5pAODWvBblktblwEaszu/IVX3tTRAlRQJp/aX7NTfkMAef8FzOzkKfkmZskpxLKk6tTMw8PYvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223594; c=relaxed/simple;
	bh=DFEDw9V38UP3Bs6hX39P0fGR/xMwmTioMP+51jWrgck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+SFoYdN88Mr3GPGaAef8n89RzF4guBvH0hDqWZFedYp1sPLls0Rmoh77kObXadMseCtXZuRg88COwRGBlfyk2O39TQ3sg5JCFlVPB/579Fg/0eXuzZx5eRE+xZIDdkV3wEVuzPFCLA9lLhpnW4r/Ad2a1NA4trs2LcEwt2eofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPmwVnmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2450C4CEF7;
	Thu, 23 Oct 2025 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761223593;
	bh=DFEDw9V38UP3Bs6hX39P0fGR/xMwmTioMP+51jWrgck=;
	h=From:To:Cc:Subject:Date:From;
	b=oPmwVnmgTYzISULpyoj5DppAAn+4dav+Mu3A+v7JVZBI3bKtQxyCzDhXYfJByGMNA
	 cIBuY5jTyd9H0saaNf4ezrtwFGp69siRpP97akz/R9b4OsK9g0fGZPbbvjIdcypOx8
	 aA1TVLKkv/61ImzdmmVbbmfPfp3YyicO3JP32fx2y6bkihczwwRv/62cNhKtFpsTNn
	 0Upzel2GKEBqLjINJTDH5KkSDoqQwW5peWufz86rrQZVpV3y6FR6pwgGFyKvYPlMiP
	 GsG3Wfk7FFx9sUnCzaLxVfh7EVHJCxlxl+IQNBpwLoyoYhejTBazCYR7J06eGWnZzG
	 PAwjndzG9ZuXw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/microcode/AMD: Limit Entrysign signature checking to known generations
Date: Thu, 23 Oct 2025 14:46:29 +0200
Message-ID: <20251023124629.5385-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Limit Entrysign sha256 signature checking to CPUs in the range Zen1-Zen5.

X86_BUG cannot be used here because the loading on the BSP happens way
too early, before the cpufeatures machinery has been set up.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index cdce885e2fd5..2a251de66b9d 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -233,13 +233,31 @@ static bool need_sha_check(u32 cur_rev)
 	return true;
 }
 
+static bool cpu_has_entrysign(void)
+{
+	unsigned int fam   = x86_family(bsp_cpuid_1_eax);
+	unsigned int model = x86_model(bsp_cpuid_1_eax);
+
+	if (fam == 0x17)
+		return true;
+
+	if (fam == 0x19) {
+		if (model <= 0x2f ||
+		    (0x40 <= model && model <= 0x4f) ||
+		    (0x60 <= model && model <= 0x6f))
+			return true;
+	}
+
+	return false;
+}
+
 static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, unsigned int len)
 {
 	struct patch_digest *pd = NULL;
 	u8 digest[SHA256_DIGEST_SIZE];
 	int i;
 
-	if (x86_family(bsp_cpuid_1_eax) < 0x17)
+	if (!cpu_has_entrysign())
 		return true;
 
 	if (!need_sha_check(cur_rev))
-- 
2.51.0


