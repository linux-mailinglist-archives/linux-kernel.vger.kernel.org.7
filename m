Return-Path: <linux-kernel+bounces-809675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A916DB5108E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B106C188A881
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47040310782;
	Wed, 10 Sep 2025 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GB+oIiUa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E53101B9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491540; cv=none; b=G6AjxGS/pZWCgJy3iw/tiv+2Sh+/hv8LhT90Jj1S8q68Y+Q1e64kWbZ70xONwf3jH4A6CQmKSYXCqY0tvESPlH9Rf+HEdU4/v3cSWfJOAnfxQVaZSQP1xTPFv77BgPrpUhN8V4SxddIf2dMD9ZlnUgXW/TdL7wlXMDKq2DUaYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491540; c=relaxed/simple;
	bh=qyPmCnCGxSOramXXx5tP3J4r1BBGqAEwvng/Q8csOWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpbLxV6XqkYuTQyx/efD7TR0dgBQkvWGhSaCHMIMmXgrAjBouzwo2B+zcLFqVqzubhQBLoKDzcxtXTk2x/WyC4yZMXRg1/z5Ss6w2DCNKig29SCzvLfLPqkN7bwDlVAGVsxt6HVSZwgo2LXzYM5ayo3BknUExTY5q3S1PFCkrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GB+oIiUa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757491536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q7okfE8N/Cj/cxVYYhlDzMPejqxlMfhSTKL9gD+wIBI=;
	b=GB+oIiUa6udprMz6vh1l3cw6AViQplIcfdBRh4eszV70uFFM2NhbaJzWSFAGBoHeHH7kpP
	FPrDKISbt/f9ScgVzbuehUKoCFJr/izaATCL5fzbBYUq5TlWdNf+47A/2r4iPhlv3RnB0k
	koz6eM0+pWDqO/MWsUwKGf2BE57mGwI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-IAVAB3tjNPCQHE3Ie3u5_A-1; Wed, 10 Sep 2025 04:05:35 -0400
X-MC-Unique: IAVAB3tjNPCQHE3Ie3u5_A-1
X-Mimecast-MFC-AGG-ID: IAVAB3tjNPCQHE3Ie3u5_A_1757491534
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45decfa5b26so9588605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491534; x=1758096334;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7okfE8N/Cj/cxVYYhlDzMPejqxlMfhSTKL9gD+wIBI=;
        b=be2aMqYsof8jxREnSeN7qoJovANiT8v/aavYYtQlkAClslxC80nWOn+GVxbg7HhfvN
         p1l6TzccHzCWb19jDT9M5zgeeLls83cnm7dcWrQK8IX4xyNWzqJo9EGMb7j46behqGPP
         AHAEyZslNTAIn+e9F+IuPQJkoyO8b1EUHg65WaVVvqQx2IpbQOM8kE2yZE1Uv4UfoS94
         aP31C/Ym8oFx3E1SkjhdPytg91MUDNE4KeWnTsuDbs/+9RbQjaR+w83ElXc9h5ZVvzGh
         iDZlm+VA6bdS9/zfkX2yJ9W6kvJhVoMrMkxuoo3+FhfXfw+ob0fQvKPxy19yhZfYONgj
         NPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+r/J30OikjqBqqgc32L2FNdeX+kdzWlm+HJ7CUGjlR9txcyArzFDZ8+tfSXyxiHmbVsq3zj1XQlzysGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2utHm+G7ktIO02Wl/l8uyx3wJxtaT66iu88W+ckU9zPc4jfQ
	DhwrZ4nIwmxQ7jehFwRyqw8uMLy7Kgl7GOLdl6IEh9FBA0/p2QNVXu4IeWi6HLt827/6M5rpW4j
	qvDxsjMAgApXJzKfdw91w5lASbw5TKWR6fY4jdp+T8teS0JMo+Vb8AmMTVaFvsADzPg==
X-Gm-Gg: ASbGncsH7lcQz0qks0H5sFmDCeLP5kdlnKpEKEMPo2Y8YiS4cRp4KzzWkgJHFqEFrj9
	MOcX0+IqPox4N/AGVZB62KMfoxAeTX5LA0mTgewPBtUWnH/VN4Wr8TNGoryuMqIG6+jdVwdlzxP
	VWk7yM/6R3XKaRydbkZd0UNpFyUJKCH7aV789BEfxNr8XrLOuAkulVN6/AENEI5KzBOkwGVqZr6
	KDteyTZMxgaXQtRS6QCMvdmHAyK+/ZlPpx54WzUtTRIlex4TMX9uNdCr2x0GKZYthu6SrtDnOtp
	cu8Rcr5x+/BiEQ893LV1HGa6wzGJ5Qma3k3Rke3LJYrUaI249slmKyKqhO9p5T1nMRX7asGjYxv
	x+z4dAifIjbx8rbhxb9QHm8Aup0zceMNBc03QSeQ4YqgbmUctwJ7qiZqh7vrzKAlj+aY=
X-Received: by 2002:a05:6000:1884:b0:3e7:4719:a054 with SMTP id ffacd0b85a97d-3e74719a711mr7904473f8f.7.1757491534118;
        Wed, 10 Sep 2025 01:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCgDtJldwla+vW4jYusl7xeGy3gWWJkq3a9E5eOUYvmRDk2iXJOXjHFj6oEKlPxtGi0M2hjA==
X-Received: by 2002:a05:6000:1884:b0:3e7:4719:a054 with SMTP id ffacd0b85a97d-3e74719a711mr7904446f8f.7.1757491533586;
        Wed, 10 Sep 2025 01:05:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm6221141f8f.19.2025.09.10.01.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:05:33 -0700 (PDT)
Message-ID: <0b1fb5c2-3d36-4fa4-95b0-02c693933228@redhat.com>
Date: Wed, 10 Sep 2025 10:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rv/ltl_monitor: adapt handle_task_newtask to u64
 clone_flags
To: schuster.simon@siemens-energy.com, Steven Rostedt <rostedt@goodmis.org>,
 Christian Brauner <brauner@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.25 13:36, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> Since commit edd3cb05c00a ("copy_process: pass clone_flags as u64 across
> calltree") the task_newtask trace event exposes clone_flags as u64 to
> its callbacks.
> 
> However, ltl_monitor was not adapted, resulting in a faulty callback.
> This also resulted in an lkp build warning due to
> -Wincompatible-pointer-types.
> 
> Fixes: edd3cb05c00a ("copy_process: pass clone_flags as u64 across calltree")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20250904113334.18822d43@canb.auug.org.au/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509040134.bQVbm7ja-lkp@intel.com/
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> ---
> I did further search for other in-tree users of the task_newtask
> callback, but the trace macros make it a bit harder. Yet, as far as I
> could see, there are none, so this patch hopefully resolves the problem
> for good. The other matches all relate to "tp_btf/task_newtask", which
> seems to be unaffected.
> 
> With this patch, ARCH=S390 allmodconfig -- that originally tripped the
> LKP builds -- now builds without further -Wincompatible-pointer-types
> warnings.
> 
> Sorry for causing this trouble, and thanks to Stephen Rothwell for
> testing/reporting.
> ---

Not a stable commit id I think, so it should be squashed into the 
original one.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


