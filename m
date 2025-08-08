Return-Path: <linux-kernel+bounces-760379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963FCB1EA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAAD1C25A95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2C627F74C;
	Fri,  8 Aug 2025 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlGv3uvL"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73F27F19F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663213; cv=none; b=h7LHYtk7i4p2vAPkJvtymkynPefZLPY6EzkfmTjb4pblSCZTHbL4TrjEWNb51qcDbwyKOppZg7eNlkCEw9Rpz0UEpUCjiRtvWdP1QCyc8SvTl9qSKmdHXKeL2cGk6cOtid+S3IxV28Z/c4SRP7aSo2VzULER/9ViL/VfLD65ULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663213; c=relaxed/simple;
	bh=p7NGNoPoaufz8nce702zKF8yTvc4ZU0Qw0BABs6W604=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0JTcS2kv9NijdfsoyZoS+99+0sElllm/7oVyoa1c8q+Eb9PB1MppIGS+z3JBDvuVfpr1M8WF8no4HOaDR4kSLDrK2xrQk+Nn3FJer3OfYWL0AHv6RGCr6J0M0coIe0Wh7hH/jrLPEwR5Cjb+lJdNqr/BY7kDbLUMGhiE9My24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlGv3uvL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-717b580ff2aso21508237b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754663210; x=1755268010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WDyJ4waytAxtZpeOUkPDIPxeUnmaidLETwAZBBpWqI=;
        b=UlGv3uvLYI42kfDQxeZAbDbVNxF9MfIq6oxhTi2dqjQ6FTm8m4m0vEZGm8UPIGu7uU
         lg6Q2T19cr15vRzHfM329mf6coaZy8+Q3T7lAcA/+qU5WmByb/6U43OtlBFhvtL8ftJ0
         sWKmb69Gif6V+xZPg18AdZOJL2WtIN852gy7IONhrcrq/Ue2h7cy/agv13cxWukvJJBC
         Krr+MIpFaPe4Ln06y8FE8kSGukCEYgjOJWo5j9rLigx81ESZl3KW6lh2f4uge/nBuUFh
         A+MTMnaUGNjwoWB2rThXw4G31K6vtBdvSxzTCmwauFLdbUVfPLOY+jbUA+bUyeSUERog
         a2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663210; x=1755268010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WDyJ4waytAxtZpeOUkPDIPxeUnmaidLETwAZBBpWqI=;
        b=BzmkFWt0FPloP5+FUoJ4YA/qBVeJDs1O2tPR/nk36artAhgNWMs2fyAfY+5Ntaezg5
         /mCjH4uo4QtSKTcpA3PInd2T+/kz65nchOq5Vuu4UmM8lJO1swJpWvVtHOxUxLY7nqM5
         7mj6J28/wtaa5pfc3yBhYwMfOi+F9WXLOlqOkPDXstX4o+Uzavf4llmooGrryGAVEk/5
         WiVlk4OCzuxtitWRxuPcbhTeMVIqQVN+kcO/HSDaNLQ5qCBOEwGHN7lvzluacWH8zhJK
         POaHQzC+HOI09Ktluh+eXFKUwrZrLYSn2DdpC8nvCM3ZF4Ged67kaDdzSWNmgL7mGLoN
         ZncA==
X-Forwarded-Encrypted: i=1; AJvYcCWRfHX5I4HT7VFZscZmaJoAt2OSHxFk4RdrGJA4ciIY42E7tV9ffbxW+Je8dCA9xApm3iQDlX9vIq5h9iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5VBK8yeLurvWzAh7EmJe1qQ+QzlQbA011UZua+ArVfea6I6M
	JkObxeyj0PBzT6UiiYQBpoI1poHi/odZa9iYrTctYQ2UD0lUeytWr/r01ocaVg==
X-Gm-Gg: ASbGncsF7DE5c6AMdeXu5LzpY6jEaww3OiDjXbmRom+V8GuyvtWzDXPuU3BLgS6P2Jr
	pGTk+dx2PczYjlBinItTFmfB2FDRGXWtTfSxgiG/dKZVTtQJAbZ8FXF0OBoIdDkZBLDhr6ghDoI
	rFS8mTyu86KjpVLbXG9aAAlixJHj/AJ93h1YoSO0SwaQ46llB77DmxRIsyx9T9gZ4CJ84Max91B
	8n+mJAQQoLVA3ZzBfSBJFFmCnFGIRWdlZn/M9oLxmjn77HcO3PSmVA6oeneUoRFs0ikUq+uGyhM
	xWdrqzzlFk7QrdkgWZnFh/ZHTtl1wPwKJtbwPPjoVTf1s+6Fyw+VsK+3oKy/QDjC7LG3DuaZNUG
	oQXdsU556JLJYkeXr4JxdjQ==
X-Google-Smtp-Source: AGHT+IFqxRV9qk9+Bgt1zIqDMjDP3x3ye9NX+PiP0o9Tsc9GXQ5uZfQ45/JcvIFJMh/gkpSCcv9iew==
X-Received: by 2002:a05:690c:6213:b0:71b:7043:21af with SMTP id 00721157ae682-71bf0f9a20emr39182247b3.42.1754663210429;
        Fri, 08 Aug 2025 07:26:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5988f0sm52671287b3.52.2025.08.08.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:26:50 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: pratyush.brahma@oss.qualcomm.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
Date: Fri,  8 Aug 2025 07:26:47 -0700
Message-ID: <20250808142648.254205-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250808-numa-dbg-v1-1-2ddd1ec634aa@oss.qualcomm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 08 Aug 2025 17:42:22 +0530 pratyush.brahma@oss.qualcomm.com wrote:

> From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Hi Pratyush,

Thank you for this patch!

> Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
> align with the consistent `pr_*` API usage within the file.

This change makes sense to me. Also, I think this patch gets rid of the last
caller of printk. Should we also remove the #include <linux/printk.h>?

With that change, please feel free to add my review tag. Have a great day!
Joshua

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> ---
>  mm/numa_memblks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index 541a99c4071a67e5b0ef66f4136dee268a880003..de626525a87c3ed54d31695e86f18c980c084558 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -76,7 +76,7 @@ static int __init numa_alloc_distance(void)
>  		for (j = 0; j < cnt; j++)
>  			numa_distance[i * cnt + j] = i == j ?
>  				LOCAL_DISTANCE : REMOTE_DISTANCE;
> -	printk(KERN_DEBUG "NUMA: Initialized distance table, cnt=%d\n", cnt);
> +	pr_debug("NUMA: Initialized distance table, cnt=%d\n", cnt);
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 479058002c32b77acac43e883b92174e22c4be2d
> change-id: 20250808-numa-dbg-62a8b2092c56
> 
> Best regards,
> -- 
> Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Sent using hkml (https://github.com/sjp38/hackermail)

