Return-Path: <linux-kernel+bounces-887427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D12C38356
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A74104EA104
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB9F2E0407;
	Wed,  5 Nov 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7r89Bdt"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02634256C70
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382097; cv=none; b=DkBsyWeHhmsG6wFUwUeIjRCy2/y4V0rmMDpdLlPgBm0B+RSKToLntqas/+Y2J+jZj/0nPfCH9r2L1u66vJy7Gxto7VgVkVvsiA1SD23aJhFEfcmNM5OcI1pWtaR+NwrYH1i7aKWzARkOOOOVX22W+iAV8N7QnI00yGsNQbKM730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382097; c=relaxed/simple;
	bh=m9YdcX48Lm+WvofyNz3S/WPJ9jf2nNHMhjPdKCdpwJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWIZn1rrfjV9rhNaSSMyuMskIIcMZBaOoskPR/Qg2ZOaryK9iq7bpdUwzh+v82YKRePpxMzyA/hJNapRHraIy+JdsK6HPl65nVionrFHH8W9BKRhZFz8+icGo+gGTbcpGb8jaGcMmSDotW3bz4h7kPioRSQFVeVOPikffAZfR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7r89Bdt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so218964a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382095; x=1762986895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9YdcX48Lm+WvofyNz3S/WPJ9jf2nNHMhjPdKCdpwJM=;
        b=d7r89BdtIAOXlbMaQVie3uRWysnb2qArxZBNrFdZ0XFxvP8xEy1H6fIH1Vvc9pNEBG
         RoT8DuByeHa+uhUobr8DxTiSmvPLmEhRBoMUX9WznN7UWTQQSriC5OJNhnoH2UlgjTnl
         12oa1cFKetQvBO9BM/HQCvfVVLfvdHxih6mM9kYRR1tX/fenFHeId40iu2t6OePdQh+d
         nxxUhg9oslxPZUXvUnmhJ5g9VBeg2NFW7T/Qh3yJEpCxCLAbrr5I2rsg29CaHlZ6czy4
         USUAIYjicEULoDqFem47Eej/KivviMSBAjCDHXxU1LPkSeoTd/kuwDlfkHNKd2HBqmU+
         P36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382095; x=1762986895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9YdcX48Lm+WvofyNz3S/WPJ9jf2nNHMhjPdKCdpwJM=;
        b=o2fmgwaiTFi9M8JC4R1+D4w0PWoAnpq4BrnpSfe1H9AWQSqAZMgsyDrkf1DckM0EYM
         2p/0bK9lfV7fKhgUmSJhWjGja2qh0C/Dm36afAe8XhhaonvHT8Z8D2xyPAeQr5MuWud1
         xmHoRi6jW6UZrhSwn8U/xUDb663eTENt/kLj+nWHN2lI2cqScpNYUM53v8yir/3Bx5UF
         vdJ8jGKtbhUObJulRoXydBpyExi91G1vu/xdukb8G9qcaQTQhSGexcRKw+GzcgX2/0Ek
         5joSus7NgIyn8kv1apu8/HkSVCAUuPtmd3IHFYoQRPT+MbdJB4mNgJINIMreGB/U8Juh
         V4tg==
X-Forwarded-Encrypted: i=1; AJvYcCVNz6XdUdPgwrz48rImxlnqgqLFP6amGroSbegi5OX0rBAuAX3aPzuhshsjqAYfqUw049w4tYMZE/qPM5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIinla+zC2ODu6kBwG0eaystBjlcAybg0BEpMNDDAMB22lUu1
	LLLjyhLsUjrCRMdWCtUFaGrxDqi8UAGNpC0eTGXWYNiKQyHQZQCmMOBiKWR5Ml1yKpnoUk59GOt
	REY+0cdxAhJ9ez2G0fAyWJoJsdVav0Mg=
X-Gm-Gg: ASbGncsJMhzx+BkHNHBbi7sWT11qE8QPytetSNsBynUjRiUw8ptghuH3tPN0eSs8C34
	LJzrYHj/D3cdiLF5ahO52P/Q1j1ivJC8XEN3fRC1+68I4ljUPsvMJCDU9F1mgzVAnNxaM9xNzC9
	IxtTNLVHuNDCc5ekEVNzr4WmKdVEKTFxEfc4bRJOMGMIfaRRCie6iXCpUDFXVjVTq7vDgcBrPnu
	rjLxSlT8YNuwgFwtIBaBJf39GIsatIHu5E1Pg//WPmP3qibK1SA07HBdo4N8tySE72nj4j6
X-Google-Smtp-Source: AGHT+IHIHO30gWfFa2a8pQjfVD3lzjmNd22UhsmtrAsEPwyuVl9HAZlkCocO18RYcmuCLRaX9tmJc35cZ/AJdbxawtM=
X-Received: by 2002:a05:6a20:9f8f:b0:346:3d90:84dd with SMTP id
 adf61e73a8af0-350dcb3337bmr950104637.1.1762382095117; Wed, 05 Nov 2025
 14:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030230357.45070-1-mohamedahmedegypt2001@gmail.com>
 <20251030230357.45070-3-mohamedahmedegypt2001@gmail.com> <209ea5680e5ca28b6d068ef8e0b58613c93bf525.camel@redhat.com>
 <CAAgWFh2Zy=9vt6x4e3P6G+_RV0Hu66jyJjpKWWx4WVg8EAV+Ng@mail.gmail.com>
In-Reply-To: <CAAgWFh2Zy=9vt6x4e3P6G+_RV0Hu66jyJjpKWWx4WVg8EAV+Ng@mail.gmail.com>
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Date: Thu, 6 Nov 2025 00:34:43 +0200
X-Gm-Features: AWmQ_bk6WW3AO_AvnnWBICE7NGsiAPsdu5CZJbslfDarF5t2N6XtYRBJjhG5NGs
Message-ID: <CAA+WOBvmq_LkT97v+5Pnno7_OPWOMewew4j2dbLdcLvxNnGOjg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] drm/nouveau/uvmm: Allow larger pages
To: M Henning <mhenning@darkrefraction.com>
Cc: Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Mary Guillemard <mary@mary.zone>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do I have to make a v5 with Lyude's and James' review tags or does
this get added when it lands?

On Thu, Nov 6, 2025 at 12:33=E2=80=AFAM M Henning <mhenning@darkrefraction.=
com> wrote:
>
> On Wed, Nov 5, 2025 at 4:01=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
> >
> > As long as you fix the parenthesis issue in the next respin of this ser=
ies:
> >
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> There's already a v4 on the list that fixes the parenthesis.
>
> Anyway, if I'm keeping track of things correctly this series is now
> fully reviewed (v4 on the kernel side by Lyude and James, and on the
> userspace side by me) which means I think we're ready to start
> landing.

