Return-Path: <linux-kernel+bounces-725668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2EB00242
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B581AA5A49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF853258CCB;
	Thu, 10 Jul 2025 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1O9xHZP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D04257AFB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151410; cv=none; b=B+cHqZTD2lxrYaAT+T9ZnyHNcISEybHJOxsS3oySN7tFQG/zaOMFs50ptvaS0+48Huzm4wC1ryYr/nR+dFEXXp2CiZT1sVvWH9qU+PJ7KdaheozCo9MP87X9m1ZVJdA/RdJREniH0hXGL+3ecfQbzdB6iCUH/SpPmCaP/gVC9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151410; c=relaxed/simple;
	bh=s6KFsIWe08m+NRGKyxGg6ZnduWNzBb00Sh/FpcugVHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBRXXe0BYvdkQR9U8IriK4NcU7sarPxBs9L/8JQt0qFDUds9HOslIKc7xb3uqLEGZuqFfv2wsaTKdKwY+XfmSns4h/aQJ76vcPmHe9zx4M2A1WU5+WvWArGYPfbHrPiJBXHBBGUR8O0kfIdVJY59N/RP1zDrzEUmosY9qtIWEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1O9xHZP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so678186f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752151407; x=1752756207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLZ3wT/zIcTlhpVZ66G+GThU9XAAh1rTUV/NBZEfAJw=;
        b=R1O9xHZPacRsBm/CTrjEThcQzEXUI11c5il5Wq0Symni4gDb+cmtt+GzfVGaPhcr9a
         o195hezsnxgq/x3dG/8P5ynPdBJmfmG0BpNjUPp3ZZW1WecwscDdDLCH7ZHH+TC2dkmG
         an9zjuVLjK1p4ynLBvNmowWSDWgpKtXbusO8Q+awMrW8j80cdXMIKoRriF5ni+i7oT6Z
         eX8gq7+Wrv7VOGjZ7BjctVD2NXq7jwfbvxbGVhvHOSZs4iLjfMsEbNLqXikl3EggeIJ1
         +l4VSQApzkw848twI1gzQPICy2xD1aXHOJfv7jE+yR3IpmmU0jMLUv1nl29elEyFP1xD
         iRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151407; x=1752756207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLZ3wT/zIcTlhpVZ66G+GThU9XAAh1rTUV/NBZEfAJw=;
        b=mcKjtpoa4YOlGOs7U5dFozPkmvbYlUBze9LF/zO/4cbBg8CTyFwAHtFzhU2uCHdwGf
         cngCJUBLCm4Bl+GACE2m+9rCWvwb/QYDEPGQJ80DGOAkX/rsuXlsiLBMaVoopWLWrN9R
         2wdp4e5K8EuH4+LiZ51nmWb8ZpaLG/Fr/8WBP+adjzlS/VBLgyVzoY6+DyJ0g8w9HQgg
         tKNpX4bGdy8gnNyIFSBnbTh3+m/NWbej0Ngbeb21hXnQG5iQe9PMz9GgOEB6g3p+z7BH
         qAosRyf4h4d5LBBjm0cB6rlfMt07QXfEuSU2JQV0wbueOpuTBuGygnokdQhxhOwotR6b
         WEKg==
X-Forwarded-Encrypted: i=1; AJvYcCUhJ0kSEissoZKT8BXuWGlAm7Vc5M02yF/TwM53o92BG1y8264T0pGLz7izR6WVwdQowFmyb+6foz56C4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN1lR4p8d37B1uXKaSbWEMH+5STTmQA19k1oqtZbxLmM5zD4tL
	uBBvaZWhkKeQio5XGq2f72jB9NK/jlMmm0OkJaK0Xt70bJUrB3VgD8xs1r08uoh40QORV29uSvV
	qGdTkuyo2TridHJTWproMHL5ukA+iz/I=
X-Gm-Gg: ASbGncuRmACy+AuHzPUrihZGGGUU/6G0iOLHv+TsLqVx259x+XMZ74LJSFw6Y/c2YT8
	jaCf/G7zyjiHZfflNBk37zj1PuyFCDKzvESZtsce5OeoKxqlpQ7oltGwuuiAQfAhVZSo8uuf2p/
	iWXm52N0hb8BGLCYHCYjyUAvw3SvifE5EoE7KC93snY3/0rA==
X-Google-Smtp-Source: AGHT+IEnLv+M1cm1e41yBczHzCqcGvBz2LxWly+f89XFFbMNN8WbM3UxVWoFEfEmHMVnnkn6nxf6P78yVudOGfXKEXQ=
X-Received: by 2002:a05:6000:22c3:b0:3b5:e07f:9442 with SMTP id
 ffacd0b85a97d-3b5e7f34672mr2613771f8f.19.1752151406804; Thu, 10 Jul 2025
 05:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
In-Reply-To: <20250703181018.580833-1-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 10 Jul 2025 14:43:15 +0200
X-Gm-Features: Ac12FXxkeNT4SbQnhPymL-kgefhQmsJ3o4VsRU7W2osYTS5GaGgeUo2hYTeE0yw
Message-ID: <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible deadlock
To: Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	byungchul@sk.com, max.byungchul.park@gmail.com, ysk@kzalloc.com, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:10=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> wr=
ote:
>
> find_vm_area() couldn't be called in atomic_context.
> If find_vm_area() is called to reports vm area information,
> kasan can trigger deadlock like:
>
> CPU0                                CPU1
> vmalloc();
>  alloc_vmap_area();
>   spin_lock(&vn->busy.lock)
>                                     spin_lock_bh(&some_lock);
>    <interrupt occurs>
>    <in softirq>
>    spin_lock(&some_lock);
>                                     <access invalid address>
>                                     kasan_report();
>                                      print_report();
>                                       print_address_description();
>                                        kasan_find_vm_area();
>                                         find_vm_area();
>                                          spin_lock(&vn->busy.lock) // dea=
dlock!
>
> To prevent possible deadlock while kasan reports, remove kasan_find_vm_ar=
ea().
>
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Reported-by: Yunseong Kim <ysk@kzalloc.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

As a fix:

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

But it would be great to figure out a way to eventually restore this
functionality; I'll file a bug for this once this patch lands. The
virtual mapping info helps with real issues: e.g. just recently it
helped me to quickly see the issue that caused a false-positive report
[1].

[1] https://lore.kernel.org/all/CA+fCnZfzHOFjVo43UZK8H6h3j=3DOHjfF13oFJvT0P=
-SM84Oc4qQ@mail.gmail.com/

