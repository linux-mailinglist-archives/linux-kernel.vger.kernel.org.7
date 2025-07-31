Return-Path: <linux-kernel+bounces-751564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0BB16AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878DC7A352D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4D1238C21;
	Thu, 31 Jul 2025 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCCVNlvl"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB02F41
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933187; cv=none; b=FYaMss2D7jf04X/3smp+67zrnhCxr5lVGslYyOUeE77/RZFL4+/R+jQvl0jodhVWqxHfkYCUxPPTVfc3QKxXCdqMv8gk1z6pD6qkyikELF7quOgieFhqhmroAbbiAs7rQ5F8My8v79wzwuyOph95mN0M+BAmkQBAAk7JkI9uD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933187; c=relaxed/simple;
	bh=nkZljtoJ9was8v5tWhwOQd6K5YjP0ydyRsl31njCgt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1VJUEQsxUSj7qKDIEX8ZfhlOJKp7MBIIXegD1uvegt4giG4ImZHeKdHO2D5mAomWl3VjPFgKTg7qiaXGoIwhibTIKyBdhpeOApFgOew1EnNknbQShAu4riePjufi4aOrH6rt/kl74DQW1YxVFdenk1VQ7MStvNEFIBwAgms/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCCVNlvl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dad3a179so67663766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753933184; x=1754537984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3DOMuVqCG6ucS2KyeUvGWMWEYcfdslld5Co+amobArU=;
        b=KCCVNlvlr61u/ZD9H/RD1mu905qfZdp7f2QQKgJ6fCfPHVYa/pe/yWwqB/OSLO0NFM
         JSmWQeH9f8FXkCnf45JI2fmypc9mrGx2o6DmQFG9rugsED4ZRGbOMfzptxQC4D3VexEW
         yeQr+M2R2ffZX1QmrjOO1PnTS1/0Z6GNo8ZkWWyjE+niVet07+0ZWR5xm57HzbD8CFQV
         ZG1k02kmCe3WZFdpuICtb6Jy3wekh4dVqhTcmgmY57JIZ3DrPjnbO4IctjsZ1KulyIy6
         VcVdswi9R0S3I0hg9r33pRxI03Y3qQOp9PoQzvOnTSaRETcBCmVSgPXBfNRVPsrZuFTV
         FV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933184; x=1754537984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DOMuVqCG6ucS2KyeUvGWMWEYcfdslld5Co+amobArU=;
        b=J6r/vHC4aZz8wZ2ituRjhIDSPtCqpG1BZ2Iw0nJGT3haC7Uobp1He/U3Bz2nq+TVGA
         7A0tmA6EZ6ysZVUCEh/1XrnXBSD6NYz6aZyxav1fqjMXNlU1MEw7l1YkJB1JFSo4L28H
         vrN1aD/ToWx2gS8Sbg3k5qBydiTcLi2zyxhQvUefzcYi9u0IkNf+TrvwwC5O9uPiidUB
         md01cfaFLG93aF4HiTI91zKWC2fOOv6xznY03mRyMpsk7sy0ae2SSsdnarX0xzL/5C2N
         S160x5Lyf6zrxAAkPs1POeU+gKabDn/KyTvXWiHYijSanZoIgHg+hiVrbO/i3sgS1jtO
         TqMA==
X-Forwarded-Encrypted: i=1; AJvYcCWr7xJ5z12wagdTmfsSTjV1OTF4+0MquVeyjGD9FZKMFj8hZPc4TR7PXxyOjrveTEf8KNF3IH6VgrrBGDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzbT8edwfOgSSpNxXqJllIJVm1x0ACb2Ve9KDx1uvl2TExdCe4
	n2IiQEstoPxu/iaXEgUOF2VACMFs44l0poTReuvbwKkq/Fjmgd3IhuTNbAn94BJ/EUayvkVnRRo
	fhL3wAddU9/hKNA6hp2EU3V6GYOQg81qz8g==
X-Gm-Gg: ASbGncusxSQkBXGEcUOylCaJ2MqPd4SzE+C74BeZSq6VTYKDhDP/5ZVXbHPoiL2eR+2
	Ibk+S+DGMbQ0w0qdNcVU0DUldgBSfAdWmgySfAPeFW++azzgwR0TurJmnqFib13XMy4gxkPS3xS
	v+8+l6C3fful/IC0vnESNa7ZzCR7TLOcR6PkxQwUit5Y0j5+VbntYAjUv3h1ORtHG7t/9iRFqZ3
	/O15g==
X-Google-Smtp-Source: AGHT+IE1FJta3Kf+qHXYmgbBxStOpuBJWiwQe8W/T0eWdzr/4FgGfyRAGqUML7nI01THeh00KeaK1tpiRV/GV09Dvr4=
X-Received: by 2002:a17:907:3f0c:b0:ad5:7bc4:84b5 with SMTP id
 a640c23a62f3a-af8fda8bebfmr736738666b.57.1753933183917; Wed, 30 Jul 2025
 20:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
