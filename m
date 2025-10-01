Return-Path: <linux-kernel+bounces-838263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35164BAED52
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E892A3ACAE2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43127B329;
	Wed,  1 Oct 2025 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="TghmYT0c"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A09299AA9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276814; cv=none; b=l3luqpRcPyRrIGqWrStMlsx0TSdv8ZyKoCPpPniWmchxGY6GQ3l0vXcmvDI5xNMIMt11aOJ9/+kX2Gd0R20MfOn3+IeVcIHPGgUF+C2tDlpsRqCmOp6/9BW2wrdr57zo0dyeGz7RxijXWmqkVEg9RFvpz56BWaTRyN0wjUZFJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276814; c=relaxed/simple;
	bh=UeF2kqlCiIsaahRpM1/ipTFg2h1NF4GwDR0zFLgVyTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y32u2wO4tqD5rKKWc27rlZ5yXFf6Mofv/dRYJoLUUif9FbJYbp+2Ldf1zn1ImEabxEdXdsyLcers4CMMRcq+hfN+qss4iTnkYcLE5kM1uRzYM11czF+LSQAdPoD/I/QXnsW0Z+T+tTpb6o0wciNYxBwpgnQYUZCzRA7C8Ui7lWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=TghmYT0c; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D0360240027
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1759276804; bh=kVsZQDI/xfxsAZ5IkF6mAwe7hS/maPtJ1Z1KLoSdD6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=TghmYT0cobh/aAWpE/+WC3uSIfn34a/88xLyR25VAxgW+wWfLGCcUsgKkx1Zil26o
	 lMnz73FpUb581PBoSvA7RGl0VNur0Wfv8uMYsTzBVgkZlN1MSE8etqDiWT+FZPGfJ6
	 /MQzTUR9YH3VOg4bWvKEJWbqxkkdJZ8LdyI3+5TSVwuODcTwa/RC4K/02da+XXtx5i
	 ktXqbbFDiagBAhhkRvj50vEKoJoshebNRJe3dtPs/jsg7k4yIBk1zhpz/44Y4WmX9y
	 YbW2zJ0RMrLfV8r8sF7WLG/GyvGaJkOiGvX5ZzkH87BooP5RWwvZMu1/usgGxH/CmV
	 ebfMNKnwljGfg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cbw6C5Mq1z6v0R;
	Wed,  1 Oct 2025 02:00:03 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tty tree
In-Reply-To: <20250729151404.03ac580e@canb.auug.org.au>
References: <20250729151404.03ac580e@canb.auug.org.au>
Date: Wed, 01 Oct 2025 00:00:04 +0000
Message-ID: <87frc3sd8d.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the tty tree, today's linux-next build (x86_64
> modules_install) failed like this:
>
> depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> depmod: ERROR: Found 2 modules in dependency cycles!

The cycle was introduced by commit

  b20d6576cdb3 ("serial: 8250: export RSA functions")

which exported RSA functions from 8250.ko to 8250_base.ko to fix this
issue:

  ERROR: modpost: "rsa_autoconfig" [drivers/tty/serial/8250/8250_base.ko] undefined!
  ERROR: modpost: "rsa_reset" [drivers/tty/serial/8250/8250_base.ko] undefined!
  ERROR: modpost: "rsa_disable" [drivers/tty/serial/8250/8250_base.ko] undefined!
  ERROR: modpost: "rsa_enable" [drivers/tty/serial/8250/8250_base.ko] undefined!

which was a regression introduced in this patchset[1].

Before this patchset there's no issue at all:

  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/8250/8250.ko
  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/8250/8250_base.ko
  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/8250/8250_exar.ko
  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/8250/8250_lpss.ko
  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/8250/8250_mid.ko
  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/8250/8250_pci.ko
  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/8250/8250_pericom.ko
  INSTALL /tmp/test_cycle/lib/modules/6.16.0-rc2/kernel/drivers/tty/serial/serial_base.ko

So circular dependency landed in b20d6576cdb3 since 8250_base already
depends on 8250.

I'm guessing the fix would be to merge 8250_base.ko into 8250.ko in
drivers/tty/serial/8250/Makefile?

Stephen, I mistakenly sent this off-list to you, ignore it.

[1]: https://lore.kernel.org/all/20250611100319.186924-1-jirislaby@kernel.org/

>
> I can't see what would have caused this (it actually appeared yesterday).
> I am not even sure it is something in the tty tree.

