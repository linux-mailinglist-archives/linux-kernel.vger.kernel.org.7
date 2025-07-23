Return-Path: <linux-kernel+bounces-743129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8BB0FAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831DB5828C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1BD226D00;
	Wed, 23 Jul 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jNTiKtP8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E982C60
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753299349; cv=none; b=cK8yXunC15uU8K+agVbymT2srr7WQBiMiPDlVlVlFgofiXiFPd7T+sfr+rxhkYJDpD0j8FBsNDMOqTDlIVyVBk8NRjQvqqVQEihkpSnFt0DQ3Ums2oZ9dZAS5bg2qYQM6Rnfzq+RXycuhQKYGDmpTGfDndtycYSH03JS/19rwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753299349; c=relaxed/simple;
	bh=3t04CfAcfguSMnfkELrewRjpAjzgBX4bvXYMo33VTug=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tSVQ4r69YU+rnKBELSejjD+6zbl+GxV8cptdnVPlKt1WYqORTClSPYo+dKGc9R10B4UJ3PZ4XTHVcpQudldWDwXRyW3aWONUfpsuedrguaEJ0hdTOH5C41UVXqAvsI91aSmPul8Qz/fi+WDfBkHWwCNny+nJsknuD8ldAN9lpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jNTiKtP8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A7F8440E026A;
	Wed, 23 Jul 2025 19:35:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1JPErwmGoCbx; Wed, 23 Jul 2025 19:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1753299340; bh=G51RX2t7e7lKAMQItKW9G1XyjrkizMxapcPLGG7VUfs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jNTiKtP8Icsqs7uRL+qTdqSZMYU+kMHNjRaknu/LQaR0bMuPS7yJqt6dntgY6aKQd
	 tar/lfZedylIhI4gsArKhvLfCxflU+NewbZxN/Xzu4DX01wIHVXai61QOHkSqlTazw
	 NIEzcxz1KjhuQ4W85kphCjsQ7s9XS5DL4J/K26jel1IC5k6j46z274nHKD7ajggXaA
	 czBohyL6nXj9mhRZ79NdKq3KjmND61UrjDbAUrpTuO15YvRwACsGf7YCWa3zLDq5Le
	 VCa84ekG18M2WuYk8PKmF4wlolx9W53EBvPgu8RLQkIZhWXTMF5N26raoR5LL5bMkc
	 a5lDM1Sn7GC69x0sRlKiycBZyCnIFOLjP6lp/EZ/qTTZYaX7lC9wkGtB04h/6xJHBy
	 T9Rp1/FQ3uw+Up6VxS0YamXQ/d3Y7udCp/+pFg1b//JIkTm+kVhZ+vQEpP+wh99tVD
	 /G3SJ5axla9xmZzVP/jS6y3ZS5qCHgzJVoN+suKw+j/vZsFMpewsXr7ae4T7JklSo/
	 voWFr2O+BF1zM88/IzLo4uF0lq6TZ3k9aWdFh5h/j6CRRwkCBNJUwlH0gLNgXDjEDc
	 po4EzMwfRn2Pb02D9v45me6u1FWYp6IZlW25ZZlOFxXfVuUPrELJyLZdIyoV6yMhFB
	 arqa8/NYL8tUEC+mBlnu/sB4=
Received: from [127.0.0.1] (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6591F40E0254;
	Wed, 23 Jul 2025 19:35:34 +0000 (UTC)
Date: Wed, 23 Jul 2025 22:35:31 +0300
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>,
 David Arcari <darcari@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
User-Agent: K-9 Mail for Android
In-Reply-To: <20250723183426.GA1158000@yaz-khff2.amd.com>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com> <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local> <20250723183426.GA1158000@yaz-khff2.amd.com>
Message-ID: <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 23, 2025 9:34:26 PM GMT+03:00, Yazen Ghannam <yazen=2Eghannam@amd=
=2Ecom> wrote:
>On Tue, Jul 22, 2025 at 06:56:15PM +0200, Borislav Petkov wrote:
>> On Mon, Jul 21, 2025 at 06:11:54PM +0000, Yazen Ghannam wrote:
>> > The reset reason value may be "all bits set", e=2Eg=2E 0xFFFFFFFF=2E =
This is a
>> > commonly used error response from hardware=2E This may occur due to a=
 real
>> > hardware issue or when running in a VM=2E
>>=20
>> Well, which is it Libing is reporting? VM or a real hw issue?
>>=20
>
>In this case, it was a VM=2E
>
>> If it is a VM, is that -1 the only thing a VMM returns when reading tha=
t
>> MMIO address or can it be anything?
>>=20
>> If latter, you need to check X86_FEATURE_HYPERVISOR=2E
>>=20
>> Same for a real hw issue=2E
>>=20
>> IOW, is -1 the *only* invalid data we can read here or are we playing
>> whack-a-mole with it?
>>=20
>
>I see you're point, but I don't think we can know for sure all possible
>cases=2E There are some reserved bits that shouldn't be set=2E But these
>definitions could change in the future=2E
>
>And it'd be a pain to try and verify combinations of bits and configs=2E
>Like can bit A and B be set together, or can bit C be set while running
>in a VM, or can bit D ever be set on Model Z?=20
>
>The -1 (all bits set) is the only "applies to all cases" invalid data,
>since this is a common hardware error response=2E So we can at least chec=
k
>for this=2E
>
>Thanks,
>Yazen

I think you should check both: HV or -1=2E

HV covers the VM angle as they don't emulate this and we simply should dis=
able this functionality when running as a guest=2E

-1 covers the known-bad hw value=2E

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

