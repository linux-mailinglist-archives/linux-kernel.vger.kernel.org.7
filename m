Return-Path: <linux-kernel+bounces-752280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71EB1737E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4BA189D408
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793861B4F08;
	Thu, 31 Jul 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcK0zyWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB618E25;
	Thu, 31 Jul 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973679; cv=none; b=dErcpp9GGGVrz8paAUeK8BzgtHBtYaN+0EK+8ftAoXBhomUkz+xqMWMWW7nuoZRwFiNoc4MeDtVz9msRj7Gao5/BF9Rl9b19aReQhAy95OG0S49R/4yn1SnJmuXC9A0tiV+IikpoC2aUahHEWrtEs4cwHKbFsHz7Zasjl8M+s20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973679; c=relaxed/simple;
	bh=eqSCt1jtGu1voQQ+SQgsEsj/JuSUD4O5lgrTXjb4B5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SUw8EXf6gVRiYCyqV/w4FhRrFd9/GfCUvp0srCBLOwTuauamaQ2QVH+10YadeP1lZt239HwIWCJKkkQIEQe5QtdG1eLA6qZ50IKGPUAS+f2MPoBskk0hYxDEG+cUseIOpuyf305c8Kx6U5KgRnx930Q6iu6TiFC6rzYYjpXEPXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcK0zyWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B0CC4CEEF;
	Thu, 31 Jul 2025 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753973679;
	bh=eqSCt1jtGu1voQQ+SQgsEsj/JuSUD4O5lgrTXjb4B5k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=HcK0zyWNbuhEa+CeQcoEy4BM/jkZTyJ3tjKU+5oNJz57OJf9UA6iFTk3i2qXk2/yO
	 yHL2Hnjb1C8Aw8nKz9zivZVnsgFe3bkM8H4ky8qeElehA77rKfT37usl1sJhs1t+am
	 yl4N7I24MEbUe8vN92j3R1pVkWBes/G2mVIbHj2DFpf8t3RISFwcqA2hXAz9gocOPj
	 E7fpYGBtiAIKvJY8jZngQhcfIwzEpKSlMk4oj3/NOqU3n85Vtvv/fscYWyz/GFNYI1
	 2gVFxfNsvb/depZAKRsBTXy9HMdnLxtQ73P1H2ULyhyGEVr+AVzgLQDHVmL3SwWyR+
	 3q0vqMVNUh8ZA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 16:54:34 +0200
Message-Id: <DBQBRYBV9YVN.35REJ1DIA06L7@kernel.org>
Subject: Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports
 from sync::aref
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
To: "Shankari Anand" <shankari.ak0208@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250716090941.811418-1-shankari.ak0208@gmail.com>
 <CAPRMd3n-1nx6BnL=OtrrJqS1gCxYAw2wSaHUQ19174Y=ShqO6g@mail.gmail.com>
 <f958ac81-c092-4958-a61a-d30c8389f431@kernel.org>
 <CAPRMd3kvemvtEM4976+MGRbLJV+4X8Hwvodc0q8+0jtgT_V3Rg@mail.gmail.com>
In-Reply-To: <CAPRMd3kvemvtEM4976+MGRbLJV+4X8Hwvodc0q8+0jtgT_V3Rg@mail.gmail.com>

On Thu Jul 31, 2025 at 3:59 PM CEST, Shankari Anand wrote:
>> Where is the rest of the series?
> So actually it's spread across various subsystems. I had given the
> notation (2/7) to have a count of the patches under the same effort.
> Apologies for the misinterpretation.
> But yes, recently Miguel suggested discontinuing using the notation
> but as I had sent the patch long back, I didn't resend it.
>
> If it is confusing, then I'll resend it without the series notation.
> But, this is basically a standalone patch.

Ok, did you send the other ones already? I don't see them anywhere.

NIT: Please don't top post. [1]

[1] https://docs.kernel.org/process/submitting-patches.html#use-trimmed-int=
erleaved-replies-in-email-discussions

