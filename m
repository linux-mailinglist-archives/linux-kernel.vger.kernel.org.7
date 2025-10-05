Return-Path: <linux-kernel+bounces-842371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D91DBB99C1
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67A9B4E173D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B232571BC;
	Sun,  5 Oct 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CA950JOx"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508417C220
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759683154; cv=none; b=PUEp8KgzBT5yi1eqtgZGIa5kGsPJQCLK44P/NAKsMbxzC+t0dk0GeCUYW4xHDbGp+WUy85IXk+g9DY1ui0d20uiacBgPACkNhZDKGwfhOf/WSOBl9HJ8goNQHSzA/HwECM26Zg5/tT6M1ElnWuQK2AkT5N1Dd02bM880Xl4AqXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759683154; c=relaxed/simple;
	bh=klBu9E0EGjaSIF9KnU4MGBn7OrAcl/0danNujMDtO1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzu/8/EXXz/we1kJ8Xjd52Z70AXgPymOY70zLCHTAVIg4onQ0iwzRtDW59fhQ4U+KhrjdF4/56DgySWZoHXE4kzG41Jo5ryaDZYOwVIA3d2vIV5IeaFLA0iX9Ig3Olc9NProxSBXiLqzxPNXx05KQ91cSymOSCqtnHOV3/Fk11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CA950JOx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso7622098a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759683151; x=1760287951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Dj6NvaIpH/yvV5frohxXME0+g0u/Dl8Qj8hAhubDM4=;
        b=CA950JOxY6htE0rjuHQLz8VQOgSpnzXaTED8anasaxH7qmd1ed9JfuOCQK4AtE3twy
         jz7nqlewC4dkyN58RGjiRIqnYTeGwZeZAqUDDfqk7Gfkz0dFeJmNuttdG8LfjpxFQglM
         pYIGB+9nlRo7eKal1taDDafXFYOnJw5ccDAXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759683151; x=1760287951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Dj6NvaIpH/yvV5frohxXME0+g0u/Dl8Qj8hAhubDM4=;
        b=CvB1/AfKPuHKaWnpbiaGxzKWCMq+GYNlqZWI8nPecyXxLfSpAn+2Xh25gTuZPnmec0
         2+uB3KEJUXwJFBj5oBFUSYWf0WFCbCJ4XI6G+CZKpOipKYaboKq8rmcCPKuItgJLDCXQ
         CYOKT3MtcpwJNVlrjFJFuibcEBEKigFf/lnGhOCSBh8BvUbCYEej0iXEw1lRxSO3oBtF
         VYt4Ead4aKGY3EXcsciOl59hX16qVnamipT3speTGJ+C/Cb3mFyhnK5cF9jwUMIWK403
         RDiapSmFxDQlG/1mp2FaR3qg2IPT3WPvqUS9x4ceBuMiul0rHu2HXUOycCi0A/AiE3ro
         69yg==
X-Gm-Message-State: AOJu0Yzcx2OcgwfyjzKebo5+5SfTV3xpkP7DGXZCNFo8rFfaFr/s2tL4
	fNw0g+TdI2XPtUgOx20EQgDWljYg+xSuntrpsJE4CZ2AlUoCX1np6ZiKZBj+0017Y6t6YqnjQsG
	W/RZ7irs=
X-Gm-Gg: ASbGnctEAvsXs+AFxZGDbogYXpCWX4Dx+QKyfD+hiVZYTsOEzhsL4ZMTMRSBWXejMCR
	m+EWC57pnNU+GfMyovLgbAex/olmFk2GKrqoT60iATfV2wo0uzOxhbSEGyVuBPgr/V64zs3g6+m
	CfhnP1OsKQ1GLBRlc7JsqxCMV77y3iU+S9sLNGiMyLFMiM7kdFbiEkq+KKpulmdDSRLrE+cIGbX
	oycZsJHaU/9H9elI+aN5aJUKCxaG73zAOja4GjZIpCSPJr7nXPhO8DOKFmIGMBR64IdvU4z53rS
	E58ky8PMS6onTvN1TcN1qlZ5cSPi2D+GDPngbpoYe7Lhx+4p9r9F7d8+Q6RAmpAfChp5y6QGapf
	qKoZzrJgWLIXa7yErKB/UIq8xJwTiJdvRMAhNCDK4r2KXFuHeXwv7KGFeoKV/aeycaOvIGhX8Wi
	2gR2raEpCV/p4xC4O/B12KFpqD0/JnRM8=
X-Google-Smtp-Source: AGHT+IGyNufDkDuzwKkNuW1GFrN1foVwXLxGmWQsem+QP99IKOcVtutZprkoGqw9vr+pB92V/nDF3Q==
X-Received: by 2002:a17:907:da2:b0:b3d:530:9f07 with SMTP id a640c23a62f3a-b49c1280685mr1307248266b.11.1759683150963;
        Sun, 05 Oct 2025 09:52:30 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa02asm951978566b.8.2025.10.05.09.52.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 09:52:29 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso765609566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:52:29 -0700 (PDT)
X-Received: by 2002:a17:907:da2:b0:b3c:e14c:e24 with SMTP id
 a640c23a62f3a-b49c13757a6mr1247910166b.13.1759683148729; Sun, 05 Oct 2025
 09:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003122923.0cf11def@gandalf.local.home>
In-Reply-To: <20251003122923.0cf11def@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 09:52:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK3W8ZNu7MkjKEbKVZkb6s=yKRjRgtSAD_KqUAAdUGkg@mail.gmail.com>
X-Gm-Features: AS18NWDAJA8DXj4nTDk5raxDF71Ytw01QHwCqcR-E45bF3JQR2rYq2NNJk3gZ2Y
Message-ID: <CAHk-=whK3W8ZNu7MkjKEbKVZkb6s=yKRjRgtSAD_KqUAAdUGkg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.18
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Elijah Wright <git@elijahs.space>, 
	Fushuai Wang <wangfushuai@baidu.com>, Liao Yuanhong <liaoyuanhong@vivo.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Qianfeng Rong <rongqianfeng@vivo.com>, Sasha Levin <sashal@kernel.org>, 
	Vladimir Riabchun <ferr.lambarginio@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 09:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Have the system call trace events use "0x" for hex values

Side note: the "pretty" way to do this is using "'#' in the format, ie "%#lx".

It doesn't do that "if (argc < 10)" special casing thing you do - but
it *does* treat 0 specially (so it prints out just 0, not 0x0)

Admittedly we clearly don't typically do that pretty thing, with

        git grep '0x%' | wc -l ; git grep '%#' | wc -l

resulting in

        40012
        5237

respectively.

              Linus

