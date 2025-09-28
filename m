Return-Path: <linux-kernel+bounces-835128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40DBA655F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE0F7A47DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510822759B;
	Sun, 28 Sep 2025 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDmL6Bqc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B234BA42
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759022550; cv=none; b=kkJ72UNszc8a52R4Tvys09RXNBfZKuvuVX+j4Q03/lZsEvTgHBA3ZRwCGBWA0RND9GIfQ3R/vXvpGHkgMngwjGb4FB5/4ac/e4CwJC2GRg7mkorpDEfV97aWdVKdrEzjaUlnh7TQWsjEvcunkVXjDeZTCnOdlNaW+Wa2r5swv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759022550; c=relaxed/simple;
	bh=RGH9s5C2/04q7NvHsl+9+cp4pXXOkuaGfJJ5n/ZBX/I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dfzPFj3UH8dL6UpCqy8m4TuTBmpthXYnL0rQZfA4MxW8p880n0ERw0kYDTwq1RG0Z/lhD6o70HFMVHtr/JmN+i0bQ2e7ZAZ9scYkq540EPhD/e2VU1L7drQIQgZuIANyGuQ7YZhfVrvrPNtau/MRrG0duVm9X1t83H3HW7L14kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDmL6Bqc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759022547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hn7iHmC09rru4/PE6AWWnxzwMjl579sVNb/Zk7woIeM=;
	b=VDmL6Bqcx2qFzKa8RKeOrZkX/cO3YQtQm96tSJJ5rzNmoaCJnrmkRvUMl9gEkwzm51M8ow
	OEXjSdji9om/UePPCxBm3Oje09R7OWzP8Z40nok7IFUfYvCZL60j+0puvsfQtyeylENtyA
	e78Ik7lMoJ+bsOiZcw1m49H0se4gq9E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-iAlLsXPVM52LKTDfCdhALA-1; Sat, 27 Sep 2025 21:22:25 -0400
X-MC-Unique: iAlLsXPVM52LKTDfCdhALA-1
X-Mimecast-MFC-AGG-ID: iAlLsXPVM52LKTDfCdhALA_1759022545
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de801c1446so39503031cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759022543; x=1759627343;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hn7iHmC09rru4/PE6AWWnxzwMjl579sVNb/Zk7woIeM=;
        b=ABNLCF6nHBAg1D0YrvUXMrboAhIrSM+AIpy8xKAeOsHe8Yk9LMhLI26jqGqs8ep+HF
         tzO8rk5lMn23QnT04sPLZ+q4xL8kDJMabSB41LKhEwwMeqgpZgN41q6Yys8QM/40uRdw
         P3KGK5mJZjUSV4X8QgFierSPy8dJmLdmFhVNkNskNLGydQG5rFLNiWp+tOXdMb+Y7vK0
         DCXubD6wodf3Ito7SWvihFCRCu+B27LElK7SFRDI9XRsciGgZwGlEx6cKZGH2+eJnMBd
         DhAvPjigPf4v3CE4Qv2fk1O+nZX+edYCfuS6l+fBB9bm/YstcIQrJdqhF2u6dClWqFUl
         4V5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdTyFcse4SDJWRNRQISy26VRJ+f7iHvJuy4IJhNIPcJotA/D0kYcn8K5n8N4AWRgZN0uY7025WK9PkmIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaowKOBa2FqzNh2A0zyOSVsq2Ce1LcqK92aYnRfUCu4CJpgLH7
	qaPEhGJhQG6HrjmXVQa48DnfT+YQcI9g1AJpq/kT61fDLyyobG2FAdCh27NH9KowbqYUrE4sdKT
	qG2AoeoTMxCd3j6rSBKvrfYw0BBgfb2Ju3+JK8xMeWIsoKeNxpGzEhGVlPE41/1h19Q==
X-Gm-Gg: ASbGnctXGWCf2n9zw2tGQ+QMo99eGsRjBCh1ZizD2VVpxR5eq9oSbSPvv9P3Gf5rPXs
	zINMWOrIw1lZKrBNaI8SqAmLvBmnZxa4NC0/w42DsJ9tQWRvKXX0FE8pbelHW6Cg04zebPciBkQ
	y/dsPiySH7LLtePzqsVbhGs+w5ZgifRRH6eLN3B+onGVPXq7zXe+dl0bkMzaLZfI8D0TgiZUP2t
	ZUpF4XBwXefKGjnn3q1zUhR7+x1YWMq5vj2odRWklzh6haaak82U1iF1rvrmHyKCEM02OqxYRCK
	eWnUVRDAVTNtaGIk5HJbUJTJjM66mio6lurlnQrf1mfhIaKNTMfOayHjzOAHbI9e5/gQS7fzjDM
	BgoiMhk8gfrY=
X-Received: by 2002:a05:622a:14e:b0:4cb:7d9a:e1fe with SMTP id d75a77b69052e-4da4744e254mr167259891cf.9.1759022542950;
        Sat, 27 Sep 2025 18:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXAYEXbjXLS1nZBJ9oTc+3bTz5QscB++OD5I9X+SJQltT996UkTpHIv9OHMc2rT2udToz4Wg==
X-Received: by 2002:a05:622a:14e:b0:4cb:7d9a:e1fe with SMTP id d75a77b69052e-4da4744e254mr167259741cf.9.1759022542592;
        Sat, 27 Sep 2025 18:22:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b56fe22sm48001721cf.20.2025.09.27.18.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 18:22:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <410dde3f-87f6-469a-9b1b-73c676e34049@redhat.com>
Date: Sat, 27 Sep 2025 21:22:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking: Add local_locks to MAINTAINERS
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <20250927090110.t8Tm9yrk@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250927090110.t8Tm9yrk@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/25 5:01 AM, Sebastian Andrzej Siewior wrote:
> The local_lock_t was never added to the MAINTAINERS file since its
> inclusion.
>
> Add local_lock_t to the locking primitives section.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f346abc84ab0..45e6499405236 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14291,6 +14291,7 @@ S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
>   F:	Documentation/locking/
>   F:	arch/*/include/asm/spinlock*.h
> +F:	include/linux/local_lock*.h
>   F:	include/linux/lockdep*.h
>   F:	include/linux/mutex*.h
>   F:	include/linux/rwlock*.h
Acked-by: Waiman Long <longman@redhat.com>


