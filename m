Return-Path: <linux-kernel+bounces-853501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 331BFBDBD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BC13BA8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4A92E7199;
	Tue, 14 Oct 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+sdaSm6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AD188596
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485603; cv=none; b=C5ZxBQSKTzuOVsBkLO+uV+KCRoo1bB4i5s+pdhVf2cvTQBPuh5HbBN9SzpeVqgCCQz9KdjQ5ZpHj2y4WeqRlaIVy8UkNG0Q4aNUtqC/xVC5ZEvoiPunqAK8009QFYFeVdDnfnbSNEMrPEWy0E6mdKq9YD+1NWUQdtroJBxLu7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485603; c=relaxed/simple;
	bh=LYVfye+2jfXWF34eSuJa02pO1di01Vh1l2AkQHnLeTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYExNpbbKQ8FMmJg46eYh1LOPjvxr13h9RGZ2pB04X+0R9Md/I6xtkogv1P/l53dSTRzqddF5dCmqeoLJ7N9zHRE11NQ8qcxLBOgc2Vz4ZgqsgsdK13x7ZpOf2Ce7XHH7whlqlsWQbBcpZbJStYmLTAdvX6t4RX3yPUkVYTDLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+sdaSm6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-79af647cef2so2682236b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760485601; x=1761090401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vakVPAnhG+s33WW+yk2avQxhwmCtmmfNm1U+3y8SU9U=;
        b=M+sdaSm6ikHxiCKxEBWa65a6P8lemsSNKSOMi3m+0ZRisQaZJiyqX/fUsgE0fJGv5D
         wiMJRAwf2vPV8RMQH4oqsDGzlgIlpDrVdDwU7FkdBAJmwcCluNGuSbE7/axF2PYXI8AO
         2mbkqC8p1vd1bG93X4/p4yr9vf/Ohiks7HtjgODatTjWKt4VQffDTCTqQiILRJ+Hb//3
         q+sl3HYekmYEqIC1yPjcDvP/kc0+RydoUjD6NTMDGYHtgzNKnqXZVX96MCOJ+87O0xxf
         hf/CNyQHZIRYGMzpj3iVxsWMdOBr2fhP55RHxhSWVN8rQ6IekB56Jai55Ei47DoDA0cw
         jP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760485601; x=1761090401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vakVPAnhG+s33WW+yk2avQxhwmCtmmfNm1U+3y8SU9U=;
        b=JXzOi2XfrOFNxczf7x2A9Qn57sU79pSKmdxHCGMn6rbyLmJ5Vg/Av0daJnFKA0wbnW
         ESZMdoQ3xLpunwknmu21bDXVRYdnq29m+OT3gKk/rm1NogyGfQ7nKuncQ+DGrrThb+N4
         ssGZSUAQsPYfOoR+0Y8n3ZvzWpC7O6kzrHfb5n8acc5k3rSJ/adUKZBG7xDmvMf0eg+D
         omf2rA/cJMA9Bp5O8YKivEdLXRJjZBOigFZ12CiLBrc7kmKE8TXh9x7nwuhIe9QP6235
         zuoIDqjaSP+gSDdtlQgpFvcJRUp/hSzLHkNQbDL0fH6b+gvT3VibW+OhDiJyRO1Vu47t
         Vs6Q==
X-Gm-Message-State: AOJu0Yw2AlYI/uvMThN9NcwD35exjBHvlvB9sNpcnFa9IFPd6WqvkV85
	+ABaq+iJgYI7OPYa2ScR/V2rja8ZZrVGcIqPdI8LLir0B+eKspFEl+R/
X-Gm-Gg: ASbGnctCTUU3e517gQw5EeiHWE86hh2sCsIHpv7HY1yesEr8L6o5B+uGEupshyWjS5y
	GYya0yLxdSqRI/lqJqhgJCbEuIIpz58kaW6Oir0DR0mwkQYPEpp5cgwwWvhKt0CX3+YyYL6Zxp9
	O02xSG/P/mWgNJTuI65U5A70HT6QuZkvgr708fsUHESSLeUwPdwrSRg42BdvUlJexkdC465d3ek
	6YFK+yNaxXmH7hTdiAFQ+mNeijb2fzK158r+7W+6ng9qArJM2M5gBWO1lBb8zlp0TQ7eSpVykiQ
	fHCK1tKTdkIMryOMoEyIPQVTQfyLk5eNwP7GxaRc/LeCdmUxJtnknVN4r/X+b22zcyEWJNrgPlw
	cB0r64i6OQDOjqVt9DQvqx/5IaJmP/rcfYwpezC7doTzNEkoSpjOSL3ZYQG06lO1xwobOEDieHS
	5eudbIevL4g7cDbW0XIP9BeA==
X-Google-Smtp-Source: AGHT+IECtas5D0AKF7k+YfLgDtLgwNAopAU187v8QEFHEo1/tzXFB8c6NJkc8BI7xOANIs0x94HcQg==
X-Received: by 2002:a17:90b:1d85:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-33b5138e625mr35422665a91.30.1760485600940;
        Tue, 14 Oct 2025 16:46:40 -0700 (PDT)
Received: from [10.130.1.37] ([118.200.221.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df2799esm12802604a12.29.2025.10.14.16.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 16:46:40 -0700 (PDT)
Message-ID: <5137ce36-c3b4-4a0a-83af-e00892feaf43@gmail.com>
Date: Wed, 15 Oct 2025 07:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <aO3T8BGM6djYFyrz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14-Oct-25 12:39 PM, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
>> Some filesystem have non-persistent UUIDs, that can change between
>> mounting, even if the filesystem is not modified. To prevent
>> false-positives when mounting overlayfs with index enabled, use the fsid
>> reported from statfs that is persistent across mounts.
> 
> Please fix btrfs to not change uuids, as that completely defeats the
> point of uuids.

We needed cloned device mount support for an A/B testing
use case, but changing the on-disk UUID defeats the purpose.

Right now, ext4 and Btrfs can mount identical devices,
but XFS can't. How about extending this to the common
VFS layer and adding a parameter to tell apart a cloned
device from the same device accessed through multiple
paths? I haven't looked into the details yet, but I can
dig it further.

