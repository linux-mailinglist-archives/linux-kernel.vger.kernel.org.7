Return-Path: <linux-kernel+bounces-891070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB952C41C34
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 802164FB3D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5F310631;
	Fri,  7 Nov 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gfRyHloZ"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23E30216D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550051; cv=none; b=hXlPI/L3vr9uss53y2fQZuwwBJd1+ueDvf6R4v2iV68bdle5ipymmiuZA2r02iABbN+ymIQTBXUePAJGP+9aCbYYHKctNkNofMDcvc4bHlEOoEJU/NDmE7fAECqtczI4l/PNqfJG2yB7aAMvX6AV4ytAOaPy0XkRe2ocXLMWPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550051; c=relaxed/simple;
	bh=UV51qyXzYtxwGuB0zES4FqkBW93FAxvKUjuQF+mTpr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nV1AMCf0Ej2zf/hI9PHqgzOfZF+qyN9RPo67rKHg02R1f4dFSvCOBJYY4IvzQ1dBSjuhlTiZa8roUhLQVlAej/tZGpwQBiJQm6Kl4JgTD19d5BriznhJSQ2FuOIuwmChmzOAuTUo18amXSTyMYRBEfQUWQ5O88H0jcrfLtiyfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gfRyHloZ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6567607bd65so221387eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762550048; x=1763154848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vo2b5stOOMkheFTgFZGlOEGzsHrk4gEITKRM/xPVOlg=;
        b=gfRyHloZ8hHEZSlMb20dAUZruZQMPz3LxKyzsL2eEEpk4ZUChE2sBNNmMVyZ+K61ll
         h+9drTxHRX1LZoamY204Uae1mtOj8FQ4NfmHqcxxyhlAGgjZRa/bpkSO6ADVhlsmzsjJ
         HB0TZETIZ+IeToO6xrB8EkR9OJCZTXHefip1KB2bdzDq5rJNctmpifpbSQK3m5S41Ev+
         JDLRxHSDCSFlJQ9D8FozcvyFaG4I8X+p14VC+LEIfmokliiDRGUofTLTAAuDPEyw/jGj
         wjZpTP585I/gKPSgnjG8oJu2A/SovYmyl1im3cALpJcPM8SUSRfp9nIfYITaD8mA5PMk
         zxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762550048; x=1763154848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo2b5stOOMkheFTgFZGlOEGzsHrk4gEITKRM/xPVOlg=;
        b=GJlLoxX5ej0u5aTYiwX40uu4kfSaWuOroW6VlcZaLxsm+1YdNY6O3Ma4vgjGsBY6/e
         pMIoUzpPbYX58G04Ylzm0OOjqR5ZfEmE5c4EbLNcmPp+QgfcUjUZqrmJ+1Q31/ZUAoNk
         w5s8w21spheGOKzcxehQaOyTrR0a77ivwxa39H4eh+0mGgGfI92D5rOtCrYXat0Sj95q
         xxipWx2Sd9v07Veufa0WUawP4TQ0wDj1O3b/DY5UGA3nnVEBFkDOAoXroA56HlTuZA/x
         kG+1GG8KZuAgWCkBdgzQlF7pYs/cHv8PG/4NUX2a+YC0jw3Ko+3VvPr1lvLg4qLATREX
         WsJg==
X-Forwarded-Encrypted: i=1; AJvYcCXfG+rPVtRFxAEdWINq9hA4byIrstmrt5m4JxdplNUBTL2Inm0mrKtRoDaoNW0CyZTBUAKEeXCPC9HeiQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3eXz4v77eojcyKkrgDQC3Kx9Xmy6OF54s9puNePEiEkBd4J0Z
	iGEcqYXmIywjjNKiIzgCG5gZ1VrBcuQLPgzf9JOKroqP8rd/HkWcNo3UbaCi9WxtJ5A=
X-Gm-Gg: ASbGncu2rkDSNRPBillN356o2K39tgjDdVzQO6SC17WTHaent4LpA13ydeKtb71+1I6
	0WUVWuUb/8hI07XjZa7P/eBbBI/ZzNy0tJoz3X9E4uUNk3XVc8EGD0tTUkMlOWTy9+UvogYoBwM
	7IanPw8SwxYQ+NP2vLOStz0FSnZGxEWyPI3lt+tjFQL7loAo2hDsYYuU8YjYxKM45M/FOLD5oNv
	zBp4bkN43rLPvDCyDHbstyNMRrPpUnEjq6qw2s+dAjkF1LiNRrwhy8Ch4uT5HAV+YXMlrrwIuwE
	MwUq9hqbg7hWnqWy86kjzL2JiL7/hbgjB1OuJ+Nvf1Cgsd9QRs5nwTsNxI+Z7lrvoijNrYrjUWm
	TUekRUodghy5QV+IiVRNqKjgf9BEbZxLexwaKtsAoKeH0nJIP8yaF5SLU/oexnpwWmfEeqrlMtR
	pGTT5rc+dbiuYSfqsuu27zq0FAa9SUge/9V4BaKKNviD02GrHR6ao3zoQiLjjwF8yE37takIQ=
X-Google-Smtp-Source: AGHT+IH58JNXTTmu6lPkALuS59F00c00c+agrganN7d8UEB0Nzs1Gj/HxCtytEXComYXlhKlM//Npw==
X-Received: by 2002:a05:6808:80c6:b0:44d:aa05:ce74 with SMTP id 5614622812f47-4502a1be72amr387091b6e.19.1762550047721;
        Fri, 07 Nov 2025 13:14:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7bb8:950b:327d:4ba4? ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450027f640esm2781467b6e.23.2025.11.07.13.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 13:14:06 -0800 (PST)
Message-ID: <45bf8a0c-0491-4356-ad54-79c25079ad19@baylibre.com>
Date: Fri, 7 Nov 2025 15:14:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2/6=5D_units=3A_Add_32-_and_64-bit_sign?=
 =?UTF-8?Q?ed_values_of_=CF=80?=
From: David Lechner <dlechner@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
 <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
 <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Content-Language: en-US
In-Reply-To: <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 3:09 PM, David Lechner wrote:
> On 11/7/25 2:03 PM, Andy Shevchenko wrote:
>> There are a few drivers that want to have these values, and
>> one more known to come soon. Let's define the values for them.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  include/linux/units.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/units.h b/include/linux/units.h
>> index f626e212d4ca..5b3293bce04c 100644
>> --- a/include/linux/units.h
>> +++ b/include/linux/units.h
>> @@ -21,6 +21,12 @@
>>  #define PICO	1000000000000ULL
>>  #define FEMTO	1000000000000000ULL
>>  
>> +/* Value of π * 10⁸ (fits s32 or signed int) */
>> +#define PI	314159265
> 
> It isn't clear to me at all in the other patches that e.g.
> DIV_ROUND_UP(PI, 1000) would be π ✕ 10⁴ (rounded to nearest

Typo. Should be DIV_ROUND_UP(PI, 10000) or  DIV_ROUND_UP(PI, 10 * KILO).

> integer, of course).
> 
> Calling these PI_E8 and PI_E18 or PI_x10_8 and PI_x10_18
> would help to clear that up.
> 
>> +
>> +/* Value of π * 10¹⁸ (fits s64 or signed long long) */
>> +#define PI_LL	3141592653589793238LL
>> +
>>  /* Hz based multipliers */
>>  #define NANOHZ_PER_HZ		1000000000UL
>>  #define MICROHZ_PER_HZ		1000000UL
> 


