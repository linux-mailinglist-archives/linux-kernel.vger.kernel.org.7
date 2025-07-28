Return-Path: <linux-kernel+bounces-747403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90067B1336D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0700B3B3EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E671A5BBC;
	Mon, 28 Jul 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzM4DO7Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794E207DF7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673404; cv=none; b=NcVh/KNqo+5Z6igbn43ANCiXSr4sV9tJLcvnkYpSRr72EnSuo2gHU06kCLU7deSDu8Pi9OJzXpNGTau5/L5tWMENIxr8Y1QzfwH+zU6HfPpS4G7eR6uCuaUAAGbMz6dUzUsimh3Zu481KVVGmc3Bg3GwTyKBRzUvTyAn70L7H0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673404; c=relaxed/simple;
	bh=7DYuxYq5iQMVGICDY2QMi9y65NM/F8ac6MLxH71EyBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsRIPVYvPyk9CsoTw52DXkDzxc3NqVNgBQGvLp/wYtnlvNt7lO56N2sX8Ede3SMEQwccVHz49bpr+2qQUtV5mNK6OvcU3/rVUBBA9EccI4A/lSd1rF4uZwbXyg6OFyJ5KS9k3XEXHF6mPzWY47vBIA73rcIdiW8JpOhSNCb+VRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzM4DO7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753673402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C83Mxg+jc4W7tLsg6CC1/bE+dKhpk6vxsSd0/8fHDfw=;
	b=OzM4DO7ZvOaHAqmluEdx4l6+QV0+rZZe3owFFiHGX8v3tsMdJ5QNq21VLQ0Z1a2EnYoKNG
	mIbjEMGggXIMOLd6UPx8lhwC9dbyqoHyFig4d8l6S7aGzMQ/yELvRLFSNwvoLzdvHessv3
	WcLqODHtt5gh4ulaAd6Mbe6erdYIFXg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Qec4CVnDNwujx-9cjH80Zw-1; Sun, 27 Jul 2025 23:30:00 -0400
X-MC-Unique: Qec4CVnDNwujx-9cjH80Zw-1
X-Mimecast-MFC-AGG-ID: Qec4CVnDNwujx-9cjH80Zw_1753673399
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2356ce55d33so65411725ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 20:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753673399; x=1754278199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C83Mxg+jc4W7tLsg6CC1/bE+dKhpk6vxsSd0/8fHDfw=;
        b=Nnvgv7JSd9rcZv98gIVT9KPKPJFWcDMiXqCLiYosr9UJ6tdTLDRm4CM/n32pseTnnF
         qZkI0cRmOew7KCfu8P9Z6G6G145YslK6P+1aZjUsRS2XK9JR3/g5wYxcF7MWcFKbaXo3
         Ltu5SXkT/0aAxxnTdJzlbKpVjwDgXiG9JvWxcUZEAcG5/ZSiB1FtQUyHKMOQIxSzeO35
         DOUxA+YHX5KmHBG13/fUy84lYsBWDkLW/oD0vTYU5uaX0z4lTL2/ATAukG/F0sXNLgo7
         WZfBitPE79IYWdJgxTzfR/OeNUNz93FTHYXOcyTtatEjfadTbJiqMngoBcxpCDDySd8/
         IWaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWRnHNYtgGnNnNx40MiMWGAlZ1hO8coXgN5t/BGsyB3BnA3DIN6VGKPimn4/H+kM6eyxYc58x1n7JjRUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6a/bM4xzCnvjFiiXXX4qBmxpTuYR90lTrmTTCrJoMpiv6dF63
	TQUtqFslu0tas9okW5MaH8naFgsyqqxa813V9fmoatkTrRgmd3B515C361n0ofdtPZC38pPpm5E
	qqURsVWGWtMnyfcxSDYa+zpU8G4/27AChoEXWkDoGky0weYrHASS0e1zdL78Img974XU0/Jn0UV
	kmU/e2WkVpgwbwPjEmANMMrNvRNYaJiL8mjlRKTl2+
X-Gm-Gg: ASbGnct02Jy2+czfqic7MAYzYFiaJhSUVwikorn6nkQyWtzlYGt8cEuEcTW9kgCUkdw
	1zakxZgGD5IJYOmIS/TIWxgw0hvNtnOVp1lLiwzDZU10guwilZ9GB3uERPEWE4ORXunnwgG4e68
	1gxH5ZKxb5UE1UVLLy8Lw=
X-Received: by 2002:a17:902:ebcd:b0:240:1f25:d443 with SMTP id d9443c01a7336-2401f25d6e2mr30560055ad.30.1753673399585;
        Sun, 27 Jul 2025 20:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDm/Gzir3BF/7ZYp0sKNtVBOwnJLz6VbOmMMiqGZKAeWWWfopLvjf9zqkYWO77SQsKbsCM/eGVmPDAVdqAVuE=
X-Received: by 2002:a17:902:ebcd:b0:240:1f25:d443 with SMTP id
 d9443c01a7336-2401f25d6e2mr30559885ad.30.1753673399191; Sun, 27 Jul 2025
 20:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725083635.73355-1-jasowang@redhat.com> <20250725091129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250725091129-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 11:29:47 +0800
X-Gm-Features: Ac12FXzBKfRjj1zeWsbUaDLspQ0PjkB3AfDBNjrF97VpxVGJeQKTp10kHWMIYgw
Message-ID: <CACGkMEu2Dq6MWM9D4AgUMXWe-evhmN5pMGjWeW84Yzj5MBXK4g@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix uninitialized used value
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"kernelci . org bot" <bot@kernelci.org>, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 9:12=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 25, 2025 at 04:36:35PM +0800, Jason Wang wrote:
> > Buildbot reports uninitialized used:
> >
> > drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is
> > uninitialized when used here [-Werror,-Wuninitialized]
> >  2113 |                 BAD_RING(vq, "id %u out of range\n", id);
> >       |                                                      ^~
> > drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable
> > 'id' to silence this warning
> >  2077 |         u16 last_used, id, last_used_idx;
> >       |                          ^
> >       |                           =3D 0
> > 1 error generated.
> >
> > Fixing this by use last_used instead and drop the complete unused
> > variable id.
> >
> > Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kernelci.org bot <bot@kernelci.org>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> I squashed but I think you should respin.
> also noticed a couple of minor issues.
>

I think a reppin of this patch should be sufficient.

I can post a new version.

Thanks


