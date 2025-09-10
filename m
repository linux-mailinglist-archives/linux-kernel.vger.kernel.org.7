Return-Path: <linux-kernel+bounces-810300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C7DB51873
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B64C562821
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642CC285C8A;
	Wed, 10 Sep 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wejW6Dxn"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F61218ACC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512541; cv=none; b=PdRZxMy0o8h+sDhcecAiYH1lJG0y6xQrSPcSPjA+APo0y/ctIj1ej51imUu9QPtB/U2+41jSEh224ib3KCEluv5MIExZRPdmxMLVNqiJkLZpJbPeN/pX2IKBkRTT0DKwWnEOQ4fz4LZc/krgHjKfDwSSMA3h5UNDRNXBHK+7TJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512541; c=relaxed/simple;
	bh=DPtekcfskKeX5sK6S8/7A8h4mHeaG50fzKD/Jq69K2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfFzXF0xa/4NPuvKyzL6YWC/QfJXL+wV2wbBIGHLmwVmHBWXa7rwG3qyCBz1h85Y/+q/TjWudg0YndkzF3TESy+uXINJRw4hbu8blGZRguW/JS5N6xgmn8IgN8j5tnfx1cIlbmjMAIxiWi8xWDJmzFzfoPdf0xLU3/3rDdmRl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wejW6Dxn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7725147ec88so427704b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757512538; x=1758117338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AI+7QsrYS6rQ9UV54T+28pT1WL9pz224BK8bqqxel38=;
        b=wejW6Dxn65yXhFmp4dGgCVYdUVF8d0PphfBZG3coCbF3T6KxFHsgq92DTk/3MBTisu
         KQ/lZk72qoSI/54X6Sd/LyFHFTzVcWUCn+8/mmSsNJZMhP4K+T6wLZy5Sz7hojTXgaaI
         HhnRHaTxtIlDHmQOiRYgV9hrt5OkTtf/pzQ/jtXyNgdIQoV7ZJPUveMosfR/0mbI/wCr
         Ox5Yl8pC+WyMd02OdA0O5vvnp4EdokZjl+Yp9tsmr+Pa8C1gMGvVmBIUhO0oCIv/zXFL
         TmAiCu/sN9YjJnHWmVk+H8vg3KUoOyLdLdSaSwir47oU8u35QLAxFcqeF2UC56EQ4Ivq
         Mv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512538; x=1758117338;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AI+7QsrYS6rQ9UV54T+28pT1WL9pz224BK8bqqxel38=;
        b=t/CzoxtCYFHbVy1JFa+7HnRWi7wm59o5OGGmgKb95MAmxOS5wflODBE8rVdycnBn3/
         lPzctq2bv/MK1UC2l0REgbHEStSyCyZ+d0Hez1Di9J805PhTwJ/+FfMtFsefgauesojm
         i/xdizGzffNNFVZb7Ksbg6kLT41Y2mTqfE9DMbY/W8pEjRQWNoTobtcYv2gFu5vcIlVc
         aOWtYcEYHEJJXtbxzozAvachTsLoVN1Osp1V7zrDnLZYGc6LHjNj8gu21fe6BbmNwRQ6
         sG4/Whx8urltIeqhlJmZSxj3FwKDdXbgc+lBBPTnNP5QlZIR5FfPHIoodhfd9konC9US
         FAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKauvGBFmbTvcKI2vSXnlmrhl2DWUno0J58rqZzo/QiSVVJXHaGLCl9SR8HkhxH0EoS1nSIu2cwmfctR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBwfCpWACpaIo2IFgqk+9LRlEEfsBzP7tsH5UQfZNWY/DuuZY
	McgRGFGLA86IDZoQGwwEc04mYaQmob+LaFnzUkBuurlGOEtxHyDNpFw4enC3Nlv1yqw=
X-Gm-Gg: ASbGncuTaDu4ZVhTVEdhSDQpxF/tYDl376b3Q9qIlwNzyEQo1rWalQ8g7rS+HfSxDdF
	83tndTSTayOfUoZc606xSAtVJT4Qc9gAleNiic80FEeP5+ni/ADA5fZ+vl29MhtSGpzNeeVxnjJ
	iLp1YOLGouXvZAGAhM/fBKfBByTBPjzwPpU3wHQCoCO3ogJmTca4MS2GM8gLEmwxf8IQjD8Lfao
	DWgj9mM6YrlvXqER59bLXssK0AYdS7z+1tKJV9iLcRV83Cg0Rsl2rhGCQT6y/ehXCX5N7IpdMqK
	YhPQACOXzBKdh9jF2DxNzJc8rDs8O8BKIwvrGNQYmPxBrbNNZCu9ZD7MUR0/Eg///76FZAKoC85
	ZfjAhpv0U7q2qMsrr3uUC
X-Google-Smtp-Source: AGHT+IH47tbZDYTT82XLeHrkskEzr/dQvKZk5o6UrBiAKhfpEyQWgWmZY30kXCg1lcltEO60XcUXlQ==
X-Received: by 2002:a05:6a20:394a:b0:24d:d206:69ac with SMTP id adf61e73a8af0-2537be0f199mr22502163637.14.1757512538438;
        Wed, 10 Sep 2025 06:55:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e5b5csm5247280b3a.7.2025.09.10.06.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 06:55:37 -0700 (PDT)
Message-ID: <4029c2d2-7a0c-4531-aa1e-b35be9098bb1@kernel.dk>
Date: Wed, 10 Sep 2025 07:55:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 00/36] rseq: Optimize exit to user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250908212737.353775467@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 3:31 PM, Thomas Gleixner wrote:
> For your convenience all of it is also available as a conglomerate from
> git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

I used this branch for some quick testing. Since I last looked at the
rseq performance overhead, glibc must have improved a few things. FWIW,
box is running libc 2.41 at the moment. Test box is on debian unstable,
so gets frequent updates. In any case, for one of my usual kernel
overhead runs of checking running a basic IOPS based test, I see the
following on the stock (-rc5 + 6.18 targeted changes) kernel running
that test:

+    0.89%  io_uring  [kernel.kallsyms]  [k] __get_user_8
+    0.58%  io_uring  [kernel.kallsyms]  [k] __put_user_8
+    1.13%  io_uring  [kernel.kallsyms]  [k] __rseq_handle_notify_resume

which is about 2.6% of purely rseq related overhead. Pulling in the
above branch and running the exact same test, all of the above are gone
and perusing the profile has nothing jump out at me in terms of shifting
those cycles to other bookkeeping.

So yes, this work does make a very noticeable difference!

-- 
Jens Axboe

