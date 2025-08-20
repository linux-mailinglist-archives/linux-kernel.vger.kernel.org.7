Return-Path: <linux-kernel+bounces-778428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7AB2E58E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15C57AF09E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D028000F;
	Wed, 20 Aug 2025 19:27:01 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851FF2745E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718021; cv=none; b=R7hB8EilvlWd3BVfYkImarcQdH1nC1Mbf6A4eGMtpiTufHjaiPxSden/MoqWvL6uEq6x2WFoQE0syajOMlugwAE43KaR4UYX8zsGaQCe803l+WLQboKmRgyue2bP2DZmx5f8CiHbt2C4L1/0LzY0ATHHZYw34WP/w7Hgr6cw5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718021; c=relaxed/simple;
	bh=xyq0Dp3HRh7ATOR1pyN2mAmipO3/neYtIPWcRyZr4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TD/VHbXGM5Cc/BlIBbayyY166VNPeh7Kb1FwOU//ul/i0/BtUq6IxoQsYH9WwFQqZ6wvw480vzQKkt9U96U5W8z/ErwjHWt7x/ceABbsPSQRfxA8faXrKd/beBbvHinR2BmSMBztjuKCw+F+JPlqTN4pqX/1GsUjb0ZXFkIDPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 86EC4C065B;
	Wed, 20 Aug 2025 19:20:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 5091241;
	Wed, 20 Aug 2025 19:20:52 +0000 (UTC)
Date: Wed, 20 Aug 2025 15:20:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] x86: Make x86@kernel.org a list and not a maintainer
Message-ID: <20250820152054.165811ea@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5531o166h3xgifcer8zoewqszq4qfju8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5091241
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SnaqR9TjHoQMrkc4dfE8yK3xOjRAIvgw=
X-HE-Tag: 1755717652-897922
X-HE-Meta: U2FsdGVkX1+nvverwD4m6Nli3dq/rHvVvJrhUyfrcIWA1vkfCQdsDQ6O32TFuXDwleSs25L3obiGPtGWElVKEc2RPVLnKdvSU/DmecZ/qBOdO/Mqp19lnu4AOfWCXabb6YhRZARLZNUVuRx5g/BrbE+CZrxn2ioBdd6ZKSV4WZUzIER4OtAZ021LxE/I5cDVk+lXCgjQmCDdLECSvk5Los4L0xllKnFet41tFZgpj8D0pMbefiA8NQXAl689T1XbbP9eIeQEgSYGzZkS1s9+oIIhA8sbrcBMUeJ6TBLvw6+tnGUIMbMUbuTu/cLVaDKxXXBFnHD0QXWYqhLlNvOGXcy5Uu/vxt7ozOO6albCAqkzmZ0+qG+DJUSya9mEy0r0Sy093SgCa9IjqLSSDi05EJhGue275pHnE4sCQQS3Uojx3RVE4/Fvedg7jZYbZu2AsnJ+FuSYo8Ae33uIEFXHnoVVWpcRtREzrc5bOVE1NHbLoyGGANzttaYi9VZTt774+QrSTRFMqtp16YjNMk0AEdWYGgUNOFrwIEtO2rA9IUzcsIubVdNgEjjmPPw6qY2wC1oGwWPJ3ssuKfUruZKzyA==

From: Steven Rostedt <rostedt@goodmis.org>

In the MAINTAINERS file, x86@kernel.org is listed as both:

 M: x86@kernel.org

and

 L: x86@kernel.org

The MAINTAINERS document starts with:

        M: *Mail* patches to: FullName <address@domain>
	[..]
        L: *Mailing list* that is relevant to this area

As 'M' is for a maintainer with a "FullName", that would hopefully be a
person (but who knows? Maybe in the future it will be AI!), whereas 'L' is
for a mailing list. Assuming that x86@kernel.org goes to a list of people
and is not someone named 'x86' (One of Elon's children?), make the
MAINTAINERS file consistent and have x86@kernel.org all be labeled as 'L'.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..04e94562c0aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12206,7 +12206,7 @@ F:	drivers/scsi/isci/
 
 INTEL CPU family model numbers
 M:	Tony Luck <tony.luck@intel.com>
-M:	x86@kernel.org
+L:	x86@kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/include/asm/intel-family.h
@@ -27223,8 +27223,8 @@ M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Borislav Petkov <bp@alien8.de>
 M:	Dave Hansen <dave.hansen@linux.intel.com>
-M:	x86@kernel.org
 R:	"H. Peter Anvin" <hpa@zytor.com>
+L:	x86@kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
@@ -27236,8 +27236,8 @@ F:	tools/testing/selftests/x86
 X86 CPUID DATABASE
 M:	Borislav Petkov <bp@alien8.de>
 M:	Thomas Gleixner <tglx@linutronix.de>
-M:	x86@kernel.org
 R:	Ahmed S. Darwish <darwi@linutronix.de>
+L:	x86@kernel.org
 L:	x86-cpuid@lists.linux.dev
 S:	Maintained
 W:	https://x86-cpuid.org
-- 
2.50.1


