Return-Path: <linux-kernel+bounces-864761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9571BFB7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32AEE505FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D3328621;
	Wed, 22 Oct 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvK2+WOc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFE30CDB6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130456; cv=none; b=TuTfe72PsoUpSwv7hJHBrdQS1YcluZTOY/x8oW3SkWxGak5sUT9Dfu86t6sBgvmnSOC9IwXENXUFF9olEKaoefHIaHzfZ47s4OigGPZq/bi/wav6PjurwQHhV8vXZYX34VN86b1AEPEazi40nt9CrMi9pvZQgUHJY5tgHnGP8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130456; c=relaxed/simple;
	bh=yAme9gZz0jsPec+TiumN1DBQ0+B9qNdo1HlM5nTPaxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsfNzeV+Hek34JvFzFvs5V3lUbYr88uIUt3d+4fFMwgjAFRZbXNByrHSZxCt2nJji1tsbhiC9Pw/kLrvX+oUb31oT0bJcDz+6dzTvuTzQfI30c9nmFLImkpkX6+zsS5Fj9ZV6mAy9Z78xJiVw4La/KPG8rXICnVSO8hgzd9z+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvK2+WOc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761130453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAme9gZz0jsPec+TiumN1DBQ0+B9qNdo1HlM5nTPaxM=;
	b=DvK2+WOcsvBH3W+uPssJvwJqnahdFI8dnJym0MBVAL5na9ZZs5lgfSyJX126eGPbnoIoEI
	Z1HLmz170l9DiQ6iyEwdHibdHaVEKVVppSpzOsoBDKxdTDNZrvlcux44g25X4jVX+ony5g
	T3uOgOBg+3H7sABud0Wj+9ZZHpffGJU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-x00l2-dWNEKmXW9ljphlYA-1; Wed, 22 Oct 2025 06:54:12 -0400
X-MC-Unique: x00l2-dWNEKmXW9ljphlYA-1
X-Mimecast-MFC-AGG-ID: x00l2-dWNEKmXW9ljphlYA_1761130451
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-63c41bc2d58so6222255a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130450; x=1761735250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAme9gZz0jsPec+TiumN1DBQ0+B9qNdo1HlM5nTPaxM=;
        b=wETdlB4YClRjHVimuDjcrJmTXH/TOI80yY3Vjl0/dsZgFN2RQAkBWaLsOJawS1LAor
         hTqR8AmNF8PADm90QpYULyMCSY7RD2nSNZxXXJsbRcC/0nfWIcqR0F+LyrR3fVKWX1wL
         qi+BJCXasIaqs41bQgpGnBMEpzZnTm7Rr7j7eTjM6zVG+8DpI9Vgmvd1wfe4+ybK8sbp
         RM3+YQeKgKqihGvmOX7sNwLtMAQ3XyeubBlTIm/qoBOvrEi0xADlWxbxe3cVfGfIMdw2
         5xXeR/BPbI6e2XBgedOK+EVosuNjtlYh34pr//V9Kbw14vxow6qc9rQiMq4Kygn0AhvY
         Yotg==
X-Forwarded-Encrypted: i=1; AJvYcCWGPUEdGqOtDVquY8wIXu57dOIEiDYtaOxJSIm7+ZWjhpBq9NDuSyiYT2zN7REWf3iS/J9r9HwoJN9ew9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LSln8YIo0cb4jyt9V6JxYFcbnYNsa5vrQ9RdfvhDgnTd0QZL
	kSio1I4iZwY1CHhD6IIN2PfMsu42isUQetZq6EhTrpXXL7Rn2e9NCBES7ib0O+7LziXR6MfsNSO
	/0EoOa/OZ4667hNZMrZicE8H9dU3rbOWqcVFgRMcTYRQxQ7NCp/zKZYrDOhCC2vySKJYGYYQzei
	DwYg8cpTO3uAa7UbbVuEb9UXs9UtTMtalPmqwc4nGNduE8WLj0kek=
X-Gm-Gg: ASbGncvTIhcT7fhRmJTBc2I35l2VQFlq1MxLflq88vHIkX7ty4fxuNZnl79fF63UDlr
	NC2jAtfTDsOsULL9w97f48CyA23Br3GgVZzwpsHXV9EoHhcj6o/MNH2W5JGoBhC72CCTLMDHDOV
	EcAcfbitlZsqOoaJqaM2CsGBBFebO0XGt0mzqmZW5nuysqVvgKECV1ppGFGQ==
X-Received: by 2002:a05:6402:3554:b0:63c:4d42:993d with SMTP id 4fb4d7f45d1cf-63c4d429b92mr14924955a12.31.1761130450608;
        Wed, 22 Oct 2025 03:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwXo2Nnikbm4tEQdmgmkZp9TZORUaZ7NSsb6jc2EYon1wJHlulaxXg07EbqzbJhz2+0tqMwSZX80MVwHLznqQ=
X-Received: by 2002:a05:6402:3554:b0:63c:4d42:993d with SMTP id
 4fb4d7f45d1cf-63c4d429b92mr14924933a12.31.1761130450205; Wed, 22 Oct 2025
 03:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013193028.89570-1-mrout@redhat.com> <20251014053608.pwlnexeh7mwjrvsc@lcpd911>
 <fdac8d84f266ba85d517542bdad0592bdc33b95d.camel@redhat.com> <CAJZ5v0iLCcCpiBqgQM=GcEAnQvZxgbtMy+bWGrWDQEikYOgC=Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLCcCpiBqgQM=GcEAnQvZxgbtMy+bWGrWDQEikYOgC=Q@mail.gmail.com>
From: Malaya Kumar Rout <mrout@redhat.com>
Date: Wed, 22 Oct 2025 16:23:58 +0530
X-Gm-Features: AS18NWDcKkqLf4WGgRCf3VkZNzrXzmQMf2fm-cuEeYgk3yjR7d7XbHLUsCk1kdU
Message-ID: <CADD9qegh88p3gBWbAhV02ScWR7GOc9Tby6QQouLFAzN7ceozDw@mail.gmail.com>
Subject: Re: [PATCH] PM: console: Fix memory allocation error handling in pm_vt_switch_required()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org, 
	malayarout91@gmail.com, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 6:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Oct 14, 2025 at 6:54=E2=80=AFPM Lyude Paul <lyude@redhat.com> wro=
te:
> >
> > On Tue, 2025-10-14 at 11:06 +0530, Dhruva Gole wrote:
> > > Btw you can't include a R-by tag in the very first revision of the
> > > patch. This needs to come from Lyude on a public mailing list and onl=
y
> > > then can it be picked up.
> >
> > JFYI - I don't know how consistent this is across subsystems. I do usua=
lly
> > post my R-bys on mailing lists, but it's not unheard of/unusual for fol=
ks to
> > pass R-bs through means other then mailing lists (like IRC).
>
> IMV, they should be on a public record.
>
> > Regardless, happy to post it again:
> >
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> Patch applied as 6.19 material, thanks!
>
Thanks for applying, much appreciated!


