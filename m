Return-Path: <linux-kernel+bounces-773434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC50B29FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1831781DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D50F30DEC8;
	Mon, 18 Aug 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxPzdzj+"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E3261B71
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515134; cv=none; b=c/1BoHWTN+CVWc8jMDg6PnFUTxpj/BE85o7/YUbO5qkoZVESZ8oGhUuXa3srXQmTCIddL3lLmwOrJxx5s58hkHkaGggSMYgsoeQy5NF8RWQ1R7fS7P9KFTDXCV0nlc29RywoszTKqMpUhJrxOrA7gkjfMKseDtGVYINv0+cambA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515134; c=relaxed/simple;
	bh=OLeLQpTISXq/rVu2p1Au//0lGtCNf96NW1EBv6Tztyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHs5sgX7FXtq1Xfo/EYLFyhmR6aiRwHUWSzu7Lcr+n7bpHneXYKvAt0Ty7o61WHX0D7XfYXp/M42y5DsEo0PnBrD2ZYKsKfS3Zw2oH1xWGNqcP69zlpBslQPvdYXor8Vxnwgnt++YwZ2LkxfHTyM40XoNMLbQqhEMJg/9z0hfLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxPzdzj+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b133b24e66so10531551cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755515132; x=1756119932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLeLQpTISXq/rVu2p1Au//0lGtCNf96NW1EBv6Tztyw=;
        b=TxPzdzj+wGp+CNq2jjXeNRI7SIZ7M+fYWAAQVC7DBUX4lfDQs3MQiUc+qZJDrPFe2P
         Pp1wt8YfrAI3dgnznCjhLL1vGTZrWCgytwWYz2hy1tG+HGwLvpXsA/CX/edyfAFqZtqb
         ka8I356D6Aw2cZ/zKiflqsT1qyojIMoORC711sYCfwllAtg/fdWXgAV0nk0FfSpfDnQs
         8zt5GdaV9qe/WsK0Vm2WqCj651AA+OpZ4A2XCcA7ls2PdCC3yhFEZGUb/I75IgMb3nGV
         peHC7lWAwsICK+BcHmDKdHXOUtRnE8gQHY0zOTFIwSlxMpR06TZtcbdeCsyJWrKgdVkw
         PYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755515132; x=1756119932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLeLQpTISXq/rVu2p1Au//0lGtCNf96NW1EBv6Tztyw=;
        b=mFb2qSA2FCEYH+Q5l6brCMGOkDePDYyIkgoUxHnT5VsyrhnHQrs5qQbUZ3YQ6Xo5+U
         CUjFl1Uo6MTa61Wxv2hiuYedLeH0n+SDL6UYLf/tYOtRAJu2JzHKmq8dd2lnWihgh+f5
         5F4ZbXWsZBp9ZBUoxJ/xfgsbmeiopVc2/3Y/fFgrraJIALqmuYzjzsBXhP0Vx85OofCI
         5PcQlcWf7x8zQ9LSWY5H/iqjMkXnxJ6LS7edgjmzqLrOGGwuy/CL7hW7QWFeN2syCeFD
         XHT8fQMmsK8Fi2u+ByNo3UgjRVQqE/EV/6WO+5Dx49lS9MwqfD5lkr0iKj+clVYFf/BG
         T51Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVireBLR2+YJon5y3MxuzBkNSXZ7j1fnr5r5L0eN6KGQM2BkhBA4CwYPEVT8nzJk0yVZgQsZTtOmC6Xjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHuDyhJcUAaMExj6Slxy3LTCuadSULAikBAO+FfCaVer8+7sGW
	FnCcIo0mxRcaBr+5rqnWSpa31rMuHS9Vz3176N6bU4CVurmRYDkjo47ie3uKH19Z2hsFwGTYtmR
	jRbDpFRPvqcNT4aEjDi2L47Se1Vu4sIUB0KwQ
X-Gm-Gg: ASbGncudGUxRgMUT5IYTWex1MRggY2YkrwReviMZRzexIhg7SqxLss2Gt8SHf7TszQw
	vjIG4NC9x7tjM73s9Zhquv7yo5llminDjMPFCiipnfGa4bgIBGU+uRMT9IY4hRYEx0l89eXHELu
	O8c17tvGJ14hzRp+E0WRtEYkUjvNMop4ntTzXVEAkLZH0UudrTLAyWviOMWZIBj1tL758rLfVg6
	rt0xKZdgs6ApaaXpv81OL7OVysDkQ==
X-Google-Smtp-Source: AGHT+IHdU9VqdzI3gXq8fLjdBvjqpmK8iMvrHUgANzfNARCdszwgLZC2KNFthy1ZVUEXq3B7/aLfYNVPpI5t7max7YY=
X-Received: by 2002:a05:622a:1a0d:b0:4ab:9335:7af4 with SMTP id
 d75a77b69052e-4b11e05b5b6mr129114271cf.2.1755515131588; Mon, 18 Aug 2025
 04:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812093339.8895-1-xuewen.yan@unisoc.com> <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
 <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com> <8a84e658-1c2d-4380-8979-e1cc5bf5768d@arm.com>
In-Reply-To: <8a84e658-1c2d-4380-8979-e1cc5bf5768d@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 18 Aug 2025 19:05:20 +0800
X-Gm-Features: Ac12FXy5WVzUNA87UYEXlHCJAhfKEsxTiy75trluNtRJMwmhRftZ_njxa1Kysko
Message-ID: <CAB8ipk8kf1+Vd94wQn1XnWPvWqP1szxAeUroos1iV6Z17vbxFg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	vdonnefort@google.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:01=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 14.08.25 10:52, Xuewen Yan wrote:
> > Hi Dietmar,
> >
> > On Thu, Aug 14, 2025 at 4:46=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 12.08.25 10:33, Xuewen Yan wrote:
>
> [...]
>
> >> Can you not mask cpus already early in the pd loop (1) and then profit
> >> from (2) in these rare cases?
> >
> > I do not think the cpus_ptr chould place before the pd_cap calc,
> > because the following scenario should be considered:
> > the task's cpus_ptr cpus=EF=BC=9A 0,1,2,3
> > pd's cpus: 0,1,2,3,4,5,6
> > the pd's cap =3D cpu_cap * 6;
> > if we cpumask_and(pd'scpus, p->cpus_ptr),
> > the cpumask_weight =3D 4,
> > the pd's cap =3D cpu_cap *4.
>
> Yes, you're right! Missed this one.
>
> >> IIRC, the sd only plays a role here in
> >> exclusive cpusets scenarios which I don't thing anybody deploys with E=
AS?
> >
> > I am also wondering if the check for SD's CPUs could be removed...
>
> Still not 100% sure here. I would have to play with cpusets and EAS a
> little bit more. Are you thinking that in those cases p->cpus_ptr
> already covers the cpuset restriction so that the sd mask isn't necessary=
?

I am not familiar with cpuset, so I can't guarantee this. Similarly, I
also need to learn more about cpuset and cpu topology before I can
answer this question.

Thanks!

