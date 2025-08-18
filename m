Return-Path: <linux-kernel+bounces-773312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60852B29E24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A9118A015F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393230DECA;
	Mon, 18 Aug 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcL83hkh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8901D5AB7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509806; cv=none; b=GXwZnNqIqvpu12P0jZCL6zYkpN3j4IZ74jypn3dU/jUe6xYEJP3xR9WWELwi+h1vMhjcuTJjaF6fHib1QWRqsZVGOPEwQxJCo4Gvief6yMQsDgJyY7oYfkGGiNTkOC5KEzjyNIjAf7+vEr7kUj7qF+ph2qPze2xjTdbIkbt6PHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509806; c=relaxed/simple;
	bh=JEgcNfmePL4qyYKkR9SyvrheeygS1GbJsltNbl/MIsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDdIMTjjE4ohxbgzz1Q2Wl1sU3Mn/uGiRRTYJKWzJPFeUGKF8MeyCvGmc3QNYuKrdhBVF6S14/YQ1BoVLIQC3K0+Iv70E4ucG/9cvJN+F+A6zcmgyfafuEKkYMkdXJDy7OIeTUhYKZ8QS2jN7P5fRTb4ge17bBwNbRZ60iaOLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcL83hkh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755509803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yiAISqpfIZlY1GxKByb62pOCSdcPs9qo1N30a5HaEHM=;
	b=VcL83hkheL5U6itXnfEnX/6x7bVMT3i+h7Htnb3PAHPHb8ZuTJOn1hwdAqBBjzX0a04MEb
	/riQIOGd6hRm9Hyy/rW/5wkiAH0BGMleygkPXW3YnDhXG4eTMl8raHTSnf41m/fgyQac+e
	fxL4xcS5xYT/Bc099HUKqphkouVS4gk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-DlXilMUhMsuD5P36GDuEQA-1; Mon, 18 Aug 2025 05:36:40 -0400
X-MC-Unique: DlXilMUhMsuD5P36GDuEQA-1
X-Mimecast-MFC-AGG-ID: DlXilMUhMsuD5P36GDuEQA_1755509800
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41c245fso3183138f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509799; x=1756114599;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiAISqpfIZlY1GxKByb62pOCSdcPs9qo1N30a5HaEHM=;
        b=smDw1r0JKGbC3sBQLF7b6/Vvnq+1ISyT5xlOsok8p0Gl3w37CK7oCkdTWN/zGrr8cG
         BkqM027UE1sC2NrK2n/XNO47cPNFWBrBkzsmluZ8OE7QSmKiLcJeRpIgBF/SAzs/Pzq2
         0f6mnv1GjSF9AKg6H4VZDD9BV2BhPMRTiuBnwhLHqPkBUDx8iHqL/IC3keVwXayaYtOK
         IKJ1Cw9AcenqtWBGusQbWEk6mTgi7WtTYBf4G5C9hT07PR7Y1ke8Tbh8CGtbNzciY45u
         D1u/qz6X0UzCqbfoZBv33BiAkQs1odPogiITEEg1thtlDMxpMXKNOBqZk+w3HPbqWDxh
         W6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWJMq7v27odT1NDWz/sR7UNzSJO4g/leySSxpqkaOoltzqBsXTCMFPgJSGb5slTZoSGTtrV2o8plTp/j9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9gjgOPxG49k+azXSrV1FhMymSQmEKD439qkWl/Bw+kbj2cJu
	gO9ACAd5jNTst6ZMAn9kzOZpJQiQvuBhZhpqX5mM1P4TclOWGeItEdcFGcOSTgRRgB52Ey19aDP
	4pu9qdckefzyo8ln/FEhoqRsK/2wgy5STiwRdFwso6cmtkfTt1pCYy7QlQlbsvTYwIA==
X-Gm-Gg: ASbGnctXVr0+WBZNy23kN/pUaGBl60Pg2qh/nF1y5YR7mn3jZ68uReRk9xoGoYLKqVB
	tHEjlrwRbTovPKl16NHrrp5BDCuZkOfrKHRBwLHYlk60y61y4m5le2mO7Y6Co+u3YXVfFeXs0oj
	f/W4MJpAMTnEchbfv0BA3+LtWit+CIzbDvE6ffMT0RZZ5adeshgm7od3+qYuCCsGmAGtcWuCtau
	q7Qq6rYvvGAS3PkwuKCptibZLBrD0cjN1N/sUl+u302h/60klHeb+Kud5x+PWsDgX56rVHe86bU
	7N/Y9Mwr30EvLGiEt3Zl37tD+6ymdXJBQ2wAX24U/2fsMl7hrh1SryQ7itRmnXIJw9cTu+i62as
	YuDXizweZVluGa8vtDXWd6FwEzniKdSpkJyy5e3cPjxBnOxp7iZLbXB/RT9pPhDUD
X-Received: by 2002:a05:6000:25c6:b0:3b9:16e5:bd03 with SMTP id ffacd0b85a97d-3bb66564b3emr7504977f8f.6.1755509799604;
        Mon, 18 Aug 2025 02:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqLyNfJzB6LIHUYAl53Zj1vLQr81v6nLl+WxgYSZjEpwCks8VrRmbHnJYquHeO8D/HsOfDcg==
X-Received: by 2002:a05:6000:25c6:b0:3b9:16e5:bd03 with SMTP id ffacd0b85a97d-3bb66564b3emr7504947f8f.6.1755509799145;
        Mon, 18 Aug 2025 02:36:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22211395sm125025085e9.4.2025.08.18.02.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:36:38 -0700 (PDT)
Message-ID: <a385e09f-f582-4ede-9e60-1d85cee02a3c@redhat.com>
Date: Mon, 18 Aug 2025 11:36:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250815135549.130506-7-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +
> +TEST_F(prctl_thp_disable_completely, fork)
> +{
> +	int ret = 0;
> +	pid_t pid;
> +
> +	/* Make sure prctl changes are carried across fork */
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (!pid)
> +		prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
> +

Skimming over this once more ... this raises two questions

(a) There is nothing to wait for in the child
(b) Does it work when we return in the child from this function?

I think (b) works by design of the kselftest_harness, as this function is
itself executed from a child process.

Regarding (a), it might be cleaner to just

index 77c53a91124f1..1a48bcf2e9160 100644
--- a/tools/testing/selftests/mm/prctl_thp_disable.c
+++ b/tools/testing/selftests/mm/prctl_thp_disable.c
@@ -271,9 +271,11 @@ TEST_F(prctl_thp_disable_except_madvise, fork)
         pid = fork();
         ASSERT_GE(pid, 0);
  
-       if (!pid)
+       if (!pid) {
                 prctl_thp_disable_except_madvise_test(_metadata, self->pmdsize,
                                                       variant->thp_policy);
+               return;
+       }
  
         wait(&ret);
         if (WIFEXITED(ret))



Same probably applies to patch #7. Feel free to send simple fixup patches
that Andrew can squash. No need for a full resend.

-- 
Cheers

David / dhildenb


