Return-Path: <linux-kernel+bounces-775160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28481B2BC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3B25E4460
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23953115AE;
	Tue, 19 Aug 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QAKGwxPr"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DE21ABBB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592876; cv=none; b=kGZHJtARmdjd9heraJVjVm8F5WU4q0WQULFxuVtBeNZXOwza8+3lV6nAiE08zEoHG7OGlLvJ6KZienBVb8vJnQzod6tZudgGqu6A5htUobzV/c3nL+dDJgq8XVi2BTQgQ1puOmk8oQmP25yJ7QlVHfSZSN9on+7W5BSvRxItTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592876; c=relaxed/simple;
	bh=WjaINafF+OcxAtX1ABFT0e5/k1BKm/WdryDJzQE7Vfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMxCwDmBpiIObI1gQyGl1jSKvHHDPWOaY+5W1T/QeY+Pb4dkpeCjU4499cwIXKa4Ivkk8Y+7WT/D6UYgFdghB4rf29hR/5qqE2dopBGXUvjmj/BLZLptJAFdPHs7cSzdhipN8pZX7ARKV6qLVPrlJOMS8bA9+qBFiEeYAXqaa98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QAKGwxPr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce5090b1cso4852583e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755592872; x=1756197672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbWN2yv3QB0geFKiGe15DOvOVXWq4mLKTk3ZUDvNTUw=;
        b=QAKGwxPrqmou+upugQfEb9SbPSSroEsppytNf8q5oqmRDB0yxvVaTThDDQhsvw9bVj
         1U393Xy8gvoL4kMDi2S2cb3CDLri8fetQT8C/ZVqVLLg33s2i8CVif6D2Te1u4Wzzsdj
         6TSS49NYEOCkjFuxCl28jVKbye9DOEXqQ58wMVRU4ntS4iVHkgPhntiQuukk158kwsR4
         08U+FF71ssdgjmqGSaI/G1DkeDSVimhaW0WknzPvTIl6bknOo5HFRT5pmuz5C3M+zB+I
         JlBOpaVEUYyAPuZRdq9RaxKAaOsCyrqlM5yeScui8pQEymUiyyJdhdSYmVhZ2oMeYVEw
         UFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592872; x=1756197672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbWN2yv3QB0geFKiGe15DOvOVXWq4mLKTk3ZUDvNTUw=;
        b=sQH73/2H1cithVmgg2fD1GfNnt0WGqwWyz7FNrHr4ZWMPiGc+lelETEfdcWlTmBXff
         LadAD20soiFcg59vJ77MZx9Q4FommsPaBHQOOy8k6RHiv1pZNps3VbSP79J/mpBdFH3H
         ZuBCQezj8UBLUSqitgHiP8Wx0e91zVWDCfDuzgckZP/eGWbRmW3ZnFNTbCBo4xZDNLUk
         VwEJRZt/kQO/o5zTAmGscATj+6XTJk8pWEnBO4ZgKIGTmT2MKUhwjEHP+BfpzKqGKeTa
         rTP0iMb06nRD7GCLzxFWuNLgwMT3I4BQADlvyr5bNKBe/3/nkHIOjZF06bOUoNRa4HY1
         Ybng==
X-Gm-Message-State: AOJu0YwbmrK7Mx2o+IRYq6zheEdfm3C8ndjTswPiUk4jOzLxRJ0Eziuw
	DTbgeNno4rXY0Q170BP+2NTKAKiKTrZKjPHudzNA6p+FSkTULKkgG40FDd+d9lLcYI/HGk+raq4
	my12Wegbo4vlvHS583j+XkQMkUZkPgXbagQgmiZADcHrYR9mg9Hq3r5w=
