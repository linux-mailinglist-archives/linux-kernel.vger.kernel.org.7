Return-Path: <linux-kernel+bounces-810455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084AEB51AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F2CB61A52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71A32A81F;
	Wed, 10 Sep 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8pDImrf"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5C23F294
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516184; cv=none; b=n/AcNaol4bz40A/yseSSqBQwz10YAOWWDi1i3n6XQrsUWZW7hGnkPfa2zeuXwDvV1LBe+UvUvFeL83oQk+VCr/uZZ2yI+JHzjKj4HzOSuOdQ7fgjRoDvS2TbGXhVWyZAXyJy62XhxO+NEKDl5h3vDIno8EM79GxfQbLuD2iHvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516184; c=relaxed/simple;
	bh=A16G7msev3POt8MhMV8+fmCV6RQoltrKiKjwD56M3og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfR/U6xf/ly+KLo3G8Mv0YJFUtzj9aYiyi3vhgG786pCR5A2uUw6AsfyIagU2ZJZdSshSkkgdbRcWK5U5CvKrPV07ai3RLMG+pEEUBk33JJJR9EpG6PDvC0mO7ccCQB8VfAYk/pFOkMm/6YaPOyyr+ppuTHUQivlMtgDLpWGEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8pDImrf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b4bcb9638aso593061cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757516181; x=1758120981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A16G7msev3POt8MhMV8+fmCV6RQoltrKiKjwD56M3og=;
        b=U8pDImrfbYT7lY1B1DsOe21oupWRZiRIIiqB+2W7jQEH/NZX1OcYujGQ+cPqdWjtLx
         AGggm5fSE5NcmC2gCMqXBCrjk7E75DJZoFwCyaBxfWmjTUp60/JHUVDeAkg7uMur3cxu
         TH9l+PMtQq0GkljtxhJINYSBHoP16ned3BI2Nwj0fmhBIGy5Ov/8RhlTS/pQ4QcfVfxL
         ZLz5zi0xzqKeRbjagDZO2X6q5Q9L2mQywIjHDUodLCObYFNKMkKz65PEJWa9afEZSG3e
         Z2uOJHK6EXVa7Cwb9+NLUJiqk5H++rfhrAio/5p8tizJMt9fddHl/41CAmOgZhiB265m
         lLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516181; x=1758120981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A16G7msev3POt8MhMV8+fmCV6RQoltrKiKjwD56M3og=;
        b=j1miiJub4YGPfU15+X6PnVI2grXDO18kL170LEPN7/5JanS3/g/OnS5ULNXvKYw+ns
         69gcfuE2k/ZpFCckpy/On06crZpIRRo7cVf057JoYnLSDEt6t7DxX2MRhOCjOGyTSpQh
         wxWewYpymc+GJiqPWzXs3Kc9jnkdXHBbrYuE7ZtGJezTH75uLhftoS69ddUrZV+MwZpv
         //Ey0PszJeMw81lY0n7CgYTB9Dkb/8HMzwhVnktyZoz6BmBOc/sUMeUK2ANrOa4sXWgs
         0DLWA7Im2Dl7O3doJowdhevuoU8L9X44R/FyQcpTvl6ZCoMFr5ac4l9hAFHRcsfZu9oj
         FKRw==
X-Forwarded-Encrypted: i=1; AJvYcCVBEoGbOqmzwZaQQat1PHc1TFmpiTapV1UEe/I3chxYSjtb+DS/B3FEOM4wxQLTegEvPISUUkfaBCIM0R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6FTjvpUxwL1Ks7BUH8MEGr5DRBFs1TkRK5lanz8B8+5kZXWY
	dmS9BPWWJnE6fExhAEbbgdaFaa/QIXZ1VF26dHWhCbs8nl0lWG/Mim8jmKDvRAuWP0HG2Yy9RpD
	1acl6eOJSyJTXjDJGmMh/vwXqrjCZR9Mmee5jhD59
X-Gm-Gg: ASbGnctppBfMS1fGFWHTtgv8+NbJJ40MY39VPBYrUr02A49pN2ULp7/QuaoenmaJpLk
	Bb47TK5s+ukc/J8ea2dp2ojJP/2hBUJhbk/4NN1wtOi+2uUvq/odaY1dYllo7816SJpmoOw35SR
	Su5Hi2dBqAvHsNqM1VVPzKhf/OsU75cenEWW8D3H+BFObn33IjO1W/Pd1Gxa0vaohYhdHlex9HB
	OgRIl1VVmfkLVhJKW0rP6VB0ezYtslxs/IPecWM/9vEy+m9CBQukA==
X-Google-Smtp-Source: AGHT+IGaaCo3evsn7RGNzMZzR6JhniZdVW9a85shLUbENP9DBHr6Mi63wI05PWTCudwIISeltuesuE5/JBo1OoWg68g=
X-Received: by 2002:a05:622a:199d:b0:4b3:4947:242a with SMTP id
 d75a77b69052e-4b625236043mr5421861cf.12.1757516180932; Wed, 10 Sep 2025
 07:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com> <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
In-Reply-To: <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Sep 2025 07:56:09 -0700
X-Gm-Features: AS18NWDh7ZJPWGaScD2chXrEfeSkcnJTIGCOkVmB8eEUGK_Q5MBQiEFvWnW-pIg
Message-ID: <CAJuCfpFVUOLtmJyo_B+Z6HAaDOfuZhYZX71EpQW3+dpQhm3EQw@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:14=E2=80=AFAM Lei Liu <liulei.rjpt@vivo.com> wrot=
e:
>
>
> On 2025/9/10 3:48, Suren Baghdasaryan wrote:
> > On Tue, Sep 9, 2025 at 12:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> >> On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
> >>> 1. Problem Scenario
> >>> On systems with ZRAM and swap enabled, simultaneous process exits cre=
ate
> >>> contention. The primary bottleneck occurs during swap entry release
> >>> operations, causing exiting processes to monopolize CPU resources. Th=
is
> >>> leads to scheduling delays for high-priority processes.
> >>>
> >>> 2. Android Use Case
> >>> During camera launch, LMKD terminates background processes to free me=
mory.
> >> How does LMKD trigger the kills? SIGKILL or cgroup.kill?
> > SIGKILL
> >
> >>> Exiting processes compete for CPU cycles, delaying the camera preview
> >>> thread and causing visible stuttering - directly impacting user
> >>> experience.
> >> Since the exit/kill is due to low memory situation, punting the memory
> >> freeing to a low priority async mechanism will help in improving user
> >> experience. Most probably the application (camera preview here) will g=
et
> >> into global reclaim and will compete for CPU with the async memory
> >> freeing.
> >>
> >> What we really need is faster memory freeing and we should explore all
> >> possible ways. As others suggested fix/improve the bottleneck in the
> >> memory freeing path. In addition I think we should explore parallelizi=
ng
> >> this as well.
> >>
> >> On Android, I suppose most of the memory is associated with single or
> >> small set of processes and parallelizing memory freeing would be
> >> challenging. BTW is LMKD using process_mrelease() to release the kille=
d
> >> process memory?
> > Yes, LMKD has a reaper thread which wakes up and calls
> > process_mrelease() after the main LMKD thread issued SIGKILL.
>
> Hi Suren
>
> our current issue is that after lmkd kills a process,|exit_mm|takes
> considerable time. The interface you provided might help quickly free
> memory, potentially allowing us to release some memory from processes
> before lmkd kills them. This could be a good idea.
>
> We will take your suggestion into consideration.

I wasn't really suggesting anything, just explaining how LMKD works today.

>
>
> Thank you
>
>
>
>
> >

