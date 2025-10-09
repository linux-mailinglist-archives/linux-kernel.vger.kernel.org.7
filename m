Return-Path: <linux-kernel+bounces-846774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8427BC9018
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC5E3AD833
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AAC2E11CB;
	Thu,  9 Oct 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="qoa0iyNh"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F02E091C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012728; cv=none; b=WrLD5F+Wpc+tV8XZBklLi+0tEnj5k7BOzfZsjW2nNp0kYfTo+NagFKbGjv/ATIrVBZlLt78DxzKyKIqM/p4NmtXWvxJpBURC+5a0BJLh3uaaS6L+1mC0JMrFXfNAtA02eapZV9CMW56pH2LCa7mO7BsHSG7Y9Q8PinghXSgYthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012728; c=relaxed/simple;
	bh=A24Sa6uRUXw6ldo2PVWXOUy6zgWJd0pySZ4YjOJDEd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNlLtH0Iz+4GiYeAwQpwstZpXL8uzGdI+TX8Wj7cb+KwRTbMpIWrcAo+BWDZmCEnoTeiGnqFs9A6Ru62l3p/n9nIJiUk+frNIbMyaKLDKUEa+poeGBVE8xRoXb6aeV3QOe5vnRMwN2YHtcWyj7lT2m9O7Y6rA4NlvSd131HbLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=qoa0iyNh; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b633b54d05dso522765a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1760012724; x=1760617524; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OYQvJueBp9Hb/2I6l768e5MEp3i8BWM6X0GXynYYlZA=;
        b=qoa0iyNhDv9SgEU2viCMhDkjd1dbuKObveUmpoqyQSIWmSfmMtWufopqk8EZauB1SA
         Y8NxAwiseZTe9SXu0ZrrKjiy8Q7hDcAwv3QrX4+YIi5Co8YnVXCnaGhKUnXaOEImgAuf
         294dn8lZBruU0VDSdTeE/38viNnxy5KC5vzibeqIDrnjbI7Akb/drW37kHa/Ydm3Xund
         5au/m6haAWzhDwSHmAzk1/Hetf3M6YF9QLLIlqhsxMf5Mv2KXyHNBJy1Vrwy/S7U9d2F
         gWuo7go6tn3FhGImCHMx9hmLt6MUjN+OS9mi88fXNFNGPJU46NJp1JHLP/j1H9suc5wg
         838w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012724; x=1760617524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYQvJueBp9Hb/2I6l768e5MEp3i8BWM6X0GXynYYlZA=;
        b=XXE2gHBzbBXDhRTPwauP9TtXGWlnNbZcpSolsNJKOnHOUg1tSZIoeo/K9jeni/vofj
         Y6cOXI/lcMubvDiyXS1UdkaaZLdgDPZtru/ydewy3hpLDWbxGUMF8DemqB+BAM76EzU0
         oL8rCwkG8IxuhD1j/JM4BF+XIn3jNyQbTX8bSVooOJsXEms/0hqvCFua2equZ4sPt0yz
         OmwLZSAW5B7Uqyc4aHPrkmdqHqYRwX7rjnDZFqi6u6WY7lMX9xnOOQD8wswjahU72tJs
         igt+9qNZDDW+6EkimmxnjwJiNaNMnZrqM7SEgkWT8AkzxBE05+6ur9IGtVECAHerCO6K
         B+zg==
X-Forwarded-Encrypted: i=1; AJvYcCUIpMJaNLgh3sUlo2M6E4X1aXxx4ig1AWdaKIu3rQVbKFCivXsgZPGbGD3SVXf0kvqqfbA5NFY3BrzfU1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4ELLSkufigCAwmEzRfJ7uaeJCspQinJbrsUY+rDQKRsjtuLs
	gLwGerTz6oHFpl1I6f2LS0XTMaiNGjaKe9jj0B2aVOmV5pwZx8P0Xhc2rC/TGCaDel4=
