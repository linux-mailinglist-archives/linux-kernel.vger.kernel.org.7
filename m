Return-Path: <linux-kernel+bounces-830609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D2B9A1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567B91B2080F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8A3054CB;
	Wed, 24 Sep 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fl6rh/Ys"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46453002CF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721653; cv=none; b=bVpM/1wWlABuFhps0J7MrvMP5prIlblhsOxdb5EBx4baj5b3rzkrYpBeqiUYN+6pr7RlEhalIzjYE7BJY9wPoNlqIrn3phE9xgi2vQxrSsIfePresddP6ZSH52cTR6Mas2v1nRQUKETEoXuHCu7uXFVwe7nXU9Oz0aLu699fsk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721653; c=relaxed/simple;
	bh=heasNeHH0aWYUhHAL48nCMzJ3G3G+c7phH/t2HC5htE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LGTsLQ/xu/pGYyfbuAc1YlAG470eB49jqHJcB3oBukv7vbvrceXgsNJISdKPQlQ5JQDKJlvXyM7xG8+8sJS3hrqDW92uTWcFDXDW38IzlQyJBRSl1IMpnRjzvoFDnnhNgx3YTbMlmOiub/CWxL7nutqZQlz42g4X5gsvvpnSHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fl6rh/Ys; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=r0SX4y0lRHKH3+P4hS9KFsvpxs6hjsZz/jLPnhf+0YU=; b=fl6rh/Ys9SKVZ7Zd2z+roHS+Vk
	pMW87ZOtVJFspZMd33wLmVyu7IemCfKCTSsns3QIAoYLf5s9NhPc8DJzaEtbjM5NI7VITaPgbxSRB
	tCrsMv5U4L6FH3QbaTRU75iZeCbQ0KGdmndHB03oSsBX1lalZxK854hdHLtusb1ReQZRfK3miz1RV
	TpHMMWlLXBLWQHcl9hwgqed86L+8kt00pS2AMLfu60okyYClqLhKZy9aTIR66q8wOshqFLU1FKspD
	1WC2lhF5cy8VypQC4Tb9QHz/zdruk0iplOY2F9IYoQw3bYb35PxgC1+DBtVR9Z41Ous0OT0Zsixn6
	7z2Tc/cQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1PqD-0000000GLzC-0S6H;
	Wed, 24 Sep 2025 13:47:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0633030050D; Wed, 24 Sep 2025 15:47:28 +0200 (CEST)
Message-ID: <20250924134644.027686159@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 15:45:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alexandre.chartre@oracle.com
Subject: [PATCH 2/3] objtool/x86: Add UDB support
References: <20250924134507.288529132@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Per commit 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA"), make
sure objtool also recognises UDB as a #UD instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -683,6 +683,10 @@ int arch_decode_instruction(struct objto
 		insn->type = INSN_SYSRET;
 		break;
 
+	case 0xd6: /* udb */
+		insn->type = INSN_BUG;
+		break;
+
 	case 0xe0: /* loopne */
 	case 0xe1: /* loope */
 	case 0xe2: /* loop */



