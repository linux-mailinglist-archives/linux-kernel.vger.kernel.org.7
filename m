Return-Path: <linux-kernel+bounces-863309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFF2BF7837
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3177A1884EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00BF3431ED;
	Tue, 21 Oct 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqVcjBgv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992315A86D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062096; cv=none; b=NM/SVQ+hWOG/+WZTf9Yd7xcUoJUvOcqSwe/0zdSDPPdeba/Qv+JHHpzAlEHVtQrKcFvS1hCVGRFnWvp533PE3QN9W2Ntd7Qalvfa3WBaVKqQnFiKLwzmUSvWPeiX/O5/a4tAyVEVjVL3qUIYPmBB9bCqGN9rep6miTWEZMWEN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062096; c=relaxed/simple;
	bh=R+/Y3cKidgg8Pz09BG0nl39J+/VNa967FE5tqC4qY84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChzQcoXztcQZZSQflOXYvXMxT2u7wwxzMObjbLAVG4Tk2/x7dk7ObPovPkk/Tce3KBEKG8QuhrTZZS2QjRr4ZrPa2VzAMZ1sk+7vLIHEHUr5dZCH80kcC28M/1eC2SSSh6VGOlGSkAk76gV2YBlYyRc9DjCKPpz7MDdkOGnU2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqVcjBgv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KICcCCzwh6CAD3LYQzTxrECTgISFOrla0fpaF0z/dPc=;
	b=GqVcjBgv55hvdRr4KgImlXHo3nutQZWV8LODiVb/vfvEefNP4ZBTS3WtJBnOgx8HJG4xnD
	GE+qBZCZjdB8kfMLf3OxkmBJ/VPUPIgtMZMAa2lsvyrL6/OJld8Sze+2WLN/5HH3DpQsJq
	6P7xNAtdpf+CAXruiug8BWGFWqZn8sk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Smdiry0WPrOgudLd3IfPUQ-1; Tue, 21 Oct 2025 11:54:52 -0400
X-MC-Unique: Smdiry0WPrOgudLd3IfPUQ-1
X-Mimecast-MFC-AGG-ID: Smdiry0WPrOgudLd3IfPUQ_1761062091
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46eee58d405so28450415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062091; x=1761666891;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KICcCCzwh6CAD3LYQzTxrECTgISFOrla0fpaF0z/dPc=;
        b=dRWi7x8ujHS3864pzstiC0V4nsnY2P8fMfE2D/yR6u5Mz9ObZRGRG2xHzRFbDxgZyw
         F+17hxwBBL71gS87ArJhzWSvUaOa3A4n6LHcmYlJLrIb+yV/dkNiJBmhRZQycg0Ar3HB
         9hNsUutWL3jM75sctlDr+Twg9XIbao2uqRo50pixHdTPoSkFe4+Sq+FlcelUsP+x3HmG
         6uV4fyHndjA+mFTjfn2sTdIrduzcXghG5A7ILgYNZDdW6Sz303AIYSEs4yjDtTcEcgYo
         3lUQUKWmCXl/HlQN/M+MOWS56Fa7Tvi+pSVkic9ucosP4B0WroCqfz65elnRIKRUwji1
         VkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0/d2dlQXXMETAP8loa7Vx90FWpBEPMVMqgkH3GsNKnwTNDFGoDhRZRymb3ajBU29a7at9ZY00ncAaL2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzWZ1XEeVXorduEtN0xICMNX4hWNexDnLh/lpJHwirLOTy16m
	j/ADR61oPuiNwuwMVswMVXfoPAVrlKzRdpuLuaEQqivS7ww+qKEANNjUoaqtemX+xvCcBNHMKhI
	41T2TcBKFBrRCsyrV6h1GIs7DQymjqVVNeb4T9k6bxanfx6qTRdksMwTecfTyce2GUQ==
