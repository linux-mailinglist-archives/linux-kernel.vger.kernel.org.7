Return-Path: <linux-kernel+bounces-728005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE3B02251
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46DD1CA2930
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F0A2F0C4D;
	Fri, 11 Jul 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M3xXNyiv"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA371219A91
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253634; cv=none; b=hcIubTuAKH5qSAa6QpHkbvZwIj9D2UZL/U5uQNyPDUbHfPN5U953jjVGxFr17NBQBdm69GzgDIYxnVXmVWOKYNBr4jHzwVQdsFtGjivJJ+mfTg2LJQV3fh1jORSeAvKUyrZWut3daHvvZbOgCNqypLLAZ3DSAfApzEkoxBv9ef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253634; c=relaxed/simple;
	bh=FQajfC6hj9vjgjYWT16Osu25UTqQIQVqEGZHV5VAkWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS8LiOPQO0Hdyu0mnlRMeMKjgojsQm/s9l7oCaTe1AuIykQI07/ksfovcEAXRYVATAr23tvRnNDMBhWA0djKqF8JTdakS9dLvXQGKdZK0WDrV26vm7q+USppEyxPrLurV9YjWjY7PAws6mpGk+Zwfw3OJXlKUjh/G3BmkQMrQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M3xXNyiv; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73ce7b40d7aso1198231a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752253632; x=1752858432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/x+YACVlc10+DgeSv3LaeOJ8nkJHg18kDmNVpt3dpyQ=;
        b=M3xXNyivoTlYIHMXttVOLGelH+aBmAXkElSZwMO+FZAnpj8PU7+6KiD48a17HFsdDi
         poSylHsLN0MaRDpY9QvQjP5UyQcyDVwDLv3WaA4PpQPjR1tbd3XRpQLBwGWwWxfq9zgh
         TvtAcxMrt9JVAPHnRt+MVJ4SLbfdv0U/4lHJURkYCJ+K0o4Ia252Vx77O2t6XtFgBb8f
         D05z4qeOYOwEihDxgsloxJNQBhwbQ6KSZ5wIB+bMxADZnkZIGf49VbNUqKhk4ocKLdqn
         kL3Q/SurM0J9PIBrDhUbjQcukJUmQKGj1ip7xHT/1tHNohOsHF7PNixfpqi60QLK1jwu
         4AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253632; x=1752858432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x+YACVlc10+DgeSv3LaeOJ8nkJHg18kDmNVpt3dpyQ=;
        b=oIse77tJ1cw17owHjXT6f2I2pq9BRtD6B4Nn+19ZCvHWT3YCIBhtNN84xVBREkxYn3
         9hkB5f1uDpf8AaIov4/zvzqNtqBUFMnOLWnnHBhmS1SZqtxUUFIFQbrlXeVkto7yYNOp
         Cs8LRq244Fy6Yc5QHSAYMcQB0U2LX8gQbxR3sawivVu8/AYiGKDFvQxdjjMSRZn+Vxas
         XJv3NsFsd7lShX+BoRSrezFnQjXHAtM9ZYOVrOcZA8+QQCSKvHSYuTEb0dghKH7YTz/4
         3Od7FDhyzial1QrCn0zQVqeII+sc/Pu2rle/EGccj51j+P8OAQfxJA2sOEAIuAHUtZWv
         JhDw==
X-Forwarded-Encrypted: i=1; AJvYcCWHefDBxhoEYPUu+znb5V7SztmGL638z7DFTsBj8Y3vCvWczVlAV13SM0GFrgyjXrBV1SHN2ryoDA3oOdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmLyWINISRAcuf7h7X5xxicfbq7RNZ3K3K8k3CI9HsFN9B7f9
	ZrT40RRqkmseGobDjoSfvR4KVjNi+bwAQNkOfhxFIv9DmNwwBuUGt0dWPiDMMY0k1xw=
X-Gm-Gg: ASbGncvR8qg6bndLKtfMaDKBZUNAH8xRqVTSoGqNmYwfy7yF1jyoKoE+WHmpXgjmJHY
	LNI7ffZ0mNet8KYzgnSIKRuzsyr2BJCXga46hSZyRaFx5l9uN0rfo43srGTpuiNcO5IZqLtwZWb
	CGwoWSsYAQpT6pOC08WBfTPNT/RUmK8VMe1qslins9TVAtSJW/vxCnbnwla96A+JW9vjGmV7Rf6
	c03VN5xFSpy2itVA/owRaGyDB00klCtgtavhgxMWlfRlwQeoU10Bm3LO5hY722589AAUZwklbix
	jVScE3qy2abNUmjHAcTuX0blMDmYCzx7nLfhKWM2U5J25w6ZuEQwPTCLPG/+R5hA5/1R62TpEeF
	8+q+ZRQmDIbf22VVN4EPVHspNnj8qAIlvTKTxNoR6Qobs88OnCzyH/buLyYL00DLYMtT3FnPXpF
	o=
X-Google-Smtp-Source: AGHT+IEkY01cCKVG6Clr6ikQhS7ALcIWi2oLXjz9bIzvCpzXVCR9GAM5QlPm1WCudIYi7GuRrEJkeg==
X-Received: by 2002:a05:6830:3e93:b0:727:3587:fd1 with SMTP id 46e09a7af769-73cfa255053mr2108055a34.3.1752253631790;
        Fri, 11 Jul 2025 10:07:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a60b4sm621174a34.50.2025.07.11.10.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:07:10 -0700 (PDT)
Message-ID: <3372c362-96cb-4ca7-aeba-89a72e065dea@baylibre.com>
Date: Fri, 11 Jul 2025 12:07:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: srf08: use stack allocated scan buffer
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com>
 <aHE_ecZNTgRW79VU@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHE_ecZNTgRW79VU@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 11:44 AM, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 11:07:20AM -0500, David Lechner wrote:
>> Use a stack allocated scan struct in srf08_trigger_handler(). Since the
>> scan buffer isn't used outside of this function and doesn't need to be
>> DMA-safe, it doesn't need to be in struct srf08_data. We can also
>> eliminate an extra local variable for the return value of
>> srf08_read_ranging() by using scan.chan directly.
> 
> Why not with macro?
> 

In cases like this where there are a fixed number of data values
read, the existing pattern is to use the struct like this. Furthermore,
IIO_DECLARE_BUFFER_WITH_TS() implies an array and usually we try to avoid
arrays with only one element.

