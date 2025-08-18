Return-Path: <linux-kernel+bounces-774325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B516FB2B11D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF2177A45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471131195F;
	Mon, 18 Aug 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E2Akqu2k"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1A34320F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543579; cv=none; b=LND672auxTIL0IRl1E5CihuUF0iIhex/F1k81l3TVB8UNpGCTMQ4nhKzmP73M32KY2vUfYTIXXnGeo+ahbVTSTSg7thGLadVLRTq0tDvx9/1RkzceoC5UFIBZcOLAkWBWmxGHs9pGr3C7ilH+HJenTmyan8uJR0GWrTPZ17Ww+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543579; c=relaxed/simple;
	bh=TKCCw8hxZx4LVNHBY9YD1eV99l6dol3ZQ7qCTmBpYeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dMWcvkaHQoTAAOrJpg1QDjVt2N8OGAh+G6RERZzCHwu24HFM4P9rFGfVnY5oJaf/X/B5xwOW70V3VytqX69Y7ZCKRxRkYaxBUKvy8a533VpWYsNNp8O2IhSj5NVytEE5SV1P/v8UdLuGwSgLIHHbkslY+GE0gHaZRSjc5SNCNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E2Akqu2k; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30ccebab736so3851800fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755543577; x=1756148377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GlFt92LPhKKS01GxFk+3B9rLETOli+lTNFbApZNS7uE=;
        b=E2Akqu2kdKqk9LByI5Mu41SCz+cFCC9vdDmIV7ZMa9cMEfRd7Ix8N3ZynKHiPGgwZe
         fN341G57r1thuKx2q9L1/yB0o070LUdlqWJZ8jjjvDkgVCaWNeTjkoJ1iQ9k2DqNllQ3
         zGbzfpS+CzQoe5L/kHaCPyGE2zIXBRmf+Zl4JJucAXd8t4W4ddGmtA/VWEfQ2tXvIi+D
         6ZUvlgfBUCLVFXx/w1O8dfsODQYa/w9ysfGFFkG48nCQMx3EkQJx+F5FE6nRN4J+DL7K
         XcH2ENmeWLUoJ7r2mOW7I/eDKaGqfeZDaOViSnYyRgvHjhCuEoq3uDvGjB/h6gYZ/vYS
         WPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543577; x=1756148377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlFt92LPhKKS01GxFk+3B9rLETOli+lTNFbApZNS7uE=;
        b=O7AgyCkBYTeqLgjqKpCL3DoaI/I4pHmh4UT3yvw3kZOBY/HQmUYZVLMolr1jaAleHS
         ZpgxfnZwaTebQcnkYYstFr7uHbdpSTu/i9tzCPdxvckqrIQgGLC3/+4Kk/oJvnhv10Ow
         21itgjikW0a/ItYQwG/6YhNFuSmF81/b0Q1LHXni/gPWTZgdBE2QZv5GnTek0dcZrQ7L
         XUsRoZfgJIwPe8mlh3E66ZXR8vZK7Mr9EZFszuJpohfbk1PoSXwweQxfwvhRLoRlm+/x
         MhBQCcBR5oKEOLe09pSZJ8UiGTho2paszaFb9aP9xGVVwpcOK8EfZKjNFcKvCNgX8OHA
         RdZA==
X-Forwarded-Encrypted: i=1; AJvYcCWYXLw6h8HVJ5impZ4y34eWeqoTVFYOmdHPzgANqFdgJrRiOVTlDbDaoQ8Rlqw2J6+BZb9L52gq6kJ1niI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BbUplPAYLkT/SwHhqOF3HI81sCpS7KxntlMXCkby/OQnmXOS
	huOuJKU9ki595OlQsrc2oleRshgyTg7BnXmRyukS1rjxbxuxjX9yo7Aow02VT/fP48c=
X-Gm-Gg: ASbGncu2jJuAg7aLUFpS7ZKEbbu8AvvqhVcQuwXjW9A9OTS+mI6ICLY1SIpeibnix7s
	w9CgU/DuPp+3bU3KiHY/oTZweCSsXGz7UeYxJiZ/28kQ12F44XvChrbvWKDBrCql3NKHcckyl2s
	XIEvnyg0TconvxvrP+wuS5M9+McRfhges23M0gEsde7nSeIH++EtXvOg78vH8wWSFLn+3UtCUly
	jwEFcLW3tNjDxoOMQmOlAivNSjvcbRIIf5P/b6tOemJyUfw2GLdLyib/wKFQzhf7DXpL1Z3PvcQ
	MTjZe1kSy1B40wKxRo8W0NnX7QkXGzFmi6Ewr2F4S6mlLQ86nLXHAzrmmYT4Imv2N3X+DjywBcY
	Os2stEGTlv4ot3SJOsg1YuR762VhkGFvY7pdFH+jsD4LHdkb9Zz6DlHWYSGGFfbGMEKQtyBltbS
	0=
X-Google-Smtp-Source: AGHT+IHn7xbYfVCjCn3B+LxjKaU8SE92tJikPGsdCOYbX/YUHwX3Y5pn9k9bm7xFGgU57eO/UzXIiQ==
X-Received: by 2002:a05:6871:29d:b0:2d6:2a40:fb9d with SMTP id 586e51a60fabf-310be68e4d7mr5826676fac.28.1755543576697;
        Mon, 18 Aug 2025 11:59:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbf8442sm2819512fac.31.2025.08.18.11.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:59:35 -0700 (PDT)
Message-ID: <afffc91a-d4fa-47d5-bb59-fad879a2ac6d@baylibre.com>
Date: Mon, 18 Aug 2025 13:59:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-6-bcollins@kernel.org>
 <20250818191539.69e1882a@jic23-huawei>
 <2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 1:47 PM, Ben Collins wrote:
> On Mon, Aug 18, 2025 at 07:15:39PM -0500, Jonathan Cameron wrote:
>> On Sun, 17 Aug 2025 23:59:53 -0400
>> Ben Collins <bcollins@kernel.org> wrote:
>>
>>> From: Ben Collins <bcollins@watter.com>
>>>
>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>> to allow get/set of this value.
>>>
>>> Use a filter_type[none, ema] for enabling the IIR filter.
>> Hi Ben,
>>
>> A few comments inline. You also need to send an additional patch to update
>> the filter_type docs in Documentation/ABI/testing/sysfs-bus-iio
> 
> Hi Jonathan,
> 
> I just sent a v6 because I was getting too many comments on the
> dt-bindings patch.

Actually, folks will be happier if you slow down a bit. General
advice is only submit one revision per week since some people only
have time to review once per week.

If you are really in a hurry, there should still be no more than
one revision per day. Otherwise, it is really hard for reviewers
to keep up.

As it is, the subject of what I presume is v6 still says v5 in the
cover letter and doesn't have a version in the rest of the patches.
And there are still some of the same problems with the devicetree
patch that didn't get addressed. If you slow down a bit and take
a little more care before firing off the next one, it will likely
be better received.

> 
> I'll send a v7 with these changes and anything else that comes up.
> 

