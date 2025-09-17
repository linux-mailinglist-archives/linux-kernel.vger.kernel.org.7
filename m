Return-Path: <linux-kernel+bounces-819847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57FB7CA22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C3A2A3363
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700A21CC61;
	Wed, 17 Sep 2025 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPoOiqCj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFF1C07C3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072569; cv=none; b=mT8DAkH7mqhlOpDiLUUQ5B+JqDPsyznkhQAlpbfRRlwNBDlcrlxKjKL57nYpiOHqZiO/PftSfbAsOe3ew0bPiuLaD7yss0EWk89/a3Ch7uHWJ0XWQR43DCmoQFOhPxTXitK5g2BlHiOLrqfJY54i4X/uZjdsRVb82aP7LBi9CKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072569; c=relaxed/simple;
	bh=h3Z5XBCUX9Dv2HU1H9TfoRrMA8iokD6T9vv05gDJaVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+RDrMsNXazlQ6a0c3h9tJuqfZktgX/QXNI4qUV2tHGPbBJHkjVgVDksMHgoTSCqfQf9KnckJj/Hd6gA7wC9L3HGJDlDk7WodzoIOHnWEoxYBqy/PoCkI49ALOJb3cxgkZWaKnTnjykIm2c5Ko3TpIf8bx3cJ/bYx8Z/OHlEzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPoOiqCj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e7636aa65fso5594123f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758072566; x=1758677366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g02scMvbk75kZ0Cp+7G6/bKYH1FANYju2c3jRvcZJZU=;
        b=OPoOiqCjygeljr4KR8DiGtu8k7Psx8O8LvNGrRv0gt9YLa+IbWM3PCrENdfwxNhxYQ
         WRutVU660VunScw/vMt0Ni4hUZ3zwLfuvnKrkAbrtORuIZDt4mqY9VyC3NUkwOWA8t3m
         8oXgkIrlrhdilsLQrA5a6Qbn0mV+aeO2idtF88qHF33Q4ZMosWzjZ+krVr/2SVho1B0M
         MBvZm6dhhOy0MopEUbsRoI1Xcqx79BnwlY8AINt4oLXIX8SDoJX4NSkUVAVC0tkyFJIY
         eO9s8PmaXFg0Oa1EV7k6rghJgdiU/Cvl7/ZE6Rk6hmIena6CqkwK5Nv8kaoiU11d9dYD
         IR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072566; x=1758677366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g02scMvbk75kZ0Cp+7G6/bKYH1FANYju2c3jRvcZJZU=;
        b=JwDT+J1J3a5Eq/oa/8OsHDPHB+HHx7sM+lQdkWv1EdnFDvo7e1J7kp+KBtuwG/DtV7
         IzLfO6TKIc1LN3baOa+1UQjXepQ+tmLLgW2yfFhDLVmy0ThBYm1Oe2H6qHmReD+3QOTY
         /LgDOtjRUe9YPdnNswTNC0zVnmtWZR8+yooD9yo+wOhEkCBB5L1pz01qFTRzMge8qCL6
         szlbRJfPaJ6cLsNaTirUN+4WK0HwVxTEUMbc0rWhB3og12EwZVdoI6DKxbot+ztSzoGK
         EKlbYLH16CcWaBap548qAm+sWP4boTYdx6SwnBXd1PZMw2bkIgCEpdDHzfxxUmvZe8yg
         EBPg==
X-Forwarded-Encrypted: i=1; AJvYcCVekswFUJwhDjG8tyqMV8Ks4d+A3dUdjpQJPYn/KQjmM2fdRBnhg7S5+wv251cU8GwpfDIrpTt/EunPzTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdZE9E0QNTYTHNUrJgqg8g/zytsA+mzcYnWlR/u2hN+TMsyAg
	bmZafhn8hCLxMQ2SmZxSVCNQigp58aiFqqg200A+Jhz/J8+GT8nW3p6fapUzGFQXFEuOP3GjXwy
	269ZoKWjXI297XpmdORKmw1tz3y/Ig70=
X-Gm-Gg: ASbGncukVlnN9Xd2L3U4858fE+Vd/RlPMTMDXz4J6JwBjtSHJQZMlcVfz3Wago+mmRG
	mlv2S/IkRTaTczt+8Cec9R6UHXUILYORk9bTyDey2l57fsWL++/O/ezFIyLuj2xNawsFqBb8ROm
	qjea7UM9o+/1sDCTANec89qEemg5R9aH2cecplXo5QYdL5bEswaRZOTRoOc1jkbieMJIfB/eUV2
	QhwjqXGAe2lFb5lGtNvTbc7A+yz9NL3VGdWPLDspgWgBSM=
X-Google-Smtp-Source: AGHT+IEGu2CFDwBKeE+Za3mS59QmE9EyUvSMozSD5HGBC7qiRicgAaOBdHaPM1rrChotGV0D3S7jMHBFx3v53S+dHWI=
X-Received: by 2002:a5d:5f50:0:b0:3ec:a019:393a with SMTP id
 ffacd0b85a97d-3ecdf9c1ecfmr306816f8f.18.1758072566073; Tue, 16 Sep 2025
 18:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828060354.57846-1-menglong.dong@linux.dev>
 <20250828060354.57846-3-menglong.dong@linux.dev> <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
 <5041847.31r3eYUQgx@7940hx>
In-Reply-To: <5041847.31r3eYUQgx@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 18:29:14 -0700
X-Gm-Features: AS18NWCywD3v3_flXeHPv7j2zezoyngM7asF-x_7Gtru8Ru5a7BomoXllOy3-Rw
Message-ID: <CAADnVQ+KzOiDeq5WrM-08js7XEH_CU0D9cb+a5iV_JsMm+RyWA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sched: make migrate_enable/migrate_disable inline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:26=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2025/9/16 19:07 Peter Zijlstra <peterz@infradead.org> write:
> > On Thu, Aug 28, 2025 at 02:03:53PM +0800, Menglong Dong wrote:
> >
> > > +/* The "struct rq" is not available here, so we can't access the
> > > + * "runqueues" with this_cpu_ptr(), as the compilation will fail in
> > > + * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> > > + *   typeof((ptr) + 0)
> > > + *
> > > + * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
> > > + */
> >
> > Please fix broken comment style while you fix that compile error.
>
> It's a little embarrassing. The compile error is caused by the commit
> 1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree,
> which uses migrate_enable/migrate_disable in include/linux/rcupdate.h
> but include the <linux/preempt.h>.
>
> I can fix it by replace the linux/preempt.h with linux/sched.h, but shoul=
d
> I fix it in this series? I mean, the commit 1b93c03fb319 doesn't exist in
> the tip for now :/

If it's just a different include then go for it.
Make sure there are no nasty build issues during the merge window.

