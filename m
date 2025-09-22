Return-Path: <linux-kernel+bounces-827315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9825B916A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86FB3A86FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609E30C35D;
	Mon, 22 Sep 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IaeRSp5f"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB0309EF6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547993; cv=none; b=a69zZpQ8hXT8ehsS0asuvA7DEsxX0Jjk/PQg7kMFus1k64CyK1DxuaZ88wToEgQvAjtSC/IehOPBJ014i2h2AYAsrxTYV0HAJoP3xj39NIzYnpJ9HQP5gFd78uXGfXbQCwDb/KrdpBBLQmR68F6xX3R4vW4cmxvUmao3RHOY1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547993; c=relaxed/simple;
	bh=ju/+Tk1jIZw8C+PDK6Uifc35Hld5yaogm6d4PJKSVxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBaQq1u8cVTe0W8h494nS3C/b+42zF/LNeAGibHVvEiDyJhSx87ENEWXivJpIMMLnux0FHca9wEY62M3oZoTr0K4bWd015HBNMxgyLi1vsT3igZhzyfvHX2kb1PJE0pK+c0JWT+HLN8ItWtG9h+7VOzmnkDheRRfzdes5WMBhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IaeRSp5f; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso3053362e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758547989; x=1759152789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju/+Tk1jIZw8C+PDK6Uifc35Hld5yaogm6d4PJKSVxM=;
        b=IaeRSp5fW3FI4cjA2qid95VidKwoAWpdi78h1l+cJVfevuWQpKNOo9IbRWtKtA5mwa
         1FAWVUSwrR1YjXSnc4iTGqhKkMiQe4oGGk+l0Z62YzUtbCb9qoGZg8WyuGsoIK8Bec1t
         FTkY/U8Juq1JA/+ACJekmouAQ3KircfHYMO+70OFxPtbPMZGPquIExujnSVD2eWSApOe
         LfPueYV/MG1bXAbokuowgkUM/CrBkbXjKIb2zoImPpAr73qZ/p/6Orw7GN3LbRjQZkQW
         /dVm3ReZ4MdvTFe+ayvEztR+vak5zHwzmGT7bBUaj8koJzf7yjzEkQWJcEX5SWap3+PW
         KclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547989; x=1759152789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju/+Tk1jIZw8C+PDK6Uifc35Hld5yaogm6d4PJKSVxM=;
        b=q4oV5anIz32aKAocVlQEN9gfbc/d4O6xXbo0BHZ3Hd9p4DNahWp9LAYHWxjy4EcVv5
         nxJMvRR827pA1Suvvzr4hrtm2zC9eotqZQ9L7UKkip6gZ5n5pDp0/ZtG/D0fBaVJdbTR
         N0csIej373X/Do9286uvvPvCCJu2BegkWclonRvRGWWPZfrJ1nfVq4aEKlgbxREXzBnJ
         2wTw4akWFz7RHqXZmgvvZvnnEvZ1QQs3aXsbiaZb16f+P+EgNq1By+E4DZvPZkrO89Dq
         qzZukykybvaCKpXxvE3i2Q1j5dO20jdZVQcEUJrtubzuJTNdG/XYrZjxy84jT3cViE7T
         k8bA==
X-Gm-Message-State: AOJu0YzsNzo7fIZjZpMvMYmH94N5YPGUVoQLK/v/B3WlsmFBlSINuQhc
	iRLGT4bW3PoUqKYy17JS5xDSRZAuOtyGk13Iwm8hrJD/iXIhDaaWE4ngiYo6lNH43z2Cew6xMl2
	NBLvwPWl5eOlCORnQFEvwG4uu6HePwjnZnB0kggPu0A==
X-Gm-Gg: ASbGncu75SM+sh5hg8r+WRedrC93xVh8+E0Vn3mitaynuhJ3oTEQBbb5QeIpY3NX9wX
	RKI+ExDBsWozRGx8itK8D1UQOfkmXHlkZyCePnKWtZVtbxetFD4ncGTJ+Gu2YEdVEr06N0J/0Kl
	n/TCodAkrepC5Gt/8YQTWHpMbuB3MUi8HNEAmGG6F45MXLtgrucBIluz+BKcsl+ZMebBZ0uReoe
	5gUWXRS8GSWX7PwpQKhMEyJKMxDzueSmr7KG5NP
X-Google-Smtp-Source: AGHT+IHTBjNX0HP3ZCkaVoLL4eLDrptLZmHCvsE+kJJ3VY7J9vfIkHf0tBWobs9HDVtvaVyexH4mBI1JSmF5zBtai5s=
X-Received: by 2002:a05:6512:2093:b0:55f:503c:d328 with SMTP id
 2adb3069b0e04-579e2cc187emr3681505e87.36.1758547989257; Mon, 22 Sep 2025
 06:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922102407.186660-1-marco.crivellari@suse.com>
 <20250922102407.186660-2-marco.crivellari@suse.com> <b64db199e6e1cd09b26f44d2e8cc1bec43b163fd.camel@sipsolutions.net>
In-Reply-To: <b64db199e6e1cd09b26f44d2e8cc1bec43b163fd.camel@sipsolutions.net>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 22 Sep 2025 15:32:58 +0200
X-Gm-Features: AS18NWBfPDmqzwWyp5Hr3BDD1B5D9T66jY4pTEMJ-g36rEN9zorzdVIGywuXji0
Message-ID: <CAAofZF4=UgS+hH_fNry-Sjt8O1wzrEp2x12pcPzh7oPETUZ0-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi: libertas: WQ_PERCPU added to alloc_workqueue users
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Brian Norris <briannorris@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Kalle Valo <kvalo@kernel.org>, "Dr . David Alan Gilbert" <linux@treblig.org>, Jeff Chen <jeff.chen_1@nxp.com>, 
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:33=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> On Mon, 2025-09-22 at 12:24 +0200, Marco Crivellari wrote:
> >
> > With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND)=
,
> > any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ=
_UNBOUND
> > must now use WQ_PERCPU.
>
> Which I guess forces a decision, and should be kept for a few releases,
> but ... is "keep what it did" really the right decision in all places?
> It seems to me that for instance for libertas here, there really is no
> reason to be CPU bound?

Hello Johannes,

This change has been massively introduced only to make explicit that one
of the two flags must be used (preserving the old behavior), where WQ_UNBOU=
ND
was not present..
Going for each subsystem and checking who really needs to be per-cpu would
have been a future step.

I've already sent a v2 for a few other subsystems changing the old behavior=
.
I haven't seen per-cpu work, so removing the WQ_PERCPU flag and using
explicitly WQ_UNBOUND instead, is not a problem, also for libertas.

Thank you!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

