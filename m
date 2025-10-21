Return-Path: <linux-kernel+bounces-862569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66295BF5A39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 172DE50189B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765429B239;
	Tue, 21 Oct 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZgNVGLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBB2D5C97
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040195; cv=none; b=VAWbIFm8eBotgQ4zHw4GqnexrN66VuuWqV9JqCxPvzk54vTT0koRVZbgHrwwmyMeDCmKUCbGnj555ntU4WEZRf9nq9UzLvjUbT3qLKRUK04bKj40NXCvw9/AkhAMssZJYhHKNw0bfPOa0YLjz8UndnVzEwvBu83RVo/okbvJgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040195; c=relaxed/simple;
	bh=HBYnZxq1ig/iB7Y1hDTR/ccAhyKlO/sZ6C9OLBmi760=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtfIzeEioZTzZ7CvSNvI/RekzCiuKNWVMfgKokF7ivvbNQnWlzN6VeDm21VEVS+1Zic8/H8ZdzE9BzDt6RyvvO0nB4TektxgCGv547pSXWUMXv7zSoREwXdfgpb4/q/V3FS//0NBe1Hk2kJd+7b0XOsq5GE709sgH2hUsM11dKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZgNVGLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6251C16AAE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761040194;
	bh=HBYnZxq1ig/iB7Y1hDTR/ccAhyKlO/sZ6C9OLBmi760=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=lZgNVGLy7c1nDtHS7C99+jtw+MajYkesfzqzuxpHW2/5gq7ZlEsU3J+ZAWdjNnYRr
	 GdoRVJiHM2PaX3FdNvRMDRASPb4y9uXI9kLOKwB3uMkHa4wQ+gro4nmdADteFD86u5
	 Ev38O63UeEydE4QjBYJOXJHZjz2YPH4Ah4g0saTxA+mN9rv0VqxVvTI4mhBmXZhZhS
	 dRhHq/LXW6RIOWgbvCvegID34Fq3gjLTUqhqbIrvl7QDYjcW2WRnHlSUEMqJ8LmTnn
	 bpawfEoRFg9I8Ha0iddN+a7Bp+uga8M3Jm8XOPHbvDL1k1MTEiek1ZTw6tJcp7FILX
	 AaFsu6FWiFejQ==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e17c0fefbso4328379d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:49:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfPk2b9eLlBUUFZfjnn5eoGsAc9+9d5FEzqJ0vTCopsVduvEE9Ish3gS+tCQpbl4HcCFEKNogu8tYJb/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FvATtI4dT3binXkZF6YSWSqBtwEtqMYnRqCMIr50wsmjKK2X
	rN+aLSrqsT581lMqBJ7OPd/qIAV6GKkxZoWRsBc8t0i3He0hHj/ntKjZdGtJMj9M36eAELca6vb
	adj3PHIo1ZUL5ZAVobrzlyEvpWoQLBtA=
X-Google-Smtp-Source: AGHT+IGfhaZJJy3YjiGxXV8QNUvNITowO7Rwn1E8cCns5O99amxzDuEbltjE9Lahn2Xeu77MRttJ7caTy7mawIxOPCU=
X-Received: by 2002:a53:7b04:0:b0:635:4ecf:bdcb with SMTP id
 956f58d0204a3-63e161d1b32mr10648265d50.45.1761040193686; Tue, 21 Oct 2025
 02:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021093816.735-1-shenghao-ding@ti.com> <20251021093816.735-2-shenghao-ding@ti.com>
In-Reply-To: <20251021093816.735-2-shenghao-ding@ti.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 21 Oct 2025 05:49:42 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7kDfL0ucjLcpThzuWQKE39dchHgy3zSySnwTYf=4CnNg@mail.gmail.com>
X-Gm-Features: AS18NWB4cz69sMB3R-0Kx2H_dXBK7Lp4ja24xbLZXL3AEK8SNfE8yPF3AuqNltU
Message-ID: <CA+5PVA7kDfL0ucjLcpThzuWQKE39dchHgy3zSySnwTYf=4CnNg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ASoc: TAS2781: Create audio folder in ti folder,
 and move all the audio firmwares into it
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-firmware@kernel.org, zigo@debian.org, baojun.xu@ti.com, 
	13564923607@139.com, linux-kernel@vger.kernel.org, soyer@irl.hu, 
	stuart.a.hayhurst@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Have the upstream kernel drivers been updated to look for the firmware
in this new location?  Even if it has been, won't this change break
older kernels that expect the firmware in the old location?

josh

