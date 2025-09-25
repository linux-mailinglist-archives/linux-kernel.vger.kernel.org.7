Return-Path: <linux-kernel+bounces-833175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F091BA15A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B8B19C3E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C52F6560;
	Thu, 25 Sep 2025 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX+IblLj"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84545695
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832102; cv=none; b=XjYR0D/th7PE3o+PQVRPkEhPv02/F/Ou/WTeqADp8rzrwjnEeFcVB0QgWpMoG3PtiHtkPc9PUjbYwvkccQ3Zfypwskh4PeLeyq9EGNkhNRP9PWTT+y1futyEdiuOEyx5mftqc6PRLOb8Y3MMV8wVAPSBI/KV65rBr6z7rC3GGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832102; c=relaxed/simple;
	bh=/x3BVki5xJ9rvTwx1usgqT8naKwB/z95k1bC4ssGpXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNq2I4Ux6CzbjvBxcNo8eTtTzY5n6oIhsoL8arCCJo47VRs7qGkeqzfrPVR5BnHwOgbdRRXeUQMP2I/lSDkQZNmmXQTvuV7UksObTfYpcPCPJHxQZcxf8saqw2ZFWW1KcazAbm+gQUt56m8aQV3tRuEFPu/WmPgI357RfyakIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX+IblLj; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-76c144b06fdso2764967b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758832100; x=1759436900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVmWJqFwwC9UwpxqsqqkVVx9IUzg005YrMy6SZ7c5p8=;
        b=dX+IblLj6NEgIcoSLiuvNQGk5ieZwGfP3BLAHgkBscUAORqQHjG20OdzHuYzO4wsHh
         cQBr78tJMQwfQ6Nmx3pmxAE1cYw0BsCYduQ2lD8UcAHE8e9BcJtjqfyGSm2HYMI6au2o
         u9xaPbo8N/PIXzcI506tDqoQ4EDe5N/338AwG++uuP+D7NSK0dLr22WJGNtNyvc6mxRP
         SlJAslWP2FdLyZFH8eto5yg9jsT9IbGCRroaFLKNdUwqCpMKAmf+jdea59Wb0bZMkkE7
         b8kGUJSuI+juTJms5ymFThtnDp1sD3Bpv5LkJ/1c5LSN/4WRm/6ei8eeDpXejaq4FpdC
         m9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758832100; x=1759436900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVmWJqFwwC9UwpxqsqqkVVx9IUzg005YrMy6SZ7c5p8=;
        b=EyKtIC/IzbkqCpscJspqP8dDe1cVMplh4wwdZ709YUpJePNYo4dobMG0RKuMOl2VV7
         DwDV0IP2r2DQ4/pNROCB4OWtXlvUngMXZJvlaJvnWTy27EXjtQ6HCSJTJICv3V3gEhuW
         wgsMwe4I8vlE2/PbRLAQwyMfxBPiKs9XrH7g5Yhd4CUCeEWCQFgXBxofwBLLWUPsQcfC
         Zf822CLfKNo1wj3q+S3ws5/Y5Z41Da4gG2v5adaGioelCYcdXq6kGPegJWzSU9M9qET5
         pTC1rvOewn4ntQXRYF8d9u/ms2VEqmKdOLYY6s+8G1cC6VJ5r3RSiB5UnoerERZdm7Mq
         42xg==
X-Forwarded-Encrypted: i=1; AJvYcCUuGWkT+NIV9qzMcWO910YethuUPWTILf/LuikvEJ3Ve0s3vxw2b+xiqKKx+zo0+zSK5r4vzf8tMrWpgCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwt3fMHN4SJl5S2kPYkTj4O62QN2Bjk4Gz7Xmh9Ree1BE0kYU2
	3T/D6XFSaLknv8Ai5xGhwunlqNASxG0E0B5RbsZOSyC2uhd67u8V/x1A
X-Gm-Gg: ASbGncvDxkJM/KCqaG0qyun1wtegvSX2clBoCp15yzXi3p0rF8cC1EfhBXQXO1luvlA
	sxzKdCjTl0CaZVHYTODa8RbPZkveWLfIynWxfNZwuzogY5s2I8/EQhjN7K8IFGRok1yzHvhHdGa
	yvnKQqF0DX8wPx3cjEwZdKQm9RGiyr60CBpQqYGpD636W2G0FOkONBPNX8VG0S7/0bPDr1zvJdb
	iGzpijzuPZkGMh9xgGgeCyt4/0nly0FN/VWhoRFS4plVjfBrca0hd3B57IYYnLI2a42IgauhgXO
	7gYYOaz+vJ/7fIjxuj+EQK5ZFRZLKVLTlFnAa7fnas/Dy+fxHKRKTjM8lI0aAyFpBUU0gUDp+qr
	ES+6yUdi6f3lHY/yvJwtV++sO7Kekefuy0VN7DGqcpdzdihsyW7aIZw==
X-Google-Smtp-Source: AGHT+IGpvS9NECCBBaVDmxAL/wsGDeZWDGx2zhrz3DD3pXcGgle4QeL0zP/OkJY10O9P4DBKPWx/bg==
X-Received: by 2002:a05:690e:4303:b0:633:a260:14a1 with SMTP id 956f58d0204a3-6361a735958mr2736330d50.18.1758832099499;
        Thu, 25 Sep 2025 13:28:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-76884f52fdbsm4344417b3.6.2025.09.25.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:28:19 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 1/3] mm/page_owner: add option 'print_handle' for 'show_stacks'
Date: Thu, 25 Sep 2025 13:28:16 -0700
Message-ID: <20250925202817.795114-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924174023.261125-2-mfo@igalia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 14:40:21 -0300 Mauricio Faria de Oliveira <mfo@igalia.com> wrote:

> For monitoring the memory usage per stack trace, it is more efficient to
> use the handle number as unique identifier of a stack trace than to, for
> example, read/hash all stack traces to uniquely identify them everytime.
> 
> The handle number is a unique identifier for stack traces in stackdepot.
> 
> This patch adds the option 'print_handle' to print the handle number of
> stack traces in 'show_stacks'.

> @@ -887,6 +887,7 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
>  }
>  
>  static unsigned long page_owner_pages_threshold;
> +static bool page_owner_print_handle;

Hi Mauricio,

Quick nit -- If I understand your cover letter correctly, you want
page_owner_print_handle to be false by default, should we initialize this
to false?

Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

