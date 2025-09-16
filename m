Return-Path: <linux-kernel+bounces-818071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E551B58C60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54313522336
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADBA2550CA;
	Tue, 16 Sep 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMPF0ipN"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F582376F8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993398; cv=none; b=rU6Sc3gXVzg4NSU3F3cNOlLxTQMUGkJyclVuhhkaMyNRh/VhhWmum2DNZsXaCqh7PHJMucOFQRRc9sUcXSXOtKJt0hGhhiQPh63sZBnFsyd/EOFQv5unFNeG7KNnbYQfLv0bCF1PkwwGspiHSkaYhyBG619WVJIn2O4FWxGjFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993398; c=relaxed/simple;
	bh=8csgOyWqwFedICGI8KuEV1/4Kho5ECv92muZvbd3/P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4vWB2qXxLUV1q/MThgDDrJSs2fZLKIAacnuC1VGuRYzqqeuO/Lpq7Vt6ItTyhnmhBTq1suHcccXnuNcexUEl8Oz7VvufbESZP06LklL2f7BzeV5ihdO3/O2jmu0IoodDqqLzV+R9Fhyjvk/Wz392VA+E2M+zw5mb/DUFXm/YEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XMPF0ipN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-776b0100de0so1764758b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757993396; x=1758598196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxUjhwR9VEHGUYwboJUS57OxMHHZMq7UtIv/Sk4NGQY=;
        b=XMPF0ipNjVqmQidmR7u2rf1J3gdKyFuBhLRaOpvp3wrFtigQv+P5CbzkyxEqJCRI1s
         9Do4PtRMQVrU1nvQ15ihU3+JKwEexOAob0yCLMzxKkT6B5apotErDRt6O7OIomqbUAg5
         LlMpAtDlSbeQe98BLHJl6kI6shmBGvw8x76YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757993396; x=1758598196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxUjhwR9VEHGUYwboJUS57OxMHHZMq7UtIv/Sk4NGQY=;
        b=lyGnWWBZlWCGjGrryatBmzm2d+Oc60FXA/8T41RPC5Vokvpq3vtqOtj8qbLxknaeAo
         wm+uEP7C8IicaMmDFGXB2sKcDBwmAdnX3rPn3L4nduB57ysNzE/2RPJrMRYfhBs27+1C
         XHkbkmudIriR0zDm3WX9Horj6Sq7d9hP7k183W/WldCZdXyEtqHBeoPLvi3qUmojYYbz
         a/vr6gkmSPdQEmlcZIq8Ns5KkyAOmATWIibanzefeK2fDhl7Rba9lB0s63QCQ1BNzJOl
         E+meZJbBmO6qVikD9FpIEoGlhJJFwZy8E0oI+VjmzYKuhby1akXy13GHoD2jbZ71sLLU
         QEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY6RTjo2UsVF8qZJEf6iW3ZgHjSgwf8pWii7p+xgNlE0NLl1Kfw42SB/ENIyGa1ipn2WelU6OototQ5jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEgelGbWdPSHbihLBDRaNd5pbD2IcXb0nUP38+EQ88ukmS7/W
	UbQl7N+B/6rCgGyaVtaVFNqnuT8MAm36TFZvsnCpY3it90urGt3fbaX8r3J9JdxGYw==
X-Gm-Gg: ASbGncvZ7keGNF74oHKmkBgCPyzh/2b6Qv0obzsGt/ralVMM9gmu4SoxWMgpJXS395I
	ybK800F0H/zIslxI/CQVF7Z9rtqN6qd2MwJFrPKSr4C7nUtLUXnP6jo36ehirHXauutOZ83nr4G
	HYosAMjIZWhcanAu9bh9kxA4qQwTtgijejj7XheYe8yUxYIhga3z3asn7G5m9c9bI88JmQ5efJD
	2IG/5VnwmDKQ6rlt1YqeWqDvvG8dkvRm3KYyMkqo0dXXb12T13JN9QXG9W6r2NtznE9yFW+UzaF
	I/VlUQXzy9iPUCSeKkF/VpxHlcA1P9RPX4HO7XK4HDqa09hDRJWY7vcCqryNOyQV/h6q+Zomqr2
	Oy0Ozild0CEzIIfgZzR0YDaLizQ==
