Return-Path: <linux-kernel+bounces-751309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CBB16784
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068C4580C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9BA218AC1;
	Wed, 30 Jul 2025 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX33B3U1"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9C61F37C5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906755; cv=none; b=ckEu4JBaqU2i4iS6ZQ1hkmLsE8kLmGkkgkCwOA7QVUmaIogo47GJMt40tCusYjOZOEE1katWRuzuRmIPfOx5heS2T4ayfxyrZSXs2+nn8RYofNT9e4zbCXzmjYMcbUfXbBcZ3DEg3Nj6hJFiY9r+pVEOUs7VSOkTU+9EXNaWIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906755; c=relaxed/simple;
	bh=T4bqAdZyQf0HjbPlWjXEsAkQfBMmQK0W3cFdHuH3X5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoaY6fkRR/p5qF/eqDwfR2GffSdaP2PuYv8XOmhGX/eoBnxPHwHO4P1SX4Ln1XEtqkj7oo6l2nCGp+IePDTHDdpNLN1YNOtNNG1+HQwJ9HNhhxMmi3Zv1M8SDCWkB+1D/pzS0gjsgmWxEpxfpqdzt/vaApgME9F+VlWaBHZJA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX33B3U1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71a39f93879so15063977b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753906752; x=1754511552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVb487mVpeDozrUbu1+omY0eRgyQRi1HrzvWHnKCA5k=;
        b=YX33B3U1Prsc9AMYJ3UZEXnY8E+Oo9a9rbrtkUKvtFisyY81DEEoY2AaB+DWlz2XJd
         cDDy1ARB3p3OTqfktFriAgEg0cX/wCYlJx4AIuE06ylOEFojjcUDjvqNvwfRGe8gOvxa
         QFntAeLaaR2OonSxaAazxLWeHHuMT/zl14OGC185V/YP1I0gLjrPkBKXpAbjU8Cg00x8
         ztzPzIYB03TpdY6yLOi3mZKWl9zoi9XnWoACiGldgLNLAfMmq872efa4MEIwYV8JyQ+8
         7n2IPt4jDUmVVOo8KXequPu3BprcShjsNYo+qtSc3j9l8fy4B8w/e4XqcageHxfjCqUF
         0JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753906752; x=1754511552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVb487mVpeDozrUbu1+omY0eRgyQRi1HrzvWHnKCA5k=;
        b=ajQt0b8SYBomsnlwqx3JWp2XBvzrhAPQaZVh1zEpsGizcID15aC89Ukz2kD92mcnq1
         hOBrFGsoT1h1hCxJN1PimgCkC64ZGXkvGBrBrIn0SM2CsYut65En6sKkujRNcGbF9ktu
         wnsNPLLexFJcvk32rHPTIXnuEB/K8aeFlttc843g5Ec+IV1GhPNDvF2vUq7kwOtjP5ew
         WgexyOdvaAgIn4ni+wA/sxWK0qDm5A+aUW35Tco9laehdUlNy/8GMxLRZbgk2v0CfvP3
         Jek+E3bBKdaWurswPd4UeWdPdfm/NaFv9jFj4w6doOf9lF12PaHApr24T6I4eOExvHNe
         25Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Wb+J7A/WZJ7veWt0Y/pqdLDorkW7+YC0X7duudui0qXzcvjO5/F8fRbN+iZdqptgRKqF4TPyhW2t62U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz98YZlQT6QyKqJc6TV8DUEZ+Y0KVyB1sjMEjCLpDBooHz739Eg
	LDYFTT0Vs4vLXaMRxGcHo7NZasC/9Rkpyz3ZhBuCdDrOrx+v7Qlywbm1
X-Gm-Gg: ASbGncsT4AYA7ThJr3BWvAOCZoYb3K2d/Wv5vuYwNodFjzims/ksxeRgR73CKRdOzdM
	FpU+D7iFb5zUAmKKCBTUy0zRyoF7LZ42DbGDJMqtz9d2QqICgStM/ccBEkgiaxfMwicqutLIDEv
	al3oUgDhqO4ErW++fxDjr1D83S4VWXAZkixJXmVrIRuCJMHBP0hXwki5Lzo2LRQE9ZvyYmjVx/S
	tiyoBFflI2Cy81mrZppsyfzyn3kqSDJcQw2WQkOy4yTx8WNpShgil8Qa/3Ud0LpVPfx+p1RBkoG
	dRN3oDEErtP4wZF+ispXVxTuMQUESuEC3lykEgtgLvcZNMnUMPAiMh23JUN9v17oJrbIPieIgyk
	Piu15IfBd1uic5rsuQkXbBA==
