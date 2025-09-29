Return-Path: <linux-kernel+bounces-835948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA268BA86AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA931673BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB1B257431;
	Mon, 29 Sep 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jeaP3Ydt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C522F74E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135197; cv=none; b=RXbW5VEcujk4RSJT9oUYrY4STCGow7yv98yYqGblVd0hd/6d1nGioXcDiPEZK5izETl2pUAFEk1V9k4UwJZZs/en6/MN6jz3FfcD1O83d0cwP966GneXJq0XO1I8xmTE+KsmJi+3tmAfSflHHO9yRCOyRSFUuaAYxv+jhtj0H8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135197; c=relaxed/simple;
	bh=KhU9y4iDSwKnWkcZxABt8lI3a7a95hpVjPMyfPw1H4g=;
	h=Message-ID:Date:From:To:Cc:Subject; b=BBoKu//wzRAK/zu8ItVSpit3nl28ZVjaSU+iHTPj8vAaBwOF9AFABBaRxR7LlKe5OzEdv5OX2OyUdIs2u9eu/+jvjZww6Gb/37SWck4AvSOy1fhMkxCL32b3D1g70ojwcZtTlBxN51xWhjy4N0WYdKaWs5rLuS1xxK1itIDlG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jeaP3Ydt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KhU9y4iDSwKnWkcZxABt8lI3a7a95hpVjPMyfPw1H4g=; b=jeaP3Ydtf53b/O4ASObkdZe4il
	rZ/Uv3aWe92cCrc2MvGpk43C5C9hn3yXUpkecA7l5SSJXiFHr3lKFItwIu0UGjkB/6rwV4HAGJaKd
	j6c60alxi0w/cImxu3p/ELaB6ps637VjL6Y/VmQO0RHfxoeCdw7S3ZFV8YnLFG2wmVK6zUKcUqtGk
	9SNZ0YOpefFS/s9ww9HSvVlBxKvA31FrZrv9wXTp17MHF7sKmTHhSftKVr55BdZ6YH5rbNYvdV1Fr
	oTO6ZHWapzCx4hhqaaKA0K/u2VgU23uaM/WKbA4rxR8Qm7Kd8i+un+7gGDt4pVIR7tdSlX0gqtJAY
	PY6XxxUw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39QF-0000000BwKT-2K1Q;
	Mon, 29 Sep 2025 08:39:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 5FE0830039F; Mon, 29 Sep 2025 10:39:48 +0200 (CEST)
Message-ID: <20250929081853.230968966@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 29 Sep 2025 10:18:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org,
 hpa@zytor.com,
 ludloff@gmail.com,
 andrew.cooper3@citrix.com,
 mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 andrii@kernel.org,
 olsajiri@gmail.com,
 jpoimboe@kernel.org
Subject: [RFC][PATCH 0/2] x86: Unify/extend insn_is_nop()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all, welcome to an x86 instruction encoding quest.

I realized I implemented insn_is_nop() twice, obviously they have different bugs.
Additionally, I was made aware of another uprobe use-case.

As such, unify and extend insn_is_nop().

While doing this, I went down the rabbit hole of REX2/*VEX* encoded
instructions (because REX2.b4 NOP). The Intel APX document is clear as mud on
what exactly VEX/EVEX Map0 is, but the way I read it, it is the normal single
byte opcode map, no exceptions. Similarly Map1 is the 0f second byte opcode
map. So VEX prefixed NOPs should just work.

REX2 has a similar Map0/Map1 scheme, except it excludes a number of opcode
ranges -- notable not including NOP/NOPL. So REX2 prefixed NOPs are fine too.

Because I had to figure it all out anyway, I've made the function deal with
them, but perhaps the more prudent option is to simply reject all REX2/VEX
prefixed instructions entirely.

(although EVEX NOPL can hit 11 bytes without additional prefixes, so maybe
someone will start using them at some point).



