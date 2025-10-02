Return-Path: <linux-kernel+bounces-840175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D4BB3BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDF83A58D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59D24DFF9;
	Thu,  2 Oct 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUiUl0pz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182C1A3165
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404646; cv=none; b=MPc1L9SscT0yLV1RKt5nT6LUrXOOaVCGSsQrlA6kgdrK2UIG67yFSuD7+UAAgFmxTYi4GFCHgYMkhkb2i1NmX/O12Qj/jzJ6izfC6wvu3SYwYvN2ewXKshlCh2ORxX+R+4g5RfdFn5PtkWU6yf3nb/twp2tcU+KFmMv8ZDDmQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404646; c=relaxed/simple;
	bh=RQX1NrwSl34NR56s6r7Eq4byEhj8c1P2Mj4LF6PvM/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUPjnu0iGvyHHQv70Rh7aJJ2NRNXKiz3MlNYfJ72sFVDRu6A75AHXuYF9CvJ9d6FrpRDs8uyyX63OojGHftXi2HPfHzAcS4omjVWg/LS5IKvDmj5HqlKUY4fEuow4r9lCl6yfeI3PeqyC0D7wVB1mXnkUlrprBaD6vqEOJQGFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUiUl0pz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759404643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vgnKlLoouS3JtpeFvZfGtYcXm2a9bedZ8zcilOwZLtg=;
	b=IUiUl0pzGYthahOiOPEz2OoGU5yYX0f8T5I5dZJi5qy6hZtAqqL2P2vq9TKdYDCPiTWZk3
	kS2FD95c/jLtIlbskIBtyiM46QZmJpuznP4PhBQT+24kPVr8pD7Oxb8G7n94rWIHO5YoAl
	eO0R2JUHrdcsGh0CmSE6wGcwM1P9VqA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Vu2Y5PI0NSiF0sU0dgmwcA-1; Thu, 02 Oct 2025 07:30:41 -0400
X-MC-Unique: Vu2Y5PI0NSiF0sU0dgmwcA-1
X-Mimecast-MFC-AGG-ID: Vu2Y5PI0NSiF0sU0dgmwcA_1759404640
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso1241374f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404640; x=1760009440;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgnKlLoouS3JtpeFvZfGtYcXm2a9bedZ8zcilOwZLtg=;
        b=hXdagHy5V95F7j2qqGeXwgBgjAs04LUm1ZuxyHH4Kwoea+4QIXSTD+DcCMcfwAVsg6
         K3HxlDeMDKZNtKMFzWexuZj4Wnx1ow+dm3M3WdLY5uxPcdDY2MLpCKQEN9Fjpkc8mpCE
         GjtmfaEqQTIkNM7QMINoErZ6leJTSH41XXu5THfh71ZuGL1VHxm3ORIqUgoyy3+0SDTP
         CmCh/3Oh6YbJ84RAmyk2cln5gu0hYzKgr9L1Diuv9v4GdczpFcdZ4tb+HFHUQzsgergo
         1hv7qGZbQe8D9XfaHrXukgGeQlZUL8QNxnzQDZTES/qPVmXQqje2islqbnT9hY1NHCox
         3bXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU07Feh+JAEi4JgZY4nQVf/8KE/u8a3iDm5h+5FN6pEOrOLoO1HhrCnJBu2Yswvy1QLkFAEPUTHd8ELJwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhbO1HG1iIPbuYBakG/Ztcwq2jdX+S16+EbEBSVVjnm4dGUgY
	OIE6T3nrsHmQ+/fkoBRBzZOwzwW25glzw30jH4MTJhMj46V7qReA5MPy70FFyuVlnScy5SCJI1o
	U9sqyx13ny9baB91VHO6a6TKhx97M+Oo7kiK+ndjGqvA6Wc69hcicFXzq+2zWgWwCEw==
X-Gm-Gg: ASbGncvhlSdcP59jqIjCNjcO/Pd1NfUbXGEGVMgp2X02PjKh3ep3/9cji+4x+NAYca5
	rTyoJTBHFj3tpf4DlWVGlHtDJecS+vkGLNKSiDUNkJk2H/QLC06MO2Zz0XA9rZ4u5LGZGmWBob4
	Eh8spTfkPhst9/jW10stg8L9Tjb97ypn++JnadC8J6vzkRvymg1FZMJdA2Ad6Cfo96BsU9M7ga1
	EsmGrMAQNqNPjWXC8CTA7CLgdIg5G+xItUcn7QE4mOuqWposmgyMOEyzwFLRuvE39s5bMSYP2UE
	lADMXF6vD3JEEzbo2ynHbF41xQlxRZS7wVAOchet3xONTKl0MYWlBz6xrlUbfEMsgM2lnBs=
X-Received: by 2002:a5d:5849:0:b0:3e7:4265:66de with SMTP id ffacd0b85a97d-425577e4a34mr3854400f8f.8.1759404640410;
        Thu, 02 Oct 2025 04:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg/p/3A3WClXyVi0cI2vseaqGhsWcOe/0Q7yc6NHO0UegG/kY8kVpI8noqmlGXEPJcWATvzQ==
X-Received: by 2002:a5d:5849:0:b0:3e7:4265:66de with SMTP id ffacd0b85a97d-425577e4a34mr3854386f8f.8.1759404639960;
        Thu, 02 Oct 2025 04:30:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a8542sm3262416f8f.9.2025.10.02.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:30:39 -0700 (PDT)
Message-ID: <58243003fdba1c06d90576fcfec5096012318a27.camel@redhat.com>
Subject: Re: [PATCH v2 03/20] rv: Unify DA event handling functions across
 monitor types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Thu, 02 Oct 2025 13:30:38 +0200
In-Reply-To: <87a5297jij.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-4-gmonaco@redhat.com> <87a5297jij.fsf@yellow.woof>
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

On Thu, 2025-10-02 at 11:14 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +/*
> > + * da_get_task - return the task associated to the monitor
> > + */
> > +static inline struct task_struct *da_get_task(struct da_monitor *da_mo=
n)
> > +{
> > +	return container_of(da_mon, struct task_struct,
> > rv[task_mon_slot].da_mon);
> > +}
>=20
> This function is not used? Maybe later in the series, let me keep looking=
..

Right, this doesn't belong here, I should add it later..

>=20
> > =C2=A0static inline bool da_handle_start_event(enum events event)
> > =C2=A0{
> > -	struct da_monitor *da_mon;
> > -
> > =C2=A0	if (!da_monitor_enabled())
> > =C2=A0		return 0;
>=20
> Can't this part be shared between different monitor types?
>=20
> Same for the other handle functions.

Mmh good point, I left it separate because the per-object monitors (later i=
n the
series) do a bit more before calling the __da_handle_* functions (like some
potential allocation).

But it's probably not a big deal to let them do that in any case, consideri=
ng
da_monitor_enabled() is false only during teardown or with monitoring off, =
and
in neither case a superfluous allocation should cause problems.

Thanks,
Gabriele


