Return-Path: <linux-kernel+bounces-752045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A429B170C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F08758549B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBBB2BE7D9;
	Thu, 31 Jul 2025 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG6b6sgb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAEB236431;
	Thu, 31 Jul 2025 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962936; cv=none; b=Stph/tV+AN9oRdFbukRXzxFBGBF2P5y7rJhlFlo5/HjqaC7gZ/vxoL5efALeUxhH8sd/HvErAtMmdp4q3i7sHsfgmhZD8H4+USAil7v5ubplOuddNKFF8AFbf63o/CW2SllxqIfStfY7SHntkwMpPJkMM1ejBK5b4RmVkSKi5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962936; c=relaxed/simple;
	bh=ipebKhXuaFbN22VY/IL9Mx+5rUkpuKe4KBFjo3bkK6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHOLud+aoSSeoWhiFlXtLDh+2+0iscnH8OnoAd7wH80KxUXOkFtH1h4ccGDAb8JOozfNwVqX2EqW8Z1Jq6OPKLzZwPYD63q6EtDs8YGmjMTOdXecwZPNfGPGgyIKxYuS0D38R2cV7kjcCd6jsT8+n3Zlt3AJCbF8KacYn5WUYK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG6b6sgb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45634205adaso3759105e9.2;
        Thu, 31 Jul 2025 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753962933; x=1754567733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipebKhXuaFbN22VY/IL9Mx+5rUkpuKe4KBFjo3bkK6k=;
        b=KG6b6sgbTbAzCxwNa0AI/UEcFz8pcgjx+39zv8UlrXllIkz2IcaZQyKmGuFFRlXXbN
         8qFMFZIcPNPxyT8+EBK0CwmckpnSBs9xpidA67zsVxAy/tjuh/PWTnS1kpIVvGiRUkWC
         u+KO71cPZAfWa3D41ZoedX8gFsk/CWwWP3DKwqJHEfyMOD+cK3zXBrh89dgu0Qji2oI3
         fRzVYU7Jj4m7rkII6Dsmp0ezFls+cmyS4ZEWCdruLS77Jh4q67EYhG+WStJywCLVqrsl
         kZZpWiKbG22JhICfqhxT+0ko2eL+dGFQMEQ8gDqdn6lmf3LF/pAbyVjGEWXGrLyjCs/A
         BoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962933; x=1754567733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipebKhXuaFbN22VY/IL9Mx+5rUkpuKe4KBFjo3bkK6k=;
        b=PKXjMn1c4d/tDXablGgkc9YFTpRZm/4tPihUerWHFQM6cHPh/dkdj9GfhFIgTJuHOe
         jvBuvkNcsnKzYkTbiYxnBe0DaiN0RtghbbE1N2pUG7YNcMmRciYwUhV8We0m6WTZPVyI
         b9y8StHCRE4bb8s26Gwcx5Ko3PlZ3MwPA+j2jcer3cLSNO5cL74YQ5zYKyjWvkomrCmR
         MbMqBSJdUnl8X5BuL/9hjofWR5udVyeFSbOwCfFN9L56/eqLf0KAJnrRZytg0GfVjKMT
         C4sI47EmbYh+0zR/cUSxOIUyBFQRCeJ2WhA4jbg0yLoNPPNtDcYpUnTOiEUWAikTIr3W
         ltkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB6Zfh++f5KjFbL5RbO/21jJLw/vy6MuJlpiCRJbAlBpQOGKPV8yokNIzl6kvWB/I06Ibj78zDnvOm8QPY@vger.kernel.org, AJvYcCWsvShpXJQ8xR0n1+fh1w54LN9a94+9N173VHBLPbAY0MVY105UROq960+0sm6Qehs6ICF+PJFwTxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XJuzW6MX3c7uAeSrFfH3Z2Al/J22t/U8nvbjtQrj2jgDarPt
	Ertng2LjHr+ctoaUQBl/C6FW85Ntak0FUgat9lvnjtCYNS22tf5UTmDd
X-Gm-Gg: ASbGncsM4phYd9HChHgf1Spznu4G2Bmq6kAysSWFHlfZSKpj+cOeYX43jCyTSFSL5Dl
	CG5vklPBdKFjXGSpFak1Pw2/Ashpj51wkDi0aDmQ+iEsGxvnf3bWqL49i0uaSLJ/cGjtDBsLgFU
	2H1DmuH6gJPnTmAElozOQJVmwHgjH4Km9j1bth6oVdp/vXyr1k7WW0iacD9kGfu4ImU77GdqFZk
	bV7dQKwi63zOzsepmHEnNCUMoZeRFzWfHpRnnzEAEqVfc1ysjJPYgNIDhvnPz8WCgaAhIzMD8Mt
	u78Q+97jAG12mxaYxYPVd+ZllpjOe0BrBzgCGpgrXyn2RbmJjchN+FLx8xZk0SIMNqn0NsHjYUz
	oNex35t3hiviWnJ7Ch49UMJDGXDJT5n2g26fzyNNpRO/VUZ85pSBPY/wDI7RcMuFUSSPAiK7X7H
	18lOLDdg==
X-Google-Smtp-Source: AGHT+IFpJVxtyB0Gn+FN/gaWAyTmnRBEh3acsXFbFuXq96g08UWdRioIiv/+fMwh38/b4ZjhBXOsFw==
X-Received: by 2002:a05:600c:c177:b0:456:cdf:1ecd with SMTP id 5b1f17b1804b1-45892bde5abmr66124935e9.31.1753962933126;
        Thu, 31 Jul 2025 04:55:33 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::4:3f35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f887asm63654145e9.29.2025.07.31.04.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 04:55:32 -0700 (PDT)
Message-ID: <2f73f1d9-ad0c-40db-9697-3070cd52f688@gmail.com>
Date: Thu, 31 Jul 2025 12:55:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] alloc_tag: add per-NUMA node stats
To: Casey Chen <cachen@purestorage.com>, akpm@linux-foundation.org,
 surenb@google.com
Cc: kent.overstreet@linux.dev, corbet@lwn.net, dennis@kernel.org,
 tj@kernel.org, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 yzhong@purestorage.com, souravpanda@google.com, 00107082@163.com,
 pyy@meta.com
References: <20250711002322.1303421-1-cachen@purestorage.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250711002322.1303421-1-cachen@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/07/2025 01:23, Casey Chen wrote:
> This patch adds per-NUMA node breakdown of memory allocation,
> enabling more precise visibility into memory usage patterns across nodes.
> It is particularly valuable in cloud environments,
> where tracking asymmetric memory usage and identifying NUMA imbalances
> down to the allocation caller helps optimize memory efficiency, avoid
> CPU stranding, and improve system responsiveness under memory pressure.
>

Hi Casey,

I was just curious how you used the output from per NUMA allocation profiling
to fix the issues above? (So that we can do that as well :)). We get a lot of
NUMA high level meminfo from /sys/devices/system/node/nodeX/vmstat.
Are there specific allocations that are more of an issue?
Do you monitor these in userspace and use maybe something like numactl/migratepages
to migrate resources to another node?

Thanks!
Usama

