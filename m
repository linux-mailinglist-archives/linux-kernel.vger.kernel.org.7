Return-Path: <linux-kernel+bounces-835473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933F0BA73CE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA57177471
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C1223DE7;
	Sun, 28 Sep 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMwja9mw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD52F2E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759072798; cv=none; b=bp9Cr/JWlvcBUQq6VUMKnF4VJA1EOUWcppxNG80Cagx8CgW9K1t3MGMXsgCIom4++C42sX6xATr4GsSk3k+eI0adkwHTKLvls2SLgN3ubXr671NcjwzzTtVm5rEbVMfOBoIBTjKKrPqwGP4+wdHUWCM0AWdK6pSnfi1DRkCWSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759072798; c=relaxed/simple;
	bh=wPDBrdQTCDXm8wWh7L1ZhRK7JSAkxj0PQWsiK8NKfeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkkRbsRMXgPZMlDz5F0OFAvZadmdOHQRLGqWSI/l12MpqviCdi3FQVDZWKNRG1P/lqS2BKpy+6TP68ZIkLdALQSmNlQLBm2TJN91F4rwjofU/fMcXwaif/pvyOTkzES3FOoo8J1oi1GheI8Fo2BI0ZTlh+2CqjL45gYXT7pAdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMwja9mw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759072796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Nj+XJ5XDmLzfECpTepH0pTjok0xdxtN8C8fEmo+ohU=;
	b=bMwja9mwu6XrZypmB0KYpsQUdehHN+82I7Hhc9e3WYaKUvsWi+nMC5uEjlZF7V+sV76lX/
	Hqum9blHh8cP5K1MopG8ZRikguAfgy8nRmm8/6JUAht+ZwYt4ivgCsnOZ8rbG8TrW0AX7V
	bD2iDOXaa29I1tlGldS/1pK6W5BDHM4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-ot4uwpuhOC-SCrb2bXSRyw-1; Sun, 28 Sep 2025 11:19:54 -0400
X-MC-Unique: ot4uwpuhOC-SCrb2bXSRyw-1
X-Mimecast-MFC-AGG-ID: ot4uwpuhOC-SCrb2bXSRyw_1759072793
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b36f970e2abso272790066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759072793; x=1759677593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nj+XJ5XDmLzfECpTepH0pTjok0xdxtN8C8fEmo+ohU=;
        b=d8HxCnosCie92cEgyjqn3I1rLkzU3Shpw0ZzosjRDUaUQFDkEdU1dvWYnSEg5uXmtj
         4csXLwiNZxiOEo2cf0+aTBV5XJgMi5Rb7tJ1mD4/EcwNWk1Q3K8nfFzxGpoIxVDnxb+0
         GkhZwQ6wQB8T/Z8V+b36SY2/690EID5lROCCGNfdI9MH3N9rD8EdMVVK7FQpd1jRrZOQ
         mxv20yp76PNJO3KNMaMKP3NJz77JIKsOQAYKW1V7xI3h4TgKl5Bw6MDzTaYOaQNfal44
         rEiCv03SuyE8TpJRuWdrmoXG/XI53m5lNhdJXAE9BHNRhxuAzTnnLleZQUXtogcou/r1
         lLcQ==
X-Gm-Message-State: AOJu0YxzVi1eM8EJ6ld3+aPdtZwOV9Bo2Nkvkps9nN1OiTiI8LcrfCCf
	rS2igt+dKYhO9IGesZfP4DYw91sQNqFAEInPSgGnsyC7MUCdcxTugVC8UCoNb62xBBvcGTkXfMj
	8dckC6mX8ZkV0XdItwrszk0cOkCYF0rR/n8qPB9z/pwtC11rQYKPIvLcOIoSTXozi/lSgaJ1lkM
	Eq/7Tz9KBub2U9cU3dAYJ3lYnbpgcNhaz3+gKUxW4M
X-Gm-Gg: ASbGnct2Qo3Dy6lx1yD4Sy5WoKW8vKb72i+XiaLVjgSK0ARdjJnWPFeEO9v/dIvVlcV
	pweQP1pv1YjGOvd/MVYG3XlhJAT96lNoROMv+JC43FWutHJBdJrRhUVxdgIZ2an59GrEHkVYhNb
	RoOjbk4QiMkYHJgDvUWcncIg==
X-Received: by 2002:a05:6402:1ed5:b0:634:abb6:8b4b with SMTP id 4fb4d7f45d1cf-634abb68ebdmr11666664a12.22.1759072792997;
        Sun, 28 Sep 2025 08:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEXOWbg90CJJkxha814gD+CuKt+/kXscwr2CNdbjM83qly0+8WAmk2G6QmTyhOM7V3maHx0B6gcYdklWD4E4E=
X-Received: by 2002:a05:6402:1ed5:b0:634:abb6:8b4b with SMTP id
 4fb4d7f45d1cf-634abb68ebdmr11666645a12.22.1759072792583; Sun, 28 Sep 2025
 08:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
 <175892581176.80352.17113730544408747678.git-patchwork-notify@kernel.org>
In-Reply-To: <175892581176.80352.17113730544408747678.git-patchwork-notify@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Sun, 28 Sep 2025 23:19:16 +0800
X-Gm-Features: AS18NWBSpKZiEBLRbL5PnMmNdeGqjtYIf7q6ZYGPEWxXL3UeD_dVM7STFHMxMyw
Message-ID: <CAPpAL=wSFdEgHfA-OysFAqLSjTwAGLkcGYELFaRi-xHmyvO6=w@mail.gmail.com>
Subject: Re: [PATCH net] ptr_ring: drop duplicated tail zeroing code
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com, 
	patchwork-bot+netdevbpf@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Sep 27, 2025 at 6:30=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed, 24 Sep 2025 01:27:07 -0400 you wrote:
> > We have some rather subtle code around zeroing tail entries, minimizing
> > cache bouncing.  Let's put it all in one place.
> >
> > Doing this also reduces the text size slightly, e.g. for
> > drivers/vhost/net.o
> >   Before: text: 15,114 bytes
> >   After: text: 15,082 bytes
> >
> > [...]
>
> Here is the summary with links:
>   - [net] ptr_ring: drop duplicated tail zeroing code
>     https://git.kernel.org/netdev/net-next/c/4e9510f16218
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


