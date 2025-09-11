Return-Path: <linux-kernel+bounces-812541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34BFB5396F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69458485433
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47135A290;
	Thu, 11 Sep 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og4OG157"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA03570B3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608708; cv=none; b=mclyU6ejTlml6mCvvw9kXFmYDbSQhz/bbFEJRbFeZ3dlx+vtg+G0OL8Yd9Qkal7vgrfGu6gJY8XI0GrCRDjFuvGhES6LVSqYpn8REE0WKoa2z/54tm0ATp9nmo20MBA2M5W6OXTi7FbttqBairj0IyzCvENPoEEiHLcWDCANUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608708; c=relaxed/simple;
	bh=7NgZ+ki7Jpk38+35vOYlyLMHAwb0CdRdix5vu5oMJcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/vH72TR3X2JqEy/2nuSoIyk9dFzqnWV/AErE4qq/D7mRzJs+2HJdMr3h97TG08cDQdDULHHuipgv7vRHhpl0VlzJNTeEDCH8Zt/i9DHzm5G5fIU3aKJ5Xp2yEQQxVm40PpzDzcVYZ8i5HDyhIcBSRBnxvu9xhOMR1Sfhx6XYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og4OG157; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2570bf605b1so8773735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608706; x=1758213506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNfZ+THGjVnPfKEQVjfAvTl//pe2jY0CkLSpKpP2yFk=;
        b=Og4OG157EORSn1qNZOlUl4xWUwzxVe3G+JkEuPeUiUnUHK80RjkF25Cb57eWnstdOm
         nkGiiigL2jN2+c/F6zXxLki+giGMqO8ugU4e23d9BKr8cO0mcJ/PaQGV6KPZBDg4MwBV
         AiAK9I+k14z8yb16SHLjXage6gqzUZouBWLvo1K2Ddr5xQXTiK+7cWBDj/Bt0/4YNydW
         pQKk10dn9qWfcDt3VR4WoaeP90l4ng6m72CVy7AeYgVDUSzs7puOlZR3WvEg6hTVmEe5
         Wg7Agok5k86bHSG4qoS4AMtVwQ1Q+zeUs85f4cok+SgIBeUbq3tfe1sBDbigCZJiZE8L
         U23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608706; x=1758213506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNfZ+THGjVnPfKEQVjfAvTl//pe2jY0CkLSpKpP2yFk=;
        b=AOGX7LSPjHMdOHQqSM7unliVLRKDa/Edq2ZUixFWlc3xJDDWA2mvr9nYmDXiNHvM00
         OyFJemZOrXTc3rmW6Q2k5+Yprkg44uhRmhgBulD3isG/PdWE73ijQDy+/rqVqsHuIo7h
         6yoaDtHkOiGKHekgJx0gjxBFCJBroGL7Wc2BiXzDM5lp8nEycKhngQ6LquaN/Uopl0T1
         NmgGAHTgh2kBOA548auSgxGU53eaNI2qcjmu9vufuZ712WTyKd+FgR9TFAbVi0Wy3nS7
         So7sJbLDrvd9N4zpCy88D6LHuLx5x0vGpOs73czg/ELqYk1SwveXKRif14obI5QrQ6+F
         IgPA==
X-Forwarded-Encrypted: i=1; AJvYcCXx89UcwdJRq4XcROQIfPGJ+4TYaGdNclgSV70FaRAb2DrVMVnsT/sxrrFcAtaiu+8MRuupZN9T3Ixxah0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxba+9vQqWhmnYyhon/J2u9jRevMF9jqzMsRHhZMaWGIzqpZKC4
	z7vR+dIk7uGOtg+/PI6tGCby9vIB5P4PJJ8tgeNG9zeCp6TDYWbk1ZYE
X-Gm-Gg: ASbGncuZfTQ1ZkfdIznnWepoFSql+9HvEWWYiP/6MX8k+dn6AqdaeJYIjU8D5iax6F0
	KcVhUPXFqeLArGDB51Op151DHZlQlgGwfYf424VLiMmrXb4AfvQVk4yJ2zJTc6PRimRQW4cX643
	1fClp70CSyePKgqY3ORV8QQlr5xKsKnWk64vcc3ql20PvzrubIddtZkOlqFkE/1W1L8rZSy+8JS
	ElxmhARDQazdyV/lsDL/klaglS57IviUSW1KxQ2AIjw8/3xeElh7FOJNzaqubLt1qDy2rVF0sjZ
	BWXqfuvFvEmJBPIwS8wWX1wSaxzWL36K6MrfrcIgbvaGm1AumvIx4PpDar3DoChMyo5BFaZ8OY2
	xVyQUd0/915zX0I2Mn2HoOKm79ZwTi1t2ztm0uv619qtddaKATDZETY1vcqTzh+RJYPDKJKY=
