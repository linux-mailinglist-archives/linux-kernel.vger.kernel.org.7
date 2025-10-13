Return-Path: <linux-kernel+bounces-851000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC48BD501D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A885E03D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC013277CAE;
	Mon, 13 Oct 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BAafWk04"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197B279335
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371901; cv=none; b=P/2qLfjZZnr8pTn/hEBvfBOpAYpI5FJJLkOytybZyGeFyVyYUC5R1w1Zt511jqknX4uKvfEDy5Gsjldh/N64d8Pej9bbuJcuyA5kNzY9nNZP8tw0duVToq/sFHlfF2qBoz/fPDezvIGkr084W83S8SHdHJV8ruUrQnGPKvQPXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371901; c=relaxed/simple;
	bh=kg/O8YEE7mR+ya0+LRSE57GVTGuGrt0BUIQcKJIGT5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu9LPPqHF9VYUYPrWQNH+o4uIMrmdZe2a2IAVRMw5VMu4B3lr9/AGhKhtISaKI39b9lJESbULrpXEJTPxYLaX3Ru3gWdmM+6P3CDPKKttCgk68LoBdiX8EnI8OUcUXga9CZWZhcVPrhlPr77/DMHN74C/TmwNWH/lGJhJHDXXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BAafWk04; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so5584494a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760371899; x=1760976699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqOTihtF3LWBkyrOGHrf9dtz4pV67L7r6ac9tYX6C1E=;
        b=BAafWk04W2IbJqD903TwCKpzbScLcVU1DKRkLGTFdkHM1jBvA3zQR9GbyFNH8of9oF
         hwsmFajD2xsR0xDY9YRutepiKkY4bbQKElitqEKuRwwL2mDvhsN/CtCGOC3xe0188Qhq
         LigN5AGNIzz0C4FR4VO0ylgKaMMxboX1i2qSCAFwvkvUcRpAXac/uVrDQnIektIi6zq7
         2uNzT8uUFDkS4MwP/H4SfleVSXY3Bn+jcB2ta3lMuMxFFc3KMyQ4CcKm8RtXBhj+IROF
         438Ah7Z9VdA5IMeWIFwxRff350vLN1dFuwoTVgsq42uxqLcVVgyFQyF0glugqziB0CUM
         7V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371899; x=1760976699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqOTihtF3LWBkyrOGHrf9dtz4pV67L7r6ac9tYX6C1E=;
        b=KhO5lvzVvCBVxD2HtOUYiuOECZUDO263qhDpApzxgHRD2/LsEBrspuTeCHQt+Ja0NM
         I+NY5Jw6U0n1jkcsUvj9+xfphhWUWv23qGDu1d0LSBCT8lv6s39c0v0Wpz9hHyF7iDLn
         YzX12iU9iDH41Tm2qPKKH8DOwYZlv+jFsQn7IJ2TAToSR32or+NtaoeTurR9nND+mrBc
         3Kv05kWDJJ/plAJtuJlw0K9jOW/9RyRSqwtABZ09ygpaT0n0GbxlG8/i+fC2ToY5uY4v
         aJc4XLrEBoUOzyU/07cOq7N9efblFO60KXPZS+W5PCLzWCke5t8U8MKZZePQd1MflV34
         7VuA==
X-Forwarded-Encrypted: i=1; AJvYcCUtZtK4owOnSOiJMHQD6THkZWf8z9HnkujBkfMNU2ALbubNUxSzkiMpGPGlUzKQQshmNLQ1uArTykDnUSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrIC/7BwqsuYNUTgUY0DEfnB7INDI9ETNgQ3ML71HwcyXmCNJ
	qO7dtsAwjitzWFGTfwYkI3sFLnfweITul1wvBS8aKZoAabqRD60rGaevDijf6gcWJLkMMTbO7PX
	wZUEuCMNpjUQeEW4TSYyUimC0/FCU/j/Cds/TJfm3
X-Gm-Gg: ASbGncvnfWmtwq5m+u2mA1mcdBZO4+NMYElAe64A1NvNfKJzo5b8PCHEQZVX1vJnKFy
	V9DA1VULRgveT4/HQn/ARt1HWMX7Kbhh3hBsMDjMV/jaBjLP3LG2zCPDjgP3MAP/JmvKwMDQXon
	ItD+yDAXeDUquTtkzkuv5H3HOYMk/Htl+ideMzWo6yi8uc8NSfIuCvYpQ9Smg603Wlp6lUjO3GJ
	RWAARsS1eHhlGI2DWQ+pyBPZA==
X-Google-Smtp-Source: AGHT+IHRsuUk9qzBCL3fBbXKncdyg4e+WegpXlz1W9aKK5q8PTZ1CSe8HMgR8w4ThEmt0m0Vt2wsoc3RPFAThEuvYAo=
X-Received: by 2002:a17:90b:1e0c:b0:32e:749d:fcb6 with SMTP id
 98e67ed59e1d1-33b51118ef7mr32930909a91.12.1760371898906; Mon, 13 Oct 2025
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
 <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com> <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
In-Reply-To: <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 12:11:26 -0400
X-Gm-Features: AS18NWDWa7MaOMrTZEmj_OT-vE-kCVjZdzIYuzWQVFZrpDBS2O2ZFbNWHUYu4oU
Message-ID: <CAHC9VhTSRkP=jNw8bLRx5em6MnX9HTywBqXGsJCBPQ9MKJym=g@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Sep 22, 2025 at 9:12=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > When would you recommend that I re-apply the corresponding userspace
> > patch to reserve this policy capability number for memfd_class?
> > After it is moved to selinux/dev? Understand that it isn't truly
> > reserved until it lands in a kernel.org kernel but would prefer to
> > reapply it sooner than that since there may be other policy capability
> > requests queueing up (e.g. bpf token) that should be done relative to
> > it. Can always revert it again if necessary, at least until another
> > userspace release is made (not sure on timeline for that).
>
> When it comes to API issues like this, my standard answer is "tagged
> release from Linus" as it is the safest option, but you know that
> already.
>
> The fuzzier answer is that unless something crazy happens, I'm likely
> going to move the patches, in order, from selinux/dev-staging into
> selinux/dev when the merge window closes.  This means that any
> policycap API additions for the next cycle are going to start with the
> memfd_class policycap, so it *should* be fairly safe to merge the
> userspace bits now, I just wouldn't do a userspace release with that
> API change until we see a tagged release from Linus.

... and the patch is now in selinux/dev, thanks everyone!

--=20
paul-moore.com

