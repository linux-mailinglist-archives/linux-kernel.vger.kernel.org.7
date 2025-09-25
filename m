Return-Path: <linux-kernel+bounces-833038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13819BA10F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C463B6C0680
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1931B122;
	Thu, 25 Sep 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVZD43Z0"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D031AF24
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825891; cv=none; b=IeRCuSjPopRynGoXR5ImbwGF+bDA+fwQCaxxKrIAMgMlPjgzQCnKyMOeRZJJn5t7xB/mQyUs7pPAtunn/iIQKYURHlmuguLLaTjz1WUtKFYcNKqxTLvCd6yVuWzHj0rg1zWqKpbby8JTUNaA58s0QPFw5VHuQ6kP8qF3Ryv0aG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825891; c=relaxed/simple;
	bh=bZWTYYiAQPIlB4JW1UgT7qgXpOkz+PgSrQVaL+yemDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTMaSLaN/l7AwpOWUdXv94d539n9h+EeriVgLrMqYE8mfX0Y5gr318T7a5U0j6j0T4yC5nrLd7evaw0xfzFov6jUCdpzmV03w/2/w9QBw9KbONFR9S3mD0Jdfdo8rj7UZT00M7kS/W1jqPRDr1pODLUCn1xihJ5c4T/uFjxYgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVZD43Z0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-723ad237d1eso16091987b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825889; x=1759430689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pd8ejEjzronLUI3XRPYabqh93pMkqarOd/GpoVCbhA=;
        b=XVZD43Z0osY4TXcEy+ilBW4yRFOzuNJ+LyZO9N/KWNJ3dww+dNcTjqFEoe6gRNJ/Jp
         9KMQA/bBPwDGlm+Lb1sl0b0uZZmxYX+ioFDXcfh2XbHx8ZG6CvaWQZkvcFUjB638BvIc
         j6UEvsMIrKZu8HSZaRwH6FsKbuqR+4hwK4JKvvYSQ5PHELE1UVDfqJvZBSefcmHbEq5N
         5e+pcT/XvBa3VwQfuffNwUfXgWqo+ESUMX2Z8T3NlOYiNlByuHaLmTc07xr5xrZD2YEV
         Wd6Xeb4LrvZYDRpnG/u9IB6VOWMxv5vSGcXblFhh/UjL84SIzBXeDErrGkuRq8KJEsSP
         uKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825889; x=1759430689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pd8ejEjzronLUI3XRPYabqh93pMkqarOd/GpoVCbhA=;
        b=Y3OsaRPR6G2C/LJmZClF0TAjPtWmeTJdutzzmY3CWfmPJwUfvyinE4U/2gqzBwxI2B
         MQOQGxOoWbfwGatv2sQ3WkKOPxhqqOwfIWD/jFlotmajY0CG8ecvmsYk2IJeLcbt/lGp
         s9f2gox3yO8KRoK9hjoi4DmyUtxqn5cH/TWlIjmElv79xtb5R0/malXuNs3v6r90/28I
         1rhTTDZScnKBLpj2I/vvHz/0R5deJiEuG4oJoJhTvsbaC81En48uJO5i/Dwh+UeBN3wy
         gdj2T3Eo/SL9BEF7XCHRmIaVFebaE9eg2qad9APKmsH9gSLR9cmu1GvNuX79gC4c3f1U
         ytFg==
X-Forwarded-Encrypted: i=1; AJvYcCVXEBWu5Ri8Ic/k8/9njwuTipTs4MV2iQsIp+eTCY0kri7UzIejobrbElunZ4WlnCzOlZtDNHQGDj2yuqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/Powm9DYBwtC1KHtkXy0i4vGlUX4nv1FITbY+os1By7O+gdG
	2MLffncWHkyyu9VEHKoPI9OVFzo1IAL8IYXuhepcSaWovffhaJLlXHMr
X-Gm-Gg: ASbGnct5yxnrQY4pYqErFG+09PJlbJxFUWMMdfJtNnXIFx8grxI886gSie6BBpBMvk1
	bMzo6t0TKCPe8f1lYutI4+vx9DQc/VMD6QjBNHuBawZXZlEm/pXlXmDKJi01K3IuFYKFPuW5c70
	NN5jz9ZjB7LfdNzgBtbNLGv9ZvLB+Rp0wVA/53RvyLhAkCoWITKH0OLL03TdZ1rlKec3zV4mej7
	0UZGrNonQevYHVkIqyVrzK6A2Os5VhgS0hApLtuiegXQtS9UDXMlBuX/Y1hwqNwYeRCCYdQaNWH
	P/ruMIRGe/jjIiaTYw29Y83vAzP/KooarI6j6g+AUZpnDKWaDwqqnSH1xUkseNjARDZCOBE4VfX
	kQr1EUUOpKKkdVAvaQsskTQNOWPJGKdKccnoAzHdtll84xiKVv8nZKQ==
