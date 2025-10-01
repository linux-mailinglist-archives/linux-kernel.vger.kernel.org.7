Return-Path: <linux-kernel+bounces-839020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75780BB0A72
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C26F16E236
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D9302151;
	Wed,  1 Oct 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="a1rYaZl/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B34315A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327777; cv=none; b=Ri6ipH4wPnA7ctuaS45t3tUMgPyT2dWzqdmZtSqRV/tWRNNVuJqoDfwXWIeN/jRVTJzFuq0rTUpomYHZZsp9gKoqc8JGlQeKJEBgcyNvlxJYAnXMl1RuJucqYZu2VddKy/NQeOy7Fl/HfofxWGnKo6HesRMxGLzkrZ7ZUJph2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327777; c=relaxed/simple;
	bh=OJ+KTqcayfmcDdWZtInXc2jIwZoqL1zTM3i3uUSjZ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQtM++m339Qn/EdbXntvhR7LqJa5Uwr3/em2aHIZ/raL4MQ7NkvUB8cedeYVfXM3vzvf4dy8KpCiCoor2nCa87LnzgOWGmeC9ulWfx0Cxpa0Rm5POfuCiyO/swqYpXpI+xykFZH83wvGiaGaIi0v2vmpb68scOIhzDCd3Ww/A70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=a1rYaZl/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27ee41e0798so92908415ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1759327774; x=1759932574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqH0aTCG1Npbjt4UvAY64PL1wv1XtMcuMWK/965I/ys=;
        b=a1rYaZl/zNId7KXt4FlcfsGYaVP55ozqVWbqOSc2KndDDFaHn9gfB76qaGt8rsxBtb
         +UjW8ZXPsR61Ict/3/Ox00vm7E5wCASyYXzdNxLa1wgRQgbNJwBjt+d2O9/Yte4i5tYX
         TzdbxYXpv8ofKPdVj+5PVrtixJCs0/YkkY9gq7NFxmKqb5n6PtsXXqXsgnVQCbH9RKy5
         L5l6rdIh694PCrdpmofXZ0vLm9K5cS1sHRsoOuWS3w9jrKwIJqydVPFGyGFSXguhnsIE
         bDT1sRTZg8oFZynMdRNtrjDWKi/CmFEXqBwRYHlcHyeSPopFfUYXvgm9ouyxcwirj96N
         mwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327774; x=1759932574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqH0aTCG1Npbjt4UvAY64PL1wv1XtMcuMWK/965I/ys=;
        b=btNQUzphIBt7nDXFWJpr0ehkOCRZu/ApdfcoN2kOBCQ+UEH/XaWuItzzxnD6B3zLGZ
         JLdx1/34ggp9yFJDmJbEg+OBBzhJng2vMjV01uvnGgDW/bndWm5bjtI4fSR+e11AvTvz
         1Uv7wO6zTxO9igPTNu/8+5A/rzEDyERi7LKYSs9yCcljJyyGsQAAEzbyPWEFgtWo9kRc
         U8CU42Mli+r2r8nJhn+b8ndApkKgCIC1bVnDHqos9zN7f574o+z0i9I+O30Yv6eMptos
         JCX8oP1fUp7RUwV7d82YLsp6lC7Jz8s0XD2QCZEtu4aUlUW04ASnHCr7bOuG+lNPjeG8
         D8cg==
X-Forwarded-Encrypted: i=1; AJvYcCWNgHhUJ3z2RLBaQQoITKtoEf4Xk3QgpgbvambPcGfPUDze/uz/R2k8fXc0/htYQZYFUih2+Ls1sWWKNII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQf+CJJM49NYUxg5zX95YKLfRc987N41/70+TJmelIRxfrjCc
	SGC/aE6fcEE2Q8PCUc7g1vtvGjIjHaRzMJv/TFeannHS2Ks+a8hx0n3FElYFcbtwanM=
