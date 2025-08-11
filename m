Return-Path: <linux-kernel+bounces-762295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F015CB20488
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8876018A0B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E9204C0F;
	Mon, 11 Aug 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e70RdzFX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185E3594B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906027; cv=none; b=XReYit5h/gvBJEVAPAsnUiwPeNxag8WXl/Mo654vxvECD+p8niot5x2MI/FCUvmFFK5KnoPDnQ9Npvb+ZsZyzR8xM4ocFdgO87uBDu0FzdN/qGrbGdGsfAHNoOpZT01iBmRkqyscPQ5/JAB/poKumUpQBOy8vCeYbrc2Bqjg1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906027; c=relaxed/simple;
	bh=X+/wETXg6+t+xV51UEQmour6oMA0R+27wdMYsGkvz+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivV357/Vz0WqW0viTbORhUJYGDub8I0R6k7Zt0zZtEjsGl9SWSmpsKYHMjbDsbfyFSSEwH/8BIFu8J0LNSfxAazczFsU2CPhadnqZhkkScD+7saAI3aHe6GqGdZ/aiwSDrDP9OVb27dJiKhIIuBu8SiuCv2WCTd7PVQtvfUlqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e70RdzFX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754906025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHJd90lJt7pKkV7L6fdhKaIxyXCO7FJPwtx28akpSm0=;
	b=e70RdzFXKzTZOfkPn172HQdxInLj+LSbF6NuLrYF7vq4yK7HyDOfQSfn5t2tVYUxCLoqyw
	Foyl2YoVn6smT5ZpriZ4HyWLTOy8/kCGP+wfdFf63Ojvsuu9v1zZrPnaoooIJq/CB6aiRJ
	O/CGlB/r/slIgrlFiYUbIT/j1MzZYw0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-N4WinZANMGapd3D2_y-jhg-1; Mon, 11 Aug 2025 05:53:43 -0400
X-MC-Unique: N4WinZANMGapd3D2_y-jhg-1
X-Mimecast-MFC-AGG-ID: N4WinZANMGapd3D2_y-jhg_1754906023
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70743a15d33so95113276d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906023; x=1755510823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHJd90lJt7pKkV7L6fdhKaIxyXCO7FJPwtx28akpSm0=;
        b=UePP1qr7q9qjVZJUFN/wyP4ngJlDi2msioE5w+24/k3O9jLoEWJM0hlWGNsznUIOX+
         s0/NPqWfxEap9crI7VQIbreFHsM0ZHRE0Fp/5MsQNXa9/p/fd6p4OKryVB5qnNqMamoB
         K6htBMEdlFg95n5MbcoDilJn4eQnWKb5rnKrHIAD8F9mcW0sgegGLQJdjczZiBF/NDuc
         fydUjytPbg6ReYmKp7PJT0UP1/UvbdbPXJ67ircb9k9h0QRYriG9P+jNJjgzLuxHl3aj
         VhSocfEf33kirT4jj6LoA8SwLaP7/bQjZtmN8sbl8T9Xr1euEEJkKNGd3lZIkY/8yHqI
         11bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJfWWZXbGeGBZnW/IW/SBjB0A1TqK/Bdets4DJd5ooDf1hvHUGA/KeMy36QADXoyndfloQAn6epqoe7fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCW3Jb/o7jWMm1ZNH0ZMFO6p4i4w/ND2XgY1f/100KpBi9zzqT
	jDVqgi6FtQVksiBAvdFidIDr3M7rjtVuth2yvCycnehN5wvOkwMecwFpqpg+AHGugzmK2JNywu4
	rOygJjnfhakHnergzkgMa0zxJrqUb3UCXR/d1PFR6fwO6HI9WXi6KaPWNCbmKPyGuCw==
X-Gm-Gg: ASbGncuMkNoglRo01MRSIsI4JfhmjnIkp777h9O1hst5kiF4W4nPZsNPfaNbB6qx9r5
	TdI/7/h6Xz2Yi2WETtK8ZM2MUPQQ1zrigqyKbz6g5OyrCs02rDZhPDN9SLLji1ghauWLILkjKL1
	UEdpMXvxYuL9M8Cwlt/8YkfD06ZlHGBxpHW3jvfsmAmFKuUAYRqEJYWqo/4+NuCb5prjGKFsvPl
	S1ooPDumQIlXFxl8uEd9Zaxd601n/tgoe4/fpUHCrTyalQ2eGDdvvCFW0WISaw6JgBXOikFeU59
	Le3OJHU4h/x0yMLfR3a1UYV6pcCtJHdDoYhMvrOj0mE=
X-Received: by 2002:a0c:da06:0:b0:709:9b8e:da0c with SMTP id 6a1803df08f44-7099b8edbe5mr112073396d6.44.1754906023060;
        Mon, 11 Aug 2025 02:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhDAMiPhkWP4y81WnT8aCqUZTFa3MossLf3cLQLsxAl0+cuexXhtMxG6I+EVpY/G1M9uEsNA==
X-Received: by 2002:a0c:da06:0:b0:709:9b8e:da0c with SMTP id 6a1803df08f44-7099b8edbe5mr112073306d6.44.1754906022634;
        Mon, 11 Aug 2025 02:53:42 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9dff72sm151703916d6.15.2025.08.11.02.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:53:42 -0700 (PDT)
Message-ID: <beada520-564a-481e-9f9d-91cd106aaee3@redhat.com>
Date: Mon, 11 Aug 2025 11:53:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250711183129.2cf66d32@canb.auug.org.au>
 <20250801144222.719c6568@canb.auug.org.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250801144222.719c6568@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/1/25 6:42 AM, Stephen Rothwell wrote:
> On Fri, 11 Jul 2025 18:31:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the net-next tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> include/linux/virtio.h:172: warning: Excess struct member 'features' description in 'virtio_device'
>> include/linux/virtio.h:172: warning: Excess struct member 'features_array' description in 'virtio_device'
>>
>> Introduced by commit
>>
>>   e7d4c1c5a546 ("virtio: introduce extended features")
> 
> I am still seeing those warnings.  That commit is now in Linus' tree.

I'm sorry for the latency, I was off-the-grid in the past weeks.

I observed that warnings in an earlier revision of the relevant patch,
but I thought the previous commit:

eade9f57ca72 ("scripts/kernel_doc.py: properly handle
VIRTIO_DECLARE_FEATURES")

addressed it. At least I can't see the warnings locally while running:

make V=1 C=1 htmldocs

Perhaps it's sphinx version dependent? I'm using sphinx-build 7.3.7
Could you please share the exact command line and tools version used?

Thanks,

Paolo


