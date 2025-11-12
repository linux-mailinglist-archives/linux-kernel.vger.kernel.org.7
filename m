Return-Path: <linux-kernel+bounces-897731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142CC53708
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 804D635052A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266133AD97;
	Wed, 12 Nov 2025 16:25:54 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3C311C3F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964753; cv=none; b=buhZ/Klq5/lluy5dCokJHHBfgXuihvhMVAcqnJHT1av6tS0x+UeLRAQxDdE7d73NTcYP4plsWX4iISSZ/PPL6NtEBYC7u57YcD+3G8azA/P9SA25JNunj1FP8fFTe+s+awoSBmzI5bUwwu3vwR6K7fGO8utqOt3sf8pNc8MiEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964753; c=relaxed/simple;
	bh=KKsAI3szX8k5QGcaHEIBxzjAglk5W7KKlVx8cmhmNBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCwMsIlLIoydsL4xlb0SYwB6Oroo5nOBZMtbha/88werqLstfFfpKb3/zSS7j49aUvXSglzCEtUwB2ZBZ+zXU3ZiKx1XA9B+4F5dP5WCxV4Fa1mrg5Y43t73hJ9/6dFwFA1Q0dBt1CLu2coCQi4I+CVi+CFLMAoyhmqOfxHjqmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dd8988d098so377169137.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964750; x=1763569550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2P6mD4EHSxM2KeefnQnSLrX2dBEn9VutMK08a+7oUBg=;
        b=CtorL4cQnlushdFCHTSK4mWh6IsIfxpR+o5l4kLZJPTUHVkdvBXNEac3QPIuDmyZDV
         UlyXmO30PqFh7aE/QnFV9TQf72MC+EKYcbSsfr1G0kqeffVfr0BHhVSEOslMJ/dzaimS
         Rt+2sItPaLGJP/shTiXO2oK78u2XGYT+dM0dG0vQ00fV77P5Bt/2CBo3wBbpVYwbqMH6
         yJcV1jGox6R1DjKQaaZhsqOGpMYFMKXokr/3RSoGfcZSFd/4ssng/eDEJiwzOI/h5UTg
         Le3b6XjyhgH0/BrRE2Hewqsgi6QJK/f93RgmVleIhLp3Klr/UlflXYJ/MmDmhuvmv8Nl
         fC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh1JMsQYfbXpLBkF69JPIJbrPkgSTYEymSvnIA/DpVR8zL4t3u8j5CQ1TEBmyXWHsjC8MSO3CAKgz0P9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9QmKlTvahu+b2wgqVLNksJubHkM27v13NPll4DmQS9WBR/eYq
	hWtZW8VgXTCUQVLeJC2CxmRCNm0GDXrfOQ5T/aMGoisDFLD1sD8WA+C2mUeItTe5
X-Gm-Gg: ASbGncuapnMUNlmd+TtUGo8O7TWRAEzeNu0HsWYzt9VFemcxPzA5ZdA3EJgXO5Gw1Fe
	hVo++auXyOPuVu0vzW4faj0h5AL830qBJAS+lbaVWQQwTZsefwy2na7LeTrhLf8stFC4QkjgksR
	BDz6/EEbAmbg02LPoxQkLpAi3A0mbjtlmFvYyDmcoxvsk9G0dNcIl6g5+srN7qwOckiV1WapDFL
	iVqrbORgnVgt7h97luPnqugMnRVBLgFKALNmH1oFOtkBoAPUJmZcSbJ/3l1bJMLQMCh48maEewk
	xNndCVbbZfBYyKML9D5k4xBhIHjrRrOcmBiZjfHykveT/YfoTV8uf7RbxC+5Luo2mwcdekNxpKh
	yy54zIKcqHaWA9KCcZSR5O+VtrJXnfU+XiBHsBs4CehOfn6H6mvYaANa0/i/5Hn6CgTRKtPhaAI
	llyfBfuzKPPgkZjwpwVQ4FHNTIj59HlOAsTa/leBC4MQ==
X-Google-Smtp-Source: AGHT+IFUfeflxF9i+nzchibz0P34nOWqJEE+uJuY0317/PBDGjVhiyRoExzG+o1Np2VnYDxUiuM6JA==
X-Received: by 2002:a05:6102:e12:b0:5db:2867:568d with SMTP id ada2fe7eead31-5de07e05e95mr1091967137.27.1762964750124;
        Wed, 12 Nov 2025 08:25:50 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9372a613bd3sm4772313241.1.2025.11.12.08.25.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:25:49 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dde4444e0cso427989137.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCUVZ2fGClbaRx+L0oeHVZoILQl8/O8jk6F7TSbbN0wFaeNA/jf5JG+LmoKUNmwz0uC1N4lhO1KEIWz8M=@vger.kernel.org
X-Received: by 2002:a05:6102:4424:b0:5db:cba0:93a with SMTP id
 ada2fe7eead31-5de07e5dd3emr862566137.35.1762964749487; Wed, 12 Nov 2025
 08:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-2-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-2-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:25:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUOXjMOxOn5oU1jftAVKk6b+8LN-72H5tAqaAyvysxhLQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnXVpA5sSxuV8McK_e1ZHyzSr-EJLVA6EUpZKT19Uyy9uwBtuUtu1ias6k
Message-ID: <CAMuHMdUOXjMOxOn5oU1jftAVKk6b+8LN-72H5tAqaAyvysxhLQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] of/fdt: Introduce dt_root_addr_size_cells() and dt_root_addr_size_bytes()
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	James Morse <james.morse@arm.com>, Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 15:37, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> Currently, many places use the result of the expression
> `(dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32)` for various
> checks.
>
> To improve code maintainability and reduce the chance of errors, extract
> this expression into two helper functions.
>
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

