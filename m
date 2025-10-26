Return-Path: <linux-kernel+bounces-870257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D84C0A4D3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD43ADC7D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D295287508;
	Sun, 26 Oct 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr4GcKvx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F884264602
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761468630; cv=none; b=F7JxTKt/xPiVdvJqB1tnLGm4g3+hvQX8PpuPdSfhWDisfX8JpeCP2WMqlSEpNxD2JwAwqysxcYSV8qjvRlSe+PA4Nqm/CRffPinJFbnBS1qOoeMHICw2IE0kwAfLJJSTxjz8Qus09gPQfgvCkk2n0MubINpLK/inJrMCxeoYvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761468630; c=relaxed/simple;
	bh=qUv97I7rJ7EfeUfzdIMw6A9QYkrO8FwT2r0vGFlDE0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pahQS9KX3eJ9Fa3t6ObLtPMz0gtZb67b/TRUeBhNJ9Y1mAJZeQwKHdWa4Mdl2uZWNZuIzA0vh65ihhU4g86kl0pMf/Q8KESIK6PQSlVFzSDfrOcGzX1l2B749vY6TEhZDsiBJ+QkiIcqXO7mpMPCdnr5nOFyW496bkWcIgOniOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr4GcKvx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d14e5c9aso49582505ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761468628; x=1762073428; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4erMBwQ48N3S4QlFMJdE0eCyGlP05V530oLjHStsso=;
        b=Mr4GcKvx/LAtW1SssMM2PWEumNXy4snQNK6JCJ/s7U0old5m/wLeZPPW1WPbLsK2gp
         etP6tLgEBBVptpxrIhVPh82Zxy9YQySOWLLf6ybPoezzda3U/uNiS5FHVjAsd8kNPyh0
         2JK/By4Lhn2mm3+sGD9NQEJieMInCXif/F/QO3GmaIFFvSwItRb6xl+DA1JBqTlKoGwy
         OmMmOon3TlcGxsaqjVCoBWZNe+hutEoCEfv0jvTOQn3iyHQqzPm21rf3smocNxpdFHEw
         DN4S2fzQV75unZHQv4FV2uUoJvJy4MukvhhIddleb9p976y2tzrgIDwWEv3Wslbqf3V2
         MZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761468628; x=1762073428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4erMBwQ48N3S4QlFMJdE0eCyGlP05V530oLjHStsso=;
        b=UCG8tEjk1cRa+A7bHtqq19Awt3vl6WL6n+GCdXLgNxdksHU3QjVpu+aR/zKG0cxXbD
         b6Rq/8/Xfi+qV6qW/PGbE8NLoFYhRQzsqbVLuOfrc7ees39FymnL9faXA1hhrbBoC8Xi
         kSGZG9NNamoOYWo/KP1APXyO3NUSC5fC2HKFj88aRTfeZM+JfTIvRFAfrQhRnLMxRJPz
         XgdpHUPT24HvvkAzu8I9n3AmIhf6OPoCmWqSXERPUtproGDtsKGOrsehkEW1ulmqE50h
         eovOr0yoCSSacYXb/QK0Gc1V+VE6RaMkzrg3hHRGBlCGAxqt/tA7NXDHs6GvA2/nmtxR
         r9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVEsBfhMOA07uZFRlujboIjByet3WkMyfjHgCG22BPnSVZtMdBKVItGJb8IhO0gFIqOYK7HasGh39ne3ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGnmJNTnfyGqCI3j3FtaGvNBGYKyKgb5iulxc6pSMRkJzyOra
	9hBsDeDg9s4Nu9dccXaF10NDaywCy26sEIg+qrWk89HSJW6fP3fp2GkL
X-Gm-Gg: ASbGncttQcLgkX5RmP+S06wBZpQ060xGa6/Ze260ukjxZ62ZVIhIJBoT/H82fS9o20v
	Nt3n0PBddmY4H4Doah3Y4Ew1Z3HeVO8U8st2w3tplzIuiZA0GBr29Z2dsgjDhadYa72piPn7lNk
	gm8fxm+XKpozc3RvKbAvz4vIyWC6oXwkAcn9K3g8U50JjsYbuPP2nxURb9dzp8htLf34JVgaclB
	V8XUEsa+d6JxOWwqNBLoFK3DbWKEa7hPA046OyxXWJ9r8ZRr81RIr+FXIFUU8eHwuTflIPo4lMa
	+ZK6x4mWc5oDOXpQWnEQmUxcACAEDyV0Qf3rcN3SMoT9+noBCZE05p1lruLCxvv83kTrh6u/rVj
	G28qtV6kp5UnfrnGgkg88HM2DP8PVeIWjWAJBUgrPCM+FHs+S3doy1wbqUHmMD/PcIvMB4DVH8R
	A9WK8wxizyT09kAf4=
X-Google-Smtp-Source: AGHT+IF/m6/+800gB7/6liHmYwj+jJvYjxHcXB/tEA5NbSYwquOHX9mUISDWYTYNNgTYOtc6bmcQGg==
X-Received: by 2002:a17:902:f689:b0:294:92be:64d4 with SMTP id d9443c01a7336-29492be682cmr90289775ad.18.1761468628250;
        Sun, 26 Oct 2025 01:50:28 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d27541sm44678205ad.61.2025.10.26.01.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:50:27 -0700 (PDT)
Message-ID: <d52862c17afab501453c3fbb5167f78d24b1f807.camel@gmail.com>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,  Simon Horman <horms@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>
Date: Sun, 26 Oct 2025 18:50:19 +1000
In-Reply-To: <20251024163336.5fba5cd1@kernel.org>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
		<20251023184404.4dd617f0@kernel.org>
		<cd557c5b11b04da060f07d3849dc46e7b3625ed1.camel@gmail.com>
	 <20251024163336.5fba5cd1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 16:33 -0700, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 12:11:11 +1000 Wilfred Mallawa wrote:
> > In the previous record_size_limit approach for TLS 1.3, we need to
> > account for the ContentType byte. Which complicates
> > get/setsockopt()
> > and tls_get_info(), where in setsockopt() for TLS 1.3 we need to
> > subtract 1 to the user provided value and in getsockopt() we need
> > add 1
> > to keep the symmetry between the two (similarly in tls_get_info()).
> > The
> > underlying assumption was that userspace passes up directly what
> > the
> > endpoint specified as the record_size_limit.
> >=20
> > With this approach we don't need to worry about it and we can pass
> > the
> > responsibility to user-space as documented, which I think makes the
> > kernel code simpler.
>=20
> But we haven't managed to avoid that completely:
>=20
> +	if (value < TLS_MIN_RECORD_SIZE_LIM - (tls_13 ? 1 : 0) ||
>=20
> I understand the motivation, the kernel code is indeed simpler.
>=20
> Last night I read the RFC and then this patch, and it took me like
> 10min to get all of it straight in my head. Maybe I was tried but
> I feel like the user space developers will judge us harshly for=20
> the current uAPI.

I am open to reverting this to `record_size_limit` in that case. I
think the only trade off is just a bit more complexity in the kernel
side for the additional checks. Does that sound good to you
Jakub/Sabrina?

Regards,
Wilfred

