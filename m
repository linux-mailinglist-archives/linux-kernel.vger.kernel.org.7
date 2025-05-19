Return-Path: <linux-kernel+bounces-654044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8A6ABC2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197ED189E356
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B59286422;
	Mon, 19 May 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XIqp4KIr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1DA281346;
	Mon, 19 May 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669222; cv=none; b=QurPCTXyk/LC8lOYms/CYCT/+IE2Xat8FpeAQ859EVLDoCHj8UYuNq3kVFZSUOUTaS+J+u8gvW5x1CVC/hlrSxaBVxEFfcWMZb9nRj2osEfN7Dw9q/pu0VpwLJdy27xRia2hDmz3PTToSlAlB+pahthwbEq9h+vcgi+TaBDunlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669222; c=relaxed/simple;
	bh=BM/Dl5qWCkMnJg16IPiFKB0N4stAnTqyudz0G2oBd3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pA9e0f2RDtLHu8xnABNNQs56LoW+DcyF/ZUJpbjmrmg6wxhxpTbpjLYTwcMuQcVwPUmjABA+GcSBCOm4S6HXwzw8hOYlj+ZAWjG/an4o4OVCKX+RA60hkSEicjWSNJ7l5dAmyEYKc7MnnR73jw0ZYnsfrAGh0Yoy/yHRFBAFvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XIqp4KIr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 61B3D41AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1747669219; bh=NsIpsnCHMaMX+L15e7tjvSysbCwRgG5P+DOALl6smkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XIqp4KIrZbxWevhvMsGnazsroPPopIYmYQ4Zp9YyfirCSncs81GyuxYz1djcggK5T
	 U0vTUgwiADRBmVVqZkVVF4JDwtg0TcmUsPn3gWNUy7b4cK0Y6kmZhAToo/TuLfR/Ha
	 TRhxzxWOPQu7zLmfZOqSSOHQluSk8D5coBz6oW7ePMXtaXaX32JIiuc0OalkEHSGMM
	 1JwVon9qVfrjkkWeT72fDD6Q6RyLqsnfbJhQUHvfkFntRmYAZhV5f+vKtfdVp63lJw
	 yHT/EAA8VeKjQzlYblZ+O5zbmS/sdgINTkI9QJorwZ/2XNWmHyEtuejRvdC+D3Igfk
	 flbFcoIS7Q2bg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 61B3D41AA1;
	Mon, 19 May 2025 15:40:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jesung Yang <y.j3ms.n@gmail.com>
Cc: Vineet Gupta <vgupta@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Dinh Nguyen
 <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesung Yang <y.j3ms.n@gmail.com>
Subject: Re: [PATCH] docs: align with scripts/syscall.tbl migration
In-Reply-To: <20250506194841.1567737-1-y.j3ms.n@gmail.com>
References: <20250506194841.1567737-1-y.j3ms.n@gmail.com>
Date: Mon, 19 May 2025 09:40:15 -0600
Message-ID: <87ldqsip7k.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesung Yang <y.j3ms.n@gmail.com> writes:

> Update the documentation to reflect the migration of the following
> architectures to the centralized syscall table format:
>
>   arc, arm64, csky, hexagon, loongarch, nios2, openrisc, riscv
>
> As of commit 3db80c999debbad ("riscv: convert to generic syscall table"),
> these architectures no longer rely on include/uapi/asm-generic/unistd.h.
> Instead, syscall table headers (syscall_table_{32,64}.h) are generated by
> scripts/syscalltbl.sh based on entries in scripts/syscall.tbl, with ABIs
> specified in arch/*/kernel/Makefile.syscalls.
>
> For the convenience of developers working with older kernel versions, the
> original documentation is fully retained, with new sections added to
> cover the scripts/syscall.tbl approach.
>
> Verified with `make htmldocs`.
>
> Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
> Link: https://lore.kernel.org/lkml/20240704143611.2979589-1-arnd@kernel.org

I'm not sure anybody has looked at this ... but nobody has complained,
anyway.

I have applied it but ... it seems like this document needs a more
thorough refresh rather than just adding some "actually, don't do it
that way on these architectures" notes?  Hopefully somebody will find
the energy to do that at some point.

Thanks,

jon

