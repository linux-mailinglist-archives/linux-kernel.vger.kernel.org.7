Return-Path: <linux-kernel+bounces-887839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD71C39322
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E782189F072
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8782D8DD1;
	Thu,  6 Nov 2025 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/taTsnx"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70C28E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408722; cv=none; b=EyRGRJBtHtov8dFJ/NcPVljzJ/i9kkqWZ9vcYz8NDPc75TttOn6452PhsXNK8bohlk55exQjA6KxJ7MUzo06P6JVvkWYJxIbQNgmnDjsP+HaWQIJy7t1fLhCgD0bNeHSLo6jTXrb70co+ky/wffVcFf+/FqYMd3wPPDhHEk84Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408722; c=relaxed/simple;
	bh=oLVGhCmDPqe5/1InNx2MFKI/VYmuXn1CiQS9ELK8UHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2u1BsKK4rDgV5QqzaKBOPX07B6K7QTj+fDwDivGSji6ycSk8Wdr2L6/b7uXaFik3b+O1Sg9jVZI+CWrXFj6Zl+3SI7MhkILOGJMh5RYiylVRYHBLW0LBaEeghEZ8Qwb5cddEkCOn0AVBL55gYRheH6KVSJ5ca+kFPVpplRW5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/taTsnx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so808102a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762408719; x=1763013519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzTY9uLnmKMTRAxdEztuc4L+zqZ9LZYXdyYI+Bt2y5U=;
        b=W/taTsnxIm4wlxFZJzTVvaNq7qwuFpU/ZtiFDd7XXkrYY8ma8zbzaxIdSk+z3itbnd
         vPryFA9Cq9EmBr51N13se7q+sesfsunsM6JwkQ4nGI1ICrzUmkN0zBvvYChfINrfjBLH
         0tmWQUlq4DvXLB8IYYankJheyCGz6qw0fNyD2Dj/TG+BXd/8JrFhe9xP9P9IY20x5VfA
         bKPIuhhu+l9TmIORdJXucRyHFD52TJm9KYyM35d6bvPGXsHBvGTmHShMxPprZPQ00e/8
         k6uCrmozF0eelokZZP5mcrY7w9PFr5Vzd4C1YSWS8gdzNrBX519tauAML5QMcyWOugfy
         /zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762408719; x=1763013519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzTY9uLnmKMTRAxdEztuc4L+zqZ9LZYXdyYI+Bt2y5U=;
        b=QmEADUen2jEV16ytskiiQIgyAjl6ZgOOq8DwLiT+YPqefkaO5+20gNpw3I9Ht/G0bg
         c+G5oyTpEXqS2UGhdC/QFatbjC4cdxS+QNB6H7pWMD1GW9NboAdwgRCFnlzdN5vPD+On
         uFhYKdUtQRzXMWuvA07Sd3I8Xtd1T7VvJYgCaSdvEZOecw5cN15uowttZsdkvrlwXSfB
         D+tzrrgIywbOUWwEGy3sQhgE+y+rup2BT7PjprExTGNhRNyq15T+ch+GlxfHziH514wq
         R0uz/VeLaoXsaPkgHVjTc4jqd8WmqrcZdK6a0rRD6FWV89pwNtAkdDXZZbsgpCOXulG6
         S5jA==
X-Forwarded-Encrypted: i=1; AJvYcCV3qgcXrfdXqfRQgwk+zMU8awGgEqWLm3fYGnycXTJUnJlxstXdjhU0yviT+6aYYzMj/wVcdCLdr5Mms6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWchUTto4ywvnSL/+MqhdOziIPR8QeqC9ffGaMiLvs1pryCoLy
	+HPTP27tk2rGOGLagEugbwNsUID5C81SMMTEw1vhM1XlGaOYgGKXPcl+rQVs7mNO9I3cunFQt4b
	5TzFelK0Ro7gnVmN7R6X8jHd+LfzFIcY=
