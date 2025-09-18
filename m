Return-Path: <linux-kernel+bounces-823420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2FB8660C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A894A7BC009
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E622C0F66;
	Thu, 18 Sep 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N9KivoIk"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D23223702
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218821; cv=none; b=VWcT/pSi9xx0ZJFaoPalTnHrNsUIQub1RhWQi3yBtK9Z+HtRgfDOSNWJKqV3XpEcllooQGSuVI780AxifoWawdBJ7b/u7QXBBd8hoLK/0wvtv1gdmXgOl8GPo9leaPJp7gXDPAOanPt2OfZ6jV0skXBn74CnaGdJV1m0VcmOmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218821; c=relaxed/simple;
	bh=b1VI56OWvK1tmwsX2dbcopiTFH8Zr46g+PeA7taEl/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGN1SzqGgGR5X0sS5uoRtmMEUqBI2zvpKFtvQgTh9K20dG6aU191/A1RRJEbqoEBv8W8Zv1Jau4G3OX9kL6L6nVtGCmUPGbG2P2ZBelpmVCpx891/RaQVEzQp2JxecnYBjm1h8oy3/h4jQPGZ4zMzVkiHyt6i8lMr8nF5JEH2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N9KivoIk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78de32583fbso6565536d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758218818; x=1758823618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPBEn4/fueUrJT4RnliR6Zn3+7CEMnoE1lnAFIQBudU=;
        b=N9KivoIka+dKRgzWt96FZT7HBlZSFZMnelXRrjkDAo59HIf3aH9HxRL08dK1r3SImB
         PqhZKZL7cZRRS1PkvRiZYbs7njh+fpTGh3FzJAzy7ExF0ibmMdSMtPB9XjKxpuPNNiQl
         zRn81F5wc667GlBqynLWLElcgs96yxPVhEfEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218818; x=1758823618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPBEn4/fueUrJT4RnliR6Zn3+7CEMnoE1lnAFIQBudU=;
        b=Znegd8Mmu+lmFrVRwq0tTzIPpzL8MEat+PN0tltR/FQIDyNh+WiNZkO9zdse0wAnba
         UMspCiiTb9if2rW2cFYjbRQZcgpYk1FICMFkmJBrt3MeDApRjFfY0TLprWGvrkqjebZf
         Fpgr3+g4TTGIn0BaiUtdlWLlo71X1E/sbfXakqONV7ddrAzgXYKlcfXPrLaQ9TTDrREp
         ILMJyizbEE2zR1werQVZGsT6sjsdkex8Ji9UUcOxttdojZcyxNgZCw56+gPXWIsfuKqN
         5UIVovQA9N5QLt2L1CVVnwLctdcXQ0An9Y9o6b22jFV8DciOtJ7BTc3k1F5jwr/XwrY8
         isFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYgJFbyAQwxwLDrappiqqhCeVsCRnYybQqoB1CdchSGl+xTSHL47CEApKJi9wTXSaZ6vuN79U8/8SN3XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywmdaqPw6lB/Zird+dKj6umnwqsgz59T1IpHJk7B29cCRyG/wg
	RSRjIkSpMWgxaaf7GbaOB+rQ1sK94LijWj3hSGvxv2eKEJD20gA+AiFFSXb9DDofotU=
X-Gm-Gg: ASbGncsz3qnDSSf4TAumn2gZXHILRAJ0d3jcueiZhJ9zmCi9j8z2xPnWL5EiSJwe3QJ
	+SIok0vGztuvfOrcwSwylMuRyrjfY0RQviz9icI3FMwvNI9a13Pml+MN4w9ELsP8B52ecGXG+DR
	6hJNybehJbREhCmDYq8iGY4vZ44gDCHK3G8xJWUYI9cRSlqOZwuFuTct9GVS37BTEP778dwbK+1
	SzBtQhyt1ESD9LzMvvZqOm38CBoK3Qk8arcC5ZiBDKyASra3ioAEe8VHDhTazg4GAEsKRIkCuai
	s+3S5ehcidbfv7oLyq/+8EJr/gAX6Oi5Fy1fxPHPj4uh+Uj5gz2R2nCwEh3Odk7t4T3bMPG7joM
	OswWaNRpUuF97/t2KoF+4hP75LGkXyY2hbKthQzhAeh31xAq7a50hFk5odo93j9dPtDqJ6f6Pcy
	KewqT1FPyj1rT33Qv0dPVWq4XSWZiJ7BshgnBXD/1qdwYqehquHJMR68TjCWM7
X-Google-Smtp-Source: AGHT+IEYz4mCFMtgI1U2y62M08ruBZjhmxD/qpb8wLHUyuXItNye5CldaDF1VaKgqhs6Ma/cWnWPow==
X-Received: by 2002:a05:6214:2462:b0:711:75c9:1766 with SMTP id 6a1803df08f44-7991c124caemr4124536d6.40.1758218817573;
        Thu, 18 Sep 2025 11:06:57 -0700 (PDT)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79351f70e9esm16735056d6.42.2025.09.18.11.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:06:57 -0700 (PDT)
Message-ID: <53ec38e9-5ba2-4a5e-9bfb-ba43e411be7f@linuxfoundation.org>
Date: Thu, 18 Sep 2025 12:06:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: always install UAPI headers to the correct
 directory
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250918-kselftest-uapi-out-of-tree-v1-1-f4434f28adcd@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250918-kselftest-uapi-out-of-tree-v1-1-f4434f28adcd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/25 03:56, Thomas Weißschuh wrote:
> Currently the UAPI headers are always installed into the source directory.
> When building out-of-tree this doesn't work, as the include path will be
> wrong and it dirties the source tree, leading to complains by kbuild.
> 
> Make sure the 'headers' target installs the UAPI headers in the correctly.
> 
> The real target directory can come from multiple places. To handle them all
> extract the target directory from KHDR_INCLUDES.
> 
> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
> Closes: https://lore.kernel.org/lkml/20250917153209.GA2023406@nvidia.com/
> Fixes: 1a59f5d31569 ("selftests: Add headers target")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   tools/testing/selftests/lib.mk | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied to linux-kselftest next branch for Linux 6.18-rc1

thanks,
-- Shuah

