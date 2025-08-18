Return-Path: <linux-kernel+bounces-773899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA80B2ABFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561FA202AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC1235063;
	Mon, 18 Aug 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RQpqI/V9"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9572309BE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528967; cv=none; b=dgSBmw6Ytipoa/ttouwksWfsS272865aUvyHeCH+B0oRZVn9EuN7XxqNJ8pUcc5QK00jlQdGwUXUO6TA1DIwf7f28TJ1xxuEuGy/Q+meqgNPiSH+Xy+awfHbhVlui7EDF9IZ56+MDQDR0d+TFp+ggmVhLFfAvedOCgVc3eUMUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528967; c=relaxed/simple;
	bh=OoK8EZCVh6shAzfoSOyrqIIYjO/z1iYKrSUGlMsjZxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXlNxE4y4+PmpNDH0ndpWePoiKot/JzXehWUjUMMZj49ZJSNFbmkmb8v6BjGwJj57T16NnX8dfYllxFqLoQNf3y1hd+3qmMCXMzPAtkmwoWBlzKYIOAH0WM0wIa/jyP3l964+whnZb+Pmp5dqSBfSV8V5n3tLtMK1X/ByFObiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RQpqI/V9; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e66937e452so5855815ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755528964; x=1756133764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9CfNSTuc/uF1qHY5WFP24kXO82FfA15GfsdN/C+IOc=;
        b=RQpqI/V9TnMHG7v2MomdAoIKrZCNnmu6gMri5+Rcw8M9G0T+ExOaXaq9VeLAjyCssR
         lvwXNxJhJsIQoP9tCn1EMesTxtDQEeqZyhNRqH1sPzgOEkG4HvDwe50yipll/p67KqhF
         VDvB5z9GomrDNTVcMzfQWIOaE9ojAQo/AlqTff0NuOqyzYNQC3EEPikGAizq/FbXPjxS
         aWVF/fFqga9QcTq/eXaU692caGFN3xDKmSuDWXKq+6iDlDy4C6wrnnuaQzYjpdneGa3W
         I8AB3p4aj4VAqVDxFWaPp738jTumOaoo05nk8DaLhDmmsEeL2GIu6vyWCYZLxUuAyY1/
         U3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755528964; x=1756133764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9CfNSTuc/uF1qHY5WFP24kXO82FfA15GfsdN/C+IOc=;
        b=IPn/BKuHqymbfnc5R97RP5uN4sLKX5O4odF+VngrAED6c1cbGmoirjsIAnFSCanRpu
         5f9ABjTJ4BLODt5yQ6w1cm8eCFdhI6wSOdCoABuyoxkHBI3kxPAN21RTXLu1mUIDrgbz
         O5k4R+wUD8zka1r59bCxqZo0BiGr/5leFCuDKBaSxqq0KNFYF+sJtsrZQBdPUnS38+qv
         yfI/5LnsrFgVORMqp9jIzSU9bG0WZdV7LhL71onz/eZ49nLrHNXLI7XkwL4akd8nU5h4
         GiRDSQF5X+GY/p+Mfj+jVc9OCg74lX/TwNfB4xeYefOI4i1StbqHEpAOR3O1YjC556As
         fuOA==
X-Forwarded-Encrypted: i=1; AJvYcCWwh0MTguo9jLdqtrkmFW8uHPA97F/OHEUfWijQg8NA2oewTim/j1mDb0DteddYdn7gY7yosdmhm26c270=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxac7+yRqQFzptSCer0GNoErI2I8eaRfXMyyRgjc7WR6uoEMHVh
	o7g7SdgNJmEq8WrmxnnnBgbGkWhtbwpHyK5DEIVP99AIoxA9MYsu3b0HuMYkZy9tz1c=
X-Gm-Gg: ASbGncuoyJZSeJqEZu3kNJmgo8zHj7CCDqJcodqHFMOi32zdMLpd7+OqOPpRb0y3LGD
	eW+d2BLNWiBrxztVn7bnd6O7NW1dE+Y0y1pi3jjDEvshePQvt/ONPv59I/g0mbvifXOZDTb9dTl
	HcbOG2CFUPMCN/yUhxm0kSY3vu2Rf0FT0TJQa+iKr7yE7QmtG7h0JGE3Bshk3/lL76b9jswB6Ai
	wnJmXCnEHdG+UxpM19StEM5Ni0YBE/Bk1ZmFhvo+8ujIzIilbFTmb8XEE+liudQIY93expIf95L
	YE9W6vYsLMzs2Ss1ZOVjQG/VKj2OlG06K1WF9cHxcgdr/UWfmy2AsE8ulpBhmQyThpAHXXskCh0
	7ksST+1sbTv3Mq+nvf7+GXUmGrYT5hQ0MLDE=
X-Google-Smtp-Source: AGHT+IHKhwEj30JkX2wIaBs2G2ErrpG6q1NBNVHTVwHY/0ZVQYUutUV3YGS8fX1au2IKlXNP3c+x+w==
X-Received: by 2002:a05:6e02:18c6:b0:3e5:3d13:5d80 with SMTP id e9e14a558f8ab-3e57e86aa7amr243594735ab.6.1755528964324;
        Mon, 18 Aug 2025 07:56:04 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef56sm2565433173.5.2025.08.18.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:56:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:56:03 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
Message-ID: <20250818-ba7d5f923321feb836a408db@orel>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818143600.894385-3-apatel@ventanamicro.com>

On Mon, Aug 18, 2025 at 08:06:00PM +0530, Anup Patel wrote:
> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/csr.h |   3 +
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/riscv/cppc.c    |  17 ++--
>  drivers/perf/riscv_pmu.c     |  54 ++----------
>  5 files changed, 184 insertions(+), 56 deletions(-)
>  create mode 100644 arch/riscv/kernel/csr.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

