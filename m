Return-Path: <linux-kernel+bounces-833994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F528BA38D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D482916D094
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79F2E2F03;
	Fri, 26 Sep 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP6BvlJA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029242D0601
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887502; cv=none; b=qrko7JY9Cxmq+tc6xKsTzERFKpCslAwZX9KLRjO9bHMWr/0meFh2Gb54vhUDBLQ+NQvx9ohClSun6kvGCN3livbwZuQ32lBGYlONT7jlE17YSIJoYLD9eZcVj2prwPfvv1xMFrls7lcG/OsmVaELYThMezjgwwOWw8XZJqVmIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887502; c=relaxed/simple;
	bh=ao1doj00WMHqalxYfWSLJv5Vq9PqzzapmuQ1G9usjJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H77xyECooVTBB8hwB1urG3f7GJa4Ij85hWAtqqSgFhSTLXHF+fC14H6XQ0j//1ciTzufzfTFSNtLM5+0J60uyzHJzMxYrcC1qx0T64n+Ss7l34hDTpk9mKvd1HCZiBxXW5WPb62Nr6paAFqUXnciKtHb5S5Z5rgVGNKH9QXn/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dP6BvlJA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758887498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VLEhIrJlHfb6A8TjzRrKlq1NWG1Fjm+KGzJKyI2nT04=;
	b=dP6BvlJAD2Ko27JT8WHmaT5muAKdLhVL9i2pIPtsaHZ9Qx1L13TWce+/tIRqFIkwCirbpf
	1mzBDnP7xtu30YymBmtIBrjWPAe/QzP+nMT7PUz4pzh6QdAqJSbrpr2ty0jQRBgrLIASCk
	7gcKlOzNjYO0ckQod4nnCg75kLOO3Qk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-t7wAnVQ4NBuKf4dAJMIECg-1; Fri, 26 Sep 2025 07:51:37 -0400
X-MC-Unique: t7wAnVQ4NBuKf4dAJMIECg-1
X-Mimecast-MFC-AGG-ID: t7wAnVQ4NBuKf4dAJMIECg_1758887496
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e38957979so6911925e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887496; x=1759492296;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLEhIrJlHfb6A8TjzRrKlq1NWG1Fjm+KGzJKyI2nT04=;
        b=cQ6ooRwUPAc8Jm+L8wJIx+HBISun1OHzPqmp3GXjS5tLvN2xRU3H9qtLr9zvxi16I5
         IJO2RYYO8LWHWlncolFybOEuaXRT72ERM3rtFSVB0SWVXQ2ojR1rbe/WSeG/vXgK0vB9
         XSj0dy2IMonYOWS3tEuS+hDYqTOOLv6NqpaUyAnk6UUxilSRBFOg70dQ15yDnsTxPtJy
         SfloM4wVYqTTgsJ+2D7IXTr6za06lemXSYWZQ3P6/hAi3vwNhTpCtDV8erBhmXqxXMv8
         vO5omIOFXFeb5+sNzLfmxdfH9ySE8WVZ7pijUMNYtl5cp4Fn+MpVnUY1eMLwRR6SI7UP
         Jq9g==
X-Forwarded-Encrypted: i=1; AJvYcCVuq7dlyNNZfcQfIpEp/gt1hL0OFaR5g9U4HVWTT1nErTCo27twsmYPYXizP6Ja8Du4BtAJ1mI6WQTXwwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTLxpTNZP0IbU0yT5CAzgxBSwU0fbw+F6WeNIQHHvUo2L1n3u
	bD5ARilANSKCPLGhr818FSZo77p5GiX0g3Pwyh26+rj/8KcvdpCvmUSTG4qJ5VWL9GSbptClkZA
	K0GpTpGOkyuj6O1kf+IK6lQCvN6zOZFMGXhzZhvBNzPV68nJoMVYl6aE/xgZxxqoyb/luDhszUq
	6l
X-Gm-Gg: ASbGncugjXDmrDoCpppO0ZCHs0dlYFBb9WG+BmEEfNe0MnNSwDKjWsXDiWNqLM1rAKU
	Lh1NdlKptzAosV7LRf/jmGJ5ZHsvjPXMA09mGViICocHpNFSomrsTP6mUBsfW0Pfnbedy7xKmBI
	DZGVdwZzKTRy3b9vKXyxmqiTO6A5zSbkooJw8ljjr9c8d0HjT2ABNsfV3lgTZDb7oR+QKHPjVCd
	cpY4p79KeUAFhrixNUWy3EIf5tZ3QmWhV1WS/nTmQy9xYkkeeni+CylyN/LepaP0IwxMYCLqPs/
	re0/HZv7kXcwBK1O+xVrFbuxFxR69gK6QH0ZtQOdWakAPmSFE3JQbMjfhF8iA/LW2bl/36Ak/bG
	0+BP+jg==
X-Received: by 2002:a05:600c:8287:b0:46e:3dc3:b645 with SMTP id 5b1f17b1804b1-46e3dc3b88amr17813145e9.3.1758887496092;
        Fri, 26 Sep 2025 04:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhEuRpxIn4z6fRY26sp9Iq3dQid2wrlFsVQ9tJ4On9InvvWfOwTygPAa/NdBQbfhwDVMhyRg==
X-Received: by 2002:a05:600c:8287:b0:46e:3dc3:b645 with SMTP id 5b1f17b1804b1-46e3dc3b88amr17812865e9.3.1758887495593;
        Fri, 26 Sep 2025 04:51:35 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net. [47.64.114.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm112709175e9.11.2025.09.26.04.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:51:35 -0700 (PDT)
Message-ID: <16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com>
Date: Fri, 26 Sep 2025 13:51:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Add kprobes KUnit test
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250513151631.3520793-1-namcao@linutronix.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250513151631.3520793-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 17.16, Nam Cao wrote:
> Add KUnit test for riscv kprobes, mostly for simulated instructions. The
> test install kprobes into multiple sample functions, and check that these
> functions still return the expected magic value.
> 
> This test can detect some kprobe bugs reported in the past (in Link:).
> 
> Link: https://lore.kernel.org/linux-riscv/20241119111056.2554419-1-namcao@linutronix.de/
> Link: https://lore.kernel.org/stable/c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn/
> Link: https://lore.kernel.org/linux-riscv/20230829182500.61875-1-namcaov@gmail.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
...
> diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> new file mode 100644
> index 000000000000..3886ab491ecb
> --- /dev/null
> +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef TEST_KPROBES_H
> +#define TEST_KPROBES_H
> +
> +/*
> + * The magic value that all the functions in the test_kprobes_functions array return. The test
> + * installs kprobes into these functions, and verify that the functions still correctly return this
> + * value.
> + */
> +#define KPROBE_TEST_MAGIC          0xcafebabe
> +#define KPROBE_TEST_MAGIC_LOWER    0x0000babe
> +#define KPROBE_TEST_MAGIC_UPPER    0xcafe0000
> +
> +#ifndef __ASSEMBLY__

Could you maybe change that into "__ASSEMBLER__" instead of "__ASSEMBLY__" ? 
I'm currently trying to get rid of the latter in the kernel sources, see: 
https://lore.kernel.org/all/20250606070952.498274-1-thuth@redhat.com/

> +/* array of addresses to install kprobes */
> +extern void *test_kprobes_addresses[];
> +
> +/* array of functions that return KPROBE_TEST_MAGIC */
> +extern long (*test_kprobes_functions[])(void);
> +
> +#endif /* __ASSEMBLY__ */

dito.

  Thanks,
   Thomas


