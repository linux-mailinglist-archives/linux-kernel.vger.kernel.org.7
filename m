Return-Path: <linux-kernel+bounces-827935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C836FB937AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835873A8347
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986E2F1FD3;
	Mon, 22 Sep 2025 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy8Cy55T"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1027876A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579832; cv=none; b=TYTLHndOB/1kOli4ZPprMDZqu6aqgnkFBr5IWRx/2GOHYQilDaF7nN6uUJMTFROQFT9KgmwOO6ttlGKCuzzdD6nyb4bBAEnpo5WZmHUVItlWOhC8HkI4dvUYshoW/0v7stlr2ecMtq5raT6Y6pCqLXbhf1se5ZycVGdA4JJbTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579832; c=relaxed/simple;
	bh=Sxgi+qzzqkTw3Plt5ecLA21mEANLQWQfDdkvQU9u55o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZqF7p9v7C/QHc+hpUmqlWHILfKd9ep7gJznadZOOiGpCk/fYAXk9pKNLQJIqRFEoq7qbaC4UQDvi8pYTVC7tEAjHmEt0F2rRB6mSCCKMKL02rTqFcjBu2HxFzFO+XlGdPQAJl7q75jtNXZAHMU/iHiS988RwV5XXZ+zeeJOLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy8Cy55T; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2680cf68265so36644725ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758579830; x=1759184630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRsFo/EuRH2UoqiV9syGz1Dqlotoo0X01FdBzIc3c+E=;
        b=Xy8Cy55T8c4uGVKoNiPCsJBzJVGGJx7JY05Bsuf4yajr48ORgpH50OELV02eCt7tXa
         tSKvdIImAaqzKpXE5IReM4iElZuNLRLkrnTNcoUZHQEq+F+Hi+Qy+jH15NEtTzQOjJPQ
         RyC0ZBA7MBZPEX7KjWF4uIJ/ad4TLLStV3F27F6Umg6JH3SIS94NRKfneae/2dgKg4Fy
         jK92DAohVolsA/JUxQsA6TjbGqqT7HhxGKS0gb62yxR7NuJuSgiqPHsqUfkR8hiyBSz5
         0pzW76TmwtaAaxwiqf+foB2o5LCHNIzGvLyguxZ6wlSc1XkUykMGgGTnHt36B0r0jM64
         H2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579830; x=1759184630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRsFo/EuRH2UoqiV9syGz1Dqlotoo0X01FdBzIc3c+E=;
        b=qcJCGZcbcIsWx/b6rUz141d2fIvreM0nNnFLvrFgnyhhzc/QgRyOesycRWqYYMMlWn
         heJhqgXuy7owyhxvk47JEubfQzktK09iQHoK/1RYXr2iLjSO5yxhNocRYDCTxOH0QpuY
         BV45w1GNbWU0Rbe1kz0/wXvWKTo/5WTpG3qoN62vpdM2Pmm/SK1wZBOx9s6XTpNkO1la
         IRi45gfTiZgDyelcymetfUFzFzH0Yy/DogYXO+VbsQrLdPKq5ZlFWLhFNhiMbRlpnRHH
         31nBTlU0mfxO5+2nIZQ9EeeGu3kNToBzdFPu7um6x8CyGC8Afgjt2XfdfK6h/U+ntPeg
         Jsbg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ILaLrBpJS70d2nHgrqznCSsgENO4jMk36X7ksIucOh/Z1U/8kUxyQXGUsbWiDd4EDFdX+HpRyJw7pfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwS1ke0AgQO8/ZaJZpa/Bzn1990LLwYmuQbip3N425cBvAtcJ
	FVQcONWpfRDR5DSusrauS/SSRAbnS0RQdK/txf5XIP0h7InMHtlhkN9y
X-Gm-Gg: ASbGncvNPaUANcvlDelOORejnybcHCPtGnRoOYe/WJnpC6Z2ECQG7LRJGnpRAmXeyVs
	lunsdOwRTvBogq9TsvbKROOgfGuCJf0HNWFbHyUhD6vAxbhuE0xZ3wlJVeSxrMocg3cdom7ANNY
	briSkjAiubydyQLblrcD/F3KXYoGOR35H5Y1c4PNqFifG+Th2ZynuxX3mFL+VX8qX4cwFUTCgJW
	9IMnAZ64vGIiWDKrS6fNlNU1pPVziZUWIDgnMx0BMEmZwQcYbaeCx/jk0+NqhEANkPt/mL64DqH
	zHm84XW6thuVhvLJo9woFg7eQqXOaIiFCoB24BRene2EzNPoR92KvluHdejLQVzN4rP6LnJYiTp
	c61aiVHvNiBUjf5eJFcZSmTBMG5JRJGwHayiaRwAP
X-Google-Smtp-Source: AGHT+IE8ZDXe+4AoRHXjewJQ1kqq5SzJmZMgTWVHsKxdYcEj7QnvITb3KlBf7Gm4ryAb+XA979ghqQ==
X-Received: by 2002:a17:902:ecc4:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-27cc09e3ff4mr5390975ad.6.1758579830332;
        Mon, 22 Sep 2025 15:23:50 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm141736545ad.90.2025.09.22.15.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:23:49 -0700 (PDT)
Message-ID: <8beb54ba-4b88-43db-8e12-7a7f85c9a9da@gmail.com>
Date: Tue, 23 Sep 2025 05:23:45 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: process: Arbitrarily bump kernel major
 version number
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Dante Strock <dantestrock@hotmail.com>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20250922074219.26241-1-bagasdotme@gmail.com>
 <87h5wu8x7o.fsf@trenco.lwn.net>
 <ff092ff5-8ee1-4e91-b7f7-e5beb1d6d759@gmail.com>
 <87cy7i8tsj.fsf@trenco.lwn.net>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87cy7i8tsj.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 21:07, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> So it is slated for 6.19 then?
> 
> If it's not in docs-next (or some other subsystem tree) now then yes, it
> will wait another cycle.  We are at -rc7, after all.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

