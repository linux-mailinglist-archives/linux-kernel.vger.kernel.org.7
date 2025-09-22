Return-Path: <linux-kernel+bounces-827783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7FDB92C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AECD3AB356
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0F2F0C5E;
	Mon, 22 Sep 2025 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a5L0TJsa"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CCF1519AC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569422; cv=none; b=NonQoAKqiy7Z3UZmEqwQ21+uzk8/RvL2UnVMBJ1/JS1zlPv4W6nyRjmOtFYI72zWZbaXnzw9sfb2jszLtpfZ7hCJoRqLHcre+8ShRz5l1GqJBCy4suamofeVMs82vFEemvZY+6gvkiP4mSGM1Yk+i6SbyRngweNFPzNyPirty6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569422; c=relaxed/simple;
	bh=M55kfbiA5WNrGJ3r6EqFqgctDNfA8Xd3Z8+bi9BHwqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTLUxh5Mu9AXKNCeJn5NtB4rrr6lh2jKnjJ4AvwPiGZosKzOlaWB2EQqH7sIoQlMXi4OR2nvDgu5/9iqU/P8JLi1RAAiyGPP8aQqBs8UMHAtOGXf/hs+Wa7yVFEUvNT1m11VSpxkRfHdyWz0L2DXj9jBhy/bwGPL0qDddtKzYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a5L0TJsa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd630so5040483a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758569419; x=1759174219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvdWOntfA4A2sQxeMILs61f9nOsNLek7agJHp14BnZw=;
        b=a5L0TJsaSgtelL6PwfSc5g1RGH5xXQFmKj5F1lLBAeFsG69TsSvyMsSrFNtc2wPL2a
         whvVf+1P6Xvn6utJdbFrhO8fyOhXDoBY2rlST9n/D0rmICcvUF5O1dzXv9inJoECHO9X
         ilXyo8nEQz1QpOhlnDnQmz0lHxNKPiNHUrv4jk12thJRYG6FqJ7zCf790fiTUsUzjuZm
         948+9zbPqmkPppmpcFykZDpX4SBd3I5vVjLb/gpoN1c2LoYLk5oBAjhEphmxQDiMnb7x
         wAPV6rdtxYN3pr+QaE2TKzq0FR+A5G8hVdAolnBiI+qM7V/8LlkuDuBsTGO7sQfIcFTs
         xrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569419; x=1759174219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvdWOntfA4A2sQxeMILs61f9nOsNLek7agJHp14BnZw=;
        b=WyqRosYmafe3kW22P0ShUHQtEr80MBGWKs3WMzHEgEvvS76U0wJ98SfV8BgDy7u86F
         SgOEdS8Le/UKbesF4f5vO1qskGgC5PvhqH53bFu17+7Mf7sFa1GrU6iXZg2ExWTnTCG0
         vxMdfLJdBl51qTvFPnAbT+X1Du5mzUnysIzZ7SW2RO2tWCjOSor86rr8zVgG6B/eheAP
         iZFxgd61tViw351BQoL3TN8SUXXIGU0h3WV5HHNfea91/4YTJaIQCV/1Nicr9Z9KjdmF
         ndwDzWANgdmPmIfjEFmRPtgQiuzg2ylb5A8oIrP/R3LRWzqV531mbc20zjjIhwbmlr+s
         zubw==
X-Forwarded-Encrypted: i=1; AJvYcCWoNe64iXvLfLq/9p7mIMf+l2wt8NjUNWt7vDubPnkflxO9XWY5IRQ8jbFfiVWtrrgr76SXd3Sir3i/Q64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mAIYI3IXRu3Es1DHPuG9jk7FZ8DMIdnOXhVwDfMyV8HizJR/
	oWO8z2PGQzASiL+WwjERg1RUf2rdQqKfcur7Ej0KlmbwXbWBwL41k4INjyqXAKzymJjzUgiK5sb
	4xbipRmYcobc4SskpYd0HadMSsn/LNsEO8VVEpxHI
X-Gm-Gg: ASbGncuk2PZj8jhhhGISGuDijcHwSQicf1UwRrYgJXiKm3wYLQHX3f29jygsMydxPgX
	DbR1CB9I2eIwJwHtyF0P1g201wiY7a3vthsD1Sf+Xo+6+n2VATWs5USKOCq1oUkugDGBSwsTLOn
	fXQ4qn60/n+xc4ogz6is4+TaEdwlPnm7StDpYZeKOrjYjBUfiERU0UomMqtR89z401eNV/+K4pE
	tO2Ngk=
X-Google-Smtp-Source: AGHT+IEiBDSh+6Em5c+U4LmqyUVPf4J6sg4KEYshuli5NnK7h8jqw5N22Ih+dxfjqxwcfWjX8MHUInxueYuNHXzg6tw=
X-Received: by 2002:a05:6402:5201:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-6337b1ea02fmr4563672a12.34.1758569418235; Mon, 22 Sep 2025
 12:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
 <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 22 Sep 2025 15:30:04 -0400
X-Gm-Features: AS18NWA9HrHmx3YP496OglRtxh1AdycMtaqbc5LSlhUEUhu_PxKTgISVOm7uHlk
Message-ID: <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
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

On Mon, Sep 22, 2025 at 9:12=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> When would you recommend that I re-apply the corresponding userspace
> patch to reserve this policy capability number for memfd_class?
> After it is moved to selinux/dev? Understand that it isn't truly
> reserved until it lands in a kernel.org kernel but would prefer to
> reapply it sooner than that since there may be other policy capability
> requests queueing up (e.g. bpf token) that should be done relative to
> it. Can always revert it again if necessary, at least until another
> userspace release is made (not sure on timeline for that).

When it comes to API issues like this, my standard answer is "tagged
release from Linus" as it is the safest option, but you know that
already.

The fuzzier answer is that unless something crazy happens, I'm likely
going to move the patches, in order, from selinux/dev-staging into
selinux/dev when the merge window closes.  This means that any
policycap API additions for the next cycle are going to start with the
memfd_class policycap, so it *should* be fairly safe to merge the
userspace bits now, I just wouldn't do a userspace release with that
API change until we see a tagged release from Linus.

--=20
paul-moore.com

