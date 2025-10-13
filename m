Return-Path: <linux-kernel+bounces-850833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F63BD3FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA691896C40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5860309DA5;
	Mon, 13 Oct 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm4LZ0lc"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9230DEBA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367408; cv=none; b=RW1PsrPtE2zrEeyUgT3tPQqnLt5pODyxkPLz3rux01NTolDpUzmKyMuc3KP3li476OcfQSw8A9BNnKCzinLE6gyXCpt/YJrsC21mXc78rfkbvKiaYBqF7RWNFMqdRKePYgF0ySQO0PoztC2rH9J60CdlVMtPDhRSUUJ5OlCiuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367408; c=relaxed/simple;
	bh=AehrbhclTtoUDRENr/Bm8ZihfIN/oseRDAuymqWxuE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nleNb+WEjy19QSl4Zi75PPfzRf1uVpSV7WZwzifD9oNEtYlAOEPSKjIlmy+1PCjqCvYR1jD5S9OHxxLRt/gADBfiHATahioMXC5Kfq9xAc5GOTs0UCMtayVYDMeq4xmiaDerLYSKqY99s/+3yMyfdirmR3FXOtbyvSZns5Te0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm4LZ0lc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b54f55a290cso595523766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367405; x=1760972205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aiSy7SPQKxnXOFRglf0lpkGWBCc1QdWRr3Gsnj2XNY=;
        b=Jm4LZ0lcQYdJ9ZHsG/wCiTD6Pfh4EIP1BhafH61PTSBE/1vudWTeMWI/6dq0xMgfe7
         qRk4PnXUIpeKgPtAgXn1w4qx8tdPaH74ppZ/G6XmUPjXrPSOpTteeCd6M+XGVMA8l+s6
         KzL6MLH9o/VU9qCOB3u5vn9xGCR2U87yUJHnnM8FxW5fR/U3zCK0qfscxII/BkJ+OI5p
         gUfZT0B/r3JQ+jqBsb4vvHgHN9F9kj4bAcoJ7rBBrgonqMO1QQ8yzPnWQrORLpyoQQqi
         oqgT1KtKcdLyZBr2k7TLqib5ki+78a00ixoKWijIKtwt+e7yT6fH9TDk2bP3GQPE3X87
         I9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367405; x=1760972205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aiSy7SPQKxnXOFRglf0lpkGWBCc1QdWRr3Gsnj2XNY=;
        b=HUdzE6YYBzVP95CWt/yF2kRl0Hbxln8w9ZRiPIu40C0V1kVvhC4GXoOYcah2V++Av+
         wm37i+qaRUItjxZLkzBRRM4rcyCuBgS8KG3LAPRDpyBQ/wc9bGHxO0vmZOWHQv5BaWLh
         CkU5WNw6+2QaTzfT52k7WU1ccT1t4100Py153/lnVp+4oJNSAtfOvCF0gBzg2MH2ASQF
         9c16uoDEBfI3XIIsRPBYQA7ih3sFuFZ3mynSNXxZ53eEmGHBFCJb2HOygzXMIteaCtUl
         Hw9m/DZZ+gvdegF6p32h44S6hK3PWJzxGFiZJ7gLB6yAfNZmtN25x9Eq7lB7tdz6nkno
         C5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl0m8EfLpvLJlHsJkkbkkR3wc9LGwL6w/B8rhmScEQq1qQ0A1vO7HPmtx5iKy3UIVS/x5Tgli71wCAjFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xGIfWw1LymNfaOyZGwXi/0AQIGGMgwxqpepSS88LheIY9AgR
	hpX8g4AoiGr0B//GwYXqw7DijLnIIxgIHlbQUDy/mDH0HBl9jbINsjprK+Otxj6wqFKGyi3NaLt
	O3JGX8bb1i2e37rRnVg5iWkRK1j0xFLs=
X-Gm-Gg: ASbGncv7K6Y7h0D0PIU003Zx3FEMDBhJ9huka4vT6OjCsYrD6DO4YscUVZfHnZp2FSl
	0Nm0/J3gZaIFOVsxZuo3x4CvK5eo4xZoLzAopfKPBOdYA9DZRjWym+hLDKExfFFdlcmEjoERKsx
	vZsK+Cp3/GJLWENdguKgOQkJYsRT7Pt24AcY8Scno+4OScZUheIH6jgNFnN0L+JSp13dJ9ksYgQ
	OZvloa/5hIp3fNDEWBpWs2CUjkgymY=
X-Google-Smtp-Source: AGHT+IEn4BipHFdFQpty90yZnHdtDve94da1wmgcnb4VcuDQTWpdAlFenmdB0falhANu5gpidPUxD2j+WgGCDLtnHLE=
X-Received: by 2002:a17:907:6d1f:b0:b41:6ab2:bc69 with SMTP id
 a640c23a62f3a-b50aaa97cf5mr2140703066b.22.1760367404418; Mon, 13 Oct 2025
 07:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
 <20251012100002.2959213-3-a.shimko.dev@gmail.com> <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
In-Reply-To: <bf59e192acc06c88f122578e40ee64e1cafe8152.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Mon, 13 Oct 2025 17:56:33 +0300
X-Gm-Features: AS18NWAykio0w701fbhEeHmzQJfNFnnKmOciJx4yZvvqyOgcP50A65S9gxbvyXk
Message-ID: <CAOPX745BVB4oVUxz0ZYRRs3_KWT6Y6cGrMdc26v49U66+u0ReA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Oct 13, 2025 at 11:41=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
> reset_control_assert/deassert() handle NULL pointers, so you could drop
> the chip->has_resets flag and just
>
>         reset_control_assert(chip->resets);
>
> unconditionally.

Thanks, I'll fix that

> Why is this moved down here?

Reset operations typically require clock signals to be available. By
moving reset after clock
acquisition (devm_clk_get), we ensure that the clock is ready to
operate when reset is performed.

> If it is ok to keep the module in reset, shouldn't the reset control be
> asserted on device remove() as well?

dw_remove() has axi_dma_suspend() function, which is where the reset assert=
ion
occurs via reset_control_assert().

Best regards,
Artem Shimko

