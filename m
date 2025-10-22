Return-Path: <linux-kernel+bounces-865390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F74BBFCF46
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0593B27E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064E3502A7;
	Wed, 22 Oct 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD/bZN1l"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F8212B2F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147596; cv=none; b=r985W2avY5+sKlCBtSAW32mPbXgXFF9q+Sz7JBqnMpj2Jlups9QrU0ViTVbzrYnh0+XICMyrSjOPAdukSaof9yKQwFeF6jZJvTdzyQ32YjqVk1APPAcHDhTH2woZ0Qmfl0/2c/zzbKt6jXRsBJO60rOKvYnYpS6lDmUsxL23AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147596; c=relaxed/simple;
	bh=Y7nRwgNuEoRlNNpluhXoG5akVg94Zwfd3+z5MLrputQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=py/0B8XcXP1MyHbZynIxJMKYS9HtZK4VkCIj10OT1cnONlbJ0QHQAH2uxLoYrty830Hsp25dR1gajzyFl2pb5MBzkmV7cctmZEeznLw1M18ht04yBItFvcANjkH0NTM+ta8/6bqRqRCTbh4Hs2lwxigWMPsuUoIMnmvZW3bWqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD/bZN1l; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7810289cd4bso6717562b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147589; x=1761752389; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7nRwgNuEoRlNNpluhXoG5akVg94Zwfd3+z5MLrputQ=;
        b=YD/bZN1lpZAcn1WKVcNW96Hxla7lkRfvHfVjlgjE4NgmR5JI4g5iO7vItrERVOedCU
         EJM6RtMCiHGSCCqScQT+UWJ5y77IFninYRLbLlIsorT8B1tN6OuEgJAmsviXjC2c5XL+
         /KKz1JDLIUsek5QIEo/AnZ+QB1z6aekNIq8Gyu9XihN3krO2594xVQCyJzybkDKkm+ns
         nuJN6LQDa0Qk3TLxt8zyQs9CaSaiz3e/0sRLw2G66+yUpYGFsu4yvHN7C81xX+9a1ip9
         W8uG9U6NjxJ3sCq2uMqVuW2NNoNnphc1AvaIH06qEIPICnZtXzTS1yruI95bMsiu9F3V
         xiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147589; x=1761752389;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y7nRwgNuEoRlNNpluhXoG5akVg94Zwfd3+z5MLrputQ=;
        b=uob99QKepETjb3TFut5uD8naPnzxR/sTF1Rz5TpA1prbwDzaQ1LPhy8Lj40SO1ZeKy
         4LEoySck1ryUZNkyDYDUcXLxrNMLwGCHxCOTbJ5J+FsoDqYJy8GRrcCybDyujWp3Vr8W
         +v0T+wtSSrWhM/rV98/Sahus6Pwq5Zt7l2irg8ABy6WVuLd6uu/uiS4x3yvvmDU1aJ8q
         wgU4avaNK22J26h+R4JdwrxJ0TegZ4MZDCZpOiVXsJMceU2ZG/4Aq4C5A/OTzyoM70q+
         lchUwQd9amaMHP75tNFgsOnsp6nDKX8KRDuTWvPa5uVFL+wozTKLpQJWdNuQ2M0keIGv
         TGsA==
X-Forwarded-Encrypted: i=1; AJvYcCUoWx8ilnwhacbUtKocJMFlYA90L57Q+2FC1ljdE5Skyr5WEx1/u91QPacglx4ERRvpzx19HiLJJDNoq7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu010umNDeVnIashys1BaJvIf1tB6SdLiXEw++8mOjPvAQieVC
	hB/toBkExgTZLhg7U+3Lv6Rq/VnvtC180FaI4eoBXXgtsX+yqeQKuuCf
X-Gm-Gg: ASbGncuCVCj6oFFbQvbJB8tU0KD3uzhVcSGiqYAXcy4+MoA2bbDeuJKnmLDKBgXb1ti
	kLJiy6DuBvD7BcOtlUj5RVRv8/M6wEQs7UY3ZbbRe3874yGsXwE+NYSw/JVTdotGn4z7u5mm0B5
	rxfh/RgcFpz4lMX1zAbml0k7ZFTqYSmI0mPZqPoi5RkaUzghKm8diqG9jhNw1ckmrqDGxxSimmX
	WB1LCx2iDhq9BL2+OuoDu93ROaCYJUseOnZgUV4tmAXr7Nto5K+NofNmRGQNWDag5jYLaAkthNl
	+NEuPjMWCMCcLeEOOp8cZayoFlnmrUt/EMpHOCCgUlxs+Dtz8G1kdYqSFeC2iN/QYcVOGMUbnga
	EzRIqxPD8dGjXzZDlhfHTmSXdS0j8l/Xo/HMz6sEdCWx9TqlRFX+86kwTAtFjLwFzaNWwNjQf8w
	gn0Ks9tRbdXoFfvq8=
X-Google-Smtp-Source: AGHT+IHA8x16qnReEkx7tom3/OFAd7P+EdqEKlOFfN8xi5QWb1VTjZPUHlGnrwAgma8aqZe+Er/QzA==
X-Received: by 2002:a05:6a20:6a1b:b0:319:fc6f:8adf with SMTP id adf61e73a8af0-334a85340b4mr28440226637.12.1761147589058;
        Wed, 22 Oct 2025 08:39:49 -0700 (PDT)
Received: from localhost ([2405:201:3017:184:d484:e840:6844:1f7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm13987935a12.26.2025.10.22.08.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 21:09:42 +0530
Message-Id: <DDOYPQ2FG2ZF.2RO4YIQ0TRKJA@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Aleksa
 Sarai" <cyphar@cyphar.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Jan Kara" <jack@suse.cz>, "John Garry" <john.g.garry@oracle.com>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "Darrick J . Wong"
 <djwong@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ingo Molnar"
 <mingo@kernel.org>, "Andrei Vagin" <avagin@gmail.com>, "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 1/1] statmount: accept fd as a parameter
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>
X-Mailer: aerc 0.20.1
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
 <20251011124753.1820802-2-b.sachdev1904@gmail.com>
 <20251021-blaumeise-verfassen-b8361569b6aa@brauner>
In-Reply-To: <20251021-blaumeise-verfassen-b8361569b6aa@brauner>

On Tue Oct 21, 2025 at 5:41 PM IST, Christian Brauner wrote:
> Hm, do you really need a new field? You could just use the @spare
> parameter in struct mnt_id_req. It's currently validated of not being
> allowed to be non-zero in copy_mnt_id_req() which is used by both
> statmount() and listmount().
>
> I think you could just reuse it for this purpose in statmount(). And
> then maybe the flag should be STATMOUNT_BY_FD?
>
We made a new field because we thought @spare is already being used (or
will have a future use?). grab_requested_mnt_ns uses @spare as a mount
namespace fd [1], but we also only allow @spare to be 0, so I don't
really understand whats happening here, is this functionality disabled?
> Otherwise I think this could work.
>
Thanks, Christian! I will send a new patch with all your requested
changes.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D7b9d14af8777ac439bbfa9ac73a12a6d85289e7e

