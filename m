Return-Path: <linux-kernel+bounces-764710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E12B2264D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1736B1AA1374
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F72EBBB0;
	Tue, 12 Aug 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVHajGqo"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E222DF9E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000296; cv=none; b=LZBPzKrT37qQuo0pqeCoIQTszk2k8ORXJGG7ACOisMOgxFB6jnWrq2of69atwCzO6hewrgV+i2c7UPtIKCa3pmPnMu8ix40nsG/IYiRvZQnf3TKVCjSutxdP3y4P7TkRCj/oOo7G1sx5L+Mq3dt/eX1uv2cPI3NXW3DGqLxsU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000296; c=relaxed/simple;
	bh=ovc6fUZeloBDZyhGkBC6Gkvyn8xyLhFiEzrPpT3TN2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdBiLoaNQzzr1UXLFFyxAj92AsdlCLUXVOHIg2n0FlBomDnzXiboWbI4uJotaUkAnKY/+5tbeU78GTX+auc06SCj22hGx47A933RSLJez8tq/7F0utIgpgS3Vo2MDaeGJiKFU1UZuI7/awY8V7TnLFwQw6aJI8g6IV0OM03sx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVHajGqo; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e9028e13bb4so4407824276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755000294; x=1755605094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMHHyMgYDOlp4YhB2iXTghFE64hBQyHsaMgY5YIwUBk=;
        b=UVHajGqoLMbh1CCW5BO8eSruvf2JczSDs/HAQp/v6lymNWk2JiJW/XWe2HTi5WF6nu
         6qvtBoU6hbfTTP5syYpzYsTXlkBJpFpJ0kIDvFQt3I47pxpdvd+Gum7C25+XWjiYuMZl
         JWd1qESgOQKfIxnQ2fc4zfhOGHhyeXaVuvl1s6TWIlHT9nMxM0iz+GZxb0HyzdoY6vwV
         I9odqoeg7KCdQUFoyfwiWbIetDfeIgMK4Iz1PqJDeyMWC1jmIbg82KRQ4sg6+CpXiTny
         sYDuWPa+QZcvHDKJMSHpwH2Sq2WHNcgoopY0tSHWSzVn5N2irjOw11NbKxMN4pX+GSyi
         CinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000294; x=1755605094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMHHyMgYDOlp4YhB2iXTghFE64hBQyHsaMgY5YIwUBk=;
        b=YU+Qa0BYD9K4K69WJW2NENRvOP9JBigjVIzCEKdP0x/a5sryME3YzYsiB6RJJ4jukA
         MVXPewfBOFGyrr3hZi9cygPo1lSZdjIeCnQllYiGpjIMtXpx4Ck7NWhcDDCXBn1iAFkE
         VqbHp5HW77PkhwgrIEkS4K1i35nMd5N4OqaaJ4XJ8JQSwvkhKkr2YpA6qf2lWrgVIMDV
         EOwgs6ebeyqsLkzE4E5JFCY6VXao2mvdpCKddq5o2ly4IHWrKvNp6DoKI/xkfmKLcpcJ
         iX77FwTdoYf/LphWe+0yu6rkXYdSEWdMfE7uw+lEg3fCFY3YnFZT6O1zda38PcAM1Wu9
         pgdg==
X-Forwarded-Encrypted: i=1; AJvYcCUUSgAQ9dmO6mRQ+Ex4eQWm+Hx3ZH48xjZ8txiiH9PnZNeVe3sgIWI3+uNqw9FtBjpJ+0dbnxcvi+D1xNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaI/07yGS3IYSfXZS5kKPYjxg69oWsjh4Opw0XYcqYwh6CEBab
	9dyO6fsj3J1QVm+7n2qLyyIRwmAV0TIKKwjMkmikSBzNJ9srU5aDhszN7zN3o4iVn3LXsxmxdEk
	bXPgy9KDAt5ogg0JnOVobo0rfcHV0M8U=
