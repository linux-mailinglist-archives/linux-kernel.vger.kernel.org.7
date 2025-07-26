Return-Path: <linux-kernel+bounces-746811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CEB12B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80FED7A7DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E528688F;
	Sat, 26 Jul 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6ItUpFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117511F1527;
	Sat, 26 Jul 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753547773; cv=none; b=nAY9BlbCf+GST7yNUBeWSow1NBn5xhT/8Sv9g7/LxRQ1x8/2s+N+wzEm9kGayS8PSsi0b6QYoM210J8rE+kK/evpUgoo7rNBQtILbEJhe0s7ru2+yMlQUolUYJSgfxFc51BSkaTipn+HGlERQ+gTYZvlD1Q2iBYNFUzBObEeR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753547773; c=relaxed/simple;
	bh=SZcp93tNtxNW4dMkEKDGLpDI0WwjltYtCcdV+PyeY6o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VFiB2lfSFJeHNaNPvmzazgbPiFiwRdSQxLOWYJbO+DhbosqyM7KrHI7iRQf68nIP8bmJDt5GwpGr7COtI+ptzmjVCOIzkWcy4Q8vvEZn/OiftUhTxOnXG/puPXvnQpFD0uf5s17w3Ol0HB/xQJp6Qyc2MQKH5podNiNqOtpprwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6ItUpFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D71C4CEED;
	Sat, 26 Jul 2025 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753547772;
	bh=SZcp93tNtxNW4dMkEKDGLpDI0WwjltYtCcdV+PyeY6o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=b6ItUpFQdF5kpPAD4ayJR/SDIlh436iFEHsDWcg0b2yNBcIYluzyJRhVIqYFFHxCZ
	 GePCiSZsG8JWgvyhZ/5CiWZqr8QkrQ7vS9M5MJ6JcctHlal00HduqGZSaL9U6DpMNy
	 H0w4aG5Bx7/jHmURfmmhiU3Ort18ohwA9Qn4vTrSHCtBOMUldIBw3qdjz7y7RFHdJs
	 lFJZpvI8TWpXFxuNuoUehCBvZe+AG/Q/Y5UHfm5zgTnoqMatROJQuPvX9F3EGN9Bm+
	 BM+Jd1mqRpQ/MevrQAplsp+YNWR0Hgo5Mq10/8Wp6J7w9h4K/YJUrjo4CT8DMqxCta
	 tLWwbetsIirXw==
Date: Sat, 26 Jul 2025 09:36:08 -0700
From: Kees Cook <kees@kernel.org>
To: Mario Limonciello <superm1@kernel.org>, Sasha Levin <sashal@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: rostedt@goodmis.org, konstantin@linuxfoundation.org, corbet@lwn.net,
 josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
User-Agent: K-9 Mail for Android
In-Reply-To: <77782f57-6131-4968-95dc-088329cc50f7@kernel.org>
References: <20250725175358.1989323-1-sashal@kernel.org> <77782f57-6131-4968-95dc-088329cc50f7@kernel.org>
Message-ID: <48E7949A-F137-4412-8F96-B4BC2F915206@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 26, 2025 2:07:40 AM PDT, Mario Limonciello <superm1@kernel=2Eorg> =
wrote:
>> Example patch creation with Claude Code:
>>=20
>> 	$ claude -p "Fix the dont -> don't typo in @Documentation/power/opp=2E=
rst=2E Commit the result"
>> 	Done! The typo has been fixed and committed=2E
>
>Is this actually how people use AI agents?  I've never thought of asking =
an agent to write a whole patch and commit the result=2E

Yeah! I've been using the interactive modes (e=2Eg=2E just the "claude" co=
mmand)=2E The insight by a friend of mine is to have the agent update its o=
wn knowledge base regularly=2E For example, for a first time session, using=
 Claude I would run "claude" in the root of the kernel tree, and then write=
:


/init
Find and read the coding style and submitting patches documentation in the=
 Documentation/ directory
Always use a build output directory, like "claude-build"=2E This must alwa=
ys be specified with the O=3D option for make
This is a big build machine, so also always use the -j128 option for make
Perform a build of the kernel
Save anything new you've learned in your CLAUDE=2Emd file
Keep all new =2Emd files and temp files in the agentic/ directory
Examine git history of commits by Kees Cook over the last 5 years and writ=
e out a new =2Emd file that describes his commit log writing style
Use this for any commit messages we write
Figure out how to run KUnit tests, the docs are in Documentation/
Run the fortify KUnit tests
Update your CLAUDE=2Emd with anything new you've learned


(Note that I run the agent as an entirely separate user in a Docker contai=
ner=2E)

The agent acts like an intern who reads VERY quickly, but forgets things r=
egularly=2E So it has to be both reminded to save new stuff it learns (I br=
eak things into separate =2Emd files), and then read them back again after =
it starts forgetting=2E

It still needs extensive hand-holding, and it's rare that I'm happy with i=
ts commit logs, but it is pretty helpful so far=2E That said I've been focu=
sing on some smaller refactoring work just to feel out how to use it=2E I h=
ave some hints that it would struggle with doing very large scale refactori=
ng on its own, but it's nice to toss it at a huge patch I generated via Coc=
cinelle and say "build this across all our configured archs and fix any com=
pilation failures you encounter" and then go have lunch=2E ;)

-Kees

--=20
Kees Cook

