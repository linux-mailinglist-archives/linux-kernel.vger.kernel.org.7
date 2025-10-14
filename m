Return-Path: <linux-kernel+bounces-852904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E202BDA32A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548A2501B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6322BE642;
	Tue, 14 Oct 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R63G216R"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81632299931
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454014; cv=none; b=R0hWJ2jaN3aJvMARzs7v5IIgIj1yxfgc6XCsj5OEXm3I6XOEQWpVOSSYybSb0vV3IrURji/ZA8iMtq9ZEe9mjl82QaX+tzL6Ew0ghP4ClKqgDyvp12LIzyBxuWdwzDiOScjbJipzqi4Q03WMgBmktALvtAae//rq8cyoW/oocyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454014; c=relaxed/simple;
	bh=0x3UrsBPVETTwBRwCnhgBbhM6qnsudgwu+ZzzVr0Ebw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5my1FbM3YEZSPVdxImDroojArC97AVUG4aB/MMuBpXbkh21VJA67qqh0cGdzW4Tkjjqs/QrKBFUFKOtnDKP02/02gbPwVJcSYXIr+peRtlF6WMaE+KrxZHCvN7uOvFVdG7xxDQB4oPOdQO6S/QhSEXYTn9Rl7NX9BEXOw2nvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R63G216R; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso4709477f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454011; x=1761058811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/xcWPqQvGv38fpENJkFXKlfs9/4HkC5weY5m/7dyuo=;
        b=R63G216RsGvn0rm21gCzhIhoLdW9FNuxrFwmHQno9PODDtpl/fBmRuaIDwol9B6uHa
         fbVJiiRi31idfGndw5zVQcmuG+ls8l4DtmTV0/+qwk/AmHKqUqyfxuEWjmhgHlfeNrfR
         pM3wJDuyhhqAvYRY7hpjAExBQk61ObXRO6vA2ufG2smSWS6SEbyFbeHSSavsiAHqnrs2
         uT220mWEOP4rTmJQI/zaSpw7lBDBZT3LfbtsjKy8Otj1C4LPZzqCL7jyv+uFR5agxMPB
         imGfE3CjmugE1Xauxngii3RzFM/mEaH4DBpl/yHSsjuKsoz/TeVc9ZNZ1f87+T4eN+mb
         WkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454011; x=1761058811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/xcWPqQvGv38fpENJkFXKlfs9/4HkC5weY5m/7dyuo=;
        b=JvdkYXOXuw6SmcT1SeywPCPNWTVql1b8Bg7fzVCTQ1zO4qcbgtiIryev19omXeD+fq
         or+aiIunW9vrosqGRvaLc1kpazBZDT5z15ZzxZ6n+vfARJe3ltS0jZyCdj/NsITrObM/
         dshgzy4NwP4RPkBOyv/kXb2CO/auPFcoEQlS1sQuHlNHvdZRV+ClPB1zsfwKtZ7RnqLQ
         a4lA6VUx4XW3EJcnZTO3h6/niLNGRsi66eIrtNG2ZrKCITR4saLzOVEB49wFmZDbyCG6
         ST9t/cax9UhuGMQm0+3Q3E36AMeVxjDVHxLqJMGhv/Y4N6jtqsMNSPAm6nEgoR7G1v+t
         5jZg==
X-Forwarded-Encrypted: i=1; AJvYcCUVgcxkNKNGkxxpwN2hCyM9K66RLcO3UHbEMl0vZQ+UvEPNzvyyHA8FC1bwfvtI1tyW39hMVaHbte4k1hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyskFkFIA3nb81iY9LdsPHQTARKLn50W07s0fOPeub48fE7m7ws
	PGiqd4oeszjqJftLHnLOQWXF4lv+IUPt7+3PtoPmJ+mS8oMd2+flxfMh5FvCdziefjDp+Lb/6zu
	AyZSrqIZlbmQay5tenIg0yoIUDN7j0rQ=
X-Gm-Gg: ASbGncuVXIVZSLfvxFIV/+DzqHIXrtdzQ/7tgjC9hGzW/v1xVu1PwZt/10PgSImerTS
	tNxTOIij8Hoo2jfAotOcqajaSeCN02TO6msxt1kUN802lfJTueHnC5T0VUKR7YGN0NpiMUhUfSS
	GbHgiEZDR6IJ/Tg80eObBmL0GItSR+aLt8eMj4lWUpzR/VARkv74PadeiBU1zdgRC9OPfiftD2N
	s9Rt6HnBybKQGThTtP5J9+3+cte6OSSim4Jq7CYdDHPDkMskfNOemHVxezWRPM=
X-Google-Smtp-Source: AGHT+IEL+XKbdnyLYTXdmxGHy9YwikjzfkbvX4vY3C6sFX76Rp6uYlL4tbzFCJI5Gg9WzOlbXIXA8roQvkXUi7xUH98=
X-Received: by 2002:a05:6000:26cc:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-4266e8d9301mr16784354f8f.49.1760454010511; Tue, 14 Oct 2025
 08:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014112640.261770-1-dongml2@chinatelecom.cn> <20251014112640.261770-2-dongml2@chinatelecom.cn>
In-Reply-To: <20251014112640.261770-2-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Oct 2025 07:59:59 -0700
X-Gm-Features: AS18NWA2q98sWLkB5P0TlTxcTup2CzSuwp44HByL-Q7jhn1Gi58d-E1VqVOUgzE
Message-ID: <CAADnVQJygR6Pb1SQq=tJUpHVx7wwnSX1A78mXGha+bQArowtHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] rcu: factor out migrate_enable_rcu and migrate_disable_rcu
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	jiang.biao@linux.dev, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:27=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Factor out migrate_enable_rcu/migrate_disable_rcu from
> rcu_read_lock_dont_migrate/rcu_read_unlock_migrate.
>
> These functions will be used in the following patches.
>
> It's a little weird to define them in rcupdate.h. Maybe we should move
> them to sched.h?
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/rcupdate.h | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index c5b30054cd01..43626ccc07e2 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -988,18 +988,32 @@ static inline notrace void rcu_read_unlock_sched_no=
trace(void)
>         preempt_enable_notrace();
>  }
>
> -static __always_inline void rcu_read_lock_dont_migrate(void)
> +/* This can only be used with rcu_read_lock held */
> +static inline void migrate_enable_rcu(void)
> +{
> +       WARN_ON_ONCE(!rcu_read_lock_held());
> +       if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> +               migrate_enable();
> +}
> +
> +/* This can only be used with rcu_read_lock held */
> +static inline void migrate_disable_rcu(void)
>  {
> +       WARN_ON_ONCE(!rcu_read_lock_held());
>         if (IS_ENABLED(CONFIG_PREEMPT_RCU))
>                 migrate_disable();
> +}
> +
> +static __always_inline void rcu_read_lock_dont_migrate(void)
> +{
>         rcu_read_lock();
> +       migrate_disable_rcu();
>  }
>
>  static inline void rcu_read_unlock_migrate(void)
>  {
> +       migrate_enable_rcu();
>         rcu_read_unlock();
> -       if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> -               migrate_enable();
>  }

Sorry. I don't like any of it. It obfuscates the code
without adding any benefits.

pw-bot: cr

