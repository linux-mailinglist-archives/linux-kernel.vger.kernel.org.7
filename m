Return-Path: <linux-kernel+bounces-880537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C923DC26083
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05211B24393
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B46C2E7BCC;
	Fri, 31 Oct 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EiH4IaWo"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A322ECD0F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926585; cv=none; b=AX7sLTtWe2KxyPeMoFhbFLd9zHVLPPsWo3fRCVZOm00tS5ABBcY6kYqHw8th6d6H1AwnD3YVZxE/giNdQHwSp+SglRHcMsX+MiGKZJXQoEsb7NXx630XiGhtlieidLOtOten1LcXUj29AtD02ewSul0/pbOq7tYCpbaqUEstwP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926585; c=relaxed/simple;
	bh=wOFtqKU5cY/H+/wFI62mVCydJUcPAJO0oOtjoN+GD0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULdJD5lNCMgRtaFd5+QxZgCsLbPhH0ANL3D22J1kWuJnVVyy29viBAzGF3p+webPDeF+TUU7xp3HJlb2wv9ECvexeeXRcudA6zaEBu5SxiK23bOtPkrXTRiDtTR92kbrwo+PVYISaYjNhqDzdMkS8Pa4sshF1J40mxIr7EOkSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EiH4IaWo; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso358633a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761926583; x=1762531383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKLnpauphF64zVNd2V79/vxesQJj7qD0DUlSjcW6MUA=;
        b=EiH4IaWolqZhtZSfAi/GsnIKmWR9uLr1lp3OEaW197rzRgOE6hA9dsWLbCmQBJ8qXn
         FtQ+YMpMi27vPKlTHmfqz1U5e8dybW6SYPhBXIZHEeuoG+KCugMR+83PGsU1KBmpUpY1
         +bhpOUs+IAHAipZRzhQVwjpQX6jG24CAFyzHKvDzetKjLrHwGfJmjNjmeEst8zwdDUXG
         GpER4z6BbJ0Harcm4kBUGfCe0eK90fv05kEBLnVzHHsTi+sEYo6VcjvYevYWnTN3OTyZ
         vOFLJ+k6D7Owx2X67BW7geIfPt3wtcKNV6kwTN+JDc7duV1C3GUCR0pXvY8AGqwmHxXs
         iHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926583; x=1762531383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKLnpauphF64zVNd2V79/vxesQJj7qD0DUlSjcW6MUA=;
        b=iJf/jdlJmt/33dUu2BVLhU2LG7z9L6Mnksp3YComesADh/cBO5cFbfe55Kz2UPonbR
         GOczEwrXE5LFDvhMHsjZC5/4b9H6HMTExqDiVMxPpZN+lV1g118utieC6zERZZuI6W8I
         ogWqVsS6F7ns9tJbyUj6tzRCK6PyV/OTpSo57SkiX6zdcVmmOl2109wRclK0o8o1uU7R
         9r7sYoH6evND9wSkAOvZ9HGNmz/NGiKormkTlA5yO/H5rBdxe97BP70b4ELQeQO2ajnR
         DhvoHSCKY/HTgyEaVqMFqA5kNAbepVt2BT1IoHNCiZjiP8kpzJBLxQV2R1uduHQJ2UT1
         eSFA==
X-Forwarded-Encrypted: i=1; AJvYcCX2jYstkCHM7A0TxfGmoG0Ut9S3CdKhSfqwGbNIjljENY2D6yFc87d+lGGlHDs3DFK+tLeA6y4vrMEYmCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgt01oP6BNKflFoUZESsyC01gPpMCV/IbwRuz98TIKbsXSs2q
	t4pD6Yy3+1z1GRTY/G/hkZvM++ZfvoCJlbo28MhMN0F4FLQODp5px0pINCC9nORWdwSTTpdVBVJ
	x5puCXpHV6EvP/hINAyoPn3Mmk78VETWC7vgpykHMRw==
