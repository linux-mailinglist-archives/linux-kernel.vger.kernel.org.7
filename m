Return-Path: <linux-kernel+bounces-734905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B6B087FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEBF1AA5F22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538F5263F5E;
	Thu, 17 Jul 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gmLnEX1p"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940441FAC4E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741189; cv=none; b=PhQAStk//BOJkdt5HmHNp85/g4ddTX6da9+jOonPPgpklIWtP4/l+ldAa2unn2IjoO2eJkotyHorXqOHFWxB5qAmV4Mid+BWPTlcjxdZm3SZaK26MLKaiZw9sD13Cc/u0N5dK9KNUWAuEvhkhG+BMx9BDGYybFXRzPqlmz8BryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741189; c=relaxed/simple;
	bh=aKbcOie3v0A/5n5Us0l3VB629p6dlBVa3xxTCgrTYQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nagchEFOXAHJ+7dbDTV3ueJpo9aU3ewVGAhANOjItrk5QVCb9TjhQYtDRUD8GrMtTgd4KEu+gEhCemwFy5/zasMAWsSuMB/UX6PnRSx1qZt0RrM4fZ6r6TePWfZhyWtabPGC2CDxo6Yf9XeGHeqf0eegpjXo8xTgH1CCq5cv4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gmLnEX1p; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-612b67dcb89so150817a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752741185; x=1753345985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+zy8ImwGLjg21NL3Ls2d42Nsvv3gr53sPg+xxgM6no=;
        b=gmLnEX1pDZgkl3nsW4fmBtLWG/rJM791c4pCVBD2cCIQHqpqpI5QxjviXgi4SA+BY1
         Ok6O1mRvxk/2ENAJ0H8OrBA+9PhUivcnLo9YxvegHPk8WqEcOhcKV0CwOGAdp9FidHuE
         8fVaurwYdZc7YVHZ4dhG7CEdB/xOVbh2BByLJ1Gtd0jYmL0ryR/GC+McUQOMvsCUiSCj
         XcJHOswmjHynw58FbkZbP9qbUAtnnGVg6VqU+Yr9ULQ5Ro6fbNixCNWZXVaOCwEli1mf
         pg9WGWRxNssqvJ8UfmSG2724Nk3/HD3mh9/ARZoL3LlJUZTzPaE/LGVuvSwAz2L8vTUQ
         aRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752741185; x=1753345985;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+zy8ImwGLjg21NL3Ls2d42Nsvv3gr53sPg+xxgM6no=;
        b=hUEzVIIpQFRLGxkSM+lV7cOTxwJcVBR9xwnPytIal8qH56iMMNtCvMfvnmJ1jzRTgG
         d3TY59q0FzBkmo6EDn1mvSxAYHldw03BTSTFRPgPBp6dfrU0i5GwsY3xtnmOPxKrmmxZ
         WIhin8zUiwBcjEYiDNpna96PVSq80OZfM7+/mCk08+1VQoWHf8WqsXFYYaP++Ib7Jzh9
         9fcrnS4PM78m3CCTUEt3VCJKKTj65wKDiRarolWrHgxDXSScf1ssL7jbPCCvPXPugSqE
         G3aRwD9rbMstfbV/aZFjSse4FytB7JIxNiwrelq3bktRdkFowALFJ4lug4qWpohdh+s3
         wyvA==
X-Forwarded-Encrypted: i=1; AJvYcCXLDe7KetvIxTxmRgV+HAeTp/7ixw1SxSZSp8jEI+S3r3pqZHAxWzduyNSpE7OuFwh2JVn07kiugoWP97o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydjLy1ZOsnJVOL6amXc0gvt9r3ZeeXyt4A5S7ONiu+AlRA9QNw
	5nFXxG0qcyJx7Lxx08QKKsIKbg+i4eJsrqd6HpnJRHwIFA8UGk9GmX2wjIPUzX5POVY=
X-Gm-Gg: ASbGncuxU0ovNOR7mdyruQ3tya6Fh0FG0Ksb0wCDIjrYksUWdIvGmdxAi44QGY6ekLI
	k5mgNL2Cp/5ORCJjkRoEy2KywdVNBIRLqkSxrS+KHdcG8OtTFd+qmJ7ZoPgqFMBG6uJAMN0vgKy
	XZYM0qX3mvt0vYgSLh2kv7ma8qmOBVL5OewmSxQcH1CbXlCCopsN9J0Ksf1hMjtR5fkkXDQCZDL
	1MXdb6tm1CuF3rxM4FD5/aB2J0roSdiik/888zLPahVpX6Y/Z8/EZGDneqPQOFcMkNfW2tfPU1w
	dyl+olBxSbSeob32GUM8gOGtXHRH58ioF+cJaCWTHgkQyiALWcOeR6MFxuuGPjfpsWIWk42CgP6
	Q3kZkiBtR8VHgK1i8Sh9F2ihnNw==
X-Google-Smtp-Source: AGHT+IGQd6HrVXlsT+uZiXcmjPwSxKmy/dtxZCjZEF7cuerCYJLBFBPI88NoZIEGpeEQrjUp3G8waQ==
X-Received: by 2002:a05:6402:90d:b0:606:a99d:91d4 with SMTP id 4fb4d7f45d1cf-61285c03c78mr5664695a12.27.1752741182014;
        Thu, 17 Jul 2025 01:33:02 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.209.237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611db7d59e3sm9109787a12.44.2025.07.17.01.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:33:01 -0700 (PDT)
Message-ID: <e02db21f-c08a-408a-bfc0-c4feb628ce52@suse.com>
Date: Thu, 17 Jul 2025 11:32:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/build: only align ENTRY_TEXT to PMD_SIZE if
 necessary
To: Dave Hansen <dave.hansen@intel.com>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>,
 Guenter Roeck <linux@roeck-us.net>, Jared White <jaredwhite@microsoft.com>
References: <1752092219-16248-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <d9e9ae3a-7637-4a0b-892d-9b7c6335c1d7@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <d9e9ae3a-7637-4a0b-892d-9b7c6335c1d7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.07.25 г. 16:14 ч., Dave Hansen wrote:
> On 7/9/25 13:16, Hamza Mahfooz wrote:
>> PTI requires the begin and end of ENTRY_TEXT be aligned to PMD_SIZE.
>> SRSO requires srso_alias_untrain_ret to be 2M aligned. This costs
>> between 2-4 MiB of RAM (depending on the size of the preceding section).
>> So, only align when PTI is enabled or SRSO is enabled.
> 
> This seems so utterly random.
> 
> I don't think I was even aware of the SRSO restriction here. Looking
> over it now, I do see the vmlinux.lds.S changes and this does make sense.
> 
> But I'm really worried that we've grown more dependencies on this
> alignment. Let's say, for instance, that you forgot to address SRSO in
> this patch and the mitigation got broken. Would we have ever known?

Yes, because there are some ASSERT in the linker file that ensure the 
various SRSO thunks have appropriate alignment.

> 
> I'd like to hear a lot more from you about why 2-4 MiB of RAM is
> important and what the environment is where you presumably know that
> there are no Meltdown or SRSO vulnerable CPUs.
> 

