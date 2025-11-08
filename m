Return-Path: <linux-kernel+bounces-891588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E35C43017
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E53188B78F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166921CC51;
	Sat,  8 Nov 2025 16:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87E3A8F7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620637; cv=none; b=bIYZOjqQrG4Of5U3wscKukrqB1l2tY6vjkWYgNVVS1V8Ej6EdIpj509X/bhFRrIs2+QS45XaPSOUo7jZWh3YrpTFDfbHVairGg+f5yVdD//0fWA2swzVxPn+AkD/rR8xrJaU4jKy9GiEcpbNiA0e2NJd8lxF9Wes2KK23FbeRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620637; c=relaxed/simple;
	bh=ixSLPz11f32aUa01GlhA0xfDMDF+v9lVYylrYr2Ff50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnLH/s6TC0LYtOw2q7qcxDHZlKP25qg3xSHjX8RoPJ8wlZfRX/6GcCeKOJyIqjAciJA8xfYovl34V0ZkUxx8zdjlJ1298wzWXA1/berUvP6u4p32hDLUdIaxvO+xILJQXWKfwk1/0rS1w0zOZMRmtL1iGd9v3mKaIPbSliiX/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d3h870ppPz9sS7;
	Sat,  8 Nov 2025 17:24:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlV_46oyIpsG; Sat,  8 Nov 2025 17:24:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d3h86700pz9sRy;
	Sat,  8 Nov 2025 17:24:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D075E8B765;
	Sat,  8 Nov 2025 17:24:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3zU9wu4pd2yf; Sat,  8 Nov 2025 17:24:06 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 65B3C8B764;
	Sat,  8 Nov 2025 17:24:06 +0100 (CET)
Message-ID: <ad87d404-3d93-4c7e-908a-d9f47daca4b0@csgroup.eu>
Date: Sat, 8 Nov 2025 17:24:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "florent.trinh-thai@cs-soprasteria.com"
 <florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
 <2025110513-manliness-repayment-d005@gregkh>
 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
 <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
 <eb0cd539-9d76-489a-b5f4-ecef2a6d32dd@csgroup.eu>
 <a88e1546-1530-4326-b0ee-dc4e50d0343f@csgroup.eu>
 <cd174dbaa3171f92e083d5dca89732aa64e32f15.camel@siemens.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <cd174dbaa3171f92e083d5dca89732aa64e32f15.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/11/2025 à 12:41, Sverdlin, Alexander a écrit :
> Hi Christophe,
> 
> On Sat, 2025-11-08 at 12:14 +0100, Christophe Leroy wrote:
>>> Now I'm trying to understand why the problem surfaced with commit
>>> 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
>>>
>>
>> The reason why it was not a problem before was that the transfer was
>> done into of->prealloc_buf (fs/kernfs/file.c) which is a kmalloc() with
>> size (PAGE_SIZE + 1).
>>
>> Following the rework of at25 it now goes into the bounce buffer which is
>> allocated with the exact size of the transfer.
>>
>> Why do we need an intermediate bounce buffer now, why can't
>> of->prealloc_buf be used directly as before ?
> 
> userspace access is only one part of the story, the other is NVMEM
> kernel-internal API, like nvmem_cell_read*() and I suppose there is
> no requirement for a destination buffer to be DMA-able.
> 

As far as I can see nvmem_cell_read*() allocates a kmalloc() bounce 
buffer already:

	buf = kzalloc(max_t(size_t, entry->raw_len, entry->bytes), GFP_KERNEL);
	if (!buf)
		return ERR_PTR(-ENOMEM);

	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id, 
cell->index);
	if (rc) {
		kfree(buf);
		return ERR_PTR(rc);
	}

	return buf;

Christophe

