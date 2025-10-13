Return-Path: <linux-kernel+bounces-850271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F1ABD2603
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5C71884488
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBBF2FE059;
	Mon, 13 Oct 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="l3vhrcEO"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F02239E63
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349008; cv=none; b=AjTX9FWDeA6K6Nxz/xDffylhvawM33zg0vPia4PxR3omffWqWZS17fkj0DqT56s2M49IeDT3dmPceUIFLJ+CeANWwt1AfMNiwEYU02QGWOeOLs4A4n40W2r4XskvR6rgBZj+rM85ozbjnhw7Q4JAP8RppzPFBG1FKrcDe11TuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349008; c=relaxed/simple;
	bh=BAnwDZOovV8WGEHznvS0ASUsl81ftZ3UHqcj056/iWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUao/ujoTEDvnyQZnIv8v5lwdzL9Piqwl52pY5vAEnWFR79BSBFLAnIPSmdHZ/mXdDnZpKpx+Vp+I4NX3j2eohPL7BT6lomaVqAAegYjculs8T7hNVlf9GNpC8JI5KTKdX0b5sWUOTCOy3OolzucP2ZIwErEpwYrD7LR+qAvqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=l3vhrcEO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2897522a1dfso37700325ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1760349003; x=1760953803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp51fhwIp2TxChiApwV+E+DXmQ/uPeFWu0ZwqX85B3w=;
        b=l3vhrcEOa++eozTx3XRR/r6yWBqLpeicG9EnXayMJUGW24c7j3XmsP1xcyQ4AnPgUz
         x9InSweMCR49LENaGfJ73g7IuvBm66NnLY/WSL93rY90oHdcoDeI9RsjKwPYEvt5DwBb
         tMFMfQnpw+9VWAPTWx7JHRK+tG/FOycvBgXA5m7OHKc6sK3NaGZM02tAyLXF6/Wv505d
         HgOWeo7HLE2j/PwkFQauEcSmnScd+LbM5XbMMDpvJTJKRsBp8Y/s74gYMjHZTeD5zShc
         K3nMXTmLlgLMem4khXKAvCgHlfqWZvPWMN+kPydVzAwUMW4Blhs/NthIeOYyqZe79PiN
         CAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349003; x=1760953803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp51fhwIp2TxChiApwV+E+DXmQ/uPeFWu0ZwqX85B3w=;
        b=qfG34n39/UzztZqinYI4X/0uaE2FiXWQ8zk1SaT4PE/SG4T7o5Gl7wRhREdtX4NWkK
         8hgcbsxJPODLfJ7HTDUd6q2D3k1DkjbHEDAijcdj9rMGgUTniVpuVRKC58OuALGblYC0
         d+qEiDhYsxND08vKCU42bsOdc/OTeiPCoxtNZRR1bWYwJmqh1PKL5Qkn9XSowVGFfyDv
         RjBdy8qPmIHhnAZ5hlmnDAr4C4OYkEoTvM/nWS3ZkJcTvj26veMB67OowsvQfCxpRtDh
         K0NO4F0EjTxaF6cntJjWFUpMppKQ8SXebTlx/lS4xxx3mUPSkJS5Qs366EEd5bcMr1B/
         fsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk95vvpTGvfQy+w3bA0c8Cp3tcujzS7iMiJPQJZLQuJpcdcXVBsGTwMklPShZ19pmM2yqK7XAjTTwcrsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlighSCNAzvdkrmuAXIW3wZgbiYSaL6Z0dTL3LOJtZPMymY3Z4
	9eJpmxaz3EKOEgBVeQ+pIF62QPOlsQlD4rxnkWQn3quKBKT8yDe2atIS6CpS09hadhvRtMQ3Hha
	i230u
X-Gm-Gg: ASbGncu1LDZsmaFdOgbxalXO6sG9KHbNBPaauzAGq7M8q3yV0O0H/X+azP2yLSzQfeG
	rjl5IQHNrDb5dTqSRbphXrjJuI1I3x1nddhnlET8/WPjNMW1TtZVB67UVXZjc27DgvGPPHfDjSb
	f/3izjmN1JWZjgiX/jpmRYh3VEuetNzEvJroMzEah4DXyWzDb37gWH2jNfF57MgeyeCELzafoKn
	Vr0sxuIgA2t3yBrgZeu7XiE4RpuUfwDl74I7uYEws7ZimgyiLxA0ti8Sdly0O4/4B3NWaJZRKdq
	NoaiO1RIwA53r1Cm3w1C1m1cSCtQnS/PYDRTBfkpOdyuW8pAhwaCsCjRnI+Hl837pLnsZ2zikYg
	G0QdEAHgvXYGLNp315gMyUmOF9jwiJFObXMEWo147xJLsEfnIuhDmZuWw0AjZK1kFS89xTOFOQQ
	==