X-Gm-Gg: ASbGncsqVwxpofGDeT++CbjQaWBwMWVifSoa1cVYvc/l6wsMSf9xHqAQ/qXQcHO7zSd
	IK9OumCNYX8MqscmJce4JXElTx3u+PhdmTBTFAPO8XeO8dd+fp8jb8P19njGW0nu66xk2VIwQ6t
	rjMayGFJPzfjIqlfBeO3fJ53hBYsLATTLb6R3dNyg9ayF+3Qa//JGh8whkEiHVX3AIerwWrxG1m
	L+yDDOA
X-Google-Smtp-Source: AGHT+IG52vA6ahxeUqOgxAddv0S005RFOpjqXItDGwjxtwmTGb4dRGfFLOtGrtoRdBYkKkuE0C2n0bb7FMpswhAU5p8=
X-Received: by 2002:a05:690c:3605:b0:719:f7ed:3211 with SMTP id
 00721157ae682-71c429651d2mr43942727b3.7.1755000293897; Tue, 12 Aug 2025
 05:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812092810.38728-1-yaozhenguo@jd.com> <20250812100035.GG4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20250812100035.GG4067720@noisy.programming.kicks-ass.net>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Tue, 12 Aug 2025 20:04:41 +0800
X-Gm-Features: Ac12FXwGINdGukGNn88-lI0nyCdzZeXqhtTdAR66wgd8w5pZeWco6uDcLkBHYGs
Message-ID: <CA+WzAR=gnECdMh2vdJYHi9vK0GGw27xDNfgpL+ZE_jTLSu=0Xw@mail.gmail.com>
Subject: Re: [PATCH] sched: change MAX_SHARES to NR_CPUS
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, 
	yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=8C 18:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 12, 2025 at 05:28:10PM +0800, yaozhenguo wrote:
> > From: ZhenguoYao <yaozhenguo1@gmail.com>
> >
> > As the number of cores in modern CPUs continues to increase,
> > 256 * 1024 is no longer sufficient to meet the requirements.
> > Therefore, MAX_SHARES is being modified to NR_CPUS * 1024.
>
> You forgot to explain why this needs to scale with CPUs, you also forgot
> to provide an argument for why this will not introduce numerical issues.
>
emm=EF=BC=81It=E2=80=99s such a scenario=EF=BC=8Cour server with 384 CPUs  =
as a cloud
computing host running multiple VMs. We need to configure different
CPU shares for VMs of varying specifications. For example: An 8-vCPU
VM is allocated 8*1024 shares. The
/sys/fs/cgroup/cpu/machine.slice/cpu.shares is set to (total cores -
reserved cores)*1024 (e.g., 380*1024 when reserving 4 cores). Purpose
is to minimize interference from system processes on VMs and to ensure
differentiated CPU capacity for different VM specs under high load.
Assumption: 1024 shares represent 1 CPU=E2=80=99s computing power (please
correct me if it is wrong).

The MAX_SHARES threshold (set to 1<<18UL) prevents this configuration
as it reaches the maximum allowed value.

Regarding numerical issues - are you referring to potential unsigned
long overflow when NR_CPUS is too large? I couldn=E2=80=99t find historical
commit records explaining why MAX_SHARES was set to 1<<18UL.

Alternatively, my understanding of this "share" could be completely
wrong. If that's the case, please correct me. Thank you very much!

> > Signed-off-by: ZhenguoYao <yaozhenguo1@gmail.com>
> > ---
> >  kernel/sched/sched.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index be9745d104f7..5c219e34f48d 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -510,7 +510,7 @@ struct task_group {
> >   *  limitation from this.)
> >   */
> >  #define MIN_SHARES           (1UL <<  1)
> > -#define MAX_SHARES           (1UL << 18)
> > +#define MAX_SHARES           (NR_CPUS * 1024UL)
> >  #endif
> >
> >  typedef int (*tg_visitor)(struct task_group *, void *);
> > --
> > 2.43.5
> >

