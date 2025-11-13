Return-Path: <linux-kernel+bounces-899007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BAC568AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CCEF3461AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CC2D7DD3;
	Thu, 13 Nov 2025 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrN+bVY/"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91D330B3B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025305; cv=none; b=Ts8uWAnut4C2Tn22ptNLCnrNMzXytaX3hKzQXHZD9Y1jTYh41HtcVn+rOq1kef/1enDUUfVVQKvw9kjErKQqHxvsKsGhzJzU/4+wIz/FJJm+ElX2j07rSlcEKGbA2ffECUMfCRKLd9UjPRtbwvzl3QDYfCyWKmqyzMg8XF8FD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025305; c=relaxed/simple;
	bh=kb8GCBzISZxMBObnJYLcLo1xyRlhTxQlzt5p10iy9/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl/8ZnELLk5Ec3zGsovH/NBZffkRMw2DTVC6kmp0xy/K3Yz9K8o3/ediHaV2Jea7QmDDgWpLQwMlpxl25WFTzCzHnp7nGEhJpD+Knn6uG7Cg39UjqDZ7rEGfgUde/UlykICYkBTDK+RtcRpEegR1K3wRwE554UNbxmCeJ0cRqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrN+bVY/; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dfae681ff8so374417137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763025303; x=1763630103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9KVozUkK/zJH0JaBiGr0HN/eCPVvCbe07YpCEdnuQg=;
        b=KrN+bVY/dq99OhtAHYodpmFQIlE31s6hpnjCPIsWXhlRN87kjFkJp8w9wF1XlvOFZo
         wkQuwTjv5GDKV45YZ168eoF/W7eizMjfjPH69fRpRxXRpbsKlyvTI+lhpkSAEtUP2un4
         aSmPPWgG1Ed9OkiqvmiiXj3EDu/767C0K4/JNLd4aPh6fNzT7nrJBusvxfOkRcWUGrfO
         4yAYJGEKxUfzEQbdyDMj9226dafz7+sMwGAQMRNg6bOEcL/Xy/5vGm8erJ9oT5wkLyh4
         DHaEIGbIiuQ5qnwtomRS0i6gD77KV7SLm5l189HtSANk0qvvjkskXpgyt7DfLLBWoZEa
         PYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025303; x=1763630103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9KVozUkK/zJH0JaBiGr0HN/eCPVvCbe07YpCEdnuQg=;
        b=MarTsfrTJuoXym09vtVOJYqRdQxLmHEnyClrrpmrmrzeQXzF53g6iyfF8+DJmqR3K4
         y/uMehRgzhF342n5auhe7X7/nF3QQMLFfEpHAapB+SlZurSmZU2XsTaCvu2/HcL1tl4Y
         tSOtWLuJMDpwY8RHnXX2heWsIgJXLarfoEXR+aqXslS/6+nVd5LVee0bHCATvPatD+NL
         waA5pbNNnE6CcHq036ljb3oPT1CrFoN5W1QO06gf8Xzv5Hrb+S5bptZXv+ugLD3k34gv
         netXs6XH2gLnUzHfN3wqeNdzsQXAFIdaVQ44llRbhkFERkrlioHsTsck7kFjGi8MOjCn
         tDDw==
X-Forwarded-Encrypted: i=1; AJvYcCVGFp/xO4+8eqDnuPIHQZkbnBxp6h3flb6HGI/Lysa3IH2IwGytlNZmq+nyfFcPvu4UH00x/rop5GqzjfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExp2XCgtU68+Ph4c203fPXJyrSy/SHtrMaTcjh2qA6Ckyx6Fu
	14HOjt2woKWKYuHXIrMwhNDqDsmOZ/iSJIjxQBEWmE9GCfMnucIjdfLvKRpxfIKO5K9vig5bCJ1
	Pg0pzHZ7TSgBD7Np2MiPTnSvVV9q8BNY=
X-Gm-Gg: ASbGncuivkVfjKZt7LxinXfYwBLom8JdVyAUlnrkgquYq9pFkwgHPVI0W150Y/HBFFe
	kiXnpshT7ac6b3OKWuk0SZk0vOsAqAOc3DMdoug7K/4CS+URFDxq5cADd1Ob5LJurQfgrZs9pa8
	Jr6gMczBSYhjnp2Bti9vCBgBqzR3ndi0P8+W/lCp6sekuONsrP7fjIxLiW6dzH7snYNp8Y/zjlr
	+t7hgGaJIcXvUfvsHg52V2lc85sbZyLy1AWKhcHTM3yYKb6Sl8D6faH8Gjy
X-Google-Smtp-Source: AGHT+IGCKlT8KlNNXDeE29mhTzV1PY6dXe3xu2it3WaIVDyYn0hULj3RhvJmaX44OFowRvQL1IhQ+AzGvfsm/iLeSEQ=
X-Received: by 2002:a05:6102:374a:b0:5de:736:71d9 with SMTP id
 ada2fe7eead31-5de07e15d59mr2473324137.28.1763025302810; Thu, 13 Nov 2025
 01:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112160333.30883-1-scott_mitchell@apple.com> <aRUT2PIAqo3VY9SJ@strlen.de>
In-Reply-To: <aRUT2PIAqo3VY9SJ@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 01:14:52 -0800
X-Gm-Features: AWmQ_bnfBe6KH2h_Rc9kOZTesdBr9bneRKpm-4Xm2O-RYSOUtmVGAZ2AtJRiAdk
Message-ID: <CAFn2buBaQNSWtb8eU1Mwm-L2i2vaU4MVSjHi3OTwdd9ZyYx4RA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nfnetlink_queue: optimize verdict lookup with
 hash table
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Scott Mitchell <scott_mitchell@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 3:10=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> >  static inline u_int8_t instance_hashfn(u_int16_t queue_num)
> >  {
> >       return ((queue_num >> 8) ^ queue_num) % INSTANCE_BUCKETS;
> > @@ -114,13 +153,63 @@ instance_lookup(struct nfnl_queue_net *q, u_int16=
_t queue_num)
> >       return NULL;
> >  }
> >
> > +static int
> > +nfqnl_hash_resize(struct nfqnl_instance *inst, u32 hash_size)
> > +{
> > +     struct hlist_head *new_hash, *old_hash;
> > +     struct nf_queue_entry *entry;
> > +     unsigned int h, hash_mask;
> > +
> > +     /* lock scope includes kcalloc/kfree to bound memory if concurren=
t resizes.
> > +      * lock scope could be reduced to exclude the  kcalloc/kfree at t=
he cost
> > +      * of increased code complexity (re-check of hash_size) and relax=
ed memory
> > +      * bounds (concurrent resize may each do allocations). since resi=
ze is
> > +      * expected to be rare, the broader lock scope is simpler and pre=
ferred.
> > +      */
>
> I'm all for simplicity. but I don't see how concurrent resizes are
> possible.  NFQNL_MSG_CONFIG runs under nfnetlink subsystem mutex.
>
> Or did I miss something?

This makes sense, and I will fix this.

>
> > +     new_hash =3D kcalloc(hash_size, sizeof(*new_hash), GFP_ATOMIC);
>
> Since the hash table could be large I would prefer if this could
> be GFP_KERNEL_ACCOUNT + kvcalloc to permit vmalloc fallback.

Good feedback, done.

>
> > +     if (nfqa[NFQA_CFG_HASH_SIZE]) {
> > +             hash_size =3D ntohl(nla_get_be32(nfqa[NFQA_CFG_HASH_SIZE]=
));
> > +     }
>
> Nit, no { } here.

Fixed.

Thanks for the review! I'll send v2 shortly.

