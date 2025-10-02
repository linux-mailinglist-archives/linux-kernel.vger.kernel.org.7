Return-Path: <linux-kernel+bounces-840436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DDBB46B5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5777B1173
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4292B23ABA8;
	Thu,  2 Oct 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rCUGi3+6"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE7224B04
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420712; cv=none; b=U1TYOICLwbKqryaQabynQwN+QlknWNjlWJNHFOVhdpRhl9uc3jRj3gvm4KmFZ7iSVOnfFXFM9cmj0m6WhDc4lseGzvKla7vNSrU2RmII2uq3E6CllyWl3hONIGe3YRy9V1N77p3nGG283ZNXXfxQ05hzIVWl2ODKvVxHGPjgfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420712; c=relaxed/simple;
	bh=0AOCr6BPvIm1M5pnw2VjYpyLZxGSVwWCediy8evOiuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPre1RK1vtbEAx/TvJ3FvHneCbO1RlV2+fRGteBJy908Rlnqy0vFlVMVcTO7PbHVJYDwvJf6dIx3iYdI6IgTy5vWa12xrf9TX5TcBU9GSw13l8JFfdEl26oSyd5R0buW5i+w/E9kuOSG6meYfIcUfDiBHWCTv7sbuSKeXAaJ6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rCUGi3+6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42861442ec5so11391455ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759420709; x=1760025509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNilpGtwunxhkKhtHuanByyeVgHiZ0tzBGIYdEYkGmA=;
        b=rCUGi3+6k/j40dTyvQH3OV2lP/wGRecIhNLRpRqpAjP3rTSbC6ZlZTqX/23Rv8OTxE
         lAXg3oAFeBwvEsOIiQAZ5bGrwIl5b9PKt1+HAnLnIkZOyUO0NAtf0qd7QcgRDnIAG9Q4
         4oYrC8qa5cqYfpGHXj9Xh0ABqZJ2K7sb6EWTmhBuzy9oUVH1FGlodlRuFTQ/Z9yjItBN
         azg05OJJK2OIj4gVRznFwJkjz0DxaOaRC/p7gjo3XOQpVWuSetBZxB8kIRN6LDviq03d
         TwjauBeTs3hITnB614ZKj1h3Kp/cftbcqKKRqWVRYMletv7t/QZz+mYSDU8+8F7fxr3v
         C0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420709; x=1760025509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNilpGtwunxhkKhtHuanByyeVgHiZ0tzBGIYdEYkGmA=;
        b=WDrne98VNN184v9kKgVFfWkuglRbtQ/K3MLVOuhzez+gNq9s4v9WMYpsUR8weel5RQ
         S5e4yRcNtH4CgijxD0mX2i+aowcwWqZZ3kCLZQ9qhr+I3jS8aaCqak9mFbY9NVdThn+/
         rVkk2edOwBFApnr7Cwwh8TUQAuGhcmd/ha/TwiLc3akdq2n3QvXHfxlyFNLXe2Jg0hwa
         Nw8Vv6xZs29TW+kFU4n7/JO+GXRtWxMYspoteq8DoDs6RiybT3e0VImX4499dY0CaU8P
         tqdUsHncJzLrrmApg98fUG9A2B+Im2BVhVkdtEhOvCddydUwzQhd5KDKn5XcL1GLyVqI
         xpJA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ+a0P4Ej5+oduz6z0jylsrx3FGcS9o20CrmoURi/IrjMncy+6S+Q61byaS+YpRDi3BMOdOiuimrxk7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+k6UwjndoSrSiDkGlmzkoiLRBv56AeWC5u2JxvUcpzd8ghAir
	NMz/yw/b+8VfcTiBCoXjM5qRMPqCyrhB18+YHr6Mlie522KU7T9c3/ENdJmTROZ0dUg=
X-Gm-Gg: ASbGncvKmaRxCpQcJ5l/VPPE/vFEWQOmN0q4gjb9r891cFFyEcfXqz3grOfX31tEhPv
	I37UP7EHYxwSYc5K/8FAIYeTPVvoRZ0WyduFFCRAlFu5raMSPEJ4pxPE4HfNQaWkxHa7CjGYu1L
	P1I6i7/SLAtlv61nHX+yyxumvm20PHhZ4U7U7VcidSs8CEwX2kxbiawcmjh7aD00HOh/4U9ds52
	4+w3nWE37iYeSyN4MiSHuNCGflonYneqQeuSWYIhDSIlcWJjiWNOKbmWJ+UUi92tlzs6xwdOsr9
	cTUXB/KdqN/atM4FY+kXiXdTmovqJ+ztSOUEjFsUToIT2ZbGr4XYV/hThj9E81cdgolPrWFNnEQ
	77zw219P8DAJOvMBpsTwbdtPM7IZKFo2hLkuwws9elCmk
X-Google-Smtp-Source: AGHT+IGEiHZSumtbEx41vubwodqOoT5aOYw9eNQC8MCndLsgVDLYkboIsl41CSo6vL17oHiISA8Lew==
X-Received: by 2002:a05:6e02:16ca:b0:42e:741f:b626 with SMTP id e9e14a558f8ab-42e7ad021eemr1269845ab.13.1759420708846;
        Thu, 02 Oct 2025 08:58:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm10924825ab.2.2025.10.02.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 08:58:28 -0700 (PDT)
Message-ID: <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
Date: Thu, 2 Oct 2025 09:58:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>,
 linux-block@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com,
 gjoyce@ibm.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
 <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 9:30 AM, Nilay Shroff wrote:
>> Slept for a couple hours. This appears to be well known in block (the fix is in the 6.18 pull) that it is causing panics on stable, and didn't make it back to 6.17 past the initial merge window (as well as 6.16).
>>
>> Presumably adjusting the request depth isn't common (if this is indeed the problem)?
>>
>> I also have ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/nr_requests}="1024" as a udev rule.
>>
> So the above udev rule suggests that you're updating
> nr_requests which do update the queue depth. 
> 
>> Jens, is this the only patch from August that is needed to fix this panic?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409
>>
> Greg, I think we should have the above commit ba28afbd9eff ("blk-mq: fix 
> blk_mq_tags double free while nr_requests grown") backported to the 6.16.x
> stable kernel, if it hasn't yet queued up. 

Sorry missed thit - yes that should be enough, and agree we should get
it into stable. Still waiting on Linus to actually pull my trees though,
so we'll have to wait for that to happen first.

-- 
Jens Axboe

