Return-Path: <linux-kernel+bounces-784607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A9B33E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E23481441
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70927F195;
	Mon, 25 Aug 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="x5881tFt"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60B26B96A;
	Mon, 25 Aug 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122649; cv=none; b=r8/mU7cARvwvCRfdXoqjQD2hR9wBlpohUtkWqrQWP+Vn8z0cUut1TXmNOO/br8drFaHDxKe3yUbX/96NO4hrCnNHuDRBB2+ZBEkPMACgtjgAXQB1bX19nx0ep1J/ixDCvaMIf9OuKWJhny8pwE+S/tNv5TLywba3mSUdS7+hV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122649; c=relaxed/simple;
	bh=IOgRJ2eleMpZ0vUdVq7/RiI9M9eXDoLDvXBtk7uBY4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKr1f3lz0zGveh9PorSgs7VcLPehGItUmvnjBOQNFtHYKe9KrsK4dirIg0WFo8VsjuknXWwume9QlozD21E6PlNnv54q3viEbyuAsdQm6aTxLC2bsqw6clpTForJPesvKLDC+pd4w4NbMufRsRHQIa30bMJOIxwkmav2mvBJjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=x5881tFt; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c9TdJ1kPkz9sWM;
	Mon, 25 Aug 2025 13:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756122644; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOgRJ2eleMpZ0vUdVq7/RiI9M9eXDoLDvXBtk7uBY4s=;
	b=x5881tFtTnZsbMZH99Fc8I37Q7+fNng5Pz2oIsX1crecmQ/oV0KJPU6O2cMBV3mO6pJ9R1
	th6ynfy0QWmonH9b4m53UTnbJdnmlTOwWPjCFTwAlZ1oCJKe+A00Yz8DCIiBfuW+DmcZcI
	Di07D0DmZlACD0GKPlT/x2HPe3JhRuzenRPuHcVmRQ4KURg8f+v7dbWknAMgoCTtNRuPEC
	HMw/GiYsnvZJZL6Xz85wVa3rSM2INlAOc0xoQU10+WcQmo6NYO+4QwxKsszXGLchyejkGR
	BVg98rtJo04n5YUaG2yfPPnPZ77ze9T/UyDL+ZPl1ZroxWMsJrvdSwUl0b708A==
Message-ID: <0f0cef136230d97e9181cd2e61a365d1ceb00cb7.camel@mailbox.org>
Subject: Re: [PATCH 0/3] ALSA: use vmalloc_array() to simplify code
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Qianfeng Rong <rongqianfeng@vivo.com>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Philipp
 Stanner <phasta@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, "open
 list:SOUND" <linux-sound@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 25 Aug 2025 13:50:40 +0200
In-Reply-To: <f1e66db3-980c-4e06-98cc-021c166e9b21@vivo.com>
References: <20250824135521.590780-1-rongqianfeng@vivo.com>
	 <aKxCbceDzTFom2Mq@smile.fi.intel.com>
	 <f1e66db3-980c-4e06-98cc-021c166e9b21@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: cb5060d04b1811c3c7f
X-MBO-RS-META: bxaotygh93575z97puainxsiuztaj6zr

On Mon, 2025-08-25 at 19:46 +0800, Qianfeng Rong wrote:
>=20
> =E5=9C=A8 2025/8/25 19:01, Andy Shevchenko =E5=86=99=E9=81=93:
> > On Sun, Aug 24, 2025 at 09:55:09PM +0800, Qianfeng Rong wrote:
> > > Remove array_size() calls and replace vmalloc() with vmalloc_array() =
to
> > > simplify the code and maintain consistency with existing kmalloc_arra=
y()
> > > usage.
> > >=20
> > > vmalloc_array() is also optimized better, resulting in less instructi=
ons
> > > being used [1].
> > Have you considered using sizeof(*...) where it makes sense?
> I believe that sizeof(*...) should preferably not be mixed with this patc=
h;
> instead, it should be addressed in a separate, independent patch that
> covers all relevant instances.
>=20
> Additionally, I understand that not everyone prefers using sizeof(*...), =
as
> it reduces readability.=C2=A0 What do you think, Andy?

I agree that should be addressed in a separate patch, if at all.

As for sizeof(*foo), one gets used to it. I think it's preferred in the
kernel often because it's more difficult to introduce bugs like so:

long *foo;

foo =3D kmalloc(sizeof(long) * 9001);

When you later change long *foo to int *foo and forget about the malloc
place, you'll get an overflow.

foo =3D kmalloc(sizeof(*foo) =E2=80=A6) can never have that problem.

Regards
P.


>=20
> Best regards,
> Qianfeng
> >=20


