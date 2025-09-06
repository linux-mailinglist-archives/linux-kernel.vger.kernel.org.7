Return-Path: <linux-kernel+bounces-804241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B88B46E0C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDD617FB4F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4972EDD7D;
	Sat,  6 Sep 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXdQ6EEg"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F414A0B5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165130; cv=none; b=fpPXA7TNO1Nyyi6dnmFM+3CPn0ZlNSr1+6YtjIj5eaEuHuLxmj+/FieKLWxMH9xY7EvXERPRHYGdCTTSVUebDjJW0n60y+XZqS3LgHdpmk866Ml9PmLM1DCazsHkw7RufIyyRGqTs7yoyje+uQhygbxhhnI+fQzi3CaR0L/11l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165130; c=relaxed/simple;
	bh=VE+Mx/TU7aQIVb363hbvW+WQvMnqT6BMcQeprM6OFYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gw2vNaQmmMJQIzyDIi1Tu94HRzwtblm/7FC0B6EjO8geCisR9WeWacHpgWmlXqW9jJc3OrwO2k5RFWEfHLcSM17/3qnUet4SHpO7zrBvC9lwzFi34iWBr+dp4mAYbsUTbxE1rx9BEqfMTbOseP4/zwoyFJwDuHFPvSdjCaPzFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXdQ6EEg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso15204465e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757165127; x=1757769927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE+Mx/TU7aQIVb363hbvW+WQvMnqT6BMcQeprM6OFYE=;
        b=nXdQ6EEggrNa6JOqEK2oc1a4zrpHLY7DzgP8twE5XS7aohnwoF8Yjl5905Oplmzvpp
         9Xkeifay41iQ7SgxuI2Wdk0MR8Ei00Cao4jVJ3PbOVN94kbaToEweXc88m9vC5lLkUeN
         P8vx2J7g93cS6ItYYSD9xTm9GYjZ33EXW/ptJd1y1ITQdhk3AMdGNC7TNC9jYTOTW5KB
         i4aLXeMvQ0PDMlP/s/m75uZgdlXoVRpSUHK4zPo5XJSQWgmbjOTwekXcOEc6u85TVNgQ
         +ZzTHGhfnLVL9j4K+Bp2Qnj+6NG87/hU/SRti15+aDb/NM6pUboC79Q81XEH+Hpb+CTh
         +vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757165127; x=1757769927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE+Mx/TU7aQIVb363hbvW+WQvMnqT6BMcQeprM6OFYE=;
        b=taOr+aOnwUv+YfoSRS9NNF/5r0uP6vg8q3ACc54IzXeQQzS9oCoRwXbTOwUqaGQ0PP
         0mARc4/xZ1XzQugkAdQ978B1bbxA5b1hfmCHld3HjUH33yw1o8LknrL2Jv3JQe0js0zq
         g+No36R3FsP4IWVEAvm7FMzXd7ftRmlJURogPTHfAIRtlgVFiL+BrFVI1ejvCJ4iNPxi
         QRjqHV1dIoYaaAhM3JYjCmDOsn2QJqJNgoMeOgev21xC6ChjjxxWhbpoGjT+uNEriyLv
         Z1VkDbKcTQtoWb41kToy6xxGJVPKKTsp43adRsy2eUUD0k++V4DXgOcuy5PJ9Asg3hXB
         3y5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhdDjleMDBmABUvswf4t0wrUIOper+9f2HTPEc91PdG8ZlYp/MeVudYJUhpGcu1e9aE6BFQMofaglTz+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCHP05ho6x5DXQE0++DOrSaOFCa8kAWE8CE54lhfOmf0uHRew
	gHctmObat2pIoKccTTuJwEt9EOsb32SpVNGy6bZtTL2zyc/VLx5r34IG52dVXFyDxdAKn0Rrdi0
	1+4POMckz3xJCOPyff1W8vEvr/G3Dfwg=
X-Gm-Gg: ASbGncu1iMhIyUeNSPLeDyA6icGuGlWGD0D7PrqMHKkbtgsNdN2ydBKX1FgcNudRuT4
	SlQCGK9YCJFEfaSTl3EisYV6jXrx4B/wg2EQVfn0/3aqSUlF+7JJdX3VMBoV4VO+pmMr+nJekbO
	WH6zVq+lVYvPClpa5rTUv5kr7Z016Db6hX2pHd9jjLjIc+IjkMIfs5dsKQP1YVPmKKxNr6SYIly
	5Nahke4
X-Google-Smtp-Source: AGHT+IH7xxFltspr8zCiYexkZxI5yiQn/I8vOs80sqSulDOmiRjBylXmYFVNrCaFsedsn3UnPzIuoip5fBxmKpv09wE=
X-Received: by 2002:a5d:5887:0:b0:3d1:6d7a:ab24 with SMTP id
 ffacd0b85a97d-3e641a6095cmr1198571f8f.17.1757165126529; Sat, 06 Sep 2025
 06:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
In-Reply-To: <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 6 Sep 2025 15:25:15 +0200
X-Gm-Features: AS18NWDtWolEoXZVKCJMBulXUlUwGez_rwjXq9tKdDHHBjrrgE8FIXbdfmCaUgk
Message-ID: <CA+fCnZf0z526E31AN_NUM-ioaGm+YF2kn02NwGU6-fmki-tkCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: glider@google.com, dvyukov@google.com, elver@google.com, 
	linux-mm@kvack.org, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, Andrey Ryabinin <ryabinin.a.a@gmail.com>, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:34=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> Baoquan, I'd be in favor of implementing kasan.vmalloc=3Doff instead of
> kasan=3Doff. This seems to both (almost) solve the RAM overhead problem
> you're having (AFAIU) and also seems like a useful feature on its own
> (similar to CONFIG_KASAN_VMALLOC=3Dn but via command-line). The patches
> to support kasan.vmalloc=3Doff should also be orthogonal to the
> Sabyrzhan's series.
>
> If you feel strongly that the ~1/8th RAM overhead (coming from the
> physmap shadow and the slab redzones) is still unacceptable for your
> use case (noting that the performance overhead (and the constant
> silent detection of false-positive bugs) would still be there), I
> think you can proceed with your series (unless someone else is
> against).

Hm, just realized that kasan.vmalloc=3Doff would probably break if
CONFIG_VMAP_STACK is enabled: read-only shadow for vmalloc =3D>
read-only shadow for stacks =3D> stack instrumentation will try writing
into read-only shadow and crash.

So I wonder if there's a way to avoid the lazy vmap freeing to deal
with the RAM overhead.

