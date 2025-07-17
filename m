Return-Path: <linux-kernel+bounces-734514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22FB082A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494D87A6219
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF31A83FB;
	Thu, 17 Jul 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5M2EN2x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7E258A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717144; cv=none; b=gjLqmGcR5RSwOWKz4N734a+fzPC0WDcWzPc/Fd77VM8/+dHJYAls5w40GkB6ru8lgfHEZgHT+rfF7gLqrustpXg/c6k9RIVH+mF9pSdKZhqby+KGe0kOt+ZIWHGsSp6KDZgIMCOldHlo1awKKNmtBzedyVVAys/Jeuqa4UPwFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717144; c=relaxed/simple;
	bh=8QV+OaUtkOfiiPmnV7XnlUYE7aieMZMLvEkIj+sf1AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as8V/miK0ipnJSA260FexZpFsoQbO65xblX+6psBDFV9SOPqDJuZk5kY5vt8w7gINpkLLOEUByyd56vzgJKz/gOa6kqi1SSvh5KaFNyDRp0VCzpSCfFEmRI9o4RwvgrLkmHRar4RRIC/DdBqiM7yVuoO9TGD5HtaqeEHQDkp6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5M2EN2x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752717141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oonJpaJQAFJWZsBx4HwWzksB4jk3QqHG6oMM5XEtJzc=;
	b=Z5M2EN2xSDEmWCwSNY9LPG74wPOTQrCnHfEPypkRlgBsM3lq5hpJH6VEDkT62zibgilBOR
	fMgYzwAPoX9VrLhGKS0Pns2VrnVPtyqnQZLY1V2AZ7y86SS3VgBaWOeIpYoW1OIj5O8ptz
	UfNgB9YQEZ+r+rGCAB4x3fl+ozPrOJ8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-hMwKIcscNIKD3YCOPrLfNA-1; Wed, 16 Jul 2025 21:52:20 -0400
X-MC-Unique: hMwKIcscNIKD3YCOPrLfNA-1
X-Mimecast-MFC-AGG-ID: hMwKIcscNIKD3YCOPrLfNA_1752717139
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6face45b58dso6975776d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752717139; x=1753321939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oonJpaJQAFJWZsBx4HwWzksB4jk3QqHG6oMM5XEtJzc=;
        b=T9BFJoUgImJk22BqBwd8VMIVZMIXEAJdd4+aCANXJ1HiW5bylXxIro9lm8v7SukI8/
         yuWroOBwuQi+QyZ7J0eWjDqRSH/KrdqRy5wsc6i3SdMMGIphTm0a4aB0RUrbmyJhGkJB
         2wKh90UEHAwfBfvP0rFBhNe+S7BLRcM3R83w/wdeYwKe4xZVByz4WJXLCVhubKw596Qw
         BdBQCeB5ZLBt1k9sXbH3FuA5jxzqEccQIY38EZbC+SpUeyaA3HZBm1H5AOjal+BImetQ
         P+fqGRZVld1xKennEzHFQJGvwDdbNQEbZBMmH8DxBUB6nk8hWgnoRsuvEOm2PHFcDRjZ
         GyOw==
X-Forwarded-Encrypted: i=1; AJvYcCUWOZFsGtdJ0QdFSMqf7XYPWpFwM54hTybUBvKIzNj4mmfNrS1kCo2G8v2vKBuCpM/51pAtGz4p3v+rA+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjM3LG4kfdbQAm80LGvd8QJZt9RO/BYRnQpzm9A63rt1g/pQw
	7apdEJzIVtijDc245lokANVR1SUXZAP22oiq34Yp3XWpy5PZnmGd4H8nEo1JX3SmvbmTdNON7jf
	YpczeYWlz9/SfWCv4LeLYJ5vYjRyvL4JdtjHKNWByf6E6WhIfqmojPjs/JDD+M8Eg+g==
X-Gm-Gg: ASbGnctKcJwV8U3tK4Q93FMj9qZ/JnCkNb3bWM8c1Ri4u+6nE2r9K2Tjv2b5rxdc3Gx
	k2TgJZe1CaVpV5JOiSBPkpLnoyI+603HyjgF9b3TV4mzHaVdlBpgZXWL3dfV1WcK3x6JHNSn+xQ
	eKMUUe/TYvAkuSlDDG9jCFnBp2Ud4eWm+v+ts6Np9bz0E1KNDOUwPUWKZmhWxY3oXw4+0e6QnbH
	GX1V/pGyyH+qHITkI5q5sTqoJrmBi9REdZMv3U60m2PZLsJaspbdzJomkDN5NFcDVSPVSaFH12X
	uNiwh2AdUOkHIUKTczpm/uJnSP6SrjRem3wnOF1b
X-Received: by 2002:a05:6214:5d87:b0:704:7fda:d174 with SMTP id 6a1803df08f44-704f69fd7a3mr75458736d6.2.1752717139558;
        Wed, 16 Jul 2025 18:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeNqyzhftnEI+RGrgPgJ/W+j/U4BgacO8D07ayiMNbDZaO2N4D0vHL8lrJF7eKKtR/H82Umg==
X-Received: by 2002:a05:6214:5d87:b0:704:7fda:d174 with SMTP id 6a1803df08f44-704f69fd7a3mr75458506d6.2.1752717139091;
        Wed, 16 Jul 2025 18:52:19 -0700 (PDT)
Received: from [192.168.2.110] ([70.29.229.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d94538sm77582286d6.99.2025.07.16.18.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 18:52:18 -0700 (PDT)
Message-ID: <e4798260-41b7-492b-8b7c-0922173f59f9@redhat.com>
Date: Wed, 16 Jul 2025 21:52:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm/util: introduce snapshot_page()
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 shivankg@amd.com, sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
 <ca72882f-257f-4f41-bea2-0b5324c820d7@redhat.com>
 <900252c7-b16c-49b9-8c01-60e6a7a48683@redhat.com>
 <492025a7-4132-4944-b55b-90c6d6e40bba@redhat.com>
 <20250716151937.6dd71398bf764d073526dc8c@linux-foundation.org>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20250716151937.6dd71398bf764d073526dc8c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-16 18:19, Andrew Morton wrote:
> On Wed, 16 Jul 2025 20:18:00 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 16.07.25 19:36, Luiz Capitulino wrote:
>>> Yes, good catch. This was from an earlier version.
>>>
>>> Is it fine if I fix only this with a follow up patch for Andrew in this
>>> thread or would you prefer that I post v4 with all the other changes as
>>> well?
>>
>> I think the series was part of mm-new, but now I only spot it in
>> mm-everything, weird. Maybe because of a conflict with the other
>> stable_page_flags() change?
> 
> I think I removed v2 from mm-unstable and added v3 to mm-new.  Maybe.
> 
>> So whatever Andrew prefers, really :)
> 
> Either is OK at this stage.  I do prefer little fixes so that I and
> others can see what changed - it depends how tricky and large they are.

I liked some of the other suggestions from David so I'll send v4.


