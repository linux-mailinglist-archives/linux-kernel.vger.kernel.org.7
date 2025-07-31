Return-Path: <linux-kernel+bounces-751535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98CBB16AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCE1567891
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DBF1F4262;
	Thu, 31 Jul 2025 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IKvxnFy7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C9219ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931140; cv=none; b=ZFKjpXwCMe0RvwW12uJjs2bg51wB4kzHb0DQGBgD7gaynG0FNefI3xcjHgsddffRlPEiWcd1fKND83zc92KsjU1xudaP2/btW7BIa4AmNle2niJYnTeTAtKeop2HdidmMkzh3GE1t8MF4p+2d/3tqNLG/Z1d7nnUC7p+FbUcuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931140; c=relaxed/simple;
	bh=8wRvJxKbyOTOj80ZwVzdl39ChzxT4SlYxsyHrRPLzk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFYgqxHbzM6WrouQ6mWjewMLPK3BimgQGgcxEB0nojEoVKVE2OUNbPfy4jDRZrt4VUJZWRDGn9RA8zeaKDAFhX0LkSoYAPQJ8GTg91qBWKIo+f/s2NXcX4MQAU3Hg64NbiaCzgsymA9f4IGpiwwtGZEUMQdNeN3eKOOcreBNlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IKvxnFy7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so416562a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753931135; x=1754535935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HAYf5bawKOAi9UbMFDlw0TMRVyadJUpjLn1RTvakHDI=;
        b=IKvxnFy7+cTMmzrSW68rpH3nsruIuN3nLILZDt4ADbxJGwZly+YeLToEGtJQbDDUvT
         Tv9MAqyREYmtyMFxZqdlBftpBd4/TXDnijlHj4N/55mx4ji/wlhPcReDJKQcF4RPL3ch
         yfE/bsaEg7JLZRO/lYMiK6b3DabSawvEUo68Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753931135; x=1754535935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAYf5bawKOAi9UbMFDlw0TMRVyadJUpjLn1RTvakHDI=;
        b=wKM7NaT2SM5sMt8ztjVB7ZojJ5DQN3rbGmHrwMqoo/R5YWVNbTfSQd0vOebaYpHdPw
         EmwsVTq6dasoOHZD27eF8uGozGaQHzrdh/bvItmLZahoeme0Z3FLjuElu2BbWmDuVYJF
         5EyQZzetkzTwF4USv4C7WJE5G158gX+J6s6a98n0nYF05SXHRjKoj/vYkyJlXAXPHwOa
         wU479XFXvY2ocgc9IrvMikgTnimwGWh6bFgriykwx+59IyT+Ldlz4LnIGg9yBNEb3SNL
         dqm1gMH7E9jdduCPmq99gkDly5qMFxKIYrMYAtFkgGX0qdBxRy+jwhq3TTz9J83Wz3Kr
         OUIA==
X-Forwarded-Encrypted: i=1; AJvYcCUCzSOvuFgRjyc5kry3Hpoa0Y7rF2K9kzILR2tIQ5PJEbuZP+n+1NHBdQ/muJyyeDFMBt0lOWsiN9Du5nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhlZfU0vrkHRKNPIK+DcaokpRf4hC7aDkaxRbb2/NlvU70sHh
	RdPOqGsSK7pf6NwNOX31hsbaYuWh7sZj+me9Eu3ZbdTSEQYY2IbMUZGC4OEwWufPrFchAXqkhkJ
	LfFM3zSg=
X-Gm-Gg: ASbGncvFcBeJynxcxRncTrqd+N8BhWq3A3QXqM5TVC71EIAXREsOKa2hxSy9KaSw/7d
	/BlQkHYct3soqfuFMi/QefL8B4e6cJ1nWo+6sjv+RxJ+L/g1p065BXgZlkLWNfq05p3uCH4yJJ3
	1Wb+BXEHlHCTkN9G70U945DKQQwv35xuTGtlyBbApVx7TAkHEaae0PyYbXSMSc0J+GBMuZwPhP1
	OFIbCuB5WWanPUbTV5Pp4hINKTRg2AOCKRH1TYrqt1HBk+CoKieBgDc6bGMuVwM0u0BBrW8njYN
	xV5XfSyr9IfTR0Pds9Hh+YVbxivUSbL+7n7ijmNmjcqwRE0BDQrGI88X1lpQWCUFto/Wxsfx1tJ
	xXyV+RALv6b4VXyllveRyWzYPqhjLgBPsF+ZUG/5CCIXe4JUmD2P5o4qBeTH5xYF2deJbN6Lj