X-Google-Smtp-Source: AGHT+IG1JzQQHQjMT21Ythm1gXAqTXhkL84Z5ZHyVJBm9N9Dh0WoFdsAzPwZjCutcgln/HrN3DWkBQ==
X-Received: by 2002:a17:902:f60d:b0:26a:b9b4:8342 with SMTP id d9443c01a7336-2902726259dmr238303985ad.25.1760349003313;
        Mon, 13 Oct 2025 02:50:03 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:b0a8:f639:5bec:40e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f06c82sm129052355ad.81.2025.10.13.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:50:02 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:49:55 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	akpm@linux-foundation.org, axboe@kernel.dk,
	ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
Message-ID: <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
References: <20250926065556.14250-1-409411716@gms.tku.edu.tw>
 <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
 <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
 <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
 <20251005181803.0ba6aee4@pumpkin>
 <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
 <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
 <20251007192327.57f00588@pumpkin>
 <aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
 <20251010105138.0356ad75@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010105138.0356ad75@pumpkin>

On Fri, Oct 10, 2025 at 10:51:38AM +0100, David Laight wrote:
> On Thu, 9 Oct 2025 20:25:17 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> ...
> > As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid input.
> 
> (to avoid two different input buffers giving the same output)
> 
> Which is annoyingly reasonable.
> 
> > One possible solution I came up with is to first create a shared
> > base64_rev_common lookup table as the base for all Base64 variants.
> > Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), we
> > can dynamically adjust the character mappings for position 62 and position 63
> > at runtime, based on the variant.
> > 
> > Here are the changes to the code:
> > 
> > static const s8 base64_rev_common[256] = {
> > 	[0 ... 255] = -1,
> > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
> > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
> > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
> > };
> > 
> > static const struct {
> > 	char char62, char63;
> > } base64_symbols[] = {
> > 	[BASE64_STD] = { '+', '/' },
> > 	[BASE64_URLSAFE] = { '-', '_' },
> > 	[BASE64_IMAP] = { '+', ',' },
> > };
> > 
> > int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > {
> > 	u8 *bp = dst;
> > 	u8 pad_cnt = 0;
> > 	s8 input1, input2, input3, input4;
> > 	u32 val;
> > 	s8 base64_rev_tables[256];
> > 
> > 	/* Validate the input length for padding */
> > 	if (unlikely(padding && (srclen & 0x03) != 0))
> > 		return -1;
> 
> There is no need for an early check.
> Pick it up after the loop when 'srclen != 0'.
>

I think the early check is still needed, since I'm removing the
padding '=' first.
This makes the handling logic consistent for both padded and unpadded
inputs, and avoids extra if conditions for padding inside the hot loop.

> > 
> > 	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));
> 
> Ugg - having a memcpy() here is not a good idea.
> It really is better to have 3 arrays, but use a 'mostly common' initialiser.
> Perhaps:
> #define BASE64_REV_INIT(ch_62, ch_63) = { \
> 	[0 ... 255] = -1, \
> 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
> 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
> 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
> 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> 	[ch_62] = 62, [ch_63] = 63, \
> }
> 
> static const s8 base64_rev_maps[][256] = {
> 	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> 	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> 	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> };
> 
> Then (after validating variant):
> 	const s8 *map = base64_rev_maps[variant];
>

Got it. I'll switch to using three static tables with a common initializer
as you suggested.

