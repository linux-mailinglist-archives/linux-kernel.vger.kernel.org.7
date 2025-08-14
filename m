Return-Path: <linux-kernel+bounces-769592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3149DB270BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5731BC53EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A14274B46;
	Thu, 14 Aug 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="D+EmjNUE"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E41D416C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206435; cv=none; b=EevMkeXRuj7nyhFO25x1ImfzLCxungM5heYzVbhxJXYRFlOG3CSOwRqisAZnNw7+BSW9G3G4+9cHgzMSzryzF6puipXuFf7oUqMcGt+3JNPLie+Zu0b/jgF/P33UzLrGCvQACoA1zjW8MzYDD+sEcQAEv84Lq5kBMMZA/2F75Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206435; c=relaxed/simple;
	bh=q7WXXDVQRTUpqr4QVTAWHGjdq5DFUQuYmSY3+FLtqQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ3UFBkLmqYksYnL8xNDnJn2H3W09UjdisJ1vJ6PyfnpFq5APoL9cmmtULuRxCSZnWEjRQKd4ILLPQlBwcNQZ4mkapnwCs+RoMtfvIYGcyM+425Zvcpr4L6YDKGR5e8ia1tfsOX+EO7Yx9bpk4OR4hXZMzivCjDkIGBbk+iisvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=D+EmjNUE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47174beccfso1069533a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1755206433; x=1755811233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb8iVo/PgFJEpKV/W6EYfcl1Z1VGsLh+aStmYLIfSCU=;
        b=D+EmjNUEiid4UeeMTDkASIKkp7wpXrgbY+gKkq9SLiB841acKTMnGoKybxJF/cVZKN
         8Yse7Qf7I/+ORTc6viR+Ookywyy6Q6ZmA9EfjxxuiLL51MCmTuE91pt0F/2dnmbrcu5x
         D6wbe2cJ4LcbWfL2sdN2HNRxgJHojAlKdKoX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206433; x=1755811233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb8iVo/PgFJEpKV/W6EYfcl1Z1VGsLh+aStmYLIfSCU=;
        b=eJEd6zqconZHv4tEsF2iTXmfeDv+Sy+3+nXhnMqmzYhcvDN59ONBMBbNj+DDJmZjh+
         1dSqsCys8FbYeFzVnGDzTbItM4jw2woO1Xb8lFblyJkzMLj5dk9aqvE6bBqmjIE4LPGp
         tLvwGsblWPSe78OVLfsskZ5eHhrNyp5ZhUjDtjebhwbJ3RxHFIAuLEJ3MXCpY8B8jup1
         H6gul0IDHeotiRjHnXZwAzRZko7qP53y6YQqy3ROCgg8MVyompwTTj2g0h0xKojqv+k2
         xaiSpaYZsQmHi4YoeaL6aKpaea9k07YeBQQfcPvGBtz1lJSwLtJ8b9O2a13n8Jpiiw3n
         N9NA==
X-Forwarded-Encrypted: i=1; AJvYcCUQFYqfEdOt6+zchNTw8I/AenF3sWbh7zgi1Lpj6dwRpJadN93T02siH+sYckDuVmRtmD4mvY3n1J49TeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQitR7XR/CdcSzHRrra5oTBOmnOcAXK4kXsGFm36+FFkWw0Ht
	b4oNPlvJAWIOUquUm1WarrN9eNvojae961mZoa5Jl94HbgznrSA7Azj34txor77r0SqwhAne1Mk
	hiNaLBNrY3EGQ4IOy7zvw2dVnIisDAkZII2+RDYG6RQ==
X-Gm-Gg: ASbGnctSya9kHHKcPS6yYiM5z2WyYEDu4Fz9xkrzGD5ZIDsxIIh3GAO02iiqlZjbwlK
	zJRHMDyknfW0mKlVXzqPpYAatmi30P6tbfFnyXfA0Pd1MW7zL8FrVj4IUwFjT1Q1NxVKvtamWxp
	1XZhV+qHcN0gUsjE8P7s7LDt5vsjwXYi0/9HU1pahT4vjoTmoGx4CPEVlLXkXrjc5wgBVOWGE/j
	lFMRayYkg==
X-Google-Smtp-Source: AGHT+IG5izskxuGt97vLqfWNw4igRbo82Y3j+f14aiAzLHxWfBRRhDu8K6dri9rvqD1+sMgxxeEVk8/Ui/7hT8dVSl8=
X-Received: by 2002:a17:903:1c3:b0:235:15f3:ef16 with SMTP id
 d9443c01a7336-244584dc612mr68322285ad.13.1755206433226; Thu, 14 Aug 2025
 14:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
 <20250804022101.2171981-3-xukuohai@huaweicloud.com> <8d9cdce252162519c7679132a5e3235d03ac97c0.camel@gmail.com>
