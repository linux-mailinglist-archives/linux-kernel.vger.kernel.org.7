Return-Path: <linux-kernel+bounces-764114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C3B21E31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31E03B81A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329E2D47F6;
	Tue, 12 Aug 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X90fpE5j"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477A2D3A85
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979756; cv=none; b=Bk574bFH/fk+Xl2PznF0/2nNPOWMwZSG2Y7BeMNFNTn0jYtfUCgD2od8It9fkLFDnJCXjAlZ5J1tG/y3Il1+WHYEb+aGJKmOE5HgLbke4/CfsxZMMlWQkNFIeT2x6g+Tx/SUfqZV4i5A8FJwIi2HXK/XqpdXLTiZmGtsgm2iWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979756; c=relaxed/simple;
	bh=0i+LZ+owKxYyPXTubGR7tYyzj5XgSpwx6JKJPrM4eho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hm933dj0dRI2c6fgwqXBVD6X+8gDOAnBcTkO4fXuPgEcvbPBXyID7+5GGFBQpefgyGwt+P+zuDUYlrSxUzlS7X4wxSJzKJHAYm6CTshd/nVUT1lB6SgbZqKR+p2Qbr6rh7oRqt1nyQ8y95e34hhKhLTvgYARFY1HAeWJ9NtGYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X90fpE5j; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a04147a8-a087-4965-84e8-1c8aed5b62f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754979742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdSSw5y33BjQl+3DCjsck3nUXe8hfMl/gV1/fxuV90E=;
	b=X90fpE5jdVzGSdGKSCrC+Xs7F1eCChQ5F5KnEXLLuQMWZQDLJ+ofFFNaTEeqeqjKIKSh1b
	K7+7TbCqALWveeqrCCikaN5ldJG+U1KpNcPm1P1Okt2b/cFxkmZWNSbE6cleoI2uOr9FO4
	1vLOHWxh7ZxIoh+YLnjkillPxMLovw0=
Date: Tue, 12 Aug 2025 14:21:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Add kexec_file support for LoongArch
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <CAK3+h2zXBcAgtWJLXhAzzTZQ6_7Epqc6HuOassm_o5JAftK+Gw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <CAK3+h2zXBcAgtWJLXhAzzTZQ6_7Epqc6HuOassm_o5JAftK+Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Vincent
On 2025/8/12 00:20, Vincent Li wrote:
> Hi Youling,
>
> On Mon, Aug 11, 2025 at 2:28 AM Youling Tang <youling.tang@linux.dev> wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> This patchset implement kexec_file_load() support on LoongArch.
>>
>> This patch series enables us to load the LoongArch vmlinuz.efi or
>> vmlinux.efi by specifying its file decriptor, instead of user-filled
>> buffer via kexec_load() syscall.
>>
>> To use kexec_file_load() system call, instead of kexec_load(), at kexec
>> command, '-s' options must be specified. kexec-tools needs to apply the
>> corresponding patches. These patches can be found in repository [1] and
>> will be submitted to the kexec-tools community later.
>>
>> The basic usage of kexec_file is:
>> 1) Load second kernel image:
>>   # kexec -s -l vmlinuz.efi --initrd=initrd.img --reuse-cmdline
>>
>> 2) Startup second kernel:
>>   # kexec -e
>>
>> For kdump:
>> 1) Load capture kernel image:
>>   # kexec -s -p vmlinuz.efi --initrd=initrd.img --reuse-cmdline
>>
>> 2) Do something to crash, like:
>>   # echo c > /proc/sysrq-trigger
>>
> I am new to this feature but I am interested to test this feature, How
> do I get the second kernel or capture image vmlinux.efi and
> initrd.img, do I need to build them separately and how?
There is no need to build separately. The kernel images and
initrd of the first kernel and the second kernel can be the same
(because LoongArch is a PIE kernel when RELOCATABLE is enabled).

Thanks,
Youling.
>
>> Link:
>> [1] https://github.com/tangyouling/kexec-tools/commits/main/
>>
>> Youling Tang (6):
>>    LoongArch: Add struct loongarch_image_header for kernel image
>>    LoongArch: Add kexec_file support
>>    LoongArch/kexec_file: Add initrd loading
>>    LoongArch/kexec_file: Add crash dump support
>>    LoongArch/kexec_file: Add "mem" parameter to limit memory usage of
>>      kdump kernel
>>    LoongArch: Enable CONFIG_KEXEC_FILE
>>
>>   arch/loongarch/Kconfig                     |   8 +
>>   arch/loongarch/configs/loongson3_defconfig |   1 +
>>   arch/loongarch/include/asm/image.h         |  58 +++++
>>   arch/loongarch/include/asm/kexec.h         |  12 ++
>>   arch/loongarch/kernel/Makefile             |   1 +
>>   arch/loongarch/kernel/kexec_image.c        | 112 ++++++++++
>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++-
>>   arch/loongarch/kernel/machine_kexec_file.c | 234 +++++++++++++++++++++
>>   8 files changed, 448 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/image.h
>>   create mode 100644 arch/loongarch/kernel/kexec_image.c
>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>>
>> --
>> 2.34.1
>>
>>