X-Gm-Gg: ASbGncvGGucpyFCAC2nqNUfggl+YCwMLpDO1hXEw62RLJ4R+uw/iShn7rWutTxXId7h
	6BJTYMS7wg27zM9Mej2K5IwG4lYPuiaQV0nG/p9HRYKp9RnDw0GGISMyCUGKPpWSIk9EHnQAV0D
	hvARj3TCbdygp8O22A3xdNEnr0WUnLtmVpYEPtdDOWaK7GIOz5XUPXJ/BYt7u3+Xf4JipDpkzcm
	LmwjkQl8E9iOoB7Gwa1UaR4cCrFpCVySZ8LG5Z4ZjhnKdCfmvQilg9L9IukKj6c
X-Google-Smtp-Source: AGHT+IEsh0YfLrQ6Befz1e+5Z8Ke8inELoHU9k4IjVehY2VMbpWVDfJ96d2X4MolrEK4yj2WsuO8tzP4B9EUAmcajOk=
X-Received: by 2002:a17:906:f59b:b0:b40:664c:3317 with SMTP id
 a640c23a62f3a-b726555b4e3mr588270866b.43.1762408718932; Wed, 05 Nov 2025
 21:58:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690b99ab.050a0220.baf87.0057.GAE@google.com> <fcikaqlrbqzc6utdbd3utgkkw52474l2hom5lzpbmh6wsvbb3n@tpex3btkz34q>
In-Reply-To: <fcikaqlrbqzc6utdbd3utgkkw52474l2hom5lzpbmh6wsvbb3n@tpex3btkz34q>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 6 Nov 2025 13:58:02 +0800
X-Gm-Features: AWmQ_bmVYfN0T17nYGfIatRf7DhVL4mqCPN_Mdqublj-P_yXRMvrkecHbryO4K0
Message-ID: <CAMgjq7Du2iVn65UOCWZvXKw0XkB6JRsVv6bHJyg72bGeafAD3A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg (2)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: syzbot <syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, david@fromorbit.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 10:58=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> +Kairui

Thanks for the Cc.

>
> On Wed, Nov 05, 2025 at 10:38:35AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    ba36dd5ee6fd Merge tag 'bpf-fixes' of git://git.kernel.=
org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16515704580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De46b8a1c645=
465a9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc5b060ce82921=
a2fd500
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7=
976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/62471ef815ed/d=
isk-ba36dd5e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e7a72af6e621/vmli=
nux-ba36dd5e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/352eec7dbce0=
/bzImage-ba36dd5e.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 13908 at mm/list_lru.c:100 lock_list_lru_of_memcg+=
0x30c/0x4c0 mm/list_lru.c:100
>
> This is VM_WARN_ON(!css_is_dying(&memcg->css)) in
> lock_list_lru_of_memcg(). It is unexpected as it can only happen if
> (1) list_lru_from_memcg_idx() returns NULL or (2) lock_list_lru()
> find l->nr_items is LONG_MIN which is set after CSS_DYING is set.
>
> I don't see how (2) can happen. For (1) to happen, somehow someone has
> deleted the given alive memcg's list_lru_memcg from shadow_nodes
> list_lru. Not sure how that can happen without some memory corruption or
> unsafe updates to shadow_nodes.

Last time I saw this was due to memory corruption from other components:
https://lore.kernel.org/linux-mm/CAMgjq7Dxv4JwebBtR18_9TpNX_7ej5HXEN1s1sitB=
+H+4rCE-Q@mail.gmail.com/

Another time was due to an allocation of shadow node missing mapping_set_up=
date:
https://lore.kernel.org/linux-mm/20241222122936.67501-1-ryncsn@gmail.com/

>
> I think we need to wait for syzbot to generate a reproducer to debug
> further.

Agree, this part has been very stable for a year, hard to tell if there is
any other allocation missing the xas_set_lru callback or something
else is wrong, worst thing could happen now is some minor memory
accounting leak.

I'll have a look from the code side when I have time.