In-Reply-To: <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 31 Jul 2025 13:39:32 +1000
X-Gm-Features: Ac12FXyFcrYEVB54oZoJqoDectz4Jjvkrj1zJCKaLa3O4xleVd9ylaAKXtYeJpU
Message-ID: <CAPM=9twG7By95nYrkoyLtAT5YPV9WdMUgVPwjuZ9kiZFuse+Fg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 13:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ,
>
> On Tue, 29 Jul 2025 at 14:06, Dave Airlie <airlied@gmail.com> wrote:
> >
> > I've done a pass at merging mostly taking from drm-tip:
> > https://github.com/airlied/linux/tree/drm-next-6.17-rc1-merged
>
> Hmm. My resolution is pretty different, but part of it is that your
> test-merge has a different top-of-tree than the tree you actually sent
> me. I think you added commits
>
>   b213eb34f857 ("drm/tidss: oldi: convert to devm_drm_bridge_alloc() API")
>   66cdf05f8548 ("drm/tidss: encoder: convert to devm_drm_bridge_alloc()")
>
> to the drm tree after you did your test merge.
>
> That said, ignoring those differences, the other ones I'm pretty sure
> your merge is wrong. For example, you left a duplicate
>
>         err = xe_gt_pagefault_init(gt);
>         if (err)
>                 return err;
>
> in xe_gt_init().
>
> Also, you didn't undo the dma_buf addition to 'struct
> virtio_gpu_object', that was added by commit 44b6535d8ace
> ("drm/virtio: Fix NULL pointer deref in virtgpu_dma_buf_free_obj()"),
> but that commit was a fix for the problems that were reverted by
> 0ecfb8ddb953 ("Revert "drm/virtio: Use dma_buf from GEM object
> instance"").
>
> In etnaviv_sched.c, you seem to have missed the "Rename
> DRM_GPU_SCHED_STAT_NOMINAL to DRM_GPU_SCHED_STAT_RESET" in commit
> 0a5dc1b67ef5.
>
> And you have missing MEDIA_VERSION / GRAPHICS_VERSION entries in
> xe_wa_oob.rules from commits c96e0df4e9f5f and b1c37a0030b27.
>
> ANYWAY.

I also need to check if the Intel folks who did drm-tip merges dropped
some things wrong, since I mostly copy from those. The etnaviv one I'd
screwed up definitely, I didn't do an arm build on the merged tree,
and I probably should ensure I do that in the future.

>
> My point isn't so much that I think your merge is wrong - it's very
> possible that I have made other mistakes to make up for yours. But my
> point really is that these drm merges are rather messy and
> error-prone.

Agreed, the error-proneness of them is my main worry, in our internal
tip dev we try and get the knowledgeable people to do the merges, so
my trial merges are definitely not something I practice often, so I'm
happier that you are better at them than me.

>
> But I do think that the drm people are doing actively wrong things
> with the random cherry-picks back and forth: they cause these
> conflicts, and I *really* think you should look at maybe using stable
> fixes branches instead.
>
> Would that require more care and cleaner trees? Yes. And that's kind
> of the point. You are being messy, and it's affecting the quality of
> the end result.

I'm not sure how to parse, stable fixes branch, do you mean stable as
in a special branch for stable tree? or a fixes tree we don't rebase
every rc?

Currently all the base (drm, intel, xe, amdgpu) fixes branches are
stable, we backmerge into them after rc1, and very occasionally
afterwards if a backmerge from rc5/6 is needed.
I pull those stable branches into your latest rc each week and send it to you.

We should only cherry-pick one direction, things that go into -next
and are recognised as fixes are cherry-picked into -fixes. The people
doing the cherry-picking are not always the original developers, and
the patches for fixes are often part of larger refactors.
Because of that, things that end up in -fixes are often refactors and
not clean cherry-picks. Then we get the fun of having a revert in
fixes, and a fix in next and shit starts to get messy, (though in this
case only one or two of the conflicts are revert related problems).

I'm happy with mostly correct, since the downstream devs will
eventually pull this into CI and fix it up anyways, but this time it
was very ugly, and I'll make sure everyone tries to review the merge.

> But that one looks like gcc doing some very strange things with
> coverage tracing, so I am currently inclined to blame it on odd
> compiler output and objtool rather than the drm tree itself.
>
> But I really wish you had a better model for "backport fixes" than the
> mess you have now.
>
> Because it clearly is causing potential problem spots.

It is, I just can't figure out a better plan, myself and Simona have
gone over this multiple times, and the answers we get from others is
just have your developers know in advance that the thing they are
fixing in next should go into fixes first, but then we have to forward
merge fixes into next more often, and large teams of developers have
to be aware of the rc cycle and rules around what is acceptable when.
Scaling sucks here and these are large teams, who are often working
far ahead of the rc cycle.

Dave.