X-Gm-Gg: ASbGnct4ziwey4YuI0g+TD8UfOtRxcQ5khK8lkE3HoIAbFKjLYytMOhfSQZagMNF8bb
	9IY55LZMvfhXTOGYV06/+DZHc9iHnkkpLq9xnYeizIbuzWuIsCX5vOKe1tTVs/ENuqgRmGUKnnV
	0AFxWU+s9ATfQtrrYBZjT21U/aLqTwtL1sVH8hyCqbOhOQLYwLupvQzoJbDPlClwLt6e/seajyK
	79XMWHubnhAqofwC8I409iTceD7PD9s6GiAcAeVAqkldeEP4+RuJu267aGq+xEPPrpGDwwWoUxX
	IMpE/ZXE0Z3LTvTXot298yFsWbS5ltsWsN8SA+BGi5t6T6pFkWcPOWcLjY567PTJUym6h6lXEzA
	VpWUXHxsBWnE34tlJN8vDX/t6CJKQn03UUtm7c2aCauONQM3X3CbzZY62xZt+xG8f0faz
X-Google-Smtp-Source: AGHT+IGgYOAP5JcZE9yHPeldcLK5JZTHw150agf7t58NJs7o4pgbl6tneqfkXD6iMaFuGY1SnGJkGg==
X-Received: by 2002:a17:902:d60f:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-28e7f32ffb4mr43337615ad.50.1759327773570;
        Wed, 01 Oct 2025 07:09:33 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:6af7:94e4:3a78:e342])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66f9257sm186844295ad.35.2025.10.01.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:09:32 -0700 (PDT)
Date: Wed, 1 Oct 2025 22:09:27 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com,
	idryomov@gmail.com, jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 1/6] lib/base64: Add support for multiple variants
Message-ID: <aN02F6hb/evk95D7@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065512.13881-1-409411716@gms.tku.edu.tw>
 <CADUfDZp6WeW9YQRRnxB7fFObtajatY_+f+x1D5dQOrNv626znA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp6WeW9YQRRnxB7fFObtajatY_+f+x1D5dQOrNv626znA@mail.gmail.com>

