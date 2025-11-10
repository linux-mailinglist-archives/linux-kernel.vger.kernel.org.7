Return-Path: <linux-kernel+bounces-892732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963DC45B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19FD34E82A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176B301492;
	Mon, 10 Nov 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZ7akTCd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTojAgFJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A3301025
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767912; cv=none; b=agQv+LXf0p4c3F9Md7zuDrKcs0od3M9H/3x3s2gqkjGOy/ApGwW1yGOGUjm377y7o2OAYSIIQXMxrSLepllYMECj5iGm7VeNN35dU1UNJyWemtqFQqkJry7C/yWZWdYzphOUNqaBVlnsOCFaPW4KGjIJemWy3eSYthZkJdfV1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767912; c=relaxed/simple;
	bh=yLyXjYFXqWstrak83rCupm0ESjDS9MUZyp6jbuMyBOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bh/F+XIKTm3SKuMGIW+BR/gUXuIEgobd5jgW2SbdM5l0ZuyIoHbY1V2up96YRwbr3rMBDyLNy2vt+6QOMrRnNIxb5M7obx7rTdot8sLk2yfb+G2ovkzWxHBRcT0ReCci+0vas36nt7a6NkzNFmkEJ565N6kFm5gBWh8qvKLPQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZ7akTCd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTojAgFJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762767909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLyXjYFXqWstrak83rCupm0ESjDS9MUZyp6jbuMyBOI=;
	b=EZ7akTCdxRs7EzwWO7GNduVzJefrsX9d9UPCjeVxfyTvLcRg2bLRoasQ6+bEOCULZCq7tV
	F0Lu7M7tfB8YOzTuiNEE1yXJ088/4Ngg14whPcp/h9essUNHvL9jSTQwSVNlWwx0kizQv7
	2XVnI+9/ITxqUYW5cH6/V5q24TJW+uM=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-tGhzK2D6Nw2Ffg8XgVMq2A-1; Mon, 10 Nov 2025 04:45:07 -0500
X-MC-Unique: tGhzK2D6Nw2Ffg8XgVMq2A-1
X-Mimecast-MFC-AGG-ID: tGhzK2D6Nw2Ffg8XgVMq2A_1762767907
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dd83e15408so1757735137.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762767907; x=1763372707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLyXjYFXqWstrak83rCupm0ESjDS9MUZyp6jbuMyBOI=;
        b=HTojAgFJUJwSWWah3cTzkcwC4Yc4SHcx9/xD4bgFJWR3ThgrepbsxGLJLRslRI3yxk
         vy/0NzNVwn6fw8ZXM7RHaa+5GT92yJ51OqyNZWEGtAp0IgvY+pww1V2EOkgSCokAwsXQ
         ITy4+ihQSsdkPmrv9FrZcy0ZbCbrlffvhYkik22ArVmXhyOwUGTkaza+cDUu5Ehfd2KR
         iIskhmGspy3tGANrO7AbnZ6qcFnjCQbnsvam08AFW+HQY3PwWwvDKfjjvY4ynzzTxSwX
         qNEMbHN+XmllhwmDZYs2s5ZSZmt/rfon+jhoyPpYVdcaFGX04XryBGosnygUK7gEVrOj
         YHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767907; x=1763372707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLyXjYFXqWstrak83rCupm0ESjDS9MUZyp6jbuMyBOI=;
        b=vphSGPYnJR3VEFkyDdtVsZ16VH07yCfedIrUQn3O5mJk5akZWKm0zlQBEl2IOVooWN
         ARKy2rCSRwZRfUdBhOd/mcBHpKDVoLWsb+IdmS7glPM03gRMCYUMIfQniIwlQjb3s17x
         9i+sD0CC7uTVuzgeI6vwIPRNYborVhEYunlD18MGqPmRcNnVR5wVnq4MRUJQWSpDB/10
         T8yBtS0Z/ohAu2hMzBJqPlqXBuhIblPFjx5RTjTfyZ1RFrNGbSSw0e57qAJTo3n7VsCT
         +24XlbuDCZIcnbx1nJiAlQAkxFFFSk4PqMgWi13UhH5ewoDoTnMwOyBjYEkHWfy4lOyL
         BYRg==
