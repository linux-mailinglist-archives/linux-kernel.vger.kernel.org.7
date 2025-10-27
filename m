Return-Path: <linux-kernel+bounces-871644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A875FC0DE3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7AF634CF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C526056D;
	Mon, 27 Oct 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="C9itIBJB"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B955258ECA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570728; cv=none; b=FJKE2vwZKtsA1dlqHOPPdotAjdoFms4610kRWZ9VrTBCpiW+j7yzNIfWzRgHAThO9IejvJ2lzm9i9dj9o+61m5irETqewueN32p+siaSXy2mEym0+1AZZ3KrZkFAyt/hsFOgnmb6IzySy8yK/trSsdojhd/FYYDrhLUbnUDGg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570728; c=relaxed/simple;
	bh=RxODQK9iX8R1B/vCOJ29vmwlQgvahBpmQhh4qJyamzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGxlW2b/uuUskumZFOLVEuEkFEZajWKAJS5C7RDIq0dZJcm0/vd9LPrD4tFkrQPvo9gpkp4f966KJEo9Vmu9sO70aAHoZXLQFVZs3kJPq0/fdiojFBTSnfnAO+6XigloJ6MePcx5m/QRoCjmAu+lcazwpOSipr1OXUViMBLEKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=C9itIBJB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b679450ecb6so3396402a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761570725; x=1762175525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YHYAm5clDKGEgl2cOgr+YFXcUNktmsVcXuwqgoHg62Q=;
        b=C9itIBJB6+O1ZA8fNqt6pbGdmy1UXawioxrf7oIfw8dSb6zUQxogHbBoB5LswlGvBg
         DO61O6wKUSnkh1+VSXYPAuAr1hMdYo6tO4n7dq8YJeSf0fisQJwzwLGrNDtEN/7fv1Ft
         fcjNIkUaR+SAAnyyiNMvlozIJnKE5QTUBQJz8wyp6kDakr6/s3Db+WtSVCVq6qd8CdB+
         efnd9DFnTMUIR3812T1UATkOzYbRpbI1O5nHecvpnG4wjVjD/qx1K/GA46Pq+IrvLGoX
         tfdMqPJTIzF6u9nM2eK4vzP5hag10MhquGxbwjW5Q2bOZu/kscVPaOkM84knCVOrJVoW
         1z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570725; x=1762175525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHYAm5clDKGEgl2cOgr+YFXcUNktmsVcXuwqgoHg62Q=;
        b=LpAcMR0+ZQkdSaLp0O6sfDIaGvrZuhmZfcx3qn1OSFV7NWgPafdqKaCPJz9RbT1XA2
         2hCRRaTxG5EibWkyPDhk86UdYw76Fq515Ql1VOMUlI04fQgm8heP2vhQRHcILPzdihEB
         mI50VN5VsQzsCfWR9HQCAlJ+I9oFbUrvk9aoFDIPNdOKAbWQyHq/UuLzIO0v3xzOtBla
         PxA91yuWyxUY2397YtC7flnsHLE/WLojHky7DdJjKWTzDZfdgGmNjJJUxA33NJLMhtZK
         O61WXN8B+HfpHUZ9EPKt6NDG7T1CuINrnrHIdqEhOtFUZ5vOFZSMbzepGUgAKt1TqX8W
         3STA==
X-Forwarded-Encrypted: i=1; AJvYcCWD0RCfPvT8yCKD/u16SkUyWWJHZrfrp/I5o9uqqunqfjjDAbBvhmZCN+JMjh/6xZmwuRIdUm8+v1rXno4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXMIVQ34u6B1v83p7L5q1TKW739VWrJc3EeJx5KgOD6C8gAuYC
	CEvrBYcFGDYsk7wU4On4ArFXYxS05mlVlelBcDLu4DBt++ZZ5YYd395jPjXVSetkNVI=
X-Gm-Gg: ASbGnctH9n1rrL3Fu4Zr+F33tW53fQ4FUht3pxTMJSxer7UtiI5J4vhSoXeA2B4IgUV
	Ak+8Bxes12Thc2UbkofjxSZCLAZFtZzokh6SxxHKj/pgjC+XFk7Qfdww1mMklbI7EEnqXANVfv8
	A+xDxJHhEjHx1ya4SQFbMQiUaeVCCleDkmxQjD5UtaH3wE3szBL5qV958qSmFPp2ISNVakl3oT3
	V2zAEZHhvtoYgKPasTAChTXLrHK8Mqvl+iSfO8hQqozLIF23qN9mKt3ivpim2mBkJLq0jaYkmdE
	ldcQhiwRu34gck9rsEOjdPjUsQCQlhBU46JK1o5loGGtbK5hX5KgRHfLIy11UPNuWC+TARAjcdN
	GgONRWjiWRN4hOfkRUmFVhoodztlrouzsX02BHysOtXi+CyoDvfzfRK7HIV24Gw1yVsG+W5UV47
	e76mZnWRyI9qctyqlPoBFx
