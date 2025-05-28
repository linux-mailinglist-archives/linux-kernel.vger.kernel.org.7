Return-Path: <linux-kernel+bounces-665184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3910BAC6540
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 11:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2A07B030E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 09:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A87275868;
	Wed, 28 May 2025 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSHp6lpT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD5275859
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423362; cv=none; b=KS/eOioDBznWG9uDwk9OkrOHJ+N/453fU+Yd6GeeLFkAUlwCTgrYDBjZ04ZBUeAHlDs82oH1s3hfc3iQARBMrRHLnI298we3c3cEqqJ5KlOnqfE8ufQxSRKZIsFAbN1unlJtW8WMYSY5WClHrZETCAOnsnFVmGmlNIg18qg4DNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423362; c=relaxed/simple;
	bh=sg20bLNUz/QFXRFaU70PwpcwAVbsKDYF5KqdTjgKZjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCJ7bQcSuIeeWbKuIsiysc21Gg2ZzKsIIQFWhLG77mYUWYENH+o2fcT19TFtTqun8Q/y90uxWG69MfbxgK/FztSCQzxELI/0fbmiQzxM0fflzZB06uODiR96tSuZfUj+vBu40puCQYOk3e+VJ9lk233Q2j0wMKeUSyd+xWsoYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSHp6lpT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748423358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mEQXyKOYvt2g5cMesLCcww4mgZn3lojWLzf+f6VokPI=;
	b=gSHp6lpT98fEduvUb72p+GDhaDJIbI4UKoOhE4+bJNRgXQYE7GiZNIq41EFB3nFso9+KXV
	XjzRG0vUnJjXL5Ik3vi3XA6CqI96MMDdDWhTChjEqTxZL8BISCb6T4lxR7DFqlhvyWrLBM
	B+7qnyTRZwuvlzkWapJ8XXAChCdHVs0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-_QdmW70PPAS7Ovrufazw5A-1; Wed, 28 May 2025 05:09:15 -0400
X-MC-Unique: _QdmW70PPAS7Ovrufazw5A-1
X-Mimecast-MFC-AGG-ID: _QdmW70PPAS7Ovrufazw5A_1748423355
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a371fb826cso1866047f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 02:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423355; x=1749028155;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEQXyKOYvt2g5cMesLCcww4mgZn3lojWLzf+f6VokPI=;
        b=WBCyYiCNyiOdkd82rs/ZGyKHXGY0eHM9pOx4+qviAFxfgQO899xcCqA4auyawlUGIN
         hURV3g5dVtZvIn+PjYTVcCnA1aiYO0WgvPrROtjWLY1C/9x6whsA3/c9y2mB+MTlsGUS
         cB2VqumuLqKXUs7FX70fkEr7CEWdrukVbZ6w3SJiO0IsSufSYtsKq+sAIoFP/WqvUOMs
         RWQmL15FynXwwW8utm3lM5XRCnpW2l4nANZ60X9ziKaw95CQk5s0htaeZoGswK3C9VAy
         2VjGUaoNkyYIs5t5Hu50ktZYqVei2GTrDr7+2YNVomlocI65kPAXj1fSnZoIOfqCxMgQ
         SRfA==
X-Gm-Message-State: AOJu0Yxc79E02e9PoUyQLY+gMEA0BmWVGTpVeXJ5S2T/Y//Zv/DP8doV
	Ac06Jb0cncYvVv2oHtZha62jXZqtzdKspg6SQrF9PPlR9p5G8fpKXzK7yf3r4rkKUW+idc6iFMk
	KHUtaOT+uSQa0pQlh1GUe448K3GRlTnLXaIJ1sDO1iNLXa8omPePoxq+98DGviVjI/A==
X-Gm-Gg: ASbGncsezQUpUcl+6sb9ylSZJm+tvvqIZojRoJX1FRxsHPcefB2kZGvgi5mGqbOKpIq
	gpcSPYB82NNC5raMY129BNfGuM7kMQk6SUDt9GUrwFpu6MjKztvK4/lS4jVtcxfJ5t4Sq6EAumQ
	dj+EDuqp4HWKegfyg+7QRSN3tan2Sp33BeN+SSxoxSXm27WVASYb/TUts1nlc+46jwDO8to0rMU
	GXB2/x0Id3LwLFFg3WJFPTA9uLKy64lqRovRrIpTvCzHcfAyiPbp+ngBfnTEPtSCfRdXwI6EoRW
	bKTjYDs1asnV9C6y+jXRsBT1flQ45VmoNYAW7m29YuedJtui6XdyaBKxWmrSKZtGCAjq41APyHY
	uLFF/K2NjzuyxW1+kl4ZpCjdohpQjxoQB0X2eYzs=
X-Received: by 2002:a05:6000:400f:b0:3a4:e284:1b87 with SMTP id ffacd0b85a97d-3a4e2841ccbmr3513197f8f.18.1748423354716;
        Wed, 28 May 2025 02:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkD2EIBglWCSiZn4xndJdgWSSjQNyuOFqWDMsi9lfpRG+9nxrnmD06llkP4qkcMkc2YAd7eQ==
X-Received: by 2002:a05:6000:400f:b0:3a4:e284:1b87 with SMTP id ffacd0b85a97d-3a4e2841ccbmr3513164f8f.18.1748423354262;
        Wed, 28 May 2025 02:09:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36? (p200300d82f30ec008f7e58a4ebf06a36.dip0.t-ipconnect.de. [2003:d8:2f30:ec00:8f7e:58a4:ebf0:6a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac6e5aasm928610f8f.13.2025.05.28.02.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:09:13 -0700 (PDT)
Message-ID: <ce048e11-f79d-44a6-bacc-46e1ebc34b24@redhat.com>
Date: Wed, 28 May 2025 11:09:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86, mm: minor tlb_flush tracepoint adjustments
To: Tal Zussman <tz2294@columbia.edu>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 x86@kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250528-tlb-trace-fix-v1-0-2e94c58f450d@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.25 07:35, Tal Zussman wrote:
> One minor fix and one minor cleanup related to the tlb_flush tracepoint.
> 
> As an aside, include/trace/events/tlb.h isn't covered by MAINTAINERS,
> along with other mm related files under include/trace/events/. Flagging
> this since I see there's a recent effort to overhaul the mm MAINTAINERS
> entries.

Thanks for pointing that out.

It should likely go under "MMU GATHER AND TLB INVALIDATION"

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ecc6063b2b5e..0e88ea5de5b73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16509,6 +16509,7 @@ L:      linux-mm@kvack.org
  S:     Maintained
  F:     arch/*/include/asm/tlb.h
  F:     include/asm-generic/tlb.h
+F:     include/trace/events/tlb.h
  F:     mm/mmu_gather.c

  MN88472 MEDIA DRIVER


-- 
Cheers,

David / dhildenb