On Tue, Oct 21, 2025 at 5:39=E2=80=AFAM Shenghao Ding <shenghao-ding@ti.com=
> wrote:
>
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>
> ---
> v1:
>  - Create the audio folder in ti in order to only store auido firmware.
>  - Move all the audio firmware into the newly-created audio folder.
>  - Update the year to 2025.
> ---
>  WHENCE                                  | 302 ++++++++++++------------
>  ti/{ =3D> audio}/tas2563/INT8866RCA2.bin  | Bin
>  ti/{ =3D> audio}/tas2563/TAS2XXX3870.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX0C94.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX0C95.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX0C96.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX0C97.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX10A40.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX10A41.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX11540.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX11541.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX12040.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX12041.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX12140.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX12141.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX1EB30.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX1EB31.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX2234.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX2326.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX387D.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX387E.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX387F.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3880.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3881.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3882.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3884.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3886.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38A5.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38A7.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38A8.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38B8.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38B9.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38BA.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38BB.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38BE.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38BF.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38C3.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38CB.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38CD.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38D3.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38D4.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38D5.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38D6.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38DF.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38E0.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX38FD.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX391F.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3920.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3E300.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3E301.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3EE00.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3EE01.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3EF00.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3EF01.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F000.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F001.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F100.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F101.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F200.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F201.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F300.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX3F301.bin | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX8DE8.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TAS2XXX8DE9.bin  | Bin
>  ti/{ =3D> audio}/tas2781/TIAS2781RCA2.bin | Bin
>  ti/{ =3D> audio}/tas2781/TIAS2781RCA4.bin | Bin
>  ti/{ =3D> audio}/tas2781/TXNW2781RCA0.bin | Bin
>  ti/{ =3D> audio}/tas2781/TXNW2781RCA1.bin | Bin
>  68 files changed, 151 insertions(+), 151 deletions(-)
>  rename ti/{ =3D> audio}/tas2563/INT8866RCA2.bin (100%)
>  rename ti/{ =3D> audio}/tas2563/TAS2XXX3870.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX0C94.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX0C95.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX0C96.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX0C97.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX10A40.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX10A41.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX11540.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX11541.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX12040.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX12041.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX12140.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX12141.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX1EB30.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX1EB31.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX2234.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX2326.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX387D.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX387E.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX387F.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3880.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3881.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3882.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3884.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3886.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38A5.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38A7.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38A8.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38B8.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38B9.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38BA.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38BB.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38BE.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38BF.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38C3.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38CB.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38CD.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38D3.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38D4.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38D5.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38D6.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38DF.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38E0.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX38FD.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX391F.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3920.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3E300.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3E301.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3EE00.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3EE01.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3EF00.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3EF01.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F000.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F001.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F100.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F101.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F200.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F201.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F300.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX3F301.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX8DE8.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TAS2XXX8DE9.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TIAS2781RCA2.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TIAS2781RCA4.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TXNW2781RCA0.bin (100%)
>  rename ti/{ =3D> audio}/tas2781/TXNW2781RCA1.bin (100%)
>
> diff --git a/WHENCE b/WHENCE
> index a03f4dc8..3f05cda9 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -8556,165 +8556,165 @@ Originates from https://github.com/linux-msm/au=
dioreach-topology.git
>
>  ------------------------------------------------------------------------=
--
>  Driver: ti-tas2781 - tas2781 firmware
> -File: ti/tas2781/TAS2XXX0C94.bin
> -File: ti/tas2781/TAS2XXX0C95.bin
> -File: ti/tas2781/TAS2XXX0C96.bin
> -File: ti/tas2781/TAS2XXX0C97.bin
> -File: ti/tas2781/TAS2XXX10A40.bin
> -File: ti/tas2781/TAS2XXX10A41.bin
> -File: ti/tas2781/TAS2XXX11540.bin
> -File: ti/tas2781/TAS2XXX11541.bin
> -File: ti/tas2781/TAS2XXX12040.bin
> -File: ti/tas2781/TAS2XXX12041.bin
> -File: ti/tas2781/TAS2XXX12140.bin
> -File: ti/tas2781/TAS2XXX12141.bin
> -File: ti/tas2781/TAS2XXX1EB30.bin
> -File: ti/tas2781/TAS2XXX1EB31.bin
> -File: ti/tas2781/TAS2XXX2234.bin
> -File: ti/tas2781/TAS2XXX2326.bin
> -File: ti/tas2781/TAS2XXX387D.bin
> -File: ti/tas2781/TAS2XXX387E.bin
> -File: ti/tas2781/TAS2XXX387F.bin
> -File: ti/tas2781/TAS2XXX3880.bin
> -File: ti/tas2781/TAS2XXX3881.bin
> -File: ti/tas2781/TAS2XXX3882.bin
> -File: ti/tas2781/TAS2XXX3884.bin
> -File: ti/tas2781/TAS2XXX3886.bin
> -File: ti/tas2781/TAS2XXX38A5.bin
> -File: ti/tas2781/TAS2XXX38A7.bin
> -File: ti/tas2781/TAS2XXX38A8.bin
> -File: ti/tas2781/TAS2XXX38B8.bin
> -File: ti/tas2781/TAS2XXX38B9.bin
> -File: ti/tas2781/TAS2XXX38BA.bin
> -File: ti/tas2781/TAS2XXX38BB.bin
> -File: ti/tas2781/TAS2XXX38BE.bin
> -File: ti/tas2781/TAS2XXX38BF.bin
> -File: ti/tas2781/TAS2XXX38C3.bin
> -File: ti/tas2781/TAS2XXX38CB.bin
> -File: ti/tas2781/TAS2XXX38CD.bin
> -File: ti/tas2781/TAS2XXX38D3.bin
> -File: ti/tas2781/TAS2XXX38D4.bin
> -File: ti/tas2781/TAS2XXX38D5.bin
> -File: ti/tas2781/TAS2XXX38D6.bin
> -File: ti/tas2781/TAS2XXX38DF.bin
> -File: ti/tas2781/TAS2XXX38E0.bin
> -File: ti/tas2781/TAS2XXX38FD.bin
> -File: ti/tas2781/TAS2XXX391F.bin
> -File: ti/tas2781/TAS2XXX3920.bin
> -File: ti/tas2781/TAS2XXX3E300.bin
> -File: ti/tas2781/TAS2XXX3E301.bin
> -File: ti/tas2781/TAS2XXX3EE00.bin
> -File: ti/tas2781/TAS2XXX3EE01.bin
> -File: ti/tas2781/TAS2XXX3EF00.bin
> -File: ti/tas2781/TAS2XXX3EF01.bin
> -File: ti/tas2781/TAS2XXX3F000.bin
> -File: ti/tas2781/TAS2XXX3F001.bin
> -File: ti/tas2781/TAS2XXX3F100.bin
> -File: ti/tas2781/TAS2XXX3F101.bin
> -File: ti/tas2781/TAS2XXX3F200.bin
> -File: ti/tas2781/TAS2XXX3F201.bin
> -File: ti/tas2781/TAS2XXX3F300.bin
> -File: ti/tas2781/TAS2XXX3F301.bin
> -File: ti/tas2781/TAS2XXX8DE8.bin
> -File: ti/tas2781/TAS2XXX8DE9.bin
> -File: ti/tas2781/TXNW2781RCA0.bin
> -File: ti/tas2781/TXNW2781RCA1.bin
> -File: ti/tas2781/TIAS2781RCA2.bin
> -File: ti/tas2781/TIAS2781RCA4.bin
> -Link: TAS2XXX0C94.bin -> ti/tas2781/TAS2XXX0C94.bin
> -Link: TAS2XXX0C95.bin -> ti/tas2781/TAS2XXX0C95.bin
> -Link: TAS2XXX0C96.bin -> ti/tas2781/TAS2XXX0C96.bin
> -Link: TAS2XXX0C97.bin -> ti/tas2781/TAS2XXX0C97.bin
> -Link: TAS2XXX103C8DE80.bin -> ti/tas2781/TAS2XXX8DE8.bin
> -Link: TAS2XXX103C8DE81.bin -> ti/tas2781/TAS2XXX8DE8.bin
> -Link: TAS2XXX103C8DE90.bin -> ti/tas2781/TAS2XXX8DE9.bin
> -Link: TAS2XXX103C8DE91.bin -> ti/tas2781/TAS2XXX8DE9.bin
> -Link: TAS2XXX103C8DE8-0.bin -> ti/tas2781/TAS2XXX8DE8.bin
> -Link: TAS2XXX103C8DE8-1.bin -> ti/tas2781/TAS2XXX8DE8.bin
> -Link: TAS2XXX103C8DE9-0.bin -> ti/tas2781/TAS2XXX8DE9.bin
> -Link: TAS2XXX103C8DE9-1.bin -> ti/tas2781/TAS2XXX8DE9.bin
> -Link: TAS2XXX10A40.bin -> ti/tas2781/TAS2XXX10A40.bin
> -Link: TAS2XXX10A41.bin -> ti/tas2781/TAS2XXX10A41.bin
> -Link: TAS2XXX11540.bin -> ti/tas2781/TAS2XXX11540.bin
> -Link: TAS2XXX11541.bin -> ti/tas2781/TAS2XXX11541.bin
> -Link: TAS2XXX12040.bin -> ti/tas2781/TAS2XXX12040.bin
> -Link: TAS2XXX12041.bin -> ti/tas2781/TAS2XXX12041.bin
> -Link: TAS2XXX12140.bin -> ti/tas2781/TAS2XXX12140.bin
> -Link: TAS2XXX12141.bin -> ti/tas2781/TAS2XXX12141.bin
> -Link: TAS2XXX1EB3.bin -> ti/tas2781/TAS2XXX1EB30.bin
> -Link: TAS2XXX1EB30.bin -> ti/tas2781/TAS2XXX1EB30.bin
> -Link: TAS2XXX1EB31.bin -> ti/tas2781/TAS2XXX1EB31.bin
> -Link: TAS2XXX2234.bin -> ti/tas2781/TAS2XXX2234.bin
> -Link: TAS2XXX2326.bin -> ti/tas2781/TAS2XXX2326.bin
> -Link: TAS2XXX387D.bin -> ti/tas2781/TAS2XXX387D.bin
> -Link: TAS2XXX387E.bin -> ti/tas2781/TAS2XXX387E.bin
> -Link: TAS2XXX387F.bin -> ti/tas2781/TAS2XXX387F.bin
> -Link: TAS2XXX3880.bin -> ti/tas2781/TAS2XXX3880.bin
> -Link: TAS2XXX3881.bin -> ti/tas2781/TAS2XXX3881.bin
> -Link: TAS2XXX3882.bin -> ti/tas2781/TAS2XXX3882.bin
> -Link: TAS2XXX3884.bin -> ti/tas2781/TAS2XXX3884.bin
> -Link: TAS2XXX3886.bin -> ti/tas2781/TAS2XXX3886.bin
> -Link: TAS2XXX38A5.bin -> ti/tas2781/TAS2XXX38A5.bin
> -Link: TAS2XXX38A7.bin -> ti/tas2781/TAS2XXX38A7.bin
> -Link: TAS2XXX38A8.bin -> ti/tas2781/TAS2XXX38A8.bin
> -Link: TAS2XXX38B8.bin -> ti/tas2781/TAS2XXX38B8.bin
> -Link: TAS2XXX38B9.bin -> ti/tas2781/TAS2XXX38B9.bin
> -Link: TAS2XXX38BA.bin -> ti/tas2781/TAS2XXX38BA.bin
> -Link: TAS2XXX38BB.bin -> ti/tas2781/TAS2XXX38BB.bin
> -Link: TAS2XXX38BE.bin -> ti/tas2781/TAS2XXX38BE.bin
> -Link: TAS2XXX38BF.bin -> ti/tas2781/TAS2XXX38BF.bin
> -Link: TAS2XXX38C3.bin -> ti/tas2781/TAS2XXX38C3.bin
> -Link: TAS2XXX38CB.bin -> ti/tas2781/TAS2XXX38CB.bin
> -Link: TAS2XXX38CD.bin -> ti/tas2781/TAS2XXX38CD.bin
> -Link: TAS2XXX38D3.bin -> ti/tas2781/TAS2XXX38D3.bin
> -Link: TAS2XXX38D4.bin -> ti/tas2781/TAS2XXX38D4.bin
> -Link: TAS2XXX38D5.bin -> ti/tas2781/TAS2XXX38D5.bin
> -Link: TAS2XXX38D6.bin -> ti/tas2781/TAS2XXX38D6.bin
> -Link: TAS2XXX38DF.bin -> ti/tas2781/TAS2XXX38DF.bin
> -Link: TAS2XXX38E0.bin -> ti/tas2781/TAS2XXX38E0.bin
> -Link: TAS2XXX38FD.bin -> ti/tas2781/TAS2XXX38FD.bin
> -Link: TAS2XXX391F.bin -> ti/tas2781/TAS2XXX391F.bin
> -Link: TAS2XXX3920.bin -> ti/tas2781/TAS2XXX3920.bin
> -Link: TAS2XXX3E300.bin -> ti/tas2781/TAS2XXX3E300.bin
> -Link: TAS2XXX3E301.bin -> ti/tas2781/TAS2XXX3E301.bin
> -Link: TAS2XXX3EE00.bin -> ti/tas2781/TAS2XXX3EE00.bin
> -Link: TAS2XXX3EE01.bin -> ti/tas2781/TAS2XXX3EE01.bin
> -Link: TAS2XXX3EF00.bin -> ti/tas2781/TAS2XXX3EF00.bin
> -Link: TAS2XXX3EF01.bin -> ti/tas2781/TAS2XXX3EF01.bin
> -Link: TAS2XXX3F000.bin -> ti/tas2781/TAS2XXX3F000.bin
> -Link: TAS2XXX3F001.bin -> ti/tas2781/TAS2XXX3F001.bin
> -Link: TAS2XXX3F100.bin -> ti/tas2781/TAS2XXX3F100.bin
> -Link: TAS2XXX3F101.bin -> ti/tas2781/TAS2XXX3F101.bin
> -Link: TAS2XXX3F200.bin -> ti/tas2781/TAS2XXX3F200.bin
> -Link: TAS2XXX3F201.bin -> ti/tas2781/TAS2XXX3F201.bin
> -Link: TAS2XXX3F300.bin -> ti/tas2781/TAS2XXX3F300.bin
> -Link: TAS2XXX3F301.bin -> ti/tas2781/TAS2XXX3F301.bin
> -Link: TAS2XXX8DE8.bin -> ti/tas2781/TAS2XXX8DE8.bin
> -Link: TAS2XXX8DE9.bin -> ti/tas2781/TAS2XXX8DE9.bin
> -Link: TAS2XXX8DE80.bin -> ti/tas2781/TAS2XXX8DE8.bin
> -Link: TAS2XXX8DE81.bin -> ti/tas2781/TAS2XXX8DE8.bin
> -Link: TAS2XXX8DE90.bin -> ti/tas2781/TAS2XXX8DE9.bin
> -Link: TAS2XXX8DE91.bin -> ti/tas2781/TAS2XXX8DE9.bin
> -Link: TIAS2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
> -Link: TIAS2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
> -Link: TXNW2781RCA1.bin -> ti/tas2781/TXNW2781RCA0.bin
> -Link: TXNW2781RCA0.bin -> ti/tas2781/TXNW2781RCA1.bin
> -Link: TXNW2781RCA2.bin -> ti/tas2781/TIAS2781RCA2.bin
> -Link: TXNW2781RCA4.bin -> ti/tas2781/TIAS2781RCA4.bin
> +File: ti/audio/tas2781/TAS2XXX0C94.bin
> +File: ti/audio/tas2781/TAS2XXX0C95.bin
> +File: ti/audio/tas2781/TAS2XXX0C96.bin
> +File: ti/audio/tas2781/TAS2XXX0C97.bin
> +File: ti/audio/tas2781/TAS2XXX10A40.bin
> +File: ti/audio/tas2781/TAS2XXX10A41.bin
> +File: ti/audio/tas2781/TAS2XXX11540.bin
> +File: ti/audio/tas2781/TAS2XXX11541.bin
> +File: ti/audio/tas2781/TAS2XXX12040.bin
> +File: ti/audio/tas2781/TAS2XXX12041.bin
> +File: ti/audio/tas2781/TAS2XXX12140.bin
> +File: ti/audio/tas2781/TAS2XXX12141.bin
> +File: ti/audio/tas2781/TAS2XXX1EB30.bin
> +File: ti/audio/tas2781/TAS2XXX1EB31.bin
> +File: ti/audio/tas2781/TAS2XXX2234.bin
> +File: ti/audio/tas2781/TAS2XXX2326.bin
> +File: ti/audio/tas2781/TAS2XXX387D.bin
> +File: ti/audio/tas2781/TAS2XXX387E.bin
> +File: ti/audio/tas2781/TAS2XXX387F.bin
> +File: ti/audio/tas2781/TAS2XXX3880.bin
> +File: ti/audio/tas2781/TAS2XXX3881.bin
> +File: ti/audio/tas2781/TAS2XXX3882.bin
> +File: ti/audio/tas2781/TAS2XXX3884.bin
> +File: ti/audio/tas2781/TAS2XXX3886.bin
> +File: ti/audio/tas2781/TAS2XXX38A5.bin
> +File: ti/audio/tas2781/TAS2XXX38A7.bin
> +File: ti/audio/tas2781/TAS2XXX38A8.bin
> +File: ti/audio/tas2781/TAS2XXX38B8.bin
> +File: ti/audio/tas2781/TAS2XXX38B9.bin
> +File: ti/audio/tas2781/TAS2XXX38BA.bin
> +File: ti/audio/tas2781/TAS2XXX38BB.bin
> +File: ti/audio/tas2781/TAS2XXX38BE.bin
> +File: ti/audio/tas2781/TAS2XXX38BF.bin
> +File: ti/audio/tas2781/TAS2XXX38C3.bin
> +File: ti/audio/tas2781/TAS2XXX38CB.bin
> +File: ti/audio/tas2781/TAS2XXX38CD.bin
> +File: ti/audio/tas2781/TAS2XXX38D3.bin
> +File: ti/audio/tas2781/TAS2XXX38D4.bin
> +File: ti/audio/tas2781/TAS2XXX38D5.bin
> +File: ti/audio/tas2781/TAS2XXX38D6.bin
> +File: ti/audio/tas2781/TAS2XXX38DF.bin
> +File: ti/audio/tas2781/TAS2XXX38E0.bin
> +File: ti/audio/tas2781/TAS2XXX38FD.bin
> +File: ti/audio/tas2781/TAS2XXX391F.bin
> +File: ti/audio/tas2781/TAS2XXX3920.bin
> +File: ti/audio/tas2781/TAS2XXX3E300.bin
> +File: ti/audio/tas2781/TAS2XXX3E301.bin
> +File: ti/audio/tas2781/TAS2XXX3EE00.bin
> +File: ti/audio/tas2781/TAS2XXX3EE01.bin
> +File: ti/audio/tas2781/TAS2XXX3EF00.bin
> +File: ti/audio/tas2781/TAS2XXX3EF01.bin
> +File: ti/audio/tas2781/TAS2XXX3F000.bin
> +File: ti/audio/tas2781/TAS2XXX3F001.bin
> +File: ti/audio/tas2781/TAS2XXX3F100.bin
> +File: ti/audio/tas2781/TAS2XXX3F101.bin
> +File: ti/audio/tas2781/TAS2XXX3F200.bin
> +File: ti/audio/tas2781/TAS2XXX3F201.bin
> +File: ti/audio/tas2781/TAS2XXX3F300.bin
> +File: ti/audio/tas2781/TAS2XXX3F301.bin
> +File: ti/audio/tas2781/TAS2XXX8DE8.bin
> +File: ti/audio/tas2781/TAS2XXX8DE9.bin
> +File: ti/audio/tas2781/TXNW2781RCA0.bin
> +File: ti/audio/tas2781/TXNW2781RCA1.bin
> +File: ti/audio/tas2781/TIAS2781RCA2.bin
> +File: ti/audio/tas2781/TIAS2781RCA4.bin
> +Link: TAS2XXX0C94.bin -> ti/audio/tas2781/TAS2XXX0C94.bin
> +Link: TAS2XXX0C95.bin -> ti/audio/tas2781/TAS2XXX0C95.bin
> +Link: TAS2XXX0C96.bin -> ti/audio/tas2781/TAS2XXX0C96.bin
> +Link: TAS2XXX0C97.bin -> ti/audio/tas2781/TAS2XXX0C97.bin
> +Link: TAS2XXX103C8DE80.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX103C8DE81.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX103C8DE90.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX103C8DE91.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX103C8DE8-0.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX103C8DE8-1.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX103C8DE9-0.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX103C8DE9-1.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX10A40.bin -> ti/audio/tas2781/TAS2XXX10A40.bin
> +Link: TAS2XXX10A41.bin -> ti/audio/tas2781/TAS2XXX10A41.bin
> +Link: TAS2XXX11540.bin -> ti/audio/tas2781/TAS2XXX11540.bin
> +Link: TAS2XXX11541.bin -> ti/audio/tas2781/TAS2XXX11541.bin
> +Link: TAS2XXX12040.bin -> ti/audio/tas2781/TAS2XXX12040.bin
> +Link: TAS2XXX12041.bin -> ti/audio/tas2781/TAS2XXX12041.bin
> +Link: TAS2XXX12140.bin -> ti/audio/tas2781/TAS2XXX12140.bin
> +Link: TAS2XXX12141.bin -> ti/audio/tas2781/TAS2XXX12141.bin
> +Link: TAS2XXX1EB3.bin -> ti/audio/tas2781/TAS2XXX1EB30.bin
> +Link: TAS2XXX1EB30.bin -> ti/audio/tas2781/TAS2XXX1EB30.bin
> +Link: TAS2XXX1EB31.bin -> ti/audio/tas2781/TAS2XXX1EB31.bin
> +Link: TAS2XXX2234.bin -> ti/audio/tas2781/TAS2XXX2234.bin
> +Link: TAS2XXX2326.bin -> ti/audio/tas2781/TAS2XXX2326.bin
> +Link: TAS2XXX387D.bin -> ti/audio/tas2781/TAS2XXX387D.bin
> +Link: TAS2XXX387E.bin -> ti/audio/tas2781/TAS2XXX387E.bin
> +Link: TAS2XXX387F.bin -> ti/audio/tas2781/TAS2XXX387F.bin
> +Link: TAS2XXX3880.bin -> ti/audio/tas2781/TAS2XXX3880.bin
> +Link: TAS2XXX3881.bin -> ti/audio/tas2781/TAS2XXX3881.bin
> +Link: TAS2XXX3882.bin -> ti/audio/tas2781/TAS2XXX3882.bin
> +Link: TAS2XXX3884.bin -> ti/audio/tas2781/TAS2XXX3884.bin
> +Link: TAS2XXX3886.bin -> ti/audio/tas2781/TAS2XXX3886.bin
> +Link: TAS2XXX38A5.bin -> ti/audio/tas2781/TAS2XXX38A5.bin
> +Link: TAS2XXX38A7.bin -> ti/audio/tas2781/TAS2XXX38A7.bin
> +Link: TAS2XXX38A8.bin -> ti/audio/tas2781/TAS2XXX38A8.bin
> +Link: TAS2XXX38B8.bin -> ti/audio/tas2781/TAS2XXX38B8.bin
> +Link: TAS2XXX38B9.bin -> ti/audio/tas2781/TAS2XXX38B9.bin
> +Link: TAS2XXX38BA.bin -> ti/audio/tas2781/TAS2XXX38BA.bin
> +Link: TAS2XXX38BB.bin -> ti/audio/tas2781/TAS2XXX38BB.bin
> +Link: TAS2XXX38BE.bin -> ti/audio/tas2781/TAS2XXX38BE.bin
> +Link: TAS2XXX38BF.bin -> ti/audio/tas2781/TAS2XXX38BF.bin
> +Link: TAS2XXX38C3.bin -> ti/audio/tas2781/TAS2XXX38C3.bin
> +Link: TAS2XXX38CB.bin -> ti/audio/tas2781/TAS2XXX38CB.bin
> +Link: TAS2XXX38CD.bin -> ti/audio/tas2781/TAS2XXX38CD.bin
> +Link: TAS2XXX38D3.bin -> ti/audio/tas2781/TAS2XXX38D3.bin
> +Link: TAS2XXX38D4.bin -> ti/audio/tas2781/TAS2XXX38D4.bin
> +Link: TAS2XXX38D5.bin -> ti/audio/tas2781/TAS2XXX38D5.bin
> +Link: TAS2XXX38D6.bin -> ti/audio/tas2781/TAS2XXX38D6.bin
> +Link: TAS2XXX38DF.bin -> ti/audio/tas2781/TAS2XXX38DF.bin
> +Link: TAS2XXX38E0.bin -> ti/audio/tas2781/TAS2XXX38E0.bin
> +Link: TAS2XXX38FD.bin -> ti/audio/tas2781/TAS2XXX38FD.bin
> +Link: TAS2XXX391F.bin -> ti/audio/tas2781/TAS2XXX391F.bin
> +Link: TAS2XXX3920.bin -> ti/audio/tas2781/TAS2XXX3920.bin
> +Link: TAS2XXX3E300.bin -> ti/audio/tas2781/TAS2XXX3E300.bin
> +Link: TAS2XXX3E301.bin -> ti/audio/tas2781/TAS2XXX3E301.bin
> +Link: TAS2XXX3EE00.bin -> ti/audio/tas2781/TAS2XXX3EE00.bin
> +Link: TAS2XXX3EE01.bin -> ti/audio/tas2781/TAS2XXX3EE01.bin
> +Link: TAS2XXX3EF00.bin -> ti/audio/tas2781/TAS2XXX3EF00.bin
> +Link: TAS2XXX3EF01.bin -> ti/audio/tas2781/TAS2XXX3EF01.bin
> +Link: TAS2XXX3F000.bin -> ti/audio/tas2781/TAS2XXX3F000.bin
> +Link: TAS2XXX3F001.bin -> ti/audio/tas2781/TAS2XXX3F001.bin
> +Link: TAS2XXX3F100.bin -> ti/audio/tas2781/TAS2XXX3F100.bin
> +Link: TAS2XXX3F101.bin -> ti/audio/tas2781/TAS2XXX3F101.bin
> +Link: TAS2XXX3F200.bin -> ti/audio/tas2781/TAS2XXX3F200.bin
> +Link: TAS2XXX3F201.bin -> ti/audio/tas2781/TAS2XXX3F201.bin
> +Link: TAS2XXX3F300.bin -> ti/audio/tas2781/TAS2XXX3F300.bin
> +Link: TAS2XXX3F301.bin -> ti/audio/tas2781/TAS2XXX3F301.bin
> +Link: TAS2XXX8DE8.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX8DE9.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX8DE80.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX8DE81.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
> +Link: TAS2XXX8DE90.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
> +Link: TAS2XXX8DE91.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
> +Link: TIAS2781RCA2.bin -> ti/audio/tas2781/TIAS2781RCA2.bin
> +Link: TIAS2781RCA4.bin -> ti/audio/tas2781/TIAS2781RCA4.bin
> +Link: TXNW2781RCA1.bin -> ti/audio/tas2781/TXNW2781RCA0.bin
> +Link: TXNW2781RCA0.bin -> ti/audio/tas2781/TXNW2781RCA1.bin
> +Link: TXNW2781RCA2.bin -> ti/audio/tas2781/TIAS2781RCA2.bin
> +Link: TXNW2781RCA4.bin -> ti/audio/tas2781/TIAS2781RCA4.bin
>
>  Licence: Redistributable. See LICENCE.ti-tspa for details. Marked:
> -        Copyright (C) 2023 - 2024 Texas Instruments
> +        Copyright (C) 2023 - 2025 Texas Instruments
>
>  ------------------------------------------------------------------------=
--
>
>  Driver: ti-tas2563 - tas2563 firmware
> -File: ti/tas2563/TAS2XXX3870.bin
> -File: ti/tas2563/INT8866RCA2.bin
> -Link: TAS2XXX3870.bin -> ti/tas2563/TAS2XXX3870.bin
> -Link: INT8866RCA2.bin -> ti/tas2563/INT8866RCA2.bin
> +File: ti/audio/tas2563/TAS2XXX3870.bin
> +File: ti/audio/tas2563/INT8866RCA2.bin
> +Link: TAS2XXX3870.bin -> ti/audio/tas2563/TAS2XXX3870.bin
> +Link: INT8866RCA2.bin -> ti/audio/tas2563/INT8866RCA2.bin
>
>  Licence: Redistributable. LICENCE.ti-tspa for details. Marked:
> -        Copyright (C) 2023 - 2024 Texas Instruments
> +        Copyright (C) 2023 - 2025 Texas Instruments
>
>  ------------------------------------------------------------------------=
--
>
> diff --git a/ti/tas2563/INT8866RCA2.bin b/ti/audio/tas2563/INT8866RCA2.bi=
n
> similarity index 100%
> rename from ti/tas2563/INT8866RCA2.bin
> rename to ti/audio/tas2563/INT8866RCA2.bin
> diff --git a/ti/tas2563/TAS2XXX3870.bin b/ti/audio/tas2563/TAS2XXX3870.bi=
n
> similarity index 100%
> rename from ti/tas2563/TAS2XXX3870.bin
> rename to ti/audio/tas2563/TAS2XXX3870.bin
> diff --git a/ti/tas2781/TAS2XXX0C94.bin b/ti/audio/tas2781/TAS2XXX0C94.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX0C94.bin
> rename to ti/audio/tas2781/TAS2XXX0C94.bin
> diff --git a/ti/tas2781/TAS2XXX0C95.bin b/ti/audio/tas2781/TAS2XXX0C95.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX0C95.bin
> rename to ti/audio/tas2781/TAS2XXX0C95.bin
> diff --git a/ti/tas2781/TAS2XXX0C96.bin b/ti/audio/tas2781/TAS2XXX0C96.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX0C96.bin
> rename to ti/audio/tas2781/TAS2XXX0C96.bin
> diff --git a/ti/tas2781/TAS2XXX0C97.bin b/ti/audio/tas2781/TAS2XXX0C97.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX0C97.bin
> rename to ti/audio/tas2781/TAS2XXX0C97.bin
> diff --git a/ti/tas2781/TAS2XXX10A40.bin b/ti/audio/tas2781/TAS2XXX10A40.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX10A40.bin
> rename to ti/audio/tas2781/TAS2XXX10A40.bin
> diff --git a/ti/tas2781/TAS2XXX10A41.bin b/ti/audio/tas2781/TAS2XXX10A41.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX10A41.bin
> rename to ti/audio/tas2781/TAS2XXX10A41.bin
> diff --git a/ti/tas2781/TAS2XXX11540.bin b/ti/audio/tas2781/TAS2XXX11540.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX11540.bin
> rename to ti/audio/tas2781/TAS2XXX11540.bin
> diff --git a/ti/tas2781/TAS2XXX11541.bin b/ti/audio/tas2781/TAS2XXX11541.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX11541.bin
> rename to ti/audio/tas2781/TAS2XXX11541.bin
> diff --git a/ti/tas2781/TAS2XXX12040.bin b/ti/audio/tas2781/TAS2XXX12040.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX12040.bin
> rename to ti/audio/tas2781/TAS2XXX12040.bin
> diff --git a/ti/tas2781/TAS2XXX12041.bin b/ti/audio/tas2781/TAS2XXX12041.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX12041.bin
> rename to ti/audio/tas2781/TAS2XXX12041.bin
> diff --git a/ti/tas2781/TAS2XXX12140.bin b/ti/audio/tas2781/TAS2XXX12140.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX12140.bin
> rename to ti/audio/tas2781/TAS2XXX12140.bin
> diff --git a/ti/tas2781/TAS2XXX12141.bin b/ti/audio/tas2781/TAS2XXX12141.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX12141.bin
> rename to ti/audio/tas2781/TAS2XXX12141.bin
> diff --git a/ti/tas2781/TAS2XXX1EB30.bin b/ti/audio/tas2781/TAS2XXX1EB30.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX1EB30.bin
> rename to ti/audio/tas2781/TAS2XXX1EB30.bin
> diff --git a/ti/tas2781/TAS2XXX1EB31.bin b/ti/audio/tas2781/TAS2XXX1EB31.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX1EB31.bin
> rename to ti/audio/tas2781/TAS2XXX1EB31.bin
> diff --git a/ti/tas2781/TAS2XXX2234.bin b/ti/audio/tas2781/TAS2XXX2234.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX2234.bin
> rename to ti/audio/tas2781/TAS2XXX2234.bin
> diff --git a/ti/tas2781/TAS2XXX2326.bin b/ti/audio/tas2781/TAS2XXX2326.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX2326.bin
> rename to ti/audio/tas2781/TAS2XXX2326.bin
> diff --git a/ti/tas2781/TAS2XXX387D.bin b/ti/audio/tas2781/TAS2XXX387D.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX387D.bin
> rename to ti/audio/tas2781/TAS2XXX387D.bin
> diff --git a/ti/tas2781/TAS2XXX387E.bin b/ti/audio/tas2781/TAS2XXX387E.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX387E.bin
> rename to ti/audio/tas2781/TAS2XXX387E.bin
> diff --git a/ti/tas2781/TAS2XXX387F.bin b/ti/audio/tas2781/TAS2XXX387F.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX387F.bin
> rename to ti/audio/tas2781/TAS2XXX387F.bin
> diff --git a/ti/tas2781/TAS2XXX3880.bin b/ti/audio/tas2781/TAS2XXX3880.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3880.bin
> rename to ti/audio/tas2781/TAS2XXX3880.bin
> diff --git a/ti/tas2781/TAS2XXX3881.bin b/ti/audio/tas2781/TAS2XXX3881.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3881.bin
> rename to ti/audio/tas2781/TAS2XXX3881.bin
> diff --git a/ti/tas2781/TAS2XXX3882.bin b/ti/audio/tas2781/TAS2XXX3882.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3882.bin
> rename to ti/audio/tas2781/TAS2XXX3882.bin
> diff --git a/ti/tas2781/TAS2XXX3884.bin b/ti/audio/tas2781/TAS2XXX3884.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3884.bin
> rename to ti/audio/tas2781/TAS2XXX3884.bin
> diff --git a/ti/tas2781/TAS2XXX3886.bin b/ti/audio/tas2781/TAS2XXX3886.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3886.bin
> rename to ti/audio/tas2781/TAS2XXX3886.bin
> diff --git a/ti/tas2781/TAS2XXX38A5.bin b/ti/audio/tas2781/TAS2XXX38A5.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38A5.bin
> rename to ti/audio/tas2781/TAS2XXX38A5.bin
> diff --git a/ti/tas2781/TAS2XXX38A7.bin b/ti/audio/tas2781/TAS2XXX38A7.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38A7.bin
> rename to ti/audio/tas2781/TAS2XXX38A7.bin
> diff --git a/ti/tas2781/TAS2XXX38A8.bin b/ti/audio/tas2781/TAS2XXX38A8.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38A8.bin
> rename to ti/audio/tas2781/TAS2XXX38A8.bin
> diff --git a/ti/tas2781/TAS2XXX38B8.bin b/ti/audio/tas2781/TAS2XXX38B8.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38B8.bin
> rename to ti/audio/tas2781/TAS2XXX38B8.bin
> diff --git a/ti/tas2781/TAS2XXX38B9.bin b/ti/audio/tas2781/TAS2XXX38B9.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38B9.bin
> rename to ti/audio/tas2781/TAS2XXX38B9.bin
> diff --git a/ti/tas2781/TAS2XXX38BA.bin b/ti/audio/tas2781/TAS2XXX38BA.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38BA.bin
> rename to ti/audio/tas2781/TAS2XXX38BA.bin
> diff --git a/ti/tas2781/TAS2XXX38BB.bin b/ti/audio/tas2781/TAS2XXX38BB.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38BB.bin
> rename to ti/audio/tas2781/TAS2XXX38BB.bin
> diff --git a/ti/tas2781/TAS2XXX38BE.bin b/ti/audio/tas2781/TAS2XXX38BE.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38BE.bin
> rename to ti/audio/tas2781/TAS2XXX38BE.bin
> diff --git a/ti/tas2781/TAS2XXX38BF.bin b/ti/audio/tas2781/TAS2XXX38BF.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38BF.bin
> rename to ti/audio/tas2781/TAS2XXX38BF.bin
> diff --git a/ti/tas2781/TAS2XXX38C3.bin b/ti/audio/tas2781/TAS2XXX38C3.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38C3.bin
> rename to ti/audio/tas2781/TAS2XXX38C3.bin
> diff --git a/ti/tas2781/TAS2XXX38CB.bin b/ti/audio/tas2781/TAS2XXX38CB.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38CB.bin
> rename to ti/audio/tas2781/TAS2XXX38CB.bin
> diff --git a/ti/tas2781/TAS2XXX38CD.bin b/ti/audio/tas2781/TAS2XXX38CD.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38CD.bin
> rename to ti/audio/tas2781/TAS2XXX38CD.bin
> diff --git a/ti/tas2781/TAS2XXX38D3.bin b/ti/audio/tas2781/TAS2XXX38D3.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38D3.bin
> rename to ti/audio/tas2781/TAS2XXX38D3.bin
> diff --git a/ti/tas2781/TAS2XXX38D4.bin b/ti/audio/tas2781/TAS2XXX38D4.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38D4.bin
> rename to ti/audio/tas2781/TAS2XXX38D4.bin
> diff --git a/ti/tas2781/TAS2XXX38D5.bin b/ti/audio/tas2781/TAS2XXX38D5.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38D5.bin
> rename to ti/audio/tas2781/TAS2XXX38D5.bin
> diff --git a/ti/tas2781/TAS2XXX38D6.bin b/ti/audio/tas2781/TAS2XXX38D6.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38D6.bin
> rename to ti/audio/tas2781/TAS2XXX38D6.bin
> diff --git a/ti/tas2781/TAS2XXX38DF.bin b/ti/audio/tas2781/TAS2XXX38DF.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38DF.bin
> rename to ti/audio/tas2781/TAS2XXX38DF.bin
> diff --git a/ti/tas2781/TAS2XXX38E0.bin b/ti/audio/tas2781/TAS2XXX38E0.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38E0.bin
> rename to ti/audio/tas2781/TAS2XXX38E0.bin
> diff --git a/ti/tas2781/TAS2XXX38FD.bin b/ti/audio/tas2781/TAS2XXX38FD.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX38FD.bin
> rename to ti/audio/tas2781/TAS2XXX38FD.bin
> diff --git a/ti/tas2781/TAS2XXX391F.bin b/ti/audio/tas2781/TAS2XXX391F.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX391F.bin
> rename to ti/audio/tas2781/TAS2XXX391F.bin
> diff --git a/ti/tas2781/TAS2XXX3920.bin b/ti/audio/tas2781/TAS2XXX3920.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3920.bin
> rename to ti/audio/tas2781/TAS2XXX3920.bin
> diff --git a/ti/tas2781/TAS2XXX3E300.bin b/ti/audio/tas2781/TAS2XXX3E300.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3E300.bin
> rename to ti/audio/tas2781/TAS2XXX3E300.bin
> diff --git a/ti/tas2781/TAS2XXX3E301.bin b/ti/audio/tas2781/TAS2XXX3E301.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3E301.bin
> rename to ti/audio/tas2781/TAS2XXX3E301.bin
> diff --git a/ti/tas2781/TAS2XXX3EE00.bin b/ti/audio/tas2781/TAS2XXX3EE00.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3EE00.bin
> rename to ti/audio/tas2781/TAS2XXX3EE00.bin
> diff --git a/ti/tas2781/TAS2XXX3EE01.bin b/ti/audio/tas2781/TAS2XXX3EE01.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3EE01.bin
> rename to ti/audio/tas2781/TAS2XXX3EE01.bin
> diff --git a/ti/tas2781/TAS2XXX3EF00.bin b/ti/audio/tas2781/TAS2XXX3EF00.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3EF00.bin
> rename to ti/audio/tas2781/TAS2XXX3EF00.bin
> diff --git a/ti/tas2781/TAS2XXX3EF01.bin b/ti/audio/tas2781/TAS2XXX3EF01.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3EF01.bin
> rename to ti/audio/tas2781/TAS2XXX3EF01.bin
> diff --git a/ti/tas2781/TAS2XXX3F000.bin b/ti/audio/tas2781/TAS2XXX3F000.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F000.bin
> rename to ti/audio/tas2781/TAS2XXX3F000.bin
> diff --git a/ti/tas2781/TAS2XXX3F001.bin b/ti/audio/tas2781/TAS2XXX3F001.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F001.bin
> rename to ti/audio/tas2781/TAS2XXX3F001.bin
> diff --git a/ti/tas2781/TAS2XXX3F100.bin b/ti/audio/tas2781/TAS2XXX3F100.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F100.bin
> rename to ti/audio/tas2781/TAS2XXX3F100.bin
> diff --git a/ti/tas2781/TAS2XXX3F101.bin b/ti/audio/tas2781/TAS2XXX3F101.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F101.bin
> rename to ti/audio/tas2781/TAS2XXX3F101.bin
> diff --git a/ti/tas2781/TAS2XXX3F200.bin b/ti/audio/tas2781/TAS2XXX3F200.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F200.bin
> rename to ti/audio/tas2781/TAS2XXX3F200.bin
> diff --git a/ti/tas2781/TAS2XXX3F201.bin b/ti/audio/tas2781/TAS2XXX3F201.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F201.bin
> rename to ti/audio/tas2781/TAS2XXX3F201.bin
> diff --git a/ti/tas2781/TAS2XXX3F300.bin b/ti/audio/tas2781/TAS2XXX3F300.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F300.bin
> rename to ti/audio/tas2781/TAS2XXX3F300.bin
> diff --git a/ti/tas2781/TAS2XXX3F301.bin b/ti/audio/tas2781/TAS2XXX3F301.=
bin
> similarity index 100%
> rename from ti/tas2781/TAS2XXX3F301.bin
> rename to ti/audio/tas2781/TAS2XXX3F301.bin
> diff --git a/ti/tas2781/TAS2XXX8DE8.bin b/ti/audio/tas2781/TAS2XXX8DE8.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX8DE8.bin
> rename to ti/audio/tas2781/TAS2XXX8DE8.bin
> diff --git a/ti/tas2781/TAS2XXX8DE9.bin b/ti/audio/tas2781/TAS2XXX8DE9.bi=
n
> similarity index 100%
> rename from ti/tas2781/TAS2XXX8DE9.bin
> rename to ti/audio/tas2781/TAS2XXX8DE9.bin
> diff --git a/ti/tas2781/TIAS2781RCA2.bin b/ti/audio/tas2781/TIAS2781RCA2.=
bin
> similarity index 100%
> rename from ti/tas2781/TIAS2781RCA2.bin
> rename to ti/audio/tas2781/TIAS2781RCA2.bin
> diff --git a/ti/tas2781/TIAS2781RCA4.bin b/ti/audio/tas2781/TIAS2781RCA4.=
bin
> similarity index 100%
> rename from ti/tas2781/TIAS2781RCA4.bin
> rename to ti/audio/tas2781/TIAS2781RCA4.bin
> diff --git a/ti/tas2781/TXNW2781RCA0.bin b/ti/audio/tas2781/TXNW2781RCA0.=
bin
> similarity index 100%
> rename from ti/tas2781/TXNW2781RCA0.bin
> rename to ti/audio/tas2781/TXNW2781RCA0.bin
> diff --git a/ti/tas2781/TXNW2781RCA1.bin b/ti/audio/tas2781/TXNW2781RCA1.=
bin
> similarity index 100%
> rename from ti/tas2781/TXNW2781RCA1.bin
> rename to ti/audio/tas2781/TXNW2781RCA1.bin
> --
> 2.43.0
>

