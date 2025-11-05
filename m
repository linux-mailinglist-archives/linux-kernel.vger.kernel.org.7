Return-Path: <linux-kernel+bounces-886675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26239C36499
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2966C626511
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0A32E155;
	Wed,  5 Nov 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeecVev+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+VhSKs5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F322172C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355287; cv=none; b=am8XXe6NqtX0ca6UVgVqrwQavLyND+rJt++yuprtOIHf/zzDB9vVcNLCQpLHsrf4cTn66B4tG5JITEZ1bCsywZ5VgZKuba4GwWlyaCh7liEgG1Mv5jXm4df0ys/ejKRvfu3wnY3glATOLJpmCQeGBMVBbZm/Ie3i6IYzjiQ0jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355287; c=relaxed/simple;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRw9ttR7+cORvWsmTDPjtte+1c/f3/DFkNXsp6Jo+4tnY8xFuG3hy69Dp2OflJ4MP0KflT9aeUFTMb/BwNdFF06g827kmalWTWyXPiUeItoVNfmUjgbz3LyZHaiPJEMaQ7pXIDvOhgmnignsTpWp6HnlXyZ0FvhC7znNulMtV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeecVev+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+VhSKs5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762355285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
	b=PeecVev+3s9fakJdP3mprGvod2Kw5Qd0zUzoQD5ST0EAJX2kY/qNI/NRPS/6Mx48nXXcv6
	Nur9n98KtT4mMzDyQjeZ/zo1AwFKn5sfR+fTuJVVl3VEwU2UQf5dQDrvsDTPIKv0s4UH8l
	sNz8QcMACGVegVviN+ubmEbD2vkjl64=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-eq8ULoHON_m06P9HXOnxSg-1; Wed, 05 Nov 2025 10:08:03 -0500
X-MC-Unique: eq8ULoHON_m06P9HXOnxSg-1
X-Mimecast-MFC-AGG-ID: eq8ULoHON_m06P9HXOnxSg_1762355282
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70be4f20deso291061166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762355282; x=1762960082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
        b=E+VhSKs5SJh45HFSv2dfh4byTipz3JBUuXq2cmafniGyY1LOU2Y/5Hfm2O+5q6xElQ
         MpZ8hXEgAx+hKxFiItQqf2EPRWpLqZ/KDhWPjnBl8ShEqGkyqusem0EJx+Ke0SrKROPT
         dZaVWrN/J+oxW+dDGB/UpEvjBQ9I+GeNZIaXON4wEsVEVUbrKCtkQtQPI4jcUhvXhGJw
         eCCOSId/EcvAbpl5TEhLVby2jDhtpub7Xd49lH9pc4D8L7IUoIlmfaGgxU055bot6ltl
         ybDsIFwnRZdgWIzVYuKp0Ve8jQqtAp1PqyFLnvrq7cbuGA7PsmemCOhyckjgsbERpVAK
         TQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355282; x=1762960082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zddzhOg8X1nKlNluFiKuPj0/7ElZvDoM9lEwBP40PIo=;
        b=V6P8fNNP2qgbVf1fegAdZI0jNxo4+NVm1iV/5Bm8HrZqU5UExIwbyjosOnn/onX7of
         MXQcyVdjS6Fjf88KGjm+iIBy5MVtrPi9skBnJXYkNfi1ZZDy/a8zEaFsM26TUqkfDdTL
         0rgiRTg+NszMc4Y4k/QYMuMeVL6ooemp7DbkFeP0T/92TS4FXs0hra97KSaaTtL/4vVb
         qPzAOd8qcogSMHKb06da+5oUVN/AwvJ00+3VONEFuEF38oYfY3qDbZdxIPurJO31oHdF
         QuDULPKD6X0qC5F2MXL4cUMaHlPtlXnXryj/PyuoGMXEp0yWipVnan4zT239XcOMo5qi
         5Iqw==
X-Forwarded-Encrypted: i=1; AJvYcCVd33+EL2/2Zn4TReigCoKSh5S5USV2ig3wTCJfqYz58tLUzOVP3qaePlqAoHAKHfDra2wDc+npzHlry0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTqEDKmt3Wke3ruSHPgckhhqZFu9yJy3EFyEwYTw5jk/KtH6O
	GG1gm/6fSrMN9v6r16ksDfBObNLFlO+oOOwPf0llOFDX5RE3WG6ejWIKEizqLgtRSJoG4c/cgOu
	GN4Qb9YqF9HKigh6Jk7LoTCyYdacGSQGGv0Qosxy9Mio4Jw3X3XYZAGIkFgVjlLyEWbumSu5BvC
	YqCydc5rHFaOevUqUzDjfD1+I1C4q5vsgZprK9Sf+e
X-Gm-Gg: ASbGncs1dqfQX8QBaNcupPwsAhZ8ZCUzEjFT4rGegi7XPMciQ6alQ9mA3FyBchHEyZ7
	sUAo917d0k/YIzGewA6C3N/fiOpOnaEhYGylhKZ+waxXM4r9MZqmSE2SA5+ZFvqpOxfLfG5tdzR
	fX1Nsw9ZC3ni1pjipVt50m4f1bwYpM4eNtuYbU4M3BCHtzheQX3qRCh9+5
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id a640c23a62f3a-b7265568be1mr330079866b.50.1762355282309;
        Wed, 05 Nov 2025 07:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVOQsjYVyVVrNvkq8akL5ZkGRlDA5wjcsUyQMOyzqYmrxUAS+dfw/oU0IlQDgyfAtyrlbYChyW3M7kMF0tLDI=
X-Received: by 2002:a17:906:9c83:b0:b70:b3e8:a35e with SMTP id
 a640c23a62f3a-b7265568be1mr330075866b.50.1762355281900; Wed, 05 Nov 2025
 07:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
 <1762149401.6256416-7-xuanzhuo@linux.alibaba.com> <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
 <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 23:07:25 +0800
X-Gm-Features: AWmQ_bn6PCV_WZmKEJ3xHMkBMOhvHDcRetwwHLmBCefOcZy0CYLo96d-gGmw7e8
Message-ID: <CAPpAL=xDpqCT9M6AWHTfNuai=3ih-452sW4g43gduiw7TptToQ@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:19=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> Hi Lei,
>
> On Wed, Nov 5, 2025 at 12:56=E2=80=AFAM Lei Yang <leiyang@redhat.com> wro=
te:
> >
> > Tested this patch with virtio-net regression tests, everything works fi=
ne.
>
Hi Jason

> I saw you mentioned various tests on virtio_net multiple times. Could
> you share your tools with me, I wonder? AFAIK, the stability of such
> benchmarks is not usually static, so I'm interested.

My test cases are based on an internal test framework, so I can not
share it with you. Thank you for your understanding :). But I think I
can share with you my usual test scenarios: ping, file transfer
stress, netperf stress, migrate, hotplug/unplug as regression tests.

Thanks
Lei
>
> Thanks,
> Jason
>


