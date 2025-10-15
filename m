Return-Path: <linux-kernel+bounces-855023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCBBDFF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ABD94EDB14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D93009C8;
	Wed, 15 Oct 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="QoXMAfRb"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7973002DC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550853; cv=none; b=rRi9rf/XyIPbNiatQU51ZATbm1Xw3t+eJdLCoWJ+6f1fBAuMErKDyL74bJYg9FxOe43DtFFTFeZ5AvQF3N0e7itry83K02u4lVgYFyLn1FQZ93eveyOg1ocONTB2EXbZ4F/cdbaxUwlrtIJ8400rT1/p3b6YUDZ2klL4M+fcw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550853; c=relaxed/simple;
	bh=RE3vtWpP0QvpNGKTL3HABS89YCYt7BAbRul6Y11WGjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2+YR3xOlPScTRmOtcipwgrTGNCPBlv6kz7B9DPpMtG4P1hQHfFDNC9fxK/6wt0mnYRUcg7qaYNiXDO/m8apd8Th8UYBPw9MKdazZscO4olcpu7aOJ3uBsu4hbaBKt6bDd2+PAV5TPSZmiIk96EkgRis1qlnGJzHJGBfQpcDgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=QoXMAfRb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72e565bf2feso72367607b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1760550851; x=1761155651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20TjVxuYLuxrPBc8Usx9S2ZXr8G1tQbSoOkIE3uAZcs=;
        b=QoXMAfRbi1LjTqwWFCwRvXfbrJ5fc48fSHCA8/v2u+UnOaRa2AJeASfqbyPpIsMT0o
         j4PyzXhY8cDpDgLJjAFv9eJcaESkwyH0+bquo26toxOhYE+pnAmjmfh+YS3A8CHkznUy
         lDiXgXzKK2XwlUQdAU1NhKaLKMTJXif9fFUAFBe+nCgzp9T4zfVG9KwmMpB5cvD0UJXm
         2yAeh6JKnePpFs7WCKQgbT/BRqZhch23ZMX8htAG5ZIFvxeb7TEfx+9U8FSDbRVSnX5h
         9tQj8nH2D4/ESv7yJkcn4PBQuQFRFxdCDCgYeAe9rg9FZW0Pwt+v4/023mg3pEVFoDQi
         ZPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550851; x=1761155651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20TjVxuYLuxrPBc8Usx9S2ZXr8G1tQbSoOkIE3uAZcs=;
        b=ITeK0wUz6QyMD6z76VyE1lpQ7Fv8D75ztu9hFKo5yD+oPK07GWP8hUuuvVeTghg7Oq
         3xba1hXRdGjFl/4xzF9v92Rr+8QJ0TjFw/BaEEtal1xawBH4Wjg3gfoD9bvtp33792hY
         p0BmXjI0PxoWD7/wDLN5/oH5eY4ys+JUmzEvMFeaUZhYJEZqxthmD+fe1iHcI2VG7P6u
         gWFcxSVexVy/Q4FBnWDo2qlkMmiu9/FtNFMS/YE4hIj/2t8A5gPmzyxp4f8fm3walg3G
         MIf/atOoxG/cyfoWwR5p9iGOcz+ZB/rg8c6gDHz+wh9kMH4Yya3yrxSgP7R122COlagA
         b/gA==
X-Forwarded-Encrypted: i=1; AJvYcCVZRG6XgOVYh93nFSEZtttBeIAfe61ZUs2et2YYZIE/VsoXKYPW2pPFFjXlqdk1FjT/2IBCenSQzEOl5gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LSlbgVSUeX/7Q8ixEbGEyrBIt2vBX1reXqtKsF4i4Q94146Q
	CS/2bwdv7C1S9S6a20GfB1zW62Mt/J6RXNtcPFKB+dFII1znPw7ByifRfq4ZCqWCO1dVanIEqj5
	2PpiDNNtXCg==
X-Gm-Gg: ASbGnctdKL4GV20X3isMeVkryKHm6pjV8PmhsxH7D7s6fpHBgkc8K6yMEPASkOBdxZG
	Wv9bPO67addadDLbKjzDljTs7RfeFp0jEMcaCR8ZOWU/OS9PePAjwioS4t7La4ORBUOmw+ao0qu
	VG4usON2GQJsPtM9kBwGnvT2DrlZ7Y9oKI5eeVzdBTa/ALHwDlMtcsiKRAgtWgLsjZHebPKZWD0
	ZxXb2Bu1BcvmnJxoo7mXP+RqC7e1k5fdyu505iT2xsstAiTxfwtXV/9LibTKTB7fxalcfEa7unX
	tM5fFlLUnyGboScQxhjhiCaMkNsMCtOF5uXaZETSLCwOBtWNpzeT1+HX3NqXfd7HRl2kS0I886Q
	CI9r/gIb82kLhDNtsFHVI3uStjwgKSw+y6MRZqBX7yQbUh6/RkxeCfVdjRQgO1eoE9+idfGoxk0
	UOWwCxD5Qf
X-Google-Smtp-Source: AGHT+IEJI/X0Om/X4OdP0i6jP/hd2zYqPCc2NHZo4DzNqM5kzZVFC++BUBxFxHro8tyP+knc9Xlr+Q==
X-Received: by 2002:a05:690e:1586:20b0:63c:f332:b948 with SMTP id 956f58d0204a3-63cf332bb0emr12878227d50.42.1760550846805;
        Wed, 15 Oct 2025 10:54:06 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63cd952e09bsm5860124d50.11.2025.10.15.10.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 10:54:05 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7826060df96so3850407b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:54:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIaJocRZmvKqQ8dN8zaVUoTkKxcT0vHRzDISHz5aPtsh4jxz8XulYkM6zbux6gcq0wgFGguB5QhTjd53g=@vger.kernel.org
