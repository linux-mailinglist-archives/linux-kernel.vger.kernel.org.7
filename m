Return-Path: <linux-kernel+bounces-878184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CFC1FF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83304E9190
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601D62D5C97;
	Thu, 30 Oct 2025 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IKeyBXMA"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3F2D6409
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826730; cv=none; b=PgoqjOEGflgibMZEgN9i8JW4FrA3pYLzoZN2YV3/P8BsoVIyxbOtKRDl8W6rx0t58+qYFsuMn5F87FNzd24h4lmIUT1AF4igIrF2o5l51vjTvt+n6QiTm71qUHLTS6dsCoUh7eNzQdaBKteVWQRaN96YEglLtZNL1v/guY7udMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826730; c=relaxed/simple;
	bh=wnhbQmh4ahC8PKdCzcYNoFOto08zipbrJDQpVkPseTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ6zLjots2+yXMPVb7KAgJTE/30d+N3LLuNZ+6b4qJ7W3gBb9H17w6q/BS4JXl733LLPD2VX8P4BzN49wk6OucZbkRDGQ9JPZc4ZXr3lEC+1LyuOC6cYOkI7awCg+GQJYNsFTKPcFIbGsZiSJA6mhZ6YGww2CYqMoo6RYalo7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IKeyBXMA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3402942e79cso1369215a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761826728; x=1762431528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV3Wyms5GctmoxFgrHuylYNeXPRM7QEqyLlsa9U1RVE=;
        b=IKeyBXMANtoC2kDVWMWzblpfbBCCKWAtm5X3/oeXJT3LQe/ZK20nfjoC/RFWAXsRML
         L/DuDwrB7bC5m/J1FlN9I6dVfskzy6xJXnZsZaAQYUuWiFEqwRrom2jfyx+p5qEsvXAt
         mHe9VfSiID6WhiCx1DBab/uQL9UCo54Cl6U9XfOsHEfx+soCGWOfoO81v4An3HRaDYan
         3Y/vq1LZ1qZLl+zcVzkUa74WpefYc6SPdrhbzzjlEIgPFDq0LOTJEkHL/VyPfJIrBnZv
         +yEGoJxh4wFSbSXLUihOkTRNqNAM9c3rmYwj4BQ/ieWeF5SiMqcx8XJ60RyeeZgXFHF1
         KlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826728; x=1762431528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV3Wyms5GctmoxFgrHuylYNeXPRM7QEqyLlsa9U1RVE=;
        b=wzZjz3dAkRpTBFEkjzrHudLl6uHY3lvDZSa9Ucgr9OTJknZNUoZnQYiYLNt0q5RUeO
         SzxuawccIBn30U4iuMSSAIgtLSf875tHeSWPKGYKEXmq+exZIHRWz1nC9mnZxu3gNYV9
         WbV18RxkO7KkugN9XR+ZBNZf0axA6X3bvn0yyz7flFYc9EpfO2Q7yEftUWiR6GH3vjOI
         qS4rxKUusZIKTbc11M7zzkec17Q6w+AGGannNeHhHL+iGcK1lJzA7DzxJ+yBRDm704R5
         3pWxKI/L6cY3+tInAJlNjClJuZ9QfYNIqftb9+KT2vboln8Y+5b6+9P3EjZneWQKAEDw
         okdw==
X-Forwarded-Encrypted: i=1; AJvYcCWUVoWu2n0Be6UN97DNEASEo4cbckaCCAoxLi7ndMXU07DBDCGzDjbOwJsg+CI2WTdqcxdWudaOjGcTQIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+VOdtiCOtMeg1YZSi3/4joIQ8P+wOLoz3op0Y6lnZY8TuOmo
	A0qb0zxWCf2FoW9fy8NHOTkwonxOJ5zxLVFotN0oAebXyuvZYIQH3Qi8mRL6k8h3ZyKELggQL7e
	LaS8MEilmElLuagx9FuWUIL4Xwq1v687atOLm8MPJ
X-Gm-Gg: ASbGncskEaEi/sUtqrPtOptu00yxGMvAoYpggckAcjxfBL+LTCNtc2FfvTLUlvF8SXZ
	KFqikjm+4HP3oAZFd3TbdmjgVcW19XB63RsL7kRFM1bUQLTCcBwPVbRRLHX4/Yc7TkcedGVSEnP
	cU/EVZMnpZUQ2iG9ejG+2pp9aeQ4VYYiiPVJmitjCdhbjKJAymKwFVfoVg1qMjeChhgPxfvKPxS
	Uv4RtME4Keja/ZBmT4ls0/g/HQ9saSt2G2oVdYJ9uvZpBADLyH5H2XEbklMRCHwwsgZbp5VLRV9
	nDN9nEs=
X-Google-Smtp-Source: AGHT+IEAOTMFK3D5taJ3KPSJjji4K5xecEJyo6FAdbfI1bayrytkxTVqsVBKlawrgvajLnMKq8BLOieel/imjS8/7jA=
X-Received: by 2002:a17:90b:1c87:b0:33f:ee05:56e7 with SMTP id
 98e67ed59e1d1-3404c404985mr3892931a91.16.1761826727860; Thu, 30 Oct 2025
 05:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-3-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-3-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 30 Oct 2025 20:18:36 +0800
X-Gm-Features: AWmQ_bmiKDcTTVrpLtfWQHLoVOAgkHmCC4dbaQET0qDlzDFIGwHDaLhNbSek-Lo
Message-ID: <CACycT3tUQuQLgxE1-++izeKZLbdzKWUt9a5ukRW52HCjm3V1ZQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This allows separate the different virtqueues in groups that shares the
> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
>
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
>
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

