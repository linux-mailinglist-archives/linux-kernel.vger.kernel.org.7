Return-Path: <linux-kernel+bounces-772338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E295AB29185
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C11E7A5ED4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219791E5205;
	Sun, 17 Aug 2025 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeDGugEE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93871D8A10
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755404932; cv=none; b=XGYWr/BJtmxsQczOOhIaQvSXvWslZgTxAs90jH7mCPkT/FPoNctQykSRVI/ToDY65QPrGqi6XGI60h83rpm5KPgvLRd9cjW7on7mBOpm/TYR3NJJ/yv2ILvfzbQFcxD2FNrilYHdKIn/jCvPdr8JhB59zGOSmM3bpu1Bi9ZXm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755404932; c=relaxed/simple;
	bh=Mr4fHH6i7FAjbuBkaKdLxYVk8XQx7tfluazo+4U4NMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kM0qiCDxbLfUcLSIuSye+VZlXAmepxZpqsMSrdWJf4SsbzDF+LrTkamdDNi/M9vSFd6PKSoOsyEWD+tJhPgJTjIV9NHcyYlzSwalBqNdMmw2eepzsE2vRuoc88pCQDzdb5nNZdpQtBDDOqPT25RWqFOB8x6T838naow7WsSfHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qeDGugEE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9e4147690so2096135f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 21:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755404929; x=1756009729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiJC33MJvOH1Vpmx9TcHijUmBr5sO/XAeGk2/N8gTkw=;
        b=qeDGugEEMQqcYWZ+RryJp0lvRraM+7W9K609gu6QVwft5qOX+hugZi6TPR/Ljx2QM3
         A4b3ooPRc7xcIoGBu+WI/NrejGc4DmVmaLgcecp6F9kD2CWgIiTDp1P7h+RUlc3YLv5s
         XlT6vgTEExUGXmnkQp+v9xdfNnB5fn5xKTdBh21oJxG9GOdC+PQOVr0MIalge8PsyKD6
         z4pNuC2wp2YcMieAOItL7mnIgGHtnFqcvcInlxmCT+NMRcSvZOZ1ugDjt8wFJlygYwFz
         rcVV5L5zXMkuMZeRAMdoQvXGDzNYXQdvL6XI5XVA2aEog3SsCpY6UrETwXXW7UFbv0Gf
         NGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755404929; x=1756009729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiJC33MJvOH1Vpmx9TcHijUmBr5sO/XAeGk2/N8gTkw=;
        b=l61YbVUm65B+3I6Ht5BGZsOwZynsytP8uCf7nWuUUPG7WenU1Jm7Pa9n+jZzrU8OP5
         Wh1FHHhyePsVf4h5CspuzBFIBesUTPSillkZiNcxR09KZ8XTAMPWUOxJqcqccUASehi+
         4Gwi7g6nvdJwwWtSmW/4zrmxvibJTn8QI4H7NGzp2QPDVtqmko5nIt2OdcdM1zO/whLc
         9+6nuTXV889ss/4GlN8mGfin1dEQyOHXnxuhTQD62i45YuX+j7BgVxbE6n2vYlkGbaff
         +tjUFgpFd8DYyYx0LaZrGhoZa7v44rgTJx8/OdQg+ux0zY5XqOwJps2KsZRgDcjPNbb+
         ihBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq+rVZyh88nLqt0BI3sBVYidH78nxPjtRU/b22uDkwoMRNfs6UNLkLxYDDUWIygsyrR7klqsF4r4JWjx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FnjrRwDBeG4MD2l8oK5/JUlvO8fzdZyTwMqhON9osghU/ZD9
	aulZhta1xQ/qvCnvKItGdzefxIGHpFJjDnHd4B1MhsEFAMM5qTWR+GKcOP9eCG8OOrcPLJSVxpM
	+eEszjBubSHkb/wHF5SwE5pm/ZQXTVgCZBnH07pEc