X-Google-Smtp-Source: AGHT+IFRgrc7hf2+6CuHsBHMzYgRmSG6lQVmw3vlPAYNWTFNGjLEiLeTnXfLTsx0w4DvUGGNsCkacQ==
X-Received: by 2002:a17:902:c410:b0:26d:d860:3db1 with SMTP id d9443c01a7336-2946dec239cmr180220365ad.24.1761570725236;
        Mon, 27 Oct 2025 06:12:05 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:745:9b32:70e1:48f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3b64sm84103415ad.3.2025.10.27.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:12:04 -0700 (PDT)
Date: Mon, 27 Oct 2025 21:12:00 +0800
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
Message-ID: <aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
References: <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
 <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
 <20251005181803.0ba6aee4@pumpkin>
 <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
 <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
 <20251007192327.57f00588@pumpkin>
 <aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
 <20251010105138.0356ad75@pumpkin>
 <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
 <20251014091420.173dfc9c@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014091420.173dfc9c@pumpkin>

On Tue, Oct 14, 2025 at 09:14:20AM +0100, David Laight wrote:
> On Mon, 13 Oct 2025 17:49:55 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
>
> > On Fri, Oct 10, 2025 at 10:51:38AM +0100, David Laight wrote:
> > > On Thu, 9 Oct 2025 20:25:17 +0800
> > > Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > > 
> > > ...  
> > > > As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid input.  
> > > 
> > > (to avoid two different input buffers giving the same output)
> > > 
> > > Which is annoyingly reasonable.
> > >   
> > > > One possible solution I came up with is to first create a shared
> > > > base64_rev_common lookup table as the base for all Base64 variants.
> > > > Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), we
> > > > can dynamically adjust the character mappings for position 62 and position 63
> > > > at runtime, based on the variant.
> > > > 
> > > > Here are the changes to the code:
> > > > 
> > > > static const s8 base64_rev_common[256] = {
> > > > 	[0 ... 255] = -1,
> > > > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
> > > > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
> > > > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
> > > > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> > > > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
> > > > };
> > > > 
> > > > static const struct {
> > > > 	char char62, char63;
> > > > } base64_symbols[] = {
> > > > 	[BASE64_STD] = { '+', '/' },
> > > > 	[BASE64_URLSAFE] = { '-', '_' },
> > > > 	[BASE64_IMAP] = { '+', ',' },
> > > > };
> > > > 
> > > > int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > > > {
> > > > 	u8 *bp = dst;
> > > > 	u8 pad_cnt = 0;
> > > > 	s8 input1, input2, input3, input4;
> > > > 	u32 val;
> > > > 	s8 base64_rev_tables[256];
> > > > 
> > > > 	/* Validate the input length for padding */
> > > > 	if (unlikely(padding && (srclen & 0x03) != 0))
> > > > 		return -1;  
> > > 
> > > There is no need for an early check.
> > > Pick it up after the loop when 'srclen != 0'.
> > >  
> > 
> > I think the early check is still needed, since I'm removing the
> > padding '=' first.
> > This makes the handling logic consistent for both padded and unpadded
> > inputs, and avoids extra if conditions for padding inside the hot loop.
> 
> The 'invalid input' check will detect the padding.
> Then you don't get an extra check if there is no padding (probably normal).
> I realised I didn't get it quite right - updated below.
> 
> > 
> > > > 
> > > > 	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));  
> > > 
> > > Ugg - having a memcpy() here is not a good idea.
> > > It really is better to have 3 arrays, but use a 'mostly common' initialiser.
> > > Perhaps:
> > > #define BASE64_REV_INIT(ch_62, ch_63) = { \
> > > 	[0 ... 255] = -1, \
> > > 	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> > > 		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, \
> > > 	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, \
> > > 		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, \
> > > 	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > > 	[ch_62] = 62, [ch_63] = 63, \
> > > }
> > > 
> > > static const s8 base64_rev_maps[][256] = {
> > > 	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > > 	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> > > 	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> > > };
> > > 
> > > Then (after validating variant):
> > > 	const s8 *map = base64_rev_maps[variant];
> > >  
> > 
> > Got it. I'll switch to using three static tables with a common initializer
> > as you suggested.
> > 
> > > > 
> > > > 	if (variant < BASE64_STD || variant > BASE64_IMAP)
> > > > 		return -1;
> > > > 
> > > > 	base64_rev_tables[base64_symbols[variant].char62] = 62;
> > > > 	base64_rev_tables[base64_symbols[variant].char63] = 63;
> > > > 
> > > > 	while (padding && srclen > 0 && src[srclen - 1] == '=') {
> > > > 		pad_cnt++;
> > > > 		srclen--;
> > > > 		if (pad_cnt > 2)
> > > > 			return -1;
> > > > 	}  
> > > 
> > > I'm not sure I'd to that there.
> > > You are (in some sense) optimising for padding.
> > > From what I remember, "abcd" gives 24 bits, "abc=" 16 and "ab==" 8.
> > >   
> > > > 
> > > > 	while (srclen >= 4) {
> > > > 		/* Decode the next 4 characters */
> > > > 		input1 = base64_rev_tables[(u8)src[0]];
> > > > 		input2 = base64_rev_tables[(u8)src[1]];
> > > > 		input3 = base64_rev_tables[(u8)src[2]];
> > > > 		input4 = base64_rev_tables[(u8)src[3]];  
> > > 
> > > I'd be tempted to make src[] unsigned - probably be assigning the parameter
> > > to a local at the top of the function.
> > > 
> > > Also you have input3 = ... src[2]...
> > > Perhaps they should be input[0..3] instead.
> > >  
> > 
> > OK, I'll make the changes.
> > 
> > > > 
> > > > 		val = (input1 << 18) |
> > > > 		      (input2 << 12) |
> > > > 		      (input3 << 6) |
> > > > 		      input4;  
> > > 
> > > Four lines is excessive, C doesn't require the () and I'm not sure the
> > > compilers complain about << and |.
> > >   
> > 
> > OK, I'll make the changes.
> > 
> > > > 
> > > > 		if (unlikely((s32)val < 0))
> > > > 			return -1;  
> > > 
> > > Make 'val' signed - then you don't need the cast.
> ...
> > > Or, if you really want to use the code below the loop:
> > > 			if (!padding || src[3] != '=')
> > > 				return -1;
> > > 			padding = 0;
> > > 			srclen -= 1 + (src[2] == '=');
> > > 			break;
> 
> That is missing a test...
> Change to:
> 			if (!padding || srclen != 4 || src[3] != '=')
> 				return -1;
> 			padding = 0;
> 			srclen = src[2] == '=' ? 2 : 3;
> 			break;
>
> The compiler will then optimise away the first checks after the
> loop because it knows they can't happen.

Hi David,

I noticed your suggested approach:
val_24 = t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
Per the C11 draft, this can lead to undefined behavior.
"If E1 has a signed type and nonnegative value, and E1 � 2^E2 is
representable in the result type, then that is the resulting value;
otherwise, the behavior is undefined."
Therefore, left-shifting a negative signed value is undefined behavior.

Perhaps we could change the code as shown below. What do you think?

int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
{
	u8 *bp = dst;
	s8 input[4];
	u32 val;
	const u8 *s = (const u8 *)src;
	const s8 *base64_rev_table = base64_rev_maps[variant];

	while (srclen >= 4) {
		input[0] = base64_rev_table[s[0]];
		input[1] = base64_rev_table[s[1]];
		input[2] = base64_rev_table[s[2]];
		input[3] = base64_rev_table[s[3]];

		if (unlikely((input[0] | input[1] | input[2] | input[3]) < 0)) {
			if (!padding || srclen != 4 || s[3] != '=')
				return -1;
			padding = 0;
			srclen = s[2] == '=' ? 2 : 3;
			break;
		}

		val = (u32)input[0] << 18 | (u32)input[1] << 12 |
			(u32)input[2] << 6 | (u32)input[3];

		*bp++ = val >> 16;
		*bp++ = val >> 8;
		*bp++ = val;

		s += 4;
		srclen -= 4;
	}

	if (likely(!srclen))
		return bp - dst;
	if (padding || srclen == 1)
		return -1;

	input[0] = base64_rev_table[s[0]];
	input[1] = base64_rev_table[s[1]];

	if (unlikely(input[0] < 0 || input[1] < 0))
		return -1;

	val = (u32)input[0] << 18 | (u32)input[1] << 12;

	if (srclen == 2) {
		if (unlikely(input[1] & 0x0f))
			return -1;
		*bp++ = val >> 16;
	} else {
		input[2] = base64_rev_table[s[2]];
		if (unlikely(input[2] < 0 || (input[2] & 0x03)))
			return -1;
		val |= (u32)input[2] << 6;
		*bp++ = val >> 16;
		*bp++ = val >> 8;
	}

	return bp - dst;
}

Best regards,
Guan-Chun

> > > 
> > >   
> > > > 
> > > > 		*bp++ = (u8)(val >> 16);
> > > > 		*bp++ = (u8)(val >> 8);
> > > > 		*bp++ = (u8)val;  
> > > 
> > > You don't need those casts.
> > >  
> > 
> > OK, I'll make the changes.
> > 
> > > > 
> > > > 		src += 4;
> > > > 		srclen -= 4;
> > > > 	}
> > > > 
> > > > 	/* Handle leftover characters when padding is not used */  
> > > 
> > > You are coming here with padding.
> > > I'm not sure what should happen without padding.
> > > For a multi-line file decode I suspect the characters need adding to
> > > the start of the next line (ie lines aren't required to contain
> > > multiples of 4 characters - even though they almost always will).
> > >   
> > 
> > Ah, my mistake. I forgot to remove that comment.
> > Based on my observation, base64_decode() should process the entire input
> > buffer in a single call, so I believe it does not need to handle
> > multi-line input.
> 
> I was thinking of the the case where it is processing the output of
> something like base64encode.
> The caller will have separated out the lines, but I don't know whether
> every line has to contain a multiple of 4 characters - or whether the
> lines can be arbitrarily split after being encoded (I know that won't
> normally happen - but you never know). 
> 
> > 
> > Best regards,
> > Guan-Chun
> > 
> > > > 	if (srclen > 0) {
> > > > 		switch (srclen) {  
> > > 
> > > You don't need an 'if' and a 'switch'.
> > > srclen is likely to be zero, but perhaps write as:
> > > 	if (likely(!srclen))
> > > 		return bp - dst;
> > > 	if (padding || srclen == 1)
> > > 		return -1;
> > > 
> > > 	val = base64_rev_tables[(u8)src[0]] << 12 | base64_rev_tables[(u8)src[1]] << 6;
> > > 	*bp++ = val >> 10;
> > > 	if (srclen == 1) {
> Obviously should be (srclen == 2)
> > > 		if (val & 0x800003ff)
> > > 			return -1;
> > > 	} else {
> > > 		val |= base64_rev_tables[(u8)src[2]];
> > > 		if (val & 0x80000003)
> > > 			return -1;
> > > 		*bp++ = val >> 2;
> > > 	}
> > > 	return bp - dst;
> > > }
> > > 
> > > 	David
> 
> 	David
> 
> > >   
> > > > 		case 2:
> > > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > > 			val = (input1 << 6) | input2; /* 12 bits */
> > > > 			if (unlikely((s32)val < 0 || val & 0x0F))
> > > > 				return -1;
> > > > 
> > > > 			*bp++ = (u8)(val >> 4);
> > > > 			break;
> > > > 		case 3:
> > > > 			input1 = base64_rev_tables[(u8)src[0]];
> > > > 			input2 = base64_rev_tables[(u8)src[1]];
> > > > 			input3 = base64_rev_tables[(u8)src[2]];
> > > > 
> > > > 			val = (input1 << 12) |
> > > > 			      (input2 << 6) |
> > > > 			      input3; /* 18 bits */
> > > > 			if (unlikely((s32)val < 0 || val & 0x03))
> > > > 				return -1;
> > > > 
> > > > 			*bp++ = (u8)(val >> 10);
> > > > 			*bp++ = (u8)(val >> 2);
> > > > 			break;
> > > > 		default:
> > > > 			return -1;
> > > > 		}
> > > > 	}
> > > > 
> > > > 	return bp - dst;
> > > > }
> > > > Based on KUnit testing, the performance results are as follows:
> > > > 	base64_performance_tests: [64B] decode run : 40ns
> > > > 	base64_performance_tests: [1KB] decode run : 463ns
> > > > 
> > > > However, this approach introduces an issue. It uses 256 bytes of memory
> > > > on the stack for base64_rev_tables, which might not be ideal. Does anyone
> > > > have any thoughts or alternative suggestions to solve this issue, or is it
> > > > not really a concern?
> > > > 
> > > > Best regards,
> > > > Guan-Chun
> > > >   
> > > > > > 
> > > > > > Best,
> > > > > > Caleb    
> > > > >     
> > >   
> 

