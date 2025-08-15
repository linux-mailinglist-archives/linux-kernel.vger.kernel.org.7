Return-Path: <linux-kernel+bounces-769816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E2B27407
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F22D1899157
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C331438DF9;
	Fri, 15 Aug 2025 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NXDusvXL"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE53770B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217719; cv=none; b=GRz7tKz1xPE5/GnyNOQrw64snAWIqyeRuE7wNgQonPu0UGmB77b+hl4qSmbcQOqGAb97m9oZ2yYOKyQ6XHxLJkGVE6W3Kd40ZrBO/iW1fH6lJM45f982W7EQGX1+uamIJJA2XZ1EMJ4HUMDQ55VBwcm1AOyxoiuEtOd0zLM2frQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217719; c=relaxed/simple;
	bh=yVKMqWKrf5rQ1fctBmoCT+YVt0KEBHfv/Hl5qX2iIME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afbgH7DEO9KgrqkCQFEkKKbJNUciSYW1jBIG1ikhB1ibFteMjvRtpi401MoFVR9SZ155/wGuPTJydbhwzQJ8hhbpBPowHXYfs9oe4oQuOKHaecj8H7ZLDxwwSY7Vu+m7FX1ILDp6WCEQ5c8sp1wnCRsBN06OgmPYoH4ccGC4yaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NXDusvXL; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e932be1b11cso571914276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755217716; x=1755822516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhYHAOHHcTMvb/JsfZaG+H6/8e/UtvwiyrLLiJuYoaU=;
        b=NXDusvXL6RDgCRCDxKUzEN3WI/0qcEQ2PSOIsIplk50EGECaDRzbcUDEU3Zly74X6b
         SPQOPIrjBciSruYWWrG38SLwXySiwpcO+bGJOGrJ0yV72ChYATs/Ubdl0+/YwT5JBt+e
         T4lZPNS5vSdQgeq7O1CL4Jkjld8LLC4618XEjFGDObi8Ddd+u368ArYvz/E3wGH/Csvt
         NaUwTP2vssEsTWD0ED5gbpJTEOXHw6XhHMnk7MVmVe69ZPaD5zdhXD1BAv82PI/HJ/+G
         br9tNcr1lb45TBfub/uy9cnqllsnE54QUx+M3lHw4pkTqMEzbYT7H0OJgZraD6GGk7XP
         YRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217716; x=1755822516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhYHAOHHcTMvb/JsfZaG+H6/8e/UtvwiyrLLiJuYoaU=;
        b=MayFvtb0r95nhe2quGpxAu8LQpxU+K1t8RJhYEtBxTHDBmoiE0qbCTnblL8UOP4+xG
         h7EMk8zQuo7ZgDzNnRXH1rXuUTTQHiKQthILZtIFRKfJ6SDhk+/OlZDBpZFcYDMfy8zs
         XA+uYBvy9V75acNbE10btwwLFN5AvGygGOAzohD4VrCy6qR9ibeARe4p7nZdyxDgDrwP
         ZNKVkK/yFMqc6U7Us1Hmktl5ri/EwICyEdFUTGpYLuBMAzZ+6Our2KUfY/4KSiBHZq9I
         LxgIEjIxIRLM1VN48U6KZhViCsKjAcU211OJY3v1Jq5QVL8KVKt8lUZKPKEQK4mo7kak
         M0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUL+VnoMgbE0hD4wpY+4pWkYvyG5Fihv5BPceq5ucuQx44QShRCp9ax6+vi9HjsUIF+jrZzAWvJgWvf0fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+borXg/ZYyi3N5HhCcV+J+c1denqC7Af1AnuDMlzgNWtebRFk
	j4O8YsFWu5fenKtZK5F8tU8QwfmhSjdl6WhnE20f7ieo2OL/zq7tj4gMblzEfVf2EHFWocPF8EC
	W0H9/xcF9F2Gu5U17ovGlvBXnO2+plSHYiW6q552TpA==
X-Gm-Gg: ASbGncszKnJZkLJy77I1iqIV5WlPhVE/ArPoe7udIp8ordUkWZqanUmchojSaDZnb+p
	nJKbsezHFJGM2rrFrXlWLlelJeXzkmPThTs9VCRZXhSm8ntV7oSej5dg4GxWv21zeNUrrNeJ8V3
	8Zo1fWqwBkuChJcKQyriRtPc/cRVAgZ5Lm6dlnXIejNOixWmnxt382diISd9gzGLe+dVgpMbZ+/
	dTlEcpJ
X-Google-Smtp-Source: AGHT+IEWHgZsAdK4qEvDGvsR02TXcwc61mkjg/mahmDjUByNY1vc8hT9AhSsb4gPaZW5ujgSq5lJQRMSMiPVldUmqB0=
X-Received: by 2002:a05:6902:70f:b0:e93:2f07:3fd2 with SMTP id
 3f1490d57ef6-e93323846bfmr333872276.5.1755217716217; Thu, 14 Aug 2025
 17:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com> <268633D49B18C3E7+aJxMHPhItPq9ioto@LT-Guozexi>
In-Reply-To: <268633D49B18C3E7+aJxMHPhItPq9ioto@LT-Guozexi>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 08:28:24 +0800
X-Gm-Features: Ac12FXxnSnbbKz6jQ95n94znx3YpWdrJ0lK8qAhRBPKv8TxP7rZpNGXhbYfh50Q
Message-ID: <CAH1PCMaMm+aDXG4AfPbZ_iJQW2cuKY=VMU2_C1k6Vi3cBBSthQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] dmaengine: mmp_pdma: Add SpacemiT K1 SoC support
 with 64-bit addressing
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:26=E2=80=AFPM Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> Hi Guodong, thanks for your patches!
>
> I have tested it using i2s and dma-tetst.
>
> Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>
>                 - Troy
>

Thanks Troy.

