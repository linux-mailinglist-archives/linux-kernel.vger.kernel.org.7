Return-Path: <linux-kernel+bounces-786405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E93B35957
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D0816F2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75031984D;
	Tue, 26 Aug 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="C0E9pJaQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A921F131A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201772; cv=none; b=uFuADMuz3YyBRQC7l1mC1nvxpbddnKrSTQVIlNJO+NnAq9ZfExRxie5//FuTgHlEnOsMk6mH1QcQzCjNJWtonv8L67TJrF7e4Nt7RM4xfv0GkRtWtKYpEPNNXyIGUMgtw5IiOk4c0oYMo2Tl23YcRI4X9PG4IBid6q0SiPAzImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201772; c=relaxed/simple;
	bh=8uU1KPKs1gS7ndsz4z7IPqMABOsX5ZVIKofbCNNbstQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=se3TdJVwd8jk2ZOt62Gmeg7UME5fNGl7M5lj58sRw+4iR9OE1Wltk0t7dEuq+uaZ/UWkzG6zVpckxo5Bl3rnT+gr+rLbb/h11yGh13ZCriCZAoiZ0oRk0AVpXEv3rl0xDNJTgPYYwZjpwXwsoJZ9691zS3SK2VKxXQdMdSdjaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=C0E9pJaQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756201768; x=1756806568; i=efault@gmx.de;
	bh=Eubsq0DCVMLxbypxGYmdOVjC2vqcNSirR74nyEAB2MQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C0E9pJaQ1JcYsRlyaCLx08P2vBO/NtUGPkwH1fgyniyBWbSe/SKIr/Qltdc22sDz
	 35blLmya9r9q7yPs2T9/xIVtD863KHz0P7Kuch25/x0pCUlO+ax7Sn5E/5sGAMqKk
	 jG7u9GxISlGTc5XOTAeXLi4+Bt7HpWMAat7rrjk+rByEK5deyZ6aVEDvw/gGKYawD
	 ionaGjR7WF1nZncIUBWlPE94z6xLfQFxR5DOSiwcvVsXAgajVeEIkzWg0RMYeKrhv
	 qCIVJBmb1MS8AWgUHZXCfFsPTEvv+zTt0Wyr4OiGWwxWCWrcWK8+CPQUm9EFb/x8Z
	 uZ7B26Bn26Ed/5eyVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYPi-1uJjXs1HDs-00emjo; Tue, 26
 Aug 2025 11:49:28 +0200
Message-ID: <e32a52852025d522f44d9d6ccc88c716ff432f8f.camel@gmx.de>
Subject: Re: netpoll:  raspberrypi [4 5]  driver locking woes
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Robert Hancock <robert.hancock@calian.com>, Doug Berger
 <opendmb@gmail.com>,  Florian Fainelli <florian.fainelli@broadcom.com>,
 Breno Leitao <leitao@debian.org>
Date: Tue, 26 Aug 2025 11:49:27 +0200
In-Reply-To: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
References: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:iIaEaxmhs6BrR/bThHSnlmV9REZBw3KYHEmgp9ejL5eovVQkQNT
 3beUPrY5dKqeAZa+Pq5kAeZEz8sqdqXxd1Ym3QwqUeJlq4nO7We79eqyJt5lUnpmqY4XZ5w
 JNRdcTHgLLzCVUNBM5HHPcpSLi/rI+NiiwHaTXQaaxfH13V5KYgitmZ/dLcOWYQoaXqQlPM
 isData3MyEX7VSNR92oXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V54JRaTC3Kw=;hkVPFNpeUhhzyqzIY8CuZI+zlIo
 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
 23Ol6GVYBKP5nu3A=

On Mon, 2025-08-25 at 07:53 +0200, Mike Galbraith wrote:
>=20
> On the pi4, lockdep muttered about ring->lock in bcmgenet_xmit() and
> bcmgenet_tx_poll() - switching to irqsave/restore spinlock variants
> there silenced it.

I went ahead and submitted the pi4 patchlet.

The pi5 gripe fix is equally trivial, but submitting that is pointless
given there's something else amiss in fingered commit.  This is all of
the crash info that escapes the box w/wo gripes silenced.

[   51.688868] sysrq: Trigger a crash
[   51.688892] Kernel panic - not syncing: sysrq triggered crash
[   51.698066] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc2-=
v8-lockdep #533 PREEMPTLAZY
[   51.707234] Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
[   51.713085] Call trace:
[   51.715532]  show_stack+0x20/0x38 (C)
[   51.719206]  dump_stack_lvl+0x38/0xd0
[   51.722878]  dump_stack+0x18/0x28

That aspect is a punt and run atm (time.. and dash of laziness:).

	-Mike

