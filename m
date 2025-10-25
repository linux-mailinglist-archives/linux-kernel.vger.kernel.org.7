Return-Path: <linux-kernel+bounces-869875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDEDC08E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE84E389B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC412E7F17;
	Sat, 25 Oct 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOQzZE4d"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D82291C33
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761385788; cv=none; b=BTiyxqsHPMEDtBMY7uszcpNmSeQjaVWIzwRAj8+ZDFHMwH/eTYVUrJn+HVtowlz9s27/dqa4uj0gLpNNJsKt/lVFul7PITbNDvM+0WmkYOviI4EOz+tbL2qiQHY0tGC11yvAgU8pnN00CInPzF0uMebWCJ1HWbaxfb9goJKy7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761385788; c=relaxed/simple;
	bh=KYDbvM5SlKINN0ZRd2iObH++vvfW6rGNqCv0yERtWUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWT1X6IXiPp/EaivG3DylC5vJLUbvTmnUcd2yPtwEJdrWwwQ8nUYbcLFJ9hjCmCLHiiynyzgQTnXDzZd+sIgKPdylIoiyK62JHkJMMkx+JAN8y3VK7Hw7XhbzOdbWJv/M88T+bgBHshBw9QX0/oXeXQBgEBBrpgnbggh8JmDlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOQzZE4d; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so3203218e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761385785; x=1761990585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wa/PzYa41ebeg2IQuTqJ8Z3lhmQsqFYYMGmG2oqsguY=;
        b=fOQzZE4d2LTl05O5cPnuqhl4oHGKku677tzpUvcF/dHqAUZV7661CbbnZowd8k4n8m
         n8WEA/xMJRklXxpb3ob8MZ7V24mbvUNdEKh5cqumxwlQvPU1bdHbnkMNoGmuB49esT65
         PliqnD8mCKbIREAUh0RHU2uDhDRSsqOFqeMrL+BaB/I7G2uq1tLX8lkKvBZos684WshV
         +18cZEVEWj6Da/zpCLA39K/cp4tTbRe2c5YVGbYE/3psA8MtMRsoKNrS1sohDuSnnBdj
         PkFFYERC4hoCel/0zKP4pSkrVZUpE9x5UI3RRDZduECTBYniHDdIF301NOWLBdjVbQFx
         zZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761385785; x=1761990585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa/PzYa41ebeg2IQuTqJ8Z3lhmQsqFYYMGmG2oqsguY=;
        b=XSW/Ux6OeBQ35ZQ5/asNU+zIQpdvRaVFnheMWhpeqr8A87QptGnWuVF/QuyUr6c9sW
         AqUKr72PBD+mZ47pr1ueKFYJDR5ilgpQVSpXfmVnWZENdGjQ59A+RYQcgncS2XAKgM/p
         jzmxp6d3hUQC2oAGH4pA3vlyr/GAjsu//4RNnn9glM8oTZKHQNMZKh/sVb6ztF+QzxJt
         mFGboHsOR0lpl7NxInXJf4cLy2Q3WibPQ0Nk+MjagsOhZKRqDAapIs7u5Fe+gLCZzj89
         GZ8LEguwquvy/1RkPz/NcgFg/KY1V4T0TkZkfA4xmnpVP14UuvmwC/bYMYP3uBk80NLD
         hm3w==
X-Forwarded-Encrypted: i=1; AJvYcCWUZCxSQkJCbOZ8YtlGxp4G0OnIl9gQUU3UfdSfHehw1p4rHGzkJGadlMNd6FcBJPonuVvR8VXvJWlVGR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJR6wQmms9B/076PrlEN5UgMOfwsobCOgBait69s15T4YEgyAe
	GkNC50bRePIw2SxKikjsXrSzSWY4imaw+78SP5+CWDUCGbw45HTcpsjF
