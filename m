Return-Path: <linux-kernel+bounces-874804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A80C1722A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E14F4DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A23557FF;
	Tue, 28 Oct 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF+kY4sp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6C29C33F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689285; cv=none; b=iH3x2jzPmO+PYrBw3R7ssC1JVSePS7EIpXLeGtDo9g4uSOAHSOiY/PMs4ZRqv6vfQva8HFtNtI9wM+Clh091GwCpzED6o2UOC5TeIkLQd/WO/vcbArGsPOjZ6+OUXt8Get/a3eBIpLcd79uvMRNwRckGW5LxQc24hFpkVdbm258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689285; c=relaxed/simple;
	bh=xxLjTcs49KVHsuBWJBp8+5TQJEuXYXCZzLvCqnDtD3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leL/XnRGhuWUjL204ZRzT61YPhyylWXFGdUANvfl2v1C+r8rqoCWTwrbuB5Go6I/09NtxkzWHGkfzDiQb3NPiffcu3BUrLAFUVims/OXSqTuC1NDzqLHnvk5Bwd/k0UHKbHOum2fQhqElmJWXhViwGXFqjQPdW5y+Liy04aajIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF+kY4sp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee12807d97so6120541f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761689281; x=1762294081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V+762A1daN4J9oNjmmT69+inXV9phu8pPtP3M7FAMM=;
        b=lF+kY4spAEP0CrGbZfaCAYVN7tjQyJ5/IL8S82YAu/KyjKTunYI52v+6qy/xg2iw//
         2Pi2f7HzzYPuj1lhyuMfD8Rx2xK+JiCvtEJyPmXulM0ugiz773sMLNM4Z2uzDz0LtMQz
         R1D9Hs53WOC11wBg9ld1ltuUSCRYYkHvQMcQYu0F44xXeWnmoldnNqbTPjdDPxjuoZFc
         jeber4tOBrgqsoJ/Pcvxy6biJejoZFO5BGnMLtHxMuxh5OxB7JnnuDWextrF1tC/8s2M
         4653WgUejRDf3dfmvisPN3TAONI0sLwUwAjRtC8ZUqKPjWS8ZxYKQziRHPSMuCOOvEYA
         +xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689281; x=1762294081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V+762A1daN4J9oNjmmT69+inXV9phu8pPtP3M7FAMM=;
        b=pGxhl6I5WRRDoFryP5dubZCEGl5PeLhXZsQ+4hEV9IvUMF2tSlmKFHYTj0HranGxc2
         JZ7D63usW6ll0PvhUi196Pga5GXnF1u7DcE3lwMSBOtXHLuaG4bV0VE7ajR8upIGmLh4
         bjHq0Xw+PgGaD9L+AESuMchhxHP2OQS4mniFOkcgO9cGYdL5akcx4RedCL7Z9H0qWS0J
         IwGt163IjfiVXiO21IDkJ+a/lONrfdjAQ4/nDP439YPqEVndu5edsRAFya/cFyttLiHj
         VfmTTG9TBb03RhGkLpY8ZbSo+bSEzVrCN476aIqVfedSHzyUFgyppC5nd3kGPhL7XJLH
         aPcg==
X-Forwarded-Encrypted: i=1; AJvYcCV0cpouu/atHK3X8cd5SZneYmIVyljTuEo7BCcNOe44zpmX8OJysddXFQBnblYRLM2271TEpCQg+pqa8VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyWQXWAKTnOpt0ThWGRsLoZQwMJA4ncLgP/8au7L7b6xv0hLJ
	fCwilGL8FM0Zby42lM0dn6nj5/p1or/1vweOIm9KBpCz1/3ZX1ZHSzqHWG7yOWm0iE4G+3E3Wn1
	y6L9JeMY11fhOhzypF1+49BgIAyOIOEs=
X-Gm-Gg: ASbGncvzcOZ/oAsXI4NT36s7xN9WYYY7cCMXLL0LGs2+nH5PyccVNA4+Yw97U14ard9
	fMSRgH6QVsVRwit9zmDsWnsUm1abqtbfWLlJbnOlH+jdw7sCM87uW8dWYy3c++Gy8TgB+9A3OMb
	PFPgD7XwyK+CRlIxR4mhcAIvRt9wxy3hUprPArZfFLyUnfOYKoWezoHC/O8WLdNB60DhuxIH3TM
	aN0Z9Av5gWYYmp5X1qFVa9ODoKZkQezJtQCkqcwJpqByAFV9EC8+uGahuWaHpkwg0HsauBX1Isd
	wKJYQVz6/LGlLDen/g==
X-Google-Smtp-Source: AGHT+IGICaO3BvlkXeLb+EbVNUOXQ0U63xZwGPTFrBoahOPE5MZiS6EG5jxPBtr1ZSjP3nUamu+JhVo3r42lsbR/Cqg=
X-Received: by 2002:a5d:5849:0:b0:426:ff7c:86d3 with SMTP id
 ffacd0b85a97d-429aef78c90mr552970f8f.13.1761689280869; Tue, 28 Oct 2025
 15:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev> <CAADnVQKWskY1ijJtSX=N0QczW_-gtg-X_SpK_GuiYBYQodn5wQ@mail.gmail.com>
 <87qzumq358.fsf@linux.dev>
