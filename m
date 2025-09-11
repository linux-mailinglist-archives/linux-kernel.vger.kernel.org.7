Return-Path: <linux-kernel+bounces-812740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E5B53C09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAA7AA61EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542625A642;
	Thu, 11 Sep 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvrkqwEJ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED2258ED8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617254; cv=none; b=BE9QgET3l6JUyfzAvmmwj80IA7pZokTlwPvM9+ZIM5kcVge+6ERbfN6V5TVY3ZS+bm28z2lGK3xqCJw8EuC5efbBrukZj7gXsqLAxKhImfTD3NIgHqL4ncOEatg8H/w+K+L0MkoXytyDts5fy/i1jAkqnBVuIBtArQwS95QjOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617254; c=relaxed/simple;
	bh=CMQbWvL35NGiKpRsKtPmgoLpczTG57AawYwSUnRe08I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV6wFo9/5968/XWls7XkT3DKIBXTHD5d+LpSkDwy81GHIB4qwFQaX838XbKmtcjpw7IZBg1lQ36e9vGnMzDJCE3vCLvNcfTCKNx+DsGc+Rger3n3Ct+S1WJv9gkP5/SpmEgBNUAXMrX5GkFEyrrB1gBMc/TD5bp7/nvOnBHBedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvrkqwEJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77256200f1bso1130283b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617252; x=1758222052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tF1OTr2rtCxy3jTEKLVALatHVlDvvfc6+FzIrMIIxc4=;
        b=fvrkqwEJEBXaGtXnPKVpZjXRogDl2sRl5XFL/z3EhlUYNsWS/iUenkeQxK2O18JYQN
         kuTbtQg34JDgnEfLYFnzoWP1J9E1TItNMbOYdv2CpgD1GFCN3SQ0V2XUtEbBsi5tQGBe
         OHEW0bbfhvW4Q6Gt3mhSxRsmhO4qqhFYKhP+Fxyf434GuIUu6o139SLi8HBEacqTdY8R
         UusgJ4dDuMyZVFQ7WwQ0BDu5ARo+KzYEoI9YZALidF5qutfa3KddZtPMT7E+jwTBK4qe
         YpnANLsU0QaChQIEbb1qVIiBE3I2jTMjJ8Zg3OAIlW0EbXIBxSMVnf/lh7H2sQGyNVkg
         PESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617252; x=1758222052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF1OTr2rtCxy3jTEKLVALatHVlDvvfc6+FzIrMIIxc4=;
        b=jMIa6XNvDLEKhF8ERIoPCRR2fQHAIu+uMzOlMQBmjLf9+LAMf9+9TG0sCge+vSNUO2
         3ib97KXzgU38FnzGnbFAUNEA+HRT6xmmfYYXasGjr2U/UJZE0ioXAWTxlLisHK/EuE6Z
         MKCDr7NypYMnXL21LmjQlFxRt/ZA0Oo1vNrhjrN0NYEgCY1sypSHlYcqLFT2+J8gv4Ay
         pNN+WVgbkrhEPj1Xjk7HgWe1dDX68brx01L7Ms5eZq0wdn9if7I8j878gBnYnsRKr57N
         pBp4mK+wM+h1GfTr6o3CVN2AxMFzX/5gjZUt2cw7+x9gr45d93nJJSuRmQFbE5TTdipW
         kY6A==
X-Forwarded-Encrypted: i=1; AJvYcCWPKzeVEOO/ESDV+dF3xDyC+a0wa5p0QvaMXKDb6K+XgrqKibMvYTBj3LaMqSVRcHZhS5yDI0/HXVkDYao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq7YZDNTrBmcoqN2+ymhNN3Hgcf4vv3dXzvH7uOJz0ythQUwov
	SBWDDhW2qLPR47LMVwyTDkDbbdxLRDQ6iDJnX6QfCgE9u2By4IjyX1Ua
X-Gm-Gg: ASbGncsXZCZ9cDGj2OEvpvNS1v4qjzt8GNJiRsdjSzwZ2CdCUGcbTeB1OsHOdoXZq7k
	saFvnstUtWchBQo5JjxmZb9vk/ex668R76dauneYqfHSYeeD16P/OeUO5TMcsXiG0SFuedIAViF
	HiqGEI24IDmp6zjjwoNE80B5blh6Wd/Wd9XmsKlyMFCRFW6WgUwNiYfctF5ONyn3FP9B90ZHSsU
	mPZ5wgLCmpxHNKqYuzFk8VoL9mATBTIYlOeWUnOerPw+/24j4iIPTuvV/F6ICkNmCp/m9MnVu/u
	+DDw7giMnDq434iTWEAZBdlzrQmbhXuYPRo13Jh0AuXXNEGRVhRin77GY2FYfmc8Ypilk7C/CYK
	PsIdNrP0znVPvkNjoyMhATJtHzuDE5tnXTo4yTKPRXwkFL7buNAhoqKgauEb5SMB4Gp2zCfjHpx
	6nHuOExA==
