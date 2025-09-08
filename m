Return-Path: <linux-kernel+bounces-806129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A1B49236
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F161B2490F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6330BB9A;
	Mon,  8 Sep 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPErVpPL"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEA2F3C28
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343572; cv=none; b=mAvDn+ThVFbHhPp9FEIN9R2eJmtCBzGeAm91DTfBCcx26bgR1vSnL/MdyzBqOgMkgpoSA4iTsnqCS8Ysna2vldTevYVPwsvwF8kUakdWWMREtgD7HIJ7xSw3m+MT/R3MEznSmUPlJl1yd2rb5Nu/lFVoxYoCswu2wvtCfw8qDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343572; c=relaxed/simple;
	bh=qCpK6OFCrAXWZyC3c9WtGrIupiWt1m8Hi382mlStvSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbhXvDQ61iSV2/gNtK/E9M0ucBWJmJdUfJIhqBkrppvLUBPsUBjESd+6U6l4WN0IJ5z7tLLRut8X1d7yW8TQo0p5JEsCjUt2ZUwup8LF1uQ8yf2zwD0MnMUxAShtzg23W2ak60iA3YWdElsXUA59xdUUeJkEPj9Gnmx3mPA3nOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPErVpPL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so7190501a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757343569; x=1757948369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCpK6OFCrAXWZyC3c9WtGrIupiWt1m8Hi382mlStvSA=;
        b=fPErVpPL3ECT2ZCY032Zoy0iTWtnGVuTQyHFzs0e4KVxsXAivGG4d5N0DqE4AXb4Pz
         Mwt0NRYG4CwV+LVFzFcnW912HYPniv28QG29e68efS1Pa+7nJ7mkbR0Da62Y2qNzqBIj
         06Ih3n6AHaFMosIq1GWYeMwVlfEg8+wDXhWekt+DLFRDHTKM3Du7lCjrMcwmgcOJWNuX
         /My1f1HhftYs3BdmWsuknmtcCGiyE8yWXUCdHIv3UtK2HBLq1pW/AiGToXcGZwmpCSgP
         i6OHvVXsKp1Mjrr7/+qAgAH8EdqrUFZ4IMoE8ErZ2PJ5kKBz1dTECNitD4mNOr6oH5qa
         xZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343569; x=1757948369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCpK6OFCrAXWZyC3c9WtGrIupiWt1m8Hi382mlStvSA=;
        b=FprZac0OGIi2y78mNB6rbpVZxFtBxpnnSoECFskB4qtCmvzZf57KR58PyOtiM/9eIX
         jyo7yp8iCRvo7k8wB8dmhKJR+1U5D8j+TChrpX6N41eBai1dwHxF6ejU6MZeSS6N9KOJ
         5lEIqvb4H3g6nsDI+BAl3dPBnwH7H5M2WBiHk7B0KHl1bczA6YhwwTU3HDYbeb0a3A3k
         HHbo57WFsSvtsclUyVovPILPkRTrTIQSHZBmmQUmwbGdWzt8Rhxg2ERfQzADh3yGrW/X
         edpn+AdyMobUhc8vllejnBU7FxGYCOuDPXU1RKRrWdnM6+o0w8IfPZgVqzo8VHoXalVj
         b1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVTxm4DFH1I2ING/B/DOvIdw58Dsp+b3yvhajRevmurehcYCWNv78qUqHvUcKIQwkjINL4NSh7n7UJ0Nh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzawSTqVhgOMhvKSMFu+yWYQsfCRwhfuykinEtYbG+RJaJs4eJx
	yzF1mIPuWhYGapLEJWhNCljL2zbE+yPpoAGipNLxWghfP04XtUtLPggTnGI12kixZmykgkhpU0W
	hYl9wWjww1n4snZxs8DhbDXeuKhd+beQ=
X-Gm-Gg: ASbGncvQLrwXaqxf/64nLVke77q9ZxzH/dhsRqIVRIQNvuJdWmgTUf3x+jPIaEZnD/w
	BMmeMD97rjcXodTxLTUOZRV9/WLupra90n/qJjV40T8DkJ72I3RacfpL7H4iOibck4c6Kigo8MA
	sfgHqHveKB5klaX7OVjYruDmLF0D5J/zjAnKOyMA/ZvIKI8NdYoN6kEgAA7pTWwV3gon2anEK+9
	iKet0VHeLE=
X-Google-Smtp-Source: AGHT+IFVR7T6+Lm4E2NKqekSiz8GZDSpXQSzI9L5eH92Hm+cLpHRFZSbl6RzOFr2DzC3gQRViVNaDgLDawjUGJ2YOug=
X-Received: by 2002:a05:6402:27d1:b0:627:9d08:97a6 with SMTP id
 4fb4d7f45d1cf-6279d089899mr4287732a12.18.1757343569461; Mon, 08 Sep 2025
 07:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-15-ryncsn@gmail.com>
 <CAF8kJuO31q0nZmZwxeMZDq--wH=zeXwsZ8YK2M_7CyYmbsOouw@mail.gmail.com>
In-Reply-To: <CAF8kJuO31q0nZmZwxeMZDq--wH=zeXwsZ8YK2M_7CyYmbsOouw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 22:58:53 +0800
X-Gm-Features: AS18NWD4IDdiHB5mIiuiWAojKjPiQpn3DyQZG4c0y4smD4KrFO55nVVEatPd84Y
Message-ID: <CAMgjq7CYuCA9-gV_SfD7+WkQSdWtN+pacrqp2TuMuzEzU-CBsw@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] mm, swap: implement dynamic allocation of swap table
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 11:59=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Kairui,
>
> Acked-by: Chris Li <chrisl@kernel.org>

Hi Chris, thanks for the review.

>
> BTW, if you made some changes after my last ack, please drop my ack
> tag on the new version or clarify ack was on the older version so I
> know this version has new changes.

Most of the patches are basically the same as before except the xchg
change and naming change. I'll mention and drop Ack's if any patch is
updated non-trivially. Thanks for the info.

