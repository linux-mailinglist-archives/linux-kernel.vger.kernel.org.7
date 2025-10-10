Return-Path: <linux-kernel+bounces-847677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B72BCB661
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6BAA4F55D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCE237163;
	Fri, 10 Oct 2025 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxBpXPQb"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6F288AD
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061825; cv=none; b=dUUzZMj4B2Hs6Sg63kGD300Qdzt+K91hFdOXISQIzBtqXT13m0qRnAwExaSgrzJiG3nRVKp9MQZJTmKHnpgWCIXU9cuupCln1FPNhHMs5vJiYPc/NB6VjHmbEkn0RDFzkZ6FCjuAKi5BWT83ik49/VXjAAyypR71r+dKxuN5ysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061825; c=relaxed/simple;
	bh=zYsqa3guwWVAVB1C5gyhw93AF5/olsVvy/KECbkUpJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0JIe4dKVTMBWBgbxuKT9lY8u4DRxbT2dhCP8/aPgTD8IYBkZBQ62KZMXGHCxq2SWDbWym4QMhxWYS+s3XvNzZ+/yyRaxkPtl7DgsS/5GmxMLopFApS9+1/7dbWojvzXHq2joIBbJ+bVx8yV02PEj/4Yd+7pX8BU/QdUqReOmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxBpXPQb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so969685a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 19:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760061823; x=1760666623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/zrolnPflEL/cxQ6mOTWr2Yo13vs/nPffcZaQ7JvMU=;
        b=bxBpXPQbP4XYynWR0qWqroDUJYS6jH+7+rBS01RXhcRfrkkGLUM8iSGtLxPN6XbuO2
         2J3CUv+3mbK7CcGA1/T7mfS/4HrpFiY6DOs+XTBxcsyyQJouvlyIBKEWr2C1q2QBcfnY
         /Ska7X8kxj2qsMTgvKMeLbBdNiODTEiRy4JCmTjuLVAur2ZauNRf+1WUA4qSJgkxqcB1
         k6HwIemmGKocVSE8QWpHbj2d6pUITLabXQXUTtyW5jLOwDfg2K4+/XyokUuxSeNvBzCM
         /2/b1SZ1zi65uETtuJ3RPRYtergm3bV7F93B/QxdDzbaUe2R9Jpnc31MxlfiBfiMu/zA
         ccaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760061823; x=1760666623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/zrolnPflEL/cxQ6mOTWr2Yo13vs/nPffcZaQ7JvMU=;
        b=YLdsr/tS1bP2kqp4Mh9wYne/LMbf0TK+r3VDyqlL/X1x3k8GPPNxr4yEgqXlQFInDm
         LVluejONovG4SS1VkKRD0VzXNjHEwWJLMP4y/17B3cuCvQAw/I0dzBROnYVCJ5mWIXMA
         NSGVKzHkX5cO/xs71Y4UWkTBtZ2tmRHVPZUJAZEm3tlse1fsRsyYd7NxoAxsMAdvrzRe
         ++cVd8NZuwByRpXer7Cn/ZK9N0BaWLhtNFXfyqSGR8riCgSrMTarFxP68AXjHKQxzMmm
         VF8It6/9o9CgVI9NsrmyDSj2yOSIJ7yTBuO5e7aUm+i3STtd6tpK3OYg9uHVWKolD69b
         XiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY9AK3C7hQWjNnyAmXvtgoFEpsgRvLUSV+VZaPir/bViSOT0p7X7jrFQvnXj+QBLhZw1hvJfXTmhZAM6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXkEsfBwi4bpOnJzshzdTpStUWqAFLBuUmsFVQDgUOcn1ayE0
	HSHcU1BOpD/+rKUU515sgfRJl7KN/Unxtdj5q1k12TGEoze7TfCZnynhBjQpTIQie9DCP4NUYds
	YdjCNGZEB8wiZLNVtfob/65PfaSt3Ur5/D/YtQGQ=
