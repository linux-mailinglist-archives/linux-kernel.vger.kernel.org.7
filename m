Return-Path: <linux-kernel+bounces-815969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD36AB56DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE83318988B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3991E8342;
	Mon, 15 Sep 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXNtLfRJ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A51E3787
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757898606; cv=none; b=OeZUpf+3oSq7V0eFzyzVls/lHkWS8N1zE4OgffN02ZVR4LA/ZeFDhR/LPLnv5QUuNdu7HYgP4WhrLS8K5qMMuWGFKjXXXBWWJAJ0Vh0jLRp+6rJFf35NJL6vNixsdOjOuRtfw1sYoO7FCqpSpuVwO5ToAPtAd8TarUkYLD1GL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757898606; c=relaxed/simple;
	bh=9EbPEV4t9uKYae1tGgVJ+2UWK0ihUYSSLQ16wEfVy3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DP6fR6E4QJSEk8Zk8CqhhlpL8f3h9j8e2nMqaL2Tfb2eOMTzRvlj6G2BgjLP4nzrl30ahgQHiQSENucYt92p7xlGgHCpoKVMSZMM0iODnGvldjYz4U5R13zhj3PvS9tnV6/q+aw1T4tknyIGPvJb3Uxa273vEMbvlCLInKVedcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXNtLfRJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e9ca387425so642957f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757898603; x=1758503403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49Eqg2HdajKAwzkRCOkvbIc3muo7YrinnafKf5gLJ64=;
        b=iXNtLfRJkIgHYhjAYrTVXGuwdo/rG/Hh5Swh/VtxhFRCje+f53lxs6KTje1qGvBtdt
         8brQFvsV5mdvVfEzy4WwOu+N+PF5IxAdempi3o8IN0YACCjnq7GHgcRlC5vc56DrxW9m
         YOYg/byNqFGeqHaDlisvNgjm8cFO3SYjfcxmEuaEtvFbkUcJgsTW9cDL9Gr9Z1kfVzBR
         4ORxxB/8ftajJZAs4eSNMql6L4Nw+fnAqp9xdhkaDFusZR0vtBFzdeyM4jYXB7PfQ9I/
         Wl1+ssdPRlsNk5Gc7xl7gcKAWZziSjIip2CHPPrnPM/CnnBHXZN9Z2bt60EOyW9srxoU
         cUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757898603; x=1758503403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49Eqg2HdajKAwzkRCOkvbIc3muo7YrinnafKf5gLJ64=;
        b=iKxt7zz+wOjqsJkM5qg3mVYlYV18amxg6hQwkkPAJcwx14WUjSYHFaiG8iiWsd3F3b
         4bUYXLPcBDRPTXLYDg3vBhdiRDRACt62qe0eL4XVK3WIXQmeOkjnqO7/VHbNSGKOpSXp
         12LFfAqzQMTevFx9NbvUyEASwxi4TUGh4feEzkzYiMgXylJriDOQopNvfFgDrga7B0JZ
         ZWr0ZztfSV/EEtDh8fLakYwJFpAuhSW/6AnJuM05Who6rrYGzKXMbU6uN8wzUTA4uijv
         4Oh2yB5nE1CZEytwvQFKLI3SirtTNZPSu6UDue+fAfSNseiYtDotLfH8wxMgZyngfyK9
         lM8w==
X-Forwarded-Encrypted: i=1; AJvYcCV0e9AlYeSgYja3SwJThUp1MbDZAaCME5zOeq0VFkepPFUBJduzYoRVsqJjVLv6PQZgY3/g41MMOqeekMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYzInr/IFpwFXIMKUKc8jvL5G/sfi0MrJFzGJEtX2wk3yuHQ/
	Cvs3TrT6mO0dr+ITCxdAPBrMsNzhCAHcKKuBVW/2nDQo8gCEkWHf3bJhYihPBRh4b4A+nSgczFL
	DEfqMkusPLG2f0PmdQ0k33FeRxRS95XM=
