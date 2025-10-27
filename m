Return-Path: <linux-kernel+bounces-872145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A68C0F698
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0794819E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC53164DF;
	Mon, 27 Oct 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNkIU/Qm"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04693164A8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582772; cv=none; b=szvWAsTz5JIAkNzsdnSyp7OCDF7wfD+XKxSbdbN2TpVc9yqn3upI3xZZPnRiKSgZYuUmBfg56V0Pc0vvfy4GRuOXcC0ugVF1HV+xCgvTtMRoMpj+Ea2RB/AWUKJ/9fJv26pR260JJWTAEUa+iO247FRhxsdObJHdp3Xfr8e/BxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582772; c=relaxed/simple;
	bh=TnOakrnRtLMDcV8Ns77mVydNCZhs/gRtET1InUAd8IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stLo+zif4nfAmCFv9arDqawIsdgz9lCGRXPiqtNWj5/UUZtU0U5nINSefkh5sxpMxrqcc0kSjpgA23YoDpyYvPOKoiYW2TvDRulGuVw9eX6f/x3o5Gtc7qo/B8qYijIinH1kl1Dw3ku7Br8iGKC6FBJbftyLwH4WkHgxYyrlw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNkIU/Qm; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so5632480137.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761582767; x=1762187567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnOakrnRtLMDcV8Ns77mVydNCZhs/gRtET1InUAd8IE=;
        b=dNkIU/QmEpcm2HyrgexaGVxOEhG/TJkpHIfbeombtfkiAQBCiaj/xuqSTJXPuaTlOB
         SpzG30A5CdRKcVRUSXmnlBp35VklWjUcqRBs4wIIv1uzyEjtLPtd1+QMYEvW5OmzMFz/
         hMV0fNM8z9oMYbHskSFuW7yYxctvE/m8SzOMHNs7l5ol8dTj8hwHb7Tm8zVtV+uVLLca
         h+HLBnn5qATH02ksqUYMEOwoszzcJCNRNQkq87fbKMUBEpt5L1d9FWSpxmj3NarDoITL
         vDmeSvSK2AOwAOziX+rK2W03r0aLzXfNTtyUusVL0rNO7kktCvwS7JGtsoV3evc8RIWT
         nhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582767; x=1762187567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnOakrnRtLMDcV8Ns77mVydNCZhs/gRtET1InUAd8IE=;
        b=vNWMKS5mECMd3ahxHAG39e/1wvQs4HgA+X6op+VIW4UaIrbC0irw4fDTFWrfZ1HA03
         GVHBzF913zDKujI9bmVRNKMBSqSWJ127y7NIz9Si4rSACBlowbuo+2RHXE/utDrwjPPJ
         lt4z0DqFmIRQeifMTv6jMg9jDaP7Qu522CeKjky71WktrHys3PC9CDknXa4Kaz7NyTx1
         Xi9obcZQYylx2k+T15+pkdkeQ0EtZm+0KCVe/JKaZPGbKn+aN+bXY3+Lca5Dg6S/Zomz
         WkOsxZQppWhSei+1O6DpQAzJW4IYqgAt2fwWqhWRp5rtzud8PnVYwJ5LC++QK55u68Hj
         Xqvw==
X-Forwarded-Encrypted: i=1; AJvYcCWnxcvQwhUGlXrerNNG5ld6LF0JBOzji+RgqOhP7+yTqFfOYMgHooTym8pXgbbixHJnQuWJGEAsJjeXgH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XrIUz5wu2JJLXvqgK9aVyzjdQZIMSNJABhuoxPMbO2Fe9fdq
	iJhug49EfvGoJnthOZ6wB8w4JqxGM/nIcoGFaH210P4utync+415cNZ0m8KErITa88tpCdLClrt
	zL9dDCuhI0HHZElaABpDsPyrzpnduM3JEFYSuG9v7
X-Gm-Gg: ASbGnctPtuMyUTmWP3ET5Ge4dgHajDEarFC7XmiNxLjMxMsvF+F1A+AGgSRVMBcU3Ks
	f3pbgfKw706gqT80nyuabhOoPx44wIex9YfPqj73SVtnQGiJ8801Qxo1c2OFrgzrrpjurObMa48
	oLwsrKRazQIKzq2wGtx3E88KU13tbANYGjQO560BcwEL5RZuggLZByoQFWN3fLGknXhmPO1rNpL
	WZjcZsXjNxQyxDR1jhiQkWoNH6z6TUYrTu3kBSSKmXbB2K7CypIIzpvrbut0hvFVZo1y2U=
X-Google-Smtp-Source: AGHT+IHXnfvepXGeW7qZPCtmz5hEeIREM34YMMaK2zLFn3F/OLqY2HLg64GBHNBo1E6OD+RqYxgrz3GBQj87+voxOUw=
X-Received: by 2002:a05:6102:6105:10b0:5db:2168:77bd with SMTP id
 ada2fe7eead31-5db7e069f95mr77611137.2.1761582767337; Mon, 27 Oct 2025
 09:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924141018.80202-1-mngyadam@amazon.de>
In-Reply-To: <20250924141018.80202-1-mngyadam@amazon.de>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 09:32:17 -0700
X-Gm-Features: AWmQ_bnCgLJQdJadHXgZTs11fy3YYiv4J1ib7SVx2-I_tj6H5qXd38RuBwvFIns
Message-ID: <CALzav=cuhzsTu7pZSae_6EpbJ1KWq7Th3Puk2n=TEbWN6LWh-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] vfio: Add alias region uapi for device feature
To: Mahmoud Adam <mngyadam@amazon.de>
Cc: kvm@vger.kernel.org, jgg@ziepe.ca, kbusch@kernel.org, 
	benh@kernel.crashing.org, David Woodhouse <dwmw@amazon.co.uk>, pravkmr@amazon.de, 
	nagy@khwaternagy.com, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:11=E2=80=AFAM Mahmoud Adam <mngyadam@amazon.de> w=
rote:
>
> This RFC proposes a new uapi VFIO DEVICE_FEATURE to create per-region
> aliases with selectable attributes, initially enabling write-combine
> (WC) where supported by the underlying region. The goal is to expose a
> UAPI for userspace to request an alias of an existing VFIO region with
> extra flags, then interact with it via a stable alias index through
> existing ioctls and mmap where applicable.

Would it make sense to build this on top of Leon's dma-buf series [1]?
My understanding is that dma-buf can support mmap, so WC could just be
a property attached to a dma-buf fd and passed by userspace via
VFIO_DEVICE_FEATURE_DMA_BUF. Then VFIO wouldn't have to create or
manage region aliases.

Apologies if this has already been discussed, I did not go through all
the past discussion.

[1] https://lore.kernel.org/kvm/72ecaa13864ca346797e342d23a7929562788148.17=
60368250.git.leon@kernel.org/

