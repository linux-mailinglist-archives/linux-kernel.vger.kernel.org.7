Return-Path: <linux-kernel+bounces-835378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1DBA6EFA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E1017C610
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451A2D9ECB;
	Sun, 28 Sep 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/XX24QA"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F31EA7EC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055043; cv=none; b=kQwIp5yGZT4RCkwgJqFn+v4e/ex69rCodIdsEemBARntsDBFvX3Z4p6GwrH7slTRxq47ItXe7O/rkKwVWIYp6cSqBQnLC7KYn8gtSFrbw5TeGkGI1SIEItdqr50uFVYWV+ON6NlLByKcd4Fr92PMtkZJrp2Bo3hsZClWhCsT3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055043; c=relaxed/simple;
	bh=D6IUpv1N1uqZnzwjcSW/CDPKsLpnOn0CcSzXGCV/+/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkfhQPnnlIz+6CN1k7X43Xg7DPPuITpEUfQJ3M6Nybo+aJnU5zPK4NfGvhjMlFYM5aQV5KVkBWQDv64g9H392BqzbNls7GYiCwcRIPd4a2Vlim2RZloMVYsHnrlDk3gEKq0WyJvOx/qLI3Ga0ZUF2o2WiCZFBdo0i1tcsg6t9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/XX24QA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so5307637a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 03:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759055040; x=1759659840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=D/XX24QARRVg99CyYmaO9aZB29n9O+hNxVas7M+YzXr5W7iyod8yNdTxpmyrKOV4SX
         DIfaJZoYKVQ9KEXkBdz5AID/d9kdtcD7ndQNhTpu2Xk59V2jhcI3OpiXANWBXkrz+eQA
         r8DCz+sL0/yp3fEIavbG55VbvrNwtgV74aMrTXJ0BsTwNp+PDCQLEAgygdChwzwpWktJ
         /x2euhGfuhI02XnIa6MLzSDchc8s3K0CZl1Uo7vNt9Bbnj4MhMEaBsWCOGFnjkpTYuZF
         AWMV6ZS36p5oLtbP9Leu83seM5pLLPG5rjgV/nKptnplpwcVzIdTjn9sAsWDQ/reRqYF
         5Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759055040; x=1759659840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcChJkbyyCyxxnYoZ0h2dgScTYQu8ypUACGdGHRDEY8=;
        b=RwWo8SkfRdpzKqhgVOZwjgQwHk/TS9fEHHwHaxoj3WrKwlzt+ErQtX+EAiRIZXx9VY
         FMVB5zZWLa1CFWdzMTnJMeCyM2RSlpQw55vv8AQlz4e3O+x2P9HZpXxR6mGgQ804ei0L
         +mmc7WHRlh6sTE3irktalAJVhewCXCBE/d7Xxbi2GthAAEJKMwK4iJR/X39K0O47wu8A
         RxbeWzurqpXhL1d/U2/spyoeMKQ0LeRpwlN9FQrBhnaxRnIuETLwUQx/lRv9Msd9rI9x
         roic5pGt/yoM96U2BSxtOa+yYjlBCEwCFR37c6h0YOsa30xxphazcfgseycWOv8DyhVL
         NTBA==
X-Forwarded-Encrypted: i=1; AJvYcCXdKsQBeEEX5HkedivLt+5RAlvVM9LEUga1uUQk6SXM0vWGH0BdZ2kgar2XJijCFEJO8whoatOnXyZclso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXnWhKQYDBd+WpgDIvPXX5qbaOJVMojmZjVZfJGQ19KjwL3JT
	nDFq7YdHWMImuajkHNXvIbQqvdniCQqlP3bLs9oWfd9H+Nhj4BeknDKxjVzZInGPD2NWs0PLCC0
	XX3/rW2wOSiGNTWJowsKbs3t9B33vmwc=
X-Gm-Gg: ASbGncvNXhqv7RiUWvJgrSFWUah+GDDdtGvQW4jIHqZbyOEM4Pme6nolsX3JihzgCUz
	HHlROR8IVLcI74LHNN5Mrr7Tg56HcK7DolRTDgmw3yNGq1dAFpvtg7PQlL33o7Gse2k7b+yFWTQ
	Cq4+0QaajmCBVNHaeW2N7PhuI0E6HTUTFoTVtHh6267WSpeyDO+ajfu0qtVSSa7iaFXdjmmZJAK
	S+oZjBa
X-Google-Smtp-Source: AGHT+IGAq0LbOWTh24q9bLB+mXJC5ix6EL+ilnN7HstffL1oa4ImYTxpRTBcFvmhE8oxPjiGws6tJF6LzW8U7U3nO24=
X-Received: by 2002:a05:6402:606:b0:633:8337:da95 with SMTP id
 4fb4d7f45d1cf-6349fa9f661mr8379897a12.38.1759055040002; Sun, 28 Sep 2025
 03:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758219786.git.leon@kernel.org> <0c64474985af55b1aa934b857808068a0e609c6e.1758219787.git.leon@kernel.org>
 <CA+=Fv5Q8dVUFVBh82mAe=fy3mV6mWtQT_0pBPLQwLNBt3f8E1g@mail.gmail.com>
 <20250923171819.GM10800@unreal> <CA+=Fv5SJcQ5C4UeX2+deV9mPAe5QxrocMG8EJ2eVcYjbLE5U+A@mail.gmail.com>
 <20250923235318.GD2617119@nvidia.com> <CA+=Fv5Tg7sQACpeG8aMZF6_E6dbRnN5ifg0aiHityXadxiHoPA@mail.gmail.com>
 <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
In-Reply-To: <CA+=Fv5Sze_BNmHqzypmCh8p2JO6gytXH4E6hXv3gZdfoSJsMUQ@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 28 Sep 2025 12:23:48 +0200
X-Gm-Features: AS18NWC4Nb9W4XCpYP_OV5Q9pNZrLenXw3hzv9kO6uALa6_OupoUAOrEskTs214
Message-ID: <CA+=Fv5TF+RTPEkQEmVd0_=B9xbqKycLz3ck3UwcPDqacezYfFQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] alpha: Convert mapping routine to rely on physical address
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geoff Levand <geoff@infradead.org>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, 
	iommu@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jason Wang <jasowang@redhat.com>, 
	Juergen Gross <jgross@suse.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	sparclinux@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	virtualization@lists.linux.dev, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

> After reverting the above commits, I'm able to build a working kernel,
> that is, no filesystem corruption occurs. I'll take a closer look at this
> after the weekend.
>

Short update,  It is enough to revert the following commits, in order to
have a working kernel on alpha:

e78a9d72517a88faa6f16dab4d1c6f966ed378ae
(dma-mapping: remove unused map_page callback)

d459e3b80ad1c81bf596d63d2e3347cf8c7bb0d9
(alpha: Convert mapping routine to rely on physical address)


/Magnus

