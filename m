Return-Path: <linux-kernel+bounces-833550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F841BA24C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E5D322C62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA02641E3;
	Fri, 26 Sep 2025 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VeMEgYuX"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BE34BA49;
	Fri, 26 Sep 2025 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857259; cv=none; b=WQtjidWzok7ZlgrnUQheGUU/o6mI0v7r5Q5phbZSkdpbOlq3fBBtkXUxuHFyM7uaxrfrSdfMcQk8zKN9As+i1JuYRFvYOwTnwSETAPyFlpdW5VQfxJhG1FJctJuIoLK8LocqW0FLvZaCTEfSV77BUsTyjRLaG6vDJkh77TrdhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857259; c=relaxed/simple;
	bh=ma77mz/r+Nhb8tLS+kUWYlmQgqAWvSEHhfio6sjmmZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4EQRkjPq3H/QB7YUpwEhHau6myzGfvM1JTn2sJC2yU5mBvt0AlOiKfXwly20eT3M6PR641Wn4tMUfvKlgMRQT5anpSJrqS21R+Hv403s67+OXuRP6TRvGjAH1mZwWxt70IDtPkaCqlwKsfCvNDDyYSfe1FxNM4cOuniJ9/7eJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VeMEgYuX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5quBJHfxUzGIdr2V+p30UJ+dXw+mxnhqSbhhnIdRp80=; b=VeMEgYuX2UWVLRbc0d+44sOZcB
	MCZ1siW3DpQP8oJTojGiXjU3/YLw4pC8oIevYJD0/eEGWzOAavyCryRaL2j5EwbCOV99DSTvz4WAW
	ZgojER0ne30yNFXCkxr5Z1uXZTiy1ldz2tjcAS+CnCpWS8Mpvkikv1S9Q3hlr6mqYCzqOEVVYXuQ7
	pQIfMDKibHPsiv2jCBOf+CPE9by+CxR8O7O3nXXvQSIwoyfROlnOjQW+XMzgHtGC+D7zn48UaT3+l
	umPOj6nf1x1WcuXlHVTPbH3grZ4HMQz2EjWGQNDfZWjPR0oYq56/aADqm2EBioQy/wVa9pPVZ7lhS
	JShL8QOQ==;
Received: from [50.53.25.54] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1z7M-0000000FMcA-3R5R;
	Fri, 26 Sep 2025 03:27:32 +0000
Message-ID: <61aace07-890a-4b55-8e84-935ebc4a3be1@infradead.org>
Date: Thu, 25 Sep 2025 20:27:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: perf: Fujitsu: Fix htmldocs build warnings and
 errors
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, corbet@lwn.net,
 will@kernel.org, yangyicong@hisilicon.com, fj2767dz@fujitsu.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linux.dev
References: <20250926003938.5017-1-krishnagopi487@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250926003938.5017-1-krishnagopi487@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/25/25 5:39 PM, Gopi Krishna Menon wrote:
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
> Add blank line before bullet lists and block quotes to fix build
> errors and resolve warnings.
> 

Yes, this is better. No warnings, but some of the output
html file still isn't formatted as expected or desired.
See comments below.

> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Changelog:
> 
> Changes since v1:
>    - Remove formatting changes unrelated to the fix.
>    
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
>   Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> index 46595b788d3a..4edf26f8cfe6 100644
> --- a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> +++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
> @@ -15,15 +15,19 @@ The driver provides a description of its available events and configuration
>   options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/
>   and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
>   This driver exports:
> +
>   - formats, used by perf user space and other tools to configure events
>   - events, used by perf user space and other tools to create events
>     symbolically, e.g.:
> +
>       perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
>       perf stat -a -e pci_iod0_pci0/event=0x24/ ls

This produces:

events, used by perf user space and other tools to create events 
symbolically, e.g.:

perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls perf stat -a -e 
pci_iod0_pci0/event=0x24/ ls

(That last line is all on one line in my browser.)

Please try using "e.g.::" before those 2 perf lines.
And then check the output in a browser.

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

Thanks.
-- 
~Randy


