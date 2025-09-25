Return-Path: <linux-kernel+bounces-833022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ADDBA1006
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81071BC6EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4212314B90;
	Thu, 25 Sep 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaiGAqPN"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D223128C1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824776; cv=none; b=GQ4vkUSOVnMSa25/BmnAauqZbNkQybpd/4DM4dvBLfhOILibHs9+Wgd0c0+rXxdRdKGeZLnN2WvZdFsVOwgY4oLi2vE93uWOhCp9IzvlJ8dN9iemfPfeDVHthdCIkTym54iavPtJxEa8GUKlvoIedHx6Fxm9pTK767gueoheIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824776; c=relaxed/simple;
	bh=/SRe0VQBpLHtMF1xTe+/Ewx12Hj1X8HYfYKjGgTk03U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk7sAl61njW2SCWyKBV3jT+uOYv66DYFH6+wAVt1AVF5rkrDzunHYWm6m7CpE09HzmIEjAFs0eQVu7Nss07QFC4tM1AS9hNfo1JVqOSOqFNo41Nn7qT0v9EQcJAFfVJiNIY/iopUrvkIpwQVqCxLhNoml4IC6kinIl83XsStHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaiGAqPN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d5fe46572so16490697b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824774; x=1759429574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh9nK5ND045N+FL5Ib8gPJReb2Q9R1K2+zjNC4yoXCc=;
        b=YaiGAqPNTx2BIUuc0KFOOG/WEF7KLUmGEexCiCXMitRV2X5L5TK5MZUycc8a8Z1nC8
         YIwQdC7gkrFhL1MOy7q6PBbm6rnhTbb/DYHE/D/EuYUhA6DpHhdcIb7s+7tvA4rdpCIx
         XjDPwxynSF63minfgBfsaLYXh1VasiMw5jXk96fFpMt5VOtXdyuiEkO9Nx0rfIwmN7KN
         GA1J/1l2pMSXv7nC5IYGroduJG8I96E/6PvVyzgXKTJWwyzYgrt3uyF3Z9HBymJqTpLR
         z3BkIFdLgd0Ft4xF7hvvxExnA4OdxUij0MWFn+giEH7m610Ux4bjZFF4skU78hfcB0lJ
         JmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824774; x=1759429574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh9nK5ND045N+FL5Ib8gPJReb2Q9R1K2+zjNC4yoXCc=;
        b=ZdrcOWWUexrUCWTpu72nGOf0FlWoCyt2UeImBnw9PeHVbqWJ0OGNulwkjL6ryZ8gVb
         nfn4ySpqioyWNnNh4wjfZRPpj6/uj7DUpAHLsJ/CLUmVYeuNNbPtTSuafoCeNQaV59f8
         72NRXl6OjPcVoAPXmXsq+Lq9f6O7zpWy8DeeFhYDCZRiKcaslz8g/rrw37jSZsyULTWX
         GB9emB0LORbmgkJJ3irafB/YhwoU1rjJmWtBUiXvd/1nJsyHaRm5rsjUuT50yEz7XcPa
         3tAHVq52ZOhUVAH+44B0gGuv1ReqaH/CouCmJ/spgp7eDHpmNzsYzCGzD2q/jcMn5FC6
         HXUw==
X-Forwarded-Encrypted: i=1; AJvYcCVLZ+rNDKGJohkzFtDx968akuQQxUCQPYf+e8sR7BWNb3rtXmfuCRyvmaOX4Fh08hN5fw0tNLpF9HcTPl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqYEZL9Ak0YIayB+3Dn9wF65OJd5Nf/I8f0pXMD8flPllQuYG
	G6Q+dejM8lFGbphUFdcju3N3u0dMfMXaNHH/UfCXQuIQtu2ONXFR8eTNnjqwmw==
X-Gm-Gg: ASbGnctYAAk/1x0NeD8HFbHjJn8D0O4G+39K8jsQLQoVnuxzIdfwsURzcZleg1iZRxV
	sL3hm+sBF7lij8ladqjMV+Pn4EEJlmpFK2q5sUNB02TNFPjJjMbbCx3GvbxiloUTIXr8xAAvrWm
	1D4Ik+2kNr+lU3D7McvnRZ3+wNddUKouA0xv7rBtS07j3yCqbZcEJqKTXs5DLpIczcv1qONHqvu
	zAa+yzW73VOloJgdA+KO9HFkraIzY5vQm+WqDb9ahGHah7toFmacN5aAR/1NoNmdO6PPtiq8/87
	cMAiQ/OY6WM2P2bjapx4PberfbCoKsQvAQXGFAO1G9LsdyQAa2Vb7P4tky5P4zudPSr+on5/8iq
	KbBoDZg/sDj/kkKeOv55fRKSkwLlQHWK7tcWRRKrYsJZIC21QyX+VvKxQUTpBiuFF
X-Google-Smtp-Source: AGHT+IF0DpIz7DGH5ZqEIt1BcjbnMswoUnU7/ApjqSwRCj4bn3gIocs3R28KhC8dB6+XVJWY1ddxHA==
X-Received: by 2002:a05:690c:3702:b0:73c:7776:ce29 with SMTP id 00721157ae682-76553dd4e1amr32394917b3.10.1758824773525;
        Thu, 25 Sep 2025 11:26:13 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bb916b96sm6608427b3.5.2025.09.25.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:26:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
Date: Thu, 25 Sep 2025 11:26:06 -0700
Message-ID: <20250925182606.114616-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <fdb56260-8235-eb20-05cd-491fd512cec0@gentwo.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 15:51:58 -0700 (PDT) "Christoph Lameter (Ampere)" <cl@gentwo.org> wrote:

> On Wed, 24 Sep 2025, Joshua Hahn wrote:
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d1d037f97c5f..77e7d9a5f149 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2561,10 +2561,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
> >   * Called from the vmstat counter updater to decay the PCP high.
> >   * Return whether there are addition works to do.
> >   */
> > -int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
> > +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
> >  {
> >  	int high_min, to_drain, batch;
> > -	int todo = 0;
> > +	bool todo;
> 
> 	todo = false
> 
> is needed here.

Hello Christoph,

You're absolutely right, thank you for the catch! I'll fix this and send it
out in v3. Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