X-Gm-Gg: ASbGncub0Ui0w2dfosvg2SzPZpY6R7ogaVM9/yqW1yS4YCvDKfcYypJKwbB5Iw5F2FM
	b5H89TXSaMskciaGutwOci+i/W2weP9JMrXXxU9Q8EUGkFY9z79q9ioIf5aU3YB4dmTCLYH8uLY
	ktUQm1uSY5mxDAdtIlD8leI0KsIGoFErKuMR4JAlLfIsgzo0+UIUbagvVCt8R7h/oD9heAHO4MO
	jehF9Ve0zceE2BRcj729I8eKUhAGI6Ou74lfJEAi4Ltm4edBzx763b+9cEe+TGs4jQaWXKuDWQh
	LiwrrdW7BWGE5iAFSc72IklEu197dE9RWiN3qJaKx51iW3aiPpMoYe4/Sp9mpIqf6YevT7epedr
	V26GMCDoGHfRKZKRwdmNsM8FoZHWR8dH+sfQUXCAjRr0B7eKOvJE9xsI/4oFH4tuZ9XkS
X-Google-Smtp-Source: AGHT+IGXlF3weDiptjfQZEX78pP+MlLZCTm0BRTUwV4CgbXzIKSt1J+eqJtH5sinTFEIZe4r03A6zQ==
X-Received: by 2002:a17:902:ebc5:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-2902720f560mr93173395ad.5.1760012723418;
        Thu, 09 Oct 2025 05:25:23 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:d976:98e1:d1ef:fb3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f72esm27417355ad.118.2025.10.09.05.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:25:22 -0700 (PDT)
Date: Thu, 9 Oct 2025 20:25:17 +0800
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
Message-ID: <aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065556.14250-1-409411716@gms.tku.edu.tw>
 <CADUfDZruZWyrsjRCs_Y5gjsbfU7dz_ALGG61pQ8qCM7K2_DjmA@mail.gmail.com>
 <aNz/+xLDnc2mKsKo@wu-Pro-E500-G6-WS720T>
 <CADUfDZq4c3dRgWpevv3+29frvd6L8G9RRdoVFpFnyRsF3Eve1Q@mail.gmail.com>
 <20251005181803.0ba6aee4@pumpkin>
 <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
 <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
 <20251007192327.57f00588@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007192327.57f00588@pumpkin>