X-Gm-Gg: ASbGncslNS8Ke7XYlLE1tgbZ9aES+MefxCGFC88566rs9dxLmA/CxVfzfYUc8yn2GBD
	7rWEt1tA+oDVy46+RCEb93UY+j/iHuToN6VF4hO7TojzPt8ulA2FyQ+Ur//QHlRyGibyPwgAS+E
	3ezHdkunK6aVTpmZzMlcXrALlLZ4Xptjv6xedwztdhMdiLw7Lv4pFwZyvfQ8bJ8HqPht78V5N5v
	Xo3FlKmiAN5uKZA1ejCSXus9t8WJbBqXiD6l0QB+733p0NomjhYRcXsvLhdq+JYKCVs7fx/iJvU
	++dqugwDgWl/Crb8nkw=
X-Google-Smtp-Source: AGHT+IHQNwuWDK2T/eNnooHACy3fG8LlSN+5KqjixEyYxsKgHxuFp/7yzY+VqxnhcGwGexzG2IWKvU/wfslm4s4hXyM=
X-Received: by 2002:a17:902:c40f:b0:294:c54e:88 with SMTP id
 d9443c01a7336-2951a566345mr32508655ad.11.1761926582838; Fri, 31 Oct 2025
 09:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com> <aQQwy7l_OCzG430i@fedora>
In-Reply-To: <aQQwy7l_OCzG430i@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 31 Oct 2025 09:02:48 -0700
X-Gm-Features: AWmQ_bllfNr7JNMeEI7t-sb-EdtYcOvAPuSji3rKtHyHN6KPL5msm9P2N6_ycpk
Message-ID: <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:45=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
> > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > iov_iter_get_pages2() to extract the pages from the iov_iter and
> > memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
> > Switch to using copy_to_iter()/copy_from_iter() instead. This avoids th=
e
> > user page reference count increments and decrements and needing to spli=
t
> > the memcpy() at user page boundaries. It also simplifies the code
> > considerably.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
> >  1 file changed, 14 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 0c74a41a6753..852350e639d6 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fo=
ps =3D {
> >       .open =3D         ublk_open,
> >       .free_disk =3D    ublk_free_disk,
> >       .report_zones =3D ublk_report_zones,
> >  };
> >
> > -#define UBLK_MAX_PIN_PAGES   32
> > -
> >  struct ublk_io_iter {
> > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> >       struct bio *bio;
> >       struct bvec_iter iter;
> >  };
>
> ->pages[] is actually for pinning user io pages in batch, so killing it m=
ay cause
> perf drop.

As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
pinning entirely. It calls copy_to_user_iter() for each contiguous
user address range:

size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
        if (WARN_ON_ONCE(i->data_source))
                return 0;
        if (user_backed_iter(i))
                might_fault();
        return iterate_and_advance(i, bytes, (void *)addr,
                                   copy_to_user_iter, memcpy_to_iter);
}

Which just checks that the address range doesn't include any kernel
addresses and then memcpy()s directly via the userspace virtual
addresses:

static __always_inline
size_t copy_to_user_iter(void __user *iter_to, size_t progress,
                         size_t len, void *from, void *priv2)
{
        if (should_fail_usercopy())
                return len;
        if (access_ok(iter_to, len)) {
                from +=3D progress;
                instrument_copy_to_user(iter_to, from, len);
                len =3D raw_copy_to_user(iter_to, from, len);
        }
        return len;
}

static __always_inline __must_check unsigned long
raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
{
        return copy_user_generic((__force void *)dst, src, size);
}

static __always_inline __must_check unsigned long
copy_user_generic(void *to, const void *from, unsigned long len)
{
        stac();
        /*
         * If CPU has FSRM feature, use 'rep movs'.
         * Otherwise, use rep_movs_alternative.
         */
        asm volatile(
                "1:\n\t"
                ALTERNATIVE("rep movsb",
                            "call rep_movs_alternative",
ALT_NOT(X86_FEATURE_FSRM))
                "2:\n"
                _ASM_EXTABLE_UA(1b, 2b)
                :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
                : : "memory", "rax");
        clac();
        return len;
}

Am I missing something?

Best,
Caleb

