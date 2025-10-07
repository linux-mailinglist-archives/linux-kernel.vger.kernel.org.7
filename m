Return-Path: <linux-kernel+bounces-844572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2243BC23F4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3E6C4F0BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC02E7F30;
	Tue,  7 Oct 2025 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="AZeqs+Un"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE12DEA90
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857860; cv=none; b=m2v3Mp8yWJyyiOGBm/2iyxRz/+W6d7Z6MhV6zct91O+YQBlV6JOyc9gwCghqQfuSXpFBe3zp9V9VtgorytogofccFyxTmw8I4m0Grx1zmj3kBHAUjoTwN5tX6tBjlIcjzKEWhUjZ1U23UA8qrUF2PY59KaI4JpWj+VBI1hccgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857860; c=relaxed/simple;
	bh=2lsp5SuMzpDkwG9rfeGHdBJ+q4tUZPIiVjrr5lsdeRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dyfnfqttsmg3ebT00KiXs9UiBQJQoKMAnfT/UtOMeoqV4kUBf/DeoMIpc04sLx0Sdlfu33HOvKPvXdkiycPGBswtsOs6C8CazXqUetzsQTX5VV9Ju+t8lODdIh7lPM0KmCThOkfI01qgX1dC7wOdmpomm3IqwRDKdEMDCoaumBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=AZeqs+Un; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2lsp5SuMzpDkwG9rfeGHdBJ+q4tUZPIiVjrr5lsdeRo=; b=AZeqs+Unn2xKZCf3Sa/u120GSX
	1l2h09u1Zrqmk5aFt5sUHaxYHBqitldfvnVoS3sgREbNtc98vvAmrCLybdouHHrJvF0hvJb+rO90T
	2XuQifFOujXzJ3mVMneV4DoMNWJ0llQ7W+vZOQg27dGmwsAQ1e6gcQzm7En2MwQkq+4QI0CY1WzWt
	6/lGrGd8CBueXIi+Xc1NrMZm/uzD0Z/QjRUnGD8+ZXOaTocx5SIf4GCPLE4xjtz8s2QVfHqSJDRoA
	LqrHxhUiU9upiPbKVaqK7qMiN97uyU6z7X5q+FGBfR/r9hnHLE4psnoGGSnZkaD8APLqqu60vwIiZ
	LCSM9d5w==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1v6BP3-000000004On-39Dz;
	Tue, 07 Oct 2025 13:23:09 -0400
Message-ID: <cbd56835c1b8dc2609019193d896d3f0ec7346ad.camel@surriel.com>
Subject: Re: [PATCH] x86/mm: fix overflow in __cpa_addr
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@intel.com>, syzbot
	 <syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 kas@kernel.org, 	kevin.brodsky@arm.com, linux-kernel@vger.kernel.org,
 luto@kernel.org, 	mingo@redhat.com, peterz@infradead.org, rppt@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, wei.liu@kernel.org, 
	x86@kernel.org, yu-cheng.yu@intel.com
Date: Tue, 07 Oct 2025 13:23:08 -0400
In-Reply-To: <e7c10342-93c8-466f-8f23-7d256d016681@intel.com>
References: <68e2ff90.050a0220.2c17c1.0038.GAE@google.com>
	 <20251005234805.6fedaccb@fangorn>
	 <e7c10342-93c8-466f-8f23-7d256d016681@intel.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 15:22 -0700, Dave Hansen wrote:
> On 10/5/25 20:48, Rik van Riel wrote:
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Cc: stable@kernel.org
> > Reported-by: syzbot+afec6555eef563c66c97@syzkaller.appspotmail.com
> > Fixes: 86e6815b316e ("x86/mm: Change cpa_flush() to call
> > flush_kernel_range() directly")
>=20
> Hi Folks,
>=20
> Thanks for the quick fix here!
>=20
> But this doesn't need to go to stable, right? I think it just went to
> Linus during the merge window last week so it never made it to a
> release, so won't need a stable backport.
>=20
Oh good point.

I had totally lost track of when the problem
was merged upstream in the first place.

--=20
All Rights Reversed.

