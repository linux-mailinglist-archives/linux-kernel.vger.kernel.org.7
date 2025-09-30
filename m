Return-Path: <linux-kernel+bounces-837229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD56BABBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C53A439D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7902BEC2D;
	Tue, 30 Sep 2025 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e24a7szX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e24a7szX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4B2BE037
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215885; cv=none; b=C2jLrToCq7biAhCGBjPYS0qCXf6fWVe713AW6EGG8Y2iewQ46GFhwOPatyzG1ybqwktzZoG4q2UwB6dJ/fpllkYk/6vuVmLKR+sgPYz8gOCflJbWtBW2puZHBRefgmZY4yRHT7TzLHXI+rnkwJuNdTBeQpwqHxQ9RDrqH/hSgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215885; c=relaxed/simple;
	bh=DURkwRke2cx9nsvZCjdaKHO//XZ8sDlKFa/gLDLWIwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4hijDYIkjYL4Dd87AAq4oDFV+8Mv0tLpK6eVzCZSgJ8bS/QzRRY9pp9cszf2BlVyo1O3KVxEwMvm/Vj541l1U2BUl7s9t7WagFaD3DR/FxsjU/PjazZlwVxqVTCLuOKwk8e4uUigghFRmpvBj2YC8ByD3w+dlzWcQOR1stKghg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e24a7szX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e24a7szX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AEC11F449;
	Tue, 30 Sep 2025 07:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54W/P7dmPqvd6kdIyWRFWs72NWtxPZWW/Zs0TK1TxK4=;
	b=e24a7szXrQZrO7uLgKABySpfC0o/tYBudz39agRCJCF4vlvEnLXyiHhyTJuN56cKWCJbBA
	bj4kYfxAJxzMZjPKYD/SxC/6ER+O4DFCpcWiAtEy0t7wjYuOkcad/WgVBpgVfLFYOiAGKr
	jOkx1nK3Z/cn4ZtZK1r/wK7Trn85cBI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759215881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54W/P7dmPqvd6kdIyWRFWs72NWtxPZWW/Zs0TK1TxK4=;
	b=e24a7szXrQZrO7uLgKABySpfC0o/tYBudz39agRCJCF4vlvEnLXyiHhyTJuN56cKWCJbBA
	bj4kYfxAJxzMZjPKYD/SxC/6ER+O4DFCpcWiAtEy0t7wjYuOkcad/WgVBpgVfLFYOiAGKr
	jOkx1nK3Z/cn4ZtZK1r/wK7Trn85cBI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20ABD13A3F;
	Tue, 30 Sep 2025 07:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vF9dBgmB22i3RwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 30 Sep 2025 07:04:41 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 07/12] x86/opcode: Add immediate form MSR instructions
Date: Tue, 30 Sep 2025 09:03:51 +0200
Message-ID: <20250930070356.30695-8-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930070356.30695-1-jgross@suse.com>
References: <20250930070356.30695-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

From: "Xin Li (Intel)" <xin@zytor.com>

Add the instruction opcodes used by the immediate form WRMSRNS/RDMSR
to x86-opcode-map.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch, taken from the RFC v2 MSR refactor series by Xin Li
---
 arch/x86/lib/x86-opcode-map.txt       | 5 +++--
 tools/arch/x86/lib/x86-opcode-map.txt | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 262f7ca1fb95..65aeb18ad22d 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -839,7 +839,7 @@ f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
 f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSSD/Q My,Gy (66)
-f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy
+f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy | RDMSR Rq,Gq (F2),(11B) | WRMSRNS Gq,Rq (F3),(11B)
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3) | URDMSR Rq,Gq (F2),(11B) | UWRMSR Gq,Rq (F3),(11B)
 f9: MOVDIRI My,Gy
@@ -1014,7 +1014,7 @@ f1: CRC32 Gy,Ey (es) | CRC32 Gy,Ey (66),(es) | INVVPID Gy,Mdq (F3),(ev)
 f2: INVPCID Gy,Mdq (F3),(ev)
 f4: TZCNT Gv,Ev (es) | TZCNT Gv,Ev (66),(es)
 f5: LZCNT Gv,Ev (es) | LZCNT Gv,Ev (66),(es)
-f6: Grp3_1 Eb (1A),(ev)
+f6: Grp3_1 Eb (1A),(ev) | RDMSR Rq,Gq (F2),(11B),(ev) | WRMSRNS Gq,Rq (F3),(11B),(ev)
 f7: Grp3_2 Ev (1A),(es)
 f8: MOVDIR64B Gv,Mdqq (66),(ev) | ENQCMD Gv,Mdqq (F2),(ev) | ENQCMDS Gv,Mdqq (F3),(ev) | URDMSR Rq,Gq (F2),(11B),(ev) | UWRMSR Gq,Rq (F3),(11B),(ev)
 f9: MOVDIRI My,Gy (ev)
@@ -1103,6 +1103,7 @@ EndTable
 Table: VEX map 7
 Referrer:
 AVXcode: 7
+f6: RDMSR Rq,Id (F2),(v1),(11B) | WRMSRNS Id,Rq (F3),(v1),(11B)
 f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
 EndTable
 
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 262f7ca1fb95..65aeb18ad22d 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -839,7 +839,7 @@ f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
 f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v) | WRUSSD/Q My,Gy (66)
-f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy
+f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v) | WRSSD/Q My,Gy | RDMSR Rq,Gq (F2),(11B) | WRMSRNS Gq,Rq (F3),(11B)
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3) | URDMSR Rq,Gq (F2),(11B) | UWRMSR Gq,Rq (F3),(11B)
 f9: MOVDIRI My,Gy
@@ -1014,7 +1014,7 @@ f1: CRC32 Gy,Ey (es) | CRC32 Gy,Ey (66),(es) | INVVPID Gy,Mdq (F3),(ev)
 f2: INVPCID Gy,Mdq (F3),(ev)
 f4: TZCNT Gv,Ev (es) | TZCNT Gv,Ev (66),(es)
 f5: LZCNT Gv,Ev (es) | LZCNT Gv,Ev (66),(es)
-f6: Grp3_1 Eb (1A),(ev)
+f6: Grp3_1 Eb (1A),(ev) | RDMSR Rq,Gq (F2),(11B),(ev) | WRMSRNS Gq,Rq (F3),(11B),(ev)
 f7: Grp3_2 Ev (1A),(es)
 f8: MOVDIR64B Gv,Mdqq (66),(ev) | ENQCMD Gv,Mdqq (F2),(ev) | ENQCMDS Gv,Mdqq (F3),(ev) | URDMSR Rq,Gq (F2),(11B),(ev) | UWRMSR Gq,Rq (F3),(11B),(ev)
 f9: MOVDIRI My,Gy (ev)
@@ -1103,6 +1103,7 @@ EndTable
 Table: VEX map 7
 Referrer:
 AVXcode: 7
+f6: RDMSR Rq,Id (F2),(v1),(11B) | WRMSRNS Id,Rq (F3),(v1),(11B)
 f8: URDMSR Rq,Id (F2),(v1),(11B) | UWRMSR Id,Rq (F3),(v1),(11B)
 EndTable
 
-- 
2.51.0


