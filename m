Return-Path: <linux-kernel+bounces-747127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E0DB1300C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E493B5F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061E21ABB1;
	Sun, 27 Jul 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kffYuAXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC2405F7;
	Sun, 27 Jul 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753629826; cv=none; b=gdzDZ9ePSbgwQRAhJGvsBgGNSd3A6FMnwm1Hd9/DHN7kNOh/GwMZY1cuetQmtmgwj9nuox7BF6Sl/WrtUh1cB6dCU02Rrc8tMaWvqL0lGJ9JsfIdWiLCGIUjmxbua+y/dBc+R6d0ygJ1kH8+8brykWq6JL9XzsIvkxmDeGltLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753629826; c=relaxed/simple;
	bh=keR1k/wmb1jqq69WkXpHLaWHRoXcuakEANVW2FAl7fU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BbQwnVjvSpiUDJypTVvV4Vct5dx2NW2pXuEN4eBjzdrYBjf7U0Arorpxf7Bas/y/qdP/h/0rxJ8VE78S6yprwF+1iD/yYeD8yaOTr4DFtTRZrCVwscZuCTFZXjiP2b4YzBxF3VOdD4zk3rIXzH5UKWT1jxeNRi8XqHLIvRcFn6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kffYuAXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82F2C4CEEB;
	Sun, 27 Jul 2025 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753629826;
	bh=keR1k/wmb1jqq69WkXpHLaWHRoXcuakEANVW2FAl7fU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=kffYuAXN7QgocZfvvjJfi2Rm0/zYgpGVkFXXjKOGMpDsebAnsKCFt8tAd0PW6wIww
	 yX5oUYzbDapvmaWurTw2uSLxKjywBqcoQDWJA89gb7zgskktprPkOLcMRNINszddTW
	 61ec06/ggDX8CtLyRjri1hUUajMGbWzusVVy1U0d6kJTKTOyR6wr3ZP4/FpWCv30cY
	 JuNbeb9A/EMzp8T8Bf9G9wYDg5Xt1NPhfkH3/7t92qejqEQbBX6WwfVcpCIBJWJQKn
	 JD0hWGZeGTDpq1njeOLzneGDsik9CaHfJBYa8PLbUqghuV5osgsWQFYVrO9iJdvDQB
	 es806wwkpj/Pw==
Date: Sun, 27 Jul 2025 08:23:44 -0700
From: Kees Cook <kees@kernel.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, Sasha Levin <sashal@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: rostedt@goodmis.org, konstantin@linuxfoundation.org, corbet@lwn.net,
 josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
User-Agent: K-9 Mail for Android
In-Reply-To: <CACzwLxg=vQeQKA1mPiYV9biu=swo7QDmjB3i=UhYmv+fGRBA4Q@mail.gmail.com>
References: <CACzwLxg=vQeQKA1mPiYV9biu=swo7QDmjB3i=UhYmv+fGRBA4Q@mail.gmail.com>
Message-ID: <053939E0-5BAB-483A-9FE4-92BF35201A4C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 27, 2025 2:37:22 AM PDT, Sabyrzhan Tasbolatov <snovitoll@gmail=2Ec=
om> wrote:
> [=2E=2E=2E]
>- Code verification
>
>LLM does not do any kind of verification of proposed code=2E So the human=
 still
>needs to compile, run, test it=2E

This hasn't been my experience=2E With the MCP cli tools I've had quite a =
bit of success with it doing build testing and unit testing=2E I'm hoping t=
o add runtime testing, but the hurdles for getting it to sanely interact wi=
th a qemu instance is tricky=2E

That it will do basic build error analysis and fixing has been nice: it ty=
pes faster than me, so if it's simple stuff, it's faster than me to find an=
d fix typos or other missed refactoring work=2E

I've not used it for anything large for exactly the reason you mentioned: =
the context window is very small compared to the size of the Linux code bas=
e=2E But if it is given narrow goals, it does well=2E

>P=2ES=2E: Personally, I've decided to pause on the vibe coding, since I
>spent too much time on
>explaining to LLM the context and copy-pasting errors, and reading the no=
torious
>answer from LLM **You're absolutely right! Let me change my code =2E=2E=
=2E**=2E

Oh yes; this can be so annoying=2E And the "mission accomplished"ism! "Thi=
s is the most comprehensive set of tests ever added with 100% architecture =
coverage!" Sheesh, calm down=2E 100% build coverage is table stakes for Lin=
ux=2E ;)


--=20
Kees Cook

