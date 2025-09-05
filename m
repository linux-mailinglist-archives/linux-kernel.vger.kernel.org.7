Return-Path: <linux-kernel+bounces-803554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A855B4624F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF085B61925
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90B1E47B3;
	Fri,  5 Sep 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aaTiEZwj"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFF274B4A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097058; cv=none; b=B6nAhualEvJ3ON/ctlI7V0bq9OFV+xxw3yR0DNGG3beimcdTnEUISgNvYQ1hnFEs5SDGlLFDhZGQbzAqQLzfgchixKnpk36qwVFyf+7pBEVzTemesNfD2voS/WUqFfMkRd+6tuCh/O9bQRnaesU0zVGChbvFEqeSiRwJ///s2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097058; c=relaxed/simple;
	bh=n39RLZzesXy3Ya0i5FeCxBO0PaTXwkPBg/RaOa1/0y0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kztG7ZQFMecAAOTmjV2RckQMzzEqDNYvPerZuOsyGy5WjUguKmwhKXxEZKcQFTO+vHsNP8AlHwDUGbq4MYi5HY9mjk44YMkQa9Ju2HBe49A09QwxveHJ6pp/M6OR/E9LeItGcY9MkZH6YTuC87Ug/0Cc3vvzylrB5nh7TIDXNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aaTiEZwj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3df35a67434so1422541f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757097054; x=1757701854; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gBA+c06r4TFRMbFgk13btPJ6nLb1j4n/DqQJid5OtAA=;
        b=aaTiEZwjqKOTAXvkl2XZ7CVfPI70XzkL3dgOSKksiWtOYubvLkVB5um6bCaUawjgF1
         Ts2brFM7lPGck9PCOOVbbeLggsr41d4wuSckxVfVWEYL9ZKu117shHPXFzksUwrzKfr+
         aBOj+RRgv4jkDTuP/xyohGzGbwnedh1v+e872vdnIA34Y0wYiEJ8qxowKxUDQZ9C7jpC
         raneUvS6o5t7iEYLuw2iqYm9ShDPszUtQcMNm1WgmTPo0tXjxjUdNUspiFid1Ov/IOKB
         Wba9Hz9C/myJm/UbVj6E8pYp6/Z2plO9gzzbbynQDKaycjb0XFAcINgLjLcdYuAey+io
         mQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757097054; x=1757701854;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBA+c06r4TFRMbFgk13btPJ6nLb1j4n/DqQJid5OtAA=;
        b=rWHG5gRK/IH/e+AVwsBgpA6SGVHZ+dcDuZjZkBK81PsKmu4zDV+XcSsJNZgwwfE4CE
         2HHlYHvr6mhR4fLQ1xEVgxnymwIRT4ruNDgShu+c4IhCvriplhOK1ql69YN+K3mf3Vq7
         tzIY50hkVgcYiR6LseV9xhXeQj6HMyCx1I9arBmPNyC5gRcVMHOcWhLohvoANJmOM5Bz
         Yqs4lvNB+INi0PMjlqLFECRztbXGJHIMKuTZLWYMlHIU/hT5B0+V8nzZzVYyMQpSM8hl
         Jrq/deQOMmCQrp8dTbK1o1pUv6UN+GTVLspjHf1ZlgFOjXhegpdsQMlAEE64IsUqtKZk
         qISg==
X-Gm-Message-State: AOJu0YyhGlUTzsSRDQZa0ZGJCmn6AruYnag6E4b5ZVcIFjHHwJ8UZELe
	A9ycC6kQJ8GmC+W6c6GH1HpiT37MsCdNmA64QafXaptBGTxQMvNwOgvp4N5OWrkXTWI=
X-Gm-Gg: ASbGncvE7R2OWyjVLDr1ZZDRt8gk65nLvmTQX7goURM/VbvxO9xxY1zW4mtJvT6XUej
	G9yU2e3C8ur/J2tRqk4jM36Wl1s1b/rsqwEqupA4/ZvJYlluyCmRIWkYD8JQrr3Y2R6s00QQoSX
	HvXx7ngaGxRnW3V5cgpWf6GEPfTPuwhwbQ3qWwxRAiUfTES46l+yizB5bVo94G9SbKyk3koBaUi
	E9s6Il2diMVobMxva8YzQxHrrdFx9dS8Kx5H4lzhbMS3Wjy3yrnoTgTrkIMqGUGQGSZbXQ74akj
	xBEEmESi19/gBOihD8FFdmm4SMaHjLwv6bJlIhKrhZCbMkxTrPnmYC+JBaD9KTtjTjS1tzVT39D
	ysXpmK/J6kSg7wWLH8i/U9hdltxgiG0FEL5yDxvjLh3KA3OlyfcyWivhl/BuM
X-Google-Smtp-Source: AGHT+IF4mPKr9EHhGGhStUqmEX30pwsIH+zWFlH028qfz0Yo9D3G/S5D4m8JynrIhd9248xdacDfVQ==
X-Received: by 2002:a05:6000:1ac7:b0:3e0:854b:20f9 with SMTP id ffacd0b85a97d-3e0854b247bmr5439437f8f.19.1757097054518;
        Fri, 05 Sep 2025 11:30:54 -0700 (PDT)
Received: from ?IPv6:2804:5078:9a0:f000:58f2:fc97:371f:2? ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89a35fb95d2sm3700951241.15.2025.09.05.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:30:54 -0700 (PDT)
Message-ID: <85defbcb97090bcfa0995bbd58f8e41d8288ca44.camel@suse.com>
Subject: Re: [PATCH v3 3/4] printk: nbcon: Allow KDB to acquire the NBCON
 context
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt	 <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Date: Fri, 05 Sep 2025 15:30:48 -0300
In-Reply-To: <84y0qtdk99.fsf@jogness.linutronix.de>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
	 <20250902-nbcon-kgdboc-v3-3-cd30a8106f1c@suse.com>
	 <84y0qtdk99.fsf@jogness.linutronix.de>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 16:58 +0206, John Ogness wrote:
> On 2025-09-02, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index
> > ff218e95a505fd10521c2c4dfb00ad5ec5773953..352235a0eb4a484caccf86d3a
> > 57d1a149218ecec 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -255,6 +258,7 @@ static int
> > nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> > =C2=A0		 * interrupted by the panic CPU while printing.
> > =C2=A0		 */
> > =C2=A0		if (other_cpu_in_panic() &&
> > +		=C2=A0=C2=A0=C2=A0 READ_ONCE(kdb_printf_cpu) !=3D
> > raw_smp_processor_id() &&
>=20
> This needs some sort of ifdef CONFIG_KGDB_KDB wrapped around it.
> Maybe
> it would be cleaner to have some macro.

Ouch.. that's true!

>=20
> #ifdef CONFIG_KGDB_KDB
> #define KGDB_IS_ACTIVE() (READ_ONCE(kdb_printf_cpu) =3D=3D
> raw_smp_processor_id())
> #else
> #define KGDB_IS_ACTIVE() false
> #endif
>=20
> and then something like:
>=20
> 	if (other_cpu_in_panic() &&
> 	=C2=A0=C2=A0=C2=A0 !KGDB_IS_ACTIVE() &&
> 	=C2=A0=C2=A0=C2=A0 (!is_reacquire || cur->unsafe_takeover)) {
> 		return -EPERM;
> 	}
>=20
> Or however you prefer. We need to compile for !CONFIG_KGDB_KDB.

I like the idea! Let me prepare it for v4.

>=20
> John

