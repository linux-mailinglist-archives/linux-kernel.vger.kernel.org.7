Return-Path: <linux-kernel+bounces-762824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AB6B20B41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168C73B0AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929A214204;
	Mon, 11 Aug 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giaaLUpK"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361A20B207
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920998; cv=none; b=tx21kaq0SP5IdZ1lO3xupj2kGtGVMYAQyp6SJZ/WAFp0ByOlo24FAlg+yKgOtQ9G2xNqL2fErKes8Bd4R7uwekve+yImrmanENZnYAi0N9t9Uu5BiuO/6sm1hM2Et424s5zsU/AhI3wL2I/7pFxRrq9EhqJjcGJ8RGcM49JU7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920998; c=relaxed/simple;
	bh=w6egrbluYjyH+/2gaPgEShA3w+cVTQr3sSQ2l52QBH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdS4WoWLjQEJa0jstLH4yfBu9X+6qCfdbTlZ3UYai63C/xuRxW5I1fGDgTkO6NpP2chbVl6gZ5u7HwKduA09gA8wDdp8VZMPsKIclL4VEG81FJYGW1dOJ2H+D+nPcxlmCXxmsHvZEb+kNREZnKap+SXfIb9nqL+ZyS0M//GDKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giaaLUpK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71bd028bb5bso46566187b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920994; x=1755525794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HLJeGvuklMP7ATFsRoiARoYLmPkcqCC9xvrYga8Pl0=;
        b=giaaLUpKMG03S9W9zcZVIalIStWGC6udaOhPwjImjPVlxVuIMhzXDSEs8rDGh7R2iX
         gLLJw1lrXOFPi4pK4Zl5dG/DjCxl37fbvzaPwzhhdnYZ3SS/0AUSW1N118MCGQjEDn2z
         s7txBQFJqSNpFpUNTQQg8pUo3qy5DLII664JHx+pGemG2EKxa54NLGNglihhNqS1kAs/
         ahADYSaNbDu9kQBRqZ45h07G4Qsgk/A6hddF0qE56PHg1PXgHHGhUHk4DWX0PyrfGdqP
         2sQJyiLniwqNuVjgUN9oxgtnXMmKVJmZ2KJQjZ0VkSOK3cbXEpoayiB4WEjnbYA/XP+Q
         IVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920994; x=1755525794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HLJeGvuklMP7ATFsRoiARoYLmPkcqCC9xvrYga8Pl0=;
        b=qGnADY1qKSqVb11dIEQSXXlPNePnhBJRM0uO4aeR+aJl7q+uhYuMSkbCxUkR9Lm3vU
         ahWaQC/Ux4cWIyF3XPOU7zrwsRXCm5QthHMX5tIV0ThDfeKnUuf1sBaocEmNQO8m8NNN
         cs44qAunsFQoiESI7b6Ugje9pa2Gyw1WtwukhvuQzpHNX+80wpIq+gvUVV2gtfEpjwmQ
         GCLM4ZxqvqQ5+7dSZe0bhWHoFOfNSXzDK3028oGrOUl+KnSNNd90afA9N7n8Dk0KncSW
         0CG1ytjCyzPf58psPlWnAwJwupyHdxYsD1Ja0254jCOzFW9dJXipA3J+eCm/4zRP+oCf
         ZxTg==
X-Forwarded-Encrypted: i=1; AJvYcCVsbdamiQsrzZeOPMN1NWVSVbKhebTqYNN37FkAhY3SRnF+pBm7o5tynWsOvYZDvKAbvuZaFbdqSumqThM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw84J8TVGZYpsFXblKu8hRs/Q92RoshJe9KbPEC6s6Aefl9hIX5
	aHMQnVbuy+A+ZKm+IGBURZGbJsx7qXCbvoXpdcvwnZNS77o5J8LrhHkKCUa+fA==
X-Gm-Gg: ASbGnctwy9+lpBr0yDaYwpzIFfmfTUg5nZkGNJPGLFKCx6qpHWC2RdaA4cTsOjKqAr9
	E8LkZbyh9VU62SwoTaderSimLWmmbws2umiemfgmR2UXoCAPG0qd/dAX3evmrnHh/54JYePh07i
	PIj0QTQM/jtgjzryQdDUNMT0hxyXHKp1oD54WRUqBBqmbRiz0pHexGfdtZgPZjDn7qqSYayzZdd
	MGGJVCpDbcVkylR5U3QMdXkVXPztgPXQMeWtI6MH78J75r1mZH43KYIsmYxrS2yTyYZoX5/CqNR
	so4LlAybZgmSEdQ+16Ira8v0XISWpsLBWIDrom3TOzAvAgyr5zX5yBxUcJtWL5vxIgRaBgN0mIP
	//6GpZTpNSrVxVYTpv345pQ==
X-Google-Smtp-Source: AGHT+IFewBym46TYf2D5lfnQZS5KaqX6Do7GHSRbX+1k26Bp5AAhyfhZKfKCSKnYzeyr5076YpqTXw==
X-Received: by 2002:a05:690c:74c8:b0:71c:bf3:afc1 with SMTP id 00721157ae682-71c0bf3b6aamr93824817b3.17.1754920990350;
        Mon, 11 Aug 2025 07:03:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a59e9d9sm68953617b3.56.2025.08.11.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:03:09 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush.brahma@oss.qualcomm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/numa_memblks: Use pr_debug instead of printk(KERN_DEBUG)
Date: Mon, 11 Aug 2025 07:02:45 -0700
Message-ID: <20250811140246.3264034-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aJmjXABrInqumY1-@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 11:01:32 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> On Mon, Aug 11, 2025 at 12:13:54PM +0530, pratyush.brahma@oss.qualcomm.com wrote:
> > From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > 
> > Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
> > align with the consistent `pr_*` API usage within the file.
> > 
> > Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Removed printk header as suggested by Joshua.
> > - Link to v1: https://lore.kernel.org/r/20250808-numa-dbg-v1-1-2ddd1ec634aa@oss.qualcomm.com
> > ---
> >  mm/numa_memblks.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> > index 541a99c4071a67e5b0ef66f4136dee268a880003..ed6fcfca057ab4c9a8aa26cd1929551b4ded4a5b 100644
> > --- a/mm/numa_memblks.c
> > +++ b/mm/numa_memblks.c
> > @@ -2,7 +2,6 @@
> >  
> >  #include <linux/array_size.h>
> >  #include <linux/sort.h>
> > -#include <linux/printk.h>
> 
> Please don't, pr_debug is defined there.

Hello Mike, you're totally right, sorry about the incorrect feedback.
For some reason I completely missed this dependency when reviewing.
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

