Return-Path: <linux-kernel+bounces-784056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECAB3360F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749701B20698
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2613423185D;
	Mon, 25 Aug 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="K8zTCLSM"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE30253F20
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101232; cv=none; b=M1Dx9D+l+vhjY78z3Bmk1lspWZTO/LYs4jBWWnLz5sUmWjXXZIkK9VkPvjtfu5A+KC2ZNx5h5bZDEyV2snm6Gp5D3Zs/A7ojfnPtC9QoO2NfMubnBNexntojclI0aev/lWqISS56htLMWYBw90VdbWgOeRkil69k69VbfP3ANPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101232; c=relaxed/simple;
	bh=nLP/883NaE6R2aWGjB32xB4LsPuYQAR4+375XN9HYQI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=LViV3u5xHD5pl5bp65dhsgiiyLEIv87yTscgTrshLt+NCkp73xbmdH8cYIVE9r0qEhvBgebm6cWhi/BV8hFMlQVsytJhJcGjiKeRQAg8BKtOBQFr79aJiMF61ktbUYDRjkp8DggwzRcXR3HQaBoz0bTeoLbG9AjfvvK+iIpVTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=K8zTCLSM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756101223; x=1756706023; i=efault@gmx.de;
	bh=9v9m21++G//ynIXdxrX/MEEG0zUTjjh4tvkoa3Ds8T4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K8zTCLSMOh3z2hqg/zjwo14hGGnagqkvF3Mp69UQaHb7GwbhOYZPZd2rBT9NiYEE
	 EGH9Ghx113bRqhPrFWMvXhxtTagwGWXxbNRI/W0peqsOEMEmEPf0gv7ImXm2ijTum
	 DEHipg4XqmkM8Y3AbHDm8aX1nuVYochY5BIfHYNCWLV//qz9/OmdXNhct0fJDlgX7
	 LKJHuwbcVW+gFq6sHyhuQDodg7z1AIc/69+8pkNdmHzChEpyecF0rQrE9ZwGbv893
	 2O75Vx1KVnpFCArjtg2gvobuzs8x9ktGDWilpPG0HEi1gUW93bBD8ylqpUF/wrV6Z
	 muyurqASu/FXDEtNlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1urWbr0NyW-00Dnuc; Mon, 25
 Aug 2025 07:53:43 +0200
Message-ID: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
Subject: netpoll:  raspberrypi [4 5]  driver locking woes
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Robert Hancock <robert.hancock@calian.com>, Doug Berger
 <opendmb@gmail.com>,  Florian Fainelli <florian.fainelli@broadcom.com>,
 Breno Leitao <leitao@debian.org>
Date: Mon, 25 Aug 2025 07:53:42 +0200
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
X-Provags-ID: V03:K1:QlbhFeKh2nH5/qE3pNVWr7TdCFLu27wsh+glGzY8aQjQoSGMNlC
 +ZDkXB56NqR9YdbiJctDClDss0CZeMUa7hyEO3rWPQKCQ39hUGZ+X3Xyybm08S0YqvaZOgX
 8yrSNyIjjZEnmcsOHVr4+WrQEHgKzfsiccYmIzjIdCHgEYb4xuQaQkOiIBF/cSndJAHnovm
 hvq+fJ/Fv6av40IC72VTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ejPcs1WX4lE=;wPu4U7wgrKJF7s5+jm1AzMYn1je
 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
 q81VKaz2cc/CCkgw=

Greetings,

After meeting some netconsole+ieee80211 woes recently, I decided to
build a lockdep enabled 6.17-rc2 kernel for my rpi[45] and give it a go
on their wired nics just to make sure there were no surprises lurking..
but damn the bad luck, both cute/dinky boxen whimpered.

The pi5 met locking woes due to...

   138badbc21a0 net: macb: use NAPI for TX completion path

...injecting spin_lock/unlock_irq() into polling, which inspired
netpoll.c to point a finger directly at the driver.  A quick poke
didn't produce instant gratification, but a wedged in revert did.

On the pi4, lockdep muttered about ring->lock in bcmgenet_xmit() and
bcmgenet_tx_poll() - switching to irqsave/restore spinlock variants
there silenced it.

Note to readers: before turning on lockdep, perhaps consider whacking
lockdep_assert_held() instances in gpiolib.c.. ymmv, but here it would
have saved time and naughty language expenditure.

	-Mike

