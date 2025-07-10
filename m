Return-Path: <linux-kernel+bounces-725984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983FB00641
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF503A8F00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DB7272E57;
	Thu, 10 Jul 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PAU66A2V"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB602F56
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160646; cv=none; b=eXJrpYrMiuowBqadyeGXXpmNLJKnPewW5stlvguMwWVoYa4vqCwVlcjtJgr5M4Svl29BBvYjniMMDTNmzrVEQuov0lmWI+o0LuFF5oVrRm/lfdVKJ6xXQROkKyXsD7cWf/31Iy67bkxf/Sy+CCv5h/MH3+Ka0QnxQNSzKRecJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160646; c=relaxed/simple;
	bh=PmLNRRqqfi+6nUAh8sDWXo0YvlyTgCdrC6js2PxgPaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCLFk+8KotUMSN33IfJhMdm6ohNj6X18UVXQ9mXkwMv/SRQbh0jIikkWAK4Ta91BZhma3IfJGQmktMB1PwN5RIMOQu5vIOwbNNzMwykLwn336AMnr9pgwrEFBdjBvyPeE9gwGjb4X7R9rtdPYXF1pcjQOWi2SSQkZf5jFYmDGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PAU66A2V; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 80AC740E0218;
	Thu, 10 Jul 2025 15:17:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KQ_WOBrk3L96; Thu, 10 Jul 2025 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752160638; bh=LnxUmCf47hqiBieumciAui5/Q+y16ggub1NBhnpTlPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAU66A2VU1wU/8qGKbYoJUW2HlLw5/ICbsOZfnHI0T1hKdgHHf6VkhK/0msyYpXUO
	 G/jN9kfkgiUMXqV6eB7FJ+Zh8q0lzgnrYvoiQW34ap5P9Dpi5HmDPL7kXSqGulXOsR
	 yNhTeuS+XmYHDngtIyd5RimMEhppT3E1BDr7rV1gJiDG6Ik7cTboCTEMK+ib8xtGNL
	 DBM7b77j06bFO6pE+QwbkSOz9A+avacHhEVG6b4x0oIGlBOK2i12j2hj+E6N0PUfdd
	 bNRqFwtOVeyLOKUlog5xsctHLmeWVwXHTEA44oT7CRuiXc3W9LbXDifrp594wMSiRh
	 6FcdQIB41G8wkhDEkq4UwdKXUBnrwik0EBf9giVjAuae0ghvsaYbGbr4BT4BGSkj1R
	 ncMNZJkfhglWqZirivQhgxS9luO0RmHPrCYJDpKGISlqA6ndbwGxXh6vo9Tm04DaWW
	 liTmJ7CJAs7345IU2a6GTj+vVoWJRkt98tXx0tgYRhpzesdYkcCXNpaNTZAF0u8vgO
	 mxm9UJ80Z8wmwH/0+6Woy8hTslSQ+mC2aTAlzlG/sAmUCYuZkjDAD3R0948loxNB7m
	 nYAAyiRUyWRvP5fmRY3gmOIMuR88Slb5/OWz6r8c1LlVKc7jXFq+KegflDVhI1tHid
	 4w30yuqNK73Na3wVUWZkt7kA=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F150140E01FC;
	Thu, 10 Jul 2025 15:17:07 +0000 (UTC)
Date: Thu, 10 Jul 2025 17:17:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/21] cpu: Define attack vectors
Message-ID: <20250710151702.GCaG_Zbjo1sqZ6NB2g@fat_crate.local>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
 <20250707183316.1349127-3-david.kaplan@amd.com>
 <20250710104252.GBaG-ZLG7p_LsNCjBm@fat_crate.local>
 <LV3PR12MB9265E7C013D6BBA5E6FB586C9448A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265E7C013D6BBA5E6FB586C9448A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Jul 10, 2025 at 02:02:56PM +0000, Kaplan, David wrote:
> Interesting.  I would suggest a comma instead, so you have things like
> "mitigations=auto,no_user_kernel".  That's somewhat consistent with the
> existing 'auto,nosmt' option as well.

Ack, see below.

> Still you would have global options come first, and then the attack vector
> options.  But since commas are already used to separate tokens, that seems
> cleaner to me.
> 
> If you're going to edit the patch directly, just please remember to update
> the documentation file accordingly too.

Yeah, and the commit messages. 

This is just the patche(es), I'll go over the commit messages too.

---

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
index ee56e849616f..b4de16f5ec44 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -137,7 +137,7 @@ or more options to disable various attack vectors.
 
 Format:
 	| ``mitigations=[global]``
-	| ``mitigations=[global];[attack vectors]``
+	| ``mitigations=[global],[attack vectors]``
 
 Global options:
 
@@ -166,17 +166,17 @@ the global option is not specified, it defaults to 'auto'.  The global option
 'off' is equivalent to disabling all attack vectors.
 
 Examples:
-	| ``mitigations=auto;no_user_kernel``
+	| ``mitigations=auto,no_user_kernel``
 
 	Enable all attack vectors except user-to-kernel.  Partial cross-thread
 	mitigations.
 
-	| ``mitigations=auto,nosmt;no_guest_host,no_guest_guest``
+	| ``mitigations=auto,nosmt,no_guest_host,no_guest_guest``
 
 	Enable all attack vectors and cross-thread mitigations except for
 	guest-to-host and guest-to-guest mitigations.
 
-	| ``mitigations=;no_cross_thread``
+	| ``mitigations=,no_cross_thread``
 
 	Enable all attack vectors but not cross-thread mitigations.
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index be25543567c0..c976a6686d8b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3276,8 +3276,8 @@ static int __init mitigations_parse_cmdline(char *arg)
 	if (!*p)
 		return 0;
 
-	/* Attack vector controls may come after a ';' */
-	if (*p++ != ';' || !IS_ENABLED(CONFIG_ARCH_HAS_CPU_ATTACK_VECTORS)) {
+	/* Attack vector controls may come after the ',' */
+	if (*p++ != ',' || !IS_ENABLED(CONFIG_ARCH_HAS_CPU_ATTACK_VECTORS)) {
 		pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",	arg);
 		return 0;
 	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

