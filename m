Return-Path: <linux-kernel+bounces-833617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18895BA26CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE8E1C02B74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C9275AE1;
	Fri, 26 Sep 2025 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m4d0JtgO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756422749CE;
	Fri, 26 Sep 2025 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863688; cv=none; b=dQQzbW+++413XPJsPKLErFOV5/7KwhoO4NKruX5CZdE/aKMmRHF92echg+ilL71veHN5y6gwMmp3u6hDHnoOGYi4wgwPyfSU7H1QY3py39f6L1gdjK7rSCZbNv1G4vj8+TVZjKPdwYOu4TKcTM8dCFNKXoqoZd56+Ih9xRwxODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863688; c=relaxed/simple;
	bh=ByeMJo60bvbtMMmpAcMXNN6aRyyLg9N8lH6sgDTI8mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lB/KaswSNtYZsLlW5VkXF7L8JUfvZzi5gvqey8hfNXqMhS+WRcUe7x9i0fV/+pGpKPi2LYWvCg9f/fmKCATnM8YsZnXcywxSgGohuH4iPmTSwQtqwNe4KTqrB1LCByRzluMr1gdQpxiN/q1VBapJ5xM5Ji6B/yWRRoZrgXD7yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m4d0JtgO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bXsMiGgu0Tu21kIHHLsClOAsZPBY8FqiGU15Oi59YtE=; b=m4d0JtgObqIMfP9tbu6BnGX/yT
	PHyrRR7NkTxplpm6BB1LrInkl3Xr5QVFoE8Kad7e2QfNmu4kgQcJ+86siP492m3vMMEanve5zgdbk
	fJU96X+KmtZNCgc3IzgxX7CCrTzbW9pr2oHEk+DOrl436TPAqA7o7JFM6FAjokCKJRXbHd7/swR1e
	jikvNegZdxEtXYmbMDem8u6UmHSrcdj/DE22B16aB/yCBGvdeAQHzCiACtYWB9uCmMgz7yMorCbLU
	cG7iKttFR5oto364TQZ81Xqf+BNKf+vUUPsMUh1JyYMChKLZ2E97AZr9lrpexMy3NVfUgVs9k9otF
	MSTEFarg==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v20n3-0000000FyOw-3sUJ;
	Fri, 26 Sep 2025 05:14:41 +0000
Message-ID: <32e30b90-c089-4b96-9573-3c57a4e66a8e@infradead.org>
Date: Thu, 25 Sep 2025 22:14:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs: perf: Fujitsu: Fix htmldocs build warnings and
 errors
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, corbet@lwn.net,
 will@kernel.org, yangyicong@hisilicon.com, fj2767dz@fujitsu.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linux.dev
References: <61aace07-890a-4b55-8e84-935ebc4a3be1@infradead.org>
 <20250926043748.3785-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250926043748.3785-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/25 9:36 PM, Gopi Krishna Menon wrote:
> Running "make htmldocs" generates the following build errors and
> warnings for fujitsu_uncore_pmu.rst:
> 
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:20: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:23: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:28: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:81: ERROR: Unexpected indentation.
> Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:82: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Add blank line before bullet lists, block quotes to fix build
> errors, resolve warnings and properly render perf commands as
> code blocks.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changelog:
> 
> Changes in v3:
>    - Properly render perf commands as code blocks (use "e.g.::").
> 
> Changes in v2:
>    - Remove formatting changes unrelated to the fix.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
>   Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> index 46595b788d3a..2ec0249e37b6 100644
> --- a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> +++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> @@ -15,15 +15,19 @@ The driver provides a description of its available events and configuration
>   options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/
>   and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
>   This driver exports:
> +
>   - formats, used by perf user space and other tools to configure events
>   - events, used by perf user space and other tools to create events
> -  symbolically, e.g.:
> +  symbolically, e.g.::
> +
>       perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
>       perf stat -a -e pci_iod0_pci0/event=0x24/ ls
> +
>   - cpumask, used by perf user space and other tools to know on which CPUs
>     to open the events
>   
>   This driver supports the following events for MAC:
> +
>   - cycles
>     This event counts MAC cycles at MAC frequency.
>   - read-count
> @@ -77,6 +81,7 @@ Examples for use with perf::
>     perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
>   
>   And, this driver supports the following events for PCI:
> +
>   - pci-port0-cycles
>     This event counts PCI cycles at PCI frequency in port0.
>   - pci-port0-read-count

-- 
~Randy


