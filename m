Return-Path: <linux-kernel+bounces-729561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7D0B03869
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C53B3BC854
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6852376FF;
	Mon, 14 Jul 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itboC17W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CF233D7B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479711; cv=none; b=EuTHB1EWwxKT0+lfXKNQER68F6qd3K1dvuWYgevk9vAwr3oMgqbLlI2ImfNaTSFgglSVT8G6BYUfBqsi/RPBduuQNCTVeP0veCG6ZWut7HrTqtsn/TWbeLJ4ELrgsEq6KEYKWg40ezNea7pUbWrRFYnTQ9qJY3zgcUoJmrKiYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479711; c=relaxed/simple;
	bh=tiu2nK+C56Y4UTXeDLT+Tfbmtgme13MZm7oIc8lWWM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfaZ+Dm5PXpK6JzdBEAH2msVxgJNbqIpESPRT4E/+KXEZ5LcCRG7wcfKQDNBz9/qPITn3Y4O3Gd07atyo3LKhEBn4kzd+pgy2xltppDNwLEruEqTziYbol/6moLcuiA1EMSlFrUfsbrYAiGQtscN5AyoPNxcqy7tDy103Dboouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itboC17W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752479707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IvISYJSY/qK2kGKabHvUCxDGnx58jdPHinutempWO4Y=;
	b=itboC17WAaWE6a+4LblQ7Y7SqWyyiWoC2N8cjcimILDqMG94KbNmaupwAl0AOLkJXM1EBl
	9qaoeYTzVeqWDwkjHvwTXaYUZ+qS3MJTw++BlnI5ilF3IDOABA+ukCP/qhXIdV2+qD6I6J
	WrecUucX/MDlCxHiwJVCIR6yAcwv2RU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-eh-WnacUNtqXbnL6clPZgg-1; Mon, 14 Jul 2025 03:55:05 -0400
X-MC-Unique: eh-WnacUNtqXbnL6clPZgg-1
X-Mimecast-MFC-AGG-ID: eh-WnacUNtqXbnL6clPZgg_1752479704
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313f8835f29so6580263a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752479704; x=1753084504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvISYJSY/qK2kGKabHvUCxDGnx58jdPHinutempWO4Y=;
        b=w4VdKQRl3NIyM1yWT/1HqWZVLvOwBfS4L5GgL6p9CkkONewTIdFnBWQyi8xIt8T7bL
         CTPbZFpJWojpkBKWS7iloSV+1tnBpDyke0B0QN7tqKjMiPdUksMR0+bFn4HvClJHkW/F
         XnMdfVW13bnUk4gFvd5Pt300SueM1E9ddz20wql5OwrjwgQ2StXKAcxSM09JkRdxDE0l
         kR/LzJ7ILSgjsuCqIyu3zClIRyHA60dCXsZ/JPph3rq0Yd/yZT1/uZwEhfJfQFdx8TVt
         y9ig9dTX7WwH5CQ9nIphoxCLqMY9jK99LFj4a25jzRVpX+BKc/HYat5Bafy/OPoqcAFb
         KXFg==
X-Forwarded-Encrypted: i=1; AJvYcCVUIm30zg8+s2HmBLHGAHRiQqEAGSLB1NF4S3rBPX/9oWgcNIKlw6u4KzXS7hjevi6vXuLTwrFiOBLGoi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32khdKw58m9VuRbfld6DeJlYGS4aDWbiv6KONDU07/tv1i0mS
	vIi17DmNaYLL9MoSl9qTM/PqAz497k3RfIvQi16kVG+72wsqKfpz89VODHN21b2pbdFOYU3T8PE
	IdudSMUQhT0qRIHJY1P8Do5bKcRm1VmzfkdCb1eAoecfpcwehnjpoexpcKvNCV23h5NNjvAds4S
	1d53mH+PKpQRLlb9W4y/iX4JQ12u3C5c8SNkZM4wN9
X-Gm-Gg: ASbGncvQCCNUbEWbzbZFXDuXUV0PilFRtLZERf7seYEMj8VnmQu/Laj4zmMMTHqesaq
	fHiYDNJ0yT7EZUJ/AeI/fMNKN11h2cgpdC9pLVE+DmHeg0bZ49a888i4QKZKb5dw+k7pbujF6aN
	jhG6cRqkrd6omeiqno3ECT
X-Received: by 2002:a17:90b:1b0c:b0:312:f88d:260b with SMTP id 98e67ed59e1d1-31c4ca8484dmr19569348a91.14.1752479704459;
        Mon, 14 Jul 2025 00:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnet4rC1xgcXEZ20xYgQVBr3JRR5R4FOhA8hV2O705o81pURROYmMQvBTkz/PEie7bN+76RHxpnjO5by0g3h0=
X-Received: by 2002:a17:90b:1b0c:b0:312:f88d:260b with SMTP id
 98e67ed59e1d1-31c4ca8484dmr19569328a91.14.1752479704074; Mon, 14 Jul 2025
 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714071333.59794-1-lulu@redhat.com> <20250714071333.59794-2-lulu@redhat.com>
In-Reply-To: <20250714071333.59794-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Jul 2025 15:54:50 +0800
X-Gm-Features: Ac12FXwOxi5XmIWDjVBorqVT78hYR2jMNPSkm1W_ckD1RqpdpvGkBqoo8WdhIzE
Message-ID: <CACGkMEvZthxg3x=SLQMj5t_dunnuutFm_8ZZiO1MiQdWGqx9Cw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 3:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This patch reintroduces kthread mode for vhost workers and provides
> configuration to select between kthread and task worker.
>
> - Add 'fork_owner' parameter to vhost_dev to let users select kthread
>   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
>
> - Reintroduce kthread mode support:
>   * Bring back the original vhost_worker() implementation,
>     and renamed to vhost_run_work_kthread_list().
>   * Add cgroup support for the kthread
>   * Introduce struct vhost_worker_ops:
>     - Encapsulates create / stop / wake=E2=80=91up callbacks.
>     - vhost_worker_create() selects the proper ops according to
>       inherit_owner.
>
> - Userspace configuration interface:
>   * New IOCTLs:
>       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
>         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHREAD=
)
>       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
>   * Expose module parameter 'fork_from_owner_default' to allow system
>     administrators to configure the default mode for vhost workers
>   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whethe=
r
>     these IOCTLs and the parameter are available
>
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
>
> This partially reverts or improves upon:
>   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray"=
)
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