> > 
> > 	if (variant < BASE64_STD || variant > BASE64_IMAP)
> > 		return -1;
> > 
> > 	base64_rev_tables[base64_symbols[variant].char62] = 62;
> > 	base64_rev_tables[base64_symbols[variant].char63] = 63;
> > 
> > 	while (padding && srclen > 0 && src[srclen - 1] == '=') {
> > 		pad_cnt++;
> > 		srclen--;
> > 		if (pad_cnt > 2)
> > 			return -1;
> > 	}
> 
> I'm not sure I'd to that there.
> You are (in some sense) optimising for padding.
> From what I remember, "abcd" gives 24 bits, "abc=" 16 and "ab==" 8.
> 
> > 
> > 	while (srclen >= 4) {
> > 		/* Decode the next 4 characters */
> > 		input1 = base64_rev_tables[(u8)src[0]];
> > 		input2 = base64_rev_tables[(u8)src[1]];
> > 		input3 = base64_rev_tables[(u8)src[2]];
> > 		input4 = base64_rev_tables[(u8)src[3]];
> 
> I'd be tempted to make src[] unsigned - probably be assigning the parameter
> to a local at the top of the function.
> 
> Also you have input3 = ... src[2]...
> Perhaps they should be input[0..3] instead.
>

OK, I'll make the changes.

> > 
> > 		val = (input1 << 18) |
> > 		      (input2 << 12) |
> > 		      (input3 << 6) |
> > 		      input4;
> 
> Four lines is excessive, C doesn't require the () and I'm not sure the
> compilers complain about << and |.
> 

OK, I'll make the changes.

> > 
> > 		if (unlikely((s32)val < 0))
> > 			return -1;
> 
> Make 'val' signed - then you don't need the cast.
> You can pick up the padding check here, something like:
> 			val = input1 << 18 | input2 << 12;
> 			if (!padding || val < 0 || src[3] != '=')
> 				return -1;
> 			*bp++ = val >> 16;
> 			if (src[2] == '=')
> 				return bp - dst;
> 			if (input3 < 0)
> 				return -1;
> 			val |= input3 << 6;
> 			*bp++ = val >> 8;
> 			return bp - dst;
> 
> Or, if you really want to use the code below the loop:
> 			if (!padding || src[3] != '=')
> 				return -1;
> 			padding = 0;
> 			srclen -= 1 + (src[2] == '=');
> 			break;
> 
> 
> > 
> > 		*bp++ = (u8)(val >> 16);
> > 		*bp++ = (u8)(val >> 8);
> > 		*bp++ = (u8)val;
> 
> You don't need those casts.
>

OK, I'll make the changes.

> > 
> > 		src += 4;
> > 		srclen -= 4;
> > 	}
> > 
> > 	/* Handle leftover characters when padding is not used */
> 
> You are coming here with padding.
> I'm not sure what should happen without padding.
> For a multi-line file decode I suspect the characters need adding to
> the start of the next line (ie lines aren't required to contain
> multiples of 4 characters - even though they almost always will).
> 

Ah, my mistake. I forgot to remove that comment.
Based on my observation, base64_decode() should process the entire input
buffer in a single call, so I believe it does not need to handle
multi-line input.

Best regards,
Guan-Chun

> > 	if (srclen > 0) {
> > 		switch (srclen) {
> 
> You don't need an 'if' and a 'switch'.
> srclen is likely to be zero, but perhaps write as:
> 	if (likely(!srclen))
> 		return bp - dst;
> 	if (padding || srclen == 1)
> 		return -1;
> 
> 	val = base64_rev_tables[(u8)src[0]] << 12 | base64_rev_tables[(u8)src[1]] << 6;
> 	*bp++ = val >> 10;
> 	if (srclen == 1) {
> 		if (val & 0x800003ff)
> 			return -1;
> 	} else {
> 		val |= base64_rev_tables[(u8)src[2]];
> 		if (val & 0x80000003)
> 			return -1;
> 		*bp++ = val >> 2;
> 	}
> 	return bp - dst;
> }
> 
> 	David
> 
> > 		case 2:
> > 			input1 = base64_rev_tables[(u8)src[0]];
> > 			input2 = base64_rev_tables[(u8)src[1]];
> > 			val = (input1 << 6) | input2; /* 12 bits */
> > 			if (unlikely((s32)val < 0 || val & 0x0F))
> > 				return -1;
> > 
> > 			*bp++ = (u8)(val >> 4);
> > 			break;
> > 		case 3:
> > 			input1 = base64_rev_tables[(u8)src[0]];
> > 			input2 = base64_rev_tables[(u8)src[1]];
> > 			input3 = base64_rev_tables[(u8)src[2]];
> > 
> > 			val = (input1 << 12) |
> > 			      (input2 << 6) |
> > 			      input3; /* 18 bits */
> > 			if (unlikely((s32)val < 0 || val & 0x03))
> > 				return -1;
> > 
> > 			*bp++ = (u8)(val >> 10);
> > 			*bp++ = (u8)(val >> 2);
> > 			break;
> > 		default:
> > 			return -1;
> > 		}
> > 	}
> > 
> > 	return bp - dst;
> > }
> > Based on KUnit testing, the performance results are as follows:
> > 	base64_performance_tests: [64B] decode run : 40ns
> > 	base64_performance_tests: [1KB] decode run : 463ns
> > 
> > However, this approach introduces an issue. It uses 256 bytes of memory
> > on the stack for base64_rev_tables, which might not be ideal. Does anyone
> > have any thoughts or alternative suggestions to solve this issue, or is it
> > not really a concern?
> > 
> > Best regards,
> > Guan-Chun
> > 
> > > > 
> > > > Best,
> > > > Caleb  
> > >   
> 

