Return-Path: <linux-kernel+bounces-838781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00665BB0201
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89872189D741
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A129BDBD;
	Wed,  1 Oct 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXdYR8BM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1585C2581
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317728; cv=none; b=M8e0RIUfo5fb+QbPZXy6DfKV7wgTL9HOuWVQAaWgCpEWR0G8uz79W0kjErY8xY9XSbATrMR39uVQHS2pSG/e16USRAOQoqm0tlkssLLOhTHJ0yt/QwXkrafeW7+Ji6WsNDHettAMe43t+7KRAODlkUmtO8t1/lRaCrCaYZu9DTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317728; c=relaxed/simple;
	bh=MHUSi4P/U4csGmhflVuOc3gtRv4O4p5QklistO68IOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljdWM0fiZEbFaUECYJ62YKeoyk9K/xqR1MAcmHunhNH22UoonUJgz8ii9IRmd1Re1w+u2A9dvYgn3Y9azbdB4C6JFBcKRwhlzpmVu+3hbS2BpcLH4+1KSK/01gPlaOkvDyir3Q4qlK5VmsthYW6eniGSUA+Ijbm2Aq2Xki6Fn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXdYR8BM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759317726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ql3BeV8zLppnm7zJzsQP4NuOCJwg+ayk79UQ80gXYqg=;
	b=iXdYR8BMmDBxquLWQGAE/DAvT49wRvs8MiQqLoQ0z1aWy3r4p3iPN5no0t4a28QdFSCTZI
	SyCv+OXZLw5hG0bAWEihz1eFx9D1Ms4ft/4Y56EXGUT1H18zGscclT5u5kZluC0CpfYpGw
	ni5teKlvJSlIRHZIK3EXXEyGBeMjNiM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-VtswpfXZOKuai15z_zn67w-1; Wed, 01 Oct 2025 07:22:05 -0400
X-MC-Unique: VtswpfXZOKuai15z_zn67w-1
X-Mimecast-MFC-AGG-ID: VtswpfXZOKuai15z_zn67w_1759317724
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso4657919f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317724; x=1759922524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql3BeV8zLppnm7zJzsQP4NuOCJwg+ayk79UQ80gXYqg=;
        b=NdXqrmiFiEuhARdJDpJLcQJUOMm9ZsuFtcPwGsjf+S6dMipSdSohjdAh8oM3IL4KoP
         ZoycSmjG1eqOKXAvWZRtRYkzTRT224zrtgneP9EauH1tj4g91uV14eJ7Rqfs175IsTe7
         U+fKghMxxa1PehXcsjvC3tSHmf0aQ3Cp9UcKhg1hqjcj+bj6E/psbY0fOj29PfR1cuuq
         /kF8vDP+Dl9YZiVZ1OnKI2rs7ESMqJpGK7NivEH+micWyAvBFUFph7yVISGlbL72p4Kd
         virBX3siScNUwBUxT3TUTgEUIyy8+W/SOGkc95BX5mgJMl+DMSOOsgAv103XQgWVW0qB
         CYqw==
X-Forwarded-Encrypted: i=1; AJvYcCVq9MjApKfITphNgI24OyJhPW5OoQHf+Sla3TEJPxvxUNtepuMhfJgGY/0u3tbHKvFAuhLksn8CXqPBKRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGH9OYve71Fvlp8zuyFiyUfNK9CkelS/nk8gy5bYDZsaHaeGq
	EYoxWR8111BRH2S2uspqr6kVTwLseTED4g3HQfA9z/gmkhk17ZT6p5f2kmSzONZki/Tb22Zr7fC
	JOUwad/WEVrhefxf7dB9F28dMZPEuExHYUk3GNqeQ92bHCzr++cDeMHzq3dbXYlLNTA==
X-Gm-Gg: ASbGncuyb+JU7r4NH2Q556nDD4KzWMXY6xxCWUFlLjMzdNdemW5jUZ8HcPe9pz2Wh4X
	NjTis8MK7+8rqp7QK/WwpRIR7zo3ikEnUuD8J0Oyq4pp9LgSnocWnvFsivbkQHGco9GFaxnOp4f
	AS15gSm3vvjAB3L+JQf3wuTx6qnbnN8ZXfYROzG76YN06Xn2oRrCWOXf4e/RC6FaRogDJipP/hi
	rFN5mcNh4HGJ1kp2PUk4nJnrHUA6owHHZMKC6MTZrxrB5+78B34f2oEJUibItAQOE0q3Lk/gYe/
	71+ROulX7C+1vkQs/JVwjBLxQg05okwoQ3ODrlk=
X-Received: by 2002:a05:6000:1a8e:b0:3ec:a019:3936 with SMTP id ffacd0b85a97d-42557816dadmr2479669f8f.55.1759317723710;
        Wed, 01 Oct 2025 04:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2YMfWSirAsieLM5wvLlIAO/DtCA3N6PuMAY/Nmj+lVBGtH+Oqh6a2oWTtM5/KVZ/v7RwKwA==
X-Received: by 2002:a05:6000:1a8e:b0:3ec:a019:3936 with SMTP id ffacd0b85a97d-42557816dadmr2479627f8f.55.1759317723082;
        Wed, 01 Oct 2025 04:22:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm27105223f8f.20.2025.10.01.04.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:22:02 -0700 (PDT)
Date: Wed, 1 Oct 2025 07:22:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com, jasowang@redhat.com,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <20251001071456-mutt-send-email-mst@kernel.org>
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758723310.git.mst@redhat.com>
 <175893420700.108864.10199269230355246073.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175893420700.108864.10199269230355246073.git-patchwork-notify@kernel.org>

On Sat, Sep 27, 2025 at 12:50:07AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 25 Sep 2025 02:04:08 -0400 you wrote:
> > The return value of copy_to_iter can't be negative, check whether the
> > copied length is equal to the requested length instead of checking for
> > negative values.
> > 
> > Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net] vhost: vringh: Fix copy_to_iter return value check
>     https://git.kernel.org/netdev/net/c/439263376c2c
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 


It's probably stable material. Does netdev still have a separate
stable process? I'm not sure I remember.

-- 
MST


