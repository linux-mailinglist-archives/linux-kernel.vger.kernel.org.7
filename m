Return-Path: <linux-kernel+bounces-581079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BF9A75A3F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B78188AD8A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D91ADC69;
	Sun, 30 Mar 2025 13:52:05 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA0A47
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743342725; cv=none; b=sk5K+TjBQW6FVRYUGt6mjvNjuyxaBqpgAbEtrC2Z/ZX0y9PQO49WkrD7xUJRZYqTP+umYp/ytSukOM1TbaCD3cH/6GNQVQDTmoy8BxWJGLz+tc82ALChQEKEvAkmU80XWdjtZROPMu0i5gOfGfSYiFDwEdIZ4snJCRUl9aMTTS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743342725; c=relaxed/simple;
	bh=2Ip7fsjMmv01983Db7BpsdwX9E/fP7OBduxaGKm1Xw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYDXthnZ5/nl13gnhhOsxQCizxrp/7Y3PAhKUV4GgV+7VpeOD196WZQOCemxVOIuuT0j7NdqiKcjzgBMIKWLtdzfrHBYT99jKgGNPJycoQ44ibDSxUNi9a98FFKDtf1eUQzexUecA8HbpdW/Vgz50YXE1LFerohHwwmR0JANqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A514441B8;
	Sun, 30 Mar 2025 13:51:50 +0000 (UTC)
Message-ID: <deb70c8d-aef9-49df-819c-53007a9ad699@ghiti.fr>
Date: Sun, 30 Mar 2025 15:51:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/3] riscv: mm: Add soft-dirty and uffd-wp support
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20241113095833.1805746-1-zhangchunyan@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241113095833.1805746-1-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeejvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeevfffhleelfedvjeegleefffeiveejkedvtdeggfdtgfeiudejueeghffgudejvdenucffohhmrghinheptghrihhurdhorhhgpdgrshgtihhinhgvmhgrrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemvdgvhegumedvtggumeehugelieemjedtlegunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmedvvgehugemvdgtugemheguleeimeejtdelugdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemvdgvhegumedvtggumeehugelieemjedtlegungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepiihhrghnghgthhhunhihrghnsehishgtrghsrdgrtgdrtghnpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmp
 dhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhgrnhhgrdhlhihrrgesghhmrghilhdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Chunyan,

On 13/11/2024 10:58, Chunyan Zhang wrote:
> This patchset adds soft dirty and userfaultfd write protect tracking
> support for RISC-V.
>
> As described in the patches, we are trying to utilize only one free PTE
> bit(9) to support three kernel features (devmap, soft-dirty, uffd-wp).
> Users cannot have them supported at the same time (have to select
> one when building the kernel).
>
> This patchset has been tested with:
> 1) The kselftest mm suite in which soft-dirty, madv_populate,
> test_unmerge_uffd_wp, and uffd-unit-tests run and pass, and no regressions
> are observed in any of the other tests.
>
> 2) CRIU:
> - 'criu check --feature mem_dirty_track' returns supported;
> - incremental_dumps[1] and simple_loop [2] dump and restores work fine;
> - zdtm test suite can run under host mode.
>
> This patchset applies on top of v6.12-rc7.
>
> V5:
> - Fixed typos and corrected some words in Kconfig and commit message;
> - Removed pte_wrprotect() from pte_swp_mkuffd_wp(), this is a copy-paste error;
> - Added Alex's Reviewed-by tag in patch 2.
>
> V4:
> - Added bit(4) descriptions into "Format of swap PTE".
>
> V3:
> - Fixed the issue reported by kernel test irobot <lkp@intel.com>.
>
> V1 -> V2:
> - Add uffd-wp supported;
> - Make soft-dirty uffd-wp and devmap mutually exclusive which all use the same PTE bit;
> - Add test results of CRIU in the cover-letter.
>
> [1] https://www.criu.org/Incremental_dumps
> [2] https://asciinema.org/a/232445
>
> Chunyan Zhang (3):
>    riscv: mm: Prepare for reusing PTE RSW bit(9)
>    riscv: mm: Add soft-dirty page tracking support
>    riscv: mm: Add uffd write-protect support
>
>   arch/riscv/Kconfig                    |  34 ++++++-
>   arch/riscv/include/asm/pgtable-64.h   |   2 +-
>   arch/riscv/include/asm/pgtable-bits.h |  31 ++++++
>   arch/riscv/include/asm/pgtable.h      | 133 +++++++++++++++++++++++++-
>   4 files changed, 197 insertions(+), 3 deletions(-)


As mentioned by Deepak, there is a new proposed extension Svrsw60t59b 
which will free 2 more bits. It would help if you can come up with a new 
version of this patchset using this new extension, would you mind 
working on this? If not possible, let's discuss how I can help.

Thanks,

Alex


