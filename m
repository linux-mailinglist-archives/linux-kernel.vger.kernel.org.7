Return-Path: <linux-kernel+bounces-893051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5EC466C9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EA53BDE8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356030FC12;
	Mon, 10 Nov 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HyA1WcD7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD530C609
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775922; cv=none; b=EqKhEV+hhozBBRcVlDWX3me1RQuWIoACtF/e0QVj58D3qwwaJU5Ucm/TUIGDxMuIqa7r30gKzVxaY8ses3ilCdhaOEzB8p7Ppe3FQAI2i0B9jGwk9Z+HWJ6s4NocONczgrwbgjRM6ZcJ+iRtvjBNKZmCTbMZVTYoMLTDW1gniD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775922; c=relaxed/simple;
	bh=/GwZj2xx9bDQrf5cLHsn+g7sOy0LoMOsZRu4zqY34EY=;
	h=Message-ID:Date:From:To:Cc:Subject; b=B4qzBjHWwICGw8l5+K7g7KTnBwrzk6vKd/rbItz7kdO7O/DS+GL0qNSgh77HOfu/XjTYhGJzXEsFS9fPUSS1gLuNReOTOIWEGKge7F+D9xO/vqd2f6RW3NEr1A2dxqQAb4c9VEwZ9DkKvn0fpjMSftLsiZOOKzlfLsAREBOrS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HyA1WcD7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=LmAsqJdd093ixnPemB3Q+9DY0NHTECRvXYixeQVNf8M=; b=HyA1WcD78d5J5ufkZtGwJVahrw
	kKpq4D8ISMzpPrryCm6t7SfOUtWB0h3OgLziOSN7n4twQNLbnpH6Diz1XzieN4etawfhOLfVCHzRj
	fBs8i2kN1ivddzasKte59ROQ3dgZ2yzlAm4fr3cCYYCscj874Clz2G0sj//1uZbpJivJcH+bTuDpx
	XYxYu9MXUiRaJFew0ltwVvEUdW7bNf7TG/Y3CCo2eLjjfuIj2ucQVn1MQYI/r+DS3gx3T9CjYMtpH
	ICruBvWtQS7KVHONSmYFmzPEW9W4Ohb9yO8OPM8EkZIPxxHAn1byHCwWbwVVEt/eEPVNzZxbgofb9
	2uCCJHww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIPfv-0000000AZeQ-08Yk;
	Mon, 10 Nov 2025 11:03:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3630A30029E; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110114633.202485143@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 kees@kernel.org,
 acarmina@redhat.com,
 jpoimboe@kernel.org,
 mark.rutland@arm.com,
 torvalds@linuxfoundation.org,
 maciej.wieczor-retman@intel.com
Subject: [PATCH v2 00/12] x86: WARN() hackery
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

I was going through my patch cabinet the other day and found these patches.

Mark was going to see if he could make ARM64 play ball to see if the generic
bits really are that. But clearly he's forgotten about things just as much as I
had.

We should probably just merge these, as they improbe the code-gen for WARN()
significantly on x86 and then I'll help Mark out for ARM64 when he gets around
to it and needs a hand.

Freshly rebased and somewhat tested.

As a quick reminder, this makes WARN(), which has a vararg printf like
arguments work with the #UD based WARN infra by hiding the format in the
bug_table (its a constant after all) and replacing this first argument with the
address of the bug-table entry while making the actual function that's called a
UD1 instruction.

The exception handler then create a va_list from pt_regs and vprintk() does the
rest.

Also here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/bugs


v1: https://lkml.kernel.org/r/20250607094224.104791182@infradead.org