X-Google-Smtp-Source: AGHT+IHUdGvf+grPzySU6sU1K6kv4ITsptEWc28oqLzHAsC2Xe4Nyh/n5AaIqBF2emksjORbwfcs7g==
X-Received: by 2002:a05:6a20:729c:b0:246:ba:2d9c with SMTP id adf61e73a8af0-266f4bdfa24mr1303797637.16.1757993396177;
        Mon, 15 Sep 2025 20:29:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c321:7d8a:f9b8:7671])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36bf815sm13259169a12.15.2025.09.15.20.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 20:29:55 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:29:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <u2kujkv47egugef25at3rykkwuztel6tg6rjqqadacv2nj3pkg@qmxkftyzmayd>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
 <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>
 <tbvushbdn7nzitey3uy6humdndd6247r4544ngqkds3cr447e6@prnla4edwxmk>
 <f3ufcsjvvxhi5gzw2wglkpedgyyi6tiaje7em3tbxkzhklphvh@sv3dbo4yba5p>
 <98B3AFB0-EBD5-4779-A5DB-FFA6717E83C3@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98B3AFB0-EBD5-4779-A5DB-FFA6717E83C3@konsulko.se>

On (25/09/13 15:55), Vitaly Wool wrote:
> >>> I can confirm that android uses zram+zsmalloc.  As of 16K pages, there
> >>> was a way to toggle 16k pages on android (via system settings), I don't
> >>> know if this is the default now.
> >> 
> >> While I don't know what zsmalloc struggles Vitaly is referring to in
> >> particular, off the top of my head, zsmalloc does memcpy()'s for objects
> >> that span multiple pages, when zsmalloc kmap()'s both physical pages and
> >> memcpy()'s chunks of the object into a provided buffer. With 16K pages
> >> we can have rather larger compressed objects, so those memcpy() are likely
> >> more visible.  Attacking this would be a good idea, I guess.
> > 
> > Yeah I personally think attacking whatever problems zsmalloc has with
> > 16K pages is the way to go.
> 
> Well, there is a way out for 16+K pages, that being:
> * restricting zsmalloc to not have objects spanning across 2 pages

Yeah, the big problem with spanning objects is memcpy()-s, which we
currently need to do because zsmalloc() users expect linear address
from zs_map().  This doesn't need to be so, however [1], as zsmalloc()
can return SG-list instead and then upper layers (crypto/zcomp) should
handle that.

I have to admit, I haven't looked at zblock, so I don't know how
zblock handles it.  I'll try to look at it.

> * reworking size_classes based allocation to have uneven steps

If I understand you correctly, I thought about it briefly while
working on configurable zspage chain size [2], I think I even briefly
chatted with Minchan on "should we open code size classes instead?".
Then I looked at clustering (size_classes grouping and distribution)
and it wasn't too bad.  However, I don't think I looked at 16K setups,
things might be sad there.  Another thing in my to-look-at list.

While looking at size-classes clustering, I also sort of thought
about limiting zspages to one single page, so that zspages would
be a collection of fixed size chunks and each zspage would maintain
a bitmap of used/unused chinks, so that we can pack any objects into
zspage instead of "one particular size class".  But this has never
been materialized in any way,

> * as a result of the above, organising binary search for the right size object
>
> This will effectively turn zsmalloc into zblock, with some extra cruft that makes it far less comprehensible.

Is v4 [3] the most recent zblock version?

[1] https://lore.kernel.org/all/Z8K10w-6fIpDhYc6@gondor.apana.org.au
[2] https://lore.kernel.org/all/20230118005210.2814763-4-senozhatsky@chromium.org
[3] https://lore.kernel.org/all/20250412154207.2152667-1-vitaly.wool@konsulko.se

