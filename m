Return-Path: <linux-kernel+bounces-595892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B6A82432
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 14:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C386E1BA44DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4AB25EF8F;
	Wed,  9 Apr 2025 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kwkqhIdq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x5OQe6dr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8B25EF80;
	Wed,  9 Apr 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200301; cv=none; b=Tjcfqo83EAKQG887ga060iHzSxaIpOKzhgnXr+3tccUCuA/jugCnNYWFLgIE4iirCq7PAc8R2SyyU/wxZXr/GoWCCqF3bRzeU1tzm4JpAFXqYcIr8q2zeEb964po4gN2E5ArwXSvTeaJH9jYhmbaNYBBhDeSnDNXeKpr/dAzpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200301; c=relaxed/simple;
	bh=ce0FFNqWlVLeRmpKOWNjv2FdlSh6kWKIpb0LedlpZEY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OMkyWzpyKTNVD/NjDPGIhoY1ksCOmApzJ3Gm2JUxdpdKaRvGVoCBjdYRfGzC4IAGdrgQQ1ou68x/SGdLU05HNu61KRywZq/gu1vWG56L5S9ImGrOtI/uLQlojivHb7jqsr7nBF8FFfmGAnzC7sXrLyd7bbVLYZDpB5L/60oYPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kwkqhIdq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x5OQe6dr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 12:04:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744200298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNrAlN4hUGwH1wDNxfqz+gdRiqBA7UT39Qgw7OMeM4A=;
	b=kwkqhIdqyLfx869WYiv2P9CVINh7YLi/MImp9pTyuDfK0eMPil6N2AynRN+jgwckElqLc5
	Al2Dtdec0EG3kbLhJhqlnZmmhSetev2iiDXJ9q9VbErGc4YfjYoiVddxfUCUGUWFBYX8Ys
	A3aasYTZTMwrxQDEJ7Z9XUbmySag8PotWbDVGFheJInK0CmB6sl2klj1G4lKAWQSAOzbep
	JB2EmZb9RnSfqSyiSa2BZk34ihTWQLoYr4XdNx7qZ4sgs/l6Q6L31WE4Cyu5lz20oPPa+X
	jokuLSYN8HL5NFB/UKFA1IISCB6x1bYiX5KP75t3EstcTUOCDk7BTJPTnFA62g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744200298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNrAlN4hUGwH1wDNxfqz+gdRiqBA7UT39Qgw7OMeM4A=;
	b=x5OQe6drp6z8Ikn44e9QvKs0JRSu6agSC1vXvdIy4bnsgzzkp8d/FDtM/SQ9aEi8iLGGHZ
	IY8NFjTcFaH/MoCw==
From: "tip-bot2 for Naveen N Rao (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Documentation/x86: Update the naming of CPU
 features for /proc/cpuinfo
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409111341.GDZ_ZWZS4LckBcirLE@fat_crate.local>
References: <20250409111341.GDZ_ZWZS4LckBcirLE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174420029744.31282.15541458842057716608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     af76f7d57ee9a3be7b3840595ce3e2bdedd594a7
Gitweb:        https://git.kernel.org/tip/af76f7d57ee9a3be7b3840595ce3e2bdedd594a7
Author:        Naveen N Rao (AMD) <naveen@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 13:13:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 13:56:52 +02:00

Documentation/x86: Update the naming of CPU features for /proc/cpuinfo

Commit:

  78ce84b9e0a5 ("x86/cpufeatures: Flip the /proc/cpuinfo appearance logic")

changed how CPU feature names should be specified. Update document to
reflect the same.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250409111341.GDZ_ZWZS4LckBcirLE@fat_crate.local
---
 Documentation/arch/x86/cpuinfo.rst | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 6ef426a..7114f34 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -130,14 +130,18 @@ x86_cap/bug_flags[] arrays in kernel/cpu/capflags.c. The names in the
 resulting x86_cap/bug_flags[] are used to populate /proc/cpuinfo. The naming
 of flags in the x86_cap/bug_flags[] are as follows:
 
-a: The name of the flag is from the string in X86_FEATURE_<name> by default.
-----------------------------------------------------------------------------
-By default, the flag <name> in /proc/cpuinfo is extracted from the respective
-X86_FEATURE_<name> in cpufeatures.h. For example, the flag "avx2" is from
-X86_FEATURE_AVX2.
-
-b: The naming can be overridden.
---------------------------------
+a: Flags do not appear by default in /proc/cpuinfo
+--------------------------------------------------
+
+Feature flags are omitted by default from /proc/cpuinfo as it does not make
+sense for the feature to be exposed to userspace in most cases. For example,
+X86_FEATURE_ALWAYS is defined in cpufeatures.h but that flag is an internal
+kernel feature used in the alternative runtime patching functionality. So the
+flag does not appear in /proc/cpuinfo.
+
+b: Specify a flag name if absolutely needed
+-------------------------------------------
+
 If the comment on the line for the #define X86_FEATURE_* starts with a
 double-quote character (""), the string inside the double-quote characters
 will be the name of the flags. For example, the flag "sse4_1" comes from
@@ -148,14 +152,6 @@ needed. For instance, /proc/cpuinfo is a userspace interface and must remain
 constant. If, for some reason, the naming of X86_FEATURE_<name> changes, one
 shall override the new naming with the name already used in /proc/cpuinfo.
 
-c: The naming override can be "", which means it will not appear in /proc/cpuinfo.
-----------------------------------------------------------------------------------
-The feature shall be omitted from /proc/cpuinfo if it does not make sense for
-the feature to be exposed to userspace. For example, X86_FEATURE_ALWAYS is
-defined in cpufeatures.h but that flag is an internal kernel feature used
-in the alternative runtime patching functionality. So, its name is overridden
-with "". Its flag will not appear in /proc/cpuinfo.
-
 Flags are missing when one or more of these happen
 ==================================================
 

