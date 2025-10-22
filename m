Return-Path: <linux-kernel+bounces-864626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419BBBFB34F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D1D3A3B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD266311958;
	Wed, 22 Oct 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNeiQbXr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E92882BE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126413; cv=none; b=UysuX6rZ6Xgic+UPVhvvm4/WG2MuzttBvnnfbLsenwcai3CSzzp1M2UU6pZlYblQADuj3mtdWP8HbN9t3paA9rfIVLi3+aOmhchqhgvRiuqnmYCpmyqz5kjfpol69psdHM4sjnK1bmW8hDhKbk+1DuytqBbMozz6jffnR1AT8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126413; c=relaxed/simple;
	bh=88E2EGzq2n20YrkFy9dxISpv1QvuEY8V4SnO7qKbctg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLpj37YninRyLHkAalLT2qS6aZ4ZKbP49tJitn9E74gfSVUVjsyfntlq0qvzWBAIcJb4TO4Xna3y25drMtw+Da1Bn/PeUGgymJtDqSkgWeKS2grwICt2PbX+CQcnb8p2SP5c8LleS1+B1p2/H4246AseZteJEK3pENVkI/WoSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNeiQbXr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761126410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipyfXFOy/lX9dgJ8MKg8vYqWY4/Yh7BKK6Ctsb29TBQ=;
	b=RNeiQbXrlLnlyzAMTF+/cL3jWWVqHIWcmpRVQInrSxM62W05Ii+MVjIEIBJ/9/41d9PdOh
	t5VNwme/wt1erddVpJwiAYcQnrqnDg6LCA+FgE9V5pSMM0ohcQ554jsRmZveIlIi1EZPW1
	AKuGPrmjxbLA2D8dlJYsKj4T1sycFSw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7rXjqEoVNYS-GPmVXagMRg-1; Wed, 22 Oct 2025 05:46:47 -0400
X-MC-Unique: 7rXjqEoVNYS-GPmVXagMRg-1
X-Mimecast-MFC-AGG-ID: 7rXjqEoVNYS-GPmVXagMRg_1761126407
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63e0865b082so9214656d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126407; x=1761731207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipyfXFOy/lX9dgJ8MKg8vYqWY4/Yh7BKK6Ctsb29TBQ=;
        b=pbkRY1Rl4D5KcejizhJJdlS/3D8a2XJfTvN7U/Y4lBzPYf+FNvG98LzSS8UTsgteS8
         lLdqVabUv9I9Dy2Rqma5QhFSirjdNlaWG8Nso8tDmQrHAlr5xIdfTgOqdgOW8CKXYKHb
         XCL0wpWJMWDB6OaNUQssOxh3YvxkTnHX6KvTHWxQfW36lhTfDQnAqBPWILy27/drzkI4
         LjsqXTBaWSWOPi7X0tYfAdjT1jbg1qQh7RA7/SRk1jZkLaWSY1GSfMbpKDTRaYD2Tbd3
         cHHK3POSW/LdOvDlWZGx0ZJxg11wACrMOuMfUb1AJrLpcbqMy8HmSawenDs03PowKiuw
         UzuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIlkwC+iReiwDoS38ixBvn9JaQT1Y6oJMN+kTqbCWkQwUEbkArO/7ZSNfrzlSO4tdPkh+HUkyBDh7/Wy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIx4tdgGailE1lx9GK4xhrKJPwRXnUt8CRYwEwomWZgGMAOexI
	7mrIqLIRTvl9Lz5yjOF0Z0VQhxq/t3KpEREFec8LI9ZaSajpI8jJBHnSeGKYhS68szhwVNE/Sep
	bEBUgP8/kNN9Dpu56IQ5wkkmvM29XBqst1RO3OkzsaVKzVV4oMYYMm5hizmHKkyrrioLg4eJNs3
	mhCQuSPx2qreM4erjBQz0bSmsWQtT/bqaDisZ4V81O
