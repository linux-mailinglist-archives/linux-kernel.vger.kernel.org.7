Return-Path: <linux-kernel+bounces-752443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F07B1759A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8DA82B05
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3C241690;
	Thu, 31 Jul 2025 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIadDMlG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD714885D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983062; cv=none; b=eOzJeTD37N6KRd63dzAfgR5WzR5EQm4FpbX2FZ6WQBMUaA17bLxfngLwpJ16zBftXxvDARSK4jpu2pr2pabra02gayXi3u2UBRmw3NuVAVNzDtLCU2uXp7wwHxxLkgC0hOv/fbqlIAXgha6BSeBIVQgGMp2joRgt1s3AMnA9XNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983062; c=relaxed/simple;
	bh=s8Fkj2wMw9x/f8DV4m/VFl3/5T54yAmMlF1RuB1J8Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzHLOp8jqJcBEgJPmbhGVgJpzqAkCD6tEs2lu6IpZyj6quGINRCKz65Wc1lcn7/wXkDuxa2BO3UXBIInY2YJpj67kdNCrmoUNYTxONuc1KCjm5+SdrJuX6WuxZAdX0ObWBJt9ghoREHWeRXJKC0ySh+i0vbfAnfCMrwe6ZHDYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIadDMlG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6156c3301ccso653a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753983059; x=1754587859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTYZ6ctQGC42ES6NTcAXoMAQOzCvBSfMLOvM1LONwic=;
        b=vIadDMlGg9Td+k1aaZpCt1PYRMRmADkx/ghEdmG7OEzPJI3JFudjeyrSMyI3b0ozt9
         4r0L+W6azV87rGzf5CYfHLI/Hu+jhI2UYCnrPhlsV2Jmy5XvdKhqupInT9bUBMdJgSqe
         I8BSHTXtSRdY1OJbjoHH7oiT09u7yPCnY/SUkTqbvC16eW2wyLRPhFD/PDlzHuQNWuuR
         ++JSdvZyVkxXnApw/nuERrd0Cup/jd4CjwFQiAUnOOB3NcKoIplTY251vO/wHgqt1zw4
         BqTYD/W0QlclmDLrJoVgv2bWY3r7emIHIoozE1Sn+ier5Em3bg3jWsKpHOahyA6DQVpx
         /YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753983059; x=1754587859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTYZ6ctQGC42ES6NTcAXoMAQOzCvBSfMLOvM1LONwic=;
        b=f2yW/tG5n3Y9ndKnpXgwGykzH/s20TNrUy0eZ/522Jl+qfw7d0RVYzkbTT4D46YzdO
         HHodIExPr9zkMvs56gh9SqufzxeYmscbg8a94YwvxYsof9twaXXhXj+nX8eo/3IeVOG1
         t4+bzYz42tils7bwrpGz+l5YWcaL+W0pxwh8Bih4Si/+5HqWKJnJPW6agRsbdgakzDzw
         sYI3W6ShRG4jkW/Tj77Nv1mQ6uOv2bab0WsKhCfvMX4ioY/2+M9Wk6NeCKR/Qqi5Hyp4
         lIHnUKRiXHKYZGRDZGEitbBhxVjQduUCqFaMtksZUt9PHcRX17SsPqynjgupbMlQPW7G
         NbKw==
X-Forwarded-Encrypted: i=1; AJvYcCUcdgSdlnjrdXL90hYL5yUfd4wVpOyyMpqan6Ia6QRPz7QqY/7B4CnwIUwbnRsEGO03AFC0HKruYc5gcvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzV5Q8Nhxvw+qNbXyDWdsvPzSyULpc/oyYYBKjcS6Kk/CwPDRh
	VU2PktY23M3QiturWZvTn3R/6GSGdWaZRZsK57eLQXXuzI3CQGefwAzYyiA6QprHWXbeInXZyO4
	LufdW8ywjB6ZeoYos+7IYhJghq7zouLSNZgTD2kGb
X-Gm-Gg: ASbGncvETY7eU2A542uZjX/L6XBm0KEWH2zfKRawOfDQG/rrICWyN54joWOd6mfM0FD
	/MJfAFpjIYGPcIUXu+tBPCtkI2OWlvSyul84DYk8V5Wdlg6V4NABlg9bLA9gsQZUrBkWnou9zvh
	OVTFWnlYC9xcsvyCJXeNgm+/XDQ50Ql+F8wJZPmvYuFwH0fumiJ6nU56i8k71V6jeHN9q+GgFjd
	OaQTBTc/JJpf0KqOcNzEuovgOSvBkyc25OWsc6dBQ==