X-Gm-Gg: ASbGncsHfpVrxjV1+t3E840hJICO9JEZzpUZKdCS7NF0AI3oTvw8DUpOdyLwwiCvM1Y
	HlTNtTgg/hV0rNY3VxUdGV1b3dEpNLzXolcH6GfQneKrMevW6tfceMMKAlhkj5e8RbmO7BqpvM6
	ibDIEIEx9mCAuRyLjEyeAyg42q5vpemEPvzJ4WCWKTSwqABuhDgZlcUGx7Zr37wWVQb3X//jfh7
	c1m9xq33go/sjwQaVCFhRkU/bY4giqRew/CwhSd0dqCM0JEHrY=
X-Google-Smtp-Source: AGHT+IG7nlWNjOib6Whg6ssHZlCGpXRNpzM5PmwPWlwvW1tMpmAE7/k8Sr8HQXSwflMqJo+QCibLUNA8AwR/Jz0K2XE=
X-Received: by 2002:a05:6000:4024:b0:3eb:5ff:cb38 with SMTP id
 ffacd0b85a97d-3eb05ffd028mr540853f8f.20.1757898602524; Sun, 14 Sep 2025
 18:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
 <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
 <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
 <CAPhsuW44HznMHFZdaxCcdsVrYuYhJOQAPEjETxhm-j_fk18QUw@mail.gmail.com> <CAEXv5_g2xMwSXGJ=X1FEiA8_YQnSXKwHFW3Cv5Ki5wwLkhAfuA@mail.gmail.com>
In-Reply-To: <CAEXv5_g2xMwSXGJ=X1FEiA8_YQnSXKwHFW3Cv5Ki5wwLkhAfuA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 14 Sep 2025 18:09:51 -0700
X-Gm-Features: AS18NWDecpqylZuTOJMtTPem1QI5J3mYFKPo0s3KQ7hbmzWX51te-iEBMJs7Dvc
Message-ID: <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: David Windsor <dwindsor@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 3:27=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
>
>
> On Sat, Sep 13, 2025 at 5:58=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>>
>> On Fri, Sep 12, 2025 at 5:27=E2=80=AFPM David Windsor <dwindsor@gmail.co=
m> wrote:
>> [...]
>> > >
>> > > Maybe I missed something, but I think you haven't addressed Alexei's
>> > > question in v1: why this is needed and why hash map is not sufficien=
t.
>> > >
>> > > Other local storage types (task, inode, sk storage) may get a large
>> > > number of entries in a system, and thus would benefit from object
>> > > local storage. I don't think we expect too many creds in a system.
>> > > hash map of a smallish size should be good in most cases, and be
>> > > faster than cred local storage.
>> > >
>> > > Did I get this right?
>> > >
>> > > Thanks,
>> > > Song
>> > >
>> >
>> > Yes I think I addressed in the cover letter of -v2:
>> >
>> > "Like other local storage types (task, inode, sk), this provides autom=
atic
>> > lifecycle management and is useful for LSM programs tracking credentia=
l
>> > state across LSM calls. Lifetime management is necessary for detecting
>> > credential leaks and enforcing time-based security policies."
>> >
>> > You're right it's faster and there aren't many creds, but I feel like
>> > in this case, it'll be a nightmare to manual cleanup with hashmaps. I
>> > think the correctness we get with lifetime management is worth it in
>> > this case, but could be convinced otherwise. Many cred usage patterns
>> > are short lived and a hash map could quickly become stale...
>>
>> We can clean up the hashmap in hook cred_free, no? The following
>> check in security_cred_free() seems problematic:
>>
>>         if (unlikely(cred->security =3D=3D NULL))
>>                 return;
>>
>> But as far as I can tell, it is not really useful, and can be removed.
>> With this removed, hash map will work just as well. Did I miss
>> something?
>
>
> No I think actually this is easier.
>
> I will prepare a patch for the race in cleanup I stumbled on earlier whic=
h is still there and could affect other users.
>
> That said, is there any use case for local storage for these structs:
>
> - struct file
> - struct msg_msg
> - struct ipc
>
> I can off the top of my head think of some security use cases for these b=
ut not sure if hashmaps are needed, perhaps struct file

Sorry, no. This is not a copy paste territory.
The existing local storage maps were added because
performance was critical for those use cases,
but we made a few mistakes. There is a performance
cliff that has to be fixed before we adopt it to
other kernel objects.
Please use hash map and consider wrapping rhashtable
as a new bpf map type if fixed max_entries is problematic.

pw-bot: cr

