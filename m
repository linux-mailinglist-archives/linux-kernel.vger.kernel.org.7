Return-Path: <linux-kernel+bounces-775694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF46BB2C3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9974A04DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C3305046;
	Tue, 19 Aug 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HK7Gjja/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B730504B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606507; cv=none; b=HFle6TCcTwDk3/APkIv8wzJ0bTC62bWuut0GD5/odtmYMvGLcJhUewz1HED8OtGlYQqhZ91yfQ42daxF1HwgPc1TRaRrHNQjRCR1kbaSQ1m6tiKad4jtwbgluq1EEJXGrEna94kAZyFSX4j1lpQyQfxsa5kcuOLaNStavDH1anY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606507; c=relaxed/simple;
	bh=buGarXLbvc7EvsGi4DdEeHT+bY6nqBYxXRUrx3PSZKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt6QiLZisD7cmw+GXL7/O+tD65dsPLyCU8sbgdFzEtiTGbA99AckG94lUGu4cRrubDGGhU95TTBoRjL++IwPGkmZipqXwiRWFRxYp//uWaq85BESaXIzjiNNf6dotasMtHHejcRlEzEI7HHW8J+gZVJl4roSHwoOTb4zr23N+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HK7Gjja/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce522c7a3so4341475e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755606503; x=1756211303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJQbWEgtxERuDWNRq8pog/2VqdvtISN3ib6sFHsfRPU=;
        b=HK7Gjja/z1BgMakU5XEBbmXXynxAbIoftZhuRqaWKsfj+dIhCRJcHRs4FTpF87U7w9
         zFK/JVfprTBtAylNN4Kq0LJhwWNkEUNMX5XWR7Gm5EC3R5iu18jZ5ZDhTxcGj55V/1hm
         q4WJCBCDUxZBMVeT5CzkztLDJlXNqqsmpeMXdDDxCuKU4zlnD7/f3FE/yCPdg3DI+pn1
         rliRVh3kjEnZCKhU+iGjPa6J21OT9LjxJek/7nz2chilemoqdhNxQOHVPujH20wU9Ycc
         d7Rzv5sK+a/2KC2Pvc7crsRJ3/WgPWgbzvLj/Pe942eIZQeq7SppnjpZl6AG+MdS8wDw
         JAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606503; x=1756211303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJQbWEgtxERuDWNRq8pog/2VqdvtISN3ib6sFHsfRPU=;
        b=U+zo109HKNigvamaP0ZQPVxqiFqPLAWwugmYfoKruZRw14EHgWxeQpIki+J3jO5Cjb
         463liOSemvgdynHkfShgP+II8wawLIB6oAXhAJY1FJFBULsQOSlHVo/xeDzvDM3/D6qM
         d11Uy4/WxY3p7QXaYkNBctW15U/ibR9MoIeCDSj7oEoxS4Hbm51ureISmiHz6iT7OG2w
         A3CSYKaUu3AP+aurU4JzsfjprQf7LwB+7W7sr7Jp5r4uJm35NRA82G25X66qit6w8P5y
         4hQV4fhTnAbnvTSCf1Oa6ZvThu06ygcZSWBMyQTqgUyR3Jmq9RRBKR+EwyzK0evyxGfe
         bHGw==
X-Gm-Message-State: AOJu0Yxij39fmgALOO6J+8z2kXBWvTnWowHK+fLVD/sSpuGEs2gCk+bJ
	kuxsfKx7C8+kXfPntgy8En/EpGwUuWgK8WxG1EqqDRBf1pTgGyNvDOVph1Zn4EIUeg1hE6hZloH
	3IkLQIMD1XfGXDfrex3oOiYn9niLoGzH2otzJHJRhIg==
X-Gm-Gg: ASbGncvoGu0+LFCucPUFeEgePXLd4cdyRhNJXm5obWVd2hryexJfgjgE1eyWKuGcyNw
	GTz0/l8KY36cGA1h2sCWWF71kF/vkRFQeQpxG138NvExHKZtfQCGEk1RYIWG/ylqzK6o/n6as/M
	aPrgKREtBBQwJRIRz40EFyPJVs8uaAiGZB0tbH4obCXanpwf8S0NGrUsV1u2iX6ePshdlPJjTJU
	42lex56h+LrolmOGdgE18wElVCWQWL2eTVa90KZPJUJesbUzi0=
X-Google-Smtp-Source: AGHT+IEXbzyfXRoTyeioUeCb52ldZMnHgEO4zOYG+njI75/BqqE1v0njwQusRTbE55xh3/SiXhJNduE0VksPYXBg0GQ=
X-Received: by 2002:a05:6512:2528:b0:55b:8277:22a2 with SMTP id
 2adb3069b0e04-55e007af663mr665215e87.21.1755606502882; Tue, 19 Aug 2025
 05:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815094510.52360-1-marco.crivellari@suse.com> <aJ92vqBchsh-h-0z@slm.duckdns.org>
In-Reply-To: <aJ92vqBchsh-h-0z@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 19 Aug 2025 14:28:12 +0200
X-Gm-Features: Ac12FXwmGEw5DI9K2XIdah8EaqW8uRUhGQ9QeUYrcEeNGzW_1qq8lGb5rb80WeQ
Message-ID: <CAAofZF5U_fND+te4Sj_+TQPgZH_DDTneN2XLyY7a0niGBjGjaA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Tejun,

Sorry for another email.

Another question / observation: I guess maintainers can't just pull
the changes and merge for the next release, if the workqueue changes
(e.g. changes in queue_work() etc) are not also merged, right?

I received a reply here, in the meantime, in "Workqueue: fs: replace
use of system_wq and add WQ_PERCPU to alloc_workqueue users"
(https://www.spinics.net/lists/kernel/msg5811817.html).

Thank you.

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

