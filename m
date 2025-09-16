Return-Path: <linux-kernel+bounces-819141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022EB59C06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738391B281C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17220B81B;
	Tue, 16 Sep 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqSCHljv"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40033315D2A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036317; cv=none; b=rxWWV68OTx0F/CpzwVVIaez34HYqxXOsAhwEbQTwLQ2Hib7m3RttFo17l8YwS8wN6CZ+Li8/1ZgMpK8wZ6JFDSyYoj2WE2x4KSJJFueIAvIFHagjtnViXPfOv12RFoOtfyqfIwHtwRDrD4q9yCg9se+nIlfv7Dd8/wutoqVXRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036317; c=relaxed/simple;
	bh=/luls4gIlkzY0q88TLuslOsp59hW9QK709W2wFxEZh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XneSH7irhDWcXeZtaWixmtMXDojF4aHdjihMjpuiyHaP0COl5AAYqKkaET3xDnOSj2ZD+JjvaIsGn1GYsahUjvwZb6FMBY3rZ5GoA1Ko0QK02cVUydMSf5LM+fLmptfqLPAa5+70wJfaUAE4nOcaAWH/cNFDaXFxCMM5qT9k8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqSCHljv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7227bc08c97so40124697b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036315; x=1758641115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0CN37Sd0cYVaSTUFD34oLWNYYkEOvdYhiUF+fG/Gts=;
        b=ZqSCHljvySWtsAkK9PntABSUgThW6gfDz8qeYMbdSHWTWDxm3N+B9fCp9o0XQ8bleS
         wrHPV+Tb2KK3/BxWllVl7/ZmmV7nZV82DhvnMKH/YaeVX2CcjLzKk6OpM6F5oNqUACQ2
         CTDF+hHDlQ4WXHaFvJrMc60sLiPaS7UMPSYccNjjik7qKaz0S5cRD4NerkSejJS5yDQI
         wgkWnuU8sDW+U9+PllZDDc/hkZXx6ftCE8IzJU3Y/uKGLuu0JY9tzucL3l9F/t76XYjf
         g6QnkCR2A67Jln4jz/VyXQwzxagOy0IOtaZu6WsVu7oPKXZEO8PUAtVp69kCKyQpAdAu
         wGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036315; x=1758641115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0CN37Sd0cYVaSTUFD34oLWNYYkEOvdYhiUF+fG/Gts=;
        b=QT7gwFYh3JChI8jj/XWZyKBv5dDJbpQwBInV0d8GPP9scLt2nq17FcHzavM7jSu7SZ
         04HwJunUXBWZq+VFIyJtgt/cn1LbrF4Y+ZjQq/bpO42hKRV0Rxpx0d/fO9uRAGnHj4eX
         oEx1G1Xot0nwWtM10rw1wHsc2Q3mdSR4GCT+j9Ok/iiRbAIIt+bBPmVAUGW9MOWC0DPb
         wynrIc8iAdHYQK1Sn0gdemfLMoU4X01kqFF9YzfkyYuPSJKPxjP4/GJPRcqYYFcSRinQ
         8ewjG1C3ZialsjFZeJnuEsyyvvkc4JZVQH6RVjI4OFjEhS6LK7vqxzQk7MHDYbSjWFAB
         3XXw==
X-Forwarded-Encrypted: i=1; AJvYcCXsstryrCr3xojH5YNkBTSJoy0WNhzyaGe4EIRDXOcBIH/cb3xJ6kyydCoDSo/qaPo6akApPRUurcsdBzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYGqSb0QmsVc2jvbbH41xGQHdaJ5ElivdddDFRrwOtDxT38By
	gnpmmgvxFoSydRmkQJ2TmYfcMRIOVuunbS2df+BZtgRnZRevTs2Wk/daniuvg2xvXXQyZop0XOF
	Qsx+JK06yYnyrpv92ADG9RmCLUl1Vvic=
X-Gm-Gg: ASbGncvfpe2xW3VgMdPPA6a58hg+kRClvjWcaSPAmy1B8xNu7rZz13gkfjE6uvNy6jr
	giJTXEopPrPEUeCwJbPlN0cNvpxLgTQptkXaHYTq0MiRBb2KOUmqQU4h5WP9GatW2k5lEPaNO4C
	dsS1Nh5BvNbRqK9aZG+3SFUCbKuzhN5vueOvxsdgYCxAs7B8oYMnL/VX2Hef279zyvflN9C0Chb
	df+zwAS3KUWJtOjALtjilcn39Rhn5LdC9lOGECBzvFc9euvw1zCLlvQ/6gdIw==
X-Google-Smtp-Source: AGHT+IG+Vr+0KTJcUpSOFsKadmEByVjhhHvih2H7TiR13xbcSMjpY2FBWnQx59o/IX+v2wbe+0jT8ntwYLBXpQNjQqU=
X-Received: by 2002:a05:690c:6c01:b0:731:1bc7:782d with SMTP id
 00721157ae682-7372017a432mr22922887b3.18.1758036314672; Tue, 16 Sep 2025
 08:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
 <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
 <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
 <CAPhsuW44HznMHFZdaxCcdsVrYuYhJOQAPEjETxhm-j_fk18QUw@mail.gmail.com>
 <CAEXv5_g2xMwSXGJ=X1FEiA8_YQnSXKwHFW3Cv5Ki5wwLkhAfuA@mail.gmail.com>
 <CAADnVQLuUGaWaThSb94nv8Bb_qgA0cyr9=YmZgxuEtLaQLWzKw@mail.gmail.com> <CAEXv5_griDfE03D1wDLH8chgCz0R2qZ5dAeiG0Rcg5sAicnMsg@mail.gmail.com>
