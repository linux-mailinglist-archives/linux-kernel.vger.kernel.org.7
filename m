Return-Path: <linux-kernel+bounces-749577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7CAB1503B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2240C18A1EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F12949E0;
	Tue, 29 Jul 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6Vs0Z5X"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BC293C6C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803373; cv=none; b=aNjJhed8jC/sxSDpOla6Jdc3N4qjxRN2OVQMAlOUH5SBUR6gr/vY7xXjV8Iu4G4ilzGQEV4dU0i8btQCBVxArgYSjym8OkQOv5ekeGpITq5xsm0W/NGHglrejatmsMNPhLhynjEhXGiF+aJbQdS+7xqTvIg+1BBS8nEBuztuVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803373; c=relaxed/simple;
	bh=5wduhGljbre2Yt9oPZs4+A80kEKdKOiR1YUtmgLhiFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNb9MEXb2CX0PQIC6Zh6QWqU9NRtLdfgFHr3ECJeW0hOvwHTKFTzZP5LHJonTU9ZWG0Ums95kQwkhrODKS66hyjYEvYW5t/hTE7uir92zbDRab5lw6sFQFggAxZ0u8a+k/bh2yL2XFgR67U/eseYnKJpK4+FqA6BFZrcO+yWSFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6Vs0Z5X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24070dd87e4so110835ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753803370; x=1754408170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8/hmqbN/GBW8ukvStLSmZmzIq7CbBo8JDmoAI3fxd8=;
        b=f6Vs0Z5XM522dC4uhbix3yv3fQmSrzhZyO19zCjV2LPy1hGNSy+Tq9GubfouTUsWij
         W07eteP/Gx3mNhIs4lhDy01md4tF4zqB7RCKIsVBgU6itXJaXZkrcvyh8uwqaT0Nti2J
         cKfYdmrvjfo6vj6Nn/aKwy5oCceomfLNomlhO9vgqY/m0PTVrgxPpXCLse2m8tIV20hv
         Lqz310QFn+2zi9FhA0hnK/pxXU5apGbFbO1ulGXyeTFAooEJpN+clE/5sbSrrM+GvT/p
         cCobgrGzKC9vMUU9Q4T4f+/AF6SAB/UwP8ANhhOcCN/B88WsAfky3g1KhmRgh2LuLXHN
         GmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753803370; x=1754408170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8/hmqbN/GBW8ukvStLSmZmzIq7CbBo8JDmoAI3fxd8=;
        b=I0hBY3gnCLbObKyE9P8dT/6JfVUa5JNPIxKwfhQEAteBpchCPkC6lVidSnFYp7FCD/
         fhucilPhGM/mWch8HEaa8UbqZMe7knqNykU0Y2sWky7i7Ub3RIXJBc6mBr29p+x44W3D
         of/beYjAj+qfyXH43BgFYsUTybCCRLXm6L9E882o51LzahwaK3yLMyY17EQ4UgYdfiec
         Gst87M/HArStiaxt6x7MjPW1K7yFtyMZynP0FoVR6nb+ZaxhoQRlF/KTQ9kXNC4uhSd+
         2MugvkpA9i9WlaFRHfsTEmhHSBjwTZ8J99jSxybwyt22uDBUP3b0eIVGTwXT0f1PN23x
         fL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8pb1XJ4ZZNljZK1ggN4KTXsViVZZPbc6r9aMXFkFSf7OS2W6Xn/jZ9yjSgGl2RUdb2VdCh+eRXHAR08E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSOvFeJP7yb34hIFovvYV0RvhMG8g1TgC8sYxPo9K8PaRwIqa
	ZOXo6GiUGis4DyPHO/yad3I8v8YlKab6IkBt13ac0NhGa7C327/DcV8HwT70PCvRmjLHdYj3ywm
	ssu+hP9HW45oqFG3v5xEjgx+ZV91CNJRDO8As3DgU
X-Gm-Gg: ASbGnctgKHYfioDPXh4JlVjGCtcmbSXZrrHfx/TiIIQ4IQnAQ6YCXM3Ne15Qs22VRzz
	/bFdl2aMinTC89JDqOvMwfortaf7E328ElchERNqrPc1InFHZALMupzj6jjksT+KcidINsdms+o
	vuCtFJJXEyNDa188ovwWwI6D2CA8ETsUh8CnbQ51Q3V2jseNq4vglDwCjZBojPW7CTxrFlSHvLH
	Fb/IP7w
X-Google-Smtp-Source: AGHT+IGIu+susF+7hiCrTHXE3TP50hiAGrBcGKU+mzfzf3q3nYpspnf34goaWoO824Nb/GlJV8bte55ulYe7nFFO2kk=
X-Received: by 2002:a17:903:1983:b0:23d:eb0f:f49 with SMTP id
 d9443c01a7336-240679824c5mr3546425ad.14.1753803369375; Tue, 29 Jul 2025
 08:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729104158.14975-1-byungchul@sk.com>
In-Reply-To: <20250729104158.14975-1-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 29 Jul 2025 08:35:56 -0700
X-Gm-Features: Ac12FXx68rwygXHJ6QoCP-sZ6Qf0MW3SVGVkhhf8cIue2-rPEB6ie-D_dohd1c8
Message-ID: <CAHS8izPonS7WbDF4BpX=CQ8kFfqjfSnXMsrrS6ivyPQpQqqs7Q@mail.gmail.com>
Subject: Re: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, 
	toke@redhat.com, asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 3:42=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Changes from RFC:
>         1. Optimize the implementation of netmem_to_nmdesc to use less
>            instructions (feedbacked by Pavel)
>
> ---8<---
> From 6a0dbaecbf9a2425afe73565914eaa762c5d15c8 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Tue, 29 Jul 2025 19:34:12 +0900
> Subject: [RFC net-next v2] netmem: replace __netmem_clear_lsb() with netm=
em_to_nmdesc()
>
> Now that we have struct netmem_desc, it'd better access the pp fields
> via struct netmem_desc rather than struct net_iov.
>
> Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
>
> While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> used instead.
>
> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks for cleaning this up. This bit of tech debt was bothering me!

--=20
Thanks,
Mina

