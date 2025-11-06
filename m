Return-Path: <linux-kernel+bounces-888889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862CC3C304
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5D64E4F40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE38D33CEBB;
	Thu,  6 Nov 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cz8rApNT"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CDC21D3F8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444500; cv=none; b=rviBl5Os2PpWM6JBcQjt5wO2zoYjvMykGAe4dM3MAzRlmrFl5hyfn4idGGYQHIu96rmbfUG2I3YR1jI9kzbw4+/VWOpRfImUCo99rbcUWCeKnoa0NF5pS4RyhyyLD8wSCPTosevpoxGshm/4yIBZajY0m6nt9nwu2cByzgMhGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444500; c=relaxed/simple;
	bh=//ip5JuhxW/nmUXS5j6syyUrR7NrGr8IQk8tr33sAkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVLO7kWUnUKrmq7IuSFKJ2D3i7QcK3aIl487ntE7Xcf5gvr4CeebpEvP0WtsperiKZnH+do/GtPXlY8czBHC1G0w7Wmj/DIjRTjSpirBgzjB1HG4mBpxFr7BuBFKhwFY9lxpDBeQ398rmsY5O9JfG+z3GNJYuA63LQYqAjHpBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cz8rApNT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b714b1290aeso135728966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762444496; x=1763049296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//ip5JuhxW/nmUXS5j6syyUrR7NrGr8IQk8tr33sAkY=;
        b=Cz8rApNTkKF/8OiDqRS1wttuH5pb7607slQmmG3tOCsXcZmba++GBSY6586Na4Ewy2
         YWP5J2fzgXHq7v7+NXra1j9LRCal007pYGkGJ2OGsLlukq55VyQny2XVfDM8r9w2SHdf
         Ygj1ahrDaaDlCPcaqGmxNfroHBN6L1bzAMbOOu8DxRFANzzcLme2WalGXHDM5CVGMqCE
         c2dzrrGOVmGOcJsi5ciez5CqyLJntxXxPzEfYP4ZRYShdMbN0YxEnQp4DccpZRxoHjuS
         1csc1gt/2Nv4RhaoW7xtdTGgARrPtYGAJ+WlXSRjdiMHQx3YQCgdEj3jeqjZK0yN7uMf
         SReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444496; x=1763049296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//ip5JuhxW/nmUXS5j6syyUrR7NrGr8IQk8tr33sAkY=;
        b=p/+JA6UsCvur8UsGUvxDySdcB4AiJ5xLiu/bu9HvqvZA6Hkb9Eew8ftHi5l+CREitP
         W888fz6zYQwyQTyr2vYmkeSgPE5kyc4p5c+ouwOM4s8jpvP9/dcXong5DnTt6Vp4st9E
         OceTWZq+UnN6Rbvd/kavY+glfaQfodQhPmkvq6MYs1aDOzfDO1AhXZN6QUKlkYw+3LbC
         iKmEE8exXUn1zaW642rJXNOntTpAD0ZXgJ/5i++hLKQmCNls3BJdu8oPXv1xOHirRSza
         c7s0g1FdgIPwLUCsd2Vu+n65HmbRiLzyxknHyfHGxWXe42f3x4KlMb6TYFKYlt5vKAQh
         e6ag==
X-Gm-Message-State: AOJu0YyrShcF/3h6rGZGq77VD2XiFML3RrjF21Xf3Roafwy8kCZfTwxj
	+NoUAdFZ57n1tqQiBaDa9RTeGbhHSMsAo9TqGl5r2DAETumwqayKtX4Po2auyjYDYXrMXDQEhQU
	eFDRtKhgQwI63xzy6zqmiLoxdKubfxOCdYiP3tgXyEg8otGzdfXG8W4Q=
X-Gm-Gg: ASbGncuxoMMo2KmKGBVaedynL7pjLcjYD7b0w71xdNdVdvodJme7LFDnaGQWsOIWzrU
	EB4uMCN4hFYQEHKR3JfQsCmaOgCeAfi9WTO3M5DiCGmN1eqsHrtpaqFjQDk8GYfGz2+Pu76dC5w
	hm1DM5WJrZtywdEV+3HR5q8+ylKvqiu9b+kw6VPHz+ue2O0C1SNYRKoDfLV1px/7zhYx/qbOLYz
	RBl8hdVTfqnG8+DrVJPk291qGX+q4064Y8UdIHUV6E6aXF4xumgbj7sbyMBZ+PtKyy3xuZOb4UO
	iFPIp4eyLRVr2dp7PdlcyIWk8+H9
X-Google-Smtp-Source: AGHT+IGqMCE+9K3ciy5K2RQF5h+CMouqQeZgWBhsBhmUskS0+qCNvN5UeeTY48AxfYhHeZ2NIghyxm9MYYlMR/fxqvQ=
X-Received: by 2002:a17:906:c10c:b0:b64:6776:1ee2 with SMTP id
 a640c23a62f3a-b72655a1a4cmr876761666b.52.1762444496400; Thu, 06 Nov 2025
 07:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106150121.256367-1-marco.crivellari@suse.com> <b1f91dd8624ed65308b0420fe2d973f0bb44632d.camel@mailbox.org>
In-Reply-To: <b1f91dd8624ed65308b0420fe2d973f0bb44632d.camel@mailbox.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 6 Nov 2025 16:54:44 +0100
X-Gm-Features: AWmQ_bmbiBa2yLE-kypl1Ed0If6u8lOhX0wrvphU7llhsVhJ85qP3ozN-Pe6iAQ
Message-ID: <CAAofZF7L4-0v0qpw3TSXp8ccYTf-+k6gJOOYsnCJptRicvDsMg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sched: Replace use of system_wq with system_percpu_wq
To: phasta@kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Konig <ckoenig.leichtzumerken@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 4:37=E2=80=AFPM Philipp Stanner <phasta@mailbox.org>=
 wrote:
>
> On Thu, 2025-11-06 at 16:01 +0100, Marco Crivellari wrote:
> > In the general workqueue implementation, if a user enqueues a work item
> > using schedule_delayed_work() the used wq is "system_wq" (per-cpu wq)
> > while queue_delayed_work() use WORK_CPU_UNBOUND (used when a cpu is not
> > specified). The same applies to schedule_work() that is using system_wq
> > and queue_work(), that makes use again of WORK_CPU_UNBOUND.
>
> Alright, just to be sure:
> Behavior doesn't change and system_percpu_wq is then still a workqueue
> where we can submit normal delayed_work?
>
> The scheduler's timeout mechanism relies on scheduling and canceling
> delayed work items.

Correct, system_percpu_wq is the replacement of system_wq. They are the sam=
e.
We chosen to add a new workqueue instead of rename system_wq, to make the
transition process smooth, but you can look at all of this as a rename
of system_wq
into system_percpu_wq, basically.

You can confirm by looking at the header file
"include/linux/workqueue.h", and search for
system_wq. There is only its definition, everything has been replaced
with system_percpu_wq.

> Thanks for the updated commit message, looks great.

Perfect! :-)

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