X-Google-Smtp-Source: AGHT+IFKgGjLknGkp8jc1chBYIIHFKqurKXfUj4cl8o1arPPk6MKDJNmBOPLMnF+vJ6NN+q1YLvRog==
X-Received: by 2002:a05:6a00:2307:b0:772:4b05:78c1 with SMTP id d2e1a72fcca58-77612079eeamr536333b3a.3.1757617251633;
        Thu, 11 Sep 2025 12:00:51 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b340ffsm2810127b3a.76.2025.09.11.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:00:51 -0700 (PDT)
Date: Fri, 12 Sep 2025 03:00:47 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
	axboe@kernel.dk, ceph-devel@vger.kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <aMMcX8jEoBjBUeyj@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <20250911181418.GB1376@sol>
 <aMMYmfVfmkm7Ei+6@visitorckw-System-Product-Name>
 <20250911184935.GE1376@sol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911184935.GE1376@sol>

On Thu, Sep 11, 2025 at 11:49:35AM -0700, Eric Biggers wrote:
> On Fri, Sep 12, 2025 at 02:44:41AM +0800, Kuan-Wei Chiu wrote:
> > Hi Eric,
> > 
> > On Thu, Sep 11, 2025 at 11:14:18AM -0700, Eric Biggers wrote:
> > > On Thu, Sep 11, 2025 at 03:32:04PM +0800, Guan-Chun Wu wrote:
> > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > 
> > > > The base64 decoder previously relied on strchr() to locate each
> > > > character in the base64 table. In the worst case, this requires
> > > > scanning all 64 entries, and even with bitwise tricks or word-sized
> > > > comparisons, still needs up to 8 checks.
> > > > 
> > > > Introduce a small helper function that maps input characters directly
> > > > to their position in the base64 table. This reduces the maximum number
> > > > of comparisons to 5, improving decoding efficiency while keeping the
> > > > logic straightforward.
> > > > 
> > > > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > > > over 1000 runs, tested with KUnit):
> > > > 
> > > > Decode:
> > > >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> > > >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> > > > 
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > ---
> > > >  lib/base64.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > index b736a7a43..9416bded2 100644
> > > > --- a/lib/base64.c
> > > > +++ b/lib/base64.c
> > > > @@ -18,6 +18,21 @@
> > > >  static const char base64_table[65] =
> > > >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > > >  
> > > > +static inline const char *find_chr(const char *base64_table, char ch)
> > > > +{
> > > > +	if ('A' <= ch && ch <= 'Z')
> > > > +		return base64_table + ch - 'A';
> > > > +	if ('a' <= ch && ch <= 'z')
> > > > +		return base64_table + 26 + ch - 'a';
> > > > +	if ('0' <= ch && ch <= '9')
> > > > +		return base64_table + 26 * 2 + ch - '0';
> > > > +	if (ch == base64_table[26 * 2 + 10])
> > > > +		return base64_table + 26 * 2 + 10;
> > > > +	if (ch == base64_table[26 * 2 + 10 + 1])
> > > > +		return base64_table + 26 * 2 + 10 + 1;
> > > > +	return NULL;
> > > > +}
> > > > +
> > > >  /**
> > > >   * base64_encode() - base64-encode some binary data
> > > >   * @src: the binary data to encode
> > > > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> > > >  	u8 *bp = dst;
> > > >  
> > > >  	for (i = 0; i < srclen; i++) {
> > > > -		const char *p = strchr(base64_table, src[i]);
> > > > +		const char *p = find_chr(base64_table, src[i]);
> > > >  
> > > >  		if (src[i] == '=') {
> > > >  			ac = (ac << 6);
> > > 
> > > But this makes the contents of base64_table no longer be used, except
> > > for entries 62 and 63.  So this patch doesn't make sense.  Either we
> > > should actually use base64_table, or we should remove base64_table and
> > > do the mapping entirely in code.
> > > 
> > For base64_decode(), you're right. After this patch it only uses the last
> > two entries of base64_table. However, base64_encode() still makes use of
> > the entire table.
> > 
> > I'm a bit unsure why it would be unacceptable if only one of the two
> > functions relies on the full base64 table.
> 
> Well, don't remove the table then.  But please don't calculate pointers
> into it, only to take the offset from the beginning and never actually
> dereference them.  You should just generate the offset directly.
> 
Agreed. Thanks for the review.
I'll make that change in the next version.

Regards,
Kuan-Wei


