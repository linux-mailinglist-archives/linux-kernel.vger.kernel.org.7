Return-Path: <linux-kernel+bounces-878615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3FC211AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB091A27AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2D3655E0;
	Thu, 30 Oct 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLuw6ME4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC33655D7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840604; cv=none; b=YqAdsiKkGs/L4wcJRGjmE3gDNqquA4J9BO3v24pFYuHW+g6TsBO9G+TlZaiUQCeauifnZb0lVP9m8gRNpEhRItbtTNlabp3RQ6lgO0tyRdaSy0lSzGTqRmxwF9hRo4g0RvGXng+3992azVTySsoIEJqJusEloEl3FmIlnuutPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840604; c=relaxed/simple;
	bh=4W4DomT1bKm5nEeHL7VS+RF2uHeK5Ikke9+xIwF1LzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/CmrLabebzhUL2H70GZkLzDVeATKfaXgmYPBVXdwVnwOM0hcr1zkfsvk5PitmwmNZbXdgqlhyYvYjrvHpSsp8J49WOdtQLlmCj9s6qi+RhKYRmuakQZmIOS60NCLSLk1ywDOQ+FqtOCMKd795AoNybzmIIzZXzdKw64rlt0rBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLuw6ME4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761840601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Hax7setvriITJMNsRG/+yeC9Z6tKUkgjVm1leMgkCY=;
	b=SLuw6ME48Cyqewg6PgxDP8HdX4RseisyMstzhL//JV0doB88e9AFu/eHLGr8gxz82wfFU6
	WxGOZE6RG/4bq28epcDft+dJAT0rjAqqcAumkbgSlGdn//nB686fi9Z3Njl8ZwxRCFeEdI
	ur/ytcaknUiFNywJ+EcUTnnncrd+lks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-D3Ex_7iOOXuPGMxuklXbJw-1; Thu, 30 Oct 2025 12:10:00 -0400
X-MC-Unique: D3Ex_7iOOXuPGMxuklXbJw-1
X-Mimecast-MFC-AGG-ID: D3Ex_7iOOXuPGMxuklXbJw_1761840599
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42700160169so645650f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840599; x=1762445399;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hax7setvriITJMNsRG/+yeC9Z6tKUkgjVm1leMgkCY=;
        b=Ti47lQhCq8Ucyc/ExRZxn7/gSK6rwoYq3C2PsfCZ/0lEr+eXf/i7IPhCjLxkS70o/b
         rbjcTl8n5oYulW97tOSptPGOzuQLpBXAOuRcJtC5qD/vgadxTnaTOUNekdqDwbGBPlU9
         2CPyN09Gdj3afvk/gtis1Iq3YukPpxIPy4nuXJNWgQXLBoyO0Zpf+/uUzAHd70QmRV82
         fGdXmZflyeGLAiiKcnmfXx8q04Q+FJGTj1LRI3G7aoXPlxmrP0CsBMf1zhpNbV5GME1x
         +V1wbQUoztWsNoG3watCJ36l13yH7YnS6NMTDep6gAYiJfyZPyKkOP0x4N/kisLsDy4o
         8Mzw==
X-Forwarded-Encrypted: i=1; AJvYcCWT4jsI/kQ6aODwUpctRAJ9jTmxChChEqe2mTHpWC2J449/aY0jj7i8oA5Px4Db93X3J4lNx0RpvPs+eKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSSo4OI4m8hIw1w6uX2nnhXh47xgKZztZm1Lgyr5yPEt68aXb
	GwKEvrSX83oXQ7hMVe7EymMezLL2P21KDf9VfgsOZuaQom7DnNO4ZGpv8vqxTGV4Ss1x0WHK5oy
	LBqZX/AEYijirJ12w62/490ISg/RClJhBAqbvKKUkiroHt0+erAc/QTz98qtASpFZSvlgTp2s8V
	e/
X-Gm-Gg: ASbGnctQsrKHR7ursLMqcb6Zolc0nvFWieFDLHwAZ7XpFXlKbWfl2EJuuxFu2+Hlzqs
	juMD+1/TldjFsQLOQ8E2psrLMI9CoDePvmp+wdYuKZtV86KcPo+drnMdbaCVCRx8GJnEQIbm9t5
	G334RbAUSHA180wl1cIKStxllf6gpTGQ+iUHIjutA2tPGoRG6bPwtOFAWGVWsQ83neC70NCOFBy
	xHz1JVnudB6loqbYuAuTkclA6Dvc60Pt6Vchyh9Wm9kg1qDt2MK/pJ8HlX5ODVJBccccecTSvvY
	H/G7Ds0z4duPv2ERXoFD9SahK7o4uWkkNI7YR+fuS+G3CoKeZYLB/usShlxiuwaeEt3Sucvdji8
	AKxLJU8zt6GoUpq/fwDRjx6Gh
X-Received: by 2002:a05:6000:1a8a:b0:429:bc68:6cb6 with SMTP id ffacd0b85a97d-429bd6a7f2dmr106411f8f.45.1761840598815;
        Thu, 30 Oct 2025 09:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZxs8bpGbnNVIoDAe6PdcyB3L8gloV1c4inqLF1+EdAlNftG3JFOGDXBzGeTlikB6tzcwrbQ==
X-Received: by 2002:a05:6000:1a8a:b0:429:bc68:6cb6 with SMTP id ffacd0b85a97d-429bd6a7f2dmr106286f8f.45.1761840597421;
        Thu, 30 Oct 2025 09:09:57 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba3574a2sm3401670f8f.44.2025.10.30.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:09:57 -0700 (PDT)
