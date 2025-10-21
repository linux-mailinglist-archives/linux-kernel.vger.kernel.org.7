Return-Path: <linux-kernel+bounces-863278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96CBF7747
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162E5188EA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3733C52E;
	Tue, 21 Oct 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dLkeUeFl"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA52239E97
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061502; cv=none; b=WCJWLu3T/xDf/Rn/wmKYWuKx+7VozA4gtjzV02+qCltIvHNARogYGEGQMPj3oV7+qj066ZeLmpSxVu6QT8meylj0ud5t3p73NNdRxliW2+yuG0fKSCQ5hylZ7nCpIODopI6b7yi09n0aT8jTy810cH98Z05+0sRwcasrxlKUDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061502; c=relaxed/simple;
	bh=2PFyqNZSot8EDSGMplRBObbfqgmY6ztn/ALY7W+G8Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHh0kR2ckMQPTF12rUqCxtAnCoWDvSiLi0Q3H7nbB/L4BRsPdbEQx8gf0ZYF8/soYe/cdNXbFhFaKQc4Ug7E23azIDmVJG7jxkZUppkFG6LjtHhiWBkIugtwtEhY2X/pTIKDw7QIje33Yb6X/y4MNNclR8DgaTTgDtogtXjdImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dLkeUeFl; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so1539a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761061499; x=1761666299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MK7K2Vi99xas8WktvZiAjv4QT6t/qx7SHQF2LdRMWg=;
        b=dLkeUeFlb3efPsoHwrpKxIHc5dh1aGja/uhFZ0nwX2XlcVc0oKRkWzXWEdcZuHC1ti
         0cgpbkTwMz1EDH6bbYdL/GWCg3Fvnbt0vS0Vgy8KZx4HlkV0+dcZtKx1lBJX+zZZs4Vg
         Wu/lkGvcnOG35aSx1qBwPWayjC03iQdMzT7QPGryTuJDFWD/H2+dUQFD2Yl7Rp9UhrKF
         6nhaxTaCdyFTJwTAKqw93a8fg4h35szY4IYDjyOWvPpfG/G6xIencPcMdT1yA5qJy4Dq
         CCDK5SqphaIfuofInBDESesq5ikqPyOOzhMHh0UtOPKLkm/JxV/41a6m2YWslid0+SpQ
         w/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061499; x=1761666299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MK7K2Vi99xas8WktvZiAjv4QT6t/qx7SHQF2LdRMWg=;
        b=iHW/dRbpI2ZETBNAibZHtFFDpuMNdoTHo5hxYkTfsjB6FPb8Rxd/6GsGyxkoSZMySS
         /EQ2EOWC5UnyNr+uB1ocqH0l1rBbwEw1W4ATpye37Cv9sHOz5ZEz2vF/RCsjQazW4Ayi
         b6zhVlBYiQvnKK9fWx9+PtmAoRc6KOAWVObGUXYybtz3nZMt1frZPNyQGb75bXy9ZiE1
         jM8swyRg5/eB+BR0pK7SuWEsTIq9xUp4XwvOw66LaCiyiFmVLg9i1OsoSrHhhp0TTgW4
         odz4TY/RxEFw2EuBSrmQkt7i4VuGuCg04/vMVRp89pqsKqSFQV4qHzavUIutfZJfC26B
         15Qg==
X-Gm-Message-State: AOJu0Yy/eDfiQzeXm3MwytdEQ7sH82HvLo/DXZwhQBjp+J24ohkZT+vI
	mpf7XQl60Prc5kUJO/yg7nGHnUJVizs6YHnGucYX9hd3ZWk9Y7H6bB+vtxt6SQ2jvLCMo+89Fkk
	b5YufsuFsdyb+7XVycTMOqVUcX7a5Gn8prZSfZBFJ
X-Gm-Gg: ASbGncvfCQ7nMouoFKt3ABaUywC6hSPVTVxs+RBVIHi/rplpHrFy2wXRGErU+S2+STI
	vRko2xR2OC1HIBreDlzX7uIbiduot4HcZjnbQudA0SC4AunPKYWEPgz5UkkLyWvgQ5x2Q6QGeFg
	J1/fNJXU5gkTzgbMiTJndgfYHKn+dv7ygxEU3eUvkj050XQMzsTOD43redA2E3VpS9UZHEOhr8t
	HMgDvpLDMykEEb/fKMVAwiL2oWgynFuASfyMHjOK5a6VsHZg6uHOUXTV1/M
