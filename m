Return-Path: <linux-kernel+bounces-835966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA8FBA8760
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81B71C0607
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434F27E1A1;
	Mon, 29 Sep 2025 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OD8P2Gev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549526B77B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136006; cv=none; b=mkH3Lgq33TXjm5cQHrQ2fkUeZV0A341zPP0wAsSo415nSYwBNxnH+nQArrMkf/69/Ur4prQyDXkNdwdKlaRhj+AbLaGBBwuaI5kajv/czZTMvnsKNy1/kC1AMmsPy0Nu3eOwPVDzYALoi/ZuUqzp3H0gX+4CEER9M7Jjg5nligg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136006; c=relaxed/simple;
	bh=HGTbeMywhbLPU/0YJZUQd3UYalFRytSBWqDIdd4eL/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzNtTgo2bekC796N2Braw25ef9cVuWRK1gEQuUalB2oCRpDayZmPop0IyHcTWx02eGMDwyComdfaZyVdHQEgT9lFywSVPrnh03hnqte5nkpyFbc6X9/eQbHzYsW9lepVsVD3Fp5AICe7lWA/VZtHeaqyV1IFj4yEwXsHdjGATII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OD8P2Gev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759136003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egsBklLkwFUqVScoVF40Gy+uR3v3jO6xWI74ZIXf8ac=;
	b=OD8P2GevTEJ56ZZcDmmqt1PgYecDjtUxeCNMKkGa4T8gLL5Xh3obymqhaopShAOqRk3kbl
	TIN0SJMdkxYsoQPIHNnOO++PxBxe4Mkbju1uBN1cp5aKtIRNFhAQAo5BYAiPfaU62Q2P82
	KwerZnjB7txy22kcIPeE13aiftFt0aE=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-cdU2OhQfPX-qhzI9rt0vnQ-1; Mon, 29 Sep 2025 04:53:22 -0400
X-MC-Unique: cdU2OhQfPX-qhzI9rt0vnQ-1
X-Mimecast-MFC-AGG-ID: cdU2OhQfPX-qhzI9rt0vnQ_1759136001
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-6352c8b74fcso5183202d50.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136001; x=1759740801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egsBklLkwFUqVScoVF40Gy+uR3v3jO6xWI74ZIXf8ac=;
        b=ZD9/ctoeFbEeXlW1SzMLuyzcih/7p4xXXzoHm1N5bht5a6hjFLAJ/ztwJMH6uawl1n
         mBusZ2nWPJKShF/vEXCmz2oDZegw6N3nuxa1ewmRg249EMW+B3RanYJsh4lv0waF5XUx
         X0gDGME5q3hlsSTQdGZWn8yteFiiS0nY/eAGeg/YN+Bu04jsQGLpEDFH5X7f2WmJcmds
         skCBXJ75ufpS5GfaqEkkyh9Tqz4Xkc6vvgtfzXnfdoDbMdLGns0TZEAMxGbNg1liyBN4
         zfqsAtJfW/0ruGICaySHZclVWWxGSBHe2QCZkqSDvQT8itmvsOzDEOP3hvqbZz+4aNr7
         AWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0tU169+9qoATuwv1wOTwNloBSIzjAFpgUgQwt0KrE9Uw4toBf55XAV+sxsn3/uYD1j4uce5h8cdKydLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqQaxobHueI1FHqx7ezHFn+bluMZWFpCnqmKphsBBCijE84wh
	Qtz3024WAiOYdjmjZcoS5L3ykWWR81nGYcxsepSJHOdnICVZZp+LVWhD967D/THHhP/KvI6JXTG
	ETh0MctUwm3qNaX/3418DKcOvv+VjEXcyr86wz7C+3q0AtIwfVA7YR3WRgxKEcwdXVYMLxCfZd6
	jDa3d3aCoSnkpyrj20qjVJDUXZGqSa2ZdylzVjNj0q
X-Gm-Gg: ASbGncvN6zL7Ly9yjU5KdkQcLdq6f6LFvgOQ6TMHhcISjsJasCWJWFabIQIB78ASJxC
	6OSexst1CLn39dqpE4BeGiwMpDEQWsj1N7t+ae5PxtXh6fivAMFm73MC9CE2aF6ETA1aDP5Fggh
	Ca9WqQXSQKMINDeSe0f2pArxYlMARfUEgXf3ZSvSIo/ao9KITmpX8299XN60GE7Q8A+VjdxQvx4
	XriZKIv
X-Received: by 2002:a05:690e:4195:b0:62c:eefb:dd79 with SMTP id 956f58d0204a3-6361a857ecdmr14524416d50.34.1759136001568;
        Mon, 29 Sep 2025 01:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECrTqBudBkSeJ3N8SX/hVo0kjWu9UUTo1pONH+icCLFs7YdIq9GweSI0ieFvne7zbnLxqB/d/leEOjjasuYtI=
X-Received: by 2002:a05:690e:4195:b0:62c:eefb:dd79 with SMTP id
 956f58d0204a3-6361a857ecdmr14524395d50.34.1759136001255; Mon, 29 Sep 2025
 01:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926112622-mutt-send-email-mst@kernel.org> <CAJaqyWdeA5xcozCsaYD3_bQ6riN1pdDGHLpMGjU7ejZmNZ4qig@mail.gmail.com>
 <20250929035510-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250929035510-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 10:52:45 +0200
X-Gm-Features: AS18NWDxfZ0r4W4VshBoL1ZD7Teu0Ou_adE4zYLCpMWTZRl0EHPUYTx5fV8Hib4
Message-ID: <CAJaqyWdQkJgUKqne0_ivLTpQ3rD9tfzcEZL26o5ZdcQsjrJL_g@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:55=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Sep 29, 2025 at 07:55:59AM +0200, Eugenio Perez Martin wrote:
> > On Fri, Sep 26, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio P=C3=A9rez wrote:
> > > > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_=
config *config,
> > > >       dev->device_features =3D config->features;
> > > >       dev->device_id =3D config->device_id;
> > > >       dev->vendor_id =3D config->vendor_id;
> > > > +     dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups=
;
> > >
> > > Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?
> > >
> >
> > The macro for v0 is called VDUSE_API_VERSION, so I think it is less
> > intuitive to put:
> > dev->api_version =3D=3D VDUSE_API_VERSION
> >
> > But I'm ok with the change if you want.
>
> Confused. You mean "more intuitive"?
>

Ok think I misread your comment,

I find

(dev->api_version < 1) ? ...

more intuitive than

(dev->api_version =3D=3D VDUSE_API_VERSION) ? ...

But now I think you meant

(dev->api_version < VDUSE_API_VERSION_1) ? ...

Is that right?


