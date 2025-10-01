Return-Path: <linux-kernel+bounces-839318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98999BB1590
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AB94C1604
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27AA2D3739;
	Wed,  1 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJSHYuyo"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE32D3731
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339148; cv=none; b=Z7yvQSEbuleR++qRUlcRHTjI1jvz2Bh8KgdvlThbHCgQmVJavKGrgnvLuax9dTJQn1m3Pf0TejwFemQ2xcZK5Sw5GG/c9iG66akOYD5zO+yr+7NwNj4HF7Nit+jqRlmhvNO9O80Pch3liX6Iy63CiXNQrXJNdWi+wKZYR4Jw5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339148; c=relaxed/simple;
	bh=0kcmI8aEU5QUSDgRbCIIeZGutsdROd4SPxVbBnnnC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWlus93iryzRP/9r+vp2aWuBx8tiVv3rHls0O6jEDJaGKgJ09qP4pvmfUzkG7P85TjWUL8WeOBHQVR/96Lditta6Bo8A+nHZGDKW3e5cqjN/w9hZ+KnaWguNtbkVN0Edh8TB6E6yNrh67MZLm8EZd/LGC73cHqiQW39GKyiEmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJSHYuyo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so2175236d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759339144; x=1759943944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zopXUsDspNb1mWWJAWkCzCfsfjyf3UGPV6M0TUuo+6k=;
        b=VJSHYuyoToYFOjVIdIJvQi1fhRNLlqXY7aiWGsf4nO3XJCgHxowhiMzdUHw2cZ5Z3r
         kKcBgcLSMI6mgI60yAKMSoghiHi/I3lKj32S5qRSb23eqgV/pA1Ng0FfEjKi33VMIDv1
         yBfKx+G8JubA0m55Pj2Ly70lVhCuGiUhELGp2WrvGXEDlb02jixPJGiY1tntqkKLVJiE
         jlxe6FQdaJogNM1NqKlK5BZb5h+WfdAlkJlgY36Zxl8q6SQYrCBUKpSpLVXpIbFj8/TP
         QC7r7fO+PbEFNJN31PcT3ei/l1LcxoWLAUPJWOZOMj8f2DkI/POZV2GxgUiT0UKNPtN6
         4fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759339144; x=1759943944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zopXUsDspNb1mWWJAWkCzCfsfjyf3UGPV6M0TUuo+6k=;
        b=EXMfBjfSVQm94lmYCIyFp1SULfGmAtHHld6gnOrmYp/JrsSOGN3jH3UU4GQLuPsejI
         oa3yjQX34qYSBam/2A6oQhA9C2CI8Op0008hg/1yNyoqnjoVlSBXlIH+jCoh7sUY/qHj
         fBieVuSLN4U4jXJ+wvkLF4sdM4CWJ0L3AqRDMzHw62bTFi0PJmo4ypic9Ac/+9auSLJt
         foBNUGwH6h+BBJivsc5Q5bHGYyyRXQ7Dv23hXpW25y0cTKqo7k9P3m86Ifa/JOyqaEyR
         NBiu5Qgoho5B3XxwUmwLe2/fAV2Rul93ptzKcaOUNQO+ZvG4MIz74xyGJgCdQq2hfMpi
         U5/w==
X-Forwarded-Encrypted: i=1; AJvYcCU5bHDcTsPuCf+/xZSpugIxfD/UAxAgFo+M0Veqt1vFDHrTMkce0FMmvUWp9Ijj1d1FdC26w1XeWr/zJNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7j0wdUO9toomd1Q5QmLHk5AJxEYFCJwPHw59oP/fS+6Ssi1VI
	DmDVlS96X+cQny0118zGJcleuDeDKOBqixgDaEibiP3tH4MJrsqfUmDY
X-Gm-Gg: ASbGncvxpui66PIZZCLBmp7JSSOe+ut2DkaY2Da5Y4fpH445mYjM0iUaoL5rnW3QCWe
	+SxOC6dJkGzm/HRzQIfSr5nhMOFB0py/KygPpH49qLog97fvMQpXrWup/DIuAp1i31UQfb1h818
	ijAhD4AvZuNQV+rJ5orfA1K5VsPlD29eY57ud1zV724xSKDLN57+e2j5Pf0adD2A4fRxoxw3ovx
	RcsJYX+DRKq1U/z3QWggK5bbNLSbPZGCunwxce01F/jHPZ+fRJxwqYo1CtuhsCd27b4e/nbolWu
	HObrQUTv0vgtu7dmMvXRAHp/BVASlU4efZt9yljDRxbQk4gEtU/fPZvOy3C8yUFcfIbryns5tTq
	AzueuRjzkjb+O9I91aDGp8dGk1sNoE4cBMKTyvJn6+g==
X-Google-Smtp-Source: AGHT+IHQhkaGCWCGXg39uCPJptTD10njVMqUQyeE04a/E92c7P5/6wo4qNH+/bkTJGYyPUCAdw9t3w==
X-Received: by 2002:a05:6214:f01:b0:78f:2eca:2000 with SMTP id 6a1803df08f44-8739be1b61fmr54866566d6.13.1759339144483;
        Wed, 01 Oct 2025 10:19:04 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::9c5c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb53e2c5sm1905136d6.25.2025.10.01.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 10:19:03 -0700 (PDT)
Date: Wed, 1 Oct 2025 13:19:01 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Simona Vetter <simona@ffwll.ch>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
Message-ID: <aN1ihRfB-GHTEt_4@arch-box>
References: <20250927075010.119671-1-albinbabuvarghese20@gmail.com>
 <cb00a5e2-6e50-4b01-bcd7-33eeae57ed63@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb00a5e2-6e50-4b01-bcd7-33eeae57ed63@gmx.de>

Hi Helge, Thanks for the review.

> I wonder if the image.height value should be capped in this case,
> instead of not rendering any chars at all?
> Something like (untested!):
> 
> +	if (image.dy >= info->var.yres)
> +		return;
> +       image.height = min(image.height, info->var.yres - image.dy);
 
This looks like a better implementation than what I had. I thought it might be
better to skip the entire row instead of rendering partially. I’m still new to
this subsystem, so thanks for pointing this out. I’ll test the suggested
changes and send a v2.

