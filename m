Return-Path: <linux-kernel+bounces-843500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C4DBBF97E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 474EB4F1781
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A1263F2D;
	Mon,  6 Oct 2025 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RR2M/KXl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120F25A2A2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759786927; cv=none; b=ntEUZJPhmcpzqlFQc+zi1ZL/IQxVr08j842tvJ8NRSFyZKF+NecPt0yaVRol0x0n3v0LVuwI8ZGTJMWk6laBLQfsP2OBx2JxEb6IH8y1A2TNIo9slHpsplfg6pvV/MK4J+E87IhTzzx+ljkv1tPHyrpSQT9hL1XNoxR784mYSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759786927; c=relaxed/simple;
	bh=Dr/v3AnbZBe2SUu6LwpBuFHKwpSZkIBctUdbZT0uDBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMRpPy1Su/+fJ5D+7bxydX6S1qI5xY9biqaSWbpxHXQgqB4RnSwltFMmHzaLfz+wGTPXS9AHYThPOQtg7szUPk7RhxrmTKsOeDCVmRcpRUnfEr3V40wHrm1QIElcL9CLLmCSdF7mdofmF1SyqJF3zHclp+OQyCNxG6i+Rn7pwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RR2M/KXl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3E43240E019F;
	Mon,  6 Oct 2025 21:42:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IjW6vkQBlsLT; Mon,  6 Oct 2025 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1759786919; bh=A5OQnOP+RJQOmPA+msbNRS3i/88Vd9mCxXbmIgIMNXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR2M/KXl3hNuiLHzyf8St4UKdmvLnHWqo99n62ygfC/aujxZE4ykCd1WV8kLuyTxc
	 KjbNalQD/gObFc1KAlgpOGt4ANprbA1J/mE1pFeAQ7j8cNI2eYXX4TnDT+Kdk3/d48
	 aeP4THJn0a8Nd1I4xM3m9R2mj9IbKlDu7DO7gQWDeWAPSfjOAu6tweHYbqWk99MZ9c
	 HXszqky96mXDw48ayhKaYyORxUG5Z25VskUbTWvf/SQJ4q9iiocatDrQDx13rm58+B
	 d9aOEtZT84sVUWaTD66R5zu3aQdu6nFNGinQNE/SI2JmLY0UkOwXEqLG+gtM3sHl/E
	 GHRCrLFlPvIJaK15eWcQstlSLQH642MCdYSfmB8MAWLCM667aW0j5PREugeghw4quN
	 wGVTkWVB1xumk/Qp6wkAW16Y8+GFXDUwgPAuWrT2X/7Xry8QEmUlQ59vnidiy8e19y
	 EovWSe+DRqkczK5R+ZkEkuIbZ0ClMcfQDtZ9Tg9MTqj56EzkUchdsfITis2c5Mna2E
	 Js+ZysYkvr4HpiI/Y9qjD3lJfm2JaHt2ZVX+R8CqtPK9m9DJ37b0ZsU9KqMGQ3RCi7
	 C4GpKIDBS1W3x1mzyavc43JuxZiZYW3RvfSPg6GmF8qxphRa1mRbYmk96nm6/D0dOg
	 84Gr3y9LRiKN1Yr35sSPeNGc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BE83740E0196;
	Mon,  6 Oct 2025 21:41:49 +0000 (UTC)
Date: Mon, 6 Oct 2025 23:41:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rong Zhang <i@rong.moe>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: Prevent reset reasons from being retained
 among boots
Message-ID: <20251006214148.GKaOQ3nNAl0BsC85Hf@fat_crate.local>
References: <20250913144245.23237-1-i@rong.moe>
 <20250916140227.GGaMlt8xSp3eMI8Veu@fat_crate.local>
 <1e07144c-da10-4817-a2c6-ea11988936ee@kernel.org>
 <a1eff492b192bbe68716b46c18cd7152951c6550.camel@rong.moe>
 <20251006133128.GCaOPEsFuhJI89YG8L@fat_crate.local>
 <9076062a9c0daafcc23bff616864299abc0353e8.camel@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9076062a9c0daafcc23bff616864299abc0353e8.camel@rong.moe>

On Tue, Oct 07, 2025 at 01:07:45AM +0800, Rong Zhang wrote:
> Perhaps we could improve the wording in the documentation? I.e., mentioning
> that non-listed bits have nothing to do with reboot reasons.

You don't need to document in that detail. That's in the code itself:
s5_reset_reason_txt is sparse and that already tells you that not every bit in
the corresponding register is a reboot reason. It could just as well be junk
for all we know...

> That said, I am OK to remove the debug message printing the cleared
> value. If we decide that it's better to remove it, I will send a [PATCH
> v2].

The fix should be to simply write back the value read before we return from
that function.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

