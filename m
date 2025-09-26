Return-Path: <linux-kernel+bounces-834475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF36BA4C52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58314563F37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF030C63C;
	Fri, 26 Sep 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx6kZlxM"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC18635C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907537; cv=none; b=qXDyMj3MiSUgwQyw6sqqEjDpLk04QMd7UZsDcRdRA8DOzFLGq2JLhQaD9AnQVy6tfmlmJ4nzPNLodYiQApNp5j3vhASPGsodMK8Clt/lcVP9YcIyOm+1a5CTFEgFOkPJ5yvssu1OlH0dV6XJ4Jm4qtbiNY45XEFa+0GJFcqk3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907537; c=relaxed/simple;
	bh=n/TwT8/XTJv3+QJo7ooua4XDm7RZIoxOK8tjOIXY3Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUqvMOCEJ1NUM0vLxZpnsVQ2bYbUQ3kQuWhrJdiN2F9W0mF45WrC3yZM3aRsP1KUucEgcB1LLlieE8LJmZalOkDwlw0syjYeMzkn54ZUK2U+fXG+FCQYK0ZPV/0vE9dA4ukgSlecSyqXj902ySU7j3+LouhvpFubI4870EbxtuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx6kZlxM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60504bf8so28231737b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758907534; x=1759512334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl7XQK783n2BcTfMcJVdy8g77YXkosVIIL/ZsHMQncs=;
        b=Mx6kZlxM0y+LQ6rKMcZ49hjgaoheEORP78hjdTTq8rzNIvu8JIW7HL6fbZqHRfm+m1
         /fw0d1sUugU9IJtFzdBuG0QdYRaDXxMZgvjlQKGS5N3tMJYItY2wqlF3a92TK78nXrlx
         02rfKfcz3Sj14AAoZs+JdhxA1LZFky2cbAzIXiTVXfXaigj+qeWTJnthvp25/3yiz5Zw
         gMBGdpwcE6fw+IIX+NDYL40pjZqLuHIO6GkRXoC4kaCgc903itfV6RvIo2R4Fo4kAGvz
         LWg+mQCCjyaJtlNxb/vT6d8vfeBifBjkajqx34JQKPUGlqS+6w4x4uQ1wZMv1WmNy7ws
         s0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758907534; x=1759512334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl7XQK783n2BcTfMcJVdy8g77YXkosVIIL/ZsHMQncs=;
        b=F7coJRd3HuO6jlYdM2sKEvMJtI1riqoyK/YKwJwYyrbh7PPLeJ0jQoACq3dDae/snl
         /oG0IoqH/LgbKZp4aWPdCP3QQSQf1nKtNLELyCrkbh6RW22OCrEkQTMD7CmmlNlti+BJ
         sU4BhqRO3MyV41+d0JFu1qkLSOQAt/OmH1Hicx4JwAP79DCGLqmYNCxNDXfr/jsn1YjW
         qUKk8H88ZMDaR86NAj5eZBw5KHN3bi8MfPVQ/i/mc/2d8XUC7z5bxBBU1FmhwBeROiV8
         fX2GZmoKPs5Mrecy5AGQqQaGoIGjjIJaK1p1l6LjW7W9uQdVB32Q09I3nV2sazm2vl8h
         WAqw==
X-Forwarded-Encrypted: i=1; AJvYcCWqbICzHO5SjciC4tLQtOKTHJ5yU4MOuHLj9dTBjBsKaYr017A/JcS/mNb/nQJ7JmJcSsWlaN6SqYiTsr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcHAkxivnNT6mYY7yiQJLXr3OAv8LeWKlbZjyQsWd1/OXortFL
	gbId9ZspwTOgWB8BdZPw00veSTt4o8NKbNj0U3zvPpd5AmRwmTHjhU1M
