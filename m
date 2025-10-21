Return-Path: <linux-kernel+bounces-862383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68683BF5226
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A77B402699
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2A9269AEE;
	Tue, 21 Oct 2025 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DRrWZumJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A969281356
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033733; cv=none; b=AOjuUESKRTOtB3Gw+mUacqT8QzhLpziz3OsrDnCUA6LqgF6t6TqVheZ3NGZl4rvLMogAiWnu376CXQhvQeNl/KeCo7/rIaSmYHXQDOArai5XJdamhAyxYfP9XPX9Pe8ZpQKg1XnEzjnZ4+KNaf9ve7qL2CUiffcXjb6LfccdU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033733; c=relaxed/simple;
	bh=i+m3PusaxM6Zgin3C3En/lGk4W/S63Hvd6XwDnbd7Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zz+ZnO0QX1JpXVzPnjKr1Qx1J8BrcMT0TQdlpzW1ChQADWEbO+N7odkldh6B6nm1+KKUhPnatZdWT/QmyQUPbLS8f/kK9SHhZYGms12GMgGKxMB6u/Sfm0oNHgPEOXlvL5wQxd6nbqobXgETF2ZKQVcDZNgtYHZevTdheO5V33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DRrWZumJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b43a3b1ae1fso129212266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1761033729; x=1761638529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0VWPqCHv6+ZQuDCTFQQ2tUl50NtMLOJ2aVBSBufBxc=;
        b=DRrWZumJLWlQQYVAwwdZ9UjK/OX3tFtqQIygVaobmULxIhz8TsmMGwWjugbCyJG/TT
         n1DisF41E2n7SCCu5Ow4O85jzTnWfSXt8lKZihDJo8KVtRsMVaD2hKDmMuIhBsbaYTxE
         rEO04c4IOVa60P52jb5mBgRIvD3zpJn6BePYm34wJNSrHC9n/jM5CtHEih+v5cF8Vk0w
         UMgg7XcMxykPPAcbgYAfFVy+kn5kUR0tXv5Bmys+Bw4+gt9Os5YLpsLf+6i0/GutnOxM
         1gvVIP5sj2M1i3gRJOmmgiQ6dgBYKdI4BRFe3e5P8g8lEyZF2VfN2cR1LesjLs8Dd/vy
         MW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033729; x=1761638529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0VWPqCHv6+ZQuDCTFQQ2tUl50NtMLOJ2aVBSBufBxc=;
        b=kKVkPN05LqE6kONYRbZhikJDDaxqbrgsv4iexy0qk1FGYiQLiAvjU5N1xKdOsR1MmY
         fRM5UPIV9t06BYgg8QlqRMU85lrNZ4wSDBStBYXkwYPte6GVAoem2QTW5BJEQj7mK90W
         Kthu0wp4I50ewGeU0FzJbK6GxiCsOGbvoW4Ww6PT4nOi4L73mcW0IJ4Rn+1Q/Kc7pfra
         qLFwMoypaNMh4gNlvwKpldKSqp5+VpcUyjvJ4RuNCKRFJQzQhRLJ9Eq9RDccM23AAPTs
         0CgEAtwwXBp2+DYhGwHNr0tEjRIP/fEDTcoR2E7bO5eLNRBS9fy8yKJRd/7FIwgB1Hwm
         5QmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe2/kwMcy87TyE6xart3HPqdINtHiZzObJgQqGkFlw2qHjOWJIEO09qt46Hl8qAfvhEWxv3V8FHn44h9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZUtiYtf/pBDp6UM21TdeX6rqfR5Kd2yS6zhPoIAeIZifCaWO
	CsGxC0Uem4Pzlfm951+0BCDR8vggZBstnS/ERzu4b+ZC8/Cfl5/0liN/6GOSDHCWD5fsOYM0WDt
	Nbj5eyo79fUQwFlkyny4MaWxYQ67QojZPcCEmMrupmg==
