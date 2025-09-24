Return-Path: <linux-kernel+bounces-830905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78AB9ADCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93274A6B54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36F31327A;
	Wed, 24 Sep 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lDGu75/C"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814A31353C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730888; cv=none; b=a7SKheSd/x5scCLiiMyN9HAEl9tJF11EtMy5ERPpoUOTGEN+EBteQhtNZOejlYijiXvZf73Qdl7PhyFs4GlTZAsD++BDXGj2mVt99++cJ6nQ0a6GAKVNiCmiUgQshjvF6/Gw+DzygouTkYyaLEcqVd3m7ttqrVtHV79Vf/zjHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730888; c=relaxed/simple;
	bh=ZcA2jKJiXKnbRwI+0MpjeeiPsAiOH2A641I3YnoiC58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkcOMS3PA7DdZr1Zisrp2yec8RTtzMvDattNZhNP71adHBW71M5th5y92j1Sb44g9rIhfik9EF7Lg/7y7AWT7uwuW0W82Cq7GKW3Y1rH4bCr1j87WiZruLBJc3zPF3oYyiZO24b+0dcog7dVd584IkodtVUOTo+cvW/iy7jUpSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lDGu75/C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso2574683a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758730885; x=1759335685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcA2jKJiXKnbRwI+0MpjeeiPsAiOH2A641I3YnoiC58=;
        b=lDGu75/CmUU+chrQl3SRXh04l8tU1MPx3VDaJjKh4FMAxZdaWUQiM6JOTs1wB5UFoB
         qTzqGmc/oU9KcFcfb6NmV72oofiD5kokl1cG5U9izgTL2aWBtO8K/S+B9csLMN90Fs9U
         tDxtsaqrsgr+gRYzxucJtFeY+4/9wxTB17tRoNCwcfeJd/80g7eS/ee6cY2DRvjs2FTr
         gGSQjMcfvNrdt6wKkebwyJIWSGh4cgcEvFmyosjCk2/wyXOna6bTzTAf4in+rWHOP77z
         WE7zjPM2JZ3nkVRH0kif80XGdqmBnLM0khtwbIZdTWhpXR6BoDe7qz/rl/iuxUcrz9PY
         JSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730885; x=1759335685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcA2jKJiXKnbRwI+0MpjeeiPsAiOH2A641I3YnoiC58=;
        b=DEddPgtt2WrAB7GiGvF9AfZwLUgMYZllemfRhBbdVcux5rWz5QT4e+/iRGqMAOhaGx
         X5N0wOT47XmOmmf07wDcDCdxENbS5lcBZ4OeCjR+j9d7nJyfzXh9hH6kelS9RoKwc76j
         drDwM/8kLPbhM/wlr3SYlaa/pbmceT8hjI1ObInfm9/s2zwUrNfQM2bfhaKLdH1MW4oh
         ZsQ/psHAHw3zQdrxFfOaThm11OH7MWpGAmSPeZx3jrRA7Ui+Ykvjl7LufK3/nq52pFOj
         tIQwyhVxCOTq3W6QGJGOqLB7AtDVwiTzlu8MRciN2ASEWwwAkv4OXKyhm91OdMjMvJA/
         s5XA==
X-Gm-Message-State: AOJu0YydimkqEfwjoOpuABzNVsmhq9kVHTZ39tMm8CjEqcFoP6sYxKkB
	8dNCpPclgiUqoM3hM26Pmtrytw8GxcU6+4ys7/VqTTeh1C+iumrYfmAWOSRkZiSsPLa1f+1dLAH
	K215B8oK53huzdwdQauvJ9Uthb12SRQLFW/0VI+BHqA==
X-Gm-Gg: ASbGncv5MiqH/E3Y1PlK7GkEsfwQKacn6oqQ7v9oGaKl/p1+LIHUI2uG+ux2qIa5+x4
	q2pwz0XcsRBkoVxrSrS5ikCsA24Z8hH+NkwWaz7MCn7ScxH4MCpDuPEo59QzC9keptxuMDCraPZ
	JGT2/i0lmZDh7GbM+D5sjFGOSzo5/C+WWQ1zBG8Pvnc/yhBpRPsbZD17NRSTYtuZGTlLydv5WBa
	M+Wy6jBPveH2cvSaIUq+4dT+w==
X-Google-Smtp-Source: AGHT+IGRWpoRX5kieAx8ODfA2c3P5709GPwYpJaUY9gD32LbMuLf1qLMI747P1qalIOpXzd9sueLH/Q8vbfBhoPeM3k=
X-Received: by 2002:a05:6402:90c:b0:62f:4bf5:2b1 with SMTP id
 4fb4d7f45d1cf-6349f604f2fmr146057a12.14.1758730884308; Wed, 24 Sep 2025
 09:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923153146.365015-1-fam.zheng@bytedance.com> <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
In-Reply-To: <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
From: Fam Zheng <fam.zheng@bytedance.com>
Date: Wed, 24 Sep 2025 17:21:13 +0100
X-Gm-Features: AS18NWBFLLBlUj7TG1Zl8-MnAWo-Z0AA8d0KVmB7UquRCmlLYJ7gqHCqbgn4mu8
Message-ID: <CAG+v+KZ4bRgVNiMDhNTeiOqqbEXCBD72K5SQZCo=m0xaQ2vauQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/5] parker: PARtitioned KERnel
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	linyongting@bytedance.com, songmuchun@bytedance.com, 
	satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, fam@euphon.net, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, liangma@bytedance.com, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	guojinhui.liam@bytedance.com, linux-pm@vger.kernel.org, 
	Thom Hughes <thom.hughes@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:23=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 9/23/25 08:31, Fam Zheng wrote:
> > In terms of fault isolation or security, all kernel instances share
> > the same domain, as there is no supervising mechanism. A kernel bug
> > in any partition can cause problems for the whole physical machine.
> > This is a tradeoff for low-overhead / low-complexity, but hope in
> > the future we can take advantage of some hardware mechanism to
> > introduce some isolation.
> I just don't think this is approach is viable. The buck needs to stop
> _somewhere_. You can't just have a bunch of different kernels, with
> nothing in charge of the system as a whole.
>
> Just think of bus locks. They affect the whole system. What if one
> kernel turns off split lock detection? Or has a different rate limit
> than the others? What if one kernel is a big fan of WBINVD? How about
> when they use resctrl to partition an L3 cache? How about microcode updat=
es?

The model and motivation here is not to split the domain and give
different shares to different sysadmins, it's intended for one kernel
to partition itself. I agree we shouldn't have different kernels here:
one old, one new, one Linux, one Windows... All partitions should run
a verified parker-aware kernel. Actually, it may be a good idea to
force the same buildid in kexec between the boot kernel and secondary
ones.

Fam

