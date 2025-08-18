Return-Path: <linux-kernel+bounces-774045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A3B2ADEF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893F54E1D50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EBF3375BB;
	Mon, 18 Aug 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a2GUf6CI"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F78322DC3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533892; cv=none; b=pE/rJ7YQoEXBqqVJGwd/T1+hFVXST5XjZpVxnh8+nMa5gA53AXwU+SM27Dz5JYoZXuCaaFO5nhZsN6u2rtbQl4jBVMfOWYHvZoVwFq9SEy8tSQLY6ayRRcH2iNuD7l5wNzX+xtaPu25mXfrBIoL5LzwbBicSpkR8FFBzmsERx4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533892; c=relaxed/simple;
	bh=PdOuDtGhAf176yTG7bO3k8fjbVMpdEjfYrDODLaCBC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNGxyrvFQ+1dCAoFxIVrcW75ds4z6/7sXr7biLgYAVeq4rP88bCLBmOLpkyNqoCEdJSZ3il/WhxN+91cHVti6we10+Q/ZRdo5z+moZWZ/Hsld2UKPc0lBy7XdXe+Ew6P0to5pfTxkpTHWyG9ksGWHALN7A21nSSUWaYWP7WWM4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a2GUf6CI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so4098255b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755533885; x=1756138685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSyqJhkRW/MDWE6bia3ikOdWhAKQSCvYd+GVVssfN+c=;
        b=a2GUf6CI/updLpPKElStKKZaHedtr3zp4A6YK9PydvkUmqkywJmAonU/+5On4WAxp2
         SnWfGxx2Qi7BInEsQbXuK/SC7vHDIJA58fHMGIhfin0I5dgjd5kja3GolStWe34k4QPm
         HtNkCRPkBHQxJfm3J/OlNFTPY3EbyBNHpfyIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533885; x=1756138685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSyqJhkRW/MDWE6bia3ikOdWhAKQSCvYd+GVVssfN+c=;
        b=eFblVUjrH5h6vbgvRhyL7P+t8oTipqxX6yFPFCVMpXkP7TuSB8T+Oik9btgXqUJlJd
         zC2yN5dqMhQbavnXlbyGLgIMj01WGMyKBOwkDxXtZxUO9feSaRbc3LQjA6MvGqbkXTAm
         gtOUz8AAPe9KbIpnd1srLZrDoZB/sS/1xeDsb8lX/e4bps9vxZK32cXeovzsdS6bc0L1
         9XJV+kw66whgMI7r0d79fDG03iclkgMZ6TNKv3bID/9F12QaTIrLbVVMXkww8ytF15Qw
         h6dlHr7fyWMIRptH0z4L7V0jyfS8KVoKQK7bPi/TMLUJ6t+TJ0iSJC8enqXWsPGi5b29
         WKKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXybcWf598Hl1B/Ms+SW0MOsGiesklfj3HHVR4tM1LSvoAe9xIADALCz9EBvzeMeXWtZzs5gtOSb9BLYVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+OcV7pGPFM+w3eEfR2UKI4o9rbaiwhbu+dG3i4w+J6NDUIwBV
	U3jDYVNfFdHl8dwePz9ImJt324oHB62KNsgj6QN4+uWSTulORwAUQ8WWKdOnMJWjECd25UUMqlN
	FUNc=
X-Gm-Gg: ASbGncuZNtTFGvp92jW5KFnJqICVvHX8fmkCxzP4tbVY7lN30dgGEGJJL8RKFCEdP57
	VgNGWPfbRuvj7piyh02aVCLs1PBDz+cQiql5wB1YhiWtVAEOvL2dZqFYJWFnwz668wF1KOJ4jp+
	+lkcvTXtg4ZMFiXDGlRYx1CAc8TFyWrjyqmb4vRW64PI3KyDdxRglj1zHRkgTuIGwJUGmNVQeUe
	B/FDiRt6hvW8nIvFGHHrGREj914NVn3Jt8qExWj2fd8JP3qiL/ihW7ukcxU6aH5FWu5QRlxYJ+T
	m7TbtbZ52R6KtpIMBaKYQg88YVhNYiYTj+/02rtZAUS8ADVrGbe5ReK4YTdKTZYocJ9yQPq4qBs
	fUNF/oNOYdTdbIdHizNfn3Gri6Lt8k3z6mSkF2walEwMmojb2FGGuTTlt0DYhbg+x2A==
X-Google-Smtp-Source: AGHT+IFRbu8MjMAHiHdp5ZCEy7f+lBxewyO2MN9aqXf8fbplqjergSli1ro9GuAUoddP2Yc2voSXNg==
X-Received: by 2002:a05:6a21:32a8:b0:232:6630:bca4 with SMTP id adf61e73a8af0-240d2e5bad4mr20118036637.15.1755533885503;
        Mon, 18 Aug 2025 09:18:05 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com. [209.85.214.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232f7445f2sm6791855a91.2.2025.08.18.09.18.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:18:04 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445806c2ddso36986585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:18:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUB40aqQfMbyH+yCK8QgWa+1uxorrZvdkLFzXl6OLZgzrRCZpb2eeTJJphmVCN9jCng5oZYIvcA2o9ckKU=@vger.kernel.org
X-Received: by 2002:a17:903:b87:b0:240:80f:228e with SMTP id
 d9443c01a7336-2446d93d8dbmr168541425ad.52.1755533879674; Mon, 18 Aug 2025
 09:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213725.348363-2-thorsten.blum@linux.dev>
 <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com> <A627E42A-1F2C-4807-B2AD-089D94FCB210@linux.dev>
In-Reply-To: <A627E42A-1F2C-4807-B2AD-089D94FCB210@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 09:17:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtB7BB0vo9FDncgCraCwLMZyYZHYKhs5BprzDcHYQFWQ@mail.gmail.com>
X-Gm-Features: Ac12FXyuTFomjGqpD0gstTADqywrtRi3JiXkcPd3XuZbN_O76LE11WCVw65yoBs
Message-ID: <CAD=FV=WtB7BB0vo9FDncgCraCwLMZyYZHYKhs5BprzDcHYQFWQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhang Heng <zhangheng@kylinos.cn>, 
	linux-hardening@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 4:03=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Hi Doug,
>
> On 19. Jul 2025, at 00:48, Doug Anderson wrote:
> > On Fri, Jul 18, 2025 at 2:40=E2=80=AFPM Thorsten Blum wrote:
> >>
> >> strcpy() is deprecated; use strscpy() instead.
> >>
> >> Link: https://github.com/KSPP/linux/issues/88
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> >> kernel/debug/kdb/kdb_support.c | 4 +++-
> >> 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > nit: Since this only covers things in the file `kdb_support.c` and not
> > everything in kernel/debug/kdb, perhaps that should be in the subject
> > line? Maybe "kdb: Replace deprecated strcpy() with strscpy() in
> > kdb_strdup()"?
> >
> > Other than that, this looks fine to me.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'm preparing a patch series for Daniel with my kdb changes.
>
> For this one here, I initially used:
>
>         strscpy(s, str, n);
>         return s;
>
> to replace 'return strcpy(s, str);', but now prefer:
>
>         memcpy(s, str, n);
>         return s;
>
> because we already know the string length 'n'.
>
> Can I keep your Reviewed-by: tag when making this change and submitting
> it as part of a patch series?

Sure.

