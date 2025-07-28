Return-Path: <linux-kernel+bounces-748384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE28B1407E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B1D1888116
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C192749E7;
	Mon, 28 Jul 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd8iXgTx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E22727F6;
	Mon, 28 Jul 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720867; cv=none; b=PRf5nGufNqd3Z/cl0g80YoIFoY0nfAcJiwQXDBxignFQhFjekU+DMUp/T/KD8B/LjY6UcqONffkaCgNAgRuKDH5tUXn7sEVl3exDcYoizLsN35GMqDPflyG8w6BpbeJ2NABvg0NmxvwB6MkAyb6R3GXbSWZP8uBA0xIkiL0Drnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720867; c=relaxed/simple;
	bh=S9qutYy6Xor9FZMzMNct/VB9FINEX9V03Uyt07X+gG8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NAYP6cE9+STWSNd6Do4gFIFdsGQi3wE4lEESk3epyF4f68awzBknozcmxdod5Q7qjP/EW0f4BflDBmsMZSO3B7NgB+lnf0HHiYVJkPK2pSnMAYZmHJQ+dcF2h8Yn/pAEgOdgyYyFaDJ3iy2cTMErHbim9GggQ97lvBmTl2ycaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd8iXgTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921A3C4CEE7;
	Mon, 28 Jul 2025 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753720867;
	bh=S9qutYy6Xor9FZMzMNct/VB9FINEX9V03Uyt07X+gG8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hd8iXgTxxeL9E0lIsfb7ZLbHJ8LYPLIY9cEnbRAQ9FBfPksMVbOxSLc/WwaJm7BU1
	 plOyB18OtXDJq35z0d1eFoqSjrltb+RJISXf2dmYAYyCLDI26+iQ7e+CRa58hVP+c9
	 IEiXrt2ul3WrJR6ksbj8J9gsSsWzwbHV4gK9/KElPLcwcCDVtJSmmpEujs8Ehk5lH+
	 mB8KTPNfw0SDmmK9wE+QDGLdDqSc7wKqbKQs/0vWRM5z6uwQgDb5QNU/e6XScbNp1C
	 hYvkTxb57ZS83ZkRbg0PFPYQrd2OczN81Dex7CD9MMWq3Hi7wPntOczDHOY7o1n09C
	 5gI34o/TnVsMw==
Date: Mon, 28 Jul 2025 09:41:05 -0700
From: Kees Cook <kees@kernel.org>
To: dan.j.williams@intel.com, Steven Rostedt <rostedt@goodmis.org>
CC: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org, corbet@lwn.net,
 josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
User-Agent: K-9 Mail for Android
In-Reply-To: <68879de1aaf4_e74a1008c@dwillia2-mobl4.notmuch>
References: <20250725175358.1989323-1-sashal@kernel.org> <20250725114114.3b13e7b1@kernel.org> <20250725150046.3adb556c@gandalf.local.home> <202507251356.4396F1F@keescook> <68879de1aaf4_e74a1008c@dwillia2-mobl4.notmuch>
Message-ID: <58B23F1B-9E09-4B30-A1AD-BF900103E971@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 28, 2025 8:57:21 AM PDT, dan=2Ej=2Ewilliams@intel=2Ecom wrote:
>Kees Cook wrote:
>> Having had to do "find all commits from [set of authors]" research for
>> security audits, I would be very unhappy if I had to do this again in
>> the future for a specific Agent (used any author), and had to loop lore
>> into the process=2E Yes, it's *doable*, but it'd be very annoying=2E
> [=2E=2E=2E]
>So "doable, but very annoying" strikes me as a problem space where an AI
>agent could help=2E It is not clear to me that a concise commit trailer
>captures everything needed to help both the review and after the fact
>forensics problem, especially when model fine tuning and prompting are
>in play=2E

Heh, good point=2E :) We can make all problems *with* agents and problem *=
for* agents=2E :P

--=20
Kees Cook

