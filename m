Return-Path: <linux-kernel+bounces-793466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F41B3D3E6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2C417B320
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F625A2CD;
	Sun, 31 Aug 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="cERAsCNE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3B1B808
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756650241; cv=none; b=X93W5m8K7qyGKKBG/YHipAG5yQkT7zsev/ME3bohEoZ6o1/k8WkiVEuqZoOf4qOqWfOplKup+DBmsy311j+Ah2qK+T+dYLgYfiXf8IxswJqhRdqqnl0C4VGlWZ8kpwD3fyeIuGPBa3Gfp48xfgMWTVqdHkrF4GepvGva1QDidrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756650241; c=relaxed/simple;
	bh=y1zF5JL1EodDQ2qLLuAywaO3QqUb5aQbBUe2g574maM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YC2MZMyNvz1AdLkOysw60t02s3BfUyXOMA0LNTmhT+T2am7Cj4dMfkC8r1DN0RKHDJkWtt4K8PocI1E17OF/Xd61oMlIKSoD9VhYNhgZd84tCbAazH42UWiC1vZ3tdNpAk8toO8QyK7iuki1tzvriKxYQG4geZvMFKUpn8W7TLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=cERAsCNE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24456ce0b96so37136315ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1756650237; x=1757255037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAUHWa+mrkdnS2M1tLNwmvLfuGzsdxZRu47bXM4nV+w=;
        b=cERAsCNE7bDngNBedrvfghgtRKi9GrpXmYY52s0mF/sNMobctPGpyV3bbjUJKDNo7x
         Jd2vv46AFdEkqn3DQXglyuge/0nB1+4vZhvGb26dFAjOvanEQu2JhK/XLhkVA2EhBZGJ
         2XuU5K61Pdcdln6mxMTQiJ8NR8eMUCMc2WT/xAd53qfCK8JBjUQib8Wg3VASzHTK7Z1E
         q2cMJ/HQqW4Rxha/Aw87daog1lK2lPXM7k3nlLnbmxhvGhovttYfgqOuyxn0eAKwFzT6
         KKt0DcrqCoCc/gU34zcA4td8NzfUOFFYEUTnF6D4+gml4OecW/6jC7Mtad1UKf4GOuWz
         iGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756650237; x=1757255037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAUHWa+mrkdnS2M1tLNwmvLfuGzsdxZRu47bXM4nV+w=;
        b=AahBvJYO6g0Abuj7oP+xS/m78w2PChdjjdtnwQzWkyx34BkEbPaL7KO5JgRdc1ACQW
         XYcBPEUeosJo2qGQlLmqHcg3L9fm5gGVLcFS9mir4ZlEJb27N6CR2cXnacgWKIBRMJOM
         2aYY7RirIYcgEYj/7dpG2y6Kv0/dfQL6GLAsYYWqdnwkTnm/Gd55hV1qHxt6fskojseF
         hTMyJfcDHkbyMkbqN/3NrdpR3PtsCrVpYkJaezEWHJRweiNwtzn/wWbzNJmCueJdxcAe
         1QT88CLpVE/gvOaF31LxFTP8K2+1VB21XeQI0206/KrUx+SdDQzszZYG3IpYP9fIKDVj
         FGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmfHx/uFGDUJ3p4tHdj2eaqPYmmP9oFFtiMh5IevfO19Lor+vBTg7V1Id4UcOzjIcQXUnnMuZk14ojB0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwPpO0jOBRAwTJ8ET8ShMDzPgX8K3GPW1i0EHnStb1jCTz7qN
	rHSPBlyhbEDkLgWhfya0o7X/mmcWAQydTTS/xffcNts76/z02yG+A7u9ywEmKq4mO58=
X-Gm-Gg: ASbGnct22WA2tnJV4xOP+jUa/jlUOoE5lhkI0hMuPQqr/dhL3wZUt/CPvXUM5Ho0jfV
	ApblrU4Fw/6pEL10jDCbfGfMA35r5h35UBfnlje1Q4G8mCrvWA1GjAMqtfMX9mk+5Ck5QSVmP/M
	XEfE14srv8kzSJEvsRJh3mM5v7qH3eri+04bElmuCzjaS4sprx6qaZI+8OBsN+QX36A7vWs6FXR
	xXAu+y3qpsAihuWJvDYu2aktjFwIXpZAmAd/YEEtFsUoRy7jPedP5lwig9w0OgUmJNEpTbbxylU
	Yt6oYgBidFUVLT2KE8d6wYt58C0qG3T/CEr0tsRPVCaSlwiOE6SsdjOAlDe8MSieByZ3zCBTGot
	iKEjeslzbxRpAOmkfuLZ7R9Xmw4xPx6Hnfk5NTHCOyOK8l/1yQILilRCAuo2eRRYG4m7Z
X-Google-Smtp-Source: AGHT+IFQ56DB3b4SdGl+LhNjvjjBhfPxTg7gFDUHSGh44e9FA9yjLxRBEUKtF6n7IdgfuIaXIBG+5A==
X-Received: by 2002:a17:903:32d2:b0:248:aa0d:bb30 with SMTP id d9443c01a7336-2494486f180mr66609385ad.2.1756650236666;
        Sun, 31 Aug 2025 07:23:56 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:c382:54ef:4bb4:90ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906598815sm76233755ad.117.2025.08.31.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:23:56 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: ebiggers@kernel.org
