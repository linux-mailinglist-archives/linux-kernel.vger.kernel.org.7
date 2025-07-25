Return-Path: <linux-kernel+bounces-746158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C4B123BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9971CE0907
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C18246BBB;
	Fri, 25 Jul 2025 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EzE+uR0L"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48571C8FBA;
	Fri, 25 Jul 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468080; cv=none; b=ewuaDF7AyjbebhXydqzUdSw0QQzvlM8YiEcOTLDCX9n1jNFjuQyjUUAX6Jzdior5+LnZ+yoqmyLIunDpkNeXxhK+o801LPdb4jl3S1I0X6SRxKMJqZs5sWL+zbNmtX0OSirtbLG3cEHpOtZLpbTHFueDnWqqogzAqY+RmKoPbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468080; c=relaxed/simple;
	bh=VQo+k1nn3UQBocuvPh1cT5PJ9UA/Fn9WOfw3tsHfHx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fgDlwjuM1VmncHi3d/OmlYGCPryb2pMbbL4BArkfxFvTLcOlsFkt7t24UAY2sZSqohe+e+45tJli1eNc4aqdINwGMBtefHeSBvFhYgvixrZFUCbqpEn3h2tKSPar7t4u43v6zaggTU8ioTYoSkZ0FZf2LfDXVRiC1DGlb/NAWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EzE+uR0L; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BD6844040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753468071; bh=Fj50Yg6ukyaZcCETnX8irK4C8dwVdm5PeuFu4kLrUwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EzE+uR0LKsg30Mo6k4yf70dijUSFJwe27UpQ/zkcEY//UT3XqyJJ1tZ0xa0I3f001
	 7KYPjUvWu77Xy/VAx3t06PRozqAU8xSnMEQgamVdmHPRRHdHym+ZvwvIPwge7eolDd
	 8Yuo/xs49lsBLUr8F+Tdo3matAulKQIOQZibuXafZaKyDIxpKwYaeZ8UsXkE2WiDYT
	 DawZ0wgKFkB3XeJzj0XVjBkCqxWLaDyXBeFcemZFYXEgTmMud3dyPN57gzI8C9XSfv
	 Unm1P/7G4f1CEshi/xW1R3Xa8gn7uiTrx6QRiUcesb4I2h6O5wr0wdEnQz0BCiq5Pd
	 FZi9MOdeZMALQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BD6844040B;
	Fri, 25 Jul 2025 18:27:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, kees@kernel.org, konstantin@linuxfoundation.org,
 josh@joshtriplett.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
In-Reply-To: <20250725175358.1989323-2-sashal@kernel.org>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725175358.1989323-2-sashal@kernel.org>
Date: Fri, 25 Jul 2025 12:27:50 -0600
Message-ID: <87wm7w5dnd.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> Create a single source of truth for AI instructions in
> Documentation/AI/main.md with symlinks for all major AI coding
> assistants:
> - CLAUDE.md (Claude Code)
> - .github/copilot-instructions.md (GitHub Copilot)
> - .cursorrules (Cursor)
> - .codeium/instructions.md (Codeium)
> - .continue/context.md (Continue)
> - .windsurfrules (Windsurf)
> - Documentation/AIder.conf.yml (Aider)
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .aider.conf.yml                 | 1 +
>  .codeium/instructions.md        | 1 +
>  .continue/context.md            | 1 +
>  .cursorrules                    | 1 +
>  .github/copilot-instructions.md | 1 +
>  .windsurfrules                  | 1 +
>  CLAUDE.md                       | 1 +
>  Documentation/AI/main.md        | 5 +++++

So I'm gonna ignore (for now) the substantive issues here to ask: do we
*really* need to introduce Markdown into Documentation/?  Are these
things really unable to understand RST?  Why not add a file that can be
part of the docs build so people can see the instructions that are being
provided?

Thanks,

jon

