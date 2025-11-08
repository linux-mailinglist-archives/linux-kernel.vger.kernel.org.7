Return-Path: <linux-kernel+bounces-891576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF27C42FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7951188DA37
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989B23AB90;
	Sat,  8 Nov 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwpzuUfx"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6F238C16
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617828; cv=none; b=h1wLnHQdiqDqsXNsbTt2rlj4Hz2wdOISvUErSifj7nCtOzrrZosyvBH0El9GnIUENIv+tq5rqhs/vVVJ+0orGFDikS21eFRyuUZuKEC4mVgZaRLH4IO1UUQQsKWGxuIAPM0s+qWeDYw18QAgL/1xrqlNEHGsPXppv655l9uJDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617828; c=relaxed/simple;
	bh=3Ybn5iXrkjkYhMWK9VcbyAZU3uy2DNNzj4Lp89kHrfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7JHsgvJvdDd3DAZcTpwCiGP79ADL/gQX0deoEjW++J1IpS6uyL9vYDTyYY5XY4FUXevzyGUSPr1KBpPLR6Ru2kBO+jr+SmdMmVNccA2mxjNda0K6EUfkHfPgleB4jj7Z1hE65mH7ZY9Z//hlRJzIRFjf0tXdn3LTo9rAJIh8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwpzuUfx; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1443442b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617826; x=1763222626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuVjvWt5pWlBdwB9kStq+sIEfsEspJe0fkwfw20IDZE=;
        b=VwpzuUfxcRugH/W+wvcMCIICA5lILiqpdgk5i4fk5c751ChsMHFsXuQK1qEkhmyHPE
         6etZKzdEWecr9cId50OKYwc+H/tGb6qP7CPRJmIda7RjdPLo1nGqas9oBSDPekflpALz
         amE0e9aPGl6hu19KuwItaOqoi37/fwsougN1SvFLLYxAPUulBcfRd8SmIgVMRJud9qSJ
         FKuZhC6/TQSeijwX1Dh1GwEuzyZgzuLonBL8rQ9VMdy3rZGNUM3pMxY7SV4sm5+tuESS
         HtM8eorJ8WvySDYz3twYL4M49fidkvcaIcWnQgxh04WBu9zpeH1yS3wv4CSGXffaQwk7
         35OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617826; x=1763222626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuVjvWt5pWlBdwB9kStq+sIEfsEspJe0fkwfw20IDZE=;
        b=SgCHHQcCCuFG8H4WOauQzvLo5Q8gF9vMCAqJEsj5XqT+P6Ua8jjWDOBJU6QAOmD8O3
         PGYKWAFSTzHKES20DPIIm6a1+qg7pdew4PdPLeIs1L6Y+iBIqXuaY73LLEk9lBLp3yLu
         6v/cj/6LE0H2smYCVUv7Zlp7A9WxrecY9AH/qGEn9d++Kg/jZ6u6OBu712V3QuPwbG2D
         tq4x2K1ItczzNJyngwObX4u3nZZXaTfd3SQ6VmQfYS5VcLUyJqryUkvcgksrkQAh4g3U
         wX+PWr0T8NZEqxdRvn1R8+GurEErIPJDJagkWY/VnUWCtDaVvz5JLY87dHVpTXuMC6/t
         2AiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfB/ko7bozhEEF/9UxKqEGQUwzUhJiXps+Nqm3RuH8+DTRcJHR5lZjoKRhLZm70ZUfBMhGxzPug9jLuNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSeFRU4Un244s7Bd6TNZU+XnmbQdKBBqggmy9hxCJ7/SvPZ1w
	jTdfkm8Dyz7aExGm4GtXPj8czb/9F3gfAlYuskKIu1Ovcu+cwnAKuiR8pPh57pd1
X-Gm-Gg: ASbGncvqEsgB2FiUaDJTTbbR5KDqgKzxblAtrftSWqDS7myB45cBFSrZU/jkknXbLsx
	kRMfZAuTmi3zE18A6hw7DNuvrnncEzXqa9mLMbFlyhZhfVtcmP5+9MQEnFMJDh2yViztcH4gzjt
	uI7pQy4sf91Q+fcg8AFM58E7vNXULVK0eBT41yW7MCycBmIxNzT8DjCxORCQk2QQsYyFA3NfkvY
	M7IxWKGHLmZdY475q4KQ2VRXZmExCyAslIyhq6jZl64j6q8+OtczYcvYqam/EiSE7EGNdhsgH8k
	4uswOYPdf1ji99ROstZZJqI4QJmObrYYp/MsOC4jyUfrjQyn/8ugfrkrrdUNM/CcB7jawQxdbsX
	uNlJ8n20WmRD1VgUVZX/Gh7btrV88IGbDpeXlvbLldg9nB5a3pSEHBizBvAe2KcZbanxsGXy55D
	7mW4iOA/00vxjiZL2xQTgyJjVpRLCPihqB2ep33DUU
X-Google-Smtp-Source: AGHT+IEE4oksO9LbHCgRQRuTc/gmfnr3f8yjUh+jBjYO6mFyInWa/Uxiu+FDx81kzpxEEQ/Iw2vrsg==
X-Received: by 2002:a17:903:4b2b:b0:295:6427:87d4 with SMTP id d9443c01a7336-297e56cbe33mr33577915ad.50.1762617826483;
        Sat, 08 Nov 2025 08:03:46 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8f4sm93174305ad.10.2025.11.08.08.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:03:46 -0800 (PST)
Date: Sat, 8 Nov 2025 21:33:38 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <aQ9p2srpUtRG4Ltp@fedora>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
 <aQyOZ6eYng-IjxS_@fedora>
 <6e07949b-d86f-46d8-a68c-9717cfb26084@kernel.org>
 <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107160855.58891ac6df6854a3b608185f@linux-foundation.org>

On Fri, Nov 07, 2025 at 04:08:55PM -0800, Andrew Morton wrote:
> 
> 	void *addr2 = addr + c.dest_alignment;
> 	if (addr2 < addr)
> 		...
>
Hi Andrew,
i have tried this and clang is raising no warning.
I will send v2 patch with this changes.

Thanks
-- Ankit

