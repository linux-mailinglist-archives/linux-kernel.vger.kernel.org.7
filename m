Return-Path: <linux-kernel+bounces-830099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF04B98BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D447A2D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539642868B3;
	Wed, 24 Sep 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLK71oX/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0052820D6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701020; cv=none; b=E/e0M5jzL31bi8TQ0DrrFh1Za6/Ba5kYM1LwGlSOIWhW7ylDUhvJJ7XrU1SH6uw+277/oJmwI2h74hfQ6yyNQxnJn6e1sPHWer8K6iGoT9XqwVsxG5/upH25jB7aEvqX0Q2/JihpmvGG8X3VSnlqZ1zw4R2gcdAQWAxU2ban3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701020; c=relaxed/simple;
	bh=2ngjv/7OiOtnkuJ7StFHumf5SQS8B4gUssWDdLrExO8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FuYO2n/5R+Ri38tYc6+1PruZS2HODDzmy64q/YGBP2NV2gKCodzgMXCd3JwLo3QoC1+hSBX0zh+eOK96AdAuUZ5vnYIahKpIqTNsRfi13Cb29DsPD44Dh0iFESnZ/hvfCEccrcw48Nys8/OeV9LoPnOo/eTuQByTiSsXRgcrmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oLK71oX/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=owIgT50kjcdetij22IMm+tbaa5oztYHip42v6jyp2V0=; b=oLK71oX/nDD3PR2TqMehs8KTSk
	/ND9Dv3KBdqGMgoXs5Ffpr1IXTTjyNi+Cis4o0DDyoubg/AW5oPg0NYZo6OUbcwzGmaWPRHTUtpJq
	xFsXdYm6/1XuCza1oxf2eU1S93vztFmdbjyJ/UBcQnnlhp01Gtr5MuolFRb8N6NK10fkFQf3zA2PO
	BUhHQNN/ia3G+OXfY9p6GqQk9YMf9YmgAtyhfW+UCd5/hHrUMwP2ate8QKObYKUq+E+JgM3OWlkEU
	hh/duxiUY/6zWFNLHDVn5nY+yfgEl41rAb8V7A2eJw/sOCUFbDpcSC1CYE+J4yo5j7eG7P8nM/sbk
	5dGohX7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeEG-2SxF;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1C994302F79; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080119.122507632@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 07/12] unwind: Clarify calling context
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The get_cookie() function hard relies on IRQs being disabled, but this
isn't immediately obvious when reading the function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/unwind/deferred.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -79,6 +79,8 @@ static u64 get_cookie(struct unwind_task
 {
 	u32 cnt = 1;
 
+	lockdep_assert_irqs_disabled();
+
 	if (info->id.cpu)
 		return info->id.id;
 