X-Google-Smtp-Source: AGHT+IF1QJ83Q6c4dkzDCM2z6KKYFAxir5RDC4UAZQtNvYOpT4gEPwIqWv3dD6bsp3P9MtuExIQPvuxLjZH4h+ZidhU=
X-Received: by 2002:aa7:c687:0:b0:615:2899:a4e5 with SMTP id
 4fb4d7f45d1cf-615aeb102b5mr84457a12.5.1753983058516; Thu, 31 Jul 2025
 10:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com>
In-Reply-To: <20250731154442.319568-1-surenb@google.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 31 Jul 2025 10:30:46 -0700
X-Gm-Features: Ac12FXwZbn_-TO6sOPye9GKpC7g4hj7tbdyDuoXOlj14tXOv6tXKAlm_xFPsw5k
Message-ID: <CA+EESO4T-rYwmd_h3AxAkiiHgqcLQQzE1SmGNSGqOFbGvEShGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@redhat.com, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 8:44=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> encounters a non-present THP, it fails to properly recognize an unmapped
> hole and tries to access a non-existent folio, resulting in
> a crash. Add a check to skip non-present THPs.
>
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@goog=
le.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1 [1]
> - Fixed step size calculation, per Lokesh Gidra
> - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gi=
dra
>
> [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.co=
m/
>
>  mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index cbed91b09640..b5af31c22731 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
>
>                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
>                 if (ptl) {
> -                       /* Check if we can move the pmd without splitting=
 it. */
> -                       if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> -                           !pmd_none(dst_pmdval)) {
> -                               struct folio *folio =3D pmd_folio(*src_pm=
d);
> +                       if (pmd_present(*src_pmd) || is_pmd_migration_ent=
ry(*src_pmd)) {
> +                               /* Check if we can move the pmd without s=
plitting it. */
> +                               if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> +                                   !pmd_none(dst_pmdval)) {
> +                                       if (pmd_present(*src_pmd)) {
> +                                               struct folio *folio =3D p=
md_folio(*src_pmd);
> +
> +                                               if (!folio || (!is_huge_z=
ero_folio(folio) &&
> +                                                              !PageAnonE=
xclusive(&folio->page))) {
> +                                                       spin_unlock(ptl);
> +                                                       err =3D -EBUSY;
> +                                                       break;
> +                                               }
> +                                       }
>
> -                               if (!folio || (!is_huge_zero_folio(folio)=
 &&
> -                                              !PageAnonExclusive(&folio-=
>page))) {
>                                         spin_unlock(ptl);
> -                                       err =3D -EBUSY;
> -                                       break;
> +                                       split_huge_pmd(src_vma, src_pmd, =
src_addr);
> +                                       /* The folio will be split by mov=
e_pages_pte() */
> +                                       continue;
>                                 }
>
> +                               err =3D move_pages_huge_pmd(mm, dst_pmd, =
src_pmd,
> +                                                         dst_pmdval, dst=
_vma, src_vma,
> +                                                         dst_addr, src_a=
ddr);
> +                               step_size =3D HPAGE_PMD_SIZE;
> +                       } else {
>                                 spin_unlock(ptl);
> -                               split_huge_pmd(src_vma, src_pmd, src_addr=
);
> -                               /* The folio will be split by move_pages_=
pte() */
> -                               continue;
> +                               if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_H=
OLES)) {
> +                                       err =3D -ENOENT;
> +                                       break;
> +                               }
> +                               /* nothing to do to move a hole */
> +                               err =3D 0;
> +                               step_size =3D min(HPAGE_PMD_SIZE, src_sta=
rt + len - src_addr);
>                         }
> -
> -                       err =3D move_pages_huge_pmd(mm, dst_pmd, src_pmd,
> -                                                 dst_pmdval, dst_vma, sr=
c_vma,
> -                                                 dst_addr, src_addr);
> -                       step_size =3D HPAGE_PMD_SIZE;
>                 } else {
>                         if (pmd_none(*src_pmd)) {
>                                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_H=
OLES)) {
>
> base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
> --
> 2.50.1.552.g942d659e1b-goog
>

