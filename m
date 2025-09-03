Return-Path: <linux-kernel+bounces-797656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B336B412FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EE11B637A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8458A2C3757;
	Wed,  3 Sep 2025 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U5kYNxCd"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A032F740
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756870378; cv=none; b=q0EpcreCbbWQDUZROnsgxiP8Qsnhv4dTbqW+4kw+y1ioH8dyztR70JEcOMx+RmT17vOEa+wj7b29CglHDNzt/8F1IU+6x/3206ZBsfphsfCVAsXfLWoMNU+jTQdolfNneIo2pHx/OKEr96UaJRFRUQLELjOVETc3HXkjbOIeOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756870378; c=relaxed/simple;
	bh=+FiSYvmYX05jcdCQoxpgi0laSBKLf5me+yHBNrNMd80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYRzEwceN4THct1hll2+7XK5DWwFnhb/xkC1pb2UfyHgvBLm9nYhYZo8Qh7d7AqnMaj3kQKSibOjSCukZT7zkuEtOgkVEsrJPJtl9P1ePc7wCxMiEtihcb8PewhgJqt1LlEJULwYM06xd6PhnA397k+IseYAcFfoURB4PJWenc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U5kYNxCd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b132bd90dso3141175ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756870376; x=1757475176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FiSYvmYX05jcdCQoxpgi0laSBKLf5me+yHBNrNMd80=;
        b=U5kYNxCdDgLW/4WC9Qequz+YtzHGrYMFwk6yRzLwGSCS+GP5fS52HcT9cs8XRKtU7y
         Mls42sI999RcUn9QGhAzJj+bQsObDfFshjvp11C2//yAEnFJ7wcmAQHPH3myhbRNC48B
         J6wqU6OkpX8eYozH93Z1c+azictMLvXYSl1aKGeNcg4L7/lgVNC5/vYOLHaRsoXYEg+I
         YMYZFmQugmj/9pfxEo2txEXN49dveb+81h3KUozTRuwTk4gJnoTl7EeejrjiWBSXhGHH
         AEouRGvdpRZ7P4ojAoovCD9DpuFxh4e+tDNl96o1o4wDoHYAxZQiKqMz1Pk+11KTB+mq
         /EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756870376; x=1757475176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FiSYvmYX05jcdCQoxpgi0laSBKLf5me+yHBNrNMd80=;
        b=pWdXtsZztPDAcB7myqP1ZL1tByk2+a8ffxemKHMoalW/8G+lxgJrx7mOKD96QQGZQa
         QjkFOgYdfEne900vZY/MD3gRSnYr8RCtRR1ZCqSSPVlYvtZWpWF1EYW9vqI08wjLJqUu
         V16sQISLvxZpgpRQIXbuVGHbrAeVqowb8csUaPYuw3Y1mDK8Vre2fcRDQMFrimiZXHib
         GUX6fQkiKOSJQd0n1krYlC3vkvd/9fKdxrBcCD6y1FdUn/x1Ks6baSSgwz+UsAN0WnNZ
         HxV9vNH6fYAqQoNRntwrjx9upLcFhfRI81uhi34EFajoHT5VtOeoz7OGK7tg7kzUhOxF
         rL7w==
X-Forwarded-Encrypted: i=1; AJvYcCVDd9ZpU52uoHgvVIuha9Hey/kxZpw+uUAb22JQH6G9gxTkm1kME3MA9podhRQvYYOL540UxGfKS+8Erhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGahGY0sj8jvqSC52yQLMP+nDaPiWMurKLE4sAX/H8T9pLRFRq
	nY7nSSYiIXnWY003il+Y9Lbtortlb0TBt18ST4z+dR6La2KZpM6/eZTLsOxlwgh7sd6V++0eyxa
	7C3NjQE3Zxu8MzRDaFaInMiRjRdbW2zmTDdOlM87hYQ==
X-Gm-Gg: ASbGncunRU0ntldCFc144T1zIw0N1pfbBECWS0ztvsmC3Uiihzq8CE1etm+nByK15ja
	Ez3mAeW72U8SmDEGz+9yGdWHSdj3nNleY1q949zKZiCvxPQqLSCbS6XWlX1UT+4cCV51dd0ZTvS
	Q70N3D+nGPx8IXBfKJQD9yn2EqgPJLimAWefjzpUaiu2fDJv2aLsbCk5mqw8OQmNjO8FVz1I0nI
	N07nUdXTCTB
X-Google-Smtp-Source: AGHT+IHR1oLlpsMfamy/liFpzWMH0CrAwaJxhyoxyjBDWiy/oTKaMWBpnGwzYkUjOo07Y3tRAhd7jt34bwMer7Nzvt8=
X-Received: by 2002:a17:90b:1d0b:b0:327:c9bb:be51 with SMTP id
 98e67ed59e1d1-327f5b3edbemr11696646a91.1.1756870375719; Tue, 02 Sep 2025
 20:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902215144.1925256-1-csander@purestorage.com> <28b5e071-70f2-4f46-86af-11879be0f2a4@kernel.dk>
In-Reply-To: <28b5e071-70f2-4f46-86af-11879be0f2a4@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Sep 2025 20:32:43 -0700
X-Gm-Features: Ac12FXxmY0nLz9R5Q2PmLsvzfZAyrh0ZNb4MhXtgtaoo8VQjT-NyWG78r4sD0xE
Message-ID: <CADUfDZrpJuq7QH47XTBvCFsENm88WQGX2YYnEPHat_UD6nLC=A@mail.gmail.com>
Subject: Re: [PATCH] io_uring: remove WRITE_ONCE() in io_uring_create()
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:20=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/2/25 3:51 PM, Caleb Sander Mateos wrote:
> > There's no need to use WRITE_ONCE() to set ctx->submitter_task in
> > io_uring_create() since no other thread can access the io_ring_ctx unti=
l
> > a file descriptor is associated with it. So use a normal assignment
> > instead of WRITE_ONCE().
>
> Would probably warrant a code comment to that effect, as just reading
> the code would be slightly confusing after this.

Could you elaborate on why you find it confusing? I wouldn't expect to
see WRITE_ONCE() or any other atomic operation used when initializing
memory prior to it being made accessible from other threads. It looks
like commit 8579538c89e3 ("io_uring/msg_ring: fix remote queue to
disabled ring") added the WRITE_ONCE() both here and in
io_register_enable_rings(). But it's only needed in
io_register_enable_rings(), where the io_ring_ctx already has an
associated file descriptor and may be accessed concurrently from
multiple threads.

Thanks,
Caleb