X-Gm-Gg: ASbGncszv/qh+r/WvoqZuWBuVWEV1JxmUQugN+T7dlipt6GPrf/gFzvkyMGuOfhGSTo
	kX8G4AEKKVyPE8s0CBwBJzN0VbsDILI7o0UN21aJWei2T3kJ/WfKsbfs9bUboWYZAqRdirrbyKK
	fKZzT4MzeZ3SMJmt1h9HPyW3FKnZfqPgUI14OFHfnOwygXpk/IrX7cz9C77JMJhz7+slpMlQ60n
	G1U1tdlAOKWeXw9MUNKdfe9VfqHdfzioc7X2MYn8Agn9Mwt0XLEbkzbqUqO
X-Google-Smtp-Source: AGHT+IEQfgvHZuihlbBSJlVb+dcEnjFV14dIS2e3QeU28hCgVySmEX3k7+tkYGmNfEgLKxBR2Hkp3zdbZ2HHX0oRDVA=
X-Received: by 2002:a05:6402:2115:b0:638:e8af:35c7 with SMTP id
 4fb4d7f45d1cf-63d16af7935mr1354397a12.2.1761033728661; Tue, 21 Oct 2025
 01:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-rnbd_fix-v1-1-71559ee26e2b@gmail.com>
In-Reply-To: <20251021-rnbd_fix-v1-1-71559ee26e2b@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 21 Oct 2025 10:01:57 +0200
X-Gm-Features: AS18NWAjr1vMpIROYlrNqm-3ej7s5Tkh074kVV9erysvDSTuNEiz5Pc19hwQJzo
Message-ID: <CAMGffEmsJjeqW8DGnKapVyM0Gporn_UuDB2xNosRmD2GduGgzg@mail.gmail.com>
Subject: Re: [PATCH] drivers: block: rnbd: Handle generic ERR_PTR returns
 safely in find_and_get_or_create_sess()
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:21=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix the issue detected by the smatch tool.
> drivers/block/rnbd/rnbd-clt.c:1241 find_and_get_or_create_sess()
> error: 'sess' dereferencing possible ERR_PTR()
>
> find_and_get_or_create_sess() only checks for ERR_PTR(-ENOMEM) after
> calling find_or_create_sess(). In other encoded failures, the code
> may dereference the error pointer when accessing sess->nr_poll_queues,
> resulting ina kernel oops.
>
> By preserving the existing -ENOMEM behaviour and log unexpected
> errors to assist in debugging. This change eliminates a potential
> invalid pointer dereference without altering the function's logic
> or intenet.
>
> Tested by compiling using smatch tool.
Thx for the patch.
But I read the code again, find_or_create_sess -> alloc_sess, which
only return ERR_PTR(-ENOMEM) or a valid pointer.
I think this is just a false positive.
>
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.=
c
> index f1409e54010a..57ca694210b9 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1236,9 +1236,14 @@ find_and_get_or_create_sess(const char *sessname,
>         struct rtrs_clt_ops rtrs_ops;
>
>         sess =3D find_or_create_sess(sessname, &first);
> -       if (sess =3D=3D ERR_PTR(-ENOMEM)) {
> -               return ERR_PTR(-ENOMEM);
> -       } else if ((nr_poll_queues && !first) ||  (!nr_poll_queues && ses=
s->nr_poll_queues)) {
> +       if (IS_ERR(sess)) {
> +               err =3D PTR_ERR(sess);
> +               if (err !=3D -ENOMEM)
> +                       pr_warn("rndb: find_or_create_sess(%s) failed wit=
h %d\n",
> +                               sessname, err);
> +               return ERR_PTR(err);
> +       }
> +       if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess->nr_p=
oll_queues)) {
>                 /*
>                  * A device MUST have its own session to use the polling-=
mode.
>                  * It must fail to map new device with the same session.
>
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251021-rnbd_fix-9b478fb52403
>
> Best regards,
> --
> Ranganath V N <vnranganath.20@gmail.com>
>

