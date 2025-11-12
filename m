Return-Path: <linux-kernel+bounces-896407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93867C504A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F4D1889337
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EDC296BD2;
	Wed, 12 Nov 2025 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duL45XB8"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2523292B54
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912886; cv=none; b=IFY8ggOjAMqfCf+W1gC8zwowMXLe45TOoDjHoG8hBYyp8mHUPWnB49MxRho2QgEaIOkvw1fNNsyhwEm7v5Z1bPLeeSq7d7UtI5mZD/9jOOAmvJ7uErweDkHjqFoXB+8pq54gG83+wJ5cqnIQnsgEBoy8oxS1gDXgI5mj2FW58cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912886; c=relaxed/simple;
	bh=hC9iL5g/r4JqelSx40pWzohnwtH2LYp7+zd2ehJv248=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDP5gC/juftWIrlwE4L+YMDCdRZP9iaAZR75u/vdM+ZIit81ir317OU7RUgm531yJwXOum0iTw3c9ouk43yGFaL1vcmJL438JYjL7yEatMSe9jUWLlwjWWgFPVz+988vs3qGWp1y0F03GFJf/kjtkbTPEpfGKRuLle2FGeZxrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duL45XB8; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b710601e659so62422666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762912883; x=1763517683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTKFA4FmHX+SmfkZDfZD4AnxihpzB+D9NvDKMNf5hiU=;
        b=duL45XB8w5vNDWqZiEepuyYjKKCcxDzLHEBze6sTSb23K6n2wGUr7iPXVrLlxMmfA+
         2mEsK5HgjnvM6s9fEHXf/nx5JowIhHZSdVJZfEW3lU3unB+m9M8O/NV6TDRzOfGFxCNV
         s/F+XrhFHA2XU0KhbEPvo3OT18UisnC2kp4JsP62GP3TjmTGHLbPeYQfRt/jR07ZriqR
         FPv3muk6M+gfBMx/l5/W1mtN1KeTV/EvJJ8bGe5OgLIWph/0OZzwBbtYwybskOai3xh0
         pcCw464KLgrWhET13WV+7tMp8exlbMoNcovF09FNqTXSqGWHiSof5pcCqbgBFbj9cEXL
         +Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762912883; x=1763517683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTKFA4FmHX+SmfkZDfZD4AnxihpzB+D9NvDKMNf5hiU=;
        b=FANDH3ND6L+9Mv6LL5ExNl8zHmyb/mIh8+qTle/1FSODPGseSMaQrE73B3CRxhXbKi
         n34gfs9Shub+vZoYc6LJBRvw4JBHs8cYkW2MTHnENVB4icjOnKwudlgDwg70O6MXHtqr
         UKu8LnZypEHJuOEARFddjpFo5joQA8ShT3Wr2/6H8ubhbE39TTUlyx22tLmpjfqMzqkZ
         T08ilFoad3smuwJa3I+ceGMFTYzLxDkmPuCa0oXN2ntHFYZC6xnnv8l8KhNq3YXMaYBn
         nQZz4JL5wusBM+BhqnwUPShmsYa/BFF8xemzl2UHnBREh5eKRzMMesbIvj97zXtw//pk
         w5lA==
X-Forwarded-Encrypted: i=1; AJvYcCUV6+OivP9F1UL/2fpCKB5dobZAuUdUT/yoxGg8fZkavqHYQ9CYYloc226c5W1SBrR7rhFVdyD9VJ9qRAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJV+Yv3d2ChmLUodckBhl0DbgUwOaUO3Tq53a4anFmJZkAekd
	F/XLwJcX1ESsEshiRjxrJOsZlJ0SHf+T3lZ6txe9K+fBX2BnA4bWbXs9/l0Yj1yez31Zefgv53C
	voWA704f4gykizR9aKccOT/JlCxnaWJw=
X-Gm-Gg: ASbGncsFetTyhoYWHVhFQT6GTEg8N6URwfBdnFInXdzVh0feksMFzICZOAjXccf0qvH
	UQd+nCzdzz42APgNzLFBbY6iFGwPEW8DLjIbd0QrnDatttQW8U+CVCp763PpoRwTtJPsgzzEh0k
	GFxA9y9v8dTN84+v4B5jN2+iPjt7MgtJuHRGAzVcVjN4Ykeuh362+pdMnVGOQ8xbvnWeBuYtWR1
	20awUY/vmic9KVBCkROWHMukl5WeL+ug+GtZh0vrOnl68Kv/J8IfATpLWF41uIv+peUxyiS+CNR
	J2NyOhA=
X-Google-Smtp-Source: AGHT+IHQawOtg7stF/ur6WruoF2ofeTS1iDLY3OcmSBF1SFdsGF0MWHPFYbJxPYnwfCCuzRE+4hJ24NlxB2pJRkZAuc=
X-Received: by 2002:a17:906:dc91:b0:b73:2fe3:db09 with SMTP id
 a640c23a62f3a-b7331a5ac62mr115293866b.34.1762912882765; Tue, 11 Nov 2025
 18:01:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
 <aROfRBGmglPgcPVf@slm.duckdns.org>
In-Reply-To: <aROfRBGmglPgcPVf@slm.duckdns.org>
From: ying chen <yc1082463@gmail.com>
Date: Wed, 12 Nov 2025 10:01:10 +0800
X-Gm-Features: AWmQ_bmU_bgiMGvUYMpZhK8hx2HVz8AzY4skzxtgFEEF4lcFY5KWBOXHxb06Ys8
Message-ID: <CAN2Y7hwUmdFMM=mwYq7gsBpbSEBq6n0nXzmES4_=p3fDV=S+Ag@mail.gmail.com>
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
To: Tejun Heo <tj@kernel.org>
Cc: corbet@lwn.net, jiangshanlai@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 4:40=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Nov 11, 2025 at 10:52:44AM +0800, ying chen wrote:
> > If creating a new worker takes longer than MAYDAY_INITIAL_TIMEOUT,
> > the rescuer thread will be woken up to process works scheduled on
> > @pool, resulting in sequential execution of all works. This may lead
> > to a situation where one work blocks others. However, the initial
> > rescue timeout defaults to 10 milliseconds, which can easily be
> > triggered in heavy-load environments.
>
> This is not how workqueue works. Rescuer doesn't exclude other workers. I=
f
> other workers become available, they will run the workqueue concurrently.
> All that initial timeout achieves is delaying the initial execution from =
the
> rescuer.
>
> Is this from observing real behaviors? If so, what was the test case and =
how
> did the behavior after the patch? It couldn't have gotten better.
>
> Thanks.
>
> --
> tejun

We encountered an XFS deadlock issue. However, unlike the scenario
described in the patch,
 in our case the rescuer thread was still woken up even when memory
was sufficient, likely due to heavy load.
patch=EF=BC=9A xfs: don't use BMBT btree split workers for IO completion
(c85007e2e3942da1f9361e4b5a9388ea3a8dcc5b)

Works that have already been scheduled will be executed sequentially
within the rescuer thread.
static int rescuer_thread(void *__rescuer)
{
                ......
                /*
                 * Slurp in all works issued via this workqueue and
                 * process'em.
                 */
                WARN_ON_ONCE(!list_empty(scheduled));
                list_for_each_entry_safe(work, n, &pool->worklist, entry) {
                        if (get_work_pwq(work) =3D=3D pwq) {
                                if (first)
                                        pool->watchdog_ts =3D jiffies;
                                move_linked_works(work, scheduled, &n);
                        }
                        first =3D false;
                }

                if (!list_empty(scheduled)) {
                        process_scheduled_works(rescuer);
                        ......
                }

