Return-Path: <linux-kernel+bounces-777970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEEFB2DFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FFF1C46DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B731E11D;
	Wed, 20 Aug 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7/cJFBB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9CF31B10B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701288; cv=none; b=p+IxpOXJf09W5mMej7stcFiT04xjxdUNhF2bR/t9N39TjylWlmU+KzNZDB+q3rG/WIeBShQ0MiLYxoT4MoaPF2EpVddYR+2QG1GonGWWxZc1fhOCixbV1TQDkhc1V0cF9am4tnNpQyI3ueZytNPZeSW5YzNzH/pGLTpSxLvbzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701288; c=relaxed/simple;
	bh=IUrGjrl/l1txCsSgOPZXbhPn6Tnj3VCBGH0kaDqFOLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM/5QTB7m0KOQ3oL45xlVBnIyVsPKo3E2GCWmgr4eEY0pz6JKDIgNWCb7lKvruaKw7JREku8ivOmpj1tikfqTsqnGvUH9IrsRx6BFjrmI6oYtVGkB5a4jYTtOIs3HYGX/T1EDcL+6pI8budFzwDyqFR9/UvXtRyPfdET0aprGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I7/cJFBB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a3a085so1010523766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755701284; x=1756306084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhUBGcq9KiQJcxiCAotwdJ7eICoMjF6+FIweyxl7rFg=;
        b=I7/cJFBBGFFd4XduoJvX0UePccmDmPbhGZLo6qmbVXx4apJmb84F2r5e2BACTgrZkS
         DoMKapNq1+mjYIq4LZhMDPlHxqojuzCD6Zh2/WrdPDKszKlxb4XsdxP+Sg8pGdf2bHJw
         J/MfJ7oCLzwAGaKNyJQTBWYAFR6u+WnKPlRUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701284; x=1756306084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhUBGcq9KiQJcxiCAotwdJ7eICoMjF6+FIweyxl7rFg=;
        b=O5EXxr6GCow1tb0rqbkicDEfbtQpMsJkbwoz/9HBFGbdI29xmFCqTRiYpdGP/qnjR2
         gdQGuNGPZlhVIkE0L1J90fvIuA8JvTQIN+Md/VQxrDQNPQRrG+K4Gd/HLlo2gzdA2xZm
         tL0w0s+08e3Iryy5gRKsPOADtjlVCKuIJljSyMyZZBod6/3kPyqDoPn/fvEm2igydY9c
         jM5WjlhcJ/Za4LFtupeMREUUmR4U9UY+K5MgOnQ2p8LR7UfRShjCX3vFklSa5QcrHjZm
         y6PI9rGxb+PfPJClgRzF2jT/7W74ZP98oa6DmDB0NOdrdFexhiY6vmIZJNe+DfhJYPRd
         hC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUpm977noa+4ayK6sICa3Oy26W5177VGFfzX5KsZsB+3goigQXlBINPM78l1Aun/jEAKAm/Pemlt25vwvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBW68XXdlPQERCY7L33Wqt34nwb9AvXGUgLZ17aAHgmh/sps4U
	77kWVrQPPyqAH8TB9xja7IyL594riGmbfqLbuBfbw0XSasfFr1ZQlKvzx6WZ7wEFUB0aSztXaQx
	hkPiHtA==
X-Gm-Gg: ASbGncu/PmoFEUmyWXuRMOHX32mMML3fieP13YEWanYoNvre5CbCo9UFPwNBeL52P6b
	iWQ5rrfU0SWShQpXttmkd0ApledMOdZQOBsNvjdqX8PLQClKj50TCYqgu9QJSYah+Ccwa+E/N5V
	/LXf7YS+4Zod3qwHRa9C3SL/KRuDGvL4wSRhIU+wW1VsId/Ges7jKCJrHZqZ+P827DqhLVQW+Bo
	m9eezSaN/mIL8AX7JN+b5RxOVlqBEdDCm8N+KqEHFDnMdWK15eOft4IX6/2+38ThG4lnsGnP//1
	BgZWYWwcN4RpoRsSmQStzc7MjXWOwIb2nfzMQJxneKXw/1/Paf93A1G/wWNHWGgv+srYg1+WBve
	dVwSTGFN3suPeCSgKsXmflvx9KOBSoQ8o+Xnsminlhk6j/Ya8a4adZcWPMJrMNw==
X-Google-Smtp-Source: AGHT+IGE4+Vpvd9/JUITzpvyI+uipCi7q6tCAPGovjfwCojxTnMNhCUdTaOR4tUDnVjqT69AaPyPGw==
X-Received: by 2002:a17:907:608e:b0:af2:80c9:7220 with SMTP id a640c23a62f3a-afdf01a3084mr268443466b.36.1755701284426;
        Wed, 20 Aug 2025 07:48:04 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2ba596sm190994266b.8.2025.08.20.07.48.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 07:48:03 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7347e09so1086560866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:48:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/nbLL5k+69duS8Hmv0siKUzjraka5r7erHIyBDTi1VC3DSZndPflrZ8bt2J2Q6T6GibWG5/iTXe9ojQg=@vger.kernel.org
X-Received: by 2002:a17:907:1c27:b0:ade:44f8:569 with SMTP id
 a640c23a62f3a-afdf01a0f35mr268297266b.42.1755701282745; Wed, 20 Aug 2025
 07:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com>
 <20250820122520.3356738-3-yelangyan@huaqin.corp-partner.google.com>
In-Reply-To: <20250820122520.3356738-3-yelangyan@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Aug 2025 07:47:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=C1oycGMS2GvGQWxVMR8h-4kv3pXQrH0rXyfvqwv4PQ@mail.gmail.com>
X-Gm-Features: Ac12FXyiFWnDzrYzsNCIRBTvsCzSDFE08U3w3EJvjmOQdowoUEgqgJLZWf1XMk0
Message-ID: <CAD=FV=X=C1oycGMS2GvGQWxVMR8h-4kv3pXQrH0rXyfvqwv4PQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: i2c-hid: elan: Add parade-tc3408 timing
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 20, 2025 at 5:25=E2=80=AFAM Langyan Ye
<yelangyan@huaqin.corp-partner.google.com> wrote:
>
> Parade-tc3408 requires reset to pull down time greater than 10ms,
> so the configuration post_power_delay_ms is 10, and the chipset
> initial time is required to be greater than 300ms,
> so the post_gpio_reset_on_delay_ms is set to 300.
>
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

