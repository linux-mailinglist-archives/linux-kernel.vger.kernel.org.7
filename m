Return-Path: <linux-kernel+bounces-753290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523CB18115
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0131C82958
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DB24888A;
	Fri,  1 Aug 2025 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDgdEe6l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BDF2459FD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047613; cv=none; b=AgyljS+/5tM0qYN+xoM7Oc2EvtzhqF4zceYBmOC+/BTr6X0jW9BQzLgAhN5kl+4T8w0xFzZD/Q4iWuykg1StjsPV6qS14cBATgJ+qE+g+sQ3j0RvhmZh/o2Ebb5tgRN1UDBkUOawYCP5cJgKV/0M32Ap1iqt1kIBwdupi+y27BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047613; c=relaxed/simple;
	bh=4xyQvpgC+I9+1Qp0FJ9nuQV679QR/nFwxzq863jh5tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrUHa11lJWGUjptswBI5omBNkLbKCcpwAki59HOm8m9wmCFw0DrJIKaYACROdCb5q2hy7/rwPVx0FUQHoW+RHrygxo8Sdcb3yNyS+8W7QVaqsJpDLMnrWliiBI5XjNb8RWnk47eoJ9AdLsPQHzQ2EdRiNfhFUFkOwzFb8HS5jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDgdEe6l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754047611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pHOprKZ6PR/GAM6prd1YkB5yUEoiTGeLa6WoyKyn8vQ=;
	b=bDgdEe6lqFdnVA/DgW6VavNj22Iz1y280pcxRdXZiWdLeYCCtfqwatt5ah2s/7hUzi/Hl4
	PU6lcHDGOf4b1cHeBBKek4Xkqxn27FMGJ9HxkZ2HiYR1TPbelohUUR25g/gCI4FnZ+ppnh
	VbpT2Wgi8Y1t/Oz/UerAjduuEU1ea4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-vGQyUVr2OK-Si1IdqxAvXA-1; Fri, 01 Aug 2025 07:26:50 -0400
X-MC-Unique: vGQyUVr2OK-Si1IdqxAvXA-1
X-Mimecast-MFC-AGG-ID: vGQyUVr2OK-Si1IdqxAvXA_1754047609
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b604541741so419715f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754047609; x=1754652409;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHOprKZ6PR/GAM6prd1YkB5yUEoiTGeLa6WoyKyn8vQ=;
        b=lte0RSeWsB+z4JDWi6Ns4Ike+wv0XLAwuCiaD6K20ASVlu+vxmFNhzZAhoYaY0QzYH
         UpwgINSlL1Bc7FUD4KwxyZ0V7CvWD5q4w5YOwLtbpmYar1vT+L0z/L5AKD7xn1OuApDK
         6YAg63q/cfDvE7SsCLPa7sEltVqtYotA/O1m0obn1k7Uyckz8166Qxq2Lxsu/J82fLFR
         aikxCA/gzen4uOTp8LbaLGC7Yt52BI2qLv8Q4PxpewHXg/KlkXa4aKKmxqEnqAsykzJS
         N4HzydlZPkSGv7MKFfBmHekOC/JtU0OyIU9luLNCdwZVyuS2mnUJUUUQtdDp82g6vCzc
         3hrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtUGrULFJNifNn9VRIAHPLCe1t5pqUlgbo0BHAJVJx9hdfMrbU4FzbdjJXs4R2a7Ir+iVMnna9iLZZ97s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx164yH3uIHmrHXAxXdJNf0FGE6C64zfwswVruNIDxHuI0CAngb
	rxFjuR52w8wNvq4YRE5RH4hm7yOloBfrqwg5lFeelDpjYsNyjuhdJaV/yHzNptp3s34MPUetyZG
	rrSFjHSK3Vz+Nh1w3DbHaS3zmzxgqstNyikmXsSvAiDxesnXp/WhjnMqB76doxPn8sw==