On Tue, Oct 07, 2025 at 07:23:27PM +0100, David Laight wrote:
> On Tue, 7 Oct 2025 07:57:16 -0700
> Caleb Sander Mateos <csander@purestorage.com> wrote:
> 
> > On Tue, Oct 7, 2025 at 1:28 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > >
> > > On Sun, Oct 05, 2025 at 06:18:03PM +0100, David Laight wrote:  
> > > > On Wed, 1 Oct 2025 09:20:27 -0700
> > > > Caleb Sander Mateos <csander@purestorage.com> wrote:
> > > >  
> > > > > On Wed, Oct 1, 2025 at 3:18 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:  
> > > > > >
> > > > > > On Fri, Sep 26, 2025 at 04:33:12PM -0700, Caleb Sander Mateos wrote:  
> > > > > > > On Thu, Sep 25, 2025 at 11:59 PM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:  
> > > > > > > >
> > > > > > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > > >
> > > > > > > > Replace the use of strchr() in base64_decode() with precomputed reverse
> > > > > > > > lookup tables for each variant. This avoids repeated string scans and
> > > > > > > > improves performance. Use -1 in the tables to mark invalid characters.
> > > > > > > >
> > > > > > > > Decode:
> > > > > > > >   64B   ~1530ns  ->  ~75ns    (~20.4x)
> > > > > > > >   1KB  ~27726ns  -> ~1165ns   (~23.8x)
> > > > > > > >
> > > > > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > > > > > ---
> > > > > > > >  lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
> > > > > > > >  1 file changed, 61 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > > > > > index 1af557785..b20fdf168 100644
> > > > > > > > --- a/lib/base64.c
> > > > > > > > +++ b/lib/base64.c
> > > > > > > > @@ -21,6 +21,63 @@ static const char base64_tables[][65] = {
> > > > > > > >         [BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +static const s8 base64_rev_tables[][256] = {
> ...
> > > > > > > Do we actually need 3 separate lookup tables? It looks like all 3
> > > > > > > variants agree on the value of any characters they have in common. So
> > > > > > > we could combine them into a single lookup table that would work for a
> > > > > > > valid base64 string of any variant. The only downside I can see is
> > > > > > > that base64 strings which are invalid in some variants might no longer
> > > > > > > be rejected by base64_decode().
> > > > > > >  
> > > > > >
> > > > > > In addition to the approach David mentioned, maybe we can use a common
> > > > > > lookup table for A–Z, a–z, and 0–9, and then handle the variant-specific
> > > > > > symbols with a switch.  
> > > >
> > > > It is certainly possible to generate the initialiser from a #define to
> > > > avoid all the replicated source.
> > > >  
> > > > > >
> > > > > > For example:
> > > > > >
> > > > > > static const s8 base64_rev_common[256] = {
> > > > > >     [0 ... 255] = -1,
> > > > > >     ['A'] = 0, ['B'] = 1, /* ... */, ['Z'] = 25,  
> > > >
> > > > If you assume ASCII (I doubt Linux runs on any EBCDIC systems) you
> > > > can assume the characters are sequential and miss ['B'] = etc to
> > > > reduce the the line lengths.
> > > > (Even EBCDIC has A-I J-R S-Z and 0-9 as adjacent values)
> > > >  
> > > > > >     ['a'] = 26, /* ... */, ['z'] = 51,
> > > > > >     ['0'] = 52, /* ... */, ['9'] = 61,
> > > > > > };
> > > > > >
> > > > > > static inline int base64_rev_lookup(u8 c, enum base64_variant variant) {
> > > > > >     s8 v = base64_rev_common[c];
> > > > > >     if (v != -1)
> > > > > >         return v;
> > > > > >
> > > > > >     switch (variant) {
> > > > > >     case BASE64_STD:
> > > > > >         if (c == '+') return 62;
> > > > > >         if (c == '/') return 63;
> > > > > >         break;
> > > > > >     case BASE64_IMAP:
> > > > > >         if (c == '+') return 62;
> > > > > >         if (c == ',') return 63;
> > > > > >         break;
> > > > > >     case BASE64_URLSAFE:
> > > > > >         if (c == '-') return 62;
> > > > > >         if (c == '_') return 63;
> > > > > >         break;
> > > > > >     }
> > > > > >     return -1;
> > > > > > }
> > > > > >
> > > > > > What do you think?  
> > > > >
> > > > > That adds several branches in the hot loop, at least 2 of which are
> > > > > unpredictable for valid base64 input of a given variant (v != -1 as
> > > > > well as the first c check in the applicable switch case).  
> > > >
> > > > I'd certainly pass in the character values for 62 and 63 so they are
> > > > determined well outside the inner loop.
> > > > Possibly even going as far as #define BASE64_STD ('+' << 8 | '/').
> > > >  
> > > > > That seems like it would hurt performance, no?
> > > > > I think having 3 separate tables
> > > > > would be preferable to making the hot loop more branchy.  
> > > >
> > > > Depends how common you think 62 and 63 are...
> > > > I guess 63 comes from 0xff bytes - so might be quite common.
> > > >
> > > > One thing I think you've missed is that the decode converts 4 characters
> > > > into 24 bits - which then need carefully writing into the output buffer.
> > > > There is no need to check whether each character is valid.
> > > > After:
> > > >       val_24 = t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
> > > > val_24 will be negative iff one of b[0..3] is invalid.
> > > > So you only need to check every 4 input characters, not for every one.
> > > > That does require separate tables.
> > > > (Or have a decoder that always maps "+-" to 62 and "/,_" to 63.)
> > > >
> > > >       David
> > > >  
> > >
> > > Thanks for the feedback.
> > > For the next revision, we’ll use a single lookup table that maps both +
> > > and - to 62, and /, _, and , to 63.
> > > Does this approach sound good to everyone?  
> > 
> > Sounds fine to me. Perhaps worth pointing out that the decision to
> > accept any base64 variant in the decoder would likely be permanent,
> > since users may come to depend on it. But I don't see any issue with
> > it as long as all the base64 variants agree on the values of their
> > common symbols.
> 
> If an incompatible version comes along it'll need a different function
> (or similar). But there is no point over-engineering it now.
> 
> 	David
> 
>

As Eric mentioned, the decoder in fs/crypto/ needs to reject invalid input.
One possible solution I came up with is to first create a shared
base64_rev_common lookup table as the base for all Base64 variants.
Then, depending on the variant (e.g., BASE64_STD, BASE64_URLSAFE, etc.), we
can dynamically adjust the character mappings for position 62 and position 63
at runtime, based on the variant.

Here are the changes to the code:

static const s8 base64_rev_common[256] = {
	[0 ... 255] = -1,
	['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12,
		13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
	['a'] = 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38,
		39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
	['0'] = 52, 53, 54, 55, 56, 57, 58, 59, 60, 61,
};

static const struct {
	char char62, char63;
} base64_symbols[] = {
	[BASE64_STD] = { '+', '/' },
	[BASE64_URLSAFE] = { '-', '_' },
	[BASE64_IMAP] = { '+', ',' },
};

int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
{
	u8 *bp = dst;
	u8 pad_cnt = 0;
	s8 input1, input2, input3, input4;
	u32 val;
	s8 base64_rev_tables[256];

	/* Validate the input length for padding */
	if (unlikely(padding && (srclen & 0x03) != 0))
		return -1;

	memcpy(base64_rev_tables, base64_rev_common, sizeof(base64_rev_common));

	if (variant < BASE64_STD || variant > BASE64_IMAP)
		return -1;

	base64_rev_tables[base64_symbols[variant].char62] = 62;
	base64_rev_tables[base64_symbols[variant].char63] = 63;

	while (padding && srclen > 0 && src[srclen - 1] == '=') {
		pad_cnt++;
		srclen--;
		if (pad_cnt > 2)
			return -1;
	}

	while (srclen >= 4) {
		/* Decode the next 4 characters */
		input1 = base64_rev_tables[(u8)src[0]];
		input2 = base64_rev_tables[(u8)src[1]];
		input3 = base64_rev_tables[(u8)src[2]];
		input4 = base64_rev_tables[(u8)src[3]];

		val = (input1 << 18) |
		      (input2 << 12) |
		      (input3 << 6) |
		      input4;

		if (unlikely((s32)val < 0))
			return -1;

		*bp++ = (u8)(val >> 16);
		*bp++ = (u8)(val >> 8);
		*bp++ = (u8)val;

		src += 4;
		srclen -= 4;
	}

	/* Handle leftover characters when padding is not used */
	if (srclen > 0) {
		switch (srclen) {
		case 2:
			input1 = base64_rev_tables[(u8)src[0]];
			input2 = base64_rev_tables[(u8)src[1]];
			val = (input1 << 6) | input2; /* 12 bits */
			if (unlikely((s32)val < 0 || val & 0x0F))
				return -1;

			*bp++ = (u8)(val >> 4);
			break;
		case 3:
			input1 = base64_rev_tables[(u8)src[0]];
			input2 = base64_rev_tables[(u8)src[1]];
			input3 = base64_rev_tables[(u8)src[2]];

			val = (input1 << 12) |
			      (input2 << 6) |
			      input3; /* 18 bits */
			if (unlikely((s32)val < 0 || val & 0x03))
				return -1;

			*bp++ = (u8)(val >> 10);
			*bp++ = (u8)(val >> 2);
			break;
		default:
			return -1;
		}
	}

	return bp - dst;
}
Based on KUnit testing, the performance results are as follows:
	base64_performance_tests: [64B] decode run : 40ns
	base64_performance_tests: [1KB] decode run : 463ns

However, this approach introduces an issue. It uses 256 bytes of memory
on the stack for base64_rev_tables, which might not be ideal. Does anyone
have any thoughts or alternative suggestions to solve this issue, or is it
not really a concern?

Best regards,
Guan-Chun

> > 
> > Best,
> > Caleb
> 

