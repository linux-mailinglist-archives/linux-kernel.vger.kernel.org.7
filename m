Return-Path: <linux-kernel+bounces-756225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58CB1B16D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB974189C5BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3B26C3A0;
	Tue,  5 Aug 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rd6eV/wD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8A26B760
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387408; cv=none; b=b4S7v4n6TqcgL/LqDUaQAa4ZLROf0M6K4iTG9DsJEq+uMrur8OtQJ08vIpgMZ3bpt1IiCxHhzG022h2PACzRiDlkfhmJrqzUx2sqFWk9VyK6Fvu/5bOWFljCOkP17OykXB4Qe/Epf65gIrbt/IzjhJ7XFOOvSDESD8l3Q7RttCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387408; c=relaxed/simple;
	bh=nCfaEyH7MqXv+EacNelojLk+r3n+1Ey4CWEaurdGut4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqrIDpMSlyJOeilMvJqnNpjPOgsNlnteG8LCjJ+GsoVxK/4CqMjjNwrQJ4SidrsY5vjhvpLmfw3vbqCPcFGemxkN1K75oOoCscAxvurpkNBEJuLULLK2KXLdtjAK7E5iCUaLWX/spL0vqukWjFyRH/hmJ38I5nvVB8mUnsuqioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rd6eV/wD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754387405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R3Nw7N9ZXr94BBw5pnV0yLMbnOotSy69DH7y+0p/p9Y=;
	b=Rd6eV/wDyiSnN19k3ygT6QmMoqkIgYBhTtaY9XY3o+//2eSIkzBpEFe2G9xVNjsFDeQbI+
	zuNCf6wPK71AyjESHSyHVz7FYdNCglb7w+a3+STBfNbWpqUN+1Rh7Ad+H29d0uRiKyaWJf
	cXJBCBwPbMNm33zB+eLYY4lF7rUMtG4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-1gAQMVZPNfKpw1dsmjhzqw-1; Tue, 05 Aug 2025 05:50:04 -0400
X-MC-Unique: 1gAQMVZPNfKpw1dsmjhzqw-1
X-Mimecast-MFC-AGG-ID: 1gAQMVZPNfKpw1dsmjhzqw_1754387404
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073f12d826so115619066d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387404; x=1754992204;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3Nw7N9ZXr94BBw5pnV0yLMbnOotSy69DH7y+0p/p9Y=;
        b=usWr1FG/V8H5izFz4/Wad64kXqytifuWTT+QXQ41M4YpqXBiwJHnZoPJBBxxfMhayS
         x2CeHbGXl333qFjDYW6G36ZMe+q8VyT2LsmbkD4ytf3fq/7lA6x64lNvWzjUZPJ/Y7wN
         7YiAOUMAOlJ0OoPckHRUNYnpanhFlVue//l9x0S7lfu6CfZgawroiYm4xI7yzCAts3XI
         6mrDKxIQBLb1plGgQcU72HF0l4jB3IvZutWQqNvoZwTjMg5AiYGROdLXy/FQjGRj9tx/
         ZS3uq5+OVAZKFWodZw9YhGc21eynnTH2PcQo+FmW29+bOpYR6v2p6La4xGyHhIoEfdix
         3jEg==
X-Forwarded-Encrypted: i=1; AJvYcCUCw3m90SbjC5wZX4xWxxTIJ5OxrCH2zExCUYaynbJA+KqNyhhBFEi8cuKSUc6j6FqzXlJnfuLRoy0QfGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgr5u7QrPOZLGQ0ZdyIc+hHgEsBewWlGcSQahiDz3ZvI6PLUq
	YmoZ0cKoK4mt4siMg58H0PF3/8/Xm1R5kt46pFpCnfCLTsUDrxVGbUSJ9TG+NOyHX9a668Kmohk
	JeZSTMFPdDSyGqkArd8aVq864+WUTEQwmkQoiETATvy9PQghk6yGa/x+VweVRqdCiwZkIjtZwpg
	==
X-Gm-Gg: ASbGnctFw5g2haZd7Wqpnl3RpW/OzuIq6ZqvT+NyAG63OujrcZixqoaEk+jbEgi57tj
	OWdbjGn2UpRXED+IO2VUmw45+Npq643AgJR4qtaAjHMyjTryaNPZX6YtuPj+6HtA7+XDoxR5ROh
	3MXjrvBUrA7BgQwhCbxpUW4OkP+yzsh+D3R/FKuG8A8pAAf04zzTjeGsdII2NiOU8S/5TEAy8ZI
	Uc5cmbP3W7F3KdZiY/j+6UnfunGxOPLd1gZnj1LD0zsjZD6lsXvbNONS6QLJ2k2G2iA79HhPCc2
	pLdZy9EXO8Rc8bSDsMdO/OtkMw6Z+tagdxjJtGeHTJrUPI2YPd5qXf4GN8fw3dx8
X-Received: by 2002:ad4:5d47:0:b0:707:5c4f:f0c9 with SMTP id 6a1803df08f44-709365356c5mr196605756d6.16.1754387403941;
        Tue, 05 Aug 2025 02:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyx5UikJMmenj3I+DsKP/39+YkgKQdeXVza/ikYs70+jG1oaF8F4CiNJdzGsonQmcA7J7Qkg==
X-Received: by 2002:ad4:5d47:0:b0:707:5c4f:f0c9 with SMTP id 6a1803df08f44-709365356c5mr196605396d6.16.1754387403253;
        Tue, 05 Aug 2025 02:50:03 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea1782sm67866596d6.93.2025.08.05.02.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:50:02 -0700 (PDT)
Message-ID: <bfb22382-c513-4135-9e24-dbf7595dbd72@redhat.com>
Date: Tue, 5 Aug 2025 11:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-35-thuth@redhat.com>
 <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2025 15.33, John Paul Adrian Glaubitz wrote:
> Hi Thomas,
> 
> On Fri, 2025-03-14 at 08:10 +0100, Thomas Huth wrote:
>> While the GCC and Clang compilers already define __ASSEMBLER__
>> automatically when compiling assembly code, __ASSEMBLY__ is a
>> macro that only gets defined by the Makefiles in the kernel.
>> This can be very confusing when switching between userspace
>> and kernelspace coding, or when dealing with uapi headers that
>> rather should use __ASSEMBLER__ instead. So let's standardize on
>> the __ASSEMBLER__ macro that is provided by the compilers now.
...
> This causes the kernel build to fail:
> 
>    CC [M]  drivers/gpu/drm/nouveau/nv04_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv10_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv17_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv50_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv84_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nvc0_fence.o
>    LD [M]  drivers/gpu/drm/nouveau/nouveau.o
>    AR      drivers/gpu/built-in.a
>    AR      drivers/built-in.a
> make: *** [Makefile:2026: .] Error 2
> glaubitz@node54:/data/home/glaubitz/linux> make
>    CALL    scripts/checksyscalls.sh
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>    AS      arch/sparc/kernel/head_64.o
> ./arch/sparc/include/uapi/asm/ptrace.h: Assembler messages:
> ./arch/sparc/include/uapi/asm/ptrace.h:22: Error: Unknown opcode: `struct'

  Hi Adrian,

could you please give it another try, after applying this patch first:

  https://lore.kernel.org/lkml/20250805092540.48334-1-thuth@redhat.com/

  Thanks,
   Thomas


