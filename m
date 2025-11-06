Return-Path: <linux-kernel+bounces-887877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D59BFC3948E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6813B4E1DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027572DC335;
	Thu,  6 Nov 2025 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ZfJkLhxI"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4842D46D0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411330; cv=none; b=E5radDxs4DUut7Hzmo1N7FDhgeOpQc2aWrWPq8K4oRU1OH8R0JVnaQjqNiwe8bFyASHwyxS5nadjXZvmvfdRGLeApGm8diOcDKWI2gEcjJI09RtRR+KSj5iuWeofMZdueTgOeCxUt8E5I9yIe5rs6kmliMR+rwXUELAdzYi23mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411330; c=relaxed/simple;
	bh=TL19hVOz4D0kxYhklrn7cfeF0qsMbESAPz4b68jgXaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiboUxmpIhqL+JTBfcJZXmapWVgBbYqVCkSVRYxgDLfk6rqjb1aPUgOa8gDAtQyj9z5y2dStmATxyF8/OXBYbsjqtz7b5ffrBI+ahfZkFQhBvNQwlhbtKXFZ13CtIvCBZV9GxoxQWDuzHKfOqk03cLh64vv8YQKsh37udvs+Sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ZfJkLhxI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2952048eb88so8383495ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762411328; x=1763016128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL19hVOz4D0kxYhklrn7cfeF0qsMbESAPz4b68jgXaw=;
        b=ZfJkLhxIWZBQvF7NMqvJ0p10+yDwCoWueoYNYNJIWmLJeaSNPIszN5JRPlWXWSh+mp
         ekXayQqhi1wv956TtCRUXANceH8lpJG7rA+kuROjny5++Tsyd2ifnmIeGHHlcgFnlAv5
         dMSIiXBAqtuUYD8F8fEVtJGNrPyMopWz6jknkFp+ICmL2LMWKWdJnh4WIWFHZnntKP88
         QUnVxemjzYLVLx0Arl+rrUYtChkGwiCmMsgOMykU6ZKhDvjBP56GXAClOtHK/ZD5vE6i
         UfvvCrveG8V3jqabpA/LWQ7S9lPeh/jNih/My/BM5soct5xJijbLonVGifFCB7ag+bQR
         zW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762411328; x=1763016128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL19hVOz4D0kxYhklrn7cfeF0qsMbESAPz4b68jgXaw=;
        b=H4YPcHWwaBOh5JAx+RiljJ2PNBT7ylqEbUsyAqqkyUrBZ3togeNfp8V/dohDDOwWgg
         OF923T2Km2i0BWwcL1YuMV8zXljMFBAAkSoMsWvgaO5jlkKr3FdFunp17ML8Dd/h8Trn
         tIRpMNYQs2785J+ZjqyeYP9H8BWY4CmaEd9pDJcAY8FdXulTkkf/AKdGTvfuZOrZ5R1i
         0efdcC03KT5a83rOreASsN0C1O8T0DB8KsAlC06AUs8uBC+9xKQ/t+cpbo1uvsmU+vm4
         fX1yW7lyQlka3THNjmBcMfvTrdjK3QHN8iAY7kBYCnJ9y12JTbm6CHiByY3kv2J9OGiY
         oQnw==
X-Forwarded-Encrypted: i=1; AJvYcCUOYW9e80dnK43+ThdQZKlgsw6bfF7IwQAg6pNLWJKOOqpLy7DPgXViAs9LALclT2yelQlzIe+nLWJd1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuuDxhZpv7JSuAMAADCCyd/BbvjSU1t3CqqVlYYdrWM5skETYC
	F8TzNBwA9iK6jf7FqZhJezyxfKaXKQjz1suley9pOMlciUGaUnsgmYzTzS8+3wfCiyE=