X-Gm-Gg: ASbGncsav6fEqqUz0LEl8UFQu02ccM4iuzFTXtUtYR9Fs7ZZoiHd9ziIk3stgMFoswz
	lhMZhxHMtVfkPbxAxbCpFMURTQ30JmD55JdLz/MGb6dJfnioZjI6LAiKebqfBvE5R/TLB7LfeqY
	Ldh/HlYWxbugepBO8nsK2mjAuKUeR9nXd51niWOHVPmZ61rjltQlSV7K/sFQqBQ2kRqCDX42XZ1
	/gg6xCdInimEExBVxT4N37H5BIIq7v/m3fp
X-Google-Smtp-Source: AGHT+IGS1pBzG3LJi4LJWdLgnoIui/QvinF2gyEaQMWHssnXGuqeTADFCMUiB+RW5hDg9XSqK51zw3Dazhk17SzXGFw=
X-Received: by 2002:a05:6000:400b:b0:3b7:8914:cd94 with SMTP id
 ffacd0b85a97d-3bc6aa272c6mr3281632f8f.41.1755404928970; Sat, 16 Aug 2025
 21:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250815225259.3012455-2-sudarsanm@google.com> <aKA7180s0HdLfOKc@harry>
 <CAA9mObAiQbAYvzhW---VoqDA6Zsb152p5ePMvbco0xgwyvaB2Q@mail.gmail.com>
 <498fc518-d78a-43a4-9196-507891e9b844@suse.cz> <22666e86-2523-4136-94e6-0de126fcec1e@suse.cz>
In-Reply-To: <22666e86-2523-4136-94e6-0de126fcec1e@suse.cz>
From: Sudarsan Mahendran <sudarsanm@google.com>
Date: Sat, 16 Aug 2025 21:28:12 -0700
X-Gm-Features: Ac12FXw1MXLMOdAVkoTs0tVE-q5mUXa0vf_noCRKGgACEIZjA3myKp54MhzQnoA
Message-ID: <CAA9mObALY3L=G3Ti52pSnWYGHspDa01Xr6NeiWHwTGOX76K7nw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Liam.Howlett@oracle.com, cl@gentwo.org, 
	howlett@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, rcu@vger.kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, surenb@google.com, urezki@gmail.com, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 11:31=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 8/16/25 8:31 PM, Vlastimil Babka wrote:
> >>
> >> I assume somehow the free_to_pcs_bulk() fallback case is taken, thus
> >> calling __kmem_cache_free_bulk(), which calls free_to_pcs_bulk() ad na=
useam.
> > Could it be a rebase gone wrong? Mine to 6.17-rc1 is here (but untested=
)

Yes Vlastimil,

You're right. It is a rebase gone wrong. Thanks for catching this.

I ported this patch series on top of v6.17-rc1 using b4 cmd

b4 am -o - 20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz | git
am --reject

For some reason b4 merging yielded me this:

git show 893ee67b5c75e7411e4e3c6ddaa8d0765985423e
slab: add opt-in caching layer of percpu sheaves

@@ -5252,6 +6133,15 @@ static void __kmem_cache_free_bulk(struct
kmem_cache *s, size_t size, void **p)
        if (!size)
                return;

+       /*
+        * freeing to sheaves is so incompatible with the detached freelist=
 so
+        * once we go that way, we have to do everything differently
+        */
+       if (s && s->cpu_sheaves) {
+               free_to_pcs_bulk(s, size, p);
+               return;
+       }
+
        do {


Whereas the original patch [1] had this instead:

@@ -5033,6 +5801,15 @@ void kmem_cache_free_bulk(struct kmem_cache *s,
size_t size, void **p)
  if (!size)
  return;

+ /*
+ * freeing to sheaves is so incompatible with the detached freelist so
+ * once we go that way, we have to do everything differently
+ */
+ if (s && s->cpu_sheaves) {
+ free_to_pcs_bulk(s, size, p);
+ return;
+ }
+

I have no idea why b4 got confused between kmem_cache_free_bulk() and
__kmem_cache_free_bulk().

After I fixed this issue, I'm able to boot the kernel successfully.

[1] https://lore.kernel.org/all/20250214-slub-percpu-caches-v2-1-88592ee096=
6a@suse.cz/

> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/
>
> This branch specifically
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=
=3Db4/slub-percpu-sheaves