X-Received: by 2002:a53:d4d1:0:b0:636:1ebd:5692 with SMTP id
 956f58d0204a3-63ccb8e1736mr19417699d50.32.1760550843677; Wed, 15 Oct 2025
 10:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-ethos-v4-0-81025a3dcbf3@kernel.org>
In-Reply-To: <20251015-ethos-v4-0-81025a3dcbf3@kernel.org>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 15 Oct 2025 19:53:51 +0200
X-Gmail-Original-Message-ID: <CAAObsKCcKsejFju6dxTn6AQ6MdidsxXbfxTxcUXGo_8KabD4GA@mail.gmail.com>
X-Gm-Features: AS18NWATPatMxMDqAM9YqlMk9ayn38myAnVms0LmmVnqJLfravwxby5QSFqTV7A
Message-ID: <CAAObsKCcKsejFju6dxTn6AQ6MdidsxXbfxTxcUXGo_8KabD4GA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] accel: Add Arm Ethos-U NPU
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oded Gabbay <ogabbay@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>, 
	Daniel Stone <daniel@fooishbar.org>, Frank Li <Frank.li@nxp.com>, 
	Sui Jingfeng <sui.jingfeng@linux.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:47=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> The Arm Ethos-U65/85 NPUs are designed for edge AI inference
> applications[0].
>
> The driver works with Mesa Teflon. A merge request for Ethos support is
> here[1]. The UAPI should also be compatible with the downstream (open
> source) driver stack[2] and Vela compiler though that has not been
> implemented.
>
> Testing so far has been on i.MX93 boards with Ethos-U65 and a FVP model
> with Ethos-U85. More work is needed in mesa for handling U85 command
> stream differences, but that doesn't affect the UABI.
>
> A git tree is here[3].
>
> Rob
>
> [0] https://www.arm.com/products/silicon-ip-cpu?families=3Dethos%20npus
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/36699/
> [2] https://gitlab.arm.com/artificial-intelligence/ethos-u/
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git ethos-v4
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

For the series:

Acked-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Regards,

Tomeu


> ---
> Changes in v4:
> - Use bulk clk API
> - Various whitespace fixes mostly due to ethos->ethosu rename
> - Drop error check on dma_set_mask_and_coherent()
> - Drop unnecessary pm_runtime_mark_last_busy() call
> - Move variable declarations out of switch (a riscv/clang build failure)
> - Use lowercase hex in all defines
> - Drop unused ethosu_device.coherent member
> - Add comments on all locks
> - Link to v3: https://lore.kernel.org/r/20250926-ethos-v3-0-6bd24373e4f5@=
kernel.org
>
> Changes in v3:
> - Rework and improve job submit validation
> - Rename ethos to ethosu. There was an Ethos-Nxx that's unrelated.
> - Add missing init for sched_lock mutex
> - Drop some prints to debug level
> - Fix i.MX93 SRAM accesses (AXI config)
> - Add U85 AXI configuration and test on FVP with U85
> - Print the current cmd value on timeout
> - Link to v2: https://lore.kernel.org/r/20250811-ethos-v2-0-a219fc52a95b@=
kernel.org
>
> Changes in v2:
> - Rebase on v6.17-rc1 adapting to scheduler changes
> - scheduler: Drop the reset workqueue. According to the scheduler docs,
>   we don't need it since we have a single h/w queue.
> - scheduler: Rework the timeout handling to continue running if we are
>   making progress. Fixes timeouts on larger jobs.
> - Reset the NPU on resume so it's in a known state
> - Add error handling on clk_get() calls
> - Fix drm_mm splat on module unload. We were missing a put on the
>   cmdstream BO in the scheduler clean-up.
> - Fix 0-day report needing explicit bitfield.h include
> - Link to v1: https://lore.kernel.org/r/20250722-ethos-v1-0-cc1c5a0cbbfb@=
kernel.org
>
> ---
> Rob Herring (Arm) (2):
>       dt-bindings: npu: Add Arm Ethos-U65/U85
>       accel: Add Arm Ethos-U NPU driver
>
>  .../devicetree/bindings/npu/arm,ethos.yaml         |  79 +++
>  MAINTAINERS                                        |   9 +
>  drivers/accel/Kconfig                              |   1 +
>  drivers/accel/Makefile                             |   1 +
>  drivers/accel/ethosu/Kconfig                       |  10 +
>  drivers/accel/ethosu/Makefile                      |   4 +
>  drivers/accel/ethosu/ethosu_device.h               | 190 ++++++
>  drivers/accel/ethosu/ethosu_drv.c                  | 418 ++++++++++++
>  drivers/accel/ethosu/ethosu_drv.h                  |  15 +
>  drivers/accel/ethosu/ethosu_gem.c                  | 710 +++++++++++++++=
++++++
>  drivers/accel/ethosu/ethosu_gem.h                  |  46 ++
>  drivers/accel/ethosu/ethosu_job.c                  | 539 +++++++++++++++=
+
>  drivers/accel/ethosu/ethosu_job.h                  |  41 ++
>  include/uapi/drm/ethosu_accel.h                    | 261 ++++++++
>  14 files changed, 2324 insertions(+)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20250715-ethos-3fdd39ef6f19
>
> Best regards,
> --
> Rob Herring (Arm) <robh@kernel.org>
>

