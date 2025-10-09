Return-Path: <linux-kernel+bounces-846496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E5BC82B0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D6E1A60FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E12D5A07;
	Thu,  9 Oct 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2RB7pUD"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA810F1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000739; cv=none; b=WLMKkEwIAn8GVF6k8aIoiMpifixv4R4xO/YwcfTgbQ3I0fQezbOyYUmmKpTXVMxHatmJMOgVoQ6UeBRzMtBhiuVur/scBXjOAbSje856EaYuq51hAgMkL2eYexV4RF6nJ80nD5C+win+fH61iksiPovnGJUgv9ZCnpupWy3X9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000739; c=relaxed/simple;
	bh=VEKWxVUe/tnNvlLhoBnBBDaH0OhNaEJWHRAMuAoTH98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8ypvu42n41VXfjBD41CGmrw78lzWS8+W/lWrA+06gfoXEs4lUQ8fqMOgOjD0iApUpJBp6mWOYo3nrJXnJfOBAvhcvtT0mWmDR1ZZXOjtJKJhkvEzdY8Us86Z3Fs3t5B6nFnQ66w+34kkxLXg+zLE8HiGxA4jNXrv6hAE1UPJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2RB7pUD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so608832a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760000737; x=1760605537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1TU7MfYzP9/dysH1d26eBKhbqRPLF+RftNgfSNIzQw=;
        b=L2RB7pUDn8k6GgbryTExOKml2C/KIRl2yJ1UGHoFawVLTI8BNT/x+EsSRQi3+s5JgN
         rDq2RYBwwtrWegNxjSiPdGxD5E84pJRlYQhXHjkP6ptHQECEuHNr/dwzAnSaYkfEMxr4
         iDYEhePxOjUA2C5B94Jg21Vos0/r6qphnl8t49MDM6XVF3a1Z27tG9+9UQ0pY2lFg4Fn
         L6EM/5Nr+WZN2cxogeJRICRI/y3v0QB1CpBJkheVbNiWv455Tz9MZQorADIkHqgStwuS
         0BZhV0k4KH7xoDxdUiSRIWY5FEMlqRPRvwSCDCx5DtSA5AheReiiw9UjrTMj3pidYwBN
         BOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000737; x=1760605537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1TU7MfYzP9/dysH1d26eBKhbqRPLF+RftNgfSNIzQw=;
        b=Mhk8+mUQEwiEHUoU2kOhlPporECQBLcmc9Xr2L8a+RDxUJrLxr9x4g8vUajTtnehQv
         S1Zic23dy3JrPNP4Qb13w0w9xBg3n046mmRGyabDZ0APgoqGXUqef4FE6gGt7SY96mqR
         jAVfcZvdaH1eDUYnL6kBEfeQ5pPuObEr2YXcGJdKWDlq2mrWVpD8YK20UkPUS+WNSrRu
         so3K1H2KSj8TVcCxCEJhJnMXTWWUCp/wGU8GvlzDaS/8KqdgfsVrW+tF7mWQALrbVDVX
         6fUZfpjuOkTbhPeKbJ7z60aSdJ+Sll744n6Zos1gymVi54U0F+OooxrQgyPATiA+L6Oc
         uCxw==
X-Forwarded-Encrypted: i=1; AJvYcCWhKLJssPaxpW7us4+ejrDnhywpw5kiexrb/Cr3sGM6faXb/tIXa7qFRs8VkksrBbfVVC+Pt1cCUA0+FmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqmLfgDxLc0XRgEDIin7PMvmjgqgmJYjhLaRPuKMMYMg9sKvi
	YKBz6PGKGHVcNdGRYZQxm/rwkIwfeSQ26RMBR+JEXtDuS20uRFvyn6L06En8vslGmLyIeO2BKlN
	8IexRSTtrbMFjze8UQRG4FGhWOFU/fcg=
X-Gm-Gg: ASbGncvMNYHMlZ03tz9URPM4NFlLqKdcihq3PNU8zgDizPcs1qFwsVkQChjpFVjxPp2
	biMAEC1u/Pw4rHcZEXXI4yChuo5rORB/su1ME3KiVJph5DM4fEPt4bbg+D7hejmfwOoTgOAlBmL
	4PhT+lr04y5NI4ouQPE5WZM/Ifmj8YTwNUD8E+yUAjIdWeUiZhM1TodzSRB7hsYamyVKBP3jQ1Q
	i0/6QucQT35Vepg0fs5EMsxuOAknTbmT6hYQ2kYxg2C
X-Google-Smtp-Source: AGHT+IH2GX8bEk4r+hR0p6Q8BVGAccvpb8Z43LxRJ+PRTrW6XFN+OBi7YUZTF1aXK8kHV5VFN+DBONnEIiVmO5qoAbs=
X-Received: by 2002:a17:90b:3c09:b0:31f:ecf:36f with SMTP id
 98e67ed59e1d1-339eda48b06mr15014058a91.1.1760000737140; Thu, 09 Oct 2025
 02:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006114507.371788-1-aha310510@gmail.com> <20251008173935.4skifawm57zqpsai@pali>
In-Reply-To: <20251008173935.4skifawm57zqpsai@pali>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 9 Oct 2025 18:05:26 +0900
X-Gm-Features: AS18NWCMN2fHRdD8EN6xDD1OrTWxPjBo90ZkWO_xScRehILrRLDTEGSKJK0VrA4
Message-ID: <CAO9qdTFk94yDCMAuTkx5yW9VXYExWuhgpi0X15C5F7e5DQgibA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pali

Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> On Monday 06 October 2025 20:45:07 Jeongjun Park wrote:
> > After the loop that converts characters to ucs2 ends, the variable i
> > may be greater than or equal to len.
>
> It is really possible to have "i" greater than len? Because I do not see
> from the code how such thing could happen.
>
> I see only a case when i is equal to len (which is also overflow).
>
> My understanding:
> while-loop condition ensures that i cannot be greater than len and i is
> increased by exfat_convert_char_to_ucs2() function which has upper bound
> of "len-i". So value of i can be increased maximally by (len-i) which
> could lead to maximal value of i to be just "len".
>
> > However, when checking whether the
> > last byte of p_cstring is NULL, the variable i is used as is, resulting
> > in an out-of-bounds read if i >=3D len.
> >
> > Therefore, to prevent this, we need to modify the function to check
> > whether i is less than len, and if i is greater than or equal to len,
> > to check p_cstring[len - 1] byte.
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
> > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  fs/exfat/nls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> > index 8243d94ceaf4..a52f3494eb20 100644
> > --- a/fs/exfat/nls.c
> > +++ b/fs/exfat/nls.c
> > @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb=
,
> >               unilen++;
> >       }
> >
> > -     if (p_cstring[i] !=3D '\0')
> > +     if (p_cstring[min(i, len - 1)] !=3D '\0')
>
> What about "if (i < len)" condition instead?
>
> The p_cstring is the nul term string and my understanding is that the
> "p_cstring[i] !=3D '\0'" is checking that i is at position of strlen()+1.
> So should not be "if (i < len)" the same check without need to
> dereference the p_cstring?
>

Thank you for the detailed explanation! I misunderstood.

In summary, since the variable i can never be greater than len, we don't
need to consider this case. Therefore, if i is less than len, we can
determine that an nls loss has occurred.

I think that under normal nls conditions, i should be equal to len
immediately after the while loop terminates, so changing the condition
here to "if (i !=3D len)" would be a better way to make this clear.

This way, we can check for an nls loss without dereferencing p_cstring,
and we can clearly indicate that i should be equal to len when the while
loop terminates. What do you think?

Regards,
Jeongjun Park

