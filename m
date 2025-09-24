Return-Path: <linux-kernel+bounces-830298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90881B9959B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B953ACDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6E225A34F;
	Wed, 24 Sep 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErseWRNi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A562DC341
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708313; cv=none; b=GqRgBrnTk1ahZdgDLy2wysbJemE3mnp/1HxjquEX8Wn+vsp9T7n8g9PJx8b0HHv3wWSKVjJRAhs2wV71VDyaf9Fbc2ntqzyW0cUD/Xl3RcrpGuvPrtNsNNY8bf0eZnTNFmLtBMtkt5VdsfcOkFjCwC7dMHf0qNkwXYCxCRZTh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708313; c=relaxed/simple;
	bh=pKcp8RbB9qIjTq//aq8x3wJaE/cjRo/2DCN671q8C4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZqI1uAlVns0qieLbQvW17ZpYB3hdtYzqPjuEcLkTowma7NU0pQ/aJxqWi9osU/yopy28OhJy+SNvrcD+PvoGZihoonfxDq0mZ4wWmtw4rpZuVIrxo51RxxeJmr5y2QRyPakfa1IDKlVOJrA81LaalpC44wkgRk1uDa3htxporA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErseWRNi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758708306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKcp8RbB9qIjTq//aq8x3wJaE/cjRo/2DCN671q8C4I=;
	b=ErseWRNi+6pJT6rKd0Mk78BAFvCuIqVS0VG20GInb8pg6q3dCLsekUUBZ/4kZ2rAlknRKu
	EA7+Qio9wr3ckp8WfSmNpuSt+/UY8AsY1FM8DgGgdISiK3zWSh8QW+Kx/8YCKAkjp0ysPd
	sJ0RBJ+OJcnjx1aiDK3NPzOLbBO+h2I=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-zo-MPsK5OHmvc5ERNOWPUw-1; Wed, 24 Sep 2025 06:05:05 -0400
X-MC-Unique: zo-MPsK5OHmvc5ERNOWPUw-1
X-Mimecast-MFC-AGG-ID: zo-MPsK5OHmvc5ERNOWPUw_1758708305
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54a87b8f9c6so1504384e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708305; x=1759313105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKcp8RbB9qIjTq//aq8x3wJaE/cjRo/2DCN671q8C4I=;
        b=anWqpZqB6J40w1Z+FHZcv4idCcRaK1OCB6ctPtoFV3LaBc0uQ5iiVcfOEYGPgve4T8
         MCC1iJHcL6lpCMxSEu8KSIv4BNXJuqVDzA1l/dW5wujBLxCMHoQ2pXTTTS9D6nZvZPmo
         9auNrHaJaIhBwFLxqgT2Im6l1e9bVhAR+VqZkVsb71oWqElJuMc1AfhCWP06wb92xdL8
         geOwQu0clSC8uz58c6On744fW9DxPENf/fGTykGASyVaLzax09PJOOgoTJPhOUfoC2GJ
         yPnd7hntpv6MmaOhnaIswcV/N+0nFV3qDcApwIrq/8kiMd3NgaXp6oxBKO6hRW31U4LB
         YM2A==
X-Forwarded-Encrypted: i=1; AJvYcCXaqj6Fs70mODx2tO4ZDcA8U3s76Zpk4PK/D77Wwu1V/h12zg6gfhk5PhTWVDRbAhprbiiarHP5h+kfGW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5GfEVuUbDI1EaMACUKLYr969OS41gZhjpq5Xd/0HcqYYh0Eiz
	umiyvJH26qwtpBaFhnm+DIsiFYsl5fIa0lusWkTcGSp62ybeXg1kJhruz+lwgagjuiXpSOiW1G6
	5WAHsULVhbWnRRCF2wjBxepWFT9yJcN3n/EjvQsYljDLMnn0EOlqktzhA/g0XqDqboXaONmSZVm
	xJ3p7uFoPTohNuEET7U4RvlRlDnR4QbbnUHHIfybrA
X-Gm-Gg: ASbGnctyUM1zzn/VDALBFPVwRlvGajesnbZS2XQwx78ttmgYdXiGE/RM03s+JKYC2ev
	0yz3e/HlluOKBTU2hvxBcoWufyn2zrcHZO4BDcHJYonKo+Eu5xBGEOQI8yMwZ4PttFrFDiqwt6d
	6p4BxTnu9PsdbFUBBMFkOOsg==
X-Received: by 2002:a05:6122:46a7:b0:54a:a874:6e4e with SMTP id 71dfb90a1353d-54bcb11e0c6mr1653508e0c.8.1758708304791;
        Wed, 24 Sep 2025 03:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPptVrEMQd0wcOTvVhc2Oe3+W+CQLov4+tsA34aiA7Aw3gYYXeQI2LOHtMUYKKnuN1qYBzcewy7H1XCDRJWDE=
X-Received: by 2002:a05:6122:46a7:b0:54a:a874:6e4e with SMTP id
 71dfb90a1353d-54bcb11e0c6mr1653503e0c.8.1758708304461; Wed, 24 Sep 2025
 03:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
 <aNGQ66CD9F82BFP-@infradead.org> <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
 <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org> <CAGWkznGv3jwTLW2nkBds9NrUeNQ1GHK=2kijDotH=DN762PyEQ@mail.gmail.com>
In-Reply-To: <CAGWkznGv3jwTLW2nkBds9NrUeNQ1GHK=2kijDotH=DN762PyEQ@mail.gmail.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 24 Sep 2025 18:04:52 +0800
X-Gm-Features: AS18NWAzS4ovR9ej7R-yAyhG3XtRFr7Vvnznyh6lks2oABccTIKfG0VXhGRlpdg
Message-ID: <CAFj5m9K4yv4wkX2bhXSOf141dY9O96WdNfjMMYXCOoyM_Fdndg@mail.gmail.com>
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>, 
	Christoph Hellwig <hch@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com, 
	Minchan Kim <minchan@kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:13=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> loop google kernel team. When active_depth of the cgroupv2 is set to
> 3, the loop device's request I2C will be affected by schedule latency
> which is introduced by huge numbers of kworker thread corresponding to
> blkcg for each. What's your opinion on this RFC patch?

There are some issues on this RFC patch:

- current->plug can't be touched by driver, cause there can be request
from other devices

- you can't sleep in loop_queue_rq()

The following patchset should address your issue, and I can rebase & resend
if no one objects.

https://lore.kernel.org/linux-block/20250322012617.354222-1-ming.lei@redhat=
.com/

Thanks,


>
> On Wed, Sep 24, 2025 at 12:30=E2=80=AFAM Bart Van Assche <bvanassche@acm.=
org> wrote:
> >
> > On 9/22/25 8:50 PM, Zhaoyang Huang wrote:
> > > Yes, we have tried to solve this case from the above perspective. As
> > > to the scheduler, packing small tasks to one core(Big core in ARM)
> > > instead of spreading them is desired for power-saving reasons. To the
> > > number of kworker threads, it is upon current design which will creat=
e
> > > new work for each blkcg. According to ANDROID's current approach, eac=
h
> > > PID takes one cgroup and correspondingly a kworker thread which
> > > actually induces this scenario.
> >
> > More cgroups means more overhead from cgroup-internal tasks, e.g.
> > accumulating statistics. How about requesting to the Android core team
> > to review the approach of associating one cgroup with each PID? I'm
> > wondering whether the approach of one cgroup per aggregate profile
> > (SCHED_SP_BACKGROUND, SCHED_SP_FOREGROUND, ...) would work.
> >
> > Thanks,
> >
> > Bart.
>