X-Gm-Gg: ASbGncu8Qj1/LeEY4sQ9bhjUO7/2FcIxRj6n9djgH0O8R4W49j6AouF3TeXoME4ezxI
	qjRbCLx+HegctZfm+MVYjO6Tl+RX5Oh2+rDV1qyfOy8r/kFIZP1gva1kh4jrwROqjYfpwvSLo0U
	2UTYk9vLu233bN1zmSI48RZ3FxhxejUlA0t8tXon4R6ryMMlbIrenceqmFl2hQtrc8iMf2bUl11
	ECASpChYp/h1wnjKf0L8AWJBVTUgo5bB2xerxxp5xTexXSC0V/Wu7TrIL8K60dMPEWAUTsGjFHO
	7zeVtb8H9IIy6fU+mznf0jpH6BEHzgsJ9aDc0DFTV/1vLJjPUTAHUrltqs5CXnX9/o5B7ybhrBx
	IeZeJwS5m6RdCqoBAgUs56E1LUuCmjl0e3tI3JOlKgUXUqptczkNonfse/PqxaxC99eBBFP9XQb
	6lMDMttHclDDh6H939MCyJWj4=
X-Google-Smtp-Source: AGHT+IFz2eCZ1bYR4MTJHMLuCeHea8GqXuofX6wmBkcYcRIU8v8aPGRsyg+mqufS9R16ARsBnWvB5Q==
X-Received: by 2002:a05:6512:3da1:b0:585:3109:bb93 with SMTP id 2adb3069b0e04-591d8564b51mr10825324e87.55.1761385784413;
        Sat, 25 Oct 2025 02:49:44 -0700 (PDT)
Received: from [192.168.88.251] ([188.243.183.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f81c1asm521297e87.99.2025.10.25.02.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 02:49:43 -0700 (PDT)
Message-ID: <d039a3c8-c4f7-487c-a848-2a26ea26f77d@gmail.com>
Date: Sat, 25 Oct 2025 12:49:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Directory is not persisted after writing to the file within
 directory if system crashes
To: Filipe Manana <fdmanana@kernel.org>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
 <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
Content-Language: en-US
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
In-Reply-To: <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2025 19:17, Filipe Manana wrote:
> I converted that to a test case for fstests and couldn't reproduce,
> "dir", "file1" and "dir/file2" exist after the power failure.
>
> The conversion for fstests:
>
> #! /bin/bash
> # SPDX-License-Identifier: GPL-2.0
> # Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> #
> # FS QA Test 780
> #
> # what am I here for?
> #
> . ./common/preamble
> _begin_fstest auto quick log
>
> _cleanup()
> {
> _cleanup_flakey
> cd /
> rm -r -f $tmp.*
> }
>
> . ./common/filter
> . ./common/dmflakey
>
> _require_scratch
> _require_dm_target flakey
>
> rm -f $seqres.full
> On 24/10/2025 19:17, Filipe Manana wrote:
> _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> _require_metadata_journaling $SCRATCH_DEV
> _init_flakey
> _mount_flakey
>
> touch $SCRATCH_MNT/file1
>
> _scratch_sync
>
> mkdir $SCRATCH_MNT/dir
> echo -n "hello world" > $SCRATCH_MNT/file1
> ln $SCRATCH_MNT/file1 $SCRATCH_MNT/dir/file2
>
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
>
> # Simulate a power failure and then mount again the filesystem to replay the
> # journal/log.
> _flakey_drop_and_remount
>
> ls -R $SCRATCH_MNT/ | _filter_scratch
>
> _unmount_flakey
>
> # success, all done
> _exit 0

I think the line with `echo` may not be the correct translation:
 > echo -n "hello world" > $SCRATCH_MNT/file1

In the original test, the file was opened with `O_SYNC` flag, if you 
remove it, the directory will be there when the system crashes. I also 
forgot to close the file after the `creat` call in the original test, 
may be important as well.

The test itself is quite weird (why would `dir` be gone after seemingly 
unrelated operation?), any detail can matter.

Please run the original test with a real system crash. I will also 
double check everything on my side.


