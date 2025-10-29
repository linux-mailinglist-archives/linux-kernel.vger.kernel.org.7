Return-Path: <linux-kernel+bounces-876457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FDC1BC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE05E007E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EBD5478D;
	Wed, 29 Oct 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8pSUfFi"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188152D5C6C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749868; cv=none; b=K2UaK2ZVcBWFFVDLaeHbMODfIHWaC9YD/g6q6kcQm3k51QMxwS3d4pVXuzIjj5pryjtEq4TvCv1eboVrdkWNv+C3rn2+xlRQNBVZXtNIIEZUiODDY50nuwfL9fYUmKcbJxplFR8v32/L8sRrwUjQE+/3GxiNP4bAAOCuETwKvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749868; c=relaxed/simple;
	bh=sW0fcO523ng4pGFY9aQJooiGcb2xLELRhF6pvb9Out4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZn2ig1cU1VFwxEuDG41aYELizkea3W4vOxFpqxzuFYMVT7anMB+VOe4zy7Kpx4lW06IYFMfGAYopRf34NP00/torGD04Rwh1C1SCINuc2Cj1Rh9pXDUBsAyqfHAf81zc+oGWYarVj7bB2Kjn7dFlED3E5cCtJhcF0EuzG2baBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8pSUfFi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ea12242d2eso340671cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761749866; x=1762354666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=P8pSUfFiXDPDvWHmEXuinZOCNdErarnp4POZ0SOm+Nft/ANiXqnl82D1ltOuvaxP2s
         RH0K4kWiEOjHoyP3J6XC7Vv3EFYLm+P9ul8yKQuoRy8/xTCUNl6MSBeb+CmCWHSPd3Sb
         JcTJlOBlIgMdppqp1oVg9pEjoUbvzy6XrklLosfX6s5Kb0Cu56C8gBleV0aVVFRKDPe4
         sJZU483KkhPOrqeiIjJFnj4l5NNwWSxVfdReZGU7PYWWlG3Kzti3eXuhCBOq86OLRrlz
         7wCz5egdwKvC6zV5PHkrbqNTTZPrHe55bfZvOf9W1rE+KJAu9Rm6qI+EOx5Ke3jEFoDT
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749866; x=1762354666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1yPrZJAtYC54ch5kkR2jlvgWTejLF7D5+gBaBiHJFI=;
        b=pgB6VnwyoQblQcwjjzBDxGOcKrBf20skxSLpNVOW1TpGb9i8UqabTj0Rje//RQhqvd
         U8PK1TGXTvFmlhUkGiTSucCPonFCjEul/hTgpeAPXeeiORElInpwvCmPlk9nUTx9PpP1
         5o+bhUfKd1NnxG1Cep6sxAKz4cace7bzjbvW8U4G/3M0Nud2grl5QV7Tyzk28r3+6LxX
         9ly/t5R7AH1z06G23aduOsi/9AWMgd69Ug1x/KMj8a2KeYN2+rDVn8E0wVvLNQftq21a
         7oX6SBtmP7NZjVdp4cfeftH5VpjniNdcO6ASfpTKw91sFd9dlL6z0iq9IvkOwQSe++RP
         mV1w==
X-Forwarded-Encrypted: i=1; AJvYcCVaLZLnSs1//b6LjFXpjrXSvEQ4nA7uMwP/sdu379edwQG19kkARW1Kujr59VJMK0au+BeVOnKr1oRroPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyyh1VDHPAlDyNCgE0vmWvf68yklLdSFk9qlBrYcMs8mUa17ZK
	Lcx9Oj1/dWq7VyT2To3b6zkTZ14NpuUjD4zJGiuPqPBwVWdwTcWCQetCKx5+5uiLBEsOIS9sXJt
	LESYweUo2TDINz6nlR8ySEP3+Rc2tqHDqfZ5vUCtY
X-Gm-Gg: ASbGncsqGchNoseQ8YzHvzDJTcSg8valSMC1bZGyHto50B6XFLVP1oB44JET3OuudHQ
	DyGatpY3wBHqCc9yCnBxwd0hZBQCaeXlRXLjTdIYeL5LYaa86FYWraRHwQE1rZkTGIxlTY058De
	JXKbY6lLr/4lUepBNAJFDMOGrxJ3sKs1x5q3T3YLZnF97GGvgI8BAvCbAIVUnUNM4CMJpfCfrti
	HkXrAtxPOhVCOoL4mJ8YP6DB08O+acthTHRXtSPMEQnNlPxauCae+fbKYJLmsTFQstAiozUMHjg
	Uc6iBuSqVOu/QIYhC6HDITtluw==
X-Google-Smtp-Source: AGHT+IHJk1Z4xsEEl6nhEK364d+WNrqkglBzi78RQdt59uckdBYZ7htllhsIgZwt9bC5EN7/2oXDuEWCE2gLHAXeC4U=
X-Received: by 2002:a05:622a:11c8:b0:4e4:d480:ef3a with SMTP id
 d75a77b69052e-4ed165a8088mr6994811cf.13.1761749865638; Wed, 29 Oct 2025
 07:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com> <aP8XMZ_DfJEvrNxL@infradead.org>
 <CAJuCfpH1Nmnvmg--T2nYQ4r25pgJhDEo=2-GAXMjWaFU5vH7LQ@mail.gmail.com> <aQHdG_4yk0-o0iEY@infradead.org>
In-Reply-To: <aQHdG_4yk0-o0iEY@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 07:57:34 -0700
X-Gm-Features: AWmQ_blGYfe_lFn4eY8RCcDjRQso5Ijs05VisPx1zbBZudE9r4ISvY1EtlCdvh4
Message-ID: <CAJuCfpFPDPaQdHW3fy46fsNczyqje0W8BemHSfroeawB1-SRpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Guaranteed CMA
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, willy@infradead.org, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:23=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Oct 27, 2025 at 12:51:17PM -0700, Suren Baghdasaryan wrote:
> > I'm guessing you missed my reply to your comment in the previous
> > submission: https://lore.kernel.org/all/CAJuCfpFs5aKv8E96YC_pasNjH6=3De=
ukTuS2X8f=3DnBGiiuE0Nwhg@mail.gmail.com/
> > Please check it out and follow up here or on the original thread.
>
> I didn't feel to comment on it.  Please don't just build abstractions
> on top of abstractions for no reason.  If you later have to introduce
> them add them when they are actually needed.

Ok, if it makes it easier to review the code, I'll do it. So, I can:
1. merge cleancache code (patch 1) with the GCMA code (patch 7). This
way all the logic will be together.
2. . LRU additiona (patch 2) and readahead support (patch 3) can stay
as incremental additions to GCMA, sysfs interface (patch 4) and
cleancache documentation (


>

