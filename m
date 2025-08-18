Return-Path: <linux-kernel+bounces-773478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC16B2A0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A3E3AAD88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FDA26F29A;
	Mon, 18 Aug 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVcdeK96"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B8261B8E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517427; cv=none; b=Vshbuyl7FLRnZePpBGa9FoJ8jFL+1lkJtbaIKNCKgP6b5+4eHVGygbo9zKmM628jtJgDSaF2cvdNMDeI3Te1xJe/25OxGETnMdXtYsA+TkKirLzA1KHIUMZFE9hIE+xOD9dcW/Dz5M3nIeyEZLlgdWwMsgxwxlKzL2g7iqq9vtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517427; c=relaxed/simple;
	bh=1ACqnTbp6lr2CX/L2N5qWPGAKLrbqzeknhUGFg+AHt4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MEGtH4TUrNwmdIp7H0ODB0jBOPAzlZlMtpi19fPTkrnFUW08GNasEcs8N544LviRahXN5Pj7wFL5G/52e20jrLD7sqyH2e3yNzz6bx3e8/gY0rfwoLng9LITVJbHDsJMUoMkrfFmgNrsgVXUYJqNTMxaWC7jadstDwQ7A6Zy1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVcdeK96; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f9044198so5728681fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755517423; x=1756122223; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ACqnTbp6lr2CX/L2N5qWPGAKLrbqzeknhUGFg+AHt4=;
        b=QVcdeK960VRYkxkvNLmeRRDi1/YBFN4MM+Jisk9JspLYA09+YB0ns9v2xVrZDJMU7B
         hGN3A0JfForVj+vvPVKxBqpsc4hmsGI4QghWgvV3ZL7+ZGZ1T5Ee7alAD3D21p6k/mj2
         6W5joV1qBlsvSp/AbaN1GWPoEHgKJdKytzDR/56gsRbQbF/OpH9pS7qvNt9a4Q3VSiLF
         HOH/8FG+ZF5dRm0rztbqfp9W6kgaL6qbq7az3bLO8Vk3ccZMTZ3cKdv5pFJfy2tz9/PR
         RrK63Q9arNY+BZ5A1SOSxknGFG8ggjTucHFG+Eqe5M98l4k0MTa05RO4dSp5+LXUjz55
         eneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755517423; x=1756122223;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ACqnTbp6lr2CX/L2N5qWPGAKLrbqzeknhUGFg+AHt4=;
        b=YgfBK/dBcrUTOdn4AgmPrBZxjOxYJrpmZBfQZtuPdWVDoP4lMUp17rfyYnVuT2eM8r
         MeYSqVLHjtpwLaUKx8fttCU8daUgrhRyk63HXDcvYbrutDEiiBrvhqvtoEIlr95FHvXc
         wNaRpQ12Ew9pbunzMC6jO0vHTZ/jOGM5ViDa1XgGFkF/2YKSa8croKWp16Vjk85UD8Oe
         8Zth2b8EFHp+IeWDwFbMkeeWyYjRGhrve5RgeIR0oEK1fyJAP7k15lrkseXkoTg0C/Bz
         fsBOMPUW+0oAUDAiMoBjxf1hbWlL9vtdmtZtuxnbl7PuFngfbCMC97AVSDDxIVeyIqQL
         Xv6w==
X-Gm-Message-State: AOJu0YzQSmx3am1W0itikwIFbgCUzgV2wC7wNMaqiwaAejqwyp5qIXRG
	zJEUqBw8qX/Z84rny7MlRxyBvJYq6S/0WIom/shKc/hYTVkJZ/HENyqg4XZaB4FCZ+VbUxfGPwz
	23p4+rl1dkloYoDQrEWB9iK6hZiRV/eEUoUFGZ9w=
X-Gm-Gg: ASbGncv7UDPJ7s7unBXyeBSp9CjKKd9guGgG5SbnjDFJOZcffCNAfTZQmkvmvb39k57
	lt8F9YHl8KpNYm16puNFISG4kUOZqXiywn8Az61qlkxqzCLsoc2bxh7YbSmH0Z25mPZ9uFoHB0h
	6BdNVAaNEU5oJSJ5EZFx0MaFZi/eKzz1wrOOJ4dgO74UMWr1IWnhvMllXYiHgAEdiQpwvFuLSim
	pgMdbmRgitlkIvXvUI=
X-Google-Smtp-Source: AGHT+IF/DQFHBcWNCA2EcUjK2nVz03fpUK/upf1op2W6bD9UTyVdleeL8/zjJ9fMQhc4fNEMxcromefCizgdcTG+UPc=
X-Received: by 2002:a05:6512:68c:b0:553:252f:adf4 with SMTP id
 2adb3069b0e04-55ceeb864d8mr1449539e87.10.1755517423340; Mon, 18 Aug 2025
 04:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cyber security <cs7778503@gmail.com>
Date: Mon, 18 Aug 2025 07:43:30 -0400
X-Gm-Features: Ac12FXy4ZtSVkJlX7veTPf0pSKw3PSHFi3Cm2y_VhR0Y_V7WqdZO05r7Vm--3zM
Message-ID: <CAPmip_xKv6bA07apqYhyHxTNsnBitVbmcwcYE24xw2RYkDX5oQ@mail.gmail.com>
Subject: [RFC] Proposal: Introducing Rust for memory-safe Linux kernel components
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am Security Researcher [RelunSec] so let's talk about rust in linux.


Proposal: Incrementally introduce Rust for select kernel components,
focusing on modules or libraries that benefit from Rust's memory
safety guarantees while maintaining the majority of the kernel in C
for compability reason.

Example: You Can expose Rust driver apis for write kernel driver in
rust and write other component in rust if possible keep using Rust
with C binding example write 60% of C and 43%+ of Rust for compability
reason write some critical part in Rust of kernel so in 2025 for
safety reason you need switch to rust unlike 1997 C is a language
actually 2025/2026 Low Level Language will be Rust.

Experience: I"am Security Researcher. I also started write in rust
some software or even hardware and firmware developement and fix issue
with C bugs via reimplement them in Rust.

Requesting comments and discussion on feasibility, potential pitfalls,
and integration strategy.

Kinds regards

RelunSec

