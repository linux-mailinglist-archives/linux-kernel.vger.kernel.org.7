Return-Path: <linux-kernel+bounces-897174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B31C5230C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D8B1884142
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAEC314D01;
	Wed, 12 Nov 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eN0yZ/Gd"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FDA29BD95
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949046; cv=none; b=Xu72d277/eBjrS7tExjjEK+7jzP1D5LOTxXPdFugujHRW8vLlCvgzJNo3qeXxNncZGnb9gAxcAg23GVaGa/ctICohQiTMZP15W4F2CDt+dFwlx65+y/N1b0izwi77A/nTcm+vKxh22f4dIvJb14p+94Yu2fYYxoQE+QH3ADI6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949046; c=relaxed/simple;
	bh=nNr0DUZQ/8VLp4TzCwfgS18j02/ugDLQvov96VmfdRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ282ksQOKtnP+fbgSWv3swe4xJeGcZYQ24QFnOmijQz9/0GcQ5qCClYVnW5LmobPWAQviVJPF3PZY60PiWMw+lOC9UmKndp6h5OA89zIy8S/SeqBG5Z91bv3aUBwqJ3Wo/YIYqn7nwNuXa13cg+b84mA6GdE6d/GHyt3dNMLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eN0yZ/Gd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37a34702a20so5873621fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762949042; x=1763553842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNr0DUZQ/8VLp4TzCwfgS18j02/ugDLQvov96VmfdRA=;
        b=eN0yZ/GdlrTRdl7LcIBbsRDvAaIKeCF425nc881BBSymEqQ5e4AWH4e77NH9S17JnR
         IzeTBtaQX+2WtINAWwkinEnVdHXOGo3/pHN+xO35wf05a7Ck4QI5mW8gRbLpRGfyhqrK
         LMwVpIkDSOhmNRuoLDrORmC9MCRXP7TPyQfo4cdNNemCpIU/aRxr1yGfsjrEdfF4TLPz
         gqOhDeyzxZEl8XmCiUh8j0v9z4p/j1/saN8J6F3wU0mTXkCp7K9h0PDbtXCeTj4e7HrN
         MeYfPPi2bDXhFUdOQ6KfyvAxtvhBy6gY0m6BsmTq3DyP3+A7FigKj5Fww5P5USdOqQAF
         aUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949042; x=1763553842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nNr0DUZQ/8VLp4TzCwfgS18j02/ugDLQvov96VmfdRA=;
        b=H7+L8gQQs/+GSDrWzZBta6w9mznXGFa86zD063PAZi/2C8aIIA/u3wfqP9IW67O6Ag
         GUf7SPEOiSKulSpCPz2k0OY0DXRyUYobo4xeVw2wGo7kf0VvQWElhQWnz9coO2gdX531
         iHoZv0d4ZhyEGNVd4K5UnJD2WAf+EHuRwBLNkD/RfMMCQRAM7YHxffd+cH281eZ9zMar
         N42/N1OmM/0E8AQo6d1z4tflH/m73Qi0du2Yr+aqpuqLNtqpa4vDhkcEhc+Bkfm5Iy5I
         PvsYovF3Ks3/4sua/LtkmRafeg2kkUDIpmMW+DV74laVJ/ASbC009jrIRh9zJrmaJQhr
         8tZA==
X-Gm-Message-State: AOJu0YzZR2sTNo8VJgFq+jQy48Kxc82ZVDdOauzMoilY8mz99gkxwAGS
	5Tz1nJCNV484ZSZvB+noERmNNXTszyOmPK+05nb5LTo1xN49a2diimIGatWZ19/SHxDQDi819Ww
	BLJF8F3QmCrE7CS10JC6B9y+0lbI4z9w/hYoDwzyU/Q==
X-Gm-Gg: ASbGncvvMU/bnv9DSG5c7CzYA/EdvMPWKWLTbZrmM+2/vdJgIE87qpJQePHCfCzvSwa
	70B1U78j+wRDeL1yiNsKcsGD54np42j37JX0PRq54rJxhUw/SKy4ISlTTIMLh25dY4LGLY8Km6n
	/QUNFsmTi97mAwN5xZzgNmPiZhvlV/gsS+iCe0JtAmaFtbEaZmuP3+MPnO89t9AgjpQTBRGfPje
	40S6SuHc4Q2auQZKkpxisOJgAln8VRxTKnwD68uBqqrw011CTVTT0L0mAAg0+wKehWHC8IuuqeC
	7WuEA6B+Zu9kq4rcYw==
X-Google-Smtp-Source: AGHT+IHusJDgxIuJ9r1OqE37V5j5KU56vMgrl6TNg3PHf11vdft9QhpgI4ltWiLi8t8k/6FGhCPY8ensI+CYekuVwB8=
X-Received: by 2002:a05:651c:3259:b0:372:921b:4b8a with SMTP id
 38308e7fff4ca-37b8c2f1e68mr7766041fa.4.1762949042292; Wed, 12 Nov 2025
 04:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106145428.250251-1-marco.crivellari@suse.com> <2a80955c-2e89-4175-9688-6ca29538dd33@linux.intel.com>
In-Reply-To: <2a80955c-2e89-4175-9688-6ca29538dd33@linux.intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 13:03:51 +0100
X-Gm-Features: AWmQ_bmzHlWeAuqugaGH_0u_xyxLnOXBHZMHqXUsR0DXraRJSBiumvY2GCO5Gww
Message-ID: <CAAofZF4BfthVOy6auxuxOyX3wDtrZ6tx6n6726Mf0xDXrwyimw@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: replace use of system_wq with system_percpu_wq
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:00=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> [...]
> Thanks, added to queue
> -Mathias
>

Many thanks!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

