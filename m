Return-Path: <linux-kernel+bounces-720573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2795AFBD99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C42F1AA8134
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CDF28853D;
	Mon,  7 Jul 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/jmxJYw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5E1946A0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924217; cv=none; b=nWi9M0/l1rIMuoHh33tGvWUxfp0oVnDj6WExoAWdVmIINEqt5dHKV09pS2weUzPCrM2SLXg+0467UVWZIkaAqoackqrFPW4D0Quoh25hooMIjlKelc4tIpvsG3ojyUn9iCZVHP/cZExGP8YmMrbiVpR/nnClOin88/p/+ZbfTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924217; c=relaxed/simple;
	bh=qraLfGOkWN7QLQxcHgl8x+wEAGndG0VVZVx2qnLdX1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UQ4SGFrNOmqjV083gKRdfJPi+x5/tqLIRyqKXM3vSUm3K2IMbcwrLsloOyHT4b61bEs18B+Z/6lMZv9DcTtE+6EKuaz76htZYwP1yTRWtqeMgW++IWcJqUqra/S2VUatY1YZtsktFAlQhfMY3Uq9DncdTAFx88m0bmU7ymzxdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X/jmxJYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751924212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFmfSbRPK9NnltZIO87T7HNPKAPVfH87hDFIBdCROR8=;
	b=X/jmxJYwTMtEFeSTJBskl6niY1KFSyuqPZD1yJbaiUnjeWc8jJGCpZn9QzCzWrJh1fP2gU
	TwS38a9SMKQon6HLx2fR58D8m5W1/Ck5tadNnFMLg2OKzJFqOv4I0mULIRrry5u/aUB5Ej
	7k5Z8DXDf68VL4Of+1sTMOgreetjTyE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-l8D-B3ZINzmq2Y5iV0qGkQ-1; Mon, 07 Jul 2025 17:36:50 -0400
X-MC-Unique: l8D-B3ZINzmq2Y5iV0qGkQ-1
X-Mimecast-MFC-AGG-ID: l8D-B3ZINzmq2Y5iV0qGkQ_1751924210
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d40185a630so623717185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 14:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924210; x=1752529010;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFmfSbRPK9NnltZIO87T7HNPKAPVfH87hDFIBdCROR8=;
        b=hBCYPnzzsLHjIkq0iUUl/AEFnyv1PwIvOzbRcT7wRSP0oychDaoAuVdlyWjVCNbIl3
         31GnNkred+xVF+/VdiB8K5aKwyJw+/bG186qW/yiDCZzQYQGzgkagjJr+0+TjcQ2V5lI
         c2lrQ1In2xknQqb6VCsJ0O08119B8dgNwE47R3y8ayibHZxYBbGt1/z1e+QGt79YQaQz
         d+o5T/hWp3J99LqOUOp+KnEFUQa4kDIWWjrnifQzgmPUxeXoGyTsr7pty+CRC+wGRrbv
         rMeOjHJhaSGi3J138p+tmeSmlSr7r2znQwHfJildI3JJWsMoQs2MoMnFZlsdxxaLB/fy
         11sA==
X-Forwarded-Encrypted: i=1; AJvYcCUi6LC+6IBJ0OZyDiv+kVH9QMBPrRnBtT5Bt73QJO2AMC8eGvDRU08dOfG3IsCE5L+H8c8jkkZ3nyFOHLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV7+hyvGE0tqXMdsCgusZX5cN4DPNXMR/8o3Hau7MkaMnpzzf6
	nD8FUrgZYM2r+TmJN/RA3EW5K7tArhqbgxnTev3/uwtPuBMMqNwKYnSaH0PlWXDCdafSUY9TAWs
	cp2liHlZL/3CexzcWnfW8cpnkdGM3/WmpvRg7hZYg051sAgSErUROsMl6Xma/YJNPCQ==
X-Gm-Gg: ASbGncuTPiV6BNiXjSSj+oI4iOMAHC3qQcv07Q2tUEbLEyVsEpL07YPcwyNBGE20xsE
	dpN/F9QxgXXtbRKW1iMnJHLO3xZvyUyRiH/4K8pPPKkCno9vJjyf8lMCbzl7Hj7CW0zHrcp2muI
	Tyimffa4I1yQm02oFSkqL/oraLgGf1RRYyaH4fl52wFReX57Gkho7p4U4e7i8uNWBzCRJPLq6w/
	g9CVf9S80cKpfpxW7ZWzXstkUtzO0mp3fIKyx2OgtV3T/3z5ziG6CvXwlSoAnDKJlSdU1MXtszm
	PAcZfYDLJhC2RD3QneXEDs8N
