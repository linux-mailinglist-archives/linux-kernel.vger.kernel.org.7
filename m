Return-Path: <linux-kernel+bounces-886085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35EC34ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5431921546
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7732F99B3;
	Wed,  5 Nov 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vrf7ZwwJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNsFrfgV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6202EFDAF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333410; cv=none; b=sG2Q65MiMDhit4CQZgnPIX6hFW1YMbWTrBbaUUFxkv2TNiZqWcgbREEWV3VmUBUIH2u62x6uNM/Hf3So3FgcxIK6uhdBdjZEQ3eFTSJEql/p0d5KNdfyksnIiujadbaljOyx9fk5DUCUi/65bz/OQlVTBuj6pP/geWvlXjOas6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333410; c=relaxed/simple;
	bh=7Zg7klTggaE2eo70HRPP2YBG1uUkbzJOxLKYewFYTmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuJekBcVNqO7cNDtGLo0JakFe05Ppodeodo6StatptBIW93S2FNWF+I+nyaMVUPjEuqZldlkeMm9ZMaqud7GTpKyRLKJaci351hcn1dsj5xMhvIANzZA1ttZzpjoi6T3FmthE4Z2L2OixrdW6r2AdMW15ghlXwU2I4kShZdu1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vrf7ZwwJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNsFrfgV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762333407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Zg7klTggaE2eo70HRPP2YBG1uUkbzJOxLKYewFYTmk=;
	b=Vrf7ZwwJcR+HrE9jAoDVRBqpDFJ79sUmA8hytsl8eB6anbSesWKuXC5LlE/AR3fzEvMTWZ
	p6JVYZOeunD+/eP5n7JQttCRaRa0GfQ2DzWfpzpoZ0jxG9fO8EA5ItpgsyjwS0VtugKE3Q
	0OCpcyUfA7wItTifIAeiDqYM8pcZTkg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-00g3IarAPna6Z0RoGIJdTg-1; Wed, 05 Nov 2025 04:03:26 -0500
X-MC-Unique: 00g3IarAPna6Z0RoGIJdTg-1
X-Mimecast-MFC-AGG-ID: 00g3IarAPna6Z0RoGIJdTg_1762333406
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71e7181cddeso115571157b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762333405; x=1762938205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zg7klTggaE2eo70HRPP2YBG1uUkbzJOxLKYewFYTmk=;
        b=YNsFrfgVxvONMAq/+Bv07r7dNnaAuZLNfI1F6n/GrzDETKLUXjjDIgxiJyMK08Dof0
         4D5R9DBPZikV4Ez7U1UlWDdCHZ5fDzRE26RKaJpQXJxi69Yie22loHRfcbd1b03XiFJn
         6+3UgS02UxkQW1A3qQO0Ai0AvxyNYoDsmQqgUy37Xmqk9s2KK/OaVt6U+9CbR6x5KjvB
         N8flCYsu4ch8sI/cuM+pCapvnFb2Af0QMQ4jiopWdGLbWEVQhSL8G47EuSDk9XWQCrlL
         mEmWJvwLp4eRluHSTn0BDlf2OZfy42h6mIwo00jQz8DwC4O9v2ysmsYqKnKFgysoak6c
         HDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333405; x=1762938205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zg7klTggaE2eo70HRPP2YBG1uUkbzJOxLKYewFYTmk=;
        b=wSHXplzZCfVe3nswHnE4UHu30ZbWR5zzGEfD1UZO3z9IrnODqKiOvvPfvpMpLTtHh5
         cAk7p1t3EZex7WdN7xxkgCP16BLa7hImDqk9CT3X5k0++OcZolMlB+v94D4CfS9kLFb3
         qDmojNy660xqDsMVROfwdCppvQWE3uMAAlkO9G2P54rr4Tq7UGHqQOi+R7/Sgx0uvU+L
         hXCaNkHV8vOzgDCVWibADng6++h4vQ4yesO0FgArfkjj2tpxneiPi4aT7NLkOsvR4eq9
         a7cOUsOENDIUo5EQ8PB3CpYp7tV+ick4OQlzbUpfeR8EZTeeS9i0Wkq6G5OPi+qQy7i0
         n3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVqgJJHdIFwee23lBVvCWB8LSs6kjwTuyiBp0+O0WNx7sY/7NNbrkWjkRRZiClgcUHoyoTgejLid5WCTmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX06L+qkF+91Wqe4LrWHCYElE5wWGVLW2HzSZnCu0NyztMqTty
	/W1f2bssmdF+FJ0FBL7VrJ0XBEep1DUMZIHd8eNFzaLWYv/h4DuL1cc4XN8VgwOyYs2Sye+Q39w
	aiO4g+uBFOMYd44IfUUhVlQHrBcCkGumylyjIoN2CK/PkZ09Nx84/zsBTjGxBObCfMGHFyW4aTO
	rjzcg9522+g7/OrdjLIQqeeq6HIlM2hcl38KokcS/1
