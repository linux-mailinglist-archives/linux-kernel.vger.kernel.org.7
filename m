Return-Path: <linux-kernel+bounces-898633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B4C559FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAF384E2C22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC629BDAD;
	Thu, 13 Nov 2025 04:05:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5E2D9EE2;
	Thu, 13 Nov 2025 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006756; cv=none; b=L04HAbcOz4uWpU9b2yhSilyyTHw45zXItrwLNxicLw/gRZraJfnOCOE008C6NdFApHk+LldKC8yaw+g5GkekdABgDs+seS4HQIM9YSm+sb50y9zt9pUKx54PQQk98nEsrmBt13YI+6CnugVJGP/snBn+H/0wM0+5fbhmOZ7AKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006756; c=relaxed/simple;
	bh=wr/dZ9WQS+zfl0uHH0gh59QDLaHTq/wIObJvtYFruFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkPEi05ehMkI2DJUEorJpzs9dgg8idbaf6Aqrx/beUHPJdUUqEcA4Uo23reGz7/wciF6nRbCQ2NkZNc5UKxNDZSNKh2zUktDy+QQIgwOXr7S3dyD2IrDL8Vk1s5fgG3nkYW5a7ySm62nfgLyiqZ1q/POKdI/+Wpn+G1Aoxb81ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97842150C;
	Wed, 12 Nov 2025 20:05:43 -0800 (PST)
Received: from [10.164.136.41] (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549963F63F;
	Wed, 12 Nov 2025 20:05:44 -0800 (PST)
Message-ID: <633b4702-f7fa-4ea5-a428-d120191f620f@arm.com>
Date: Thu, 13 Nov 2025 09:35:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/22] mm: replace READ_ONCE() with standard page table
 accessors
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: devicetree@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Conor Dooley <conor@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Lance Yang <lance.yang@linux.dev>, Wei Yang <richard.weiyang@gmail.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
 <20251113014656.2605447-3-samuel.holland@sifive.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251113014656.2605447-3-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 13/11/25 7:15 am, Samuel Holland wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
>
> Replace all READ_ONCE() with a standard page table accessors i.e
> pxdp_get() that defaults into READ_ONCE() in cases where platform does not
> override.
>
> Link: https://lkml.kernel.org/r/20251007063100.2396936-1-anshuman.khandual@arm.com
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   

Reviewed-by: Dev Jain <dev.jain@arm.com>


