Return-Path: <linux-kernel+bounces-843969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD52BC0B50
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0D19A0A55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE72E229A;
	Tue,  7 Oct 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="vRD1lfta"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218F2D8DB5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826080; cv=none; b=oFjBgyAh0rdajQHshXpz69xt+Kh0RrUwJsLKbTKlRTzPCTaD4V5SCALSuIYKBIjwDEVDfH6YjQqC6Qz3VDqgcxEvrN/HT7q7oLhuu9AHYe9Xdz7Kpop9Orbj4q7Gp+C1US2YXWJy5Ygz6yMAIzyJGk3r3LIlJg1kcu89OE0IOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826080; c=relaxed/simple;
	bh=pdTwjOm0vpFq+a+kN6s7hTsZhY51AQgE7JhmI/mwkZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3bhqZNbhycCfW/hinVeiy3DhVldjM4JiklWEWwhMF/sEJRT+Y70dNqsZ2tkt8LgaIa5uTlPAj4AQWH0iWz0wexi3TpdQrUcnAU8+hslbvlzJQK5IQA902FxeUko25IRblBa9TPDuoqv5meVOK7hOCmvbrxDkkf4oEZYSjyzDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=vRD1lfta; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330469eb750so7094261a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1759826076; x=1760430876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KgqhrnFFLcx9NWAAafw0DUJGNd8Ld5Si5GTZSSnF9u4=;
        b=vRD1lftanMtJGUpysw3W7joTCgKUMh1bEIEgkK+a6ixT4LTBpNNwyzXPzq927t0xdh
         8qXdXLL5xrx7my5pmV8mjxYfhjr1PbA0gQvNEUT5RYWbuigFVNJE5JebL6NSKj5AgfLg
         CVzNEnnBrUEZ43JGPZgho6NmS3y7DVKU+CJoS+wgnh3KpN3WvKd2c3ylRpUAmEcGMoK3
         Pid9zKVH12znNom4Rh9KuTtjYbPD3Zg+2D0PSNcODquRsEtktZYv3+cFIrGyCKXObMfb
         oV6L4BPBVnv5HIgHWu9dq4bnQfAb9kYblc9hyLLb6l9crsD0gl5ZZvdZciaQ0fQuC7k6
         LzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826076; x=1760430876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgqhrnFFLcx9NWAAafw0DUJGNd8Ld5Si5GTZSSnF9u4=;
        b=FQIFe7K/++lW+DhVURFk/zgoE6iiUUX/McfRzod10qOo5EccNYGQSpTF/17kAs18jP
         tZntd5L9SIn6RdMPAvhziV1n49zxUu869W+ank/3vu1FPBQheWFa0HuYVWMg9IqpMnwk
         BrFBHVLtAE/OtKhV9Kfc1CTld7wlJSWDijdcJIGi05t1g84GLHfksqLYAvQguyZnDFLu
         POmdfjghVbGzjnZvkuIdpQs05RPmBOSYZ2pY8BwOftjBDs0FMzRyKViE8KI2SuYKA7Ve
         23UsOwuK5DsF0bgIWz+uSzPifKHPsdbse8XqT+1qMBUSeWTBDcw5EqBJ/mQm3bo0r5RT
         5PZw==
X-Forwarded-Encrypted: i=1; AJvYcCUcszxXkRTjQRCWfcoY5SNtkykr9adxVMWn+sPhURrIsHgfPqV0RKLyTXvzi/+Bn3KEDsCWQJ+PjduZbaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXE0IC8LmEMYadkxYcbbD2XTSd2tuJoixiSMPtAexGL2kr80OI
	udtJjvxr126w3LvnBPWqAIbkMawMIeLxo9hn5DfHVr92xvS3k36N8t3NhbBjqzdIaTg=
X-Gm-Gg: ASbGnctas2FirzzGI34iYh68ptD/ixMhYemLLbICLI28DeTb+f6nJ4lo6XTUrFMt7Zg
	nn/9k/kXgHPSG/T0iIZ3piQRXSdN8/uUFR+a1I2necMstf4DWHNCJ20dRJbDqP1SFIhhSx0O9RU
	Tws+F2fyT6FXQb3M+jvKIDP9Se+GseNhCQpElg83PkcUxeR3o7y6pQGKRL3yeorlfdbddUI+Dkw
	+asZ9/juVINPYFFtjtw3cuEkjntPLQtVNPKgzyyeK0h/A4gvs3YeTibpOUG93CEAUodg6Bx2NTo
	2AqO+vv2yEL0S3MYNKmpnOJManfcE6zeQzBvO5nlOPvZb5pEN2SQgRHbpbjJ+xik1Y3nreJt/07
	zvbyf5MCagqrDYYpHLebIkEUbITF0QaPZyp92hFMTkFkiqgiGIJOsLbDjSw+UWE9NYgYVh3RYR/
	9Tlks=