X-Gm-Gg: ASbGncswY2wnqy+7VP+qoiP3tN0yjevS9HVysf4Pc5ohgULpihNJvD1jhcGpIIUn9lu
	Ldc+cUJp6pyl8n1P9M4jpOmC3cGJFcY4zK5m+w6jl3DecmkMX5fp1nl7f7Sp6Ft3CaVZgzC1Fwo
	XHcmcF7oRvsQ/snSN6Lj3mqGEeRDRA+ht9LOaGdlCn3qNVFNoo8niDRLVC
X-Received: by 2002:a05:690c:4a83:b0:786:25e9:387c with SMTP id 00721157ae682-786a4122ff7mr20366897b3.20.1762333405590;
        Wed, 05 Nov 2025 01:03:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEilkswvviU63NttoK9MAtDFSXL1klsWKg3ry/D6U8PAbuievzJBvc9ooYm/cnkzdsbMNWKMgQJMe+NxJKm6VE=
X-Received: by 2002:a05:690c:4a83:b0:786:25e9:387c with SMTP id
 00721157ae682-786a4122ff7mr20366677b3.20.1762333405163; Wed, 05 Nov 2025
 01:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
In-Reply-To: <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 5 Nov 2025 10:02:48 +0100
X-Gm-Features: AWmQ_bkDV3_RqhR4tpzBJK2B9JtMwFO734bGByXhsKE9cCp88mfSiZ6NtU5azgc
Message-ID: <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:57=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > Let me switch to MQ as I think it illustrates the point bette=
r.
> > > > > > >
> > > > > > > IIUC the workflow:
> > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAI=
RS_SET 1
> > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > >
> > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at th=
is point,
> > > > > > > so it potentially uses the second rx queue. But, by the stand=
ard:
> > > > > > >
> > > > > > > The device MUST NOT queue packets on receive queues greater t=
han
> > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_=
PAIRS_SET
> > > > > > > command in a used buffer.
> > > > > > >
> > > > > > > So the driver does not expect rx buffers on that queue at all=
. From
> > > > > > > the driver's POV, the device is invalid, and it could mark it=
 as
> > > > > > > broken.
> > > > > >
> > > > > > ok intresting. Note that if userspace processes vqs it should p=
rocess
> > > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > > vacation, let me ponder this a bit.
> > > > > >
> > > > >
> > > > > Sure.
> > > >
> > > > So let me ask you this, how are you going to handle device reset?
> > > > Same issue, it seems to me.
> > > >
> > >
> > > Well my proposal is to mark it as broken so it needs to be reset
> > > manually.
> >
> >
> > Heh but guest assumes after reset device does not poke at guest
> > memory, and will free up and reuse that memory.
> > If userspace still pokes at it -> plus plus ungood.
> >
>
> I don't get this part. Once the device is reset, the device should not
> poke at guest memory (unless it is malicious or similar). Why would it
> do it?

Friendly ping.


