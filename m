Return-Path: <linux-kernel+bounces-888421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A3C3AC58
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6471A4F133C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541D32142A;
	Thu,  6 Nov 2025 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpd9riAB"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAFD316912
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430578; cv=none; b=HtGCPGbnbABjzrhpT04EZ3LtTlDBdNKg+XEHcIu/3oSR5tRUUUj/7V9A1JrIOinT+OvqioPsY8HhK1huTXCspBdYb9XknJBmlIzoMZVTi8A7UDWrpD8nYExgmKYH6Td5Qf15BF3L8YTD+spVVPAFRUjOvl+U8tlXB7go2fZtUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430578; c=relaxed/simple;
	bh=4OKASdibq+nZZqna0+9/1+D9HntGbdAc7VcS0PAJtNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSQ9QuYmpww6G5Xa29UG68zIHcp/NaKnKUOkhodyeTrypwwaEZF9shLCHYkEoXSRAJBoMReUtXtIsyNA70POLo8uxkWvMHRXRl9pqw/j8mR/pjTdBoZKXh8pMR71Fclep2DauDveP1APpQQaj+jda+kbPkjPow1O2U0/d1LUqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpd9riAB; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29568d93e87so8768585ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762430576; x=1763035376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPtGSfOGi/keSSlURDQLQTcDjTM2nCUWyB1gbbtP/wo=;
        b=Cpd9riAB2a42RL1ElR128D1/rKifGtmTS0piEz/pL4YtGQXacgEXBUtFN6UFeqXlVi
         iuskks8k/bF+htjMmENY7+mWVmo1qv5NuDw1FSNyohRUvQzhCHB9pPO8JvXxyHCZqNP2
         gsydaWe8HHnqEMsOqRjHJMzcXRq/47x3J3fJ1EHg5WKa4ZnwULIpSYiohVWNtpsy+KzW
         txpeKN9D+aV5+tQwN9yvfH9s+19vQA0EKKqO8vUypJLgRWA+jhste/UMZ06KiNry3V5g
         IFsBeHwZNNoj7M6nliajrATXQgFnSsS2Of+spxq8rDAaUG7m71F5bTnXfwooxGzSpIKp
         Arzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430576; x=1763035376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPtGSfOGi/keSSlURDQLQTcDjTM2nCUWyB1gbbtP/wo=;
        b=sjmH0dw7FgzV1j5NhD9blRA02QA12N7qRHUL2x5QnlL6kICdPT8GWRvh+1sHnxkf5v
         Nzl83LOrzVDmQimR4TA/ihCbyAMcPeUWM/V8+sNQ0Byou/IjJXy8qIzOw9V5bHwKtBwz
         EMyzok0w7XGvPCfWK10gSIEx4yMrWIS663AVzdSre1lTSBHsgU77mwtHz4H+gUp5CGLf
         t7W99r4+TxrcOJSq4m2I7KA0K/mD7D1Zntjx6HQw1f0p5snQ8bcJQGUdZIAsw4rbv9/x
         RXrSSRrKKkLBf8ik4WAzprSXG4g51xjwYUA+Wc3oG3PExzxYAXzHuEz3oTcwsWlAS8zD
         yctA==
X-Forwarded-Encrypted: i=1; AJvYcCUrAmWqe6D/EBVAUXdzKZqbXx5PSAf1ERYQKui5E7HGHLseskmYF/8YxrknWR9co2KV3r5LPKZagX2vA90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyswQoZf/+5BgCGG3A2n85haFK4hSNIjRRCmCj6nF8PivbiL8Y4
	KG73aeMbrKIjZZfUPjqg+4giXYt1rQLtX1w6RMSFs5hhMHvhXNJ0gT/7
X-Gm-Gg: ASbGncth/+u9qKOFgPmj1sez/IgtTXhAQ5RICY0JDJBgjN1jw4OgESUGcdSXg+q9us7
	RIbf3FMUTZbGRQNG9L65SIGDkw9zHAqhb92cvIADuo3UtwrwiB9A4rTtDnykcUYk8ERnKy/KQfl
	d8QFlO8RjjZQdrBJaXWteYnCqECMlwPA4JJpU1a+JDfzlMR3s0g88l6T66cF3BU5a9siD2ZGdjh
	MFiCzTRZO/dP6bkgCUf/p36Y5rCGLRwl9Mot68KTqu9xZSECfidU3tuZZOWZOD1/Mhs8Sc3K4cN
	v9xxdK5tlMuigZ9vGtsFRcKdMwHVVK+cwSD6WHYNU21PMekisTKHcpH0c17oBcPwZKpwqcPg+tt
	F/UJdPpB+vbQ8NQSjsGg2sWT2L7YDPGCES/RHQBZDxz7cTXqN+jG7OTFWQebXH7qtLgQwVhmQlD
	AZZDyK726y85VhnKKDTteFnKMD/uoVWg==
X-Google-Smtp-Source: AGHT+IFg4ppP6vi/pJwmzK9YEs7d/wlWubuW638khXVc5Pb/3DX1F1asOgyJ4kSWyBkD8lMqiRUGDQ==
X-Received: by 2002:a17:903:287:b0:295:738f:73fe with SMTP id d9443c01a7336-2962ae4fc1emr78620125ad.30.1762430575766;
        Thu, 06 Nov 2025 04:02:55 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af82afbb45sm2582114b3a.65.2025.11.06.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:02:55 -0800 (PST)
Date: Thu, 6 Nov 2025 17:32:47 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <aQyOZ6eYng-IjxS_@fedora>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>

On Thu, Nov 06, 2025 at 12:18:57PM +0100, David Hildenbrand (Red Hat) wrote:
> On 06.11.25 11:49, Ankit Khushwaha wrote:
> > Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
> > triggers following warning:
> > 
> > mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> > false [-Wtautological-compare]
> >   1035 |                 if (addr + c.dest_alignment < addr) {
> >        |                                             ^
> > 
> > typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
> 
> With which compiler are you seeing this?

Hi David,

clang version 20.1.8 (Fedora 20.1.8-4.fc42) raised this warning.

To reproduce:
	make -C tools/testing/selftests/mm CC=clang

Thanks,
-- 
Ankit

