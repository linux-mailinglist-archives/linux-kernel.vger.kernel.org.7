Return-Path: <linux-kernel+bounces-799428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B94B42B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C18F566295
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219182EA753;
	Wed,  3 Sep 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="8KP9Kji9"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBC2DAFDF;
	Wed,  3 Sep 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933492; cv=none; b=R+n2tHSElC3kBXddy37fdo5GjPFWLdQxMdr227Zx3xKT4UlUMNHgOH3zzclEBMnTPEAHtNOjQ6hBIsCSXRjSavLYl1zVLR15QeNrUgQrnm7oaXZMRnaiRvkL7RO1JSqCzXsZ0A2PWQsrxs/Mmj/mcMmrkU9M9pa3hMbr0O5+ZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933492; c=relaxed/simple;
	bh=Aub8+2KW6ka4yxz/44G9hz294FgdZ0GUxpv2KnY0iMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+6W0ojyhR/S2x9RffFwkoCyvKoTanJhYnvPWaI7B1aYmxE2PZsfgs1z6kpyc2YV9WFTeGH7featiTbn6rHXUPKdauvdFVvTMzhbSaJT5iR0CsOTai2klLw6o+ogiLxSIWYaVDhY285lGKiaAwA/1rem6ygDbJBDXTPRIdIA3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=8KP9Kji9; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CFbvXuQP5CTRMEKHeE4FeDjz0O1PKS9x4Y3aWSyWwH0=; b=8KP9Kji9sWa3dSDozI4+2iwEkZ
	fCYNpSmx6unTkiHnRSdZLpLPW//KnMohdc8SNE9lZzKl2ydjcvoTulBr8sCkTw/uPp0FO08yfHYKI
	kT8PASMwp1c+x7+1LRm4jMcOjrLKATtFU8pR06muY3aK0LNqUEUClIqV1PgO3nc55tLWhPTBp+rm8
	hnV8Vh3HGSRYKFdTsxGL5gZ4543nEvc9EPDETpN7Rop59VHwBIPF/MkbhBKgn7wqg3Vug68g5mYSE
	CR3gHzpeLf2zQrJCUW1K6ItLdkt9EmjEmfhjq4oktDexZ4zQW2AVjCktdEXan/tyumMpwWCuO3+4R
	fevdPsew==;
Date: Wed, 3 Sep 2025 23:04:46 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Sebastian Reichel
 <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/3] mfd: bd71828, bd71815 prepare for power-supply
 support
Message-ID: <20250903230446.0be3259d@akair>
In-Reply-To: <20250903122311.GN2163762@google.com>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
	<20250821-bd71828-charger-v3-1-cc74ac4e0fb9@kemnade.info>
	<20250903122311.GN2163762@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 3 Sep 2025 13:23:11 +0100
schrieb Lee Jones <lee@kernel.org>:

> On Thu, 21 Aug 2025, Andreas Kemnade wrote:
> 
> > From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > 
> > Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/mfd/rohm-bd71828.c       | 44 ++++++++++++++++++++++------
> >  include/linux/mfd/rohm-bd71828.h | 63 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 98 insertions(+), 9 deletions(-)  
> 
> Looks okay.
> 
> I'm guessing the Power patch depends on this one?
> 
yes,

> Would this break anything if taken on its own?
> 
no, so feel free to take it on its own, if we reach your deadline for
immutable branches before Sebastian adds his Reviewed-by/Acked-by.

Most discussions are about future ideas anyways.

Regards,
Andreas

