Return-Path: <linux-kernel+bounces-777015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B114B2D418
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC81F587ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C42C032C;
	Wed, 20 Aug 2025 06:33:04 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E641DF26A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671583; cv=none; b=QJ1O4P9s5jmfHDBnEWVOrCDkcrawS7BcaeeSCISd1sX9In156kykK9P031Q5RV6Jx+Nt/H3wgA88wfuyToZsJbDdaQQOuVzzasbEcyUsCfD01Xzx9cnEztUmTWF9TV2ptmXAOO5uTtDqZQHZqx1gQm6QajWXeyPADU9PZPbntvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671583; c=relaxed/simple;
	bh=cFf9GXYyYzCDcqXWmXlaHUkgU6RAnUEXGVhlKN+mHMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4tBTm1qyCdqBD3RWrgX5/LE38CLpH9R5ZEx0DuHzHV/ectN4JuyfODjL/um0xIGXZdBTqIEeYkEGLs9XQoTn5nL06EGzI9pupApKIyNij5hNuhV2+NcACjjb7MkVszbOGlBpLO1yEWx7wxSWyovtOY/Rq4sAxPGds3f1AX2eiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8901911d598so1916821241.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755671580; x=1756276380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vajijHRENH3stH6uGMnIuNKF3UDEhAgM+AkMla0GCYE=;
        b=hLuqCWIahJ5g+AtMVRPyX9VLxsVt/1wKnGB63rfRXK4MgFCezAFzTXCrYlF4dbhS5a
         gq/DZ5AEpL9S0BGYiap38LjF6btldBCdTwl7SJfEgkqsNkEWs4OGClp4oWOo6u7dAFWr
         tirqCjh0rS4lIax4XFzS9vvI9B4OyBL7omrz6DK9ASidBG0aaDBCBTI/oyw87EBmU5/t
         JdeM9Y1WrDV20J4uQCUjlMSb5b9QA6GG+10AzBtv9aMVTqUg2GHKg5NGs+vvD1TuLxo1
         vrqlrceTrlfrSfOlZiHIJ8YHOkYhYi32kokgrx5wqfSqh+aMOMukn9WIsk0TNauu8QNB
         LNBA==
X-Forwarded-Encrypted: i=1; AJvYcCXssX4aTvKLhbX8BicN3oxMipbVZuja5kFXB58zrY8jtsxllPYsRQvHAlhh2OyJ+B8pDh8kdLIyShldDYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGV4LF1AlkubxzzKYAibb/R2+7oYRw07zI1PS/NCcAvN8toYT
	6RPmMGtnNv4Y9JMzWpyxWk7Edd2UbV81bQ8PUqcsy0mZhHapLM4pbUwkuMFQulzo
X-Gm-Gg: ASbGnct/u3t0Ivpm4iEu8agC1IgFNSaaVQsknZz6jDFZlwJerHpDTNG4vDQgMQtgvDC
	IqGrUQIC3Vlkfnw+/4pbHcsMI2LYYaDCPwBmSQSZq6FclB21/hhR103Yzs8hAXOt9wQ3ZjXcYBi
	1flKrgv2f5VgBR0OJIdtbSeaXQJvD5cS+CX+RWyDH+8FVsBlNVPC8T+ygmw89mGdVLFQJSHitKq
	DfHzBoiQ9EnHHiPoK06IalgI+lyXjszdLW2tu2lvYBPAA378CRtGlVS+aM4/M1vKX3u5y4wWA1x
	1diFMxJhAgm76Ou+ndlB1VH1mFG3polJ3qoqRi8GFyde/kieyTa5zYPPpAnhqm0c9DWzsFU5DmG
	f3HCnOqIy+1p6XHIO6GVz3NIywgtSJ2piVcIQjSHni2bQhsjvNehevXEFWpoWzSE0
X-Google-Smtp-Source: AGHT+IHh/Y0MpHZyhBuncpj2uFfwJ4/dbVd0fcxxolbaZw6wK7+tqsPJwFCgJ3yA8tXpd4x7340zjw==
X-Received: by 2002:a05:6102:41a7:b0:4fb:dde8:76cf with SMTP id ada2fe7eead31-51a4f43fb9fmr497329137.13.1755671580000;
        Tue, 19 Aug 2025 23:33:00 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5127f22685dsm3308307137.13.2025.08.19.23.32.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:32:59 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b1737003bso2348962e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:32:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3X0iiyyH+ebOex9T7GQw1eI3GovKVStUR/urfvIcVnCTxWTfQgeqHTN58pHRw4dHDDuQXt0idI/KtMLU=@vger.kernel.org
X-Received: by 2002:a05:6122:17a0:b0:531:188b:c19e with SMTP id
 71dfb90a1353d-53c6d4da982mr572406e0c.2.1755671579223; Tue, 19 Aug 2025
 23:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819165829.714344-2-thorsten.blum@linux.dev>
In-Reply-To: <20250819165829.714344-2-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Aug 2025 08:32:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPfy6Op7UaND3eM8AFmP8vo3_4z+d1_nOQ+3fPdJmfxg@mail.gmail.com>
X-Gm-Features: Ac12FXwXcFy9wJZ9JCt6nWPVidb-8bwqhxd5R9n_Oal4hhAyd1zb0CHglZKxvnE
Message-ID: <CAMuHMdXPfy6Op7UaND3eM8AFmP8vo3_4z+d1_nOQ+3fPdJmfxg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Use str_write_read() in ps3stor_read_write_sectors()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 07:26, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Remove hard-coded strings by using the str_write_read() helper function
> and silence the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
>
>   opportunity for str_write_read(write)
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

