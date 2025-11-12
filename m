Return-Path: <linux-kernel+bounces-897744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E614C53726
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73675354EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7162341648;
	Wed, 12 Nov 2025 16:29:49 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5C33A026
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964989; cv=none; b=rNFWf0y9AbbeXV3b/Kof+QdPysv0ueJmAyo5ajwgb6TWErbf1hnAFFVd5xUE5TsNcxCC0RdgfuDaoXNpL2MjBso5aFF/QVsY2TwUKUUxjf5uD8yIzLXqvUAQ+B3KN55ih+2QUsiWm5BJZ8TmFnKM76uGZM7fLCBYZsr/eGcE2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964989; c=relaxed/simple;
	bh=ooqPLYgT35A3bEL0/xnB1JjqBchWAKRzEk/UuyfrXgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvYBIfIKStk35NcAUSikLFO3qVgGn8GcpZjnyIBIwPQjGTAdiqygBdQoVQ7TztEk/lpKARwZWWfpQ9V3Oi0jcqCrbKOwulUb4/9r0GZV82/PiCJ18Ep16t2f+waW7t88d3JD/yoilO+1rY9V+x87H44D+w7Z9yMI8kZvY/ezaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89018e9f902so599055241.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964986; x=1763569786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ9QkedKrbl8l0TkhBp4GhEXOSA8xdv451nd8vqtfOo=;
        b=lY7/FMC10KpzlDWJwwoLuOY3GfNkJnPwuWFGQiAUxgGiKO8vsCFKNrHFe2R39yyP/T
         tObfGMrKzkCLvZyKxSsvniQ/b/+8Go6XmkWhVOnygfGBNmd23LzTSUnS2NzOi9TIY7uv
         juHxYR+Pv9sfZ3vLkV8Rfks0Eydgrlcmsn6eUZb5lTBY5G4hX8z6wwgit+vYg+9sLSO1
         GDEuE90bdYfwgCn6JJ61x8AvtCLGqctRfEBO+jfu/S0mXhcm1uXrXcDuUrq352IGlvcv
         vQXwGvz2PYF0zXew/vS4Kg4GKCUwZt05uUZs/0bHrNLVH6QM6ZlrPWBhPkmgELp+D4Mc
         1isg==
X-Forwarded-Encrypted: i=1; AJvYcCXAdBzE/qFEhtvDZYk/JN82QyR7d4NLo9YWoL+4Kj6725w1lizIzjAHst4w/lYYGjGj5y6cw7nqBGCW8d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctbgXH+JKNOmu8V/8JeHYYy3mTA6i4rFM7q+Cbf6TqyKz5uIT
	8k/uAL5QtkNQlsiAS+cM7NwH7MEgv1dch0rjHQQnmCiBm0bqnWF1goGRR+oyOJ/7
X-Gm-Gg: ASbGncsu/sQ1du309KzkM7weEkhn13K/LSGRcdMQdenS2iuZHHxZyj8dE9ql9uAL9DH
	J9EzszmHaNVXFRsT5tluj5E7wDr6RkVEe9XgLrSgSrqHDN9JHYqqrLCegzWXldopj/xpxV4ucqW
	TKbGycnXMjn7o+9w5mTSxl9wUHtjxIBZ+Mzf1qqk1KqvjHslYu/J6ATbAtIsxJ04KavHXHF3Tpg
	YpEwvReq6VJYr5bN7vbDuzONz6BI/vnUbSGUNvenA7TwqJwNyjK3e5ONGzFjmriJxJMYI5K9Cd5
	xNaLJDSWiHit8G9ZXJQaWv1UAQQQQ64FlcO0Y81loh305CS5VZhezYL+noSrcmmD1ZT1ONddptH
	u4fzFK+B7SQxOGGKeNFNKhHyszb+EvjV4I/+dhldXwkvRrVnLfNH/ulTmGpQow4OpbEUStdgXZn
	PjH9WdlVCmDGNR/l+8zCUkuYxPoH1YWqP4jCdcgeG+9w==
X-Google-Smtp-Source: AGHT+IGgBGv0vf12EsNaP2JUSN/31TglgJkiMftjQxcKrvmHs8yy1vEayRDJ1SjagUJhHeXyWDoGVg==
X-Received: by 2002:a05:6102:4414:b0:5dd:888a:5d54 with SMTP id ada2fe7eead31-5de07e67c33mr1259985137.33.1762964986071;
        Wed, 12 Nov 2025 08:29:46 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93727691ea7sm4982144241.8.2025.11.12.08.29.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:29:45 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9374ecdccb4so557510241.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:29:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWIyDLAbEAqJBPP19zIrJ9elDG4L41UZN2iLdhMvw7vAc6seeD1Wv1m/vuCszw6ZhZRD8AlK+iAxaVwRM=@vger.kernel.org
X-Received: by 2002:a05:6102:3a09:b0:529:fc9e:84ae with SMTP id
 ada2fe7eead31-5de07e07256mr1206304137.24.1762964984856; Wed, 12 Nov 2025
 08:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-4-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-4-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:29:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUaWzqhq72vAXCTvDzB5ErE1Gc40BULACBpOo=iTap5g@mail.gmail.com>
X-Gm-Features: AWmQ_bkC0_Wg5fCJJPXQ6L_Q8L_w-f8b7m8ocLXvvZvYMQwFGXBxxwK4Ooi7Isk
Message-ID: <CAMuHMdVUaWzqhq72vAXCTvDzB5ErE1Gc40BULACBpOo=iTap5g@mail.gmail.com>
Subject: Re: [PATCH 03/10] of/reserved_mem: Use dt_root_addr_size_bytes()
 instead of open-coding it
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	James Morse <james.morse@arm.com>, Chen Zhou <chenzhou10@huawei.com>, Baoquan He <bhe@redhat.com>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Changyuan Lyu <changyuanl@google.com>, Alexander Graf <graf@amazon.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 15:37, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> Use dt_root_addr_size_bytes() instead of open-coding it in
> fdt_scan_reserved_mem_reg_nodes() to improve code maintainability.
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

