Return-Path: <linux-kernel+bounces-751547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 543DEB16AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE4C177371
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0A20E70B;
	Thu, 31 Jul 2025 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="QH7nmr4b"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80821D001
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931851; cv=none; b=r0UhT+Rt3YbA8CrXC5Hu2ukWAkIKZplvExe/rK+EzotHGzug+veJnazJO/93uacFxTt5MyeCSuS35GY957Y6QFpViZIKPuR1uJUW4GAhAltn346zyOZhyC6pCJfrq0bXqogbqW3Do6wTKf7J0/PFQluaetq5DxFsaizpJV/EbI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931851; c=relaxed/simple;
	bh=JFuj1fXGqMv5dz+JfQKNJGaKx+oKhV2iNXQrnkiy9FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrYVP+G+tR0WeBZ9PwOTXA8SxFadNrZYnI5l7wg8YNaC2l0WLxhI0FghVV/l4ubh53k0sh+R7kCje922S/OzEY5Az/saJfAx1v4DuZAklKZT2PhKLyvtUiASQL3zGJHwozQ/f/le6tR0QBBxY5cud3P2QMOuzOJfQnLGLTN3+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=QH7nmr4b; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753931842;
	bh=8eU281h5H38ovMshW3lbjK8xCcHSrZym11Zdp6XKotA=;
	h=From:Subject:Date:Message-ID;
	b=QH7nmr4bmbCXtbu6JUWvgqNWS4Xseq4NraDiaTH7YTNBZDn8x0XWDZP6hrz89kl3U
	 xaA6eFvUeDuP7fTm5Ts1DXHbqlrG45D+mraAQeHP04WTKimfrjlEbRD8IeomFOWF1d
	 x5/qsuBw4IH1ZBmuTYTv7V3X7/JL3ARYK/TYhWWk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 688AE03700003078; Thu, 31 Jul 2025 11:17:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1416266291929
X-SMAIL-UIID: 0C90038AB855411E96CBEFA08D59811E-20250731-111713-1
From: Hillf Danton <hdanton@sina.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux kernel
Date: Thu, 31 Jul 2025 11:17:00 +0800
Message-ID: <20250731031701.3609-1-hdanton@sina.com>
In-Reply-To: <20250730175909.GO222315@ZenIV>
References: <20250727195802.2222764-1-sashal@kernel.org> <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local> <2025072854-earthen-velcro-8b32@gregkh> <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local> <20250730112753.17f5af13@gandalf.local.home> <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local> <20250730121829.0c89228d@gandalf.local.home> <aIpKCXrc-k2Dx43x@lappy> <20250730130531.4855a38b@gandalf.local.home> <aIpah6DTRd99mMqb@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 18:59:09 +0100 Al Viro wrote:
> On Wed, Jul 30, 2025 at 01:46:47PM -0400, Sasha Levin wrote:
> 
> > Similarily the argument around not trusting the code is equivalent to
> > not trusting the person who sent the code in. AI doesn't send patches on
> > it's own - humans do. This is basically saying "I didn't even look at
> > your patch because I don't trust you".
> 
> One name: Markus Elfring.  Ever tried to reason with that one?  Or Hillf
> Danton, for that matter.
> 
Frankly I delivered nothing with Signed-off-by to you for couple of
years even though I can communicate well with syzbot. And with nothing
to do with "trust you", simply because the patch could make no sense at
best even if they are from the trust cycle. I am not so tame to get into
any silver cycle/cage.

Hillf Danton

