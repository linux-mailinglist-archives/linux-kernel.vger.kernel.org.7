Return-Path: <linux-kernel+bounces-614840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F257A972C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57C317D2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034628FFE3;
	Tue, 22 Apr 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b7+I0bwy"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CFB28EA79
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339415; cv=none; b=s21h5DX6cXuzigP4ZHlx5BQ/DdzxpuXIh7KkWViyFmfzrxwYPrNskTkrjgWdPR+syCk42/uUv3BBXj+NeF4rzb4cE4qMSNWA0ibtLnMURX7Bf4PaeQExR7fLeoAf21puxYq+bouQG+RTNia6elTw6CUXbap/ao+tAyAg6m2dQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339415; c=relaxed/simple;
	bh=qHub41/86u9WEWcM1Mg22cJ6Zhr0Fexc5QzjsIThwPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkRI6ow+OAOjIySnV/nXqIReNY6mbnTQp7cgu7+CU8p8dAeOnhFlHarqCIJ9r0K6lYRRtn6M/7jf2VqisRNZZkUZYbTgahxCr9BUvx6wyndJs+AXJfjfbqs5yAlz3rsNYAyjECka2KIhO4w6NrCletJQXorBs5l+EtYRBUpHQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b7+I0bwy; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ff07872097so50483317b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745339413; x=1745944213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqKEbNLGhzwV9XEBdGBE6+HUfiIb/xIBVlRNIZDoITo=;
        b=b7+I0bwyl8jcr+29KLfzHBM+aT64dMM3tc8M9mILCm4UcHXW1iMQzva70UIdv2H4Vb
         0LQNs40lOtD93ddir8RMZXG9FDcwN2o5Rx0pGnmjSD2D2ZimKVN7VPNpdr/liWRPu93U
         vJHyEZw6BX3TP+bWM1F3zxDgxD0qhkxi9eDUCnA6dunU8iVwMK9IL4oNNClUje5FamV4
         j+OORHD9GyshjBBvmyTqh8iY7mqSV1xjS0bsdHYhGmtj0WD+w3ihmf1V9O8eMHkczmjv
         p/SNnod4xkWdiQzGoh/EW/Kc4vP6SOQOzPtKDBkvYeTkuVh7kPywXcsdbkZN/zA+hLe4
         /DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339413; x=1745944213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqKEbNLGhzwV9XEBdGBE6+HUfiIb/xIBVlRNIZDoITo=;
        b=UA0xar3zYKmBrsKQwOrGEykoPJXjum+3ezQ+d++wcp76uMHlfGXttOvXdfXTlE+BQ3
         51hLZy1MN5a7MW/5J9uG4QyrP9U5zEu0czyQnAU5vHBToVpO0qd9QtQVBFFGEP2RVT2S
         mV1fyI9Tjm5trhtAnOw8MTAr1VdV0bkFJqu/jscTuDcdveShqrIYO6rL0Xd/PqSj1ih1
         lyJGluwyyjL/Izwpaegw19U2tTq73MepSNdomnPJIGbjpdspLKhB2/+9WMPhp5VA3PtU
         WKXdeA0BqK86Iae0e0pv5Mol6Qoomtfl5VuJmfoHfaJxSi+o0nDk/a+9SkUn2LeOo9Sf
         K46g==
X-Forwarded-Encrypted: i=1; AJvYcCV0yjwlpXESM9gvdV7N+N3ylhhtVyyL0uXJ5B8QBmpW1RJvuBRjF4PnOyLukHEY/yEzF/wfq52Hb288sU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVz8s3+358texTyyLA9tVRMtTmrU4I0wAEuLFdvewKWoWBvPSM
	y7ItV5ikaMMagbEDTgS9aMB0HttjcJ+ce4dCTd8Tn0ItruYqE4sDPDq2N3yM4apieWjTMK63LzZ
	gW0+90oXWn06qrLuXnlMVKFBdqtECXuDN0k/j62MxosB8X1I=
X-Gm-Gg: ASbGncuQ9eh5Hnbsho4hpXeKaiC7eZb7alPOCc+UBNmmeO0m2Ejiyzc++P2GnS36pww
	0Lqx8IlnWbK4r7vi3XRey7c99uFa07UkbYEcNCdBxT3AuGVZJ0i9r6Et2U3bjVxYYoTP2IECmdu
	EjSPXHjJ/ZlO6+G+NRVeZV9Q==
X-Google-Smtp-Source: AGHT+IFV+Fl/M43pQ5C4mwjWmtEQVn4Q/KMbbjlHzVR5N2ztbMJY3fq7yDfY3/zkm5NX/tHqeSoyi5mBSi4LDPN1oo0=
X-Received: by 2002:a05:690c:7209:b0:6fe:c75a:4309 with SMTP id
 00721157ae682-706cce44e78mr218124297b3.38.1745339412762; Tue, 22 Apr 2025
 09:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b96c64d522cf1c46dce1b8987e83f2f41ff2e5ee.1742231027.git.rgb@redhat.com>
 <92e9622d6dd1bd3e59a36269275aa1fe@paul-moore.com> <aAe3wrAzD/7jBtHy@madcap2.tricolour.ca>
In-Reply-To: <aAe3wrAzD/7jBtHy@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Apr 2025 12:30:01 -0400
X-Gm-Features: ATxdqUEOFVSyq2d1v00GrCvVvc8dU83XbSJlmQt5G4oKG4Csn74EEhOQKDYLcUk
Message-ID: <CAHC9VhRhr0GMQB59DZ4-xJ788yEgAsUMBLNdYFL2UxioBUPhGQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit,module: restore audit logging in load failure case
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:37=E2=80=AFAM Richard Guy Briggs <rgb@redhat.com=
> wrote:
> On 2025-04-11 14:23, Paul Moore wrote:
> > On Mar 17, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:

...

> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 1fb9ad289a6f..efa62ace1b23 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -3346,7 +3346,7 @@ static int load_module(struct load_info *info, =
const char __user *uargs,
> > >
> > >     module_allocated =3D true;
> > >
> > > -   audit_log_kern_module(mod->name);
> > > +   audit_log_kern_module(info->name);
> > >
> > >     /* Reserve our place in the list. */
> > >     err =3D add_unformed_module(mod);
> > > @@ -3506,8 +3506,10 @@ static int load_module(struct load_info *info,=
 const char __user *uargs,
> > >      * failures once the proper module was allocated and
> > >      * before that.
> > >      */
> > > -   if (!module_allocated)
> > > +   if (!module_allocated) {
> > > +           audit_log_kern_module(info->name ? info->name : "(unavail=
able)");
> >
> > In keeping with audit tradition, wouldn't we want this to be "?" instea=
d
> > of "(unavailable)"?

Any comment on the above?  This is more important than the non-public link =
...

> > >             mod_stat_bump_becoming(info, flags);
> > > +   }
> > >     free_copy(info, flags);
> > >     return err;
> > >  }
> > > --
> > > 2.43.5

--=20
paul-moore.com

