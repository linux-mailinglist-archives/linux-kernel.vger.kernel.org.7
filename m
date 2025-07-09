Return-Path: <linux-kernel+bounces-724343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183BAFF195
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8106A5C0ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C37241673;
	Wed,  9 Jul 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfKCpSvV"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D923FC66
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088469; cv=none; b=BETNtbO+BVqLLfEPAf+B1z39ihROh6h6dUXK3qfOfFMx+18F4Oap4Rta1ceJe2RrDMpdZ5TXILFUfGzlZCiwZKZ7WnO7x2VtpNcTIIX7tWV+qpHnme3qAHXx5XV0VS5/uauT5GkkGQ0sTyO8WQub/9ohVCC49oxZAejNj7KRGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088469; c=relaxed/simple;
	bh=jPJg/TuVdYwclK0fum3mBzHRqZTZNfNvkIKz5QbY7Ds=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q8ehW7/ewrXhCg+HwUiT8pd8o9EZcIrfm6CIr8DhE8NO1YjxsSUJEzXiVM2bWgqdYlph6GesoGsA34+j6onfyapGpFu5w3+B8U9dhImrbsH1RscLgUo1qpEsBsetzQtkMeealiZmHXP1qu9t4v0JehwNObon1TfWzzlDjbS+g24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfKCpSvV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235e389599fso41765ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752088468; x=1752693268; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpK5NgudgLmDyl/bLIn6ku2XnVFY6MkZpnTTOpDwG8w=;
        b=rfKCpSvVmzQgTGyihH0D6mLcc/ONL9WwoX3vR9BkfDsfhB+8Sl1giCS41IS5h7tyMP
         mBRN3vL1wJthlpbynAfwYhvypvb7ziMTlLoZso8oK2wMgZZFnMfHn2Fc9wpXsioPfMuL
         z9dDSO1nFfWHj8BvvEal2IWW6tN41+XfxgUbISy2wbBOXcEUL2zTP+KENIwSt6lZ6oj9
         TEFLcVP+9UISgAVQb3gE4IkJaU2rdoabUsfHa6lon9xE6ia5QlWZyYoaP/2BjrQig0s4
         2TY0ZlkkhrEljS3kg04Zh5tbbrCgCShYgGw+D0YcI1vZJN8U9JBmonv0xYpVRyxFEeef
         QkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088468; x=1752693268;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpK5NgudgLmDyl/bLIn6ku2XnVFY6MkZpnTTOpDwG8w=;
        b=vD8KlQXlCFKhqsl7gWujErDynLyGjMJxcXRN6yh7d7VBMnWbVvALT3x5l/IKc4BkPL
         Ri3PicXLrg2765mTcdyDwLz27vhTWdskUE5acnX+HORuQoFw8c4bCAbQQH2X8UTe76T/
         DeDur6fCRfTyR2lO2S0sjg7eo19QM5jQSnHWwHpWGqeJwURkbc0rtvcU1wLXd0+3IHrG
         rRBy2kl82SR6cnAOb5nF+5K5kOycP74bvOH+lNO+elqb6zZ3g+auM4V4TgCP4qpiHFNV
         rMHhX8SIc+VjdiYN2HWr/SYHUOfAJkcMZk37lt8qa03YbIUN03xY9wNSzFdw+GpjPXj9
         MBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqqLotW47CgMDR0+j9wtr8IdUXQ2EVxsf9nMHujOp2FzpsGgVvlusJaorWG/XMEsjLv7nz9VPY9tB4bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYHjJaJShV/jpLZPm0Nj7H3Nki18AD37UoSGBTxkaGQAq1lKT
	0uRVmXRKp8dnNhn8SVRGDaZI/DGZoGoUO8uNdoIUJsZLJufVkeJChWJUdtI95sCLLw==
X-Gm-Gg: ASbGnctHWyJcc7xWnOYsk8XG1GUBCCaDjYIB3frY3nAa7jK3izNNviDbwQeOQ6pte6g
	tC7euazbulhqjVpa6k+mi0mIguoCaiy82NHndvYfVDBKxMqzmXr4GusDcI11kvE052DWTiAPx9j
	/3wSYLHAuiRxqaJSPrc35sh7HA5uJwtWhshLrypyTHd6Sb2MmXw3Yv//Ae6xGgQC4e3qDMj3J+b
	Gvlxc89gTgrtUXqE4epbGPr2JSTbIGe1ZdN351S6uJ70X1qXV2/5jNAPqnR2RIHQjIZnZA5K0eW
	DT36jOBAzzMbd00mwx2dexIhHsTH18Y3/cCq++aZVIaoRE22VsuT8di5mLE4nCnMf5uledvrR5B
	wU2I4sJ7AOs9tvSsiM5ljywDrL2KlLU/YB1ttFikpvfHVUByQybQxpxBrstV+FOcTSxI=
X-Google-Smtp-Source: AGHT+IEwXsp/82h6pdf+0D5i1VzTPH+PJP+eteh6xksYZ6jIhbjf+iwMUZpJi+8dMqoIEv5H5TPwhg==
X-Received: by 2002:a17:903:3c6b:b0:235:f18f:291f with SMTP id d9443c01a7336-23de393f81emr373565ad.23.1752088467433;
        Wed, 09 Jul 2025 12:14:27 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:9b48:7637:49f2:2d5a] ([2a00:79e0:2eb0:8:9b48:7637:49f2:2d5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a206sm144729715ad.28.2025.07.09.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:14:26 -0700 (PDT)
Date: Wed, 9 Jul 2025 12:14:25 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
cc: Kent Overstreet <kent.overstreet@linux.dev>, 
    Casey Chen <cachen@purestorage.com>, 
    Andrew Morton <akpm@linux-foundation.org>, surenb@google.com, 
    corbet@lwn.net, dennis@kernel.org, tj@kernel.org, 
    Vlastimil Babka <vbabka@suse.cz>, mhocko@suse.com, jackmanb@google.com, 
    hannes@cmpxchg.org, ziy@nvidia.com, roman.gushchin@linux.dev, 
    harry.yoo@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-doc@vger.kernel.org, yzhong@purestorage.com, 
    Sourav Panda <souravpanda@google.com>
Subject: Re: [PATCH] alloc_tag: add per-NUMA node stats
In-Reply-To: <7a9fc525-7ed5-367c-6504-5ce9ab4520b7@gentwo.org>
Message-ID: <8a7c05f2-671a-7540-40f5-ac8809a2f869@google.com>
References: <20250610233053.973796-1-cachen@purestorage.com> <cvrr3u7n424dhroqi7essjm53kqrqjomatly2b7us4b6rymcox@3ttbatss6ypy> <3c9b5773-83ed-4f13-11a8-fcc162c8c483@google.com> <7a9fc525-7ed5-367c-6504-5ce9ab4520b7@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 8 Jul 2025, Christoph Lameter (Ampere) wrote:

> > Right, per-node memory attribution, or per zone, is very useful.
> 
> I thought that was already possible using cgroups? That way you have the
> numbers for an application which may be much more useful.
> 
> 

Cgroups can tell us the nature of the memory if it's charged, yes.  Memory 
Allocation Profiling, which this patch series extends, however, provides 
much more detailed insight such as the caller that allocated the memory.  
It's been invaluable to identify memory efficiency savings and now, with 
Casey's patch, can be used to identify where NUMA imbalances exist for the 
same callers.

