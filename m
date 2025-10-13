Return-Path: <linux-kernel+bounces-850358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69230BD299D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD96E4E714E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7003016E1;
	Mon, 13 Oct 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVWii0LZ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD630103D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352253; cv=none; b=Ne0oO2qKZWaAVn1inU83FSxIO0Rd4gN1X+PzFN5S2kBgIaBibzfpamNnVZhbi3mS+JnFfedrBKjfU55gBgmi7lz36MRMbhIyr3el5aR8+wb4/dAZ+jTbjGgwbqS0Vmbp/mH44ut3utZ8wGS00xh4NRYwSwnmMOCNZ44oDow+n3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352253; c=relaxed/simple;
	bh=O3X0TiZIveW4k8cyt/JSlo+R3755fvA2/0hcbOzZGbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRLyQCPTOlqFtB0PBnZp1P1g5FJuTfzcPaUS4Q0VfUr2hWtoA2pXxxCsdTLqWF12khApRnY0q/nKdrwgqdjiKItHkJolVu9ggON1lZ2IivD5GP4FegmAA6Er3vGy1JVaSsh8KItHXorBQt5N7jesLo+oxxu45C0OQ1fu91irA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVWii0LZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae31caso861915466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760352245; x=1760957045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkBdnT8UJZ9spJ4o+LGGXAfuLnGVrF5/StRbxbSJF+Q=;
        b=ZVWii0LZX7SATx5twSWvkHHki0QsOmaYvYfUHma6+1PXiVxE5lzX2SWm7tk9TOtrie
         i5YKhj0fCJuHgRuS/2V3P0ujqbMlE2TDe6k5PZg0LJ0gy9qthDMP95BgbQ9I+eKiY40Q
         0b8s6Xqoaw8n4BfaQiBjaLxnQ5BxuNNVVo7QwEOz+9UCPNuOq/PuoJO2/kanvhaCCFl7
         qRczCW2nzvklGO9yNf6dKqSY4Aq3N2gG4b98dz2FYVW3/wOYxgt58KqQ14Z5bqJBQsEP
         Nzxr3hU3xJaoXsPq2JVlIo3DWRY3zPyghPzaIlTJhM8FJQX+wEMvz83G2+x/GUyIgSqj
         ayyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352245; x=1760957045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkBdnT8UJZ9spJ4o+LGGXAfuLnGVrF5/StRbxbSJF+Q=;
        b=UZw2wU5rLaHWRCwHAfFnfIzX7ZLKLNLqF3w0vNpDjEaza+RUa85nHHky+tSgYu8MVK
         kSX0r+0k9MAxxkQSkhLO+NBwxHWczFsdIIp6jihy4wuuYcgRvjDvZNql9+DgeJ5YeCEt
         xS9fS8vrwzy/52WndrqU/Xs8Sw0zOnA4lbP4/EXucnYQY8G7h6d2vJc8fd5W+y8yhk8N
         rcIlAnRw5wJ4N4ZheCu3+nqn6/c8cmEETyhtnJduLjQdnaqOEyX9jpRaC2l/MhRf9nF5
         cwK8Cc4M6H78M+PbB7c2ZnzBVCbUUxOKO1nFjWsyriMyCSFAjDBKo+osN2mqHgP2Vldd
         SWHw==
X-Forwarded-Encrypted: i=1; AJvYcCUkgp0Pmd3PYfVn/ZKgzLsoXuQnFgCm2yAwtLq8a6JBxjdF/8OcVJjGb/bY1MOOO7aDfm/0e1lDTb/HpLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9V09+47Q0a5+jxZeobjCrovs/WHTih1foxJa7r+z2P9/ZbK2o
	vn++1NRU3MdEbz0JUu4oXRWO2LDEzP3jBHLjthwLYVazfQLuI5OURE1zxChbYSTGNb4AHs19Yu9
	RBeiXHoGlXANObp+KOFv+1F+YPid+F94=
X-Gm-Gg: ASbGncu8GhGKa33Qeahxj4OO4MRIlOhR39fVpJiMaKPVEZWRyD/XMdSY+U3FUxu/MIn
	OvmHir1Sdu1HM1hgnW4dssiQzMIhV6V5lDQr+iSZ5hmCW20Lhl3grGEj1V3FWDtAIcljwUin3Je
	dHWfJ6jdkALsv4WnOlBe73mhrGXIbSy5BFeVyNHuLwZF1O3lDGvUXHY6xRxK9Nl1up5jQLVCP+L
	+xHtHJxVIdvw6NgFr3S67kWToZCf4Bpje5lQnO354qMV7S1DiejLqQiK34=