In-Reply-To: <CAEXv5_griDfE03D1wDLH8chgCz0R2qZ5dAeiG0Rcg5sAicnMsg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 16 Sep 2025 11:25:03 -0400
X-Gm-Features: AS18NWCDT1fo9Q_SScWx2srqmzTJIxk06hwdbw2tk2Uh1xwaeYevlco27hFBxxs
Message-ID: <CAEXv5_hKQqFH_7zmxr7moBpt07B-+ZWB=qfWOb+Rn9Vj=7EX+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 10:10=E2=80=AFPM David Windsor <dwindsor@gmail.com>=
 wrote:
>
> On Sun, Sep 14, 2025 at 9:10=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Sep 13, 2025 at 3:27=E2=80=AFPM David Windsor <dwindsor@gmail.c=
om> wrote:
> > >
> > >
> > >
> > > On Sat, Sep 13, 2025 at 5:58=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > >>
> > >> On Fri, Sep 12, 2025 at 5:27=E2=80=AFPM David Windsor <dwindsor@gmai=
l.com> wrote:
> > >> [...]
> > >> > >
> > >> > > Maybe I missed something, but I think you haven't addressed Alex=
ei's
> > >> > > question in v1: why this is needed and why hash map is not suffi=
cient.
> > >> > >
> > >> > > Other local storage types (task, inode, sk storage) may get a la=
rge
> > >> > > number of entries in a system, and thus would benefit from objec=
t
> > >> > > local storage. I don't think we expect too many creds in a syste=
m.
> > >> > > hash map of a smallish size should be good in most cases, and be
> > >> > > faster than cred local storage.
> > >> > >
> > >> > > Did I get this right?
> > >> > >
> > >> > > Thanks,
> > >> > > Song
> > >> > >
> > >> >
> > >> > Yes I think I addressed in the cover letter of -v2:
> > >> >
> > >> > "Like other local storage types (task, inode, sk), this provides a=
utomatic
> > >> > lifecycle management and is useful for LSM programs tracking crede=
ntial
> > >> > state across LSM calls. Lifetime management is necessary for detec=
ting
> > >> > credential leaks and enforcing time-based security policies."
> > >> >
> > >> > You're right it's faster and there aren't many creds, but I feel l=
ike
> > >> > in this case, it'll be a nightmare to manual cleanup with hashmaps=
. I
> > >> > think the correctness we get with lifetime management is worth it =
in
> > >> > this case, but could be convinced otherwise. Many cred usage patte=
rns
> > >> > are short lived and a hash map could quickly become stale...
> > >>
> > >> We can clean up the hashmap in hook cred_free, no? The following
> > >> check in security_cred_free() seems problematic:
> > >>
> > >>         if (unlikely(cred->security =3D=3D NULL))
> > >>                 return;
> > >>
> > >> But as far as I can tell, it is not really useful, and can be remove=
d.
> > >> With this removed, hash map will work just as well. Did I miss
> > >> something?
> > >
> > >
> > > No I think actually this is easier.
> > >
> > > I will prepare a patch for the race in cleanup I stumbled on earlier =
which is still there and could affect other users.
> > >
> > > That said, is there any use case for local storage for these structs:
> > >
> > > - struct file
> > > - struct msg_msg
> > > - struct ipc
> > >
> > > I can off the top of my head think of some security use cases for the=
se but not sure if hashmaps are needed, perhaps struct file
> >
> > Sorry, no. This is not a copy paste territory.
>
> no i get it's not copy/paste but I have the series for struct file
> ready for submission, with selftests. this is also a performance
> critical use case and there will be numerous struct file on edge
> servers.
>
> > The existing local storage maps were added because
> > performance was critical for those use cases,
> > but we made a few mistakes. There is a performance
> > cliff that has to be fixed before we adopt it to
> > other kernel objects.
>
> ahh wasn't aware of this.
>
> > Please use hash map and consider wrapping rhashtable
> > as a new bpf map type if fixed max_entries is problematic.
> >
>
> makes sense thanks
>

Hi,

Thinking about this more, hashmaps are still problematic for this case.

Meaning, placing a hook on security_cred_free alone for garbage
collection / end-of-life processing isn't enough - we still have to
deal with prepare/commit_creds. This flow works by having
prepare_creds clone an existing cred object, then commit_creds works
by swapping old creds with new one atomically, then later freeing the
original cred. If we are not very careful there will be a period of
time during which both cred objects could be valid, and I think this
is worth the feature alone.

Also, the main reason we want local storage for these structs is that
LSMs use them. Every classic LSM (SELinux, Smack, AppArmor, TOMOYO,
Landlock, Yama) has a cred blob, all of them have file blobs, ipc
blobs, superblock blobs, etc. struct cred is the basis for subject
identities in at least SELinux, probably others I'm sure.

With respect to performance issues, correct thing to do is still build
out these local storage types for in-kernel LSMs but then fix the
performance issue.

kp do you have any thoughts on this?

> > pw-bot: cr

