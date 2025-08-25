Return-Path: <linux-kernel+bounces-783850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64901B3337C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217A0161DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709B1E8323;
	Mon, 25 Aug 2025 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fv8poAOP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E412139E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756084865; cv=none; b=qjoAcydJOhqLwwftLRNV9dWoocUUs/LOPYkwFqiHadp19aC3Ec5T7RoLxj4Uw2eSS+07OoHztvNi9gBtjeWuISyhBWP+VQyPEa8pPfCPX8HhLeHtWq9wqiq5Dbpp5otOmY9BqaeqfyS1cDre7AC84mu57w+zT+Yz0TjsLX49KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756084865; c=relaxed/simple;
	bh=TO3A6bjCHbGdi/5TXUkYM/A6hXHPY42uIK5Jw3agUVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsBUyjkYwf6qmXvTe8mHtHpZrsNHVdTXbybynAn7gHrk36kilXdViPEMBZdNgZyR5qygTv1zBoWORlTnuawDGRlAxzOP8qg0EKPUc/RfEyHRgPFZr8lfkP3zvLu+8ZERCJmVKfi7LTP5qZZi3VTYtRNSt1il97RZ7Z0JGj6Y7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fv8poAOP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756084861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EN6ZzdP3i0zcjEggG2p78XDuwapKqNbwvZSSMTRqchw=;
	b=fv8poAOP09ePEOam6WkJGJ4hNWiI150mce3H47cnYXSugmppI2tFBUBrp5qKWsIwiHEKoC
	9BorRQ0ro6RjTIVBDvdBAh3CzjIrOWItGyVmYYWMeGJ9cM3JKiFNKTFNtjDQ9Dl3rLNVZC
	0wi4iMJZaNfJHBM7VIWPRwTUUh/mMeQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-tpLK9gV8MjGxXWcjvxcD9g-1; Sun, 24 Aug 2025 21:20:59 -0400
X-MC-Unique: tpLK9gV8MjGxXWcjvxcD9g-1
X-Mimecast-MFC-AGG-ID: tpLK9gV8MjGxXWcjvxcD9g_1756084858
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b471758845dso3323856a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756084858; x=1756689658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN6ZzdP3i0zcjEggG2p78XDuwapKqNbwvZSSMTRqchw=;
        b=j8oEEpAp6vLFXjYJIfJXCTUM+lwhZv8B0JurR07q0yz40iDlIBqdrH+T5dvz0lOggy
         5viOYK3DD7aArC+7NO+cBif9KxUTjHEUHD++XGugBwbl6sqD6B92xci2c/x0aSMDLkdB
         IHeypk95RItVk6YRTT2PQWtJ5cXS86E/0RKriOhcjavB/9AuOWC7SLtFArFzDXbBrOmx
         F5laxxXepQxaiFmUbxvpCJ6M6QVh7/DbtR20mYBV89sl+NMCMWdKhZgKPcd6jr59AT2/
         ayj9psZusvwWoKobMINxLBRiocate+vx7jZci5YgaO3IHZLHkkJFUO3pwz+TR3woel6x
         KuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtniy3/4TyDzaKwHo7ZlKyIwFf5OWuBR2hFeK6/EMoyxIETZ2oLYZAccyYvjcXRcgmlQZB4rdwnXqRF+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiO4Go8K2zi7VCuFD5Kr6J7J0J6bMzC03oXGTNYZAs1b1176qb
	vOZS22aU29Q97VYCc9hoOipe23ChJ1RBdkNosARFxZjCDh850uxrgv1ngBveYROw7ggPkoSYfJo
	I9hekO3LPdMdkUYdaav4R9vXfTej+iSHzOF6gkKxnbbiEOL2DPVZppcoWVxJd+RzKvg==