X-Google-Smtp-Source: AGHT+IG1e4ZfncCZgDD5eYUYtafn2zCBthgYi2UEPZzzJwoVXS6N1xdM9TrKPkNnz/+k7zM28m93AOJReACKfslbMt4=
X-Received: by 2002:a17:906:6a14:b0:b04:626e:f43d with SMTP id
 a640c23a62f3a-b50ac4dac78mr1925236566b.47.1760352244808; Mon, 13 Oct 2025
 03:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013072244.82591-1-adrian.hunter@intel.com> <20251013072244.82591-4-adrian.hunter@intel.com>
In-Reply-To: <20251013072244.82591-4-adrian.hunter@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Oct 2025 12:43:54 +0200
X-Gm-Features: AS18NWB-xW4VG51UVOQO8Z5wayqj5aYVteBt62MXOsi6a1NIBoasXF3ooINhSG8
Message-ID: <CAOQ4uxi2_YNfXLgx+DbJnNe_sf7aJTkrxzn0ocmwgytLrBcysw@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/3] perf/core: Fix MMAP2 event device with backing files
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Edd Barrett <edd@theunixzoo.co.uk>, Laurence Tratt <laurie@tratt.net>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:23=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Some file systems like FUSE-based ones or overlayfs may record the backin=
g
> file in struct vm_area_struct vm_file, instead of the user file that the
> user mmapped.
>
> That causes perf to misreport the device major/minor numbers of the file
> system of the file, and the generation of the file, and potentially other
> inode details.  There is an existing helper file_user_inode() for that
> situation.
>
> Use file_user_inode() instead of file_inode() to get the inode for MMAP2
> events.
>
> Example:
>
>   Setup:
>
>     # cd /root
>     # mkdir test ; cd test ; mkdir lower upper work merged
>     # cp `which cat` lower
>     # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdi=
r=3Dwork merged
>     # perf record -e cycles:u -- /root/test/merged/cat /proc/self/maps
>     ...
>     55b2c91d0000-55b2c926b000 r-xp 00018000 00:1a 3419                   =
    /root/test/merged/cat
>     ...
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.004 MB perf.data (5 samples) ]
>     #
>     # stat /root/test/merged/cat
>       File: /root/test/merged/cat
>       Size: 1127792         Blocks: 2208       IO Block: 4096   regular f=
ile
>     Device: 0,26    Inode: 3419        Links: 1
>     Access: (0755/-rwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    ro=
ot)
>     Access: 2025-09-08 12:23:59.453309624 +0000
>     Modify: 2025-09-08 12:23:59.454309624 +0000
>     Change: 2025-09-08 12:23:59.454309624 +0000
>      Birth: 2025-09-08 12:23:59.453309624 +0000
>
>   Before:
>
>     Device reported 00:02 differs from stat output and /proc/self/maps
>
>     # perf script --show-mmap-events | grep /root/test/merged/cat
>              cat     377 [-01]   243.078558: PERF_RECORD_MMAP2 377/377: [=
0x55b2c91d0000(0x9b000) @ 0x18000 00:02 3419 2068525940]: r-xp /root/test/m=
erged/cat
>
>   After:
>
>     Device reported 00:1a is the same as stat output and /proc/self/maps
>
>     # perf script --show-mmap-events | grep /root/test/merged/cat
>              cat     362 [-01]   127.755167: PERF_RECORD_MMAP2 362/362: [=
0x55ba6e781000(0x9b000) @ 0x18000 00:1a 3419 0]: r-xp /root/test/merged/cat
>
> With respect to stable kernels, overlayfs mmap function ovl_mmap() was
> added in v4.19 but file_user_inode() was not added until v6.8 and never
> back-ported to stable kernels.  FMODE_BACKING that it depends on was adde=
d
> in v6.5.  This issue has gone largely unnoticed, so back-porting before
> v6.8 is probably not worth it, so put 6.8 as the stable kernel prerequisi=
te
> version, although in practice the next long term kernel is 6.12.
>
> Cc: stable@vger.kernel.org # 6.8
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7b5c2373a8d7..177e57c1a362 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9403,7 +9403,7 @@ static void perf_event_mmap_event(struct perf_mmap_=
event *mmap_event)
>                 flags |=3D MAP_HUGETLB;
>
>         if (file) {
> -               struct inode *inode;
> +               const struct inode *inode;
>                 dev_t dev;
>
>                 buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> @@ -9421,7 +9421,7 @@ static void perf_event_mmap_event(struct perf_mmap_=
event *mmap_event)
>                         name =3D "//toolong";
>                         goto cpy_name;
>                 }
> -               inode =3D file_inode(vma->vm_file);
> +               inode =3D file_user_inode(vma->vm_file);
>                 dev =3D inode->i_sb->s_dev;
>                 ino =3D inode->i_ino;
>                 gen =3D inode->i_generation;
> --
> 2.48.1
>

