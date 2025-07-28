Return-Path: <linux-kernel+bounces-748647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E968B14439
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4483BB860
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC821CC74;
	Mon, 28 Jul 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abKyXIQ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F21A76DE;
	Mon, 28 Jul 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740760; cv=none; b=M7q0Sw2+ENzDX4wRjFZ0zrIwLrwXMQgzscSvIhz+bANakJJKyGfLP9W/YFJrBeZjQb45uWSdowiflDk8IRYpN+mybzb4xVCbFWgt4+TAjbytVE8gTjA06XPWEhh+mVFrKOzZrFwp6IOGCNYnCnc6nuhuyl2B408pOzRmyu60upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740760; c=relaxed/simple;
	bh=AdAjJPs6NCL8ZHORNqzrGJ2cY/mycdHeCM4d04pIoCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRISaAXBLj8yb0muxpXTWrXG1i0NjDnCTIrZo0TRW5rcI787W42MTs62gwxilSp/o1tck54Y8xqns685Hq2aNGKIwQdtLYRPjKo246n6UTypnhCs/m7ivjS8KGQXwM5MpLoxvqlNJtmRmFJMQkvIN/ro2FIIio9k68jAurAsNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abKyXIQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86805C4CEE7;
	Mon, 28 Jul 2025 22:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753740758;
	bh=AdAjJPs6NCL8ZHORNqzrGJ2cY/mycdHeCM4d04pIoCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=abKyXIQ7561JAenZNkxQ2CuBpw+9SxUN9wq9fMPBgNH6vElWn0wPPSUOZ9VEcX0fo
	 JIQvxJ7zZdgMI8XgqKmGaSXDltCDfFb+uIXE69I4GlOjXe0owWUI9zckh6XETM7j1D
	 gD+4jPZk1Tn9ruGB4SWvf8eY4NfKcs3tB19Fn+XeYh+PLMuPQoju/qOqdPI83pZOnn
	 cNTBYZLik/KsrMlkmZKkvxiKYbGkeY3IxB088pBLY9bPrBkUCDjPMmEZ+LLAbns5Ps
	 DNTS5ABt/oucvVgD4pXwmxJxynIVZFZs3cqjmz1x+/wkklFZtcoC6mInjyv7J42riT
	 xgxbu+hyOW5IQ==
Date: Tue, 29 Jul 2025 00:12:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: <dan.j.williams@intel.com>, Jakub Kicinski <kuba@kernel.org>, Sasha
 Levin <sashal@kernel.org>, <workflows@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kees@kernel.org>, <konstantin@linuxfoundation.org>, <corbet@lwn.net>,
 <josh@joshtriplett.org>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <20250729001233.4dead173@foz.lan>
In-Reply-To: <20250728134653.635a9dc5@batman.local.home>
References: <20250725175358.1989323-1-sashal@kernel.org>
	<20250725114114.3b13e7b1@kernel.org>
	<20250725150046.3adb556c@gandalf.local.home>
	<20250725125906.1db40a7f@kernel.org>
	<6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>
	<20250728134653.635a9dc5@batman.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Mon, 28 Jul 2025 13:46:53 -0400
Steven Rostedt <rostedt@goodmis.org> escreveu:

> On Fri, 25 Jul 2025 13:34:32 -0700
> <dan.j.williams@intel.com> wrote:
>=20
> > > This touches on explainability of AI. Perhaps the metadata would be
> > > interesting for XAI research... not sure that's enough to be lugging
> > > those tags in git history.   =20
> >=20
> > Agree. The "who to blame" is "Author:". They signed DCO they are
> > responsible for debugging what went wrong in any stage of the
> > development of a patch per usual. We have a long history of debugging
> > tool problems without tracking tool versions in git history. =20
>=20
> My point of the "who to blame" was not about the author of said code,
> but if two or more developers are using the same AI agent and then some
> patter of bugs appears that is only with that AI agent, then we know
> that the AI agent is likely the culprit and to look for code by other
> developers that used that same AI agent.
>=20
> It's a way to track down a bug in a tool that is creating code, not
> about moving blame from a developer to the agent itself.

I don't think you shall blame the tool, as much as you you cannot=20
blame gcc for a badly written code. Also, the same way a kernel
maintainer needs to know how to produce a good code, someone using
AI also must learn how to properly use the tool.

After all, at least at the current stage, AI is not intelligent.=20
Artificial "neurons" just sums up values from its neighbors,
trying to mimic what we know so far about neurons, which is not
perfect. On several aspects, it is not much different than doing
an stochastic analysis that would try to converge into a result.=20

The entire process resembles the kind of systems that you could
be analyzed using control theory[1], like root locus analysis. Anyone
that ever played with that knows that sometimes the system is stable
enough to converge to the best results, but the convergence is
affected by poles and zeros: sometimes it might converge to a local
minimum; sometimes it can end into a zero and diverge, producing
completely bogus results.

On other words, the one that posted a bad patch is the one to
blame, together with the ones that reviewed it. AI is not a
replacement for real intelligence.

-

Btw, if you want to play with that, I suggest using deepseek.
Ensure that the DeepThink (R1) is enabled, as it shows how that
particular model tries to find a convergence.

-

Out of curiosity, I asked two AIs for articles relating control theory
with LLM:

Bhargava, A., Witkowski, C., Looi, S.-Z., & Thomson, M. (2023). What=E2=80=
=99s the Magic Word? A Control Theory of LLM Prompting. arXiv preprint arXi=
v:2310.04444.
URL: https://arxiv.org/abs/2310.04444

Kevian, D., Syed, U., Guo, X., Havens, A., Dullerud, G., Seiler, P., Qin, L=
., & Hu, B. (2024). Capabilities of Large Language Models in Control Engine=
ering: A Benchmark Study. arXiv preprint arXiv:2404.03647.
URL: https://arxiv.org/abs/2404.03647

Maher, G. (2025). LLMPC: Large Language Model Predictive Control. arXiv pre=
print arXiv:2501.02486.
URL: https://arxiv.org/abs/2501.02486

Zahedifar, R. et al. "LLM-Agent-Controller: A Universal Multi-Agent Large L=
anguage Model System as a Control Engineer"
URL: https://arxiv.org/abs/2505.19567

Zhang, Y. et al. "Unveiling LLM Mechanisms Through Neural ODEs and Control =
Theory"
URL: https://arxiv.org/abs/2406.16985

Barfield, Woodrow (2021) "A Systems and Control Theory Approach for Law and=
 Artificial Intelligence: Demystifying the 'Black-Box'"
URL: https://www.mdpi.com/2571-8800/4/4/41

Zahedifar, R. et al. "LLM-controller: Dynamic robot control adaptation usin=
g large language models"
URL: https://www.sciencedirect.com/science/article/abs/pii/S0921889024002975

Bhargava, A. "Toward a Control Theory of LLMs" (Blog Post)
URL: https://aman-bhargava.com/ai/2023/12/17/towards-a-control-theory-of-LL=
Ms.html

I didn't read them (yet).

Thanks,
Mauro

