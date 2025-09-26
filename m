Return-Path: <linux-kernel+bounces-834160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5EBBA4135
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218E8172BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1DE189B84;
	Fri, 26 Sep 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ameoJ0Qy"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679634BA4D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896119; cv=none; b=B1PAbdl0UvEQlJ9XmDjdEl6AWHwszQDiDbuHLRk5tbhaTSSg+y89Knak3Lh3nDUsxpSzfuMknOGzhjseezKqtVpkOVEU8dRb/qXYPTOdCdNtrTGgOODo+62lMaeyMeTP3wDNfiH5CiaGfxXuTOBW38DeYLSSQPbfZlYPeLOQ8h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896119; c=relaxed/simple;
	bh=3EuETjGS94VA9aX1L+3DRTzif/UOsqRmcV3HKUoNVKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG3gflB/ghK5JLxQbi8AusvDakQO1S2w6e4mKaDv5VFS6oY8+6cO6EPo/kmQ13bZW+MgYXsi1hFN4JaUH6FmXHIsAI4Al5u7a2KXoBB+JCaDSOuHn86o0/gTOAFLDphHfVuzEgC+iA9msKe2fxYcCaC574N59VXXSl3xfuuIlCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ameoJ0Qy; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b2ef8e00becso454750066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758896115; x=1759500915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9jZmPeMSTNInBGycjXauMbuTyxBMkKpsato8i1eTnM=;
        b=ameoJ0Qycx/0+QjPvGr+LDwGVVraE/V1UVIic/seWKrq6LOceRbI8BSiND9lIm48XR
         cX3MYEZcw85O8yiLdJYt2Pu8jo+Wzkps+sTq44hR+Ya4OIEWDVaeJdfTNNEm/e1/2Cyz
         uofFHOjsO5etdGv+dmxRniHc/gGWmy0vcLn4M35Wx0Gea5beSqgL+qP0PGMWy0zMyZ+/
         vOiTZElbPpk1xd4pEFaGHGSco0FG/+kgJOEN7YsHaGy6aR0+tT8og9bxHs/V9J8wx33i
         lTBxLx2hfpCWUMFF/YOslA3e51dZg+/sGGICfXH7wYWyr2czcE6HnhVAozAoR7WxL2b7
         6g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896115; x=1759500915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9jZmPeMSTNInBGycjXauMbuTyxBMkKpsato8i1eTnM=;
        b=Ho6+dO3qK7j6mvaQSw5lbWV4vaT3vAyg4GmP4hYogq/dKWWzvMC/SOScEixcauhY+o
         s/kKvudq6kg24DNAwmFrZ8lfKdHYUV38IJNx6U5aIbhMm4/8yUoWnoWdVyO1DnNhRhjL
         uP2dQbQGLWhMKxlbQtBaJjTEGPT1vtVCFe0xeOOsUd+UGN0KtjoQ88wKv6OEHNxXyo7X
         noTJyMr0qeeYZ4QJIxsKw7vOHco/s/SFWQqqOgrPbNnK/orx1YJnke7RBy+E5fo38QzB
         FSP6wMPkp3yH+LT2gPZfOF7aI7eM5sVdDlsMgzUNGEfo2d3rQQyeMPTfsuzFr8qZehxt
         MxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9j0HVN0Krx9dl/hlemrd6TMJtiNhpVgD1sGGmoJhuZRZjyjhX5Lgsd/AVAOT11+FqkH7/EbYIc4F5+CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ82quQGgVd2WkWDGeZ4NLItD6mnAf+hIOp6+XkzF03byE344Z
	KuT1w/qsMwh8fPm85WLStjg5LXi6hw7y4hlgmuoOfDo/G9imuZnkVCCSGhYMQYtkxqYFnvdNXbT
	ywB4ZJJeZWw==
X-Gm-Gg: ASbGnctrCtSGTzmNuKqrgFbQYmBH6ieoYa02Pfb4j36kHjN3e5o5DbsLqZQCiRBbbfK
	E6Q4/1cicwY2WArrk/B+My+5R5THmL4DEmUbFbl3YP8ZsMqLZxY8iWcAhEsQicyBaFuOflqaN3U
	UxqH5wXcANOVJylpEO2u5MCLOOrr+x/HP6yOc3wF0n6Tz8lCTHIGB/+OParO8Yapm4REbyZpuvf
	mQHL8j5B1CyAaKPrE2VvFDLlAnkESAw5+EFErWBs6jwaCfBzH4IO24kgrZxEUt+bc9huIEIQ09Z
	mJ0ZgUEcxWgLQeMdDVsFLoqZ+3Jrz3+0DBklkYOZKJ1ZOVWlSr6vsrQKMHQP6fpn2XpY1ZZ+gkl
	noxcH7/uoJXgcBZCx8yld2lqOd0Wxe/gd2M9gMOAUu2JjJoAeI30=
X-Google-Smtp-Source: AGHT+IGK/genwtI1bS4PRqRq2vjmMCZw3FLLLJgbkQJTVuUZJctxfJL4S1XrBwD0AtlzfdZMtXRaOw==
X-Received: by 2002:a17:906:c14b:b0:b19:4e64:4f1a with SMTP id a640c23a62f3a-b34bf370078mr830417166b.58.1758896115333;
        Fri, 26 Sep 2025 07:15:15 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fcddf1sm380305466b.77.2025.09.26.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:15:14 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:15:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniil Tatianin <d-tatianin@yandex-team.ru>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1] printk: ringbuffer: Fix data block max size
 check
Message-ID: <aNaf756eQ6qZCmCV@pathway.suse.cz>
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

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

The merge window for 6.18 is likely going to start the following week.
I thought about it and I am going to push it there even when
it is this close. The fix is pretty conservative. It gets a lot
of testing using the new kunit test. I am pretty confident
about it.

Best Regards,
Petr

