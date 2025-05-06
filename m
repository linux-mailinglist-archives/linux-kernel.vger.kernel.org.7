Return-Path: <linux-kernel+bounces-635640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D415AAC044
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 11:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D59189A503
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEF26A08A;
	Tue,  6 May 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5Z4txiE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498424E4A1
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524794; cv=none; b=WhTgIn46cffGbkXbfMaTI6AQ4dv2lkD6jf7gF4wOEgbBNQBx++zi7eIoCFRtYfVj2ZCZFE/jWLSVyfe9KgdeEfxScU4h/D44enS3j7L08bsFwIyVIQodekQaPc4foGRc+EBgXgyNR5shecOj+JmjxjALJveZFyH6Hk8rzJ2YaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524794; c=relaxed/simple;
	bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMM++kx8uAaogxkjoqmUtNTlHiAEM16qXeQq4un9u0CUwXQcG8bAR/8sglyO/2ZHxHt3f+OWACQ0sF9ftqiT4LmeUhtCay5sSaUTNuuxcg/aOdyriKqykcnonjaY212f+BETVt3JWusrTTHR9AfYlHfRQGapsDuAUkqej4NWGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5Z4txiE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
	b=Q5Z4txiE6zU5A1wtsG9LwyaJI9hrpzNCXjlw0QmLvRdaIaA0lmHLUW6v0JvR6xGUnjkQOq
	VvvR9EbW2pKx/FBROOAEkpcXzH6Cx1PPCg/Lln452ifcO+0Rv+D7cv78hlPOac5yghEieC
	WLGJHsg/swCtoc3hXYd42ZUhlpO1fCY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-rmWMbRlxO8y2ftzwWymDhA-1; Tue, 06 May 2025 05:46:30 -0400
X-MC-Unique: rmWMbRlxO8y2ftzwWymDhA-1
X-Mimecast-MFC-AGG-ID: rmWMbRlxO8y2ftzwWymDhA_1746524789
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7082e59b9b6so79697677b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 02:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524789; x=1747129589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
        b=xT0hMB6PaB9Pr7AJJdXOEix+9hHqOEbKTIyTn+DhEcs/hMDapsprGl9naD+/g1po+q
         mwhpuD36eW8JVFXbKoL8bUtFlcea9V9/+Dq2f2cczTOP/lpZXOWHuVCBLMUjXIOdHNnM
         Sbv3Ip/bY3icnsx/LgQCABL3RTzqLY1Ru/0zxetGfrQfb2A/aC/40CbPB+8weqi/fX55
         usSjLypwPKplwiwjq0v+/hPYU47A5peBOx6sn1+1yLrFzsAzmmTZOyDXjwDUJfrHwPDX
         uDPOMB6Apeuf511qSavApkSL2wtM0Yi2L/q35TXbaRRkId08Gxay1DZQNwaLXzw95jj4
         lL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkF6q1BGtzXHWqCtLrmFZldrb7j5rizEioqxCM4NPkZvxXIVclD3j3tp+DZM1sL4TIRA7rPgdHKmWWPys=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywykecuu5B4mPG8kyS0QvnUZKP7oPJWxVbKwl/oyl4ucMV7ubj3
	OqUNPoCv6Vj3wB4VsgjW26XuY9qpYD9NT3olEB/+Z/MswraYDuH2Wd/a62CH3E316y0XKHK2Ye3
	CxXJHUaByr0i9p7pX2yRzYn1U7HWh++QtIR+R+8USH7NWWxgdFPoo1fglh5+AtrWBTicdSkpixN
	6T+uiSlFMxH7Wc5hsXmryKkRiaFt+vR25WLIHb
X-Gm-Gg: ASbGncvCcSm7ZRqdbTF3AOrrrtnFUEMMlNDtn4mbvsEuxEF7Dxnk8IJP32IJkGzeGSv
	k5jU/mGq34oEUQ8QG7hG0DXCATET0JOmbFfVQUYY3fyrH9CCgkG7gNlf+2MwP8241rvUlBjQ=
X-Received: by 2002:a05:690c:881:b0:708:b7c4:89d9 with SMTP id 00721157ae682-708eaed228dmr161341777b3.11.1746524789548;
        Tue, 06 May 2025 02:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SnKlOiGYxAIgFjpIz/3a6Amq4RJJRae2tHMUWHhFAEAWBZQzJ97jvAOQKqp6vtJokq7tr543XXcIaZE89NQ=
X-Received: by 2002:a05:690c:881:b0:708:b7c4:89d9 with SMTP id
 00721157ae682-708eaed228dmr161341627b3.11.1746524789214; Tue, 06 May 2025
 02:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co> <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
In-Reply-To: <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 6 May 2025 11:46:17 +0200
X-Gm-Features: ATxdqUGB2JgQGBx1SBATpWkN34LfUWNEz6bg2h7UGX2v3-s9HEuTp1ypMzGQ-9I
Message-ID: <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
> >There was an issue with SO_LINGER: instead of blocking until all queued
> >messages for the socket have been successfully sent (or the linger timeout
> >has been reached), close() would block until packets were handled by the
> >peer.
>
> This is a new behaviour that only new kernels will follow, so I think
> it is better to add a new test instead of extending a pre-existing test
> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
>
> The old test should continue to check the null-ptr-deref also for old
> kernels, while the new test will check the new behaviour, so we can skip
> the new test while testing an old kernel.

I also saw that we don't have any test to verify that actually the
lingering is working, should we add it since we are touching it?

Thanks,
Stefano