X-Gm-Gg: ASbGncsCtrl86Zz3ojIctBnPA1uxGoeYtda6tGCjYmQ7LsZk+gzOGRdQg4vY6AHCheZ
	7lW8G8FE04vW/hFN4lHZ9X+2YFpv2nIV2O12xmTXuMAKBDqbTLoSeHAsr4Lvvw6ZnDrXlxlKJSe
	1mdoUMK/EoWDtS1o/ML6Ac+za3gFakB2SJLWrMWnuyJxKUCNOLjhaxPN7RQLjYs1rQ4+uou23pA
	AvEoTAk6tMG4Q3PbjaIkbyBRYzuY3swjkYcpfckxhPFsogZiDzEWF8cGZohlC9zTVJC9mC3Cm/G
	voxtnGgevtHjIUmh0Xse2onfsXmdSdnBsTLvo4LM5K8G/qd0FS0vPw/x/PJw4cQlAzwjal2n+Db
	nyM/Dc8Ic4l1AO+D83cRnaHlS4JYWFuvJA7gtsxlTKRFqImHLNyQ4SPAzBkt1OikurArERMiP/Q
	U=
X-Google-Smtp-Source: AGHT+IHjp8E5q+W3TQ5BUUuAX6KWZ1EN9m5INfrKtRDUuKplaLUfJoIX/Wbu6d/Mpiu6liYDBvjLDA==
X-Received: by 2002:a05:690c:6483:b0:76a:b1ef:25ad with SMTP id 00721157ae682-76ab1ef3bbcmr55310947b3.7.1758907534254;
        Fri, 26 Sep 2025 10:25:34 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765be47f614sm12246157b3.28.2025.09.26.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:25:33 -0700 (PDT)
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
Date: Fri, 26 Sep 2025 10:25:16 -0700
Message-ID: <20250926172532.2814977-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <567be36f-d4ef-e5bc-e11c-3718272d3dfe@gentwo.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Sep 2025 09:21:29 -0700 (PDT) "Christoph Lameter (Ampere)" <cl@gentwo.org> wrote:

> On Thu, 25 Sep 2025, Joshua Hahn wrote:
> 
> > > So we need an explanation as to why there is such high contention on the
> > > lock first before changing the logic here.
> > >
> > > The current logic seems to be designed to prevent the lock contention you
> > > are seeing.
> >
> > This is true, but my concern was mostly with the value that is being used
> > for the batching (2048 seems too high). But as I explain below, it seems
> > like the min(2048, count) operation is a no-op anyways, since it is never
> > called with count > 1000 (at least from the benchmarks that I was running,
> > on my machine).
> 

Hello Christoph, thank you for your feedback!

> The problem is that you likely increase zone lock contention with a
> reduced batch size.

I see, so is the suggestion here that by reducing batch size, we
increase zone lock contention because we are bouncing more often and
having to spend more contending on the zone lock?

> Actually that there is a lock in the pcp structure is weird and causes
> cacheline bouncing on such hot paths. Access should be only from the cpu
> that owns this structure. Remote cleaning (if needed) can be triggered via
> IPIs.
> 
> This is the way it used to be and the way it was tested for high core
> counts years ago.
> 
> You seem to run 176 cores here so its similar to what we tested way back
> when. If all cores are accessing the pcp structure then you have
> significant cacheline bouncing. Removing the lock and going back to the
> IPI solution would likely remove the problem.
> 
> The cachelines of the allocator per cpu structures are usually very hot
> and should only be touched in rare circumstances from other cpus.
> 
> Having a loop over all processors accessing all the hot percpus structurs
> is likely causing significant performance issues and therefore the issues
> that you are seeing here.

So just to be explicit about this -- in my last response, I noted that
drain_zone_pages really isn't a hot path. In fact, it's never called
with count > 1000. The real offenders are in the last 2 patches of this
series (decay_pcp_high and free_frozen_page_commit), and I believe these
callers don't have the same problem of iterating over the CPUs.
free_frozen_page_commit only iterates through the zones
(from free_unref_folios), so I don't think it has the same cacheline
bouncing issue as drain_pages_zone.

So perhaps drain_pages_zone is a good candidate to leave the batching
size as is, i.e. pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX. What do you
think? Again, happy to remove this patch from the series as all of the
proposed performance gains and lock contention reduction on the cover
letter come from the last 2 patches of this series.

Thank you again for your thoughtful response, have a great day!
Joshua

