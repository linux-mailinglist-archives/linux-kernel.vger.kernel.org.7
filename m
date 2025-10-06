Return-Path: <linux-kernel+bounces-843262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D3BBEC94
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B843BE5DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DBC2264B0;
	Mon,  6 Oct 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="RSkVe8rr"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0313E41A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770811; cv=pass; b=aq98MK9ijjnmmPtgPASPcFXb92Scg8+APfdQN4qDfDog3rYKwqOVLSGH/Yx1cjA4iI3TRjfqP8mHnM1EmFyYR1PJYMWwLnBa9myFbTWM84LnPTV+g00x8/p5UKPPl4+sUTpDYMRhpS5paVdg20Bgeg7HPxcB2BNsFSYvIRoLfAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770811; c=relaxed/simple;
	bh=poyTbRkj/WjyINB9cCH59wIozgnf6SXoYlyp/3K0L3Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=j8j773y6590/oWNvLAq33ZjVI4dl7Sf2eaEvL82cRp9gziBUNK7fUIqVPPlMPAvNbWgp31xOGaAIYy0aHzoOXygUErHBT0N0gi8rrvi7fvq3Qi0zgKJVR4kQZ9v4yBCltiiMV6mOwu+00ypG8hcZm4Kdp7jMXimNscqmN0JeAYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=RSkVe8rr; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1759770774; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ngMUm1uSUBHwc4XFwvBwmvq6QNMUvC1tuuhigwQ1aXgxkOa0LrEw4L5cHpskxi6vfUCbAPllyFamPfTHACBkRNVZEOBtq5w6+aPd7cUj9rHMMC1Tc+X6cqn5N+K8xUSceT2zATBY9uQGnxy5N0I8dWUL8f/1fZfAAYYG61wAM5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759770774; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gHzlXNr5dNbJ4uVFmhRke8r682OUDwuTp69N/PUk1vQ=; 
	b=jgc4+A7WUHKdSI5u8IzZftZT7uF5kYDR0Geadibb85BeCZX5kPltTp/OjsGrD6ciiTW18Ht+WgTXEhfdhYFEIWnO7HYFu1evHb1njRttMqPhNtLy6M2CTA+kOv3pi3cgxCYE4LeVpeePVp51nr1YcC4Gzl52/EwRclcuuB5nyhg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759770774;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=gHzlXNr5dNbJ4uVFmhRke8r682OUDwuTp69N/PUk1vQ=;
	b=RSkVe8rrD9FCEhKMiekYZn7uSXod72p4b/SMgWWYfRz3RGK9MITikXNa774s8GsW
	C1HJN7TMbsDWy3M20oM9YmsQ4k6/6Bzl48yKuQapiP1v9S06z0ZT++t2FKWduu/uiwN
	p6C1lOuXQN0RXlVNHkr9z0Nv2J1S8cUTBALOfHaY=
Received: by mx.zohomail.com with SMTPS id 1759770771990636.4904855689554;
	Mon, 6 Oct 2025 10:12:51 -0700 (PDT)
Message-ID: <9076062a9c0daafcc23bff616864299abc0353e8.camel@rong.moe>
Subject: Re: [PATCH] x86/CPU/AMD: Prevent reset reasons from being retained
 among boots
From: Rong Zhang <i@rong.moe>
To: Borislav Petkov <bp@alien8.de>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>,  Yazen Ghannam <yazen.ghannam@amd.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006133128.GCaOPEsFuhJI89YG8L@fat_crate.local>
References: <20250913144245.23237-1-i@rong.moe>
	 <20250916140227.GGaMlt8xSp3eMI8Veu@fat_crate.local>
	 <1e07144c-da10-4817-a2c6-ea11988936ee@kernel.org>
	 <a1eff492b192bbe68716b46c18cd7152951c6550.camel@rong.moe>
	 <20251006133128.GCaOPEsFuhJI89YG8L@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Oct 2025 01:07:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-3 
X-ZohoMailClient: External

Hi Borislav,

On Mon, 2025-10-06 at 15:31 +0200, Borislav Petkov wrote:
> On Tue, Sep 30, 2025 at 06:18:30PM +0800, Rong Zhang wrote:
> > A user may feel confused: Two bits are set, but only one reason is
> > reported. Hmm... Is there a hidden failure?
>=20
> Why would you assume that 1 set bit =3D=3D 1 failure reason?

When I first saw the for-loop, I noticed it didn't break once a reason
was found.

And Documentation/arch/x86/amd-debugging.rst says:

   When a random reboot occurs, the high-level reason for the reboot is
   stored in a register that will persist onto the next boot.

These made me assume the only purpose of the register was to store
reboot reasons, which further made me assume 1 set bit =3D=3D 1 reason.

Yeah, I knew I made a mistake here once I read the PPR. Perhaps we
could improve the wording in the documentation? I.e., mentioning that
non-listed bits have nothing to do with reboot reasons.

> > Unless the user has read the PPR, it's hard to realize BIT(11) is
> > already set in the reset value. The debug message is here to help:
> >=20
> >    Cleared system reset reasons [0x08000800 =3D> 0x00000800]
> >                                     ^   ^         ^   ^
> >=20
> > Now the user realizes that BIT(11) has nothing to do with reboot
> > reasons.
> >=20
> > This was literally the confusion I experienced. I had to take some time
> > looking for an appropriate public PPR and reading the PPR before
> > realizing this fact.
>=20
> Please explain in detail what confusion you were experiencing so that we =
can
> address it properly.

See above. I assumed BIT(11) was an undocumented reboot reason at that
time. I no longer felt confused once I read the PPR, which says "Reset:
0000_0800h."

That said, I am OK to remove the debug message printing the cleared
value. If we decide that it's better to remove it, I will send a [PATCH
v2].

> Thx.

Thanks,
Rong