X-Received: by 2002:a05:620a:24d0:b0:7d4:675d:1d52 with SMTP id af79cd13be357-7d5df0f54b8mr1834267285a.17.1751924209911;
        Mon, 07 Jul 2025 14:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxGgfuw0SDe0K+wEH9J/GTIAFerpN+WwGi4PpPRqIgfqPxFB63z3MUMBzdnj16vPyG0nPprw==
X-Received: by 2002:a05:620a:24d0:b0:7d4:675d:1d52 with SMTP id af79cd13be357-7d5df0f54b8mr1834264185a.17.1751924209444;
        Mon, 07 Jul 2025 14:36:49 -0700 (PDT)
Received: from [192.168.2.110] ([69.156.206.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f861sm672455785a.86.2025.07.07.14.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 14:36:49 -0700 (PDT)
Message-ID: <e1644469-77ca-4770-bc79-5243a46b8a9e@redhat.com>
Date: Mon, 7 Jul 2025 17:36:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Drop preprocessor directives from zboot.lds
From: Luiz Capitulino <luizcap@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250606154112.311565-1-vkuznets@redhat.com>
 <256ad7fc-c6d4-470d-a434-7b5556c3b8f6@redhat.com>
Content-Language: en-US, en-CA
In-Reply-To: <256ad7fc-c6d4-470d-a434-7b5556c3b8f6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-06-06 11:55, Luiz Capitulino wrote:
> On 2025-06-06 11:41, Vitaly Kuznetsov wrote:
>> Older versions of `ld` don't seem to support preprocessor directives in
>> linker scripts, e.g. on RHEL9's ld-2.35.2-63.el9 the build fails with:
>>
>>   ld:./drivers/firmware/efi/libstub/zboot.lds:32: ignoring invalid character `#' in expression
>>   ld:./drivers/firmware/efi/libstub/zboot.lds:33: syntax error
>>
>> We don't seem to need these '#ifdef', no empty .sbat section is created
>> when CONFIG_EFI_SBAT_FILE="":
>>
>>   # objdump -h arch/arm64/boot/vmlinuz.efi
>>
>>   arch/arm64/boot/vmlinuz.efi:     file format pei-aarch64-little
>>
>>   Sections:
>>   Idx Name          Size      VMA               LMA               File off  Algn
>>     0 .text         00b94000  0000000000001000  0000000000001000  00001000  2**2
>>                     CONTENTS, ALLOC, LOAD, READONLY, CODE
>>     1 .data         00000200  0000000000b95000  0000000000b95000  00b95000  2**2
>>                     CONTENTS, ALLOC, LOAD, DATA
>>
>> Fixes: 0f9a1739dd0e ("efi: zboot specific mechanism for embedding SBAT section")
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Thanks for fixing Vitaly:
> 
> Tested-by: Luiz Capitulino <luizcap@redhat.com>
> 
> (this is for the build test, not SBAT testing).

Vitaly, Ard,

Are we planning to include this fix for 6.16? I'm afraid we'll introduce a
regression if we don't include it.

> 
>> ---
>> Note: not-yet-merged x86 version of 0f9a1739dd0e does not seem to be affected
>> as vmlinux.lds script is a pre-processed version of vmlinux.lds.S.
>> ---
>>   drivers/firmware/efi/libstub/zboot.lds | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
>> index c3a166675450..4b8d5cd3dfa2 100644
>> --- a/drivers/firmware/efi/libstub/zboot.lds
>> +++ b/drivers/firmware/efi/libstub/zboot.lds
>> @@ -29,14 +29,12 @@ SECTIONS
>>           . = _etext;
>>       }
>> -#ifdef CONFIG_EFI_SBAT
>>           .sbat : ALIGN(4096) {
>>           _sbat = .;
>>           *(.sbat)
>>           _esbat = ALIGN(4096);
>>           . = _esbat;
>>       }
>> -#endif
>>       .data : ALIGN(4096) {
>>           _data = .;
> 


