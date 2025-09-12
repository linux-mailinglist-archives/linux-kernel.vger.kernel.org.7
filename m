Return-Path: <linux-kernel+bounces-813175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71023B54194
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BC8568484
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D532874F2;
	Fri, 12 Sep 2025 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ManN7pm7"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1626F463
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650104; cv=none; b=NR6COLvuYM2Y/B6QtuD1iwsbVn+5r60Uq5YHUmqAMCnZQahRH7L8ajSnRRsht2TqnzsVJzJHlU8MroDT8NkigMNAl1qlEi/0Nbw4AY9qHFXWeRpEviejg3mcnUYbyK7fIux+4y3+soY5yB660Zt756ZQF1F7MCtUAcGdPNi/tPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650104; c=relaxed/simple;
	bh=Nv9Ol6QCsNG8nFcik7Gk9H70FH9gCQn0lEfqy+xG4bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgLseY1iHM/Blj2aK4MF7rG7BWM0O0bobwJZLlBFt6o1DffZVBdzB07vGPJXMd8vu3TYoKYFTFf9NoK4oOhqzg+LwFxxjJpf3vXH7S8kkjx9eRQynv+wuwV0yr5EwRAp8YcJhiO1TllqrUAq9F3NI6XGSNHLpVyzujwZplHtxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ManN7pm7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74526ca7a46so552857a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757650101; x=1758254901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg74TuIEI69uvpd3+KJam3rG3dm6pB1vhxGROySTbzg=;
        b=ManN7pm7xNw4KMHILYa0xyJFaJCbQzCdNQth4bXDQIe+SQYM0SUWCylMMrpnfd3X5o
         vrSbp5FQQwoFkQTjGYwjU3/CBi4KhlPRp4o3X6cdkJ/U6vsTbai9MMsR8lLSpM6qG23y
         SeSAYEfpyLPDYw4OzAFg0D1nWR3uQgtF3WqcpCU9v2reHVKzk7s6XxWcRuZIppSg/WRJ
         5OclvC31upeAp1KbbiqdcEU0LynKZ2OdEAXjde3dxEjLuU3ZycNe/NkxSEsJLPxqKH0y
         UQPxu13iBnBbbRLJmj7rtnZMB2BW7Sv9cVHW4yOwsq0+xcQa58rdvM8E4a/CrzTKLhrV
         PKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650101; x=1758254901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg74TuIEI69uvpd3+KJam3rG3dm6pB1vhxGROySTbzg=;
        b=n4qLD4UV0TJnzWt6Dujx5CmYb4iVZf/kCvOKvP/YhTJIyQm7w3tn/QZYBDS+1EqcHx
         6MjEQBotiI7RA5l4zFesdbe19tzajN9HkwImaNIxleDXHeAM+JPveu8KJJW2C8PIf8Xk
         2DYu1AZDV2ugKQ+uhXvxXsWnFpBizvQ2YI1abGiD6SDoeSgJ7wl/YzGfQ0PJB2Q/zJPt
         ZdAP0/7wfSLsXwGJua8BN4h9mh8cV6PsP5/s30I3DhGZGr4ym9QmbsdFx/JHXSkdaEgS
         xy2a1Un27AIzpEwg8Xs1feb02TV6yBUUkakEujETdPp1lAjC+/JNGcGxRt4EI3CTLUhy
         gCsA==
X-Forwarded-Encrypted: i=1; AJvYcCVshkM4kRtgl0rGdVrqAJh3lPUvDKbjKtBIuKn5VbofH7/VJ+uJZv5gagi+jAE1zkDaa6gYBQbPK6h5CbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgC5wWBq0fjD++3GITTUJRCONqR8aotDUhq8Ho3cdXgX6/UTTl
	OPoE6cXqZbwqGngxzLNrPpKLnSJcQFTelI+kQVl/XpSRRdEnbZlIdXIy
