Return-Path: <linux-kernel+bounces-890628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EAAC407BC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0028B4F61A5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4027C842;
	Fri,  7 Nov 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gJ4qfOPU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA22E3365
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527436; cv=none; b=DWTBzEH0hBgRnyDo6x4RgOP+e6lmV3mrVFJOz3Nic+6G9UtV1/HkDlhZE/rnvSUnmzqg4MAhHb3Ob1XOZmzZSN8pqWz0LehuLEPgnF4/areVDyCnYkBB2wx6cgI074s1WNTl6BvEj7PBLI3X0KpvmSLE+Wg3eaVTYiIWAKIbL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527436; c=relaxed/simple;
	bh=qQJHjKYDj9ZPbfC8AYi9XaYrkz84jgNpklj5TFnJRSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggRxsuxUBe6IIC9zizf7iBBkUsz8l5dWmLz9I0DGmjj3mO7/VwSRKkNnPXdEvyexD3dm4qblKKyO+650qqY0qfuvHU07SAKVEYPhr73j0DH9tPQPGQ5g5sHeB1v40xEh017/MyzQ9DGb8SsjHjzPBrNNJ6AwBwFUxaCFuCX9Udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gJ4qfOPU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5942e61f001so791454e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762527432; x=1763132232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GINQTaI/+dB0Ks7du4nzWDX5WaU5URakHyYNri4cH6c=;
        b=gJ4qfOPULwcqjDpXTpw9ppo+RdWkTXpYnJ3vPTahNZuZeMVucSWQ/fWB0Imx9ACqdL
         lHRHNGFmMih2I1oWQj+TbyqhKjt/A6iMH25pnlazHX6pYwu+FlThISGDiQUFo+7r+HCe
         rckQNOV+veHl4UrscyLhXPz73DJaPBPlMo7OofwfV9qWOm5wLxrJA8G7HJe3a6RDPnDe
         Ejbptjkcbfn8wikr/TMVi0Cb1dBVXQPI47+6IbrDVMLTcpOX3qeiuNN8fDWbbqjnRSjl
         V1R1FJEqnCu4OwOkeFD+RFs6VMNNNY/kCzk6hvbR8eIoO5S0qrlUEbloekJOFRab2WcW
         RRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762527432; x=1763132232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GINQTaI/+dB0Ks7du4nzWDX5WaU5URakHyYNri4cH6c=;
        b=iJ2jzOYQVJUqXHQjrlSdS8Y0isH5CpQHeybz8/Zu4TX7POHr7v8LLCuUKbcH8KmBdL
         QdaysQTgAD5QrZJ0LwAsdVeccZSVjZW7MIgwh57FkTf6mYPJaWylRsV1rUFCAGHBLeRd
         3XQmjdKKHD/LjL0yXMVMa9jbI/sJ8NLBFioFG7Lry+90I3xjDg2C/TLTd6uJK1NHszDH
         ngzhZMNvjRcq60QQd8qxJbAoFGsZuHAMW47KjGyZA5cmjP0aGIht74cORoRBfYTPID0n
         GeLq4TfKHlSlBjMpM8Uw6BHaDdz3hyXsmsyPWQAy5Jpmt0WqYDFncEtvUPXm+d5Pjv8d
         uiKw==
X-Gm-Message-State: AOJu0YwTXYOstXdMIBf0Ogo5KT2eIHyi6/VEq4wyfw8xJ2tnAdYjM2dH
	FhzeSCZPUSOp2/tJh5omDrv0KAII5hI7d9CTFir8Dc36Toqq+4gtldAuFZCAUInnTqIWPKF1ywM
	q/kCxp1aDemDLeoI6F51BEC8zJ/zEKbs01vvGDKN6PQ==
X-Gm-Gg: ASbGncvm62tfbiChlLUw2wavZYuY84WaZiyRAFTI1w4Z2vH1hpCRqDlctvnk/weGins
	3drwhPTxbEKXaD1ltj8ntKf2lS73lWomum4xXfjLiRt3cqzAuU/BqRA8mBt+RVy13pXddbqSt+i
	wqB/3kJ0rXR8/Bte3px5LC2VWkPTMg9Kj5zqvgJ6UB/XsrsI8XJ9uIoEFA0L33H5Uy38GS+rXc4
	1TH0pHD27oIUwUAEsw2MilRIdUpM45HFoD/L6ZQEvMwAidmS5b9efGsE1m5yWhmSUfqhinr7rr7
	GeOrtdLLkkvGf8uKHQ==
X-Google-Smtp-Source: AGHT+IEPFzUSyWHjxHsSTJV/fYFhTThHxVuOjcENPOd4X1v7VF6LkcdyUhZVrfHiGIFiKWQP6Ie+Xvd4bR35pkEt1+k=
X-Received: by 2002:a05:6512:ad1:b0:594:2f25:d48f with SMTP id
 2adb3069b0e04-59456b51a73mr1241122e87.6.1762527432320; Fri, 07 Nov 2025
 06:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106163048.334400-1-marco.crivellari@suse.com> <68ad3747-a912-7644-d9c3-e6137da4e555@outbound.gmail.com>
In-Reply-To: <68ad3747-a912-7644-d9c3-e6137da4e555@outbound.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 15:57:00 +0100
X-Gm-Features: AWmQ_blOxMd_Ms8mEx1fMRi3lxr3RRX5TQNGo1ZjptpleUogGBHHZOKMxSE6zNY
Message-ID: <CAAofZF4D6ML8Yvckfv231PXTtKf40H2De2xZ+uS23C70S5zvhA@mail.gmail.com>
Subject: Re: [PATCH] char: xillybus: add WQ_PERCPU to alloc_workqueue users
To: Eli Billauer <eli.billauer@gmail.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 3:53=E2=80=AFPM Eli Billauer <eli.billauer@gmail.com=
> wrote:
>
> Hello Marco,
>
> Thanks for this heads-up. Frankly speaking, I wasn't aware that the said
> calls to alloc_workqueue() implicitly bind the queue to a CPU, and this
> was never my intention. I agree that the better choice is an unbound
> queue, at least in this case.
>
> This seems to be an example for why the API change of alloc_workqueue()
> is a good idea.
>
> As for the patch itself, it perpetuates the incorrect choice, so I vote
> against. If anything, WQ_UNBOUND should be added, but since it's going
> to be the default (soon?), maybe just let it be, and let the planned
> change in the API rectify this.
>
> Thanks,
>    Eli

Hello Eli,

Considering this workload has no benefit being per-cpu, it's not a problem
send a v2 converting this with WQ_UNBOUND, in the meantime.
 I've done the same for other subsystems. :-)

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