X-Gm-Gg: ASbGncvtBhT3onLnZs/agWqcx3lwXWDqXH2Gs9pkmvd/2qCQ+iSbJe9tQ12ZZWG/7S/
	Pw/IrHRmg4cX7a4X+b3Vr3dYn/ZFV3/6iZDNYRtTOzM29ld6VpNHh8FTJJ+lGIzVy/dEjmRhwTX
	sKmVE1VDGGsZoTk9qR9Q/X7HNPFdj2/jkHy0mJgYBlEO4F6UKWMhbSmxkWRYLhEL0VDCofqOF2i
	aCcoTJhBGUoTmYZi116StlHwVGK5ZPgWm1WArDU3+LmxReb4LFQclKp2qSVsv4YmxdQf9KOW6PL
	XQzlE9cLFFyPS5dnHbKS6eJ6WWftgpuuFa8uQEsFBDYTsK5YYUzFnxKR/VxpVgwC7QPwhepHpRU
	1ekJvTz33koqbbK8j0Z5N+j/0
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr121691135e9.17.1761062090903;
        Tue, 21 Oct 2025 08:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8lxM/JFIrZe0gCiI3+DDDOAAYMMzRvDvH3Q6BMXVzzLrqfeZc4/96Yrfb6Kg7hAmNU9XU/w==
X-Received: by 2002:a05:600c:64cf:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-471178a80f7mr121690965e9.17.1761062090495;
        Tue, 21 Oct 2025 08:54:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d4b923sm18092205e9.14.2025.10.21.08.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:54:50 -0700 (PDT)
Message-ID: <866f10440f9edde8acd34e5a5d2965719ae5d723.camel@redhat.com>
Subject: Re: [PATCH v2 18/20] rv: Add support for per-object monitors in
 DA/HA
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 21 Oct 2025 17:54:48 +0200
In-Reply-To: <87plag1nb6.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-19-gmonaco@redhat.com> <87plag1nb6.fsf@yellow.woof>
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

On Tue, 2025-10-21 at 13:55 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +static inline struct da_monitor *da_create_storage(da_id_type id,
> > +						=C2=A0=C2=A0 monitor_target target,
> > +						=C2=A0=C2=A0 struct da_monitor
> > *da_mon,
> > +						=C2=A0=C2=A0 gfp_t flags)
> > +{
> > +	struct da_monitor_storage *mon_storage;
> > +
> > +	if (da_mon)
> > +		return da_mon;
>=20
> I think this 'if' should be moved to da_create_conditional() instead,
> because the "conditional" part should be implemented in the function
> whose name includes "conditional". I think that would make the code
> easier to follow, because one would already have a good guess what the
> function does without looking into the details.

I get this is confusing and poorly documented, also the _conditional functi=
on is
not more conditional than the other, so I'd really need to rethink the name=
 (if
it really needs to stay).

The main purpose of the functions under da_monitor_start_hook is to return =
a
(possibly new) storage, it's perfectly possible, even likely, that the da_m=
on is
not null, in such case we don't do any further allocation.

Ignoring the vagueness of the name, the two implementations of this hook ar=
e to
call an allocation (yes, always conditionally) or just assign the target to=
 a
pre-allocated storage.
Your suggestion of da_monitor_prepare_storage might fit both descriptions.

In fact, having something like kmalloc_nolock (if it works as I expect it w=
ould)
might save this gymnastics as we may not even care about pre-allocating, I'=
m
going to try it out and perhaps re-think this entire mess.

> > +static inline bool da_handle_start_event(da_id_type id, monitor_target
> > target,
> > +					 enum events event)
> > +{
> > +	struct da_monitor *da_mon;
> > +
> > +	if (!da_monitor_enabled())
> > +		return 0;
> > +	guard(rcu)();
> > +	da_mon =3D da_get_monitor(id, target);
> > +	da_mon =3D da_monitor_start_hook(id, target, da_mon);
>=20
> Do you plan this da_monitor_start_hook() macro to do anything other than
> storage preparation? If not, perhaps it is better to name it
> da_monitor_prepare_storage() or something like that, so that this is
> easier to follow.

That's a good point, this appears already only in per-object code, the gene=
ral
name is really just pointless.

Thanks,
Gabriele


