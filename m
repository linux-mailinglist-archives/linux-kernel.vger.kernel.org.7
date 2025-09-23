Return-Path: <linux-kernel+bounces-829453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D5B971E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A05619C787E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54792D73B0;
	Tue, 23 Sep 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwHGYM0E"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462392D6E73
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649796; cv=none; b=VAkxgTN7Hhs3JFUqjb+vCaDLoNtt3W8Ar/6Lq8KuoAfEM/RuqgNgNUPBZV9hMuf+lYROLLuy3XTM008polQNnNjPjCbO3CHUyhb9GmUIG7xzIzbvJ8w/Cb4FLZYc8cTEtrGpbqGbBoyxQsXoMLP18aOqm1J5nDcgVDde5ypAfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649796; c=relaxed/simple;
	bh=FMtpnPvftLzsRD78QIlbVngVYA2UiH9hMHSRtHw3Lb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyWFv82y26Vv1M/zAUHlsneB5MIbj0TjvevxNAAO1QPRBKTrNZEG6kjEKYPmTfkQOCRKrQnidO9Fg8qcXJKhNb0/VniQc6zDqJcJcWYgQ4HyW5XZayt0B1tXWrIE3nJVL/TI8AF5zTIArAPLnj2RRHfZpV5aqvtn4uy78Vuiurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwHGYM0E; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso6140398f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649793; x=1759254593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0kx1rTugh76QptF0xZZo2hW1gYb0dlnX+yVu1KHk1w=;
        b=mwHGYM0EnKkpMpbFUGvl7AXI8rZR33BSTl0fiz5CvVzlshyrn99oUjeCVlSnIi2E4Z
         QQaS3wnge9OV0YPLZvTJJ8HJbxBQv98o2wvQzfD3te62sli5mDYEHnfN9XnNUssF6D8f
         P+6bERL3GSJXegj9XvFVR0OM7lyoQTAJ/W414Fd2R+hI4sGe5qhWypx/ApQiPntANa32
         pI2WIMBnYiShyI6ec1rI6VeBm0I6er2oIv1XFeI2ooAl8P1HpnI4rzG8SkTr+owmxZYF
         c9xMou6m/LPfnN49452NYJ49HGdlbPFAMAWgofOGyCvMMP6Oq/r3YQFCOqyW2aQiD+5B
         UoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649793; x=1759254593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0kx1rTugh76QptF0xZZo2hW1gYb0dlnX+yVu1KHk1w=;
        b=SeJAI4aMd4kmRV6ttBynYqt+c9tQARx7PQyTbX/Sdh0uVux6O5nljHN9/YPcqHoRUi
         ZuhigiNn6HdiB1D1guP6E0AXnuijMtIh72JE2KIWvjJzdz2Ui+WtZZ5GqdKepbVW1s6z
         8Wf19Cb785DugKdzg05D9dgSNIWIFYNRrFggP1JNlYUFsgh7MAV/OVO7Yyfow8S1i6XW
         iz+uIMLmivQaW0SADW/Ib8sY68V2a4/wZICk1eC+MtJoZLnloAamglgg1opGmDN/siWH
         kZZbxrs6N3Ng7BanvZwCsxD3/ELlQIzXfNc4K/SeKFaqoz04RQrcov5TLmimQkh9HMSI
         j/MA==
X-Forwarded-Encrypted: i=1; AJvYcCWp0MIjEKCzXxHLY8CDdUXJ4SDW7WuSEGkcZ7M8pOvaiuxUcDm/fpV2eJ1BwcVDhWnLVyAp4Z5HSXolfyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIbBMAzfNJKQHH3tBnp/M7/rd3TlBr4kiWcWB8hVKisjkhlu/r
	P58WtPaYazE71OCdPNihMziTYs6gpK5sghi8OMjmhn2MKWa6inckmlPZtkRjSNU12sUuprXrFiy
	pjWx6zhzFhoLjOrgY6kHh/cI+Sk3AS6w=
X-Gm-Gg: ASbGncvwgIKufOWoXde0emO59y7Lz6LAY0/zmvl52Hh8Q1KD7cIXWjHck3Rllip3b26
	1RcypFXU9KvztJ200MxsHZY+RCGZ+xmAOAoVEGMeai9lfrnxIyTE/rCsUqosdediv2MMHFJvomT
	ksBaVP8SR83XhD8yW4IWUSAQDU84/5B4XFEx/0HWUoeRnH8DbnwQjXGEYZLWD+jM68t09MX+TFE
	2BTya1K0A==
X-Google-Smtp-Source: AGHT+IFDnIr9jURW/iDdf33QbVpq9yGIdz78c5cWwu6hkoK/t2n+HhwmdlTT8qcq2NE/YdgFwsyWNimpCK8U1Bj/+yE=
X-Received: by 2002:a05:6000:200e:b0:3ec:7583:3b76 with SMTP id
 ffacd0b85a97d-405c6847528mr2568370f8f.22.1758649792481; Tue, 23 Sep 2025
 10:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
In-Reply-To: <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 23 Sep 2025 19:49:40 +0200
X-Gm-Features: AS18NWAnwGHtT4NaZMiBj4LqaLnQFy6R4R90e3R6j2xRpw7zcnqFbVZB-WdaVnM
Message-ID: <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, snovitoll@gmail.com, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:05=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> > If you feel strongly that the ~1/8th RAM overhead (coming from the
> > physmap shadow and the slab redzones) is still unacceptable for your
> > use case (noting that the performance overhead (and the constant
> > silent detection of false-positive bugs) would still be there), I
> > think you can proceed with your series (unless someone else is
> > against).
>
> Yeah, that would be great if we can also avoid any not needed memory
> consumption for kdump.

Ack. Let's add support for kasan=3Doff then.

But please describe it in detail in the KASAN documentation.

[...]

> When I made patch and posted, I didn't see Sabyrzhan's patches because I
> usually don't go through mm mailing list. If I saw his patch earlier, I
> would have suggested him to solve this at the same time.
>
> About Sabyrzhan's patch sereis, I have picked up part of his patches and
> credit the author to Sabyrzhan in below patchset.
>
> [PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
> https://lore.kernel.org/all/20250812130933.71593-1-bhe@redhat.com/T/#u
>
> About reposting of this series, do you think which one is preferred:
>
> 1) Firstly merge Sabyrzhan's patch series, I reverted them and apply for
>    my patchset.
>
> 2) Credit the author of patch 1,2,3 of this patch series to Sabyrzhan
>    too as below, because Sabyrzhan do the unification of the static keys
>    usage and the KASAN initialization calls earlier:

Since the Sabyrzhan's patches are already in mm-stable (and I assume
will be merged during the next merge window), just rebase your changes
on top.

But also note that Sabyrzhan is planning to move out the
kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
I would have also asked you to do with the kasan=3Doff patches), so
maybe you should sync up with him wrt these changes.

Thanks!