X-Gm-Gg: ASbGncsMg2D0QTFmpALZ3C4u/moNvCLE2Z9Kzhi6wyx/mp73h81jEpdPSDP2RrhlJIz
	0m9E3k5qx2X4jcZsVHf212ukTocVLuUGU0K7n439/8KjhB7m0WIK0wAPt+YqWqdY4WRkJJCJ4fW
	4gz913qRZzMNr9oI2Jk64a3QJnrdDMQTnJtc4gKClHGkRV7YSlIvPcjJjFwA1YPV8ev6UIqsLsR
	5muuW2zUWScZToJ4rrfAmWd3HTk7cMM88sBxkbw
X-Google-Smtp-Source: AGHT+IH0poxiLK3siHVR22yn/Bw1cABhXbu4vNfAcfuV7JFvA3aK/yomTojlN8zeHwpVItdu3Y88ERBJmusJ+Rondx8=
X-Received: by 2002:a05:6512:3353:b0:55b:842d:5828 with SMTP id
 2adb3069b0e04-55e007a6db6mr479466e87.36.1755592872008; Tue, 19 Aug 2025
 01:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815094510.52360-1-marco.crivellari@suse.com> <aJ92vqBchsh-h-0z@slm.duckdns.org>
In-Reply-To: <aJ92vqBchsh-h-0z@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 19 Aug 2025 10:41:01 +0200
X-Gm-Features: Ac12FXzp1WDhM_E6ymADxKaKfEaeFSdTESI3_ANZqUrLCayDwGtYPzxe3oB8dQ8
Message-ID: <CAAofZF5KtD3zdrNcGekt4=sZCAAG6_a3Pz99NzfhX3iMkqLdyw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Tejun,

Thanks for your reply.

I'm not sure I have clearly understood what you mean here:

> e.g. Network flows through the same tree but different
> filesystems often have their own trees.

With this, you mean also distinguish between e.g.  fs/ext4/  fs/etx2/
and fs/btrfs/ etc?
So if it is the case, in the example above, it means 3 different series.
Prefixed like this, I imagine: "workqueue: btrfs: ....".

And I guess it would be the same for drivers, eg drivers/net/

Please correct me if I am wrong.

> As the base patch is already in the master
> branch, you can ask each tree to take the patches.

Ok, I will.

Thanks in advance and sorry for the trouble.

Marco

On Fri, Aug 15, 2025 at 8:04=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Marco.
>
> On Fri, Aug 15, 2025 at 11:45:06AM +0200, Marco Crivellari wrote:
> > =3D=3D=3D Introduced Changes by this series =3D=3D=3D
> >
> > 1) [P 1-2] Replace use of system_wq and system_unbound_wq
> >
> >               system_wq is a per-CPU workqueue, but his name is not cle=
ar.
> >               system_unbound_wq is to be used when locality is not requ=
ired.
> >
> >               Because of that, system_wq has been renamed in system_per=
cpu_wq, and
> >               system_unbound_wq has been renamed in system_dfl_wq.
> >
> > 2) [P 3] add WQ_PERCPU to remaining alloc_workqueue() users
> >
> >               Every alloc_workqueue() caller should use one among WQ_PE=
RCPU or
> >               WQ_UNBOUND. This is actually enforced warning if both or =
none of them
> >               are present at the same time.
> >
> >               WQ_UNBOUND will be removed in a next release cycle.
> >
> > 3) [P 4] upgraded WQ_UNBOUND documentation
> >
> >               Added a note about the WQ_UNBOUND flag removal in a next =
release cycle.
> >
> >
> > Per-subsystem changes will be submitted in different series inolving al=
so
> > maintainers.
>
> I'm afraid these are a bit intrusive for me to apply directly. Can you
> please split the patches in this and related serieses on subsystem tree
> boundaries? e.g. Network flows through the same tree but different
> filesystems often have their own trees. Please prefix the patch title wit=
h
> the respective subsystem's name. As the base patch is already in the mast=
er
> branch, you can ask each tree to take the patches. For trees that don't
> respond after a couple pings, we can route them through wq tree.
>
> Thanks.
>
> --
> tejun



--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

