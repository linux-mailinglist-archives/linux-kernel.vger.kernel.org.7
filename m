Return-Path: <linux-kernel+bounces-807928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E28B4AB28
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451704E74D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD8322A3F;
	Tue,  9 Sep 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTzwqRKr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E483322C74
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416029; cv=none; b=TT+LatgJLTcooX8J+KJFkpd5GIaI/iIQrsxeIyytlIvmEbFOzdxZQ3Mt5cj83FFBBTakBpSa3NkHa5noFqO0HEXKjyphGiYQLIPshNp8wFKy4nD5CtzyPw5KfxdVU3y6HlFJFu+r4yG6NItOFlRrj55WbTKL4CA6GRAfaYX71Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416029; c=relaxed/simple;
	bh=eGHe1jcUmg5KUlhvrK6wv4UHe3itsWYAkQSUtMtqe/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rg6NqDFhtiJ2EoNjA+8MudNdVNn9NJ++GpUNuxReGJOfZI/UwMnFwc0sS9qjydKYpDKRrQLPspKNSHy4ty4rLPG15qX5349SAjE3OdVchjlG7t1kFc2jfccuxgX76RdVD38Qrttr4YFhKGGouQ9xPYDZLHghlyh1VgzAEdrrp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTzwqRKr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757416027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F645HJ3vveFmp34mF8+WjlKqHIVzKpVZ1NP3PP0iotw=;
	b=gTzwqRKrqOdl90AwgwrNFvvtJZM0mi3t+ss2O+MvZcCmFRBEq1jws0mHzrzIGbsO/QaHKl
	E2oTtIlmqtXnGqZpD8e7zB/hi3hucaOxUEidpNoVPyhVVTkP8zBi7iVMw2ccjiAl0dWA1s
	O42TJPx0ZRPZ7Ypk4EIqkoOeNMCb6vM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-UzCbqJpwPbiAfJtWoI-kHg-1; Tue, 09 Sep 2025 07:07:03 -0400
X-MC-Unique: UzCbqJpwPbiAfJtWoI-kHg-1
X-Mimecast-MFC-AGG-ID: UzCbqJpwPbiAfJtWoI-kHg_1757416023
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3df9f185b82so2356528f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416022; x=1758020822;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F645HJ3vveFmp34mF8+WjlKqHIVzKpVZ1NP3PP0iotw=;
        b=WqtF4bwzpXeaLmMZi5VTVdiggvHHPg8rExICdH8OsmX1I8ryrPzoGTHm4Uy1RM89pJ
         ZXetkb03vsrsMypSRIgdYApfSi5Z+7pJlFhZ5Ol8fCL6XgIOQcvLk6tLvhpGzm8n88gm
         dPHUB+A07yvgF+gxZKVUr6QY8sulXTcUM/qCUBhyfj1SmoaXhxmZK3q7FKCR8Rub5RSr
         bc6YuBS44SKXi5P6ZbeL2ANztKX6/QuBTvfHhRciG7SaAPbQ3+3nh8dUUhLeUlUagspG
         PBthejGFXlmLDSuYotAYvuJcqLFt1pC1bwQvqaloLWoxB+hQD8AFUmJSfcozdunyDITM
         e3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUD15CrJijPE86UqvC2GlEid6hAXEjI566C9nM8Q4uQO+blnMoLipHbeX9iQXOiRwvNZZu/P8j1z8rqQ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYsfh7AMgD5tUA/+oMECbHrCmOCVN3DW/ajqQIVrpXe8HkMX42
	BPf+JkevHsh8fbbB5uLyqZhsgK88ns7QGscVTHR5thl/eVbEuTz/a0e0vAc2wpwhWRqTYDVPmOY
	kV2uFDEANa1rvdnpoXR0s9PgVvsz955BicjsKzhGEF6uCIR2d4v5aCxSfOLhusTnLdQ==
