Return-Path: <linux-kernel+bounces-862133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6152BF480E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF6F18A2DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F852253B0;
	Tue, 21 Oct 2025 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCqx+NBt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E01F16B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017188; cv=none; b=Y3sfKtp5cwfN34Hn0O7kpFkELA/xmXLZcRbOH4DroFiQs4GqhEjtSiRVuqK/FT4LfIpXKFylou+I+ged/0DAP5oFaa06oNH43zuIm7NDKg24VPiEtFYGmOnkYUBd9H16DZ6J5x+B/jfhN5U+1qPbtqgYOOpOnq9gTql35pXuUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017188; c=relaxed/simple;
	bh=MPF/Ey3TyRjTHTzyJm3pQx5+0XCF+lFgrotF5uwgNQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ta9o71cWCF2VKJIaii2tWRX4wQ/ltvIXcbKL51T7mXpR0N6Uy6f6BfzCaNxnu8vp0IBAQuF9dI3Ym011xwIA5FyffNc7jMiPKDWTcgzTcS49QQTpov8FN6RxeGVpzr8tAYLUgR+vjO8Wxeh8cWJLRB4OjXiKJiGfUj/sHfvKjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCqx+NBt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXOs7k/gBscCMNZg5w7Zfi5dcZ0lMld0rz1Q4bQ9caU=;
	b=MCqx+NBtUsLkOQSa+5Fpujb9vfEp7Ck8JXdE2pgqz5UXwRCABLc/KxS7aTfyqBSeusM5qL
	QZxdSydAZxiLooL7eNzefDvLWuO+ZmM3UNCY7Y23TT4jEArdHcuKrpUTDr3Cp63AFxsw9w
	EZznNa5MYwyUkmthaOFOC1o+YY24vSE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-iERwtyu3Pyqnp1vdzwVtjw-1; Mon, 20 Oct 2025 23:26:23 -0400
X-MC-Unique: iERwtyu3Pyqnp1vdzwVtjw-1
X-Mimecast-MFC-AGG-ID: iERwtyu3Pyqnp1vdzwVtjw_1761017183
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so9267064a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017182; x=1761621982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXOs7k/gBscCMNZg5w7Zfi5dcZ0lMld0rz1Q4bQ9caU=;
        b=nfn1zlVdb2P2TSJfgxjpBDZ36W7bbJg6eFo47MMCrIRhv2vmMUYFxELmn3dvWpjdJ9
         gp/JJyg7t23z1WpJbDYHqijkXqEdHQQAaMto7wVSIZS1aYvElE3wrgpdeySUu41f2xOt
         277mS5d0GfvD4BBXBvdC/Tv2q0Q4uThPjsVwii9oJnO7fi0pAxBgSMwqgZguIEc06IDQ
         QSOxTz7Bz/kW620nJXo0T2849is+oeyoxXt0ykCuiWAch76kZJyDzsus6dXCc4FqAf7+
         HX//CRIStJdjKy7p6xq/UBIL9w+c6ywKTo+EhKGfIvBg+zxHdVDjXGbT8JZwejr2c02K
         AjyA==
X-Forwarded-Encrypted: i=1; AJvYcCXtWV9A+eZJ6AqKF1FUrA7oxtmpTjV4dW2nZaBUKAAm67lz9EKhe/sAvuUwTU6RaYUiIzIRRm4pc6GBcZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5iCw7z5Nq140+Z3CutRw/ZcYh8JTETupWHotRwMbHZz0YQTd
	GBXUX3woNejJGoSVsYnpyCnnjkpq4pjT3qENiyg7dY4hQHradmXOrpuLLZtXD1KIglGwvs4tovw
	s/EbKDKS8qNc2f5dI0NqSGMfUkXJmxGbcnbenJzfVpy6BN0joxEuG0peSuVUuFkk6oadlIIgrEK
	XYMYhHylaf0QfvBqv1bugCC/K17pQ3rTmgHZMFV0eRZWDZyXDSToI=
X-Gm-Gg: ASbGncvkJE4u3ZtAr97pzYbMUgjZ1U4oFWYLaQj44S+OVFJk+39WI/5duB546icOZUS
	FEHLqKG6JdVjJWT8jQZtJeN7FwyNCgxANQk5CoxQS3HhnWyttB6Xdel9Kut9OMUIT0+RKwrQ460
	sOvGx/A4u5swUKTuU8RP7yRZiky6Lz/TU2wGUqiJxBzjES+hT/fv48ep8z
X-Received: by 2002:a17:90b:48c6:b0:330:6edd:9cf with SMTP id 98e67ed59e1d1-33bcf8ec5f7mr20369577a91.22.1761017182171;
        Mon, 20 Oct 2025 20:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkZKjKUosphMmTC5NGxKeaI/AWGeDGAfI2v+IJ7wS3K0M76VQ3znMf34ZJYMevrVYlCwdEGul2tYd9w2byMVk=
X-Received: by 2002:a17:90b:48c6:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-33bcf8ec5f7mr20369545a91.22.1761017181775; Mon, 20 Oct 2025
 20:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-20-jasowang@redhat.com>
 <20251020061049-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020061049-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:26:09 +0800
X-Gm-Features: AS18NWBnOxL87jmSdCbGI7Dz8sxNnbV2200Q0-rpsbUFyxlvS8QgpsrmMmWe02g
Message-ID: <CACGkMEsqqOAS2cZsMr7GptvLbqvnZzHzQeB_amXL0ZmRNBZEsQ@mail.gmail.com>
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> > @@ -168,7 +172,7 @@ struct vring_virtqueue_packed {
> >  struct vring_virtqueue;
> >
> >  struct virtqueue_ops {
> > -     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> > +     int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
> >                  unsigned int total_sg, unsigned int out_sgs,
> >                  unsigned int in_sgs, void *data,
> >                  void *ctx, bool premapped, gfp_t gfp);
>
> BTW this should really be part of 13/19, not here.
>

Right. Fixed.

Thanks

> --
> MST
>


