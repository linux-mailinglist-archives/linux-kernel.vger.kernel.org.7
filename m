Return-Path: <linux-kernel+bounces-754269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48933B191AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 05:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F369F3B9CE3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 03:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261023ABB6;
	Sun,  3 Aug 2025 03:07:21 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B115B135
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754190441; cv=none; b=TSPsa/Co/uC1pqXJvLv+6cVDaTa83foMIxRS7d09Zf7jbYChmrsclZ3we9r3h8E1zIJHOBM3X3T2ipzwC0dqjxYGwrRXni/DZ/+8TtwrDjh1mxx5rrWyHeUCS9etaTxBI7vabqtcMfK2chIZLzZ27AqWSGB1Hta2P1/Yb9jy4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754190441; c=relaxed/simple;
	bh=0LX5Gy0+3IA6CCwIv6yHz1ihgUJQC3qLijLYu/DrL84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb34TPNwCWGxMmWEEzoO0e+QEq0io0DEG2no165U93ycY+/heKJ3LMnjkyJ1PtWSftSTq+YEPzfeiKeR1tppfSqPJ0xTOppLbyECjcFbmqKVfwSD+vrAx+LCl0nG1dIl8atE25v7UrkP60QDlKqMYHkPwDY7X8PLwqEmugyXJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2420c9e3445so4840645ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 20:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754190438; x=1754795238;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59b5hv+RKc5rwZqH19eYsmGMmjQ5iKIc+JZWIcc5f/E=;
        b=CzJhixNNFBq1x8MpXOyYSOLj4hPmfzW2fhZOUnlilzniJubqZih9FMJCQdUTO8UEbX
         2gGnwxQVkGcp7xD0xxje5tQg98A/RVuhCEMjS4h48z5OtFk4k2Kr2osxQWFk1k2OJ6E2
         b2hJ0a5KYTUrv6Y4+K/X6AqxSuHBoTnSxdW+Fk9pOqPpJtUK2dh1c11cixnVwf5Jv/lY
         zt1hZ+I7yt7pZOrQCtxUhpfnsaB5HDQkbGNGSSu1rXspmbyFky6B6Lx4p/bktFtjUhWL
         sqMqwmrKnFvGXpiao9LLkv3Ko+byqCSSr7RCBGhr+2/Uvpdf+nvrYluKk9ONyRDu1DAx
         7SKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9por4DzWdXFdMKmNGBFAQA+pbmmDJbupDA+2pz3oNXtPnslkduoDBUxPI0oNHMMH1P+60ObCKY4Wx214=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89YAIzi/c3LKZqLz44RUwHhOZ3PglivLKykyw7rAOolGXYyRP
	yZHfVNM4L6j6sL743fRdbk0pUfhj1JKkmRDJr2BIrusZiKhVD2sRRRi4
X-Gm-Gg: ASbGncvC9kP/ABoAHUcbLJremuptaunphjrgLDE0dYG4w+j1LthWDa0ItuXISBPFbG+
	XW+ntZGDhiHNMv3mQgcY3TS/6Ju4uLI4UuNrGKh61IWZy9MMaWlPwli1sjU/JdOWnKUXlEwpzj+
	gcY/vStWbQM1kqxFVjmmsd5IBPlZUX6TUO1PrY3iPujN99E5Yo3ZGy+FlD0XdI7wKxwLiuFzZ9T
	ou6HEKRcoi5TNxOaFNgyWxBziRGkglTEIAzJsGnG5OjwtDRhuObettRpYnZl6eKzAvrqtVfky2y
	EcsPyFWoKvPJK+U+LbRJYiHezltyc3W+qwFEz3t9YSrsNcJPWVO/+ATAO+UYK+kBFyP3aa74GKm
	Y84CZgbwqGtDjaqh7FnDJUVfVinkrJzQY
X-Google-Smtp-Source: AGHT+IE/gXN7bCxZ8zfcYuTQJcGqV/4JRv9Xuk4YzShwGvgBmA5H1/smA6JVFfTmmsq7Oquvs9qt4Q==
X-Received: by 2002:a05:6a20:3d20:b0:1ee:d5fb:dff1 with SMTP id adf61e73a8af0-23df91e07cfmr3216251637.8.1754190438116;
        Sat, 02 Aug 2025 20:07:18 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49e0sm11108149a91.24.2025.08.02.20.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 20:07:17 -0700 (PDT)
Message-ID: <18003f21-f83a-4bad-93b2-70273c03974f@kzalloc.com>
Date: Sun, 3 Aug 2025 12:07:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path
 on PREEMPT_RT
To: Hillf Danton <hdanton@sina.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, linux-kernel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>
References: <20250802142647.139186-3-ysk@kzalloc.com>
 <20250803023439.3760-1-hdanton@sina.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250803023439.3760-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Hillf,

On 8/3/25 11:34 오전, Hillf Danton wrote:
> On Sat,  2 Aug 2025 14:26:49 +0000 Yunseong Kim wrote:
>> +	raw_spin_unlock(&kcov_remote_lock);
>>  
>>  	/* Can only happen when in_task(). */
>>  	if (!area) {

		/* 1. Interrupts are temporarily re-enabled here. */

>> -		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
>> +		local_irq_restore(flags);

		/* 2. vmalloc() is called safely in a non-atomic context. */

>>  		area = vmalloc(size * sizeof(unsigned long));
> 
> Given irq disabled for the duration of the coverage collection section [1],
> vmalloc does not work here [2].


Thank you for the detailed review and for pointing out this critical
interaction. You are absolutely correct that vmalloc() cannot be called
from an atomic context with interrupts disabled, as it is a sleeping function.

However, upon closer inspection of the kcov_remote_start() function's
control flow, it appears the original author anticipated this issue and
implemented a safeguard. The vmalloc() call is explicitly wrapped by
local_irq_restore() and local_irq_save():

>>  		if (!area) {
>>  			kcov_put(kcov);
>>  			return;
>>  		}

		/* 3. Interrupts are disabled again to protect the rest of the function. */

>> -		local_lock_irqsave(&kcov_percpu_data.lock, flags);
>> +		local_irq_save(flags);
>>  	}

This sequence ensures that the vmalloc() call itself does not happen in an
IRQ-disabled context.

My patch reverts the per-CPU locking back to the local_irq_save/restore
primitives but preserves this essential bracketing around the vmalloc() call.
Therefore, the sleeping function bug should not occur.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kcov.h#n73
> [2] Subject: [RFC 0/7] vmallloc and non-blocking GFPs
> https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/

Additionally, I have tested this implementation by running syzkaller
for a full day, and no issues were reported.

Perhaps a comment could be added here (I can volunteer to do so) to
improve readability where the control flow isn’t obvious to future developers.

Thanks,

Yunseong Kim