X-Gm-Gg: ASbGnct8ExGv4NmO3+WW6FgQtBgbbgjmP6HUIkR+snxcHG8TUDoK1OuubWFJLbbDDzS
	VBg3rxm80m0BLQSGFzg/PMe40FbhfVv+M3nzv1K2XxiwisSM8G9Oa4RShdi5AeijGVCRrvUr24v
	ZTolpyYFnKngq/91vJI1c7AhyWtbrKYjQ3Eqd3BGXpgzfeLJQmEqWIpHSjpYOyi2hxHySAWGvxJ
	X65NzgNNDOsbCR/zuCT8QtsoQwUfbWpH3oMikLSuULPxRX/wV5/aRMa2wEkBGJen9i/EIarV8ST
	xxDdumBdl1Zp5iYSTWJwudVud2wR37BN7ko9pu4GuEIRwHUjQAPPhvbjwqevehUmjNYHs7QOSJl
	iXGPwSfOsrspYqjBzyQ4PO+okEwrVe0j9pw0yPxgHYFO0Upo7q6RRqwFqWqm7c+EfQrqxgfs5ao
	yOPPDRmpJ82qimVQ==
X-Google-Smtp-Source: AGHT+IHUkyt8WCcqdVjY6Gz4mADuanTmzresjnwoIZFRGAhN7gntziMCQomA+rIkuthn7tqcXJO81w==
X-Received: by 2002:a17:902:e5c5:b0:28d:18d3:46ca with SMTP id d9443c01a7336-2962adb62f9mr95573365ad.49.1762411327911;
        Wed, 05 Nov 2025 22:42:07 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccc19asm16080265ad.104.2025.11.05.22.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:42:07 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: inwardvessel@gmail.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Date: Thu,  6 Nov 2025 14:42:00 +0800
Message-ID: <20251106064200.64198-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <c704e7d9-5bc9-43e6-98cf-d28c592b0f3b@gmail.com>
References: <c704e7d9-5bc9-43e6-98cf-d28c592b0f3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On 11/5/25 7:30 PM, Leon Huang Fu wrote:
>> On Thu, Nov 6, 2025 at 9:19 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>
>>> +Yosry, JP
>>>
>>> On Wed, Nov 05, 2025 at 03:49:16PM +0800, Leon Huang Fu wrote:
>>>> On high-core count systems, memory cgroup statistics can become stale
>>>> due to per-CPU caching and deferred aggregation. Monitoring tools and
>>>> management applications sometimes need guaranteed up-to-date statistics
>>>> at specific points in time to make accurate decisions.
>>>
>>> Can you explain a bit more on your environment where you are seeing
>>> stale stats? More specifically, how often the management applications
>>> are reading the memcg stats and if these applications are reading memcg
>>> stats for each nodes of the cgroup tree.
>>>
>>> We force flush all the memcg stats at root level every 2 seconds but it
>>> seems like that is not enough for your case. I am fine with an explicit
>>> way for users to flush the memcg stats. In that way only users who want
>>> to has to pay for the flush cost.
>>>
>>
>> Thanks for the feedback. I encountered this issue while running the LTP
>> memcontrol02 test case [1] on a 256-core server with the 6.6.y kernel on XFS,
>> where it consistently failed.
>>
>> I was aware that Yosry had improved the memory statistics refresh mechanism
>> in "mm: memcg: subtree stats flushing and thresholds" [2], so I attempted to
>> backport that patchset to 6.6.y [3]. However, even on the 6.15.0-061500-generic
>> kernel with those improvements, the test still fails intermittently on XFS.
>>
>
>I'm not against this change, but it might be worth testing on a 6.16 or
>later kernel. There were some changes that could affect your
>measurements. One is that flushing was isolated to individual subsystems
>[0] and the other is that updating stats became lockless [1].
>
>[0]
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/cgroup/rstat.c?h=v6.18-rc4&id=5da3bfa029d6809e192d112f39fca4dbe0137aaf
>[1]
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/cgroup/rstat.c?h=v6.18-rc4&id=36df6e3dbd7e7b074e55fec080012184e2fa3a46

Thanks for the suggestion! I've tested on kernel 6.17.7-061707-generic and
the results show the problem has actually gotten worse compared to
6.15.0-061500-generic.

Test results (100 runs each on the LTP memcontrol02 test scenario):

Kernel 6.15.0-061500-generic:
- Failures: 2/100 runs
- Failure rate: 2%

Kernel 6.17.7-061707-generic:
- Failures: 25/100 runs
- Failure rate: 25%

The increased failure rate with the newer kernel suggests that the lockless
stats updates and subsystem isolation changes, while improving performance,
may have reduced the implicit synchronization that was helping mask the
staleness issue in some cases.

This reinforces the need for an explicit flush mechanism (memory.stat_refresh)
to give users control when they need guaranteed up-to-date statistics.

Thanks,
Leon

