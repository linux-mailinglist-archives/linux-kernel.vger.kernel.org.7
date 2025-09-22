Return-Path: <linux-kernel+bounces-827145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740ACB906D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5BF2A3782
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF5307AFB;
	Mon, 22 Sep 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iujpkj7W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F02FC037
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540895; cv=none; b=l+9qIGts7h8SXXwg2XzL5ClyIHMcCDhIp3l1SEmQho2ysp+kYFvC4CH93kSLQcXTQ3Aoid7ogEXAtZ8qsUgUgiSlEJLwyNlgdIfHy9WqrHXnBee//63Va3POtxi9Gjra9VlO1EZrLxgL6s7LGCXhcfOQkZCe/l17bCeRY9EaoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540895; c=relaxed/simple;
	bh=Npwp37fasUaztNGjwbjQ24nWh04CyauLI9SVRQGWYVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh+DqMStwWeLsCTsckwjgSVf569YQmB0lMssvQO29yNSbrkIjK3K1dr2uwfdGIR/zslBP6g0HZJ+TZh2yEFA/oy2I93MuQbGZsP24DOsJ6W5LHYi6qu93jtUxCF6tmdwzoZMHN54AsjvyPGtTvzwDSFckQjU+zFaQbF0LdpYXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iujpkj7W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758540892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBL6ran7eeZrT38sfsNjW8tntjx1L4Y7ebN1yvWq/ak=;
	b=iujpkj7W5EaWadJ6Xfc9sJACaIrtXVWmIdeM9clz5yBzVwk0gBM7P0BC8vesQpx1bIVsdv
	qof3B1omkRkcbvUdHd30quvfrhmb+CebRFh4K4OaUc+4AHqOt00AtiVByIC9P0wl62oYmw
	q9DnblZbLZGerFh7arrMMsow1F5Nf30=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-FMr60XvxOv-aUH_XMedc6A-1; Mon, 22 Sep 2025 07:34:48 -0400
X-MC-Unique: FMr60XvxOv-aUH_XMedc6A-1
X-Mimecast-MFC-AGG-ID: FMr60XvxOv-aUH_XMedc6A_1758540888
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268141f759aso45895575ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758540887; x=1759145687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBL6ran7eeZrT38sfsNjW8tntjx1L4Y7ebN1yvWq/ak=;
        b=O622PaaRNdc/imjuukYM0XDi9Ym8RWoNpNzFnYqkfD5fgFGBzErtR893b3HnZ1NlnM
         +WefEjn1+441Smwcbznsp6bjcnwxntuuf7+FIkXXTTt3NFWlTsuXDA6BecoZKEFkj/lV
         SNSYikdM3+thgYDWueOexmk7913WFK7X5ApTvXfENCtA1zISDdAF11dpAel+4GCh5FZv
         +r3cX8ie1ocDCKDyV4+iKEo9oQ5m17lnch9fRUp3N7gEu3qaFAMVhVMzD5V3yeca+IHQ
         k+77sl7MN0Z8XhMyuLlMlBcjC6wjPpm2tN68vYd5cJ4a9LctL0jHU4L3+mtcb62VXdBk
         zCbw==
X-Forwarded-Encrypted: i=1; AJvYcCVvwH9PG2KvJBvNqMiO2w4ncFcHDLA7ChParL0AxqRY425iYDAcXy97n5AT3tkifgZOeyIks8EHtS+6RYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxybZeMhaw+uHfSWmikf7yxT3vU/TkEnskJF317ueE0V8UAGw
	tPQudhz+8lA+74cbttPEIYYx55WGIqFkH/6XgqymHknmqEccu9OE/E+7A2pPpCfn8y4+S2VQF34
	wmta/GLo2UNBHKqSVnqRbYmr0lMdIWN6LSzyDnD5Wqlm5R/us+1zf6uvMi5nuQXRzMBPSxFXt2S
	MGJHLkH4j6BTQsYZyGlx8JgFPyqnXvimKdK3edFE95
X-Gm-Gg: ASbGncsUzZywycH9xqab02fyMrM3Vo2/C9LBRTEU8YmDF2ZJBaNNS7z5F/Db9W70AwJ
	/ZFF9eoa+YICP/KiH6TkzMpGMa55O519UQlxVwXo6c3lEzHpOY6BOQYo07ztQY1nzps/vZ79zYJ
	WAq+fYT4MQQcbtSQ13K/w=
X-Received: by 2002:a17:902:ea05:b0:269:874c:4e48 with SMTP id d9443c01a7336-269ba550cd2mr171325285ad.47.1758540887722;
        Mon, 22 Sep 2025 04:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwLwdzoDbuGVYQuEXIHCwQRTwpdPRrzzjp4kgxXc6oHg0FWMGDElJOvb0KAxMjWimeR5uUisUdrOaN5DAr/3I=
X-Received: by 2002:a17:902:ea05:b0:269:874c:4e48 with SMTP id
 d9443c01a7336-269ba550cd2mr171324975ad.47.1758540887355; Mon, 22 Sep 2025
 04:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918204830.229918-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20250918204830.229918-1-kriish.sharma2006@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 22 Sep 2025 13:34:36 +0200
X-Gm-Features: AS18NWACBZeRywvdMekJd6TCUmlssvkKRWZotY-3FIzanJ_u6GG0-GRTwtWtIGg
Message-ID: <CAHc6FU4CVLe6ZxPR1Q3dc=5i1ARrNAjnB_NEK5_Y_Pecmk_4bQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: add bounds check for rd_length in compute_bitstructs()
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linux.dev, 
	syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kriish,

On Thu, Sep 18, 2025 at 10:49=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
> compute_bitstructs() allocates an array of gfs2_bitmap structures
> using kcalloc(). The function only checked for length =3D=3D 0 but did no=
t
> guard against excessively large length values.
>
> If rd_length is too large, the multiplication inside
> kcalloc(length, sizeof(struct gfs2_bitmap), GFP_NOFS) can exceed
> KMALLOC_MAX_SIZE. This leads to the allocator calculating an order
> greater than MAX_ORDER when calling get_order(), which is invalid.
> As a result, __alloc_pages() warns about the bad request.
>
> This patch adds an explicit check that rd_length is not only non-zero
> but also within the maximum safe limit for kmalloc_array():
>     length <=3D KMALLOC_MAX_SIZE / sizeof(struct gfs2_bitmap)
>
> This ensures that get_order() is only ever called with a valid size,
> resulting in an allocation order within MAX_ORDER
>
> Fixes: b9158815de52 ("Merge tag 'char-misc-6.9-rc7' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/gregkh/char-misc")
> Reported-by: syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7567dc5c8aa8f68bde74
>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  fs/gfs2/rgrp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> index 26d6c1eea559..a879e8030568 100644
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -760,7 +760,7 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
>         u32 bytes_left, bytes;
>         int x;
>
> -       if (!length)
> +       if (!length || length > KMALLOC_MAX_SIZE / sizeof(struct gfs2_bit=
map))
>                 return -EINVAL;
>
>         rgd->rd_bits =3D kcalloc(length, sizeof(struct gfs2_bitmap), GFP_=
NOFS);
> --
> 2.34.1
>

this patch looks correct at a certain level of abstraction, but a
better approach would be to sanity check the resource group fields in
read_rindex_entry(). Andy and I are trying to work out a patch that
does that.

Thanks,
Andreas