On Tue, Sep 30, 2025 at 04:56:17PM -0700, Caleb Sander Mateos wrote:
> On Thu, Sep 25, 2025 at 11:59 PM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> >
> > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > Extend the base64 API to support multiple variants (standard, URL-safe,
> > and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes a
> > variant parameter and an option to control padding. Update NVMe auth
> > code to use the new interface with BASE64_STD.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  drivers/nvme/common/auth.c |  4 ++--
> >  include/linux/base64.h     | 10 ++++++++--
> >  lib/base64.c               | 39 ++++++++++++++++++++++----------------
> >  3 files changed, 33 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> > index 91e273b89..5fecb53cb 100644
> > --- a/drivers/nvme/common/auth.c
> > +++ b/drivers/nvme/common/auth.c
> > @@ -178,7 +178,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
> >         if (!key)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       key_len = base64_decode(secret, allocated_len, key->key);
> > +       key_len = base64_decode(secret, allocated_len, key->key, true, BASE64_STD);
> >         if (key_len < 0) {
> >                 pr_debug("base64 key decoding error %d\n",
> >                          key_len);
> > @@ -663,7 +663,7 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
> >         if (ret)
> >                 goto out_free_digest;
> >
> > -       ret = base64_encode(digest, digest_len, enc);
> > +       ret = base64_encode(digest, digest_len, enc, true, BASE64_STD);
> >         if (ret < hmac_len) {
> >                 ret = -ENOKEY;
> >                 goto out_free_digest;
> > diff --git a/include/linux/base64.h b/include/linux/base64.h
> > index 660d4cb1e..a2c6c9222 100644
> > --- a/include/linux/base64.h
> > +++ b/include/linux/base64.h
> > @@ -8,9 +8,15 @@
> >
> >  #include <linux/types.h>
> >
> > +enum base64_variant {
> > +       BASE64_STD,       /* RFC 4648 (standard) */
> > +       BASE64_URLSAFE,   /* RFC 4648 (base64url) */
> > +       BASE64_IMAP,      /* RFC 3501 */
> > +};
> > +
> >  #define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
> >
> > -int base64_encode(const u8 *src, int len, char *dst);
> > -int base64_decode(const char *src, int len, u8 *dst);
> > +int base64_encode(const u8 *src, int len, char *dst, bool padding, enum base64_variant variant);
> > +int base64_decode(const char *src, int len, u8 *dst, bool padding, enum base64_variant variant);
> >
> >  #endif /* _LINUX_BASE64_H */
> > diff --git a/lib/base64.c b/lib/base64.c
> > index b736a7a43..1af557785 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -1,12 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * base64.c - RFC4648-compliant base64 encoding
> > + * base64.c - Base64 with support for multiple variants
> >   *
> >   * Copyright (c) 2020 Hannes Reinecke, SUSE
> >   *
> >   * Based on the base64url routines from fs/crypto/fname.c
> > - * (which are using the URL-safe base64 encoding),
> > - * modified to use the standard coding table from RFC4648 section 4.
> > + * (which are using the URL-safe Base64 encoding),
> > + * modified to support multiple Base64 variants.
> >   */
> >
> >  #include <linux/kernel.h>
> > @@ -15,26 +15,31 @@
> >  #include <linux/string.h>
> >  #include <linux/base64.h>
> >
> > -static const char base64_table[65] =
> > -       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > +static const char base64_tables[][65] = {
> > +       [BASE64_STD] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
> > +       [BASE64_URLSAFE] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_",
> > +       [BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
> > +};
> >
> >  /**
> > - * base64_encode() - base64-encode some binary data
> > + * base64_encode() - Base64-encode some binary data
> >   * @src: the binary data to encode
> >   * @srclen: the length of @src in bytes
> > - * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> > + * @dst: (output) the Base64-encoded string.  Not NUL-terminated.
> > + * @padding: whether to append '=' padding characters
> > + * @variant: which base64 variant to use
> >   *
> > - * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" specified
> > - * by RFC 4648, including the  '='-padding.
> > + * Encodes data using the selected Base64 variant.
> >   *
> > - * Return: the length of the resulting base64-encoded string in bytes.
> > + * Return: the length of the resulting Base64-encoded string in bytes.
> >   */
> > -int base64_encode(const u8 *src, int srclen, char *dst)
> > +int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
> 
> Padding isn't actually implemented in this commit? That seems a bit
> confusing. I think it would ideally be implemented in the same commit
> that adds it. That could be before or after the commit that optimizes
> the encode/decode implementations.
> 
> Best,
> Caleb
>

Got it, thanks for pointing that out. We'll address it in the next version.

Best regards,
Guan-Chun

> >  {
> >         u32 ac = 0;
> >         int bits = 0;
> >         int i;
> >         char *cp = dst;
> > +       const char *base64_table = base64_tables[variant];
> >
> >         for (i = 0; i < srclen; i++) {
> >                 ac = (ac << 8) | src[i];
> > @@ -57,25 +62,27 @@ int base64_encode(const u8 *src, int srclen, char *dst)
> >  EXPORT_SYMBOL_GPL(base64_encode);
> >
> >  /**
> > - * base64_decode() - base64-decode a string
> > + * base64_decode() - Base64-decode a string
> >   * @src: the string to decode.  Doesn't need to be NUL-terminated.
> >   * @srclen: the length of @src in bytes
> >   * @dst: (output) the decoded binary data
> > + * @padding: whether to append '=' padding characters
> > + * @variant: which base64 variant to use
> >   *
> > - * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
> > - * specified by RFC 4648, including the  '='-padding.
> > + * Decodes a string using the selected Base64 variant.
> >   *
> >   * This implementation hasn't been optimized for performance.
> >   *
> >   * Return: the length of the resulting decoded binary data in bytes,
> > - *        or -1 if the string isn't a valid base64 string.
> > + *        or -1 if the string isn't a valid Base64 string.
> >   */
> > -int base64_decode(const char *src, int srclen, u8 *dst)
> > +int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> >  {
> >         u32 ac = 0;
> >         int bits = 0;
> >         int i;
> >         u8 *bp = dst;
> > +       const char *base64_table = base64_tables[variant];
> >
> >         for (i = 0; i < srclen; i++) {
> >                 const char *p = strchr(base64_table, src[i]);
> > --
> > 2.34.1
> >
> >

