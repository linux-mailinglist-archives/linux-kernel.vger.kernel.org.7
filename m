Return-Path: <linux-kernel+bounces-850064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC0BD1C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DD5189447B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5E2E6CA5;
	Mon, 13 Oct 2025 07:20:36 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8FA145B3E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340036; cv=none; b=re8m0S+7PAV3gsRsMN1wGXHM5x0LSRqt/ycId/BG3me0weWXiAkDurRXgKmtAeISR/4FmrPkIZs9NIxwIkNgkeBSQxvU8f6OBodEIi4LvlvrSy51nlgkpRYenE4CmzyxmGjoecwjBe0pq4TaojzdhdZwWGT4fFYEkxREFI2pukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340036; c=relaxed/simple;
	bh=MZWBRtBK7Mp3UL9fgbqAUHnWFwcGXj/Go1Ra/k965GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CK1xD1d5zAzZ9oZF90ghqY4Uk13sF6kuEYqxrM9eGPUBAJptBWKi2eQ1B7fp6cn5d2fjwzGcMlaMQonG1H/CHTHuXKsreQNdW/RvYj0tIbh0FzsEycjajPdq2iTaVpGV/4aaOZyXFQi8mNArDyBIJMZGE3YcDlTTl2S9nK2mCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4clSZ12DFtz9sSY;
	Mon, 13 Oct 2025 08:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CKvQlxgPN3Yl; Mon, 13 Oct 2025 08:46:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4clSZ11Rk0z9sSV;
	Mon, 13 Oct 2025 08:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2137E8B766;
	Mon, 13 Oct 2025 08:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id HicaaMKJ6VtM; Mon, 13 Oct 2025 08:46:49 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EAD858B763;
	Mon, 13 Oct 2025 08:46:48 +0200 (CEST)
Message-ID: <2b4a3215-1620-40c9-a00c-ca833ebbb7b6@csgroup.eu>
Date: Mon, 13 Oct 2025 08:46:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/powerpc: Remove .interp section in vmlinux
To: Vishal Chourasia <vishalc@linux.ibm.com>, christophe.leroy@csgroup.eu,
 maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 Nathan Chancellor <nathan@kernel.org>
References: <eeaf8fd6628a75d19872ab31cf7e7179e2baef5e.1751366959.git.christophe.leroy@csgroup.eu>
 <20251013040148.560439-1-vishalc@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251013040148.560439-1-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+CLANG ppl

Hi,

Le 13/10/2025 à 06:01, Vishal Chourasia a écrit :
> While debugging a ppc64le QEMU guest on an x86_64 host, I observed GDB crashes
> when attempting to attach to the remote target:
> 
> (gdb) target remote :1234
> 
> Investigation revealed that cross-compiling the Linux kernel for ppc64le on an
> x86_64 host using Clang produces a vmlinux binary containing an empty .interp
> section. This empty .interp section is responsible for the GDB crashes.

Which version of CLANG is it ?

> 
> This issue does not occur when:
> - Building for ppc64le target using GCC on x86_64 host
> - Building for ppc64le target using Clang on ppc64le host

Is it the same CLANG version ?

> - Building for ppc64le target using GCC on ppc64le host
> 
> For details refer [1]
> 
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=33481

Christophe