Message-ID: <3ac28b2bf33086a77333791df39b779d55c31df0.camel@redhat.com>
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Waiman Long <llong@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Date: Thu, 30 Oct 2025 17:09:55 +0100
In-Reply-To: <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
References: <20251020112802.102451-1-gmonaco@redhat.com>
	 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
	 <aQNySRvImq2yaUef@localhost.localdomain>
	 <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Thu, 2025-10-30 at 11:37 -0400, Waiman Long wrote:
> =C2=A0
> On 10/30/25 10:12 AM, Frederic Weisbecker wrote:
> =C2=A0
> =C2=A0
> > =C2=A0
> > Hi Waiman,
> >=20
> > Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a =C3=A9crit :
> > =C2=A0
> > > =C2=A0
> > > On 10/20/25 7:27 AM, Gabriele Monaco wrote:
> > > =C2=A0
> > > > =C2=A0
> > > > The timer migration mechanism allows active CPUs to pull timers fro=
m
> > > > idle ones to improve the overall idle time. This is however undesir=
ed
> > > > when CPU intensive workloads run on isolated cores, as the algorith=
m
> > > > would move the timers from housekeeping to isolated cores, negative=
ly
> > > > affecting the isolation.
> > > >=20
> > > > Exclude isolated cores from the timer migration algorithm, extend t=
he
> > > > concept of unavailable cores, currently used for offline ones, to
> > > > isolated ones:
> > > > * A core is unavailable if isolated or offline;
> > > > * A core is available if non isolated and online;
> > > >=20
> > > > A core is considered unavailable as isolated if it belongs to:
> > > > * the isolcpus (domain) list
> > > > * an isolated cpuset
> > > > Except if it is:
> > > > * in the nohz_full list (already idle for the hierarchy)
> > > > * the nohz timekeeper core (must be available to handle global time=
rs)
> > > >=20
> > > > CPUs are added to the hierarchy during late boot, excluding isolate=
d
> > > > ones, the hierarchy is also adapted when the cpuset isolation chang=
es.
> > > >=20
> > > > Due to how the timer migration algorithm works, any CPU part of the
> > > > hierarchy can have their global timers pulled by remote CPUs and ha=
ve to
> > > > pull remote timers, only skipping pulling remote timers would break=
 the
> > > > logic.
> > > > For this reason, prevent isolated CPUs from pulling remote global
> > > > timers, but also the other way around: any global timer started on =
an
> > > > isolated CPU will run there. This does not break the concept of
> > > > isolation (global timers don't come from outside the CPU) and, if
> > > > considered inappropriate, can usually be mitigated with other isola=
tion
> > > > techniques (e.g. IRQ pinning).
> > > >=20
> > > > This effect was noticed on a 128 cores machine running oslat on the
> > > > isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs=
,
> > > > and the CPU with lowest count in a timer migration hierarchy (here =
1
> > > > and 65) appears as always active and continuously pulls global time=
rs,
> > > > from the housekeeping CPUs. This ends up moving driver work (e.g.
> > > > delayed work) to isolated CPUs and causes latency spikes:
> > > >=20
> > > > before the change:
> > > >=20
> > > > =C2=A0=C2=A0# oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > > =C2=A0=C2=A0...
> > > > =C2=A0=C2=A0=C2=A0Maximum:     1203 10 3 4 ... 5 (us)
> > > >=20
> > > > after the change:
> > > >=20
> > > > =C2=A0=C2=A0# oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > > =C2=A0=C2=A0...
> > > > =C2=A0=C2=A0=C2=A0Maximum:      10 4 3 4 3 ... 5 (us)
> > > >=20
> > > > The same behaviour was observed on a machine with as few as 20 core=
s /
> > > > 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
> > > >=20
> > > > The first 5 patches are preparatory work to change the concept of
> > > > online/offline to available/unavailable, keep track of those in a
> > > > separate cpumask cleanup the setting/clearing functions and change =
a
> > > > function name in cpuset code.
> > > >=20
> > > > Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated=
 and
> > > > nohz_full from covering all CPUs not leaving any housekeeping one. =
This
> > > > can lead to problems with the changes introduced in this series bec=
ause
> > > > no CPU would remain to handle global timers.
> > > >=20
> > > > Patch 9 extends the unavailable status to domain isolated CPUs, whi=
ch
> > > > is the main contribution of the series.
> > > >=20
> > > > This series is equivalent to v13 but rebased on v6.18-rc2.
> > > > =C2=A0
> > > =C2=A0
> > > Thomas,
> > >=20
> > > This patch series have undergone multiple round of reviews. Do you th=
ink
> > > it
> > > is good enough to be merged into tip?
> > >=20
> > > It does contain some cpuset code, but most of the changes are in the =
timer
> > > code. So I think it is better to go through the tip tree. It does hav=
e
> > > some
> > > minor conflicts with the current for-6.19 branch of the cgroup tree, =
but
> > > it
> > > can be easily resolved during merge.
> > >=20
> > > What do you think?
> > > =C2=A0
> > =C2=A0
> > Just wait a little, I realize I made a buggy suggestion to Gabriele and
> > a detail needs to be fixed.
> >=20
> > My bad...
> > =C2=A0
> =C2=A0
> OK, I thought you were OK with the timer changes. I guess Gabriele will h=
ave
> to send out a new version to address your finding.

Sure, I'm going to have a look at this next week and send a V14.

Thanks,
Gabriele


