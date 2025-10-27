Return-Path: <linux-kernel+bounces-871734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE4C0E329
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 742BC4F8D08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E6302748;
	Mon, 27 Oct 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0RNgoZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE412D8773;
	Mon, 27 Oct 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572999; cv=none; b=irn3YOgjmInZcWRa3vfeAQYKctlNxl81QTPUaqjEhk25LXys1DJKPvjDt/qsA96wHnE3X9b3D2byow0ZdEC/t+HRiXg5ybE2WtNivhsl5lyS+pjRop0oCa4YprWRv15/FCIwFDmrVeE2SjQ/GUv1TZL4Q6rz6zbFonQF1bh09jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572999; c=relaxed/simple;
	bh=4CEtMduq3jdDdtBZbu4z30jJnelSXvuUtTmmAVK0YKY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Vqulzise/aap8gPk1/nu1TEN0Tf+f0r/rJX29FNXuGR3mI1iuGp9znYqS9COcv53qv46h7bnwRK1MeZZDw8RGaV26gP+N+ku3la5IlLbo8B6tQNGeMkt/CpB7hghEFcM/eJmFv7PIGVp8AtoOABsbiioVWfH+dyoKxoCGTMkjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0RNgoZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692FEC113D0;
	Mon, 27 Oct 2025 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572999;
	bh=4CEtMduq3jdDdtBZbu4z30jJnelSXvuUtTmmAVK0YKY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=X0RNgoZWFysNfSmQfpTmgO9QI2k2LNJw3ht+7e0vbiodZxe5iVJlyXsJI4ZGjF84Q
	 inbY8TYNHy/20dnnbAwhZ08ahadPZw/5t61WJ6aep5UEK022ymxrvWI+bYWq1g2dHG
	 SuOXuEO6kmdiUHXClXbiCl4ARyOxrBTp3zjWy51EdSuugJ/ZoRjQ1kf2aXSr4DrJwI
	 lNX152+SzEry7yvXLzUrh1wbuw0JDe4T2CCI2FCA3uz/JgH7wDwlN6fbs5hPsQq/V6
	 JsWdp05ZNZQqG5aMH6Zh8zkolUezTSrkkj3CADi5w65LVc8RnF1FPOOJxYzyHTRoCR
	 5SwY1ZKavbe1g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 14:49:54 +0100
Message-Id: <DDT5IDT0GI4H.4GBFX9U17WU3@kernel.org>
Subject: Re: linux-next: build failure after merge of the pwm tree
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Peter Colberg"
 <pcolberg@redhat.com>, "Lyude Paul" <lyude@redhat.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>, "Linux Next Mailing List"
 <linux-next@vger.kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Stephen Rothwell" <sfr@canb.auug.org.au>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251027125148.7f7d8ed6@canb.auug.org.au>
 <22fl35khmbf6ufyjzbfvxor7b6nohqakqovjoya3v4mmlenz5c@6wbdednrd2pb>
 <yohdkizrcgfyspfj5a4zarcu5b327aiskwwjth2k42q5q7p76l@qspcmydjnxk6>
In-Reply-To: <yohdkizrcgfyspfj5a4zarcu5b327aiskwwjth2k42q5q7p76l@qspcmydjnxk6>

On Mon Oct 27, 2025 at 2:40 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> To make it easy for Linus to merge my pwm tree during the next merge
> window, it would be great if it could contain the conflict resolution.
> Can I assume that this commit is stable, will be part of your next MR
> and are you ok if I merge it into my tree with the fix for the conflict?

I think the conflict is trivial enough to resolve, so I don't think Linus w=
ould
mind.

Anyways, the commit is stable, so feel free to go ahead. Also note, when I =
send
the PR (which I will likely do) I usually send a very early PR to Linus, ri=
ght
before the merge window opens.

- Danilo