In-Reply-To: <87qzumq358.fsf@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Oct 2025 15:07:49 -0700
X-Gm-Features: AWmQ_bn1qYp03A-J3vHinawzwNNuHcAYrjS8vVp0NbrkX9UuC4qoOTSYxLLTXTE
Message-ID: <CAADnVQ+iEcMaJ68LNt2XxOeJtdZkCzJwDk9ueovQbASrX7WMdg@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Song Liu <song@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:42=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Mon, Oct 27, 2025 at 4:18=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> >>
> >> +bool bpf_handle_oom(struct oom_control *oc)
> >> +{
> >> +       struct bpf_oom_ops *bpf_oom_ops =3D NULL;
> >> +       struct mem_cgroup __maybe_unused *memcg;
> >> +       int idx, ret =3D 0;
> >> +
> >> +       /* All bpf_oom_ops structures are protected using bpf_oom_srcu=
 */
> >> +       idx =3D srcu_read_lock(&bpf_oom_srcu);
> >> +
> >> +#ifdef CONFIG_MEMCG
> >> +       /* Find the nearest bpf_oom_ops traversing the cgroup tree upw=
ards */
> >> +       for (memcg =3D oc->memcg; memcg; memcg =3D parent_mem_cgroup(m=
emcg)) {
> >> +               bpf_oom_ops =3D READ_ONCE(memcg->bpf_oom);
> >> +               if (!bpf_oom_ops)
> >> +                       continue;
> >> +
> >> +               /* Call BPF OOM handler */
> >> +               ret =3D bpf_ops_handle_oom(bpf_oom_ops, memcg, oc);
> >> +               if (ret && oc->bpf_memory_freed)
> >> +                       goto exit;
> >> +       }
> >> +#endif /* CONFIG_MEMCG */
> >> +
> >> +       /*
> >> +        * System-wide OOM or per-memcg BPF OOM handler wasn't success=
ful?
> >> +        * Try system_bpf_oom.
> >> +        */
> >> +       bpf_oom_ops =3D READ_ONCE(system_bpf_oom);
> >> +       if (!bpf_oom_ops)
> >> +               goto exit;
> >> +
> >> +       /* Call BPF OOM handler */
> >> +       ret =3D bpf_ops_handle_oom(bpf_oom_ops, NULL, oc);
> >> +exit:
> >> +       srcu_read_unlock(&bpf_oom_srcu, idx);
> >> +       return ret && oc->bpf_memory_freed;
> >> +}
> >
> > ...
> >
> >> +static int bpf_oom_ops_reg(void *kdata, struct bpf_link *link)
> >> +{
> >> +       struct bpf_struct_ops_link *ops_link =3D container_of(link, st=
ruct bpf_struct_ops_link, link);
> >> +       struct bpf_oom_ops **bpf_oom_ops_ptr =3D NULL;
> >> +       struct bpf_oom_ops *bpf_oom_ops =3D kdata;
> >> +       struct mem_cgroup *memcg =3D NULL;
> >> +       int err =3D 0;
> >> +
> >> +       if (IS_ENABLED(CONFIG_MEMCG) && ops_link->cgroup_id) {
> >> +               /* Attach to a memory cgroup? */
> >> +               memcg =3D mem_cgroup_get_from_ino(ops_link->cgroup_id)=
;
> >> +               if (IS_ERR_OR_NULL(memcg))
> >> +                       return PTR_ERR(memcg);
> >> +               bpf_oom_ops_ptr =3D bpf_oom_memcg_ops_ptr(memcg);
> >> +       } else {
> >> +               /* System-wide OOM handler */
> >> +               bpf_oom_ops_ptr =3D &system_bpf_oom;
> >> +       }
> >
> > I don't like the fallback and special case of cgroup_id =3D=3D 0.
> > imo it would be cleaner to require CONFIG_MEMCG for this feature
> > and only allow attach to a cgroup.
> > There is always a root cgroup that can be attached to and that
> > handler will be acting as "system wide" oom handler.
>
> I thought about it, but then it can't be used on !CONFIG_MEMCG
> configurations and also before cgroupfs is mounted, root cgroup
> is created etc.

before that bpf isn't viable either, and oom is certainly not an issue.

> This is why system-wide things are often handled in a
> special way, e.g. in by PSI (grep system_group_pcpu).
>
> I think supporting !CONFIG_MEMCG configurations might be useful for
> some very stripped down VM's, for example.

I thought I wouldn't need to convince the guy who converted bpf maps
to memcg and it made it pretty much mandatory for the bpf subsystem :)
I think the following is long overdue:
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..af60be6d3d41 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -34,6 +34,7 @@ config BPF_SYSCALL
        select NET_SOCK_MSG if NET
        select NET_XGRESS if NET
        select PAGE_POOL if NET
+       depends on MEMCG
        default n

With this we can cleanup a ton of code.
Let's not add more hacks just because some weird thing
still wants !MEMCG. If they do, they will survive without bpf.

