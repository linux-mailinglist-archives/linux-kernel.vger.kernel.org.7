Return-Path: <linux-kernel+bounces-775874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B3AB2C5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AB3560206
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1F340D90;
	Tue, 19 Aug 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhPovRKN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB23043D5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610900; cv=none; b=W9NF7Z44vXq9Ma2Of+xposiYkKx2c5Wn8u22qHifu4V91ms73XhCECqjHZ2higG5ILL6gl1YN6m1iwg78k1fhp4+WWsrBR7Fs4rBdsiA4g9LOft31MXyZsGvzjFFM6YWR4DOvXRv6zRIT6G1UoDmNTJF53Qsx5dlWLMejjWWe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610900; c=relaxed/simple;
	bh=45kfBlIx/c2YzCpopNGEzgYrDpvm5CQrUb7RS9hYw5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH7WuvYIPjkZs5R3k+LtPaBL0FhCv5LUTPvfaXwgmubcBfri4HCpiTsT8tuz1PmFqJiFmWWqAhRBL0fkVb16x2S+xKH5SqrtK70m3bKc6FHAAEnQnP0DekYkQdJXectUGYT3Z1J4U6wuCZfh9rno0zd3e2YEHy2vsZY3Tv/OKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhPovRKN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755610898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EujI76cBsDT4aJDRz+24Ho6Ic52R+N90rhwAuXHewjk=;
	b=YhPovRKNSrQmryEvitQjG3wz6ohNrwzCvbJuTIoRnrZ+VnGabiQF9ILlRxA2k4ZTjGHJuH
	1MYQaeNYgQzFSCpdz4eyy64w7CWAnlAogqQwQgBc2sY0NRNUjXJMvFvX9txgEO8adg7I2v
	sg9FHuJxELfQYKxfpgHeFhkaaQHY2Is=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-H6mwhTeaOnq6DrMX34o9Ww-1; Tue, 19 Aug 2025 09:41:35 -0400
X-MC-Unique: H6mwhTeaOnq6DrMX34o9Ww-1
X-Mimecast-MFC-AGG-ID: H6mwhTeaOnq6DrMX34o9Ww_1755610894
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afcb62cffd4so493424166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610894; x=1756215694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EujI76cBsDT4aJDRz+24Ho6Ic52R+N90rhwAuXHewjk=;
        b=kjMw5M5IzxuulMWXfebhzdJCf+lVc8fk1Zh2LLxiTYn349HySRTZbtG+i6Sw7zrsgy
         uLpNMFhsCCdRJW5h94zi9c/c4hGI4ib+0sI0BpgfnJ4XrNZM/udSfRsTrQh43s7uWoxZ
         RL9cKE+1AUbBcu6/InW08F27FnJ+WUKXR4fnqqFgQgbTqknMFvsA1l3rzl78lqHWY8TL
         jBJ3Qzzyz31tbC7ahkSPvA87dUgp3jrH/g6e71tAc/h4MZ5y/dGBws6QWqICA/Yj1tdo
         jnImgO1jRwBYjQvU1Jr1w3/rheqopCm3Hga0OV4/kfWC1pw2VBGZstj0vKWkROjaG/uN
         bS7w==
X-Forwarded-Encrypted: i=1; AJvYcCUY4rIZy558s+8m1LABqk/EfWhD+0RMJ+yYfO9FM4XRUiKqhLERJm3fpWjYZrzjfU1LB6IM7Bhy51YO+rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKV1XAS97XuwE45vcF8Ljg6gYyHV0t7zSnxRJ14OcT3MeFmMl0
	9lTXmZJ84X6o+N4jBCjyXoUpr4aq/EiAz5rwZTyUQcCDH17CFjopjbIY748xwv532HKZbDivZjW
	LQFRVVmGneKFBzvzex5joOvR1zEikl6d2qwrHnd3I1DSopDJWKGZC3AHY6tAK/+RhNSXVDeTFO1
	vgj3ctnA3irRwVZkw1vuDmImQK6dtsHWXWWz2JDV8z
X-Gm-Gg: ASbGncuVfHihVD5w8KWNfIIbOOcKnixtV7xekX/wgfyYUG1KuJ9MP+kgD6NAlHJha2G
	/aZS7yLQsg+BzzmaS5ZJHOn1+rkeNxPvaDFOiHUTxgfZLMcnEXQluRJvSwffQcHcBh6XuJtrVNE
	mm19O28ZctMjUDCmB6+MA5Cw==
X-Received: by 2002:a17:906:164f:b0:afd:eb4f:d5cc with SMTP id a640c23a62f3a-afdeb4fe8d9mr16482066b.31.1755610894100;
        Tue, 19 Aug 2025 06:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1GVsEmsaG7XrNaXe8wonzWZoX3xXdB8eON+UVwMeu7PAq8S6nacljTSpJPy0fGiNqSMsvj1L05aVdNrtBjig=
X-Received: by 2002:a17:906:164f:b0:afd:eb4f:d5cc with SMTP id
 a640c23a62f3a-afdeb4fe8d9mr16478566b.31.1755610893561; Tue, 19 Aug 2025
 06:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
 <20250819063958.833770-1-namhyung@kernel.org> <20250819072216-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250819072216-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 19 Aug 2025 21:40:57 +0800
X-Gm-Features: Ac12FXwPH4sSIUdUFp_9NFkFDCQTsp7XMFuiZKn4U01cioGDSa8UFneCp5B5QWs
Message-ID: <CAPpAL=xm9sgU=8b4TTYSMBYkdmgxmdx4PXFPGwYe3qkqcCh=3w@mail.gmail.com>
Subject: Re: [PATCH] vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Tue, Aug 19, 2025 at 7:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Aug 18, 2025 at 11:39:57PM -0700, Namhyung Kim wrote:
> > The VHOST_[GS]ET_FEATURES_ARRAY ioctl already took 0x83 and it would
> > result in a build error when the vhost uapi header is used for perf too=
l
> > build like below.
> >
> >   In file included from trace/beauty/ioctl.c:93:
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: I=
n function =E2=80=98ioctl__scnprintf_vhost_virtio_cmd=E2=80=99:
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36=
:18: error: initialized field overwritten [-Werror=3Doverride-init]
> >      36 |         [0x83] =3D "SET_FORK_FROM_OWNER",
> >         |                  ^~~~~~~~~~~~~~~~~~~~~
> >   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36=
:18: note: (near initialization for =E2=80=98vhost_virtio_ioctl_cmds[131]=
=E2=80=99)
> >
> > Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode s=
election")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Applied, thanks a lot!
>
> > ---
> >  include/uapi/linux/vhost.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index 283348b64af9ac59..c57674a6aa0dbbea 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -260,7 +260,7 @@
> >   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
> >   *   - Vhost will create vhost workers as kernel threads.
> >   */
> > -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
> >
> >  /**
> >   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhos=
t device.
> > @@ -268,6 +268,6 @@
> >   *
> >   * @return: An 8-bit value indicating the current thread mode.
> >   */
> > -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> > +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
> >
> >  #endif
> > --
> > 2.51.0.rc1.167.g924127e9c0-goog
>
>