X-Gm-Gg: ASbGnctGnyHf5g70W41a5IBdYjy0YwUrzSqA3OWFGij2NqZzG6YU5cJ8QhFzREJbrg6
	16IF0o8Qi8osYIlusBBGjUpWR98Dfj7DmQFOKg5aeGyRKPdrUgGQmcHDQSGAJkKgIR2tnNpfp2r
	on0srODVMdYM5KXE8oUKNptz3MpZInGrNdoWAOqSv66GmKlraPt7wTNVNVE1fK1d9iWcMNKI/hJ
	0SZDazdXnb/b6loXpSHTJn7/kzpSfu2fqXV48mdrmBQiTPB/jEmht8sPEnERn5ueNEvuGswiEBQ
	+F+zLcy1tXAS3JH3pnj9J+mFE2nTr4c3f+YBDm8H8ScnVZk7tew9RgjfE528ItM/AvGZ27hhZIS
	W2uXPfC+z/wuI3CpOFoaj/QxBI9o8qkQHTW5YzI/LOOledVG/gTj38k2IedNLLwbOhDLXwCGaiH
	q41L1x2fki5dmq/lgawdQ=
X-Google-Smtp-Source: AGHT+IFpdUTO7PRVbu6OteUBib7yjiQAfePZPl/rwNk1bMjyuwnjQurngem8tCG0KGrPLsLfCE+Scg==
X-Received: by 2002:a05:6808:3208:b0:439:af0a:dc8d with SMTP id 5614622812f47-43b8d9f6c3amr680522b6e.38.1757650101436;
        Thu, 11 Sep 2025 21:08:21 -0700 (PDT)
Received: from [192.168.86.41] (c-73-136-245-43.hsd1.tx.comcast.net. [73.136.245.43])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82abafc6sm599323b6e.25.2025.09.11.21.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 21:08:21 -0700 (PDT)
Message-ID: <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
Date: Thu, 11 Sep 2025 23:08:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Printing with overflow checks can cause modpost errors
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Miguel Ojeda <ojeda@kernel.org>
References: <20250911213157.GA1039411@joelbox2> <aMNo7qRCp_yprUAW@my-computer>
 <20250912025343.GA1376629@joelbox2>
Content-Language: en-US
From: Andrew Ballance <andrewjballance@gmail.com>
In-Reply-To: <20250912025343.GA1376629@joelbox2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 9:53 PM, Joel Fernandes wrote:
> On Thu, Sep 11, 2025 at 07:27:26PM -0500, Andrew Ballance wrote:
>> On Thu, Sep 11, 2025 at 05:31:57PM -0400, Joel Fernandes wrote:
>>> Hello,
>>> Recently some of have been running into modpost errors more frequently. Ahead
>>> of Kangrejos, I am trying to study them, the one I looked at today is truly
>>> weird, below are more details.
>>>
>>> I narrowed it down to the print statement and specifically the FFI call to
>>> printk bindings. This was first reported by Timur Tabi on CC.
>>>
>>> With CONFIG_RUST_OVERFLOW_CHECKS=y and CONFIG_RUST_BUILD_ASSERT_ALLOW=y, the
>>> following patch when applied to nova-core will fail to build with following
>>> errors. The question is why does the overflow checking fail since the
>>> arithmetic is valid, and why only during printing (and say not during the
>>> call to write32).
>>>
>>>    MODPOST Module.symvers
>>> ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!
>>> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>> make[1]: *** [/home/joelaf/repo/linux-nova-rm-call/Makefile:1961: modpost] Error 2
>>> make: *** [Makefile:248: __sub-make] Error 2
>>>
>>> Any comments or thoughts?
>>>
>>
>> Io::write32 tries to do a bounds check at compile time and if it cannot
>> be done it causes a build error. it looks like because a pointer to
>> offset is passed across a ffi boundary, rustc makes no assumptions about
>> the value of offset. so it cannot do the bounds check at compile time
>> and causes a build error.
> 
> Are you saying this issue is related to iowrite32? I don't think so because
> the issue does not happen if you comment out the pr_err in my example and
> leave the write32 as it is. So it is something with the call to printk (FFI).
> 
> Why can't it assume the value of offset? All the values to compute it are
> available at compile time right?
> 
> thanks,
> 
>   - Joel
> 

This is a resend because I forgot to cc the mailing list.

it has to do with the FFI call. The value of offset can be found out at
compile time, but because a pointer is passed through, the c side could
theoretically change the value before write32 is called.
The pointer passed is const so rustc should assume that the c side does
not change offset, but looks like rustc does not do that.

as a test i created a version where a copy of offset is passed to printk
instead of offset and it compiles.
e.g:
// SNIP
let offset = <B as kernel::io::register::RegisterBase<$base>>::BASE
     + Self::OFFSET
     + (idx * Self::STRIDE);
let offset_copy = offset;

pr_err!("{}", offset_copy);
io.write32(self.0, offset);
// SNIP

Best regards,
Andrew Ballance