Cc: 409411716@gms.tku.edu.tw,
	jaegeuk@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH] fscrypt: optimize fscrypt_base64url_encode() with block processing
Date: Sun, 31 Aug 2025 22:23:52 +0800
Message-Id: <20250831142352.16372-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250830162431.GA1431@quark>
References: <20250830162431.GA1431@quark>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

>On Sat, Aug 30, 2025 at 09:28:32PM +0800, Guan-Chun Wu wrote:
>> Previously, fscrypt_base64url_encode() processed input one byte at a
>> time, using a bitstream, accumulating bits and emitting characters when
>> 6 bits were available. This was correct but added extra computation.
>> 
>> This patch processes input in 3-byte blocks, mapping directly to 4 output
>> characters. Any remaining 1 or 2 bytes are handled according to Base64 URL
>> rules. This reduces computation and improves performance.
>> 
>> Performance test (5 runs) for fscrypt_base64url_encode():
>> 
>> 64B input:
>> -------------------------------------------------------
>> | Old method | 131 | 108 | 114 | 122 | 123 | avg ~120 ns |
>> -------------------------------------------------------
>> | New method |  84 |  81 |  84 |  82 |  84 | avg ~83 ns  |
>> -------------------------------------------------------
>> 
>> 1KB input:
>> --------------------------------------------------------
>> | Old method | 1152 | 1121 | 1142 | 1147 | 1148 | avg ~1142 ns |
>> --------------------------------------------------------
>> | New method |  767 |  752 |  765 |  771 |  776 | avg ~766 ns  |
>> --------------------------------------------------------
>> 
>> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
>
>Thanks!
>
>> Tested on Linux 6.8.0-64-generic x86_64
>> with Intel Core i7-10700 @ 2.90GHz
>> 
>> Test is executed in the form of kernel module.
>> 
>> Test script:
>
>Is there any chance you'd be interested in creating an fscrypt KUnit
>test (in a separate patch) which tests fscrypt_base64url_encode() and
>fscrypt_base64url_decode()?

I’m interested in adding a KUnit test as a separate patch
to cover both fscrypt_base64url_encode() and fscrypt_base64url_decode().

Per Thomas’s suggestion, I’d also like to explore a generic Base64 helper in lib/
(with encoding table and optional padding), with tests in lib/test/
covering both the standard and URL-safe variants.

>
>> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
>> index 010f9c0a4c2f..adaa16905498 100644
>> --- a/fs/crypto/fname.c
>> +++ b/fs/crypto/fname.c
>> @@ -204,20 +204,31 @@ static const char base64url_table[65] =
>>  static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
>>  {
>>  	u32 ac = 0;
>> -	int bits = 0;
>> -	int i;
>> +	int i = 0;
>>  	char *cp = dst;
>>  
>> -	for (i = 0; i < srclen; i++) {
>> -		ac = (ac << 8) | src[i];
>> -		bits += 8;
>> -		do {
>> -			bits -= 6;
>> -			*cp++ = base64url_table[(ac >> bits) & 0x3f];
>> -		} while (bits >= 6);
>> +	while (i + 2 < srclen) {
>> +		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8) | (u32)src[i + 2];
>> +		*cp++ = base64url_table[(ac >> 18) & 0x3f];
>> +		*cp++ = base64url_table[(ac >> 12) & 0x3f];
>> +		*cp++ = base64url_table[(ac >> 6) & 0x3f];
>> +		*cp++ = base64url_table[ac & 0x3f];
>> +		i += 3;
>> +	}
>
>To make it a bit easier to understand, how about updating src and srclen
>as we go along?
>
>	while (srclen >= 3) {
>		ac = ((u32)src[0] << 16) | ((u32)src[1] << 8) | (u32)src[2];
>		*cp++ = base64url_table[ac >> 18];
>		*cp++ = base64url_table[(ac >> 12) & 0x3f];
>		*cp++ = base64url_table[(ac >> 6) & 0x3f];
>		*cp++ = base64url_table[ac & 0x3f];
>		src += 3;
>		srclen -= 3;
>	}
>
>	switch (srclen) {
>	case 2:
>		ac = ((u32)src[0] << 16) | ((u32)src[1] << 8);
>		*cp++ = base64url_table[ac >> 18];
>		*cp++ = base64url_table[(ac >> 12) & 0x3f];
>		*cp++ = base64url_table[(ac >> 6) & 0x3f];
>		break;
>	case 1:
>		ac = ((u32)src[0] << 16);
>		*cp++ = base64url_table[ac >> 18];
>		*cp++ = base64url_table[(ac >> 12) & 0x3f];
>		break;
>	}
>
>'srclen >= 3' is much more readable than 'i + 2 < srclen', IMO.
>
>Also, instead of '(ac >> 18) & 0x3f', we can just use 'ac >> 18', since
>'ac' is a 24-bit value.
>
>- Eric

Thanks, Eric. I'll update the loop condition to use 'srclen >= 3' for
better readability, and drop the redundant '& 0x3f' when shifting the
24-bit accumulator.