In-Reply-To: <8d9cdce252162519c7679132a5e3235d03ac97c0.camel@gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Thu, 14 Aug 2025 14:20:20 -0700
X-Gm-Features: Ac12FXxT9uyArO0uNj9SBFMD5GvefioNVjShrtqRl6yBkS3TpEiwVdDypIRiE5A
Message-ID: <CAC1LvL1=61DYMAG=c57LRns++9rHF_thD3Kn=nopUoi8CkPshA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: ringbuf: Add overwrite ring buffer process
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2025-08-04 at 10:20 +0800, Xu Kuohai wrote:
>
> [...]
>
> > @@ -278,6 +293,92 @@ static int64_t ringbuf_process_ring(struct ring *r=
, size_t n)
> >       return cnt;
> >  }
> >
> > +static int64_t ringbuf_process_overwrite_ring(struct ring *r, size_t n=
)
> > +{
> > +
> > +     int err;
> > +     uint32_t *len_ptr, len;
> > +     /* 64-bit to avoid overflow in case of extreme application behavi=
or */
> > +     int64_t cnt =3D 0;
> > +     size_t size, offset;
> > +     unsigned long cons_pos, prod_pos, over_pos, tmp_pos;
> > +     bool got_new_data;
> > +     void *sample;
> > +     bool copied;
> > +
> > +     size =3D r->mask + 1;
> > +
> > +     cons_pos =3D smp_load_acquire(r->consumer_pos);
> > +     do {
> > +             got_new_data =3D false;
> > +
> > +             /* grab a copy of data */
> > +             prod_pos =3D smp_load_acquire(r->producer_pos);
> > +             do {
> > +                     over_pos =3D READ_ONCE(*r->overwrite_pos);
> > +                     /* prod_pos may be outdated now */
> > +                     if (over_pos < prod_pos) {
> > +                             tmp_pos =3D max(cons_pos, over_pos);
> > +                             /* smp_load_acquire(r->producer_pos) befo=
re
> > +                              * READ_ONCE(*r->overwrite_pos) ensures t=
hat
> > +                              * over_pos + r->mask < prod_pos never oc=
curs,
> > +                              * so size is never larger than r->mask
> > +                              */
> > +                             size =3D prod_pos - tmp_pos;
> > +                             if (!size)
> > +                                     goto done;
> > +                             memcpy(r->read_buffer,
> > +                                    r->data + (tmp_pos & r->mask), siz=
e);
> > +                             copied =3D true;
> > +                     } else {
> > +                             copied =3D false;
> > +                     }
> > +                     prod_pos =3D smp_load_acquire(r->producer_pos);
> > +             /* retry if data is overwritten by producer */
> > +             } while (!copied || prod_pos - tmp_pos > r->mask);
>
> Could you please elaborate a bit, why this condition is sufficient to
> guarantee that r->overwrite_pos had not changed while memcpy() was
> executing?
>

It isn't sufficient to guarantee that, but does it need tobe ? The concern =
is
that the data being memcpy-ed might have been overwritten, right? This
condition is sufficient to guarantee that can't happen without forcing anot=
her
loop iteration.

For the producer to overwrite a memcpy-ed byte, it must have looped around =
the
entire buffer, so r->producer_pos will be at least r->mask + 1 more than
tmp_pos. The +1 is because r->producer_pos first had to produce the byte
that got overwritten for it to be included in the memcpy, then produce it a
second time to overwrite it.

Since the code rereads r->producer_pos before making the check, if any byte=
s
have been overwritten, prod_pos - tmp_pos will be at least r->mask + 1, so =
the
check will return true and the loop will iterate again, and a new memcpy wi=
ll
be performed.

> > +
> > +             cons_pos =3D tmp_pos;
> > +
> > +             for (offset =3D 0; offset < size; offset +=3D roundup_len=
(len)) {
> > +                     len_ptr =3D r->read_buffer + (offset & r->mask);
> > +                     len =3D *len_ptr;
> > +
> > +                     if (len & BPF_RINGBUF_BUSY_BIT)
> > +                             goto done;
> > +
> > +                     got_new_data =3D true;
> > +                     cons_pos +=3D roundup_len(len);
> > +
> > +                     if ((len & BPF_RINGBUF_DISCARD_BIT) =3D=3D 0) {
> > +                             sample =3D (void *)len_ptr + BPF_RINGBUF_=
HDR_SZ;
> > +                             err =3D r->sample_cb(r->ctx, sample, len)=
;
> > +                             if (err < 0) {
> > +                                     /* update consumer pos and bail o=
ut */
> > +                                     smp_store_release(r->consumer_pos=
,
> > +                                                       cons_pos);
> > +                                     return err;
> > +                             }
> > +                             cnt++;
> > +                     }
> > +
> > +                     if (cnt >=3D n)
> > +                             goto done;
> > +             }
> > +     } while (got_new_data);
> > +
> > +done:
> > +     smp_store_release(r->consumer_pos, cons_pos);
> > +     return cnt;
> > +}
>
> [...]
>