X-Gm-Gg: ASbGnctjtUdDKbgpQcv0RFbL4jCKyPYw2rxSO+n8NwDuRZpp7/ulLTosymCBo0krm87
	2NnWum4zSTPAMy4l8WRz7+Y1hxjP7Ufo0GMChKVXomgUjS1t9PwJNTLLVuN+ajthBw+Hu20zjAy
	klLxbXBlriZazrrEmhL10FTTM5InZRWEzfypgReaHEr/BGWyYCmbRRkT6v4hPL4ugEyEkOJPe+c
	dFxHGmj8sbMeDxsFLnaw5g/mfoofMA6jvvHmCkKmuEinFltglGr4hZxeGBQwYzN8UI2fKLYv4rk
	JOhS5Mf6MQ5lq3bS6KS+crNwgi+tC2Y=
X-Received: by 2002:a05:6a20:7d9d:b0:240:387:cee with SMTP id adf61e73a8af0-2434081ccd3mr14767781637.0.1756084858450;
        Sun, 24 Aug 2025 18:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ52vj5/0XeOFHIZn6b33Fi9CgvtFLe7y13b+QMfcBUf40D3kWJXZtVu67hRZNEFoDn1nUGA==
X-Received: by 2002:a05:6a20:7d9d:b0:240:387:cee with SMTP id adf61e73a8af0-2434081ccd3mr14767754637.0.1756084858035;
        Sun, 24 Aug 2025 18:20:58 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb98e8asm5143369a12.38.2025.08.24.18.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:20:57 -0700 (PDT)
Date: Mon, 25 Aug 2025 09:18:53 +0800
From: Coiby Xu <coxu@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-ID: <yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-2-coxu@redhat.com>
 <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>

On Thu, Aug 21, 2025 at 04:15:53AM -0700, Breno Leitao wrote:
>Hello Coiby,

Hi Breno,

>
>On Fri, May 02, 2025 at 09:12:35AM +0800, Coiby Xu wrote:
>> +static inline void kexec_random_range_start(unsigned long start,
>> +					    unsigned long end,
>> +					    struct kexec_buf *kbuf,
>> +					    unsigned long *temp_start)
>> +{
>> +	unsigned short i;
>> +
>> +	if (kbuf->random) {
>> +		get_random_bytes(&i, sizeof(unsigned short));
>> +		*temp_start = start + (end - start) / USHRT_MAX * i;
>> +	}
>> +}
>
>On arm64, I am getting the following UBSAN warning when accessing
>kbuf->random:
>
>[   32.362428] ------------[ cut here ]------------
>[   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>[   32.362649] load of value 252 is not a valid value for type '_Bool'
>
>and line 210 is your `if (kbuf->random)`.
>
>Basically kbuf was not initialized in arm hosts, and probably has
>garbage.

Thank for explaining the problem to me!

>
>I am wondering if we should have something like , while the support for arm64 is
>not done:
>
>commit 2608bd8c26b62a9a7cc50106e93d3a1ffb1e1188
>Author: Breno Leitao <leitao@debian.org>
>Date:   Thu Aug 21 04:11:21 2025 -0700
>
>    Initialize the random field of kbuf to zero in the ARM64 kexec image loader
>
>    Ads an explicit initialization for the random member of the kbuf
>    structure within the image_load function in
>    arch/arm64/kernel/kexec_image.c. Setting kbuf.random to zero ensures
>    a deterministic and clean starting state for the buffer used during
>    kernel image loading, avoiding this UBSAN issue later, when kbuf.random
>    is read.
>
>            [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>            [   32.362649] load of value 252 is not a valid value for type '_Bool'
>
>    Signed-off-by: Breno Leitao <leitao@debian.org>
>
>diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>index 532d72ea42ee8..287b25e674d76 100644
>--- a/arch/arm64/kernel/kexec_image.c
>+++ b/arch/arm64/kernel/kexec_image.c
>@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
> 	kbuf.buf_min = 0;
> 	kbuf.buf_max = ULONG_MAX;
> 	kbuf.top_down = false;
>+	kbuf.random = 0;
>
> 	kbuf.buffer = kernel;
> 	kbuf.bufsz = kernel_len;
>

And also thanks for posing a fix! The patch LGTM. Can you add a Fixes
tag 'Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf
randomly")' and then send it to kexec@lists.infradead.org? Thanks!

-- 
Best regards,
Coiby