X-Gm-Gg: ASbGncsuMP1bjfu+J+s0bv0syPGhSiXVreAw6o8eV9FrBMK9QFl/BTofIPZMlSL3Cjv
	5JWyOx5DzzanXqpmpgWeFW1KIFmqH/9hYSsU4GjBm5XdmHO1dbLV9ueuKKS2q0ERnNGpHQVWLtY
	bsh3fEBARrrFr31ERzEG7lxkEmz0iqo4CH5sAZZxV721J7Hh6sl5XfuONLIRYAsOmuuVB2BDQmU
	SlG0M/hCd9I3UEsw7hUNi9VPFyIEXW04n4=
X-Google-Smtp-Source: AGHT+IFEUYwRs/06WdVaUUjfO8hT0w8wh3XXO/RSsrjN9zpFaHGINW0byPHZ6Uz0KFaQhM7z5Rwr8o4nltVV8o5Yy9w=
X-Received: by 2002:a17:902:e787:b0:269:a2bc:799f with SMTP id
 d9443c01a7336-290272b54b6mr109437225ad.29.1760061823154; Thu, 09 Oct 2025
 19:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009155253.14611-1-pilgrimtao@gmail.com> <db87a85d-e433-4daf-97c7-d5156849db0f@acm.org>
 <bb362d12-b942-48f3-8414-e859cebb8862@kernel.org> <8406f13d-d8be-4957-b1ec-6996f19d32e9@acm.org>
In-Reply-To: <8406f13d-d8be-4957-b1ec-6996f19d32e9@acm.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Fri, 10 Oct 2025 10:03:31 +0800
X-Gm-Features: AS18NWA8-QkeJl6faOsweI-nr4XveIcXeAyxDMg1xwqMwXRGapTRjcExMGBBJq4
Message-ID: <CAAWJmAZ5CdqmbJJBptDzE5pgfEghLZ+q9oMqH=L+_-SPu5CB7A@mail.gmail.com>
Subject: Re: [PATCH v2] block/mq-deadline: adjust the timeout period of the per_prio->dispatch
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 7:40=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
>
> On 10/9/25 1:21 PM, Damien Le Moal wrote:
> > There is still something bothering me with this: the request is added t=
o the
> > dispatch list, and *NOT* to the fifo/sort list. So this should be consi=
dered as
> > a scheduling decision in itself, and __dd_dispatch_request() reflects t=
hat as
> > the first thing it does is pick the requests that are in the dispatch l=
ist
> > already. However, __dd_dispatch_request() also has the check:
> >
> >               if (started_after(dd, rq, latest_start))
> >                          return NULL;
> >
> > for requests that are already in the dispatch list. That is what does n=
ot make
> > sense to me. Why ? There is no comment describing this. And I do not un=
derstand
> > why we should bother with any time for requests that are in the dispatc=
h list
> > already. These should be sent to the drive first, always.
> >
> > This patch seems to be fixing a problem that is introduced by the above=
 check.
> > But why this check ? What am I missing here ?
>
> Is my conclusion from the above correct that there is agreement that the
> I/O priority should be ignored for AT HEAD requests and that AT HEAD
> requests should always be dispatched first? If so, how about merging the
> three per I/O priority dispatch lists into a single dispatch list and
> not to call started_after() at all for the dispatch list?

From the current kernel strategy perspective, the dispatch list does
not fundamentally
differ from the fifo/sort list. It essentially treats AT HEAD requests
as higher-priority
requests compared to regular ones, storing them separately in the
dispatch list. When
I/O scheduling is triggered, the kernel's priority consideration
follows this hierarchy:
     (rt/be/idle priorities) > (expired requests in dispatch list)
      > (expired requests in fifo/sort list) > (non-expired requests
in dispatch list)
      > (non-expired requests in fifo/sort list).

I speculate the original design intent addresses scenarios where
requests accumulate
in the dispatch list. The kernel must first scan for expired requests
within the dispatch
list for prioritized processing, while also positioning expired
requests from the fifo/sort
list higher in priority than non-expired requests in the dispatch list.

To merge the three per I/O priority dispatch lists into a single
dispatch list, prerequisite
conditions must be met: ensuring no request backlog occurs in the
dispatch list that
could cause starvation or frequent deadline violations for requests in
the fifo/sort lists.

--=20
Yours,
Kaitao Cheng

