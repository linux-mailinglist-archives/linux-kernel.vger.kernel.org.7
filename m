Return-Path: <linux-kernel+bounces-852082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873FBD8201
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991323E2C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287130F959;
	Tue, 14 Oct 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcYTJuQu"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DA2C17A0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429670; cv=none; b=eK0oASvcD7sPEw5/+tjQRqOabbqPjU6tb5BVyHxy7I8K5recvgz1lNVumeQI2YYWI2P6hqzeV7BOTR9huwGoy5qwrBMsLOImgOhXaLsHz21FnuzkNSaDTTB1MzXj76P8hip6/9Q4dXV5sxPeH3A6oyNetlwCVXrMuCxIOXYI/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429670; c=relaxed/simple;
	bh=YSQmz/d4p9LxTf/yjDjDxRU/XhCYVapUCPI7TuKFeec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sn9bl5j5n9BvnlBiSbWr48l/NuCZclDBsHos3npE/VPT7W5hUfFkMhJsG1ZBvIQTws9WuCYL03C89BA03dVWdnlX3cDx3qRklK3OWM9rzZDyNEDqmuY57pkWD1KiAyRUwropMg5uAHjfL+zmYGw2FI3l3P025X/HT5YGWqpnJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcYTJuQu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e29d65728so29826385e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760429666; x=1761034466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCGlydBv1IgmD6OYCzpqtJgg2Lvc0HUVlRtG6th7/NU=;
        b=QcYTJuQuupetK01nG3J82wxIY3cJIWQJnJv1jc8l0YlRtRQ6Z9A42mXCxC9lPGohYI
         qfv1KrajREYfNATv2RftuuKOhXdOdwSsh3NR3UwNePKcz6Rr3EGRpGaF2MF75Bfm6ODB
         b1whKvDWJlLpKYCqlmrzp1IDw9mdlYlbgrYvzMPqmKJx/1KjgoFVHLjus3my4R4BVRbP
         /GxqxDUKEYuGXZZdVUTXqcvdVI6VHolNw/Sl3hUAw5b2IIauRabqhzp/K5qqHJNlAdr1
         Q9hXdq1xB/F+X4szkcHTd0X5fU3UWlte+vbe7pSBkySannBu5WxFuJ3jSK4n02GPgWLs
         Br0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429666; x=1761034466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCGlydBv1IgmD6OYCzpqtJgg2Lvc0HUVlRtG6th7/NU=;
        b=e2HMIfAx3YNRyw0f3DuDQHu6hBXBQoBC2phv9vgRj9kZiX2KbxvlZSpcwgM2zkdPZc
         5aK/DQYJiR9uqNd3aFnANd+DrjPF5E9X3gOXU7etGZ+xfZ4xgjCYFKBfiLPSR3w9ND26
         78++qespyuQFhg9CWf3gTA5ri2hIXW3YpX/xXmFc3W+kOfWFCkXSvKqZbLDkMozjl2XS
         pwxAtcJBNYD9xPvCXlSVlnSpsLHFzzSv2tiw/N3xCysfVkjtHSm3JlePMICeb94d9leZ
         qcVZkZ7lvhWDnuKkGnBH33xEmCzHMwvfqL7uBwvqkI7nFdlcljVUyYwq3oG8J9jA+99V
         Kb6w==
X-Forwarded-Encrypted: i=1; AJvYcCXBEIhdFz09mv3bH/KwHHKUOkiTCWyBgz9VQfK2gpzQ1MhhUfF9vvzOkHKO9BKqxIynVTA5vsSMYfHHo/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJwp7Y34vry41z+GwGmwJi+YYSiQ+CXVtiwgkdeNPI9tkUsMg
	cvedHBjdwCtSjL0eVlOJIiyb7fVAo3smZVdyxqnRiwoYzYUP8KM5KsLJ
X-Gm-Gg: ASbGncs5C09z2397SWFu969P6LZqu6vs0UZ8L5PGhN3CfNMZLS2qPgU0xXbzupeL3XO
	NU4sALWAbWsBw7CGuqeJY14wRCjYDKKzdeq9oPWXIuT2/ZCxCtbY3Bq9wHRlzKuk8o3reiBk4SP
	ZpG1+qM6KJnMc2blW/WP/M3j1oh6Ovlc2lsQ260TxwZMOYG2Ul38QQH7XEmPcHGuILjuI5cftp7
	TgNODV8IMzjeo7K18EHm8EJEpORy6ubq5+KsKsbn+X6J+QTvN1barTA3+h81cCC5qj6FXMnW9lQ
	TYwzyE6tLLm0fDlhfeTXwOwkhi4JpKEiFWg6wxyo8UB3n6zdW4YOD3Hg6TmNCzpD/83JC0SA/3/
	HkwF45uZ1r+HP7cvH48omrz9na58xWwYnNNXCMj9SQ/+8pacCjyfafp+6veywor+7lc7cQ15XlB
	e3RqxLfpc=
