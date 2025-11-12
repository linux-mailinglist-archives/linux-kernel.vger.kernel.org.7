Return-Path: <linux-kernel+bounces-897017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44DC51D38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1953C3A718B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2321309DC6;
	Wed, 12 Nov 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfFtztmy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ouS84kuU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0453054C1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944897; cv=none; b=ky2TcOO6hkB2iG4DmQZrl1j9UyVjXIVza8NQ3CRGKnBHnF+T5Nfvy9FE4UkH9ffb2opqslIyi3KHVOF5k21TBjm0bvyR41wGV15VQi+Gc4N6mxBT3mQkNe4fiVM2KyFyhucUfjLFtIUAIIWmW/S1s/lwsvUkvMEeOjNh2nVJh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944897; c=relaxed/simple;
	bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jt0C9QLBdLZ52OIa2iZuwmyjAoIy+nOa3K1Mfiqjh+P3fskEfBKLohCAQomanF2jDTzoGIGoIpfebJsbuzG8LSvnQvkyawtTrKRBb/CQ60vEIVLXuBMZIxCpY/vQ2KvG9gH1QOL4kkcPyGBZBJa7axuChNxRetCp/AUbP2uXN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfFtztmy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ouS84kuU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762944894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
	b=bfFtztmytfdE6x5j0yYJYxs6YUPIDZcj+5WogYYuG8w5+0GeptZHB27x6HRjN9m6YitI2U
	Z0ieIQ4sqY9RLpo4L/LtoFje9/BurODfu9ZvH0u/gxYQQK+OUOj47guZeRP6Kh82zMXoQU
	8sWwscCmHLX59MsmhWGBsY6lc2ZmJX8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-Krmh_i8UMJedMIOepGbhvA-1; Wed, 12 Nov 2025 05:54:53 -0500
X-MC-Unique: Krmh_i8UMJedMIOepGbhvA-1
X-Mimecast-MFC-AGG-ID: Krmh_i8UMJedMIOepGbhvA_1762944892
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6409c803b1aso672263a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762944892; x=1763549692; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
        b=ouS84kuUOqxjVYqyd2JOu0jUlGc5vfFvzdwstviQTaLYhw8J2jsATzKrk4pQlzj+nz
         3SDInp1Oyl2KGpOUK3UAKQDS4CqC1hD0Bc2Fc17OGlOhabo+kx6fxQB8HYLWhtqD80wd
         YQtI3xqBfZ2Pab0LH9IUp5O5fmI/DngbV2UaT03XJBDCgNXG5Rb6PDN6A3WhDr1u6BqA
         +xgfr1jlmmfDnceNpGwq6Y0uuZnXPHdksJro8mgAzxx1AW5BvgdAQem08bJa6Nm3HoJH
         8iwWQwf5Qbq21J84bzKqHSMvYttTQdqOGB2HI+xTkP7MnKlrGNPpL4x3Vea60WT4cPXO
         1Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944892; x=1763549692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
        b=SywZn6l6GzXD7VEpwwPMTrtugyp281/wVGgb8qykNeImqqD7stBHtzOQUiugGGo4X0
         AUckbm2TfVPaR84CY7jv6W4b/5UI0D3iFJ0BTu2IOBz3Cx1wCG+s5nUyM7tTXMQOf+ju
         L/FygqGtyHCr7++uc2wTZACktee3yqbQVlwqG7ItaBjbihnnPagmq7CouGbCBiK3PlcS
         KBW8Ib7n0SdmJM+e3EFoN5w0mLh1Vtak2oaBI+Am8Af5nZrMsaxcTx8QEVIYnM5WHSpK
         wdOk8DzhRJU6udC+xOgOir9y89K9s4bzL7yKj6AdiMApmJcOKOfGo1kbGfD9i+QXDlyM
         05QQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ogyQjrZf14tCb37mS3gmV89+4zKO43iskCYz0q6V/R+lHrPdTTVf8/oLwoHgoTxhuAZ3igvg1XjR9X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BRNW7t9u2sRq+2UdyN0wDWXFPdVsZP67lYttFnw7jhwTd0mo
	dEBnRO5AaIG0HlZZ7ShnEpOPT/zfITFzhzBcYUXrJ9ReXlhsBgPapI8HvVN8FD8q1+wUG+wMwbL
	wO46NZiIBd+WQkP8WeS/3xg1uKrc5zQQruPi9dCDzBduadmk9DCbPhvYgk/l2J/KWXg==
X-Gm-Gg: ASbGncsayCeUbRzYZrWu5AWajwR8WWD001WuLFiBaBRTYt4NPJ1oDdgLHGZYUIzQhn+
	Hdf0IQkXLWgd4AQHoPb90R5KUAzfIkPk4aG6296zRyYq/VksRe0SJYWWBnJupxpjgNr9d1fbAYh
	mTF8IXCT1stHOFi0tC6McY+Rb6wsnsnomjt7gqjIu8k5RGi3ooX0ATlQlpcNcnbwqUKwWvnOVpA
	5QH8M5eAA9paquT/zTU4H9apqI+9zysxiOIvbmFYI34+79Y+/zvnyDchSN2yiVutkk8pC2r8cWW
	a52YCNu9QcT47PjwRqxgt7YL3v8jffh0n7Urgunr+qgUvhNo/354rmczAvOYM/KrFzeTJobKzPL
	XZzATRofcKBs/sJw8UxQ4GJQ=
X-Received: by 2002:a05:6402:2689:b0:640:e75a:f95d with SMTP id 4fb4d7f45d1cf-6431a4ca1c7mr2289572a12.15.1762944891867;
        Wed, 12 Nov 2025 02:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6zPMnNj6//iJFyS3LCsJH7VDDk53FJ+jsm5ERoxaP9Mj04HNN3IWqXw7M8jI38CxB8FzfIA==
X-Received: by 2002:a05:6402:2689:b0:640:e75a:f95d with SMTP id 4fb4d7f45d1cf-6431a4ca1c7mr2289545a12.15.1762944891443;
        Wed, 12 Nov 2025 02:54:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578d4sm15715451a12.18.2025.11.12.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:54:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 00886329685; Wed, 12 Nov 2025 11:54:49 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, William Tu
 <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
 <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
In-Reply-To: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Nov 2025 11:54:49 +0100
Message-ID: <874iqzldvq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tariq Toukan <tariqt@nvidia.com> writes:

> Hi,
>
> This series significantly improves the latency of channel configuration
> operations, like interface up (create channels), interface down (destroy
> channels), and channels reconfiguration (create new set, destroy old
> one).

On the topic of improving ifup/ifdown times, I noticed at some point
that mlx5 will call synchronize_net() once for every queue when they are
deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
that to amortise the sync latency over the full interface bringdown? :)

-Toke