X-Google-Smtp-Source: AGHT+IFQOGllR5Jxi/TrF28dWQPOXUr2TUQ1LEG9JjC84pIqFv6UuDKjZ+Hh5UHwdDry6HVzfiTcPXTufR+x4+xdPHY=
X-Received: by 2002:a17:90b:1a8f:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-33e21ef11efmr200209a91.8.1761061499140; Tue, 21 Oct 2025
 08:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQ_hv1ri1csrgGP+9RssCuJBDuOLSDowZRD5xZcDD2mPA@mail.gmail.com>
 <20251021123842.968605-1-zhanghongru@xiaomi.com>
In-Reply-To: <20251021123842.968605-1-zhanghongru@xiaomi.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Oct 2025 11:44:47 -0400
X-Gm-Features: AS18NWCTB9vDb1wg1H6rs7OmAJYTQeAAWNpZWN3LNEXMYxnDXbB0GiUgNAMn0pc
Message-ID: <CAHC9VhQeW7fFtB5uGRJhU7882MsSLazHmOZ0UKj=pX6PKiwz8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable
 during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:38=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
> > I would imagine that a very simple implementation would simply convert
> > the selinux_avc variable from an instance of selinux_avc to a RCU
> > protected selinux_avc pointer.  As the AVC already uses RCU, I think
> > the number of changes should be relatively minimal:
> >
> > * Ensure we wrap selinux_avc derefs with rcu_dereference().  This
> > should be the only real change needed for lookups and insertions as
> > every search through the AVC will start with deref'ing the selinux_avc
> > pointer.
> >
> > * Update avc_init() to allocate the cache slots with a default value,
> > fail if unable to allocate the cache memory.  If we ensure that the
> > selinux_avc pointer will always be valid, we can avoid having to check
> > it.
> >
> > * Policy (re)loads which would change the number of AVC cache slots
> > would allocate and initialize a new selinux_avc then swap the global
> > selinux_avc pointer under spinlock.  The old AVC cache could then be
> > free'd according to RCU rules.  I haven't thought about it too much,
> > but I suspect we could do away with flushing the old AVC in these
> > cases, even if we can't, flushing the old AVC is easy enough.
> >
> > > When increasing slot size, we could directly copy the contents from t=
he
> > > old table. When decreasing slot size, nodes exceeding the new slot si=
ze
> > > would need to be re-hashed and attached to appropriate positions.
> >
> > Changing the number of cache slots should happen infrequently enough
> > that I see no need to migrate the old entries to the new cache
> > instance.  It's a cache, it will fill back up naturally.
> >
> > > On my Android device, policies are fixed before system image release =
and
> > > don't change or load dynamically during system running. Using kernel
> > > parameters for adjustment ensures no additional locks or checks are n=
eede=3D
> > d
> > > during runtime table access, maintaining simplicity and efficiency of=
 the
> > > lookup code.
> >
> > If your system does not update its policy over the course of a single
> > boot, and presumably doesn't drastically change its behavior during
> > that time, there is another, simpler option that we should consider:
> > setting AVC_CACHE_SLOTS at compile time based on a Kconfig tunable.
> > The code change would essentially be one line:
> >
> >  #define AVC_CACHE_SLOTS   (2 << CONFIG_SECURITY_SELINUX_AVC_HASH_BITS)
> >
> > ... with a corresponding entry in security/selinux/Kconfig.  That
> > should be a very easy change, and if you set the default value such
> > that AVC_CACHE_SLOTS remains at 512, there should be no impact on
> > existing systems.
>
> Alright=EF=BC=8CI will add a CONFIG_SECURITY_SELINUX_AVC_HASH_BITS in
> security/selinux/Kconfig, the range is between 9 and 14 (512 : 16384),
> with a default value of 9. And then I will send a new patchset version.

That seems reasonable.  I'm sure you've seen it already, but you'll
likely need to modify AVC_DEF_CACHE_THRESHOLD as well ... or honestly
just remove it in favor of AVC_CACHE_SLOTS, it's only used to set an
initial value for the cache threshold.

> I will try to submit the final version in Q1 2026 based on the discussion
> (Because I have some planned Q4 work that hasn't been completed yet).

No worries, thank you!

--=20
paul-moore.com

