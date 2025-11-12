Return-Path: <linux-kernel+bounces-897484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F61C531FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD03563A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C70343D9E;
	Wed, 12 Nov 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3OalfF6"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE62BEC31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959272; cv=none; b=phm1q2q8BEyKPUiPQ0O4lQsSlJ8td/V2L62BXRcsQSWiip8100JJcWP/WVFiruWP8dmXnFhX2T9ZIcdllxQQw5K7FoocUm0ZdD/3FvR7oSILtlxE/NUEp5jmX6tK+QOW3lMi1X8FdY6j1ODHjhJ6MGhTgmTjkxUCvQYSxvnVedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959272; c=relaxed/simple;
	bh=Es4V2hOvKRdpsw6YS8mXJmboFpSdQNT35YFD/0aY9uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1L6HeovfxSCA7CVJ3EM1bwV8yD5Lbn9IRKaL0laoEH/tEj5hcO6ROx/s8nAVrlgebAfFE4SAS46+QiA3nljfD2J02oYg4wEgsijsagb9n2ylaWJPDHsBCfQmQW2dZb94272s/AT/mh4NLoKfU0Cz1oDPOqjjeACae4nBV+BMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3OalfF6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787da30c53dso9423537b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762959270; x=1763564070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Es4V2hOvKRdpsw6YS8mXJmboFpSdQNT35YFD/0aY9uo=;
        b=W3OalfF6XcEplxC1yozGI9O8K2s06gERFHMeYg6Ob+AQ29WKg60E0J0tIjk2r3qlUk
         GREzuOTZ2YCBSbOWuN8Tq0tJF3UTFcgMrYO6b7lHUfllFi2ZF7nlOgjstU/QIy14MXj3
         aaBR0FAO1mAKJwgAAwmGrWVFSsKS5MwSLB9s7RccxkmYCEIhYCExQ1RcU3h9uRvkf8qj
         SfgHCN1+neE3TUciE0KrhRFTW/bH8lCJaQhZh4rZUP8CWfgdDBIY+ymf6KEQeqtR81cV
         H+tJFGzHPo6FF9c6IYjroWg1z3bze+sjeBqEYMb6sdA93Hr/m9fNe3wu8hqm83ihWC2l
         JMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959270; x=1763564070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es4V2hOvKRdpsw6YS8mXJmboFpSdQNT35YFD/0aY9uo=;
        b=cRXJvjidB+LIaX6qLl1kisZtAcqta17Tdh6rIEbUJJikgKCVNeI3NtHNaXANzbjCVu
         wMj2DIglOBgfjnj2MYq0L/mfQzZN9cqsoo9XsGZ88cbLyeNimJwdi3KtNYB2/nZlI1Gg
         +tKGjamPL0uNkrOnGiU9aZefXRiK9xoWMKVtmK19VfYw3TZTUGEpT3qhiiCHeTPCWxF6
         fuyX1gsBd09NaCVcm8ALYPvZSbBIARUs3h2gAAXKV/HVyvxL7uZK5fefEaoA+fTp5Tj3
         1UVDYG8+rnxOHnpOkKrLk90fgn1vSs4enDlvM8J0ZqJh5nf2LT9aTEfcUr5zPYDEVACw
         JLDw==
X-Forwarded-Encrypted: i=1; AJvYcCWvrPkeU2lH2ygvBRpldVIBCMlB4iqWhGMwWbyhzqKhfN25cLq5KQEnQtlX6a4dm78SFkghtPqy2L6cjAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFfqY/xSNkDX8YkSyZw4BOeSdcGv64t3dAzz+8Mb1pkVW8tgZ
	TPWrlrWKR0SVfDVeW7vhezzLoS1nvbWL2qs1yGylxouXG09piyXJgcadzh4xg8bJuRVMH/6aFNe
	dVFBn30spytaLY/269ao/HRedGC7PAM4=
X-Gm-Gg: ASbGncuJHvpLSorxUmuf3deIJv4KmeKOSdfPBl2pNQiSZrDdprTWhHc+a/CXUiUtEoV
	pFyAmw62EgX6WQoQW+ZDTuB064/ukrd7e8RDZhZJ8D9mfQIKMhns5T3WWf7sBJiqTNurv6ceryM
	T1iWcmeBtfHCR19lr9MfLF7AwjRetvdHmU/tFKViELACTLHFcBJV9EYkAfPECN/fEY0/lNNCr64
	6QWKlF7XsV0XK4uGl1rbRqRie7rNNyc/06sksFbTA4BjVADrlcH977qegjgUHq2f/6h9b+FA4O4
	Uv8mCCldDNxpcooy7g==
X-Google-Smtp-Source: AGHT+IGi+EK7jmVM3fBQOR5lG3p0ZTX5BLAC4TwPf9ia+SY4+ie0fgyFcvb1NjwLS80NIvosDD5TOEpY9arGzvvmcpA=
X-Received: by 2002:a05:690c:d93:b0:787:fec5:7072 with SMTP id
 00721157ae682-788136e4a20mr24513187b3.57.1762959270077; Wed, 12 Nov 2025
 06:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112031631.2315651-1-kartikey406@gmail.com>
 <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com> <aRRPvn4DYAhuGtq3@localhost.localdomain>
 <6a63dbb8-58f7-4511-8090-18a58c3206d8@kernel.org> <aRR2AV7_R20i4qi8@localhost.localdomain>
 <CADhLXY6keq6+0NY_=xiugguHNFGpFGc07ePWbiTTFU3qO534rg@mail.gmail.com>
In-Reply-To: <CADhLXY6keq6+0NY_=xiugguHNFGpFGc07ePWbiTTFU3qO534rg@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 12 Nov 2025 20:24:18 +0530
X-Gm-Features: AWmQ_bn-PDgYdvD5rofMqW1rSZWchWejM-yP2xGtKnv7KqOlVNyGvEzFiahTHr4
Message-ID: <CADhLXY5Hr-w07b+8Ji-ByfC1WbmAd+2UQHHWqdAEVeYr=FTrBQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
To: Oscar Salvador <osalvador@suse.de>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

v2 sent: https://lore.kernel.org/all/20251112145034.2320452-1-kartikey406@gmail.com/T/

Changes in v2: -
 - Used folio_zero_user() as suggested by Oscar and David -
 - Added folio_mark_uptodate() -
 - Added proper hugetlb_fault_mutex locking

Thanks for the reviews!

