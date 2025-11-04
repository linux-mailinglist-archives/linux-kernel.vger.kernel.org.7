Return-Path: <linux-kernel+bounces-884263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D37C2FC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4B9189BA20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDAA29B224;
	Tue,  4 Nov 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8G4krPS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+CmnK8d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD412C181
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243508; cv=none; b=Eqsd51HpuYlL84tdd+GUQH1oHGycVmbvRH0ilaDtAB61zcvTECndiHtWrVpiXzDo/jhKtuJNj4aUuJeoLD3z1tqHROooWsBXfrFYGRzK4GgkWiAay9VuVU5FtDyVCm6MLG63/JSX1Lg16KU/0jC9h6mZZFbzexLvwatKGxJJTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243508; c=relaxed/simple;
	bh=/yzTsMdskKhQu1paJCOYqDSq9bhZ+LZrRX9oy8qHqjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcCiMh0/Z2gtATmHTOIH2pmoSlIWW6vJ1zveudhsZio2cAis78nj5DETkLJq+kqEtvT9CDW+Ue3GuW9TNGGH2tUwAKQZISD27g2d6/dwMPreLhUukD7IjqdlSwV9Tb3N87NHx6bSNWkQo1RWXlaWuPaLMONsP2RuLc90AKjmrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8G4krPS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+CmnK8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762243506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpJH/9P6SXk4FNbPrBvyPZj8813+j3KAKeJeMOQg7WM=;
	b=b8G4krPSPhsZ/DgfbboqqaZePwpX8ZOAc0TjFq7XHorlugZZoDjf7nmzaEmZ+fG98MkY97
	rye/wyDZfpL7c2cWI4X/GLfzjHmtqn3agWxExHjRfYZkwaJprcPx6Ru5iW/MsBNf0t1AOy
	LR7CGA3v7x+9E4KFFY5a/vyJmzecH7c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-_1fSmpfQMomo5nqQWfeukw-1; Tue, 04 Nov 2025 03:05:01 -0500
X-MC-Unique: _1fSmpfQMomo5nqQWfeukw-1
X-Mimecast-MFC-AGG-ID: _1fSmpfQMomo5nqQWfeukw_1762243500
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59427b2fe85so985657e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762243499; x=1762848299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpJH/9P6SXk4FNbPrBvyPZj8813+j3KAKeJeMOQg7WM=;
        b=a+CmnK8du+ctm18H2CbHRg9R/KEA7Olf3dT4wQ3W2ygs61/v2zcBKVutP0MbdXrbUM
         UmHbKZQNiI1K+4T2jZR5+39L0ITE3xodI45SWMVou+9ONE//0Y8BZI+DWRw/4vxIJQVp
         kP7zLr1lTq670NzaV5+h4RX7YCXil7/5mYFtft7sytySuAdhq/42MxrVdDPagwC6Iz43
         +6rHtmmZlzRYMvtGwsT8ijamzCfi0mrbEeDcOtndjieH04dQ8XIcHF04BtiPYM5N/eUW
         bGTaZMCM1+F/fgKCRO+mhY9RXoNcn07M8Jlf6ic6Qoz2ExOkDHYYNnFJVRoKdUmlWaV8
         z7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243499; x=1762848299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpJH/9P6SXk4FNbPrBvyPZj8813+j3KAKeJeMOQg7WM=;
        b=SeqvVhGuMJvIluep2BwM/7IQ/LvxSrPVbJOsDl8akb2+rXJO2XlU3lB0e0ukGSB3D4
         8osVw/zhn3Jd+Ua4vE/2FPl/uQdunSutN7t9UdMfReSjzc+Y2V+jFz4nE6SAVwl68Qrq
         ck/mNUMgJTd4ZqZ00cyCQYR5mj5YRX/VVjiP+cZW8Vn2ZFzu40PMdzB0GFLKmAOrXMnm
         mn0jor28b+lC5Vtxmw6a+bhYJ4LBHKpQdagR5faRyb29EQrdl2peiiOwbwcn1exdla1I
         SUTJ0dCnDTpwkupre5zqxA7Nv25KRMBTIt7/gHU3N5QpR/BPtQhw3HN98s7MohmlGrjf
         BKmw==
X-Forwarded-Encrypted: i=1; AJvYcCWKQsAy+Ea44UtofxkrkPXbQa+yPjv7MNdVzptMaRtLlfP3/CFLR+ZCtN8dTn7EV1j2IjrnAQ81D9ABRBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVW3H5NPNjoQ5hW5qsWybeo1Zm5otV+VGNcXgJZ/XkRoVP1vb
	gbDEOfCNtIz7o6qdGRpyPmLnfxonkKaSrHpXpkecyfh+ImPhlWTxOajAGKQe/wUiuia3aQF/sAy
	hyyCcjecOAhtbRRe3315Rlnh45kJ/RDYZjygw0WgRgy7to/3m0M+t6HRIXRs9w5Pm/is4DLkiOS
	eFkl/t7llv0oTR/O2+MWw6NKnuUBIeDmk/FpZiJGsH
X-Gm-Gg: ASbGnctGtsN7eSkBjBF9LHyV+EI+sGVoe+vV06sanp4V/okrnimVr1VbjWvuwQs/Nwn
	PFmmA67cH0wdY+gTVY7esPiVFFAurAcODlTkyqPgt5Q7iCLlmR2lXVZ6hr6AW10AbZFOcgFvj6V
	7StwIdLa4CdERJ6N/CMCXpsoQOmlvFTaMS7H/wXTktK9k67ufGNj84VH3w
X-Received: by 2002:a05:6512:3b0d:b0:591:c8ef:f838 with SMTP id 2adb3069b0e04-594348c3813mr708404e87.17.1762243499524;
        Tue, 04 Nov 2025 00:04:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZgd6F0L+73hwJktp12hgvDYHWIWj5x9emdmzjAQF13GBDuJTprFLPwBs+j1ghQXcA1gyN6xOSkwulauIDILQ=
X-Received: by 2002:a05:6512:3b0d:b0:591:c8ef:f838 with SMTP id
 2adb3069b0e04-594348c3813mr708396e87.17.1762243499109; Tue, 04 Nov 2025
 00:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102152540.871568-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251102152540.871568-1-hehuiwen@kylinos.cn>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 4 Nov 2025 16:04:47 +0800
X-Gm-Features: AWmQ_bnYavI9hI64SjKyEPVXRfR7Mm8S6goViesnbRWVrmUWciFEXEuTuMfqNZw
Message-ID: <CALTww29GVOw3sk2=A_9dj5QMGtfogRjxRsunc1D74AqLFj_MyA@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: remove redundant __GFP_NOWARN
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 11:27=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wro=
te:
>
> The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
> 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
> remove the redundant __GFP_NOWARN flag.
>
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
>  drivers/md/raid5-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index ba768ca7f422..e29e69335c69 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -3104,7 +3104,7 @@ int r5l_init_log(struct r5conf *conf, struct md_rde=
v *rdev)
>                 goto out_mempool;
>
>         spin_lock_init(&log->tree_lock);
> -       INIT_RADIX_TREE(&log->big_stripe_tree, GFP_NOWAIT | __GFP_NOWARN)=
;
> +       INIT_RADIX_TREE(&log->big_stripe_tree, GFP_NOWAIT);
>
>         thread =3D md_register_thread(r5l_reclaim_thread, log->rdev->mdde=
v,
>                                     "reclaim");
> --
> 2.25.1
>
>

Hi

It still has other places that use __GFP_NOWARN in raid5.c, do you
want to remove it together?

Anyway, the patch looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


