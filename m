Return-Path: <linux-kernel+bounces-616787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD34DA995FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59BD1B81000
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21C01386DA;
	Wed, 23 Apr 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNIc9Q2I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796671EFFBB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427818; cv=none; b=lCuKFmNFfObM3yPAuYOfqCWAqjnp6ncyAJlsHZzx/gaSTOnk44VKPtLiop2LejyQsAMFTsUW12v9t/BHU0LxT4n4Pmt5FvjWK05o/31wddDs0xyPLsIdZLBAiJ0SJk2J93xOqO8UvB/39KIn+PUD/v/yKh30RhDDivDbI3/e7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427818; c=relaxed/simple;
	bh=0XVlTRBgn1AxRwlX5L5gSRRecvWpaBNYjygKefRRLLU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a8JhguUiq8fCC0+zSy1D7JGxqvu+CTo2JNWXfIHUM+FACLsTWiugGCPXTu4m/COYsr3PdVGXNucna5GEal50G271jOqZmnq0NsVVDVqqDtNXRmQFb8ECmQ7kwbL6GU4J69lgK2JtiUIO9QcTDlHvlXdUAIQqN1WQQVKF5QjmjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNIc9Q2I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745427815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3+7SBYIT0EMoPG6wTKgHOcC2ipTqOMHgJd9hrWDUp8=;
	b=cNIc9Q2IKqCImx36/GS0GOQjwrOr5Wq4ELk+DNh4SqmDk5K5d0tMTZTHhqN5nB6kuYBUkf
	o3oIz8Obk8uUI6n7c2J5GLGnn7OciXhT+I5DLBEm/zaJaWmFQsRF4HsAdkCeQtWi7IcQVG
	OF+jLKkk7R88awGAtpUmJAUEZOTs71Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-bpIfVjBuMaS9eZq6QJDLCA-1; Wed, 23 Apr 2025 13:03:34 -0400
X-MC-Unique: bpIfVjBuMaS9eZq6QJDLCA-1
X-Mimecast-MFC-AGG-ID: bpIfVjBuMaS9eZq6QJDLCA_1745427813
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f0e2d30ab4so1646936d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 10:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427813; x=1746032613;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3+7SBYIT0EMoPG6wTKgHOcC2ipTqOMHgJd9hrWDUp8=;
        b=tJJRn55QHh7+Ju05UYrANi6gLeYnWcGR6Z9QvyJnAWisWcgVpZi5PcqQEyKU/Wsw8h
         RWf/HwkBmydzZ3O6EuUZUY332ya+gjYEoIjG7FckPGhDqKv7DMwG3kbtBg7DfXJYaAlL
         f0vRUhYnVGJd07Zhtbi/KhC7OQzJEzZ0wItiV32CpYrcwwyOH9MpBeGsqYFBZlhous1B
         sMxkPCvn056l27/VO4BBDUZV1SKcM0Rk2aQzORWSNj19oMGGTKPn6daghlejt08HJnJ+
         4m4q031QqiVFAwjoxMXpyYSiCsmxd57CLPoK0ToqtDHppwwhVJViytIA4LUV6qL+nMDc
         lpqw==
X-Forwarded-Encrypted: i=1; AJvYcCVxBqHkNMGAAHGoj/qo88rYLxftRGRUDsH2FMv376Nk8JEWpYUXmoie4SvxErOaVgZz6u1UOj3hZyd4oqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbaLt8+I/1gUGiGTobKPzVW6ikzVoZzGcod/W4x/70B67gumU
	7YzM3Fy8JvCaWSKWh3nuodk1xIYhz4NMz6dZrHnaaJw3/YVawL95n1jkVHlZOLn1r/RQrcgBcId
	S89nUWclhYQ3Ci3ARhxRiu7zTYE/Ug9yAYshBPWHf7p1nIff60LN49pnRViuOtA==
X-Gm-Gg: ASbGncvLeBD0GwsHt8ut+pbK8d3JXC9fXTamaZoFTlZGpWaRyPldst/obJW1BqOjzhF
	/JLkSUU+RymSEop4+HTg54By21NemVKYT+dsSnIfYDjzhPLO/ySn49qu8H7X83THSO6gj//+CkO
	RA1LNjdrqv8r9arARU/mEy7ffRbIgqxxg+qOLN+quwMtfUbB1QA5PHEw1GxXhSC4IH+uXq+auJR
	9kuhMxnKX6rRhx4487fAfXTS2oIcYSNitGOE6M9TmjpfAmNYzRMlx6+bIAUEiTeGzaWqanIW9Ch
	YiWwBRX8t1kVZhtbYZnfyx4Od4cK42VVQm4TJIipRgOCc0cFyErGK76gXg==
X-Received: by 2002:a05:6214:5292:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6f2c46992f3mr343421186d6.45.1745427813505;
        Wed, 23 Apr 2025 10:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0Jady51wQ0Po3UBtRHbwZVYJnEaUhKMy5jHguua0DBLjtBhN5wZ/fJFmpmlLKNdXjaqxXqQ==
X-Received: by 2002:a05:6214:5292:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6f2c46992f3mr343420656d6.45.1745427813160;
        Wed, 23 Apr 2025 10:03:33 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b33134sm72456966d6.54.2025.04.23.10.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 10:03:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <40e1ec0a-63a8-4c07-8b42-e31676453265@redhat.com>
Date: Wed, 23 Apr 2025 13:03:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250415210415.13414-1-longman@redhat.com>
 <20250415210415.13414-2-longman@redhat.com>
 <psbduszek3llnvsykbm3qld22crppq4z24hyhsp66ax3r2jji5@xhklroqn2254>
 <0033f39f-ff47-4645-9b1e-f19ff39233e7@redhat.com>
 <h64z4wl6mw3qxfwmqsvlddsie62ehkoag47lm2in3nda7dhloq@rjxpkggawqem>
 <d32c626d-1c93-47ec-8b01-1c085b4bf2fa@redhat.com>
 <d36jhvahtoqqtuw4y2k4rjzmxnu4ejbffvimrnffvcu3raby6l@asjm6h6r7w3k>
Content-Language: en-US
In-Reply-To: <d36jhvahtoqqtuw4y2k4rjzmxnu4ejbffvimrnffvcu3raby6l@asjm6h6r7w3k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/23/25 12:49 PM, Michal Koutný wrote:
> On Tue, Apr 22, 2025 at 07:58:56PM -0400, Waiman Long <llong@redhat.com> wrote:
>> Am I correct to assume that the purpose of 1d09069f5313f ("selftests:
>> memcg: expect no low events in unprotected sibling") is to force a
>> failure in the test_memcg_low test to force a change in the current
>> behavior? Or was it the case that it didn't fail when you submit your
>> patch?
> Yes, the failure had been intended to mark unexpected mode of reclaim
> (there's still a reproducer somewhere in the references). However, I
> learnt that:
>    a) it ain't easy to fix,
>    b) the only occurence of the troublesome behavior was in the test and
>       never reported by users in real life.
>
> I've started to prefer the variant where the particular check is
> indefinite since that.

OK, I will update the patch as you had suggested. I am fine doing that, 
just that I did not understand why you wanted the result to be undefined 
in the first place.

Cheers,
Longman