X-Google-Smtp-Source: AGHT+IEVHHeaxLepGJ4XhX4dQRHXkM7amOTdOXWWl0IJq+sKnNdeAJw8Mvta4DaJYaO2o1FBG0kF/w==
X-Received: by 2002:a05:690c:9a84:b0:71a:31cd:1848 with SMTP id 00721157ae682-71a475ca7c2mr54667467b3.14.1753906752217;
        Wed, 30 Jul 2025 13:19:12 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f2154b00sm25841457b3.9.2025.07.30.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:19:11 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
Date: Wed, 30 Jul 2025 13:19:07 -0700
Message-ID: <20250730201908.2395933-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87tt2v24om.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Jul 2025 08:58:49 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Mon, 28 Jul 2025 09:44:06 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> >
> >> Hi, Joshua,
> >> 
> >> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >> 
> >> > The zone_reclaim_mode API controls reclaim behavior when a node runs out of
> >> > memory. Contrary to its user-facing name, it is internally referred to as
> >> > "node_reclaim_mode". This is slightly confusing but there is not much we can
> >> > do given that it has already been exposed to userspace (since at least 2.6).
> >> >
> >> > However, what we can do is to make sure the internal description of what the
> >> > bits inside zone_reclaim_mode aligns with what it does in practice.
> >> > Setting RECLAIM_ZONE does indeed run shrink_inactive_list, but a more holistic
> >> > description would be to explain that zone reclaim modulates whether page
> >> > allocation (and khugepaged collapsing) prefers reclaiming & attempting to
> >> > allocate locally or should fall back to the next node in the zonelist.
> >> >
> >> > Change the description to clarify what zone reclaim entails.
> >> >
> >> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> > ---
> >> >  include/uapi/linux/mempolicy.h | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> >> > index 1f9bb10d1a47..24083809d920 100644
> >> > --- a/include/uapi/linux/mempolicy.h
> >> > +++ b/include/uapi/linux/mempolicy.h
> >> > @@ -69,7 +69,7 @@ enum {
> >> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> >> >   * ABI.  New bits are OK, but existing bits can never change.
> >> >   */
> >> > -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
> >> > +#define RECLAIM_ZONE	(1<<0)	/* Prefer reclaiming & allocating locally */
> >> >  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
> >> >  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
> >> >  
> >> >
> >> > base-commit: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
> >
> > Hi Ying, thanks for your review, as always!
> >
> >> Please consider the document of zone_reclaim_mode in
> >> Documentation/admin-guide/sysctl/vm.rst too.
> >
> > Yes, will do. Along with SJ's comment, I think that the information in the
> > admin-guide should be sufficient enough to explain what these bits do, so
> > I think my patch is not very necessary.
> >
> >> And, IIUC, RECLAIM_ZONE doesn't mean "locally" exactly.  It's legal to
> >> bind to some node other than "local node".
> >
> > You are correct, it seems you can also reclaim on non-local nodes once you
> > go further down in the zonelist. I think my intent with the new comment was just
> > to indicate a preference to reclaim and allocate on the *current* node, as
> > opposed to falling back to the next node in the zonelist.
> >
> > With that said, I think your comment along with SJ's feedback have gotten me
> > to understand that we proably don't need this change : -) 
> 
> TBH, I think that it's good to make some change to the comments.
> Because IMHO, the original comments are bound to some specific
> implementation details.  Some more general words may be better for the
> user space API description.

Hi Ying, sorry for the late reply.

I think that is a good point. Then maybe in that case, we can take SJ's comment
and leave information about both the implementation detail (i.e. that it will
perform shrink inactive_list on the zone), and that it will prefer this over
allocating on the next node as a general description of what happens?

On that note, one thing that I felt was slightly undercaptured in
Documentation/admin-guide is what "zone reclaim" actually means. What it does
is of course well captured by its name, but it misses the nuance of preferring
reclaim over fallback allocation.

Actually the whole motivation behind all of this conversation is because I saw
zone reclaim preventing allocation into a second node in a 2-NUMA node system
and was a bit confused until I understood what the implication of having
zone reclaim was.

Anyways, I can probably spin the patch to include information about what
zone reclaim is, in the comment block above the bits.

But please feel free to correct me if you feel that the descriptions available
in both the mempolicy.h uapi file or the Documentation/admin-guide is already
enough.

Thanks for the review as always, Ying. Have a great day!
Joshua

> ---
> Best Regards,
> Huang, Ying
> 

Sent using hkml (https://github.com/sjp38/hackermail)

