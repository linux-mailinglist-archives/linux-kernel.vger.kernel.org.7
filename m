Return-Path: <linux-kernel+bounces-784520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C718AB33CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A383E189AA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC1E2D4B77;
	Mon, 25 Aug 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fAT0XLOM"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146B296BD5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118304; cv=none; b=N2oSLJDlbXppSzBjItBTykewAG/uOwg8r2EjP3j7A80r7TFdQwARxF9bCzJ3rVeMfFtiBlJea/v/dVt0+4whkyBwdaA35+mzHIUX9aWYZgpPRL6u/8mKX4+onLTPmkGuqQyKZa52EMbEoiggnL3pMIOQgPwsG0uNZmIbvamyft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118304; c=relaxed/simple;
	bh=am/MEBUAmJJBHiXA9o9fQPSxWEkZtS0EFtrYJV6CD7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5yvnldIo42e1KJA2yaaP7oLSIwRag4O1moHmiI0TzlkWV6/cSRFCpa8BdprG7Poxt6x+xjAeALSzpivsdKM6y9f/ZMJ0gUUeqrR07AoGaQgj3h5ARfrq4vIkha5AVuTCKC7pBNGHT8JTObbhDoln0a8DIVAs5OYXJh7GVEJGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fAT0XLOM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f3fc15e09so1179146e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756118301; x=1756723101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8qA9rZ0VGQ6htXlIqTr6No7WwJB1PvKWHfXgNdTtpM=;
        b=fAT0XLOM6hN8+uVIYUtD0yKBXWuAOA6t0vRaffQIjkL1prgLtJSTxSZGCKeVcPtTVm
         1eUcvx5G6oSubxgwwrK51EkanXI2imktHJNscEhQ/NvjCHpFYbjfIIV3yK9gTvBMga95
         UB7VlOXAc2yBczMDKXxPVQcfKyG7kuINzkL0vu5cDaWhv3GQsxdJeJr5j7jvFU6Qy0uP
         HNc7y6+LvwQIb0fnqLdDp1S1EcTm9RH4gcNV1ek+6GVXr2iR6DMXSvJ3xUxr6hGvYsrd
         S5deHVvPAwGnhOEC5rPkCd0q/T9Ym7vNdq93QVph4qOrUhRbOushWKnUt0KDA6NeMZNE
         eJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118301; x=1756723101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8qA9rZ0VGQ6htXlIqTr6No7WwJB1PvKWHfXgNdTtpM=;
        b=FhbTv7xdH4vbizSid2g7Ist9dd0v+PU80RC9HgATPrNYxSrpzvMW7sdoBCaXJ5DDEb
         za72mIBEbnwFQ52ydxy4bfFUeKlFmcca1RyfebsSJyDSMvWs7qgOOPV1J4zX+Ek0F9N7
         kUKqAD3Cq+hvXYyppuy660nirUPe/glTT/HwfaPUCkXnIWuXS71XKYz2kvpJIN/zDYLx
         dN1FwuT5RYLd2/9f4aCMSfryt5tNXOXs2MWmrCGShGi366IVXF5gX0j/rqCHH29dD9w4
         Hg/BQh+sxMMW70LdZQ3liID9J9PO6gkE7kQbSzEZA2d6rLWKDXFHE99p9pYRDWkkqtaW
         wX0A==
X-Gm-Message-State: AOJu0YyCGHc4honC66Z1zPVM6WpqNIhyWI6UK4/iEEsZ32ZniJSgsT6F
	gL/ncxpBpHFvPSEv12Sg6lc8odEs3jH61mXSgCLc9xu+Zc+HkOzPWP8wLOG09LHPY1Rf69g8luX
	bQjKlpVufze9z/Ywggi+KvYAzGFKXW9+/d+bouWBJYA==
X-Gm-Gg: ASbGncsNgdz+WPbpfQEnZY0A80TfFpJyzt7wiUISn/Fjub4R+Em7H3vApzYjWqIbyTf
	pkERyTJYV9iIiS/b6oDwSwYShcq+VO6xFr7Tb9RUzDxUcqe1lcfsNFSK++8bijBUkJVPSPFSS4c
	BeX5r3Wro85Iob/Mzx3bB28hFdK55CTCXzrLeld002o6dGIi/MfTgrB6qFofkA8ZbicQ62sMKuJ
	DYNCnq3wMEiMht9NDwGlM6o3jIThB2mGfOIF7LE