X-Gm-Gg: ASbGncs8wKxrYIukQ0NhOvSudKfKuWGrcY5ZEh0kuW7yfxE01EbnIsf8S1L8nBQUWSU
	8Q9+ZVwU/CLc8Q9PN6WpxatMVpaIjUA0vRIJADGmw8MD+jS9Pg7b0fEGhrTgm6F9dQYIJtlS5O/
	wDoKD6FhU2UcUD+bzhNHRAXzp7/vJ3ZRE/RD/tALoeKc1qNN77bTI408LJm6cc5DlOrgc7GsCjY
	jU+/xzqQV651xm2C3So9LkC1A3AehTghASb1UCFi7wOVHecrq82L4AMFep5rCbmB/tY6oMd3b04
	azChPvvxAgulEawWHFKp/crx7sUp/OANnXeNz5LpWn5lUTj85t4FA/PMTorg/eRl8wUJ1LcwP8g
	wnw0=
X-Received: by 2002:a5d:5d07:0:b0:3b8:d7fe:315d with SMTP id ffacd0b85a97d-3b8d7fe344amr350944f8f.34.1754047608606;
        Fri, 01 Aug 2025 04:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRBJH9g8fRYAfsc45Q+0l1Ggbop+PWThVcIfuhi55RsC2803vYJ2GW5q7gTx71Z8MzzyOq8w==
X-Received: by 2002:a5d:5d07:0:b0:3b8:d7fe:315d with SMTP id ffacd0b85a97d-3b8d7fe344amr350926f8f.34.1754047608152;
        Fri, 01 Aug 2025 04:26:48 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-086.pools.arcor-ip.net. [47.64.114.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2848sm5473887f8f.71.2025.08.01.04.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:26:45 -0700 (PDT)
Message-ID: <bfe5477e-7340-468a-af3f-192adc451c2d@redhat.com>
Date: Fri, 1 Aug 2025 13:26:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch/x86/kvm/ioapic: Remove license boilerplate with
 bad FSF address
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spdx@vger.kernel.org
References: <20250728152843.310260-1-thuth@redhat.com>
 <2025072819-bobcat-ragged-81a7@gregkh> <2025072818-revoke-eggnog-459a@gregkh>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2025072818-revoke-eggnog-459a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2025 17.50, Greg Kroah-Hartman wrote:
> On Mon, Jul 28, 2025 at 05:36:47PM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Jul 28, 2025 at 05:28:43PM +0200, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> The Free Software Foundation does not reside in "59 Temple Place"
>>> anymore, so we should not mention that address in the source code here.
>>> But instead of updating the address to their current location, let's
>>> rather drop the license boilerplate text here and use a proper SPDX
>>> license identifier instead. The text talks about the "GNU *Lesser*
>>> General Public License" and "any later version", so LGPL-2.1+ is the
>>> right choice here.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2: Don't use the deprecated LGPL-2.1+ identifier
>>
>> If you look at the LICENSES/preferred/LGPL-2.1 file, it says to use:
>> 	SPDX-License-Identifier: LGPL-2.1+
>>
>> as the kernel's SPDX level is older than you might think.
>>
>> Also, doesn't the scripts/spdxcheck.pl tool object to the "or-later"
>> when you run it on the tree with this change in it?
> 
> Ugh, sorry, no, it lists both, the tool should have been fine.  I was
> reading the text of the file, not the headers at the top of it.  My
> fault.

By the way, is there a reason why LICENSES/preferred/LGPL-2.1 suggests only 
the old variant:

   For 'GNU Lesser General Public License (LGPL) version 2.1 or any later
   version' use:
     SPDX-License-Identifier: LGPL-2.1+

... while LICENSES/preferred/GPL-2.0 suggests both:

   For 'GNU General Public License (GPL) version 2 or any later version' use:
     SPDX-License-Identifier: GPL-2.0+
   or
     SPDX-License-Identifier: GPL-2.0-or-later

That looks somewhat inconsistent to me... Should the LGPL files be updated?

  Thomas


