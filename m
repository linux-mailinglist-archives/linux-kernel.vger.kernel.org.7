Return-Path: <linux-kernel+bounces-773570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F5B2A1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C983C18988CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAF93218BD;
	Mon, 18 Aug 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="apkXGnNX"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082231CA5C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520140; cv=none; b=qwJfUEr6pq9FtBQF3hsIjlYGgP8xkDmNybWBNYAcWTPK4V05fNTfo1sQIEGQB7ekT3nhbKE873hNJ9l4S97hRjUT0sD7+Z20Zo9ADV33FKoPE0KBpYvmCFY9Po7xsma+yGAzFqHeovqTg2RRIqxdrAM7urh0KhOzR/PfwGEUzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520140; c=relaxed/simple;
	bh=NQlTT8wrBf6/5TXR7NEJIm2qofkpWCiqbqPMT/ijYsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvISu+KIOcg8xX7OcjGGIlr88ALbHJcbZeXHLNoJJAJ7GzJhvYnMWx8t5JsznBHnAJhWtYnisIFCC7tyPlgpkG0VZbL/O7fecRgTIAUzLYopS4CaFHiRHPWRalz3E9SG8lfE7k5T0gpLUmNdk9Xc5rGZXPTLxlUSqLOa5SeNDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=apkXGnNX; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e934724e512so1236528276.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755520136; x=1756124936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQlTT8wrBf6/5TXR7NEJIm2qofkpWCiqbqPMT/ijYsM=;
        b=apkXGnNXgGl7aZxSKibTdp0qeTPDTjWudLdbIDXHjAoMM9924TTUZQFW9AuxSMVXtt
         rl9Amti5ULwkeK4fcGv5CTV/3fIpDQzZZyCIHX6B7kZ9s681OyGUkigJIHkDj0RkBB1J
         nj3+vaku01NR1/y8Q5j/ZFTJT6QLouWVAYJp5Kc0xo2PDbwbV72r4EKhQI9XUaTYa1/C
         6vSEloZOCMUFA5C7yfXG1EzwMgPeD6dZ0pO8bx6FfVHPF45Xj5PCQkVEGjTgcPYjAU7c
         PSrNrqMWG+KjN8fZneGUn4hZMKjtw6TT+CsyCYg6HVYuCuvMtqXLahRPOTkzHdP420bf
         s+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520136; x=1756124936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQlTT8wrBf6/5TXR7NEJIm2qofkpWCiqbqPMT/ijYsM=;
        b=iJ73YIgE8Y2eSoZHKZqVI4nKygwcb1CVSu1Rm4prIYhxVNll0c2ziopDxH+1FPc02T
         FLTXPlIsux7S+mfLhOyt4ztBJ1Br+iIkggs/gjX2eaVmGVaIwPwrqPv5DyC9OKkQLozH
         eKm82d7gDPQQGUQUyGUwIcYXIxM1XKTNNqIHAtII8CnC5gkSeCodsSSV8dDK7XMBRCHh
         gbXK0s3rLsGT3MFlB8kysxup0kR+gEyUDNQoJccAYhwnzfgWArJ/5G6FnJN3SpoMcnFr
         27fBwF1iCXTIJwNsQIsBiTPOpIPAcibZjb9sv12s33CrxDDWhPruQb4xAkvprarKMFXJ
         l70w==
X-Forwarded-Encrypted: i=1; AJvYcCV/FysrLsoNCS5qiXoJD65PARTdvJLW1QjMNIRnon/ZYO99N/TlsgWlfwcdPeOqYB7C79gTQi36v7FAFHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZVyprX0v7227Whs5RHeETfxxdOLc5OctlmQteNsCcgYXoXgJ
	8gQmM9N+tOUPdI90U/drt5yogWRbocR3eltoTjaNJV3VzPQ7XKCv26hQMQquzVdq62VRxT2QOPg
	DltqHkryzKmV343e4+EyI3WWOEax0vPE7ts5nSJQjAQ==
X-Gm-Gg: ASbGncsHORHh6KbJXzKINQT/7Cd7nJm4EkRPH9/ahpT81eJNtt1lwz38B/fQPYvr58T
	40U/nnyBX4hqxBp7PNnKCvcLAlIvRZmgNvdzTLQSxl3CB0zqS6A7yQNGqWmIaHvoIYt0aAl72OS
	RB1Z4Ds7nQQxF0GiQ5rwKhZRpdX1SP8+kPdQJyELK8IEmZnTm7BNxXpzuuwFwrHEwj008NxMs1s
	PzVuQ==
X-Google-Smtp-Source: AGHT+IFx20xElPVqlagxACjExJ+Sc5Ef/knSr80J9ZkH6gy2bssr57qeuBMFLMu09POyk3VR+IV54ktaJ+qDsdY+z6Q=
X-Received: by 2002:a05:6902:72c:b0:e93:4496:a2b9 with SMTP id
 3f1490d57ef6-e934496a74bmr9054970276.13.1755520135996; Mon, 18 Aug 2025
 05:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
 <20250815-working_dma_0701_v2-v4-6-62145ab6ea30@riscstar.com> <34485B93B03EAD10+aJ7NVbe8aqjWBFd-@LT-Guozexi>
In-Reply-To: <34485B93B03EAD10+aJ7NVbe8aqjWBFd-@LT-Guozexi>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 18 Aug 2025 20:28:45 +0800
X-Gm-Features: Ac12FXzcLxiREAyDvYqUpnp8Sh2Su74nBhalceLEh9KttzUfLjprws3CtQrXJOY
Message-ID: <CAH1PCMahKsCsgmZixartnu6Tq8Oo28bMVNfoAWjnFA2McOOU3Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] riscv: dts: spacemit: Add PDMA node for K1 SoC
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz, Alex Elder <elder@riscstar.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:04=E2=80=AFPM Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> Thanks.
>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>

Thanks Troy.

