Return-Path: <linux-kernel+bounces-821620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29FB81C14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679F33B94CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382272DA76F;
	Wed, 17 Sep 2025 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="agoz5p2l"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CB2C21F5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140877; cv=none; b=DidPJwkBvpS02i1oaDFC7647TfSK9aoRLXo5DCU2DJEnOjDsrbFfZd1A7eifa6nK/uoOZ5+I7L4KsrYefroXUI1pscWlVgK9j1BtVluwfg2QDwGoj9QH6FbrM4+E5ANY+b/G/k2hiSJqw+Bk3vPVZwAoaAhmn1NAJoPs/pO6RGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140877; c=relaxed/simple;
	bh=7ftGvN/R/Ps0GPIX85RpurbPLiXS1I3fprN0bjaLYGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC0utrr9Mgrqe3yC1t3VauA4f8ncoSWiHfVXwMnmIQ1WpWJ4WelZ5eqqAyAksKr3+wbC8uBA0wh3TDVRK02kO7cvuid0ZdGrtH54efJIcU7QSsLlzAwb0r1u3v/RFlvotr3DBsOHnfmMfe1UctLO/BQ1iiJktiftfsmgEAcKkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=agoz5p2l; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso307609a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758140874; x=1758745674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4mlHJ7N2GtjpEnD9iNY8gv7p0x+AwcaIWO1wg2Altw=;
        b=agoz5p2lO+XoTPQ7Zg4tde1jUMGrm1CG/PinADYgfLY/uup0E54BFjrUKl179+uZul
         vCZCD5S/b1zLgFYMMl1rZnMR5D92TmfZGfhoOxuHyN19OBKicPHS/vFusG+MbBR8Lctt
         Yb56njz0jtkPxVtWEtG2EErvFTneR1bsyTlXc20Cnw2DlsqqIAUTBTrMPIjze56qtkcD
         gbtx5vRdK2w1k51QBJP6q05jQxhl2Vk5grH0M5RGL5+eJTbQuCstt95+CL9hp/hb8s5V
         aFGUnneQk2rSJIr3YREy+zgPRyg/fceIh0hvup4/HPfUF7gJq4Fu28L2sPa2cEeUNr7B
         BDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140874; x=1758745674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4mlHJ7N2GtjpEnD9iNY8gv7p0x+AwcaIWO1wg2Altw=;
        b=Ltt3CSWc+MjFT3B4qGkWDvGezzXxeoJrnu1cF89pydwZclMJ0u/PAZq5744RcOfds9
         DiY9jw0IHdEW8pgQPJIb8CoeL5BovbWr1ofIdmu4zZOhUPJQ4MpzmgX2lOm8vsUn8P6A
         2uCH0N0njO+pOIqflBEuJdc1mkcLwyCzHVflroKdSAqQ5XlGL7OJhylsdYD+rqCLDrIu
         G0xCUW26vqQlF1Lnhy2mv1Z5C8oC36oG3dBjc/mmlXu753lCkVKAoeJcVyx3UNeef0cP
         HAePbnBEn6+mAep156ZUiiqAtkFcc9CjRUwBWzeL5/oq7yjDpeQrPPcKM9gnBm7RAe7h
         Pg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTj6Yictk+7zP+IQ0V14Tf4RS0ECyWQKjBAfCXXq0nTh7vJkGGJBeLS5mxCmJawvjl3yzXsHoEW6/fVhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbofOA0TIqQKFsUWhrP+T2fwSoSGB7ZDmzQKBu8IgaAE/EuHkc
	jza524P37S/xCAKO/247qB1yJQX/ZbH4r2irrQTZ0eNgCw3odHsEBQrpotK1b6Itr/dywZzUFkR
	4oz4EtCT3W3PdThdynTMo7g9Du1gPhDUxiwQ0p7jIGQ==
X-Gm-Gg: ASbGnctcik60VgYiSG7j/p49hkJHVm2YffS8aWDxx3arpYYa9XofK8csjao5MQEminM
	6ABl7Gx4NYKSg2uj16qsQED7qlzOhJKIvjpRz0PAX4xrpLWxEnEYuQnixqeU86KK/28+o+vkmg0
	sUXzF2g0+DoFQiaefLCRJkmn1HDpvkQvdaQdiqEhNEgAvtdoaHz3fOuF2PQHhcZUoRSdOeneiIc
	QuRa8stnhfbYH2X+nFIFtyGleHWxRFGfxEu8j5qgcF+ENNzVlC9ATU=
X-Google-Smtp-Source: AGHT+IHTHtpXLrzOlNF8ItBS1Dao3rHs8rUuADCH4WTPP8QnLumlzZRuwQZByHIaY7Yr6edfpyVLQ1M4x0U8xNNPnIY=
X-Received: by 2002:a17:907:7b8c:b0:b04:6338:c95a with SMTP id
 a640c23a62f3a-b1bbc5490a6mr373843166b.45.1758140873916; Wed, 17 Sep 2025
 13:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
 <20250917202033.GY39973@ZenIV> <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
In-Reply-To: <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:27:42 +0200
X-Gm-Features: AS18NWD_SzRUSSGY7GiasnnPbKogXv5-_s8RWyt66I7bKnW_Disajb-Bt-pl0Fc
Message-ID: <CAKPOu+8vf5DbR=cJ5dArut=QamTu-EdpJVta_Dsk+dQDpY68UQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:25=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:20=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> >
> > On Wed, Sep 17, 2025 at 03:59:07PM +0200, Max Kellermann wrote:
> >
> > > After advice from Mateusz Guzik, I decided to do the latter.  The
> > > implementation is simple because it piggybacks on the existing
> > > work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
> > > iput() at the end which means we can donate the last reference to it.
> > >
> > > This patch adds ceph_iput_async() and converts lots of iput() calls t=
o
> > > it - at least those that may come through writeback and the messenger=
.
> >
> > What would force those delayed calls through at fs shutdown time?
>
> I was wondering the same a few days ago, but found no code to enforce
> wait for work completion during shutdown

What about flush_fs_workqueues() in fs/ceph/super.c? Is this what
you're looking for, Al?