X-Google-Smtp-Source: AGHT+IG4PiJ7Ahe7MRzt+nwIi/+/a1f2W0pJRvgQ363IH2MoiBd+l107hDp6w8HAEeTEgfYg+b91IA==
X-Received: by 2002:a17:90b:1b01:b0:335:2a00:6842 with SMTP id 98e67ed59e1d1-339c279e4b8mr20038971a91.26.1759826076585;
        Tue, 07 Oct 2025 01:34:36 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:5196:9a8f:bb54:f0db])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a19fe4sm13597424a91.8.2025.10.07.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:34:36 -0700 (PDT)
Date: Tue, 7 Oct 2025 16:34:31 +0800
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
Subject: Re: [PATCH v3 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-ID: <aOTQl2SD5W8zBuNl@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
 <20250926065617.14361-1-409411716@gms.tku.edu.tw>
 <CADUfDZpu=rK4WwSmhNgxHQd2zeNvn8a7TmKCYuTL5T7dZ0x_4A@mail.gmail.com>
 <aNz21InCM4Pa93TL@wu-Pro-E500-G6-WS720T>
 <20251006215212.2920d571@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006215212.2920d571@pumpkin>

On Mon, Oct 06, 2025 at 09:52:12PM +0100, David Laight wrote:
> On Wed, 1 Oct 2025 17:39:32 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> > On Tue, Sep 30, 2025 at 05:11:12PM -0700, Caleb Sander Mateos wrote:
> > > On Fri, Sep 26, 2025 at 12:01 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:  
> > > >
> > > > The old base64 implementation relied on a bit-accumulator loop, which was
> > > > slow for larger inputs and too permissive in validation. It would accept
> > > > extra '=', missing '=', or even '=' appearing in the middle of the input,
> > > > allowing malformed strings to pass. This patch reworks the internals to
> > > > improve performance and enforce stricter validation.
> > > >
> > > > Changes:
> > > >  - Encoder:
> > > >    * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
> > > >      symbols, avoiding bit-by-bit shifting and reducing loop iterations.
> > > >    * Handle the final 1-2 leftover bytes explicitly and emit '=' only when
> > > >      requested.
> > > >  - Decoder:
> > > >    * Based on the reverse lookup tables from the previous patch, decode
> > > >      input in 4-character groups.
> > > >    * Each group is looked up directly, converted into numeric values, and
> > > >      combined into 3 output bytes.
> > > >    * Explicitly handle padded and unpadded forms:
> > > >       - With padding: input length must be a multiple of 4, and '=' is
> > > >         allowed only in the last two positions. Reject stray or early '='.
> > > >       - Without padding: validate tail lengths (2 or 3 chars) and require
> > > >         unused low bits to be zero.
> > > >    * Removed the bit-accumulator style loop to reduce loop iterations.
> > > >
> > > > Performance (x86_64, Intel Core i7-10700 @ 2.90GHz, avg over 1000 runs,
> > > > KUnit):
> > > >
> > > > Encode:
> > > >   64B   ~90ns   -> ~32ns   (~2.8x)
> > > >   1KB  ~1332ns  -> ~510ns  (~2.6x)
> > > >
> > > > Decode:
> > > >   64B  ~1530ns  -> ~64ns   (~23.9x)
> > > >   1KB ~27726ns  -> ~982ns  (~28.3x)
> > > >
> > > > Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
> > > > Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
> > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > ---
> > > >  lib/base64.c | 150 +++++++++++++++++++++++++++++++++++++--------------
> > > >  1 file changed, 110 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > index b20fdf168..fd1db4611 100644
> > > > --- a/lib/base64.c
> > > > +++ b/lib/base64.c
> > > > @@ -93,26 +93,43 @@ static const s8 base64_rev_tables[][256] = {
> > > >  int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
> > > >  {
> > > >         u32 ac = 0;
> > > > -       int bits = 0;
> > > > -       int i;
> > > >         char *cp = dst;
> > > >         const char *base64_table = base64_tables[variant];
> > > >
> > > > -       for (i = 0; i < srclen; i++) {
> > > > -               ac = (ac << 8) | src[i];
> > > > -               bits += 8;
> > > > -               do {
> > > > -                       bits -= 6;
> > > > -                       *cp++ = base64_table[(ac >> bits) & 0x3f];
> > > > -               } while (bits >= 6);
> > > > -       }
> > > > -       if (bits) {
> > > > -               *cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
> > > > -               bits -= 6;
> > > > +       while (srclen >= 3) {
> > > > +               ac = ((u32)src[0] << 16) |
> > > > +                        ((u32)src[1] << 8) |
> > > > +                        (u32)src[2];
> > > > +
> > > > +               *cp++ = base64_table[ac >> 18];
> > > > +               *cp++ = base64_table[(ac >> 12) & 0x3f];
> > > > +               *cp++ = base64_table[(ac >> 6) & 0x3f];
> > > > +               *cp++ = base64_table[ac & 0x3f];
> > > > +
> > > > +               src += 3;
> > > > +               srclen -= 3;
> > > >         }
> > > > -       while (bits < 0) {
> > > > -               *cp++ = '=';
> > > > -               bits += 2;
> > > > +
> > > > +       switch (srclen) {
> > > > +       case 2:
> > > > +               ac = ((u32)src[0] << 16) |
> > > > +                    ((u32)src[1] << 8);
> > > > +
> > > > +               *cp++ = base64_table[ac >> 18];
> > > > +               *cp++ = base64_table[(ac >> 12) & 0x3f];
> > > > +               *cp++ = base64_table[(ac >> 6) & 0x3f];
> > > > +               if (padding)
> > > > +                       *cp++ = '=';
> > > > +               break;
> > > > +       case 1:
> > > > +               ac = ((u32)src[0] << 16);
> > > > +               *cp++ = base64_table[ac >> 18];
> > > > +               *cp++ = base64_table[(ac >> 12) & 0x3f];
> > > > +               if (padding) {
> > > > +                       *cp++ = '=';
> > > > +                       *cp++ = '=';
> > > > +               }
> > > > +               break;
> > > >         }
> > > >         return cp - dst;
> > > >  }
> > > > @@ -128,39 +145,92 @@ EXPORT_SYMBOL_GPL(base64_encode);
> > > >   *
> > > >   * Decodes a string using the selected Base64 variant.
> > > >   *
> > > > - * This implementation hasn't been optimized for performance.
> > > > - *
> > > >   * Return: the length of the resulting decoded binary data in bytes,
> > > >   *        or -1 if the string isn't a valid Base64 string.
> > > >   */
> > > >  int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
> > > >  {
> > > > -       u32 ac = 0;
> > > > -       int bits = 0;
> > > > -       int i;
> > > >         u8 *bp = dst;
> > > > -       s8 ch;
> > > > -
> > > > -       for (i = 0; i < srclen; i++) {
> > > > -               if (src[i] == '=') {
> > > > -                       ac = (ac << 6);
> > > > -                       bits += 6;
> > > > -                       if (bits >= 8)
> > > > -                               bits -= 8;
> > > > -                       continue;
> > > > -               }
> > > > -               ch = base64_rev_tables[variant][(u8)src[i]];
> > > > -               if (ch == -1)
> > > > +       s8 input1, input2, input3, input4;
> > > > +       u32 val;
> > > > +
> > > > +       if (srclen == 0)
> > > > +               return 0;  
> > > 
> > > Doesn't look like this special case is necessary; all the if and while
> > > conditions below are false if srclen == 0, so the function will just
> > > end up returning 0 in that case anyways. It would be nice to avoid
> > > this branch, especially as it seems like an uncommon case.
> > >  
> > 
> > You're right. I'll remove it. Thanks.
> > 
> > > > +
> > > > +       /* Validate the input length for padding */
> > > > +       if (unlikely(padding && (srclen & 0x03) != 0))
> > > > +               return -1;
> > > > +
> > > > +       while (srclen >= 4) {
> > > > +               /* Decode the next 4 characters */
> > > > +               input1 = base64_rev_tables[variant][(u8)src[0]];
> > > > +               input2 = base64_rev_tables[variant][(u8)src[1]];
> > > > +               input3 = base64_rev_tables[variant][(u8)src[2]];
> > > > +               input4 = base64_rev_tables[variant][(u8)src[3]];
> > > > +
> > > > +               /* Return error if any Base64 character is invalid */
> > > > +               if (unlikely(input1 < 0 || input2 < 0 || (!padding && (input3 < 0 || input4 < 0))))
> > > > +                       return -1;
> > > > +
> > > > +               /* Handle padding */
> > > > +               if (unlikely(padding && ((input3 < 0 && input4 >= 0) ||
> > > > +                                        (input3 < 0 && src[2] != '=') ||
> > > > +                                        (input4 < 0 && src[3] != '=') ||
> > > > +                                        (srclen > 4 && (input3 < 0 || input4 < 0)))))  
> > > 
> > > Would be preferable to check and strip the padding (i.e. decrease
> > > srclen) before this main loop. That way we could avoid several
> > > branches in this hot loop that are only necessary to handle the
> > > padding chars.
> > >   
> > 
> > You're right. As long as we check and strip the padding first, the
> > behavior with or without padding can be the same, and it could also
> > reduce some unnecessary branches. I'll make the change.
> 
> As I said earlier.
> Calculate 'val' first using signed arithmetic.
> If it is non-negative there are three bytes to write.
> If negative then check for src[2] and src[3] being '=' (etc) before erroring out.
> 
> That way there is only one check in the normal path.
> 
> 	David
>

Thanks for the feedback. We’ll update the implementation accordingly.

Best regards,
Guan-Chun

> > 
> > Best regards,
> > Guan-Chun
> > 
> > > > +                       return -1;
> > > > +               val = ((u32)input1 << 18) |
> > > > +                     ((u32)input2 << 12) |
> > > > +                     ((u32)((input3 < 0) ? 0 : input3) << 6) |
> > > > +                     (u32)((input4 < 0) ? 0 : input4);
> > > > +
> > > > +               *bp++ = (u8)(val >> 16);
> > > > +
> > > > +               if (input3 >= 0)
> > > > +                       *bp++ = (u8)(val >> 8);
> > > > +               if (input4 >= 0)
> > > > +                       *bp++ = (u8)val;
> > > > +
> > > > +               src += 4;
> > > > +               srclen -= 4;
> > > > +       }
> > > > +
> > > > +       /* Handle leftover characters when padding is not used */
> > > > +       if (!padding && srclen > 0) {
> > > > +               switch (srclen) {
> > > > +               case 2:
> > > > +                       input1 = base64_rev_tables[variant][(u8)src[0]];
> > > > +                       input2 = base64_rev_tables[variant][(u8)src[1]];
> > > > +                       if (unlikely(input1 < 0 || input2 < 0))
> > > > +                               return -1;
> > > > +
> > > > +                       val = ((u32)input1 << 6) | (u32)input2; /* 12 bits */
> > > > +                       if (unlikely(val & 0x0F))
> > > > +                               return -1; /* low 4 bits must be zero */
> > > > +
> > > > +                       *bp++ = (u8)(val >> 4);
> > > > +                       break;
> > > > +               case 3:
> > > > +                       input1 = base64_rev_tables[variant][(u8)src[0]];
> > > > +                       input2 = base64_rev_tables[variant][(u8)src[1]];
> > > > +                       input3 = base64_rev_tables[variant][(u8)src[2]];
> > > > +                       if (unlikely(input1 < 0 || input2 < 0 || input3 < 0))
> > > > +                               return -1;
> > > > +
> > > > +                       val = ((u32)input1 << 12) |
> > > > +                             ((u32)input2 << 6) |
> > > > +                             (u32)input3; /* 18 bits */
> > > > +
> > > > +                       if (unlikely(val & 0x03))
> > > > +                               return -1; /* low 2 bits must be zero */
> > > > +
> > > > +                       *bp++ = (u8)(val >> 10);
> > > > +                       *bp++ = (u8)((val >> 2) & 0xFF);  
> > > 
> > > "& 0xFF" is redundant with the cast to u8.
> > > 
> > > Best,
> > > Caleb
> > >   
> > > > +                       break;
> > > > +               default:
> > > >                         return -1;
> > > > -               ac = (ac << 6) | ch;
> > > > -               bits += 6;
> > > > -               if (bits >= 8) {
> > > > -                       bits -= 8;
> > > > -                       *bp++ = (u8)(ac >> bits);
> > > >                 }
> > > >         }
> > > > -       if (ac & ((1 << bits) - 1))
> > > > -               return -1;
> > > > +
> > > >         return bp - dst;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(base64_decode);
> > > > --
> > > > 2.34.1
> > > >
> > > >  
> > 
> 