X-Google-Smtp-Source: AGHT+IHpC9+Ql44BqP4ZDNZQjX7uQnXGh226uiJjuZb7wY6Cim2hKfCptNADi0/jHYRaQLJ4UcldeQ==
X-Received: by 2002:a81:8a07:0:b0:739:7804:8014 with SMTP id 00721157ae682-764069fb3b9mr32273317b3.39.1758825888981;
        Thu, 25 Sep 2025 11:44:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6361e916c8esm807433d50.5.2025.09.25.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:44:48 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Thu, 25 Sep 2025 11:44:46 -0700
Message-ID: <20250925184446.200563-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a84ede7d-60ad-3df9-77ae-cd0dbc545b85@gentwo.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 16:09:47 -0700 (PDT) "Christoph Lameter (Ampere)" <cl@gentwo.org> wrote:

> On Wed, 24 Sep 2025, Joshua Hahn wrote:
> 
> > drain_pages_zone completely drains a zone of its pcp free pages by
> > repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
> > In this loop, it already performs batched calls to ensure that
> > free_pcppages_bulk isn't called to free too many pages at once, and
> > relinquishes & reacquires the lock between each call to prevent
> > lock starvation from other processes. 

Hello Christoph,

Thank you for your thoughtful review. 

> drain_pages_zone() operates on a lock in a percpu area. The lock is
> specific to a cpu and should not be contended in normal operatons unless
> there is significant remote access to the per cpu queues.

When you say "the lock", I imagine you are referring to the pcp lock.
However, there is one more lock that we have to think about, which is the
zone lock which drain_pages_zone-->free_pcppages_bulk locks & frees. Perhaps
I can be more explicit about this goal in the commit message.

Actually, in the original version of this patch [1] the goal was to
relieve the tension in the zone lock, but since it was a nested lock under
the pcp lock, it was required to free both of these in order for the
task to be rescheduled and other processes to come in and grab the zone lock.

So from what I can understand, it seems like there truly is lock contention,
just not on the pcp lock. Please let me know if I have an incorrect
understanding of the code here.

> This seems to be then from __drain_all_pages() running on multiple cpus
> frequently. There is no point in concurrently draining the per cpu pages
> of all processors from multiple remote processors and we have a
> pcpu_drain_mutex to prevent that from happening.

Agreed.

> So we need an explanation as to why there is such high contention on the
> lock first before changing the logic here.
> 
> The current logic seems to be designed to prevent the lock contention you
> are seeing.

This is true, but my concern was mostly with the value that is being used
for the batching (2048 seems too high). But as I explain below, it seems
like the min(2048, count) operation is a no-op anyways, since it is never
called with count > 1000 (at least from the benchmarks that I was running,
on my machine).

To demonstrate where the contention / offenders of trying to free too many
pages at once, I compiled the upstream kernel and made a histogram of
calls to free_pcppages_bulk where count > 1000.
On the left is the value of count passed to the function, and on the right we
have the frequency. This is on a 250G memory, 179G swap, 176 CPU machine,
running a memory intensive task for ~12 minutes.

free_frozen_page_commit
-----------------------
1000-1250| *          (3732)
1250-1500| *          (3329)
1500-1750| *          (3102)
1750-2000| *          (2878)
2000-2250| ********** (28456)

decay_pcp_high
--------------
1000-1250| ********** (837)
1250-1500| ******     (540)
1500-1750| ****       (337)
1750-2000| **         (249)
2000-2250| ******     (547)

So it seems like drain_pages_zone does not even call free_pcppages_bulk with
a high count. In fact, it seems like free_frozen_page_commit is truly the
biggest offender here.

When I was writing this patch, I was doing it for completeness and ensuring
that all callers of free_pcppages_bulk have a limit to how many pages it
can try to free at once.

I am happy to drop this patch from v3, if you feel that it is an inappropriate
change. From what I can see from the above numbers, it doesnt seem like
there will be much impact on performance, anyways (at least on my machine,
with the same benchmark. Perhaps bigger machines or more memory-intensive
benchmarks will request for larger drains?)

Thank you again for your review, and please feel free to correct me on anything
that I may be understanding incorrectly. Have a great day!
Joshua

[1] https://lore.kernel.org/all/20250818185804.21044-1-joshua.hahnjy@gmail.com/

