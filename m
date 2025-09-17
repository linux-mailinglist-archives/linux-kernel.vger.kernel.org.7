Return-Path: <linux-kernel+bounces-819915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01554B7DE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD087324EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7241EEA40;
	Wed, 17 Sep 2025 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycno+brg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039529293D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758078627; cv=none; b=CBnd3NSEnLI8hb7LtmyvTNoAe8WwmynC+s4jpWmyg/Wi2BK42CPXNP/GM4+iFVDhUy0mgx9EmEqJCsvy+Gfd3M7j3O6NUq5vhxg3mG/HTpYR23eZhQbg0FsrAT8BqN4fdPAfIjO0fPTdx9vEWQJ4Wr/Hyhhmi4Vo38DsjBP3jFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758078627; c=relaxed/simple;
	bh=qo+k8NcZTsre/ht6MSdF9SSU+7BW0nZyjkH4oBSMWuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwWQyhsExGh9WzoJTiZgZA8hp5TYYU8yjEGWoLcaINiOc5QQw3VIgihZhrpCuKmboJHQsFa9r5iCOJ4Nh56DJ2ndgnaFHV+0ocHrcm+CmG6RvLvBtgj6QEOy7qCXhaUn2NB6WfdBs92zTNsz88S6sIFur7U3b8IjLe5j0iazq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycno+brg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3dae49b117bso4763231f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758078623; x=1758683423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo+k8NcZTsre/ht6MSdF9SSU+7BW0nZyjkH4oBSMWuM=;
        b=Ycno+brg9GMmuW20SBgx/f2hvmZ2UcgvG+T/j0pNzBS9baci/+Rg0/0mYdr1ZF2VlB
         u8nHF2vMTZGLM2cPY6uJEqY7TDRAe6uedURzFxHRZA4nSbu1FLeghGfpBVWFmr7H6edN
         RWUK8RIKR8fhTb1jvDaITER2c0i+d2acFKC6va4UgUx0h5sQENd1OgdMIUeVAMRt0OIz
         dSHrdbaP7Q8e5TXSi7lsW3PrbtxzKPbz2/9UIjWyFoU6zmhbvmOCnn+O0qm4p2AeM8JE
         QHqMptLaWCmxnreGEeYe2TX9y2SJT/dpNK9kGaKCrrOEfnk/nWPK8ViAkddao97F4Yc1
         +WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758078623; x=1758683423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo+k8NcZTsre/ht6MSdF9SSU+7BW0nZyjkH4oBSMWuM=;
        b=bHV7xwKeY6RXn/rdn6R5dbsJIiZc4RTtXuHiS3RVc+UJq/nXtokiZNtIM2Pj340nnw
         NQUVggE+ALJVfBw9lnaYIG9gJCjz6Ouj0ZsGF/JBGhNzA+XumIpIQWxatEnzqhSyUbjn
         3Dhy781q3MhsSlGUVFU7hMnRFXPmO0F83EDpz4BxtRTJZScFllw7/IzPBJuuwnjIWVC6
         EfNmaZTSaPQphLgblR+BSLFp3aYHdMNHhNiaTluWHKBIJjQMtF4dB6o4CklngZURPlEq
         xeG41J5EWAsCzg+HTwkfPJaQV2GCgobFBhZmbzoLwQ9IBTJqpOJRoVdz7/DVXf4vcxML
         kgNw==
X-Forwarded-Encrypted: i=1; AJvYcCVydAQuApr/WW/QZurWr09MvWIGQDWHYEYNz0v55g90owFqjGujdKobFCossXbxMDijZzFvWI/bLavebAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0L7O5TGeurD5DIgUI22eX8Yuo6V4VHLJDDCs9pifyxwOp1G15
	pimXhi+Muq4qW9+QOE7gskYvfhRlOXq77yxMCZwepIWoYSh8tUVSTKoILptJpH7+W6oYDaqu5/I
	yhwdjDw2SKo6r3+k3EmSgAZUXnCza4K0=
X-Gm-Gg: ASbGncvBQvBBIsXNVoL5l8TiW5zuONIFGHqA5D3BsrpKzX4EF7Auk9XzXhVtakh/VYG
	xjB0hilHn9sauIDYLEexFrL2+wdHQCq9Fvl/e3lWysZissBJvVduip/FFGHyydxhy9XLqBfXJDJ
	Dh0gA/1BTqsqIkTVu7sDw4190CPovZZSmd+jKzxTiVvlEe1xtBrRY7dOXa//FVsopVe9al2+xdc
	txqA3cHX5ONwRffZGxJfSnRoDQ+8NJjoTWEmUHqfYiRZD8TC9vjT7nF539sHgFDClN/f/XD2g==
X-Google-Smtp-Source: AGHT+IH2rAtLPqjrPkzQAgRzLtpqU6GW5KqXZk29vl3BVB2lerYk/71eQQApYbtq59ICPt5hKbYpbTG3+CYs37kW9a0=
X-Received: by 2002:a05:6000:24c1:b0:3e7:60fc:316f with SMTP id
 ffacd0b85a97d-3ecdfa357ccmr500935f8f.45.1758078623223; Tue, 16 Sep 2025
 20:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com> <CA+SN3sp6ZidPXhZnP0E4KQyt95pp_-M9h2MMwLozObp9JH-8LQ@mail.gmail.com>
 <aMnnKsqCGw5JFVrD@calendula>
In-Reply-To: <aMnnKsqCGw5JFVrD@calendula>
From: Elad Yifee <eladwf@gmail.com>
Date: Wed, 17 Sep 2025 06:10:10 +0300
X-Gm-Features: AS18NWBRXY6QRQwpfBo0poGfWO1ILeFSm2NP9vXOGP2coW97SISUDWSiYlpGLTs
Message-ID: <CA+SN3srpbVBK10-PtOcikSphYDRf1WwWjS0d+R76-qCouAV2rQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:39=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> May I ask, where is the software plane extension for this feature?
> Will you add it for net/sched/act_ct.c?
>
> Adding the hardware offload feature only is a deal breaker IMO.
Software plane: This doesn=E2=80=99t add a new user feature, it just surfac=
es
existing CT state to offload so the software plane already exists
today via nft/TC. In software you can already set/match ct mark/labels
(e.g., tag flows), and once offloaded the exporter snapshots that so a
driver can map the tag to a HW queue/class if it wants per-flow QoS in
hardware. Drivers that don=E2=80=99t need it can simply accept and ignore t=
he
metadata.

act_ct.c: Yes - I=E2=80=99ll include a small common helper so TC and nft
flowtable offloads produce identical CT metadata.

If there=E2=80=99s no objection to the direction, I=E2=80=99ll respin with:
- the common helper
- act_ct switched to it
- nft flowtable exporter appending CT metadata