X-Forwarded-Encrypted: i=1; AJvYcCUdnS98RSGafmSQmeI7tr3h03HWwS9AwMRP/zVnXqqjGcqhmjUxyjeEYt3pgV9Jvnc1Vg1xkFSuAY2zuck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uLZ6OYe1m8YV6PbtL5TWz5wz8EWwROFdZzxhQkbnFD8AV8DO
	cMcfNa8b9Rq9gCyfES0t6ffdBo0eOKl+XX7HBfRFo07PaPfI9Bh/qofeTAs8SV+F+N48KHWb2hD
	B/6MNXzzty2Vjsf2NO0K19YVQtFgsQQGkhZVU42VCHDyG4kMg6dHYhGo3EffUcQlWZRMdgRzf2U
	jJMV1cmG0MJfEupM9EwQDS51DRq5bMfpWpsWt1+xWs
X-Gm-Gg: ASbGnct95YYPvriLyqfzWT00KuQMZryftaiHfGydQjxtkYdNlupj5ugte35aa1ubLZ/
	MyPUaasy1GQyHHSaheIVux2zZiwAhfZUCfOjo5Zex1RcLVwwxQFgURZe31fxMz3nM689dp3S8n3
	du2D9Ih67YjB6HNtSuWdsxzRBOlYen2av8v13CLael2fSSSbfagwqZEKvR
X-Received: by 2002:a05:6102:509f:b0:5dd:b288:e780 with SMTP id ada2fe7eead31-5ddc45376b3mr2501940137.0.1762767907008;
        Mon, 10 Nov 2025 01:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/yYFVdBstpEFb3Ck1k5v17TU9H66w5gxYmC9oJYim2lSVQ0mI7Bkz15ozgt0Kajlovah77rM8bEk8zqdRVoM=
X-Received: by 2002:a05:6102:509f:b0:5dd:b288:e780 with SMTP id
 ada2fe7eead31-5ddc45376b3mr2501936137.0.1762767906633; Mon, 10 Nov 2025
 01:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220227234258.24619-1-ematsumiya@suse.de> <20220228092215.GA8549@lst.de>
 <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk> <20220301033001.tozk6cakdznww6wi@cyberdelia>
In-Reply-To: <20220301033001.tozk6cakdznww6wi@cyberdelia>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 10 Nov 2025 17:44:55 +0800
X-Gm-Features: AWmQ_bljs7L0oGwHxE2CM5naDDRqZ6T5ZNbQfm76vOzWoHAALjpDvqmytaIxKts
Message-ID: <CAFj5m9KDFNi+8AMdGeJzgbsKFnfanWJk2dESeCgdF=KXi+9arA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 1, 2022 at 11:30=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de>=
 wrote:
>
> On 02/28, Jens Axboe wrote:
> >On 2/28/22 2:22 AM, Christoph Hellwig wrote:
> >> I don't think we should add code to the absolutel fast path for
> >> blinkenlights.
> >
> >Agree. It'd be a lot better to put the cost on the led trigger
> >side, and not need anything in the fast path for block devices.
> >Monitor disk stats, or something like that.
>
> There's been at least 4 attempts to do so, as far as I'm aware (one of
> them being mine). All got rejected due to the complexity it introduced,
> that's how I ended up with this one-liner.
>
> Performance-wise, I'm understand the problems, but according to ftrace,
> ledtrig_disk_activity() adds an average of 0.2us overhead, whether an
> LED is assigned or not. Is that really unacceptable?
>
> If so, would introducing a CONFIG_NVME_LED (default =3Dn) and wrap that
> call around it make it better? Then at least there's a chance to inform
> users that desires this feature about performance costs.

Another solution is to do it in userspace by tracking iostat in a fixed per=
iod,
such as, triggering one led activity if any read/write IO happens during 0.=
5sec.

Thanks,


