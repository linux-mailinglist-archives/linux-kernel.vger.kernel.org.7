Return-Path: <linux-kernel+bounces-754852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC3B19D87
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F98B177FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E423FC52;
	Mon,  4 Aug 2025 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXzqoOCe"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B52309B9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295731; cv=none; b=NYaNGttSr9JbpJHcDys7QYM1vDU8vPGqx2th68qe7XwK+UoPEsBEvXNRydtSFkZkfoaEkNe613quetuJO9lF5YQSumsuyjXKQpYQyni6iy2OKzt2Ns3wR9uEQuwKNcUW5r+lQF4yMvtT6rQClF4QSq+zLpOtvJOmpgrLKetSHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295731; c=relaxed/simple;
	bh=qjOH88hggY+GFkBoYR9Ti7BNM09KbDAokHwgkZY9CcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r34njhyxfH7G5JTr3E+iY+5q5Q1SCCns+HFTlJNaXpZArlOKy7EA22jcySwyB9GCjdHsIfm+8s6XuLq9ArrKAJvg67rx63iXpUXH3Ql81q50yHEo8DAsq4QkqKUvGUSUqI415vU1gM+tfs/9xkW3BIR/QvX1pzTpM67yNNjmEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXzqoOCe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso182002166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754295728; x=1754900528; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvd7myixX9Tdbc669Fpwy91E6A6uestbIHb9Av6+758=;
        b=eXzqoOCeqDW5b3xjg1/vMrCtsB9Uq1rQLT7DRJyQeQGetYaLFNR9BmlAGgFKcZTJN1
         qYGwqj4f7wimd/iB/msgs74HE5WDWdEayrPDJ2lISZrJ/uaoJoG4hdrqtcIpzjijdsIw
         5AJIs3GnbedPXJPprEX8lmxIcQY1NdBpKoeTZIMFm4yny6gR4PyT1xQ1FuVs9KqdmchK
         KCqNpeApowB902bAZUh+IYR4em9MUYWNtaANaCcEnX06Ad+O6nrPCDmiZ2pPAWSy/WMK
         vcznufRTqU0z/91WfSKHU9W+8nzmGqnr63LDyCMhWBvnh6cHyXhZPtWruuQ9UhhI9ls7
         az4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295728; x=1754900528;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rvd7myixX9Tdbc669Fpwy91E6A6uestbIHb9Av6+758=;
        b=U0YXTy/j4wDOOly9pNVBgz2OZ5Qon7+w/QZjfxDxv2V0Gzk2tsg+2Q36kHd629QNSl
         ZOj0ua2o9HTZzDfdTqI7HlFzpUeCH2JJF35o9qoKhSNvh9JL1+S45/R5SoZeydwEaOs0
         laWbdccF1GrpLoQjkJV6UUH3ur70GjnAy4JKGEDGrajLU+TscDTHF9snX6QQxE814pAp
         biTcGATkmkG6U29TleAJgiWN+vhqfqAweBfM7N7DffFLQPMEPo6w7oiDLC+46F6vgqho
         X0LBaZa1WqR5SHnmAUIT4sUDfaMfFlFlBL3gYNLOTh7eAVgwd5JZhdv6OwW6vceE1y2B
         SQQQ==
X-Gm-Message-State: AOJu0YwBy9/qaXyHrXUQvpBY6yI4NF0nGK+sTrqWm6w2hB8MK0bkNFXo
	Xgdn8uSxJUvnKAl/PptZyQGrOR0GsNzOiNlk4dW/tbaCd3suGUL8SHgO
X-Gm-Gg: ASbGncte+9jEPr6KHR/SdKwaMcZUNFjow5XZp1R/Qkz6cnuTWvh9Z4/tgmUjn425gdP
	cNS35xYKDvweTk8ICniicRRPBtGmOGBsySTr1kcOCYvrokdaLJekrgm77c+ZTnxhpkk4x/jvCI+
	RhVeTzGMMfqlR3KGnVpBIRW88Oi2sQ4BaRCq6x/3oGPlLyFgzh3oSoEfbrNyxIvHjbKx26ZBJOt
	wNs+cW39uGB8c59vQb8QrRXbBedXG3FkQJgmKc5eQdm9eRYTfBUGydlLzthS36M0T6bZG3+riNu
	7qCCK6xAwj9y898863MYM+65jhZLqnV/iiIj6HtXDQIEav9gCyIUPOZnS61ZH9HxQm5CrHPpQwC
	l4dRH8F1EXGOZvvm6cuWu/w==
X-Google-Smtp-Source: AGHT+IFcqDL91bJ8WI7tVnisTnu/P57zfWTIch9YEy24U+3LW57zanCt6Si3JczoGVKBqIAUY63WTA==
X-Received: by 2002:a17:906:e093:b0:af9:414d:9c2 with SMTP id a640c23a62f3a-af9414d0cc1mr806271566b.3.1754295727344;
        Mon, 04 Aug 2025 01:22:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0765f0sm693935266b.28.2025.08.04.01.22.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Aug 2025 01:22:06 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:22:06 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>, Lance Yang <ioworker0@gmail.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 4/4] mm: remove boolean output parameters from
 folio_pte_batch_ext()
Message-ID: <20250804082206.ri5roofvd32kyaya@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250702104926.212243-1-david@redhat.com>
 <20250702104926.212243-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702104926.212243-5-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

Nit in subject.

We have renamed the function to folio_pte_batch_flags().

Not sure it is too late.


-- 
Wei Yang
Help you, Help me

