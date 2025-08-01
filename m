Return-Path: <linux-kernel+bounces-753526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C321B1842A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D1E627DA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D0261388;
	Fri,  1 Aug 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUIs5+r7"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAC1B95B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059725; cv=none; b=ikPPh4226FtvVvIcSJRLwuxdCoB9h8Yq6Hgs9gNfyLFwBVMqEjnX0Woqg1KItmZ0pVCUiy2pGkIpWSovlXFMrC4yqenSZPrMO0lmus0x7H5jR9v4qZYR951KxRjOCdPIYPgyhR3I57/9vtVF1GGf8dDyk+0NwHvbxfn4PPQ9fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059725; c=relaxed/simple;
	bh=UrR6XNUTj5kL1NrvKUt7vdFJKoDDBbSH4Eor0aEkOnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Va2IyElj8sA1L2mLihEO3ciFH97cAv/qIk2mVgFyVD29j4M+xMtCwD2OBIgaygkpTTjd2AXhBkqWvGGbKJcvECBUWInV3q+5ADezIW/p48Isip78jVaGkueqsvBFgHTiCt1aiNI5pzUdq+e9QxyKYi1eA9XAMFf6DuAoE7O/ETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUIs5+r7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71b49a8adb2so17120107b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754059723; x=1754664523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwxNi44Q9HFmkSLoMLMwD0FlHxsUEyWfhiB5kFV0nj4=;
        b=RUIs5+r7cPiRFGLV/hBAusDgeuP61mL91vItRD0QjoGczrFUorPa2z9IhJ85UoLOGR
         Y0x2QX22xo3d4BunmWrJy+mGeJHeZ9caFJwFwtdSCWZfBBx9ugors4fA0BlkwgElBGO+
         hgXeqKrfQ61AQmR4QLgA/gcXb7PXVCn5QrrsZyNrG9bnoFZysqzZI2mr1FO1UqQ2Shab
         mfEryr9i/NlgB4HsP+FzCh/OCJ/yAtbGgLij9N1U3EmnRGV8ugbWTlu4jsJVdKMFUjsn
         6qwRUwD04TN2XgJp1AA4jDPEDZaXmbLuQHFUCV0E6LrbmfrfjFJA3qz/CKo3hF4uvDnU
         ouhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059723; x=1754664523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwxNi44Q9HFmkSLoMLMwD0FlHxsUEyWfhiB5kFV0nj4=;
        b=Cz4Dl+uvOrDboq99P/BfNWuVrcacJnxHW7rNqtbYL5F/CiITy7yZy6Z0bFAHk/w+4B
         N28+oNaFVe5eFQuRqKSZBeJM9BTeI/rXvu62H0uU2l/Sq0Aqz5VX26N+Vr+0+mQBzAr4
         YRfq/kW3+pY3F534dpXIvbWwoFFnDNUAzV9LfKepC/ZS+VDmWVuSBbeVKaMczTbBzse/
         Ns/hJ5aMbaPjrexuIcbYr2VXlAASh/2sjZiFfXKWcDQe7UIY7eC8TUvIvjibMtK0VYTB
         r7TPLjcudADrgRKE5u0UqCGH3k0puKKszuqz9nw5PNWci32wbwTzRwB/fubhsbGc2EbU
         G5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUVb8ImiTRHoG/WBfuNFjG/b+JWmfno7rhaDvIPuOC0pj59LDYdgd9/tCg9TQuONJZvmQzQQTjZco/UpDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gD/7Re0iYBxyrN2l8xXqew6SM9ZrhyvKw3xRkBjjJI8/ehte
	eNttjqQTn+Ed0r8qUsyCqiVNljgnmdNWIFrlaFr+kNKiNRQlhEhaBqQR
X-Gm-Gg: ASbGnctSbGVVYrBpcQaZtJdLVR47mvvEI8S9uYFWrWmvwOA2NP3WWw+wk/VIjsJYaBC
	uiqjsGVp4dmdGKojWkByOVXhhXEgKzi7Num0EPZ0njnP1RF3v2XAVZ3o5KAlZNJkuv7kSxVATrq
	uhy8h6/r2/0QT11dkpqXGKFdQlrlxn5tr46VrOLUVdK3iHfhwVsvw/JkMtRVJwW15gChir6tXB5
	eZnuSJtGqbQ4F3afsjkD7xRtmT4UHhZTtMV1W7hAVoPcNvHHJEfNGZ7/lvHJ+tbP+fGdr0XRksa
	ID3BVlUGcZetoCnlVJd6VMPVJ1p/h3Qknuf7GpYUeNWGDl9eFiRp3IoD+PPuEkRuiq4prnQnu/e
	zaM6mSnfmAftLKyNTSwR2hQ==
X-Google-Smtp-Source: AGHT+IFRRoU6dN6eBPzOGXEZv+hhn2iNZpcOjnYUmOm/adUBtzqRYSVGAKD5VXXsBvrVU3+cejB68g==
X-Received: by 2002:a05:690c:7247:b0:71a:35e1:e1d5 with SMTP id 00721157ae682-71a465a20dfmr165964817b3.17.1754059722557;
        Fri, 01 Aug 2025 07:48:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b59fdcdf5sm10799037b3.0.2025.08.01.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:48:42 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mempolicy: Clarify what zone reclaim means
Date: Fri,  1 Aug 2025 07:48:39 -0700
Message-ID: <20250801144840.2067350-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87ectvamc7.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 01 Aug 2025 08:59:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
> > memory. Contrary to its user-facing name, it is internally referred to as
> > "node_reclaim_mode".
> >
> > This can be confusing. But because we cannot change the name of the API since
> > it has been in place since at least 2.6, let's try to be more explicit about
> > what the behavior of this API is. 
> >
> > Change the description to clarify what zone reclaim entails, and be explicit
> > about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
> > past already [1] [2].
> >
> > [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
> > [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  include/uapi/linux/mempolicy.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> > index 1f9bb10d1a47..6c9c9385ff89 100644
> > --- a/include/uapi/linux/mempolicy.h
> > +++ b/include/uapi/linux/mempolicy.h
> > @@ -66,10 +66,16 @@ enum {
> >  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
> >  
> >  /*
> > + * Enabling zone reclaim means the page allocator will attempt to fulfill
> > + * the allocation request on the current node by triggering reclaim and
> > + * trying to shrink the current node.
> > + * Fallback allocations on the next candidates in the zonelist are considered
> > + * zone when reclaim fails to free up enough memory in the current node/zone.
> > + *
> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> >   * ABI.  New bits are OK, but existing bits can never change.
> 
> As far as I know, sysctl isn't considered kernel ABI now.  So, cghane
> this line too?

Hi Ying, 

Thank you for reviewing this patch!

I didn't know that sysctl isn't considered a kernel ABI. If I understand your
suggestion correctly, I can rephrase the comment block above to something like this?

- * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
- * ABI. New bits are OK, but existing bits can never change.
+ * These bit locations are exposed in the vm.zone_reclaim_mode sysctl and
+ * in /proc/sys/vm/zone_reclaim_mode. New bits are OK, but existing bits
+ * can never change.

Thanks again for your review Ying, I hope you have a good day : -)
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

