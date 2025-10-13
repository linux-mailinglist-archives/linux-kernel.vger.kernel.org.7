Return-Path: <linux-kernel+bounces-850203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED8BD23A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CE004EC3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1D2FB995;
	Mon, 13 Oct 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNQbpMfF"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBF23956A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346922; cv=none; b=DGCz+z4h6bm8M6VIrk/sQLbL3y3Xp2Wst9RfrUbvE3NX8j9oDTl/F+WqOIsDn4ZkvqvDlWC9C7w2y91BsgSm2bwm2THabzoW1CA2bNSxnxb4kY9uVHugxXSLmbIlD19BQq0bb7+Y0WbTt1LcQr42jSFbapjDQbWHyGZ5Oyg4uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346922; c=relaxed/simple;
	bh=7U/uYJ1Bn25KT2yXUo5NMdtSLLLWGrEc4B4/9Q9wzXc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VJwqRSjBwBA64QOZmtthITYlJvs3P29BBd9u2JkpD2niTWcwv99sHIzy+QscHcrGC4Q0PP360fCMeOk9WipsmPn0b3SOtPufkFv2V191GAX59CkX2ukAgZ6b5V3Wza0OTAc/fQ1sQPsNo4Ze0dlRH6xnLruivSmuBQJM0GQIoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNQbpMfF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd374ac3-05a2-41ae-8043-cc3575fb13c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760346918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3uRU6A1V0MHfLT+ewa3AKJSUpsO5lmxHPh4GX6k0hg=;
	b=MNQbpMfFLQ2qpDDSdEkaNskbe9MHMp0xnYzedG+FVz6nyRLbQztirK+kx5Ir54ngMxaThf
	WDc8Q/rKrID2o68szkR+UWaJ0QWxIRx9EQGrVza8abnWCj8lKlo3duhrKfY5vZdssNRneh
	dVALp7ix5m0wpB/l+OyGFcibB55Y9ls=
Date: Mon, 13 Oct 2025 17:15:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 1/1] mm/ksm: Add recovery mechanism for memory
 failures
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
To: david@redhat.com
Cc: Longlong Xia <xialonglong2025@163.com>, nao.horiguchi@gmail.com,
 akpm@linux-foundation.org, wangkefeng.wang@huawei.com, xu.xin16@zte.com.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Longlong Xia <xialonglong@kylinos.cn>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, Miaohe Lin <linmiaohe@huawei.com>, qiuxu.zhuo@intel.com
References: <20251009070045.2011920-1-xialonglong2025@163.com>
 <20251009070045.2011920-2-xialonglong2025@163.com>
 <CABzRoyYfx0QPgGG4WYEYmT8-J10ToRCUStd3tWC0CtT_D8ctiQ@mail.gmail.com>
 <CABzRoyYK38imLh6zN2DZKPRyQrJkKyvpswqJAsWzEeECtOxaMA@mail.gmail.com>
 <55370eb6-9798-0f46-2301-d5f66528411b@huawei.com>
 <077882e3-f69f-44f3-aa74-b325721beb42@linux.dev>
 <839b72b8-55dc-4f4e-b1da-6f24ecf9446f@huawei.com>
 <f12dfacb-05dd-4b22-90eb-fcc1a8ed552b@linux.dev>
In-Reply-To: <f12dfacb-05dd-4b22-90eb-fcc1a8ed552b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

@David

Cc: MM CORE folks

On 2025/10/13 12:42, Lance Yang wrote:
[...]

Cool. Hardware error injection with EINJ was the way to go!

I just ran some tests on the shared zero page (both regular and huge), and
found a tricky behavior:

1) When a hardware error is injected into the zeropage, the process that
attempts to read from a mapping backed by it is correctly killed with a 
SIGBUS.

2) However, even after the error is detected, the kernel continues to 
install
the known-poisoned zeropage for new anonymous mappings ...


For the shared zeropage:
```
[Mon Oct 13 16:29:02 2025] mce: Uncorrected hardware memory error in 
user-access at 29b8cf5000
[Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: Sending SIGBUS to 
read_zeropage:13767 due to hardware memory corruption
[Mon Oct 13 16:29:02 2025] Memory failure: 0x29b8cf5: recovery action 
for already poisoned page: Failed
```
And for the shared huge zeropage:
```
[Mon Oct 13 16:35:34 2025] mce: Uncorrected hardware memory error in 
user-access at 1e1e00000
[Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: Sending SIGBUS to 
read_huge_zerop:13891 due to hardware memory corruption
[Mon Oct 13 16:35:34 2025] Memory failure: 0x1e1e00: recovery action for 
already poisoned page: Failed
```

Since we've identified an uncorrectable hardware error on such a critical,
singleton page, should we be doing something more?

Thanks,
Lance

