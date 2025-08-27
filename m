Return-Path: <linux-kernel+bounces-787558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E33B377C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2017629A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD627381F;
	Wed, 27 Aug 2025 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlRPu2rv"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CDFC1D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261951; cv=none; b=HTlYCtqwtXAu06HUVio2HMzl5VPqCl/FFkV3C/LfiZDf0aTZmZ5L3WFSDZuQCYeLv1ndegsK4kFkhTzmQ1k1i7hcVEjDPWrlNEudeppgib7zCEnvl/SKzHgWhlJ+tJmcqlBklvxBLmgBi5RKEGdF93otDc4iyLeBr0EY7LKzGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261951; c=relaxed/simple;
	bh=phLICMoxD4JP6sKT1DeC5mUYYErOOuHJsUqnVc0nu0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTeIA4UD8+kYkCegto/zMKviZAw+Vn5EZ6yI+hj18sVRtGnKtuTDnboSIglKX5nhV1hdHW5PLGxdM4WFCiR/vhVcyw1hnutQn7TUxSNOn2BkG5X7HOFaac0smAM7eoyseLuvMiA9YBUBT1hdRzB8lC3w1eXnL2SZZcH2RP5r3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlRPu2rv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b29b714f8cso135831cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756261949; x=1756866749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phLICMoxD4JP6sKT1DeC5mUYYErOOuHJsUqnVc0nu0Y=;
        b=OlRPu2rvec8Qzn1mqyCPLHPWANvGTHVwbDsAFSWtgYaADHlT+js4RUVs10IQTYZfn1
         7w3zg8aadiApb/FVHm9g2dQMoYzmcUVdPa+6CTQ84uk/uxvgwQ2m9g0xYKdWhlRQUHQd
         zmxp/EH2Njd46298gqXe7nFKzp65vMaXW9KsjGk/otT/UnTjEaG4Y2lti4Ov/NysHOv5
         0HxfB+U5vyyN5++a3K3I/QlRDHB4e/swIaDXxhG8WW6d54Rc9DZA0wN4cG8pGFkzgzlG
         FUUWhtiuQkoohhs6L3Un4gDpApXMiXqiZm/m11FpV6+VywniqCVUFFVub8nML3vxrBcD
         MAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261949; x=1756866749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phLICMoxD4JP6sKT1DeC5mUYYErOOuHJsUqnVc0nu0Y=;
        b=LRmkgKVQV+DW4kv/2hYKYZy/jG6QQY14tsYiHgBfwRHV/ABQh/2u+EmfHDmea9TbnX
         Bi12NNCHi1LXEBvSgZ4o7t/bDms6Y2I3z4M7ysokczGWuX/a4ZGDo1qqUQSJ3w9oNFqs
         5NMBC/aR6dOZ+yzY3Mx+Z3qEoUoLCJzIubr3ZryXdgZpbW/tSSAtD01SHUNrCCv2YLcI
         wXdHbKB1SRjhLp5+Pqqtq1TvNlzePg0ajmhVI9e2gS4ES0PdB3DJCeZeNB/7KkDyB+2f
         2dEsilYG1vpQ6lD6+M8FJa85rc1BUdjnZAB9Jk0RaLTgoLY85JsryNbNRkGKDEzVQsEY
         qKxA==
X-Forwarded-Encrypted: i=1; AJvYcCUqadVz/RMrRteQVIzfJLwfmjsqlbB+l3VZwA30ylKsfYdEsfhcVsC0DxEheDPRhLVDDBIQ9zDFYoN9moc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBQ8RddiZnX8htG20fQgATSZRLIEaIXD9g4x+6wIkVAqOm0w+
	+EeTYprdHAwVnvC0QLLoHRcuzMO7e6v6gVoSSii6ljzRcgfX12dD9Kt/13vSA88GR6dmuqqwkx+
	Kia4rrbXs+cnH60AzpViYBHYGC7OfMpeqow3ru5Wl
