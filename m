Return-Path: <linux-kernel+bounces-705736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9A1AEACEF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 04:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C4F1885CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 02:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A019D093;
	Fri, 27 Jun 2025 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+OpDwJ8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DE19992C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992219; cv=none; b=KJoq1tcAJAxFE5o4RA3XQvgVztxyU0re1eUdjW82zl9FVYJMLyfSrN5rccFYeRTv3LCCq0QdlE4A0TtdpU+u1TAF+iBsBkuhry5FIVgQoGuLib/aPcCJW81RJWjgf162ByMce0UqqZlW8wovoiakZWX9qAJ7ANg0MqDaqAaD7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992219; c=relaxed/simple;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOx9ObmN+oq8e5gjlwtN9rp5O3k11SoLELqTG7YTR77VJ5glNs+0wOc7djs46WLwNYP0eWDr1CnPV+hvk2vIBDi2NDPFcxjZtazVAOJq5kLTBFnXLpgOnr3xYw5FJcTIPPmL3Zu3AsFZ64i5XzH71rvh8Czz9yupdYpx98HMH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+OpDwJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750992215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
	b=f+OpDwJ8InoOr8JvoeuHxbODQk0deDxL8X3f+/xEylGS2Lac9HO8f9BbGjU33L6z2e2caC
	xuJafinTLHXaeLRMu3UTElGML4az6V/ipbfDkmA7sd65FxjVMSKQp4jselapY2+2WG/YmX
	0Vp+fgbZ2FvOrpX9kuXYUrh5J1swJZ8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-niTauyTyP8-W6O2dF97-wA-1; Thu, 26 Jun 2025 22:43:33 -0400
X-MC-Unique: niTauyTyP8-W6O2dF97-wA-1
X-Mimecast-MFC-AGG-ID: niTauyTyP8-W6O2dF97-wA_1750992212
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so1089988a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 19:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750992212; x=1751597012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXC4Rxkam+ZBAOFfCItPQiQAgEwB6Nk3xgueJRX/EL4=;
        b=T4GAcIHPERNE4GzgvQkC/h7asT04dyrwaRQM5TrkRJy5pZiC+nuYIcah7Af+m0OyVx
         jAL4dD5N5cI4hGjl0vz+dIEgFN/g5dMoUCeTzHsDZjw1gdewL0qbLPTnNHwVYcNrLCL+
         CBU82X2gX3Ad/WisSjmx4Lxw0KSzCqoFuGVVkM1iBSSjsAn9ED3tgzOOACWYaWy//6y2
         QIRq+hGBvW9gnD1Feu+EnqZ/FIL3CQKjswIaEdCIDRmReh8vUvX0RegZ/Pz4q8fnfNx0
         boxBewwtHMGadSjHbR35+cNgPCKSqEZ009QTEidjD8klDOtsbkMp0rjgOrqy8F39vRuG
         cqmw==
X-Forwarded-Encrypted: i=1; AJvYcCV6yuB9m3E5h9gogWEKkKTwZ0P06Z6vRBfW4x0E6FmziKlEUuXZgLkAeNC6Gsmut1OyUeG7OhFUH8bh3FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtFYWz83fMipfV7KJXTCBmWeenJ6sGKJgdGQ1haR9cgzm94VP
	0ffMv9OY8vcuGCFh3CMmE27XUyF66fwVnDK4diwHysPM0vfoAnICrgFSsyeolWpI6WO6prbd/ta
	gJl19Hw+63jdB6XZBmuNGxRmMT0YNxAw8juyKgTI+Hg1ifxeDplFADL+h00Hm8Gnq4ZI3tZWtQv
	zSSj+zogn69s6i5g/kDlIkJ1PuyUIecGX/zrJTJxVF
X-Gm-Gg: ASbGnct63fDvqJlTxUoBWzjeg09cFtuRLDdmpL64XLj+2bJerxs7w7kBkC7EZbIyiFk
	DTIU/28Nzt52lEGCjfWwD1Nm/2AjggFdecwKyi6KELWHDukFISg2Q7Z4harvK0IJZdxg0vRzGT+
	lp
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id 98e67ed59e1d1-318c9107a53mr2192669a91.2.1750992212426;
        Thu, 26 Jun 2025 19:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJM16rdnxRskTxwuXyeMZbSoBcs9q4++zM+ywcskISDMXjQ0J0UHxMNSH2KE2x3C2uBazsSFuOebCMbQTd6Tc=
X-Received: by 2002:a17:90a:d64b:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-318c9107a53mr2192640a91.2.1750992212056; Thu, 26 Jun 2025
 19:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-4-minhquangbui99@gmail.com> <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
 <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
In-Reply-To: <8f0927bf-dc2f-4a20-887a-6d8529623dd7@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Jun 2025 10:43:20 +0800
X-Gm-Features: Ac12FXyeaiRss6v-acFo0ljDViofeaY9eNXnTbOP2WE1qi3Xv2JlKX1swLORs6U
Message-ID: <CACGkMEvf18Dmo5Wzdq-GnJf-jOrzKMQ7epZA+ssWPzXvCnCXvw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:38=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 6/26/25 09:38, Jason Wang wrote:
> > On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> Currently, we have repeated code to check the received mergeable buffe=
r's
> >> length with allocated size. This commit creates a helper to do that an=
d
> >> converts current code to use it.
> >>
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > I think it would be better to introduce this as patch 1, so a
> > mergeable XDP path can use that directly.
> >
> > This will have a smaller changeset.
>
> I'm just concerned that it might make backporting the fix harder because
> the fix depends on this refactor and this refactor touches some function
> that may create conflict.

We can make it a single patch that contains:

1) new helper
2) fixes

as long as the changeset meets the requirement of -stable.

Thanks

>
> Thanks,
> Quang Minh.
>


