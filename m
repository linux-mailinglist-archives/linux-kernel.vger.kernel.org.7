Return-Path: <linux-kernel+bounces-720852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA980AFC12F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BC77B227B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0A230BEB;
	Tue,  8 Jul 2025 03:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AxyVYQg4"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E162236EB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944397; cv=none; b=qpuXDvEc9m/B6z8L+FR8tUWPEz1ZHf+Efh6WLIPR/jB0COGx61yFlEYQjbuYo4TLZnAfHbR7qqljDiGUno9BsycvUmi+i4ZjC/OVL6TsZoCZ8xTFrQMrL32mfm6Dsp2V0i7dRJx4tt3DIL3Bj3eUf7uwd1tw+t2gW9TvC/N0fLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944397; c=relaxed/simple;
	bh=dlqspsRSNSE08Tg/3IQQ5eGtPGuk+I37SgCZ42ZpKUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esMzatximLHrf764wPFTXSXyE2vm2f0EqZAO5FSGWRh305dnuJuCXI7otPLIOmaoi6NyEEOnOcd40rDV24oWSeNaIBbbuRIwo1qk9jhcPsr09duDRrjzbdN+YKUgcioq65w/1BdDnnalvtVbj9PgN20AdKThk67AW3Gb6EAVp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AxyVYQg4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86d0c598433so127635539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 20:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751944393; x=1752549193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mENbnW1wFkJXzp57kx/n/Cuvx0hvkcxx0hJLyypG27M=;
        b=AxyVYQg4pPu8gzSkEQiCV0XfirF3+rLTqheDzrF6oLreatfHP0TPpNy2ybLSOu93ol
         vZu4L/GCoyMblkWN57B+z131F9reJXTzdc15db3G7JU1USccelQ+8vFQnxAZWHW3TOzx
         +nP70ilPdY4rVvGs7CfLo1RMGZzMFrGzCxuiWNZZRJbTCV9Y0HFve81iWyNiBJsNRHg1
         0jz4ZyfVaCjsNf5zs0ETOI0ZmmCMo+S7KUbdp88AH7wKOwbHZFjs6SZndREhVrHvEYWc
         Ps67Me8QkYnjT7HI1T+QAYELDs1WoZwp0zKRKCKnG3oXMfpLWi/IiEqNxY+428QElOu0
         ZMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751944393; x=1752549193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mENbnW1wFkJXzp57kx/n/Cuvx0hvkcxx0hJLyypG27M=;
        b=SZNXV0rrjl+HUd05jpmVZTaexH2HSLoer+uYZ4MyqHaXaChCT7TOhDVwlWLrKEBhHz
         Sw4mCGSQ6is0fe5HZrFaJXpLQCTpLkwULB6L0LHuciI8yzrbo879g4rmAIcdE7tK/f/Z
         VVOYIpk0VBoYYWakYkrjm9Spjj9YEsr7klmL/8MdYLUCSRn+jyuLCgUdTPC/zE/KIrpl
         OBuZAdsASMlceSzU82WoGDUcXtAofzFHA0vJbVHNeKAMvzFFTtU69pZmI49k8reVev2T
         MgvnDmEvXacgs4sG3pcHLvOCVsj+33oLcLQp9xvprn9n9vgnQQfajSjEQWuqVMK4ety5
         sDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh92P73iPkml8JF20+QWXRkExf14J2s6C0upPSsnpYAHKWIi4tnEwL1KFnrCzzrY+q0eGLZY67wDo59Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6gM7djC4j+SOtOUqecUrqhjg4aou/O6g1Eq/p/8WLQEfWhwA
	w0ADjM3xXIgy46dgmoJYp1QH07sFMd7nXF4vB3jByAZTMbpwzzw7YYXSZ2RaoNJot4Q=
X-Gm-Gg: ASbGncvW0bwtrz310EVBZ094nKs86rgANoZVQR8WJhIZSgGOk+hlsqnt08yRJHc31LF
	4lezCg5SWvrhPSt6ja5t5zKnb4i84c/zB+u3UwHFFSwGlgQAd/v1+9bhig61Zd4+0N3S9Kegy+9
	mO0veQlXbrO5MgrIsiukPwHZkT0MrpOi/YUIGzjAtC+XF7l7nEevYCSLJtzJuQhsZ9cWqPiJLuX
	cEih3KTNE9DR2L8g03iVyx1JtguqyGv2w3Gb3peJgKXxC6OP5xTt6rFfFevQwu+5TZMcE4ogaFN
	rdleN67HWOiteD+cxmtfQkSoqNzKlWTe8PDstJb8JrFIRg20LKog/L0F9/Y=
X-Google-Smtp-Source: AGHT+IFtwCYSBbPnq7MAU32xreN7WfYm7YtV13PTKzHfEq9UZ2+U7gtCqVUuzNrgb/DFNWAbqVNHXA==
X-Received: by 2002:a05:6602:1483:b0:873:f22:92fb with SMTP id ca18e2360f4ac-876e47683damr1116197439f.1.1751944393275;
        Mon, 07 Jul 2025 20:13:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5a29eb4sm2018772173.57.2025.07.07.20.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:13:12 -0700 (PDT)
Message-ID: <47b60314-1099-4199-b6d6-dfca57689530@kernel.dk>
Date: Mon, 7 Jul 2025 21:13:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
To: Yu Kuai <yukuai1@huaweicloud.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Zheng Qixing <zhengqixing@huawei.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250708114925.2413cc77@canb.auug.org.au>
 <c1e6ab2e-7562-1c99-38cd-5083e728057d@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c1e6ab2e-7562-1c99-38cd-5083e728057d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 7:57 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2025/07/08 9:49, Stephen Rothwell ??:
>> Hi all,
>>
>> In commit
>>
>>    5fa31c499281 ("md/raid1,raid10: strip REQ_NOWAIT from member bios")
>>
>> Fixes tag
>>
>>    Fixes: 9f346f7d4ea7 ("md/raid1,raid10: don't handle IO error for
>>
>> has these problem(s):
>>
>>    - Subject has leading but no trailing parentheses
>>    - Subject has leading but no trailing quotes
>>
>> Please do not split Fixes tags over more than one line.
>>
> 
> This is my fault, I just build a new development environment and I added
> the fix tag while applying the patch, without noticing the line is
> wrapped automatically.
> 
> Jens, please let me know if I should send a new pr.

Let's just leave it, it's clear enough what it refers to. The sha is
correct and the line is there, it's just broken up. Not the end of the
world.

-- 
Jens Axboe