X-Gm-Gg: ASbGncsYuyKci2qoPFu9T7z4Uv2nCgH6mm5X8XgSUk0b9Rt+qFuFFqryd2fA7fiqqZt
	kYkk1IkIyTYdiOcsMTTSe5gVWMXhq67EtS/CInaalA4t31E4f+kefVC12jRzn2yvQDEjlVMjY1r
	PvmYJke/aVGxKrZTzWPgeKUkrDyhRMRrUALmOnFeQ437wniQYCn7KIbg8W3JFJYTS2da3Bfwa+F
	2AvE8x5pGQC
X-Google-Smtp-Source: AGHT+IGEkFxoIeaU31PPrER+XD5lzwwgqgu6SIDi6/2BzLmU7aGrEqvMu3SzdfymXhnaZAVtazALtqj98L/HKOhu2Pg=
X-Received: by 2002:ac8:5a49:0:b0:4ae:d2cc:ad51 with SMTP id
 d75a77b69052e-4b2e2b6d63dmr9758151cf.1.1756261948495; Tue, 26 Aug 2025
 19:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755190013.git.pyyjason@gmail.com> <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com> <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
In-Reply-To: <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Aug 2025 19:32:17 -0700
X-Gm-Features: Ac12FXx-amMNGfYthUlKXoV2KJV8Ivl2glrfWFB94kYjwtAlLlUunZcwpQnXXCU
Message-ID: <CAJuCfpHyXWwrKkFmmbHTGtG9L-JK2eCt03ku9364i4v6SJKFbA@mail.gmail.com>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yueyang Pan <pyyjason@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:53=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > Right now in the oom_kill_process if the oom is because of the cgro=
up
> > > > limit, we won't get memory allocation infomation. In some cases, we
> > > > can have a large cgroup workload running which dominates the machin=
e.
> > > > The reason using cgroup is to leave some resource for system. When =
this
> > > > cgroup is killed, we would also like to have some memory allocation
> > > > information for the whole server as well. This is reason behind thi=
s
> > > > mini change. Is it an acceptable thing to do? Will it be too much
> > > > information for people? I am happy with any suggestions!
> > >
> > > For a single patch, it is better to have all the context in the patch
> > > and there is no need for cover letter.
> >
> > Thanks for your suggestion Shakeel! I will change this in the next vers=
ion.
> >
> > >
> > > What exact information you want on the memcg oom that will be helpful
> > > for the users in general? You mentioned memory allocation information=
,
> > > can you please elaborate a bit more.
> > >
> >
> > As in my reply to Suren, I was thinking the system-wide memory usage in=
fo
> > provided by show_free_pages and memory allocation profiling info can he=
lp
> > us debug cgoom by comparing them with historical data. What is your tak=
e on
> > this?
> >
>
> I am not really sure about show_free_areas(). More specifically how the
> historical data diff will be useful for a memcg oom. If you have a
> concrete example, please give one. For memory allocation profiling, is
> it possible to filter for the given memcg? Do we save memcg information
> in the memory allocation profiling?

Actually I was thinking about making memory profiling memcg-aware but
it would be quite costly both from memory and performance points of
view. Currently we have a per-cpu counter for each allocation in the
kernel codebase. To make it work for each memcg we would have to add
memcg dimension to the counters, so each counter becomes per-cpu plus
per-memcg. I'll be thinking about possible optimizations since many of
these counters will stay at 0 but any such optimization would come at
a performance cost, which we tried to keep at the absolute minimum.

I'm CC'ing Sourav and Pasha since they were also interested in making
memory allocation profiling memcg-aware. Would Meta folks (Usama,
Shakeel, Johannes) be interested in such enhancement as well? Would it
be preferable to have such accounting for a specific memcg which we
pre-select (less memory and performance overhead) or we need that for
all memcgs as a generic feature? We have some options here but I want
to understand what would be sufficient and add as little overhead as
possible.
Thanks,
Suren.

