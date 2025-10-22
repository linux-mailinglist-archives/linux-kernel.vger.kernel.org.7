Return-Path: <linux-kernel+bounces-865885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48744BFE3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F451A0155F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E5A3019AD;
	Wed, 22 Oct 2025 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7XkJIrI"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501032E62AC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166691; cv=none; b=piQ7ghK4fZiCJ5oJZ2o+9KbtbzW9+TGnu/E6L36AoMPfrTcrxmqqXrSKROss1rurNplZ9F2va0t5CwTZWbJKEkzMlKHHc+i2sTHjdadQIjTA/MH+rm2qpwqzDorlhuKQfcchSH9kG8Puj6ouAqZ1iol+iSTHa97W85IY58PABz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166691; c=relaxed/simple;
	bh=TQpYo82do9fbPBhDgOo/xfuRqTcK0JdKSr5C7vhi+wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4BXWBe59ol/AHVpb9uzuA212eM0EHI7OJ4VbtTZVQnzAxMKGML2BR4ymnzDNen3axBkZ+5oPFHe6gSRcs7fLHg/OA3T07nTYNPnbNp9AmH0guUp3jZKD5lzeE6SDElwMgqJCF2/I2CQ4Azg2OI9wctbKVlKxvdEu3lc1BH3HAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7XkJIrI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so1239a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761166686; x=1761771486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KntpGwyw2h1eRy075Psp2+8kVtmZoXi9VrfpKSJ4LV4=;
        b=v7XkJIrI7Mdd37n2sXuirq21chYlo91VOEZZVE+iNnlxw/nrfkxFwGYL3J6q8gXcPZ
         wpzTemHYt+RbcRcTIASA44rzxN1qMzjpRF6OVs41oJKdYGK1cCCBgd0fqvqg5e5S7/hi
         Pvjb9bp8egNQv/lJlr5sb1pMC++aKLCIhrPvf5oZcUMKmJ/L0i/QyjM8OeNpUSEprhuI
         76JNV+8BzUNY8ZyIW5QjqfMoOYLoxdj03JDcE1+3Ij5my2SpSqXdsLbSpNberXHbnxnU
         G2riA+BaPsf5yB4FzraXY+Vp0ZOLtVwQd/571ZbEVJZ6LXZZUL4Ya6rYKeqet7WTxJ5/
         Q+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761166686; x=1761771486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KntpGwyw2h1eRy075Psp2+8kVtmZoXi9VrfpKSJ4LV4=;
        b=uEVMiHNFuxN9AM1bApX9x89v/j+UzAgJPaFd/cLvEktKq15zUt4I1hzMvWUgygSDk4
         2DKrGEGfAy5/eF9YNoEjz/TO7BbsWiPG7hl+/RK+YYsaCESelVrTVxrp+3MvvEHbuGQK
         m1ALB4mKQenFFXccfTTOSwqfR0KVpgNPdbfT8f1lOIcDREfoTiGsmQirs2b8R8QVXZD7
         nOUzV72i7ApvibPRBBInFIWxTAsqZYUIS26xhOE6cmOMAs9Ijn50B9sOzmhXKXfOTZoU
         TCOHCDDchDUr6xx0GJUwVnmpv9pr189APxSsrTVTXVa/g2GaL0A4Vh2IAMkC7J1LwZkA
         E90g==
X-Forwarded-Encrypted: i=1; AJvYcCVAleX6KOi67HUfKpi5a8B0f4WCj/+g23h56O9+FLf3hpANKrWyIWdoD2lgF/MHY8Xfbtyyi6RcpBSJXbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKROAX36ORKpN2Lzia1FAV6/TSQPtj5mu/oEQTzJq4IbLAXWd
	SrSK7AacdMSQUn8OWZ5gOb2VHq4yl9R54B8R4flKwVsXVBKkYx+nYIAwKC4pfo0ZNza2NHkLcRb
	JfVlMSMSaHf2jce8l3pNeUseRu2nJCM93L/+CWtiitvr4PFuIV0cRpM4qog1twQ==
X-Gm-Gg: ASbGnctMBbgCO0O5t8ZjRzYVcPWhlZjLHA/j3EvRT4UkaZwclfJpX9vq5M0ZjrhsxUA
	L5ykDWBrLijSIx94gXZ3WaG61rNIssARImrIprbLuFWGJFBQzsSoaWaqUTzKOTsGFg2QcHwSPiT
	HCyyA2Iy3QfIitsT+wPaMnj8jlgDL4jzhGTCQIKfmqGJ4EoPqlbNG+HKJ/2mQhAseBmYOEjuaMs
	7frat7o7OT4qWBMuIiWJoJSvIINTi3sh78c8LI3k/yQXinLpq2cNIjM80coHEToQnUznfedjMRl
	RroUaBmRFkr4vYdnRENqZheYsw==
X-Google-Smtp-Source: AGHT+IHgF4j/mUZEDqZAl++xOkAYLCnDO8Iy/nIey1xYjKyG9Wp2IkcKh6OYcT7hZgMYLxTQIiT4e0yyMs4NIgQAgdA=
X-Received: by 2002:a05:6402:461c:20b0:63e:11ae:ff2e with SMTP id
 4fb4d7f45d1cf-63e3dfecdf6mr6012a12.3.1761166686350; Wed, 22 Oct 2025 13:58:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002131900.3252980-1-mclapinski@google.com>
In-Reply-To: <20251002131900.3252980-1-mclapinski@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 22 Oct 2025 13:57:55 -0700
X-Gm-Features: AS18NWD7w3Vu9VTTfAZBw3yA23oVp-mhN22JxweH_RPe5JsaBthUo_xHsiEjfTs
Message-ID: <CAAi7L5cJ=D76pD4tb5Bs0ULGXMEOM_yQcftFBQMZmzDJTzBZ+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Thu, Oct 2, 2025 at 6:19=E2=80=AFAM Michal Clapinski <mclapinski@google.=
com> wrote:
>
> Comments in linux/device/driver.h say that the goal is to do async
> probing on all devices. The current behavior unnecessarily slows down
> the boot by synchronous probing dax_pmem devices, so let's change that.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  drivers/dax/pmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index bee93066a849..737654e8c5e8 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver =3D {
>         .probe =3D dax_pmem_probe,
>         .drv =3D {
>                 .name =3D "dax_pmem",
> +               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>         },
>         .type =3D ND_DRIVER_DAX_PMEM,
>  };
> --
> 2.51.0.618.g983fd99d29-goog
>

