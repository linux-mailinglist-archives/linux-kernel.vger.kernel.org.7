Return-Path: <linux-kernel+bounces-883122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E6C2C865
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EF014ED362
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE6531A058;
	Mon,  3 Nov 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0johv6XM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+7JqTyH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC831AF3D;
	Mon,  3 Nov 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181273; cv=none; b=bT94dL9s/rAT0ZOUeukp9pWrd/L48kD39t4fFffNG0wPj0XthAE9C4+6WRui/yjRcGCnOTW+UqK1mf04VR+tqLR+l8xw2ifhCryGIxhmfqt7zso2CPrcT5BGWBMReD84MfDGJodKk2o3yceuPtjsCgH0qanP6Ig7JIgMfZDshDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181273; c=relaxed/simple;
	bh=iR9wFzIN4MIlUgkir35fHEeAW+MlWDEtRQIwez/xK10=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AWpSQ2E6j/I4XqoZT9c15ZM+P9w9HiqEAr8lorLEkhXdxHsfXy3Ulf7w6X6GCI5SIwV0DFsDwNWgpIK9127NdOQnr8qPo+Kum3IRp82TRbXq2z+ziViyNji2QFDK1KGP8HyqL9q5N0FQAE2AmTvgc/aAXmyUKXymuEey4q7DXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0johv6XM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+7JqTyH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/DBpFHf7cEd8/4LZyPkMyxb0LAdeoKf0yMBMpXaJaM=;
	b=0johv6XMerq5kd/wpi9mMFfYMfLNB9KqghF7fjuCXnKsnkVECtHZfjj83/41i6f3VrxWS7
	7wcvXSFthrroD9xYrBv/+R+AXAe505lh+UwygCNM1Y3VkNc83/WJxLis+nDtVkUqmWEtrq
	MB/nKGWMvMAkkSctuCO2EPLRH/NxpxnG8QngAys19rEzXAuhioPmlSrTnnL0x8wHtMrlfe
	iq0p+uX9vwCx9jQuHB3sn021e0tdLMa3ZbDLMcQcCmjP5YSP9Eb6hYMENfWNs21EDlZtjZ
	MKDWGcrBFKaL23qDVf7TCVK4QjwbPmJtsHGM003BcrIFFeLyHCF2FLFF6uma2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/DBpFHf7cEd8/4LZyPkMyxb0LAdeoKf0yMBMpXaJaM=;
	b=G+7JqTyHGF0DkK59wj69FUpHtmq8s8ntfVLSTzd2wNtP/xBFbCurxmAdiD3ZeEzTIuLHhn
	LqRGWHzQYUgPjGBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Avoid CPU/MM CID updates when no event pending
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.462964916@linutronix.de>
References: <20251027084306.462964916@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218126878.2601451.7016661652891916917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     d3fd8e5061bf3506c0cbf974536855470bd142b9
Gitweb:        https://git.kernel.org/tip/d3fd8e5061bf3506c0cbf974536855470bd=
142b9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:15 +01:00

rseq: Avoid CPU/MM CID updates when no event pending

There is no need to update these values unconditionally if there is no
event pending.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.462964916@linutronix.de
---
 kernel/rseq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 01e7113..81dddaf 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -464,11 +464,12 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, =
struct pt_regs *regs)
 		t->rseq_event_pending =3D false;
 	}
=20
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
-		ret =3D rseq_ip_fixup(regs, event);
-		if (unlikely(ret < 0))
-			goto error;
-	}
+	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
+		return;
+
+	ret =3D rseq_ip_fixup(regs, event);
+	if (unlikely(ret < 0))
+		goto error;
=20
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;

