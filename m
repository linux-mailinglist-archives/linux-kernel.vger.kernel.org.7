Return-Path: <linux-kernel+bounces-751438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE294B169A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE6D7B4DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059B182BC;
	Thu, 31 Jul 2025 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW/sDgBu"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13962CA6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921385; cv=none; b=txGip2yc3ElTc/1UMJ/f2BqqgmcGN+AVVWvux/GZwebXAaGAsPe3Ppqfz2k4nyvnMU/jjaqsr9NEeqbga7xwRK+gAXYMhBdzBbEQqTkVRBHwKc9g1NjOtJB7JgrfyBQvMfEJDk1v0IKbK13arNgvlHyRhBpjelyVQrCCSohSe+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921385; c=relaxed/simple;
	bh=JUOcYwsM2Vo3v+H7B4giah3E0XAl27sfIduBCpqMtM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fboG+X4OTPn5HNyoB0nGhhD3ES88tbQtmnaEb8mkrX2u5M8SJwbSzv05jUAcCilC2jcsQJX5rkXWQq08snookjFiE15FJ65BvMGno9l/ytW2MsyL5JpmHofrWWey1SO0ZVuj8Z6ukoZal7QGzRKNjjx5ih5o/562rRxXQ6zJFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW/sDgBu; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70740598a9dso3817006d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753921382; x=1754526182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUOcYwsM2Vo3v+H7B4giah3E0XAl27sfIduBCpqMtM4=;
        b=VW/sDgBupVUu9t4HV8Br9b6vJ7KTeB5yYt/ZEfgOd2S00QCXAJaJ2lnlmDMa84mMvo
         jF91B3P2tkD9zNNATLtMaDTX8RcUjcAbOza7/mmboCe4yU/LeedI3AJFVDiwtc00m8wV
         eyvMu3lfuCFF1RN7qcIJOPloXJaBTzjdDuYIJvcRullE+UX+nT19V5tJfi1mL05ZURHE
         G5IrZZ/7ISbXDBg2I0jKEWNwy9kddT2TPrq2AJHLleZIzIo8REBf8CfYQZjYstsnBtC3
         8aALz5ufeyxkYQs0+pcT3J0Lrpwvo1HhYgI15Vwzxan+kiaItxpW6HnozS7smMjnSEcm
         77pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753921382; x=1754526182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUOcYwsM2Vo3v+H7B4giah3E0XAl27sfIduBCpqMtM4=;
        b=SOJAC15zmGaCr4aIvkKfOg5SXvYyqHquPQtXJF8vscmwzSwtiVKxFfYOlvigkUT+XB
         /CHik6wMQ5exDV5loxyFj6AMJT3vHw6+4UTZ233dMfdnmzU7pXtyagVoHq/Cn0Y8JEYi
         ws4GWgcAN155+KeFxaDRKevaRA+roYARhv9zFQgoDAnHZANV9rmJhRFUcWj8pmaazABZ
         WG6g+9qK/+CE5Gr+ixy7QDX0AjhT7dSz7J/pQueJCpcxrUhE0hQdjx8DgnS1tkUEjBxK
         nX9PKtn7UYmQFostibbmflvi21DS4FC9OxyVhdE4sk5bagQa2mp+kpfAjujzXdMrf/6I
         v/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXVWRd7vBDdQP8XYStq1YoCOFXmGSWzvz4avftgj90cxEpoxZTCr8lZLJxmcBjLdcB/CiFVaDenWg+wl08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGe8X4JB1KC+60r/BwzszJ+8Eeq0xxFcrmOVxfmUozZHWeh2v6
	M7OSo429hzNND7CKd1f8cu0o/4wWcqBeCw5mg9bnNuWEm3HtVY/PuZQfOGcPuSKacfYWJsWKjPB
	O99fENq+xR5X4RWX6DoJpwWB057tDdxI=
X-Gm-Gg: ASbGnctxfPQbFlOhl6rLk5scaGIelWPUW2rd25ejcNlt7nClSNif/dbKmUeX0jmy9pM
	Lj6xoozuy5wDq8cRPXClEZQAuaN1P3J2WUIFPbCNPGroKmc5IbPM8uAF6unPTYi1B/32huPxMRj
	dZ6Jq27oHYXv7DB7DgFx13Qmq4dCyg8xv7qO08x8YU5FLVcGUbVyER6DJTs2Ccv04l2t4rMDKGG
	dTwXep7TUcRhEzli8ZWdko=
X-Google-Smtp-Source: AGHT+IFN/GBILW5gq2qTwP+JQvZwsP6ofG/UGo64fdhGel8rnmkBWdqLor7rZi2YoFrVVCm4Y3s54Iq3+zcxE5PWlFM=
X-Received: by 2002:a05:6214:2626:b0:707:4daf:637 with SMTP id
 6a1803df08f44-707670af0afmr68367656d6.29.1753921382496; Wed, 30 Jul 2025
 17:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730234059.4603-1-sj@kernel.org> <CAKEwX=NC65XCkmX1YzivEJtPc+sEJ3pLHUsYhF60QJnk_OtpVw@mail.gmail.com>
In-Reply-To: <CAKEwX=NC65XCkmX1YzivEJtPc+sEJ3pLHUsYhF60QJnk_OtpVw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 30 Jul 2025 17:22:51 -0700
X-Gm-Features: Ac12FXxG9F8doOzHE0g2D-VIdiKuBG3pUU6xe1gaj53cRFrIK09S5oOr9nrF46I
Message-ID: <CAKEwX=Py+yvxtR5zt-1DtskhGWWHkRP_h8kneEHSrcQ947=m9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Takero Funaki <flintglass@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Jul 30, 2025 at 4:41=E2=80=AFPM SeongJae Park <sj@kernel.org> wro=
te:
>
> This might not be safe.
>
> It's conceivable that in zswap_compress(), some compression algorithm
> "successfully" compresses a page to the same size (comp_ret =3D=3D 0). We
> hand that to zsmalloc, which happily stores the page.
>
> When we "decompress" the page again, we will attempt to
> memcpy_to_folio from a bogus address (the handle from zsmalloc).
>
> So, in zswap_compress, you have to treat both comp_ret =3D=3D 0 and dlen
> =3D=3D PAGE_SIZE as "compression failure".

Meant to say comp_ret !=3D 0 here... sorry for the confusion...