X-Google-Smtp-Source: AGHT+IE0FiJZ1Xof1YnqAKXUYRLvK9Rwr7P7SSvXPPnTPHIg+AFxKr0A7VxsEXWSG4uIu8QKuqN0+Q==
X-Received: by 2002:a17:902:e38a:b0:248:cd0b:3434 with SMTP id d9443c01a7336-25d26e43dc6mr435495ad.36.1757608705609;
        Thu, 11 Sep 2025 09:38:25 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3786807fsm24328675ad.62.2025.09.11.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:38:25 -0700 (PDT)
Date: Fri, 12 Sep 2025 00:38:20 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
	axboe@kernel.dk, ceph-devel@vger.kernel.org, ebiggers@kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
 <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>

On Fri, Sep 12, 2025 at 12:26:02AM +0800, Kuan-Wei Chiu wrote:
> Hi Caleb,
> 
> On Thu, Sep 11, 2025 at 08:50:12AM -0700, Caleb Sander Mateos wrote:
> > On Thu, Sep 11, 2025 at 12:33 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > >
> > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > >
> > > The base64 decoder previously relied on strchr() to locate each
> > > character in the base64 table. In the worst case, this requires
> > > scanning all 64 entries, and even with bitwise tricks or word-sized
> > > comparisons, still needs up to 8 checks.
> > >
> > > Introduce a small helper function that maps input characters directly
> > > to their position in the base64 table. This reduces the maximum number
> > > of comparisons to 5, improving decoding efficiency while keeping the
> > > logic straightforward.
> > >
> > > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > > over 1000 runs, tested with KUnit):
> > >
> > > Decode:
> > >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> > >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> > >
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > ---
> > >  lib/base64.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/base64.c b/lib/base64.c
> > > index b736a7a43..9416bded2 100644
> > > --- a/lib/base64.c
> > > +++ b/lib/base64.c
> > > @@ -18,6 +18,21 @@
> > >  static const char base64_table[65] =
> > >         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > 
> > Does base64_table still need to be NUL-terminated?
> > 
> Right, it doesn't need to be nul-terminated.
> 
> > >
> > > +static inline const char *find_chr(const char *base64_table, char ch)
> > 
> > Don't see a need to pass in base64_table, the function could just
> > access the global variable directly.
> > 
> > > +{
> > > +       if ('A' <= ch && ch <= 'Z')
> > > +               return base64_table + ch - 'A';
> > > +       if ('a' <= ch && ch <= 'z')
> > > +               return base64_table + 26 + ch - 'a';
> > > +       if ('0' <= ch && ch <= '9')
> > > +               return base64_table + 26 * 2 + ch - '0';
> > > +       if (ch == base64_table[26 * 2 + 10])
> > > +               return base64_table + 26 * 2 + 10;
> > > +       if (ch == base64_table[26 * 2 + 10 + 1])
> > > +               return base64_table + 26 * 2 + 10 + 1;
> > > +       return NULL;
> > 
> > This is still pretty branchy. One way to avoid the branches would be
> > to define a reverse lookup table mapping base64 chars to their values
> > (or a sentinel value for invalid chars). Have you benchmarked that
> > approach?
> > 
> We've considered that approach and agree it could very likely be faster.
> However, since a later patch in this series will add support for users to
> provide their own base64 table, adopting a reverse lookup table would also
> require each user to supply a corresponding reverse table. We're not sure
> whether the extra memory overhead in exchange for runtime speed would be
> an acceptable tradeoff for everyone, and it might also cause confusion on
> the API side as to why it's mandatory to pass in a reverse table.
> 
> By contrast, the simple inline function gives us a clear performance
> improvement without additional memory cost or complicating the API. That
> said, if there's consensus that a reverse lookup table is worthwhile, we
> can certainly revisit the idea.
> 
Or I just realized that since different base64 tables only differ in the
last two characters, we could allocate a 256 entry reverse table inside
the base64 function and set the mapping for those two characters. That
way, users wouldn't need to pass in a reverse table. The downside is that
this would significantly increase the function's stack size.

Regards,
Kuan-Wei

> 
> > 
> > > +}
> > > +
> > >  /**
> > >   * base64_encode() - base64-encode some binary data
> > >   * @src: the binary data to encode
> > > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> > >         u8 *bp = dst;
> > >
> > >         for (i = 0; i < srclen; i++) {
> > > -               const char *p = strchr(base64_table, src[i]);
> > > +               const char *p = find_chr(base64_table, src[i]);
> > >
> > >                 if (src[i] == '=') {
> > >                         ac = (ac << 6);
> > > --
> > > 2.34.1
> > >
> > >