X-Google-Smtp-Source: AGHT+IGlURcaYtxeR/4YJghdHkVrrVvxKtUh4t7BLUPo3pxJJ/Y8h3MpYW3S6t6HOaxlenUga+CUFg==
X-Received: by 2002:a05:600c:1f8e:b0:46f:b42e:e392 with SMTP id 5b1f17b1804b1-46fbbeb30a2mr74875685e9.39.1760429666272;
        Tue, 14 Oct 2025 01:14:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489194dsm226883765e9.12.2025.10.14.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:14:25 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:14:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with
 reverse lookup tables
Message-ID: <20251014091420.173dfc9c@pumpkin>
In-Reply-To: <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
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
	<aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 17:49:55 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> On Fri, Oct 10, 2025 at 10:51:38AM +0100, David Laight wrote:
> > On Thu, 9 Oct 2025 20:25:17 +0800
> > Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > 
> > ...  
> > > As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid input.  
> > 
> > (to avoid two different input buffers giving the same output)
> > 
> > Which is annoyingly reasonable.
> >   
> > > One possible solution I came up with is to first create a shared
> > > base64_rev_common lookup table as the base for all Base64 variants.
> > > Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), we
> > > can dynamically adjust the character mappings for position 62 and position 63
> > > at runtime, based on the variant.
> > > 
> > > Here are the changes to the code:
> > > 
> > > static const s8 base64_rev_common[256] = {
> > > 	[0 ... 255] = -1,
> > > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
> > > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> > > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
> > > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> > > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
> > > };
> > > 
> > > static const struct {
> > > 	char char62, char63;
> > > } base64_symbols[] = {
> > > 	[BASE64_STD] = { '+', '/' },
> > > 	[BASE64_URLSAFE] = { '-', '_' },
> > > 	[BASE64_IMAP] = { '+', ',' },
> > > };
> > > 
> > > int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > > {
> > > 	u8 *bp = dst;
> > > 	u8 pad_cnt = 0;
> > > 	s8 input1, input2, input3, input4;
> > > 	u32 val;
> > > 	s8 base64_rev_tables[256];
> > > 
> > > 	/* Validate the input length for padding */
> > > 	if (unlikely(padding && (srclen & 0x03) != 0))
> > > 		return -1;  
> > 
> > There is no need for an early check.
> > Pick it up after the loop when 'srclen != 0'.
> >  
> 
> I think the early check is still needed, since I'm removing the
> padding '=' first.
> This makes the handling logic consistent for both padded and unpadded
> inputs, and avoids extra if conditions for padding inside the hot loop.

The 'invalid input' check will detect the padding.
Then you don't get an extra check if there is no padding (probably normal).
I realised I didn't get it quite right - updated below.

> 
> > > 
> > > 	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));  
> > 
> > Ugg - having a memcpy() here is not a good idea.
> > It really is better to have 3 arrays, but use a 'mostly common' initialiser.
> > Perhaps:
> > #define BASE64_REV_INIT(ch_62, ch_63) = { \
> > 	[0 ... 255] = -1, \
> > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
> > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
> > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
> > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > 	[ch_62] = 62, [ch_63] = 63, \
> > }
> > 
> > static const s8 base64_rev_maps[][256] = {
> > 	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > 	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> > 	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> > };
> > 
> > Then (after validating variant):
> > 	const s8 *map = base64_rev_maps[variant];
> >  
> 
> Got it. I'll switch to using three static tables with a common initializer
> as you suggested.
> 
> > > 
> > > 	if (variant < BASE64_STD || variant > BASE64_IMAP)
> > > 		return -1;
> > > 
> > > 	base64_rev_tables[base64_symbols[variant].char62] = 62;
> > > 	base64_rev_tables[base64_symbols[variant].char63] = 63;
> > > 
> > > 	while (padding && srclen > 0 && src[srclen - 1] == '=') {
> > > 		pad_cnt++;
> > > 		srclen--;
> > > 		if (pad_cnt > 2)
> > > 			return -1;
> > > 	}  
> > 
> > I'm not sure I'd to that there.
> > You are (in some sense) optimising for padding.
> > From what I remember, "abcd" gives 24 bits, "abc=" 16 and "ab==" 8.
> >   
> > > 
> > > 	while (srclen >= 4) {
> > > 		/* Decode the next 4 characters */
> > > 		input1 = base64_rev_tables[(u8)src[0]];
> > > 		input2 = base64_rev_tables[(u8)src[1]];
> > > 		input3 = base64_rev_tables[(u8)src[2]];
> > > 		input4 = base64_rev_tables[(u8)src[3]];  
> > 
> > I'd be tempted to make src[] unsigned - probably be assigning the parameter
> > to a local at the top of the function.
> > 
> > Also you have input3 = ... src[2]...
> > Perhaps they should be input[0..3] instead.
> >  
> 
> OK, I'll make the changes.
> 
> > > 
> > > 		val = (input1 << 18) |
> > > 		      (input2 << 12) |
> > > 		      (input3 << 6) |
> > > 		      input4;  
> > 
> > Four lines is excessive, C doesn't require the () and I'm not sure the
> > compilers complain about << and |.
> >   
> 
> OK, I'll make the changes.
> 
> > > 
> > > 		if (unlikely((s32)val < 0))
> > > 			return -1;  
> > 
> > Make 'val' signed - then you don't need the cast.
...
> > Or, if you really want to use the code below the loop:
> > 			if (!padding || src[3] != '=')
> > 				return -1;
> > 			padding = 0;
> > 			srclen -= 1 + (src[2] == '=');
> > 			break;

That is missing a test...
Change to:
			if (!padding || srclen != 4 || src[3] != '=')
				return -1;
			padding = 0;
			srclen = src[2] == '=' ? 2 : 3;
			break;

The compiler will then optimise away the first checks after the
loop because it knows they can't happen.

> > 
> >   
> > > 
> > > 		*bp++ = (u8)(val >> 16);
> > > 		*bp++ = (u8)(val >> 8);
> > > 		*bp++ = (u8)val;  
> > 
> > You don't need those casts.
> >  
> 
> OK, I'll make the changes.
> 
> > > 
> > > 		src += 4;
> > > 		srclen -= 4;
> > > 	}
> > > 
> > > 	/* Handle leftover characters when padding is not used */  
> > 
> > You are coming here with padding.
> > I'm not sure what should happen without padding.
> > For a multi-line file decode I suspect the characters need adding to
> > the start of the next line (ie lines aren't required to contain
> > multiples of 4 characters - even though they almost always will).
> >   
> 
> Ah, my mistake. I forgot to remove that comment.
> Based on my observation, base64_decode() should process the entire input
> buffer in a single call, so I believe it does not need to handle
> multi-line input.

