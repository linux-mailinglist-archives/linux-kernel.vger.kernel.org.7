Return-Path: <linux-kernel+bounces-897745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57EFC53A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEEB562DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B6288505;
	Wed, 12 Nov 2025 16:30:25 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101622BF00B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965024; cv=none; b=AbKy2GrnJG9Oybp99XD2usdaz8w2t2W/haTlmA+EjxsPzWqXruz/gr9zesVBgcT/xLj+37fYMemOC/pOGwmnjX6OKctVRk+XeExM9ls7Z00UmblStpbJ5OHbpYUQRaT5LuKg3XIxua30JZEWn5d4zR6nxMFsD4vHBwG2/yJ12AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965024; c=relaxed/simple;
	bh=srIh8TEWLd3BA27yuqff8wSQOYv+jCbG5j9PAzoS22I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAkVT6MHMS4XHOzkYVFb+S4VmYTgtIK2RHn6TIR+1BVlR3kxK+iycIePMbyZUzArpd5im009u2aI/CbdmGdaHX9JmE4VWCLRVQxRoLpfm78eM0QnLZ95m4fFIXcJFDRQyxm9MXtRo72qp4+EQOccPAFZBg8P+fnp4iE6Ii5JkD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-559748bcf99so809418e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965021; x=1763569821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrPXEPI0kQxUXG/szYw6Okg12C7PAk0aW4ESJ1E5iPg=;
        b=Lq+BAYd8laTMefWyUnmC+gXaWL0EnuX34aEMxnOV9sIyHYLn8ZObc0MkwNfdFZ+lRm
         teEcftRT7sjjeXJj3uahAMU9rxoAz00FP//xVbuFAYw3Ayd/PLn11tlmLAk/sCkrNbKZ
         pUc4oh3knjRbidd0LjEWgydwZWuxWWJkUxxAPCo2Mi4kombb9JKQEgPH4HhY8JX0gs9g
         lXZQJ+uvIqZDaoi4cWXOYVk0XI8p3CGG2m7aDCdNSaDJke7j5CuWNcDLxp4paM0RXuxz
         c1G+KriU2lpgHkCcPLGP3wZxOvu9lcmud9qfqF2Zujq6YGhu4ftQ0kMyOdbTCUQBN+nL
         YlVg==
X-Forwarded-Encrypted: i=1; AJvYcCUIIKOt0iTtGTn6mG0hHDU7Y61ofZL64Vt/UYMHnDG5BiFkOOdV2Y+Sk4N6fDbUsDPjXpPppuSrnX/o7bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLLnLJgISFkJfIYkaSFe2+qnS6m1OQ9jk0o8GTyNiY5h33Dge
	wBaFWg6E6UZiSHC+w/8U2Ee8/3FjEZdXPpF8jf3YeWRMcZMtnduRqzh+Wt6NVQmj
X-Gm-Gg: ASbGncuO6QHGX92FsDEcpS0ze5NXiC/jS5lixequ71IMCPWH1bpH0HXlMhTbYKDkinR
	/egNB7OGxQMRQ8Kz1sKUYw/eNLmaTCdroLndaLHzELvfbvXT+2BLFRAgEqb5QVD1IvB4+WyOvei
	WxDc2vUAOHg1ClU28YsTi72S62KEUl0xL6UfmzGgScFDPUxTvhw9Wpa68q6yHB1wvTEVwPks92d
	wtL0LpJFoH72aBzUhcWgxKQb+qoNTO8Xa5zOs3B265cAmoME3ANqHN2yp0wMRzvFosUQkfudisZ
	tUxq+QrXCD7tCEAYM4FB5l1a76W6ygHghW9sTYRohzAIpt0JYkC74yEJewmblmScH9IOOfg41D+
	aSy9rVhv6/iUg0F0jE4EOQ36TZuFtp3KBI4+JB38oUSL9vifKJPHtQgupk6B2VAUDJ9lIKYm6pT
	1SOayb0pX+r6DeDFsLMdv5k6sJpOeqQf1Iyt3Idw==
X-Google-Smtp-Source: AGHT+IGihIBhOayzkK5C6XrUCPK8W5NdgUIYticCY49GrOHkU0oEzf85A2HT8g7DtP2Mb9DY7Z18WA==
X-Received: by 2002:a05:6102:38cf:b0:5db:eeb6:8125 with SMTP id ada2fe7eead31-5de07d2b07fmr1220762137.12.1762965021389;
        Wed, 12 Nov 2025 08:30:21 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda1d29399sm7913283137.4.2025.11.12.08.30.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:30:20 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93722262839so590039241.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC1FuMpHXcjFVkYd+5SiVfOiyopLf9AzJO6Mx9wFJle7nJyXd4hwXBCS+pwAlXtNMApPRCKyLiWGaNjsw=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0a:b0:5db:cc92:26f9 with SMTP id
 ada2fe7eead31-5de07ece779mr1298708137.39.1762965020092; Wed, 12 Nov 2025
 08:30:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-5-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-5-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:30:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWntw15nwUP_0aekE85t21YSCJ8pWxAQouCYMou4y601w@mail.gmail.com>
X-Gm-Features: AWmQ_bmTnfy_5vi2sT0b0EhSO9dz10I3Eyl9AX2VJtEthHq6yIgXFifhVJFCFZ0
Message-ID: <CAMuHMdWntw15nwUP_0aekE85t21YSCJ8pWxAQouCYMou4y601w@mail.gmail.com>
Subject: Re: [PATCH 04/10] of/reserved_mem: Use dt_root_addr_size_bytes()
 instead of open-coding it
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	James Morse <james.morse@arm.com>, Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 15:37, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> Use dt_root_addr_size_bytes() instead of open-coding it in
> __reserved_mem_alloc_size() to improve code maintainability.
>
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But please combine with the previous patch with the same subject.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

