Return-Path: <linux-kernel+bounces-811736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1DB52D35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99606586ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260562EA147;
	Thu, 11 Sep 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XI5BQABJ"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245022264C7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582833; cv=none; b=sKYkQQPcGEdT7mvd4WK2QgwYiJBKVRJ6pVki9zK2yoHwm2Sx1BqxKKvucCfMh8vOxo1b2yHGkhQdQ7lIyXOsfLYB2FBJd3Hn9++AEMqH1HsOKaIl82VxNv/iqQ2gMrRZRRq9v2EjcpWx/587e2X+Htz1hTsv9kAyVrG5t+j6OuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582833; c=relaxed/simple;
	bh=mPzZxZC7kXMonZ38EaSepnC8+jn1j3kAR3sV1zOkMr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7N/BPCeE7fuT+yAKY0X57zNLubBLsagj47v37YpjzZz2o+0o6Tng9CS4xZYwu5GduEMs9G09s/Ms8kixrgTuLcBBxZSaykL/BZF7GvcnolCtBUGLprzEkLlocRrJiCX6gEpSBxZbljuzpObqA2oOwCaJRNDJh6cnMqzg/kpwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XI5BQABJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MoWNn7DHA78iwugknyQ5tFhWQzWHhiXfaQ0zWgavsSM=;
	t=1757582832; x=1758792432; b=XI5BQABJiFAlkLckQc10/KQII8segUyS1Ur0QPl50R3C61p
	/92LN/oBXCNNlaxHou9gDxRil3EtEM9YwouTAmbFxXcc6JNC0MqvGl3b+OduXar5I4C/bvheLQzt/
	+61TSr2QDZP2ORDpxCZHr3LTeeiKWonvG5tXynCtGUKI6sHNSSst3hXn5rI7YS/6DaTb44RcLfqP/
	KCi0KTOL/m6/8o8OC+AmRPEfZPN3JA4Nf9xXHK+/sUECdj7322bqXFF+0sqnyIHAbvWyjWqXmPSw9
	WYHYS1ImS6v3i69P3B7Lun8XCd2eUvEq9S7wRu05nTMEkVPOKtP68sm/GGvwuq5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwda5-0000000F0aa-27nQ;
	Thu, 11 Sep 2025 11:27:06 +0200
Message-ID: <78c8e39d9719a26c6e492e895b070794eb8218ea.camel@sipsolutions.net>
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Thu, 11 Sep 2025 11:27:04 +0200
In-Reply-To: <20250810055136.897712-6-tiwei.bie@linux.dev> (sfid-20250810_075306_773702_0F58F2CF)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-6-tiwei.bie@linux.dev>
	 (sfid-20250810_075306_773702_0F58F2CF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
>=20
>  void um_idle_sleep(void)
>  {
> -	if (time_travel_mode !=3D TT_MODE_OFF)
> +	if (time_travel_mode !=3D TT_MODE_OFF) {
>  		time_travel_sleep();
> -	else
> +	} else {
> +		raw_local_irq_enable();
>  		os_idle_sleep();
> +		raw_local_irq_disable();
> +	}

This seems wrong, with it, lockdep gets really unhappy, and if I remove
this change it seems to work OK?

I'll note that arch_cpu_idle() for x86 also doesn't change anything with
interrupts.

Was there something else that required this change that I'm missing?

johannes

