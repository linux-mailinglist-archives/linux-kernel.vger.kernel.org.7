Return-Path: <linux-kernel+bounces-869915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC68C08FC2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06493BCB71
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA92F83DB;
	Sat, 25 Oct 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncNWAMtD"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA51E285A
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393505; cv=none; b=F0t5HJ8uJQAK1K8+n42EFdzYpuUvrYfeQdspuhNkEWEOAWSnk7ZEVMR/v7kN9JrOG9sx+kDuszbavPIFtyRM6WsfHgSto/GKmukGMH0TKWsPZq8i5oSa/Ez/NUbxLhfdFXp0NpJNPRl0DPgHtIaLXw+BP+yxrESe7j8gHY+BYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393505; c=relaxed/simple;
	bh=Dq8AJOmwfhEJ4N/eqWoVBUPmAtuFUn4vvyR6OHjX8zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7qHiwkGPc5Cz00GUIF+Cwzy+DQQjD5iQcU4mbAHCA5gsRi5lkxijsN5TZAMZ+wAxe21uXfOOSVpSPPODDW32hMvRIOxbdlTL3KlBqWKX5V264+LTeEACdVOiDcS//uGvnF24xzD+c+UPy2q+yJDjuY1aCwfJTSej05NOTuTBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncNWAMtD; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54bc08ef45dso1946572e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761393502; x=1761998302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I9TkdogdsV9nixdXBith0cDlYgPpHBpTVoAhEFR6cE=;
        b=ncNWAMtDsalqKfYhOrm7Nbfp5BgOvXECDUT727W1LtykctntH02S8mT62cwJSyGv/8
         PrBT8gWPyhYxs8/o1OC9ypzTcrVSFYtX9Tv+TKsQ1ACdUWBNOXxAwOkQmL7F57UcjKWi
         4i5LNIAv/07CGqRkrBBvG1u7MxdNX2tU2JZDgZ1aDRS/aDLUy4MmJtPSIh0kymPDtlgL
         imj88P9U7GEqLreB3VWhYEvyiPzFcC9nBR/UkG0iA8vHlp3seWt1WjValCXGo/mAH0Bm
         59nTbov7rI+givPGK5lbvc7qfMvmxW+KIpuWwOExCPQ64xHlQEGlGvpg6CMvBdQc4nLr
         51Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761393502; x=1761998302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I9TkdogdsV9nixdXBith0cDlYgPpHBpTVoAhEFR6cE=;
        b=HwuAmM065f4OhECWhgFfWwtGtZ9ncl4/9VDwXFYCN5bQQCEy5CwBFAbVSodGF8lg2o
         ZLkXEyEqacYINqwKuZTDheY3jmquI4uXpHo6NqTpNQcav4NMQ7iz9pQoJZAPOqAAWJ/R
         2WfmvtiDOgVurtO5/wbl3u1paPBCEXz7hv6pTRV/l5IIYj8m3NPhOtnNtGXP/Ob71T58
         pZYV4bIG0bPwtZqvPIU2LIaIOBi/UVQTfXEke+FOXSJ6qOPU5fBqjUFUq2mPeKjK0hvs
         7FU1KaESPT6JAKEm/7ex0Qko+41eYYzZ73n9elXuAHK8TJ7pQt6Wqu/yXd7uEMTxISzG
         B+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQW84YqEmFCtNkTq0zheCxygNSHDW1xvsEPO3tv1CeoepqAbwnl9hyxHS5n0TmGvAJiQFvz/yLLTYhh7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dl0CB/D5i/mWEzznslFJq46cMVQir8jreawYGb4+PO+MP8aS
	Y5Kudybj11lu7+I/XglCKXD3tSWmOU0m/6KL+wYKkJgciHMDGZA8C97x1RqQpBY4yKEoOVJwSdJ
	kBsDVSo1y7OX8SMJ0gzW37ZEgS4v6QpY=
X-Gm-Gg: ASbGncv8IDZ9MCKH+fJnjZRT/7TKATT0eajxZ3d6S8LUKNVlIVdVgUYpLPpKXGhTKS8
	etFWIy8E9MJnK5THtWgC1tWb/lROh3yriDPHyT4ismxWpe4/Ym/V+9qRHwRltzp2UzasVaW2Tpm
	gnWn3hCXWnEx7YYVsVJuWYgF/vUl77WpDBpCN/NVvzUbnsFlUScZh6dLFemOPK+XAqlbApdh0uC
	D5hNuUz3Eaq6V0p8rjSmXh/6pWclpmjXFLjmWm1Y3B8U5Ey1PhPu4AGFk12hPI0rKTRXegd
X-Google-Smtp-Source: AGHT+IEjjxEtU4jsBOkQ9KzzJg48mbR9wHZxw8HVS/t5afsmBknagybFZ4yDuSvqyYJYMpWyOtsSCOSfKUdve+9kw7s=
X-Received: by 2002:a05:6122:e1dc:b0:556:9cb9:65c8 with SMTP id
 71dfb90a1353d-5569cb9739fmr2881748e0c.0.1761393501810; Sat, 25 Oct 2025
 04:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760929111.git.unicorn_wang@outlook.com> <PN6PR01MB1171791524E2BC1C227E342F6FEF5A@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN6PR01MB1171791524E2BC1C227E342F6FEF5A@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
From: Han Gao <rabenda.cn@gmail.com>
Date: Sat, 25 Oct 2025 19:58:10 +0800
X-Gm-Features: AWmQ_bkPkZoLoqCmIL-grA_sDMwqczj2smKSV0IWSOxGD1NzJo1hieHmZhU-890
Message-ID: <CAAT7Ki_4nkKM1-D_8ybwusxTTsR=Lf09v8Cx6QDWfuy8KLtbBg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add PCIe support in DTS for Sophgo SG2042 SoC
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, conor+dt@kernel.org, 
	inochiama@gmail.com, krzk+dt@kernel.org, mani@kernel.org, 
	liujingqi@lanxincomputing.com, palmer@dabbelt.com, pjw@kernel.org, 
	robh@kernel.org, tglx@linutronix.de, sycamoremoon376@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:49=E2=80=AFAM Chen Wang <unicorn_wang@outlook.co=
m> wrote:
>
> hi, Han Gao,
>
> Please help test this out on EVB, I don't have those boards and just
> tested with my pinoeerbox.
>
> Thanks,
>
> Chen
>
> On 10/20/2025 11:32 AM, Chen Wang wrote:
> > From: Chen Wang <unicorn_wang@outlook.com>
> >
> > This new patch set is a continuation of the previous patchset
> > "[PATCH v3 0/7] Add PCIe support to Sophgo SG2042 SoC" [1].
> >
> > The drivers and bindings have already been merged into the kernel
> > mainline, and this patchset will focus on submitting the remaining
> > DTS changes into the mainline.
> >
> > This patchset is based on v6.18-rc1 and the only changes since v3
> > is a fix to address the comments from Manivannan Sadhasivam to make
> > sure PCI address of the I/O port to start from 0.
> >
> > Link: https://lore.kernel.org/linux-riscv/cover.1757643388.git.unicorn_=
wang@outlook.com/ [1]
> >
> > Chen Wang (4):
> >    riscv: sophgo: dts: add PCIe controllers for SG2042
> >    riscv: sophgo: dts: enable PCIe for PioneerBox
> >    riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
> >    riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0
> >
> >   arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts  | 12 +++
> >   arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts  | 12 +++
> >   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 12 +++
> >   arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 88 ++++++++++++++++++=
+
> >   4 files changed, 124 insertions(+)
> >
> >
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

EVB1.X/2.0 can be started normally.

