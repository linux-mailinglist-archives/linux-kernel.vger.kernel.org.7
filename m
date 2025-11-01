Return-Path: <linux-kernel+bounces-881145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E287AC278F0
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4516E34ABA2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3A291864;
	Sat,  1 Nov 2025 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eciKR2Aa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428401F5437
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761980896; cv=none; b=Zj+yufUwNFDAwDUiyxVMdmpFO8dNmA5kEsoZjIciHiVyfMCWz46+VdLBlYdrLvY0lwSy/uEYyq93Xf1BfFK12fTRERKJTLm0UiksChBxSKAl/CQGMi0rFmMNf3p2wUxBPyZdJ9+Bc4OTZBkKitq+SgZWDgh4Y0Br6rjYQC0TM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761980896; c=relaxed/simple;
	bh=r/HRc629upvC0xAdYlECT/0WYKa/1Of0NCfqkbvL840=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pZPzOzKA4FlpyqlMkEKwmt0HQ5NEVwICeRlq2lq0iuHDzrvmsYjB44Nkev/7LMZA/8vdBX8o9zy28bl7Oox8hGcwnUQAVkzX0I8k/PlN5w7a7BJl3ahl/D19mgCQl6/IYfgHCuOtqV5FGOwYzCswwG9lD5fX/DktQv41RUKddv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eciKR2Aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0D1C4CEF1;
	Sat,  1 Nov 2025 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761980895;
	bh=r/HRc629upvC0xAdYlECT/0WYKa/1Of0NCfqkbvL840=;
	h=Date:From:To:Cc:Subject:From;
	b=eciKR2AaQu5TeoqwFJeoGd2387iE2tjYPj3d49lUtyrVSCbh2bzkIwYB7DYLp+dnT
	 OQboYJQGRSs5XM7FnJU7/3N3KbkvHIuJ8SWAJirGre14AvKJ8w/v2sbHuvpviGC8CH
	 i2b8DXPEt+4pzFE5jtyK4fIomnUyOxKIExzxxWlEJL2BbcgwwiicnJ+ZOGUIa2APYF
	 pRCNhQRvdmYtRlJ7Gs/9CHrLe1GG3Qu/TfFq7kOveDZBuIU1DMLXD5iP+EORV2strM
	 vpZI3XsfVMZq/IMVlkjasVoaaWOceSADP/qeeMQnQ8B+a9bHnMRKQvTkQnACUxaL0I
	 6yM22XXsAGaVA==
Date: Sat, 1 Nov 2025 08:08:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool fix
Message-ID: <aQWx2XlYJY-pnVLj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest objtool/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2025-11-01

   # HEAD: c44b4b9eeb71f5b0b617abf6fd66d1ef0aab6200 objtool: Fix skip_alt_group() for non-alternative STAC/CLAC

Fix objtool warning when faced with raw STAC/CLAC instructions.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (1):
      objtool: Fix skip_alt_group() for non-alternative STAC/CLAC


 tools/objtool/check.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 620854fdaaf6..9004fbc06769 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3516,8 +3516,11 @@ static bool skip_alt_group(struct instruction *insn)
 {
 	struct instruction *alt_insn = insn->alts ? insn->alts->insn : NULL;
 
+	if (!insn->alt_group)
+		return false;
+
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
-	if (insn->alt_group && insn->alt_group->ignore)
+	if (insn->alt_group->ignore)
 		return true;
 
 	/*