X-Google-Smtp-Source: AGHT+IGRR+pr0nZLmCdhjMbDWgtxwLfaeMoV/hzSjT08q96OHceCZOA4dGATJHzfinnklYr1KCmdvA==
X-Received: by 2002:a05:6402:430f:b0:615:a60a:38a7 with SMTP id 4fb4d7f45d1cf-615a60a3bd8mr1425084a12.7.1753931134633;
        Wed, 30 Jul 2025 20:05:34 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe77cfsm432011a12.42.2025.07.30.20.05.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:05:33 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so416544a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:05:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJsI6+UCBHpVn2O30rLmywsZaSu8m3KZMTr6R2pTfbWpH6muujQLMXxP31UWMMvXw6VBwhN/yJV3sp6zE=@vger.kernel.org
X-Received: by 2002:a05:6402:358c:b0:615:adc4:1e66 with SMTP id
 4fb4d7f45d1cf-615adc425aamr633902a12.25.1753931132919; Wed, 30 Jul 2025
 20:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
In-Reply-To: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 20:05:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
X-Gm-Features: Ac12FXyGI4908rAYUaEIQ05Ez7SZKZXC1fcfCug1m7LIGtr9OB56lWZC4UF5C8Q
Message-ID: <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

,

On Tue, 29 Jul 2025 at 14:06, Dave Airlie <airlied@gmail.com> wrote:
>
> I've done a pass at merging mostly taking from drm-tip:
> https://github.com/airlied/linux/tree/drm-next-6.17-rc1-merged

Hmm. My resolution is pretty different, but part of it is that your
test-merge has a different top-of-tree than the tree you actually sent
me. I think you added commits

  b213eb34f857 ("drm/tidss: oldi: convert to devm_drm_bridge_alloc() API")
  66cdf05f8548 ("drm/tidss: encoder: convert to devm_drm_bridge_alloc()")

to the drm tree after you did your test merge.

That said, ignoring those differences, the other ones I'm pretty sure
your merge is wrong. For example, you left a duplicate

        err = xe_gt_pagefault_init(gt);
        if (err)
                return err;

in xe_gt_init().

Also, you didn't undo the dma_buf addition to 'struct
virtio_gpu_object', that was added by commit 44b6535d8ace
("drm/virtio: Fix NULL pointer deref in virtgpu_dma_buf_free_obj()"),
but that commit was a fix for the problems that were reverted by
0ecfb8ddb953 ("Revert "drm/virtio: Use dma_buf from GEM object
instance"").

In etnaviv_sched.c, you seem to have missed the "Rename
DRM_GPU_SCHED_STAT_NOMINAL to DRM_GPU_SCHED_STAT_RESET" in commit
0a5dc1b67ef5.

And you have missing MEDIA_VERSION / GRAPHICS_VERSION entries in
xe_wa_oob.rules from commits c96e0df4e9f5f and b1c37a0030b27.

ANYWAY.

My point isn't so much that I think your merge is wrong - it's very
possible that I have made other mistakes to make up for yours. But my
point really is that these drm merges are rather messy and
error-prone.

And yes, I'm pretty good at sorting merges out, and this was by no
means the messiest merge I've ever seen.

But I do think that the drm people are doing actively wrong things
with the random cherry-picks back and forth: they cause these
conflicts, and I *really* think you should look at maybe using stable
fixes branches instead.

Would that require more care and cleaner trees? Yes. And that's kind
of the point. You are being messy, and it's affecting the quality of
the end result.

And maybe I did get the merge perfectly right. And maybe I didn't.

But the fact that you have *so* many conflicts, and that I'm pretty
damn sure that your example merge was not correct, makes me really go
"your development model is messy and leads to problems".

Again: I'm not going to guarantee that I got it right. I *think* I did
- I'm not feeling particularly unhappy with my merge end result. The
merge was annoying but largely straightforward. And it builds ok for
me ("ship it, it's perfect!"), although I do see an objtool warning:

    drivers/gpu/drm/msm/msm.o: warning: objtool:
submit_lock_objects+0x44d: sibling call from callable instruction with
modified stack frame

that makes me go "Hmm".

But that one looks like gcc doing some very strange things with
coverage tracing, so I am currently inclined to blame it on odd
compiler output and objtool rather than the drm tree itself.

But I really wish you had a better model for "backport fixes" than the
mess you have now.

Because it clearly is causing potential problem spots.

            Linus