X-Gm-Gg: ASbGncsy/n1Diknz6aBdFZRns0vjGUf0YZJagxIO7rcT3wL4rYlDZCmKYo/48TDkTfc
	+CcYkVPXerdd+J5ERWmx4G5Ovwe0Qe9IY56lwt6v7wfuXBrvpDSI7IZSvrQawTqf3kXtoXDo70X
	IDQQoBsPI30e1P7mH3EofDH7MreGvAIIwWU8jGUbFXRbROUeLJfWCXsnHBgtQElF7P1VDVWEDqA
	rz09pNtr8jJmtTNQS61i6196ZDMCU2nSwbBJoqDX14jIIgZHrxWP5tuqWYX4brSi8ZE1TxxEIa1
	YLhBUThZzAxIISRoII5VUTjeJ0w51i8pocdtLe3RSR/HWzKFDeNJ+e+o8T2kkNilUg==
X-Received: by 2002:a05:6000:3108:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e643ff9652mr9440730f8f.63.1757416022498;
        Tue, 09 Sep 2025 04:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeI98m17yynV1gNprmpuJG/4VqnfMA/ofoyol0VPV/L8nFCDCvGKffsiP06RboObT8nGFhQQ==
X-Received: by 2002:a05:6000:3108:b0:3d6:212b:9ae2 with SMTP id ffacd0b85a97d-3e643ff9652mr9440699f8f.63.1757416022037;
        Tue, 09 Sep 2025 04:07:02 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223898csm2306074f8f.39.2025.09.09.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:07:01 -0700 (PDT)
Message-ID: <93a46874ceadf0080891e06d930336e120f2d753.camel@redhat.com>
Subject: Re: [PATCH] rv/ltl_monitor: adapt handle_task_newtask to u64
 clone_flags
From: Gabriele Monaco <gmonaco@redhat.com>
To: schuster.simon@siemens-energy.com, Nam Cao <namcao@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, Christian Brauner
 <brauner@kernel.org>, Stephen Rothwell	 <sfr@canb.auug.org.au>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes	
 <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel
 test robot <lkp@intel.com>
Date: Tue, 09 Sep 2025 13:06:59 +0200
In-Reply-To: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
References: 
	<20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-04 at 13:36 +0200, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
>=20
> Since commit edd3cb05c00a ("copy_process: pass clone_flags as u64
> across
> calltree") the task_newtask trace event exposes clone_flags as u64 to
> its callbacks.
>=20
> However, ltl_monitor was not adapted, resulting in a faulty callback.
> This also resulted in an lkp build warning due to
> -Wincompatible-pointer-types.
>=20

Looks good to me, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Adding Nam (author of LTL) to the loop.

Gabriele

> Fixes: edd3cb05c00a ("copy_process: pass clone_flags as u64 across
> calltree")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes:
> https://lore.kernel.org/lkml/20250904113334.18822d43@canb.auug.org.au/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202509040134.bQVbm7ja-lkp@intel.com=
/
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> ---
> I did further search for other in-tree users of the task_newtask
> callback, but the trace macros make it a bit harder. Yet, as far as I
> could see, there are none, so this patch hopefully resolves the
> problem
> for good. The other matches all relate to "tp_btf/task_newtask",
> which
> seems to be unaffected.
>=20
> With this patch, ARCH=3DS390 allmodconfig -- that originally tripped
> the
> LKP builds -- now builds without further -Wincompatible-pointer-types
> warnings.
>=20
> Sorry for causing this trouble, and thanks to Stephen Rothwell for
> testing/reporting.
> ---
> =C2=A0include/rv/ltl_monitor.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index 67031a774e3d..5368cf5fd623 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -56,7 +56,7 @@ static void ltl_task_init(struct task_struct *task,
> bool task_creation)
> =C2=A0	ltl_atoms_fetch(task, mon);
> =C2=A0}
> =C2=A0
> -static void handle_task_newtask(void *data, struct task_struct
> *task, unsigned long flags)
> +static void handle_task_newtask(void *data, struct task_struct
> *task, u64 flags)
> =C2=A0{
> =C2=A0	ltl_task_init(task, true);
> =C2=A0}
>=20
> ---
> base-commit: edd3cb05c00a040dc72bed20b14b5ba865188bce
> change-id: 20250904-trace-task-newtask-fix-callbacks-b158634c59da
>=20
> Best regards,