X-Google-Smtp-Source: AGHT+IEMD+/QfWUQGVTcifU2FcwYt3FaAJbY7te8k9GY4GYqbtlfDjkJVOwCpFA5lIwUxT/XGC/1qrXWb5ZpNPhcSaA=
X-Received: by 2002:a05:6512:1581:b0:55b:94ea:1d49 with SMTP id
 2adb3069b0e04-55f0ccee1e8mr2876018e87.2.1756118300748; Mon, 25 Aug 2025
 03:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815094510.52360-1-marco.crivellari@suse.com>
 <aJ92vqBchsh-h-0z@slm.duckdns.org> <CAAofZF5U_fND+te4Sj_+TQPgZH_DDTneN2XLyY7a0niGBjGjaA@mail.gmail.com>
 <aKZYEDYHYs3W2OL0@slm.duckdns.org> <CAAofZF7gEeKVWf_i3uCj=QPNpDXmunb30_6MqiXRHbb9wGHKCQ@mail.gmail.com>
 <aKeBr3eBfh0wr_fH@slm.duckdns.org>
In-Reply-To: <aKeBr3eBfh0wr_fH@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 25 Aug 2025 12:38:10 +0200
X-Gm-Features: Ac12FXz9_XGn65g-WWQ_7gmB3D8y60CdtLaAu_PqsCTjuo6N7_0bMzBsIgKVRTA
Message-ID: <CAAofZF7Ucv=c8Jy2j5C_JVZ_6=4eH=3QTrXO73JGUNCR4CoPNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Tejun,

> I'm having a bit of difficult time understanding the logic behind how the
> patches are laid out. This, while a bit tedious, shouldn't be that
> complicated:
>
> - Add all the new things to workqueue[.hc] so that the users can be
>   converted in whatever unit each subsystem wants. Note that this shouldn=
't
>   add any warnings or cause behavior changes. Just introduce new interfac=
e
>   and convert the subsystems clarifying that it's a noop change.
>
> - Once of the initial conversion pass is done and merged. Add warnings an=
d
>   other mechanisms to get the stragglers and prevent further addition of =
old
>   interface. We can do this right after a merge window as a fix patch so
>   that we don't have to straddle multiple releases.
>
> - Go subsystem by subsystem and make the functional change you want to ma=
ke
>   (here, converting from percpu to dfl). This can proceed without being
>   coupled with anything else.
>
> - After a cycle, drop the old interface.

Sounds good.
I will send a v2 of this series removing warnings and the mechanisms
inside __alloc_workqueue().

Many thanks!

Marco







On Thu, Aug 21, 2025 at 10:29=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Aug 21, 2025 at 09:40:58AM +0200, Marco Crivellari wrote:
> > > On Tue, Aug 19, 2025 at 02:28:12PM +0200, Marco Crivellari wrote:
> > > > Another question / observation: I guess maintainers can't just pull
> > > > the changes and merge for the next release, if the workqueue change=
s
> > > > (e.g. changes in queue_work() etc) are not also merged, right?
> > > >
> > > > I received a reply here, in the meantime, in "Workqueue: fs: replac=
e
> > > > use of system_wq and add WQ_PERCPU to alloc_workqueue users"
> > > > (https://www.spinics.net/lists/kernel/msg5811817.html).
> > >
> > > I can prepare a branch that fs can pull but aren't all the prerequisi=
tes
> > > already in the master branch from the last cycle?
> ...
> > There is still the logic inside "include/linux/workqueue.h", in
> > queue_delayed_work() / mod_delayed_work() / queue_work().
> > Just the pr_warn_once() and the workqueue redirection.
>
> These are not prerequisites, right? In fact, we should add the warnings o=
nly
> after most of the tree have already been converted.
>
> > These changes are introduced by 2 different patches, based on when the
> > two new wq(s) are replaced inside the code.
> >
> > There are also changes inside  __alloc_workqueue(), always in this
> > series (when WQ_PERCPU is used), because they are the "general" (core)
> > changes.
> >
> > If I remember correctly we decided to keep the prerequisites without
> > any more "logic".
> > As long as this series is merged before or anyhow in the same rc, I
> > think there are no problems; right?
>
> I'm having a bit of difficult time understanding the logic behind how the
> patches are laid out. This, while a bit tedious, shouldn't be that
> complicated:
>
> - Add all the new things to workqueue[.hc] so that the users can be
>   converted in whatever unit each subsystem wants. Note that this shouldn=
't
>   add any warnings or cause behavior changes. Just introduce new interfac=
e
>   and convert the subsystems clarifying that it's a noop change.
>
> - Once of the initial conversion pass is done and merged. Add warnings an=
d
>   other mechanisms to get the stragglers and prevent further addition of =
old
>   interface. We can do this right after a merge window as a fix patch so
>   that we don't have to straddle multiple releases.
>
> - Go subsystem by subsystem and make the functional change you want to ma=
ke
>   (here, converting from percpu to dfl). This can proceed without being
>   coupled with anything else.
>
> - After a cycle, drop the old interface.
>
> What not to do:
>
> - Don't make workqueue changes combined with a lot of changes to other
>   subsystems. Workqueue changes should come and after those, not together
>   with.
>
> Thanks.
>
> --
> tejun



--

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

