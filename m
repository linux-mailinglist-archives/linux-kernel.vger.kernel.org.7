Return-Path: <linux-kernel+bounces-794722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C909AB3E652
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204D9161862
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F85338F4D;
	Mon,  1 Sep 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Vt/U2G37"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46130E83E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735046; cv=none; b=afAKTKzaslPMOwW9EVR4mvc23Fm+dHUleUT++Ez1rXuo+F91hIgXwJzKOOTlhYOLzAh/FtHJEtZxkQ52od9D8XlE6HmKyr77ICDhyd1wgy6P8ksRx5HCenZ/HdFoVjlbdV6CraimSIW9SB8INESJSXFS0lvyXB1ABOcSFLXAEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735046; c=relaxed/simple;
	bh=GHrt0LM9nbPCbupTgmjLJQx5zARBZ6P05ZbEdma6MMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8U+Bb15CjNxz9LplDJDS4wznvHuVLEXJ2xVEb/gyyivTDKEyYnbFTdD2aowdbvVfNlzEB8ask8sE0WMzYNFUZ1z9UNXEriZyUxJNAYa5o5BG9ctmPBAHx2B1uzUwL0Uh7oD6+uf7wpRzLGasJqvYXgM9KMSqFWiN1SCnftz5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Vt/U2G37 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CB4F40E01A3;
	Mon,  1 Sep 2025 13:57:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0H9eZkE-jJxk; Mon,  1 Sep 2025 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756735037; bh=Znr3mZuqE0ZXKnsjilAVz//1HApGQXQmCCHkjwAre7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vt/U2G376BTLM1J4Fo2hiqdZnhk4xEOOLJ2hDDIpGEZsFXqueM11IBOfboJ8/i3TY
	 Jv/uRZ94pvbfmotYtQ5duVoyu9/U5lXeBIGtN8KCl9uj79ahk44MqkBoycZXQ3tqi5
	 VI0BR5M2AFAWEJU5Qj7BLGxxsGzj5SdkevYr7/+iYMPdFYFrNoJQcfrwNUce8EITW4
	 IQRNs7tspMZOG0BAkb6pEBZzmKE8BF5FbRxG4KEIbY8LOykZ5g1Hv6KN8SaZdp5j22
	 d5LNQNoNm4dWWvozfVWLG7EAqQBiqV+dMbk3puPk7V0e9rqsB2GD3DPONMIi8daHGc
	 G06ySPHu4fBTCuMTws+DzFvezPsGzfQRBB5JW2WGq5rNtvE7Veh4tQuX6p4g39FU8b
	 Tjcqx01haz8Zz3/ZyWVqmA2sZZVZc6fX2nfpEV0Sii6MuuGpnFVuQqC9wKhqQ8dwPz
	 yPazORW2dweRDHF4cCDcdbw0+m+TKp04TTDeXjLN36z0vot3DwwqiMYE+Hak33cvDP
	 CiyUQrM/wXHzBt7zPDadei69vdn72unuoW5BbKBcfjkiTwW1hmxTlq27NQDdxuzly4
	 mC5wVP4fkqB/ag8MGxfXXG4DSB8/kvztGk1EEd0PzXbsPaPRl9LV0DBxv2S8oTeR8/
	 nMVoDtuOjtkfW2AZCII1vU/o=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BC31240E01A2;
	Mon,  1 Sep 2025 13:57:04 +0000 (UTC)
Date: Mon, 1 Sep 2025 15:57:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <llong@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
Message-ID: <20250901135703.GCaLWmLyQuwuLcVygc@fat_crate.local>
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
 <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
 <20250828182037.qkdKVaTN@linutronix.de>
 <c61e7737-bfc7-4de8-962e-652aa3dbfd40@igalia.com>
 <20250829061624.sC9Bavj9@linutronix.de>
 <20250829100705.GBaLF7ycOvksu9H6KN@fat_crate.local>
 <64deb0ae-5641-4ceb-889e-0ef1087175fb@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64deb0ae-5641-4ceb-889e-0ef1087175fb@igalia.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 09:49:14AM -0300, Andr=C3=A9 Almeida wrote:
> Sure, I don't want to hurry things, I'm just trying to understand bette=
r the
> rationale of having this for the next cycle, and if I would have to wai=
t or
> not till the next kernel release to send the patch :)

You don't have to wait for any release - you just send it out when it is =
ready
and the maintainers decide.

If you want to specify something about the patch, you can put your note u=
nder
the "---" line and that's it.

HTH.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