I was thinking of the the case where it is processing the output of
something like base64encode.
The caller will have separated out the lines, but I don't know whether
every line has to contain a multiple of 4 characters - or whether the
lines can be arbitrarily split after being encoded (I know that won't
normally happen - but you never know). 

> 
> Best regards,
> Guan-Chun
> 
> > > 	if (srclen > 0) {
> > > 		switch (srclen) {  
> > 
> > You don't need an 'if' and a 'switch'.
> > srclen is likely to be zero, but perhaps write as:
> > 	if (likely(!srclen))
> > 		return bp - dst;
> > 	if (padding || srclen == 1)
> > 		return -1;
> > 
> > 	val = base64_rev_tables[(u8)src[0]] << 12 | base64_rev_tables[(u8)src[1]] << 6;
> > 	*bp++ = val >> 10;
> > 	if (srclen == 1) {
Obviously should be (srclen == 2)
> > 		if (val & 0x800003ff)
> > 			return -1;
> > 	} else {
> > 		val |= base64_rev_tables[(u8)src[2]];
> > 		if (val & 0x80000003)
> > 			return -1;
> > 		*bp++ = val >> 2;
> > 	}
> > 	return bp - dst;
> > }
> > 
> > 	David

	David

> >   
> > > 		case 2:
> > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > 			val = (input1 << 6) | input2; /* 12 bits */
> > > 			if (unlikely((s32)val < 0 || val & 0x0F))
> > > 				return -1;
> > > 
> > > 			*bp++ = (u8)(val >> 4);
> > > 			break;
> > > 		case 3:
> > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > 			input3 = base64_rev_tables[(u8)src[2]];
> > > 
> > > 			val = (input1 << 12) |
> > > 			      (input2 << 6) |
> > > 			      input3; /* 18 bits */
> > > 			if (unlikely((s32)val < 0 || val & 0x03))
> > > 				return -1;
> > > 
> > > 			*bp++ = (u8)(val >> 10);
> > > 			*bp++ = (u8)(val >> 2);
> > > 			break;
> > > 		default:
> > > 			return -1;
> > > 		}
> > > 	}
> > > 
> > > 	return bp - dst;
> > > }
> > > Based on KUnit testing, the performance results are as follows:
> > > 	base64_performance_tests: [64B] decode run : 40ns
> > > 	base64_performance_tests: [1KB] decode run : 463ns
> > > 
> > > However, this approach introduces an issue. It uses 256 bytes of memory
> > > on the stack for base64_rev_tables, which might not be ideal. Does anyone
> > > have any thoughts or alternative suggestions to solve this issue, or is it
> > > not really a concern?
> > > 
> > > Best regards,
> > > Guan-Chun
> > >   
> > > > > 
> > > > > Best,
> > > > > Caleb    
> > > >     
> >   


