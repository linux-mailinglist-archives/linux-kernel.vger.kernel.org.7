Return-Path: <linux-kernel+bounces-817361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE3B58132
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42224189302E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924B1F37D3;
	Mon, 15 Sep 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrG/RLKS"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADB17C91
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951015; cv=none; b=o3iYoJMU0/JHxPkmZRLwFDXixXiKmUKcIWIZuru11IxO+q6DbvcyOZMvm17faRkkM9jhO4rtkQIBTnsIxRURlMZpox6qQXYmdxBduL6PGJgnKlRmWr8vx+NerSOq0F3SEv0958KxqBlo0uGbqRAVNMnXpfzhuAb1xXlol3O5ybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951015; c=relaxed/simple;
	bh=OgGRiEUDLX3RTzuowFTrJ0bl861dCWK6Y5fQo+yVJdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKtIcgqd3kX0SFVNei73iS3/f3yFN4ZG3OXbvvXBot1+ihj9oO8uX5X+XwknuBCh0h+g/FlCl7F70MTyouAXVB0Bwbq209yM2IHPCBtFqwK1cIX9WEPgmQJZzjRD7Ign+4zI8aOD99ij2SBVOLFsQpK60x+d7F9/A+gQ7G2zin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrG/RLKS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3eb3f05c35bso753950f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757951011; x=1758555811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4TpjbuEkSI9D7sI2TIuMaUkLm3RGFxmBSKlWPmE/RE=;
        b=OrG/RLKSdV73atEZ8bDCCuV5diO1jlCqDFHgyWBVsEo4uTmK24b4dtjlGZELSx0GBs
         TE8ytN87zLnXF2RBGduhryA2dDEjqTWZbgIiMLdvyq6aTjUTU8uUp8TzuzW2jUix/ucw
         rECU7rYPKvMvhz+keDLmYzb5MdA3YagKZr7eZ8XBw2K+jLD9iww4CpUltxfVDOy3koyc
         mhie4vU8G+S0vOSIfy4pENAf/qtvb7qPiE1CWAsiuuAuLyH1bh3nUzdMxG1dbiwKrkeF
         71VGbhDF4RYEFNHgCpP88AT+k7BHx6rBel11egAhHG/6HqZytI7JCDKjbESGndW7loh6
         sbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951011; x=1758555811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4TpjbuEkSI9D7sI2TIuMaUkLm3RGFxmBSKlWPmE/RE=;
        b=R7lWb61ivmldXIgyH7mUH3D817vuLH+aPpuk6pFeuqw77u5q13JcgLz73tbYxB8MkN
         kmUUbcJZ7f3+r5w044NY3ZxqHaeeEn8Hdabul0RHInL/UJtW1KM8ydPhc4K9FyF2Hhtk
         qktugwOMP7Sf/tkIu0tBDewld1BL/7hNlldFlF+Dv9CFYQYX+GUEchRBuSldqtCLQFkI
         xpKKAFDMCrcdXdZlU4sBSEFajqgRlCkFOY1QW/RiBHhUigiMjHiNilOUdN7EPBqGdPGZ
         5ApdrtEdnEe4Uv4IARljWDAI+qgeYfp6Qh2q/SqDNxiMgjnEH9GH0oMAuXrv480ooj0o
         4Qxw==
X-Gm-Message-State: AOJu0YyE8aR3oCImZ9nJsAnR9hMssSqv4Dr3y0xL9leWJu3ZAOxvQ5Mk
	sydTzlX7/8RPvxFWNE/n6rNN4KMegZ4Xu18qkWZQj683MQ7soYpu+3TGgdN0tg==
X-Gm-Gg: ASbGnctBr8A4K9lPwTNCMsxclyi+AtmSAS3jE4U9FMALvdj0Co8Fot7KtEvLUTRtFE5
	mJRvpUqNE/6KSuq9s/ShNOLQ0kqBuK9/ecnVZC/aZ+fNw/Ck50t+laPeftCYNkFQ6NCgkBbDMY2
	6HGQYnt6Q0aERcx47GAsLMa56gg1HljEb7TtYEjtPJGKSlDuXcgJ8NucnOq82+i/XKOu+Z4akIC
	D1qWS1F7FX+5L9UDBYlPlLyt3TaEz2x0H4l40I+8QpO63zIC5eKDsTFHpQqemWPKf+jYPdmVe06
	bVuMTPliK9izORX0KIYUGOdKlkkdBeul8JvIIT0PmC8i8WQMi3msM+LTlc+2PwRRcphWN5GRIF/
	p5vSbRWTC72zCpmL8zhKBex0nNtVgFwI5I8WScmxpOtWeqgkT4zaKwb8757pktXRW8JOIaj1hER
	0C8A1aivYrqw==
X-Google-Smtp-Source: AGHT+IHo8rprzs2lnPAlHcfPi3gQ8kIkTHbVdYwaA2RYfhtKfLsiiB/E1MXC3I20/8ZIV3TcLzdQDw==
X-Received: by 2002:a05:6000:26c1:b0:3ea:ab6b:3873 with SMTP id ffacd0b85a97d-3eaab6b39damr2657222f8f.30.1757951010719;
        Mon, 15 Sep 2025 08:43:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3105510csm5969895e9.6.2025.09.15.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:43:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:43:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, Kees Cook
 <keescook@chromium.org>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro
 <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] uaccess: Comment that copy to/from inatomic requires
 page fault disabled
Message-ID: <20250915164313.42644914@pumpkin>
In-Reply-To: <20250910161820.247f526a@gandalf.local.home>
References: <20250910161820.247f526a@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 16:18:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The functions __copy_from_user_inatomic() and __copy_to_user_inatomic()
> both require that either the user space memory is pinned, or that page
> faults are disabled when they are called. If page faults are not disabled,
> and the memory is not present, the fault handling of reading or writing to
> that memory may cause the kernel to schedule. That would be bad in an
> atomic context.
> 
> Link: https://lore.kernel.org/all/20250819105152.2766363-1-luogengkun@huaweicloud.com/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/uaccess.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1beb5b395d81..add99fa9b656 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -86,6 +86,12 @@
>   * as usual) and both source and destination can trigger faults.
>   */
>  
> +/*
> + * __copy_from_user_inatomic() is safe to use in an atomic context but
> + * the user space memory must either be pinned in memory, or page faults
> + * must be disabled, otherwise the page fault handling may cause the function
> + * to schedule.
> + */
>  static __always_inline __must_check unsigned long
>  __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  {
> @@ -124,7 +130,8 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
>   * Copy data from kernel space to user space.  Caller must check
>   * the specified block with access_ok() before calling this function.
>   * The caller should also make sure he pins the user space address
> - * so that we don't result in page fault and sleep.
> + * or call page_fault_disable() so that we don't result in a page fault
> + * and sleep.

It is worse than that - it must avoid a COW fault as well.
I suspect the comment should really be that these are not the functions you
are looking for, you probably want the 'nofault' variants.

Even if the code thinks it has pinned the user buffer it has to be better
to use the 'nofault' variant.

The only exception might be in code that already has page faults disabled.
But even then it would have to be pretty performance critical for normal code.

	David  


>   */
>  static __always_inline __must_check unsigned long
>  __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)


