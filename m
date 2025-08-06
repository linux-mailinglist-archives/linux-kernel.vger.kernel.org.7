Return-Path: <linux-kernel+bounces-757466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE4AB1C27C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9290620C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391971DED49;
	Wed,  6 Aug 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcLPAqSF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CC275855
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470304; cv=none; b=NmEluUgcHQKuB6Uuh8W41gO34EXUJa5uV5T9LijH/uE9ZbAU3jAx/Cgty5HEEIYWKnExxvxjJxqfCYK7JM9znEBKIwhTy8Cjv6WKZI6fbNtuJRKzrWrwbyX1di5y5WlLIRrEWSex+/ZVEvyk9luicyxWFN+sFl5leplTa5ys1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470304; c=relaxed/simple;
	bh=cwXBBQQVw9I8sU7E87qqxsuKRt4bONDyZXjL+znY3k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs61wykQry71y9vruBEbLwAoc1WjLOIkmWRyf5Gu/ZRp6LUr9576kMbq4g/NzBdOpoVxzpkXvGURTBfZMx0Zo3BpqkXcm6cOWX756ZzAivi8v4ANItCulzFJReQ5GGntGu0F/Et+jXWWfUHOsaGzhclJspK5x6dIgN1BknGNAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcLPAqSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754470301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4IwNT9i/JwzyfF0WXSmv6SUio7A4Qs+8y1jGBSlhhlE=;
	b=CcLPAqSF7iEIOlz8OVW41Ae7xqfqT4++tR+F+Q7FdYEHqKwRBT4PlrvXt/uGqHmhr6NbOb
	UC4+01somXkWfPGSxwyt4CLlLx4oElYelkS2NBoMUkXtZZdbpO/rhvExGsVzvXa1IX898y
	L9jcCKado2Wc/aE+wBmrijb7GLksGdo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Dqw2IRiEOf2OH5dP9VT9uQ-1; Wed, 06 Aug 2025 04:51:40 -0400
X-MC-Unique: Dqw2IRiEOf2OH5dP9VT9uQ-1
X-Mimecast-MFC-AGG-ID: Dqw2IRiEOf2OH5dP9VT9uQ_1754470299
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b78329f180so4573724f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470299; x=1755075099;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4IwNT9i/JwzyfF0WXSmv6SUio7A4Qs+8y1jGBSlhhlE=;
        b=ra5CVda9jW+vtCcu1Fjw7Rzv3j9d9zEAjCSTLtHl4Df0d/3+QBq1kJs+MYFQy0Cdvh
         BpesIgm+nYghzddR0dfkiB5s4gdsYZF8tVSuXX+jvYtU/8vnSFyfw59mrt0hJcnwfwSZ
         y8MGgHkikS7etcDyI0ooEBIMcl3y7RMzZvF4cMmhu4HTLA6trUrudj20zD34eqrydsyp
         /JY/xcgtqdxFjA601WPiyF7WFSuP5T8FgViKxnTSXuw/YMbJYkuceyl064uTJv4TDE6d
         RQq8hQW8O8rnXn6yUd0h1HJKB5B1QsZHm/DQNneIm6Num7ktiaRJ9tjueXmfpvvFK7at
         t5hg==
X-Forwarded-Encrypted: i=1; AJvYcCWs50A7tH4LxBeh9zC6bYHnNG6OUE492oIM2QpA05o4X8LTB8Yo/wrmt0Pv/EJf2RNQ3BMgblNG25P4lw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsgbOppiSrHUEAWQmM6FZYto9xMpjtLJifWbGLN/KLBOwxJPP
	3gMOOj5D9dR+4HsekkCmIke1uqjdzOxdiS6bvmOtuEDhFmS1a5HG6pGjyBI8TZuUSB24JFw4Nuq
	o2E88/cR9gIngCm+/qd0DQPDoByWzACsx91jZs9YN97capvlVhcyyRwCG3AmRWvooBw==
X-Gm-Gg: ASbGncvx0O1k2xB1t7e3W5PgKH0SCgYUcQwyeBbxMUfNJNkgBL+KOxVythozVHayJwm
	//dNFDfvX4Jcc6CWeYdCjifmz87r6FRlZHnPXPTxGyVJXefcFBxctYiRvL8wXmyP+eW03sFU7+M
	38yxx4lEtI8a541soDHbSC5+WCLFjr365Xavdzh2acB36f2bcePQnk4zH2Nq1VQzoHMhviQVPJg
	nyQec6yZv1Fy1ypVzOD4v/hTfZMyy+KvVZ2TT2uzOzq6142GV/Qi0ucIJDfCsJvLd5tgmjCaYkI
	VBe5xqhIBDHawV4EwVbzJm8XiVPbVwjHJorZKOEQmi2SReCBVDnyd5YShg0VLCjurKShZ61Stc4
	+eVF9yoCP7mLH3NzAz63MXS1TrDga9+8NqxJJG26r8E1yG0113ZSRV7FrB5OUVYMjw5o=
X-Received: by 2002:a05:6000:3107:b0:3b8:eb7d:f82a with SMTP id ffacd0b85a97d-3b8f415f242mr1693300f8f.3.1754470299010;
        Wed, 06 Aug 2025 01:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs0sLPv6yMKhOQrjuK82i6lu18QLMsncnzFBpwyUyzNv9fFv8kUEdIpX9vcp/OMB7hxfeeNQ==
X-Received: by 2002:a05:6000:3107:b0:3b8:eb7d:f82a with SMTP id ffacd0b85a97d-3b8f415f242mr1693267f8f.3.1754470298533;
        Wed, 06 Aug 2025 01:51:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm305390535e9.25.2025.08.06.01.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:51:37 -0700 (PDT)
Message-ID: <9ec621c0-ab26-442e-a07d-06905699fbc6@redhat.com>
Date: Wed, 6 Aug 2025 10:51:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Default value of CMA_SYSFS
To: Jean Delvare <jdelvare@suse.de>, Minchan Kim <minchan@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>
References: <20250806100748.21620372@endymion>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250806100748.21620372@endymion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 10:07, Jean Delvare wrote:
> Hi all,

Hi!

> 
> CMA_SYSFS looks like a generally useful and low footprint option. Is
> there any reason why it isn't enabled by default when its dependencies
> are met?

Looking at the introducing commit

commit 43ca106fa8ec7d684776fbe561214d3b2b7cb9cb
Author: Minchan Kim <minchan@kernel.org>
Date:   Tue May 4 18:37:28 2021 -0700

     mm: cma: support sysfs
     
     Since CMA is getting used more widely, it's more important to keep
     monitoring CMA statistics for system health since it's directly related to
     user experience.
     
     This patch introduces sysfs statistics for CMA, in order to provide some
     basic monitoring of the CMA allocator.
     
      * the number of CMA page successful allocations
      * the number of CMA page allocation failures
     
     These two values allow the user to calcuate the allocation
     failure rate for each CMA area.

I cannot really tell why we made this configurable.

> 
> I was wondering if it would make sense to add "default y" to this
> option. What do you think?

I'm wondering if we should remove the option completely -- or turn it into an
internal option only such that it's no longer user-selectable.

CCing Minchan Kim

-- 
Cheers,

David / dhildenb


