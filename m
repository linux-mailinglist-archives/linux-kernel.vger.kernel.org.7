Return-Path: <linux-kernel+bounces-834224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B5BA4371
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 730324E1507
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B471DB154;
	Fri, 26 Sep 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BptXx8IS"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7C1BD035
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897069; cv=none; b=OJcuT2yuNDClKHXiOkWLSWRaBXC7WGSilAXByX1AU5OsDSGvl7zoNtoRpzDIdmxvN9BpavDwZLKbaELAZrR8QFFSeEbd27Thr0j7Tk8TS+kGFM5/qxIdC6jzTKIMRPjySYJ8nb05uknGHHISnhOGmdTQdTMoHGxsmoUU3lpSUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897069; c=relaxed/simple;
	bh=D7y/T3BubgIHKIERa3ehgEshcxm/NqMlb/ZQEKo8n0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0z/gHwjpGScsc6pg/jqMRIpDn7JnHZRkYOV+HAhl3024sPWv+bLI6Wm8WTfphb7fSalKkXTXKNvMRrNCWDuITVtodM2nidcqAiiwXF0/D38WGzCvoxTpAkzb8DP3CAz9Oq9xWt3g5TNdSqCm/X+UmwxsWJ+wN3ZDM6zQW3EYu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BptXx8IS; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso7019715a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758897065; x=1759501865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kPZvj3WhzskwwD0bmnZ0NlO239qr1F6Hn1jDGegw+4=;
        b=BptXx8ISOi4MNNZTdt5T1lqglLRLEgJ2c9wZhUWaUKJ7qk2M7zvwCKZL5doLm3hd7a
         3vyUfK7sFChXcMLqnWji2LLByDkZ5klRzp6YMtozu9uD4FwTpRI0/qb13qg8zjShOlpS
         amDWStUlbPLF1XPp/C/BOuwbmN1u4o+9HmHcOw4Zp2hWMq7V1yATSOi44d2VA8huSP5L
         Mizm0hNbxE2NDj209YnVhUQF9GJj45H9qkdTp0lT6+xWYH5DtmPmEx3EJMAXd2IfeWZb
         LKtftf/mhz8CYAc8yz2eZwMQaHydKmxAmM0mJs0ayMjUWqDLpnbbhu8tFL88zdHidyos
         KrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897065; x=1759501865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kPZvj3WhzskwwD0bmnZ0NlO239qr1F6Hn1jDGegw+4=;
        b=soW4BO8DPC3Kzdgh3+HfM5QtIa7V2HrggYdGdDc+cSEsGlnNoFV/J1Im9En32Avjrm
         a34qL0ZvN3nVnES/NofsROZBIQx+voLjZATyCCzQHKvN0okYQn0SZxZH3Wt7JK7pxw7+
         9/oqUk4MtzN5WZO+mIZvMWS55L+bTVFslB7TNbqJ2/h0zdPjZ2sPbru2U0T1+3SLHGIW
         fXuCXD+0P3AxxYwFoWBrS6KQeRRIjdMCKCAbJG1Ame3J77VFHYAPbFkByLXFgMOF7vf/
         bN3bi3nPAOVbzi1gvaGSRbqfVnVv8HNxaHPXNvYekwABUtB0nVEiWBBBqB2vAd6PnSkW
         OFiw==
X-Forwarded-Encrypted: i=1; AJvYcCVsqAe+r70PYG+99929fq1s56IP/gvYDvQjnSOxoAsFDUEDjprA3j7jaPW2LuFqusmxCJjlJFxi3i6DGXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4Y/bP7Ur5qbQNODbzuCGyv9cJYf0dYFlfPiBP8wC4gM2y7PB
	V+dK3w3HKDUK7XIZjvbRq3Katf9qgCvhRtMkww6vGquNbmfJcm6548APnNC07crbMrc=
X-Gm-Gg: ASbGncvLhSEK2uvt2DXcoODmj2MGftO9L6wnLJfcYNzokLqZw5BOTKjN5f2rMuxa5We
	5iGd/6QMY8sgUqkrVVBR8/vhGo8NsrYB0AgPtoIruX1hBT0pLiIg0j5V9UHC0vzqE/1sRrvMiHN
	zow/cT8QnE2Qcv4xtN3tCHqvpq0KnaT5wHrDWOUjTLZYASgKfikfhd4IDM0UuJI6Jo24e2qk2bx
	SQngBe2Gs5Ytkv9jVmAxgE1XZetWLfCrIyw9QbrToyZBRmpu5TQx/JdzvNQbHPkkiRcusbhFGEE
	fr9uAqnpo/GUyqJFoKhMghLjsWyydtOBwqBjluNSVZxabdNzo2P1twWDXlfJATCl9cNZiNRLyuP
	rKKV6UE0C8v/zM0yNASSxiwjTtJR4hSJCCSi46VC+
X-Google-Smtp-Source: AGHT+IFL0m8nz+xgPK1qDCaQlKsXBbPU3BEMnL7cCtw5fgkY59UIyenh+3QlKQsNgUP2r9DKebRo+Q==
X-Received: by 2002:a17:907:168c:b0:b0c:fdb7:4df3 with SMTP id a640c23a62f3a-b35498c1d16mr773778966b.11.1758897065403;
        Fri, 26 Sep 2025 07:31:05 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9978bsm378460466b.95.2025.09.26.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:31:05 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:31:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1] printk: ringbuffer: Fix data block max size
 check
Message-ID: <aNajp-cjUKVfrtT8@pathway.suse.cz>
References: <20250925224959.757266-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925224959.757266-1-john.ogness@linutronix.de>

On Fri 2025-09-26 00:55:59, John Ogness wrote:
> Currently data_check_size() limits data blocks to a maximum size of
> the full buffer minus an ID (long integer):
> 
>     max_size <= DATA_SIZE(data_ring) - sizeof(long)
> 
> However, this is not an appropriate limit due to the nature of
> wrapping data blocks. For example, if a data block is larger than
> half the buffer:
> 
>     size = (DATA_SIZE(data_ring) / 2) + 8
> 
> and begins exactly in the middle of the buffer, then:
> 
>     - the data block will wrap
>     - the ID will be stored at exactly half of the buffer
>     - the record data begins at the beginning of the buffer
>     - the record data ends 8 bytes _past_ exactly half of the buffer
> 
> The record overwrites itself, i.e. needs more space than the full
> buffer!
> 
> Luckily printk() is not vulnerable to this problem because
> truncate_msg() limits printk-messages to 1/4 of the ringbuffer.
> Indeed, by adjusting the printk_ringbuffer KUnit test, which does not
> use printk() and its truncate_msg() check, it is easy to see that the
> ringbuffer becomes corrupted for records larger than half the buffer
> size.
> 
> The corruption occurs because data_push_tail() expects it will never
> be requested to push the tail beyond the head.
> 
> Avoid this problem by adjusting data_check_size() to limit record
> sizes to half the buffer size. Also add WARN_ON_ONCE() before
> relevant data_push_tail() calls to validate that there are no such
> illegal requests. WARN_ON_ONCE() is used, rather than just adding
> extra checks to data_push_tail() because it is considered a bug to
> attempt such illegal actions.
> 
> Link: https://lore.kernel.org/lkml/aMLrGCQSyC8odlFZ@pathway.suse.cz
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

JFYI, the patch has been comitted into printk/linux.git,
branch for-6.18.

Best Regards,
Petr

