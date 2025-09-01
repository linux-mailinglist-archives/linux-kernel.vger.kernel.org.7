Return-Path: <linux-kernel+bounces-794041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41891B3DC04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE7317D0D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA72EE61D;
	Mon,  1 Sep 2025 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PX++ZFI4"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444E2EF669
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714214; cv=none; b=B/WZ16sczcTUZkYkauzpTVxiZsH7g+b+c3KLEnhQowTWUBGtiGvlB+/4rzuGhV7RrHzFGu4ks+NYPxQTMdtRkurEfw405zU4LuY2L6AMXMdC/9J/Uhk5BtqgGBVvVOl98um1fE6M3dpjOBxOFDSXSM1EMQBw4ae9lieZMaOqGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714214; c=relaxed/simple;
	bh=GOCVLxhdyYB7KaTBpnGohfzlE7MskSwBmBSwBfVdmPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FquuVoFFLC/gX/oh2d5AofyKmYbdt5oyel/Z9/4ZXBk+o1kEn5aFANwsk9+Nr4AUGJ3o57ELFCF1jx7QHVYv749XTHAe4cWGM5pSd2Iftt8Ab1vzT4jIZnXQyXaiYM0S+q+04/2pp0tOFg+0uI1AHo44KhT44JfzCBvAumEZp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PX++ZFI4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so27038615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756714210; x=1757319010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ld30nTWYMhblb7gZbUBZiYF7nWKNCb3Ye8OVN8o1oUM=;
        b=PX++ZFI4dwx27P7vBf1qaNN+xcqCj3MdpvkIX+x4JFS75Ea7qIpqx/BzMHpQIG6jmc
         FgPsE8LGtQalEoILuBH2Rdd9ikd04NCC8ozDqwCNs39WeHSiiwDdsLlWvaW2Dr4aXbMW
         TX0Ez/8NSCVyzTQSsXStp0xIvP1tH7qXgAdiwJAVSHGjhjHRudRiNfRpYYDlOamfJpJe
         vqAFpsInIA75Ev/tbgokwqPg3IJ9vwmoJzWv7AU9nMZT+y/VXnnFEj4JC8NLcBoNU9Rb
         snpwWKp5GAv/gVnp18cBm5iAuP/WiYdJCrSLiPMZQdD4h8Rqx0ollAQO1fvLg+Y3PNWv
         gLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714210; x=1757319010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld30nTWYMhblb7gZbUBZiYF7nWKNCb3Ye8OVN8o1oUM=;
        b=HyCk3RRp/Zcu+Rz29zQhjdoK8Bk6nyf7kYWBUXPBKhrKywFqMj/fW8o0HY+QiUTJGz
         w42j0pQvZmYfdmExl5QXJdJDIQh3b7ewa9i4TOunQcPwzuN2xvFD1wpVod65RKIxOkQg
         R2O9r3IzTW/piXD81UoWc24q/0fDPneKBW5qxR3wus/MRWtTlqDWSLLM/6NcKfPYmLx0
         yck7prtAylTK6qeGwidRXnCtTrPUT7EqI/jK1l7dF9D1uaIKLgoZHu+X+g2JbuHK5jNP
         xb0ZlmnIY5XwD7qAHGZq0+wA8wMxMu+lOL9qTXaDYxVzQsDac42u8Pi8j326GTeu62Jn
         nGXA==
X-Forwarded-Encrypted: i=1; AJvYcCVsCyG23hfXXfOMVtHoG7NFqaFvLCXK1dCswiq0p5mNcLReQhUHSybAtyrBf7wQ3PV6yy4O6QdV9JHeI58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5cprLn45AoVYtfBsxhQWhKu0hEO7A8C43Fyiq9UNNQQh84WMR
	t8Ai5+XNug1XiTRQU1rUASPakiSw5clf+D87X1mDhAwt2YbBGLOstJPlRAuylte3P7k=
X-Gm-Gg: ASbGnctK6SgS9sD6Gt/nU6ykguSPy4KmA34S1F6Rq2uVsMc6hQe28RbTJhP3QxVqyc9
	LW7YFkigRbp1GtL6j2mLOfM5SrvbworK4ZiDCjk27RWuu21YQ7J/c5NqeKu58vTwpd3FPWT/kwl
	VNJK6IJarKwYxr+FJQy4rdVnPhNoTEGfPIermTTS5IbuqVc0zerj/fv4MhZ2k51X4La60+H45Ut
	WeNB3Pd9aDrznTHiN3IM1QETzIc1ObtBX9e/c1y3VoJ/XMNCBiRmcvR1dYQxuE8m2EqUw6JUUHM
	zg6RNGrICRlUenS2srS8Pzx6Tp/ReyUKpp6yspt9g/PgzLYiwhzPA9kWFd9VC/W7vpURWl9tSKG
	Um08yRZyXDsu7ie1Yg6hgbY7GQq6lAaYipNXkNVK5BN8HsceXaLZtBmN4VlYjg+uIAFPQcHdpPZ
	yei41uyJTyK6No
X-Google-Smtp-Source: AGHT+IFigpnG6jSn9yL+4Jz61ciZdSSt/rFedQBnVnmzRAOzSoonxIGGForgO4rBsT1YENgNggKTkw==
X-Received: by 2002:a05:600c:350a:b0:45b:8b21:ea9c with SMTP id 5b1f17b1804b1-45b8b21edc2mr34394895e9.36.1756714210317;
        Mon, 01 Sep 2025 01:10:10 -0700 (PDT)
Received: from ?IPV6:2a02:3033:26c:df97:bc62:c66c:7bc3:9ad5? ([2a02:3033:26c:df97:bc62:c66c:7bc3:9ad5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm142484965e9.10.2025.09.01.01.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:10:10 -0700 (PDT)
Message-ID: <86eeee11-38c1-4754-b72f-7606b137d426@suse.com>
Date: Mon, 1 Sep 2025 10:10:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: storage: sddr09: move write buffers into info
 struct
To: Alex Tran <alex.t.tran@gmail.com>, stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
References: <20250831192247.1120619-1-alex.t.tran@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250831192247.1120619-1-alex.t.tran@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/31/25 21:22, Alex Tran wrote:
> +static int sddr09_init_card_buffers(struct us_data *us)
> +{
> +	struct sddr09_card_info *info = (struct sddr09_card_info *)us->extra;
> +	unsigned int pagelen, blocklen, len;
> +
> +	/*
> +	 * blockbuffer is used for reading in the old data, overwriting
> +	 * with the new data, and performing ECC calculations
> +	 */
> +	pagelen = (1 << info->pageshift) + (1 << CONTROL_SHIFT);
> +	blocklen = (pagelen << info->blockshift);
> +	info->blockbuffer = kmalloc(blocklen, GFP_NOIO);

there is no reason for GFP_NOIO under these circumstances. Please
use GFP_KERNEL.

	Regards
		Oliver