X-Gm-Gg: ASbGncvl8Vb3WEh52Nx2EtjB/yqT4K/82FZYB/TMb/qh723TDnlMTMwwkazVKQRYQJu
	gOA3piQrFsCMR1+NvBqrFrLwDde+xX1R8P8rqGvVUA/gQ8qMhM+mPAYhUYyP8AxcXpeyUHDoq0e
	xZeIWe+GSewKgn8UhSJmkVXCXx/leSSbaTiRSYJ1UYuUSQ53xI9iWUE2kpEjiNeDF5zFDVRWeMB
	yEXC/fuDtIxIAKpPHQJlAF8tOeE/gNki/xqav0RtaBRASgpoUjiuervkDmRliVRLwUesViuvkHU
	hHQ=
X-Received: by 2002:a53:b10a:0:b0:63f:2db0:997c with SMTP id 956f58d0204a3-63f2db09c49mr743764d50.68.1761126407104;
        Wed, 22 Oct 2025 02:46:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvur6oK5c8R3K/TCjDX5FSuFjRyp8F3CzZFjcaXGe/kEmJx7VQHl4dG08fr+fgIFPtV66OaqY0dHi5diadPNA=
X-Received: by 2002:a53:b10a:0:b0:63f:2db0:997c with SMTP id
 956f58d0204a3-63f2db09c49mr743754d50.68.1761126406818; Wed, 22 Oct 2025
 02:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org> <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org> <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
 <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
 <20251017023902-mutt-send-email-mst@kernel.org> <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
In-Reply-To: <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Oct 2025 11:46:10 +0200
X-Gm-Features: AS18NWDw4vr0GcTnGRr8VlHsu1oogGDTd7bG2v29nWusnnH3ymm68p-CAB7l3Fo
Message-ID: <CAJaqyWcGbqRP+KfhtOMLtYA_dNB0d0SvTKLrsH7zYU4CrZb+3g@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:21=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Oct 17, 2025 at 8:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Oct 17, 2025 at 08:36:41AM +0200, Eugenio Perez Martin wrote:
> > > On Thu, Oct 16, 2025 at 8:25=E2=80=AFAM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > > > > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > > > > >
> > > > > > > > > > Not exactly bufferize, record.  E.g. we do not need to =
send
> > > > > > > > > > 100 messages to enable/disable promisc mode - together =
they
> > > > > > > > > > have no effect.
> > > > > > > >
> > > > > > > > Note that there's a case that multiple commands need to be =
sent, e.g
> > > > > > > > set rx mode. And assuming not all the commands are the best=
 effort,
> > > > > > > > kernel VDUSE still needs to wait for the usersapce at least=
 for a
> > > > > > > > while.
> > > > > > >
> > > > > > > Not wait, record. Generate 1st command, after userspace consu=
med it -
> > > > > > > generate and send second command and so on.
> > > > > >
> > > > > > Right, that's what I asked in another thread, we still need a t=
imeout
> > > > > > here.
> > > > >
> > > > > we do not need a timeout.
> > > > >
> > > > > > Then I think it would not be too much difference whether it is
> > > > > > VDUSE or CVQ that will fail or break the device. Conceptually, =
VDUSE
> > > > > > can only advertise NEEDS_RESET since it's a device implementati=
on.
> > > > > > VDUSE can not simply break the device as it requires synchroniz=
ation
> > > > > > which is not easy.
> > > > > >
> > > > > > > But for each bit of data, at most one command has to be sent,
> > > > > > > we do not care if guest tweaked rx mode 3 times, we only care=
 about
> > > > > > > the latest state.
> > > > > >
> > > > > > Yes, but I want to know what's best when VDUSE meets userspace =
timeout.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > userspace should manage its own timeouts.
> > > > >
> > > >
> > > > Can we just apply the patch 2/2 of this RFC directly and apply the
> > > > VDUSE CVQ on top then? What are we missing to do it?
> > > >
> > >
> > > Even better, can we just revert commit 56e71885b0349 ("vduse:
> > > Temporarily fail if control queue feature requested") ?
> >
> > No because both would let userspace hang kernels merely by
> > not consuming buffers.
> >
>
> My understanding was that you want to be able to debug qemu with gdb
> from that hang [1].
>
> Could you put an example of the whole chain of events you expect? From
> the moment the driver sends a VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command,
> the VDUSE CVQ Forwards the command to the VDUSE device in the
> userspace, and then the vduse userland device does not reply.
>
> How does the VDUSE CVQ detect that the VDUSE device implemented in
> userland does not reply? What are the next steps from that point of
> the kernel VDUSE module?
>
> Thanks!
>

Friendly ping!


