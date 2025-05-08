Return-Path: <linux-kernel+bounces-639785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2F9AAFC5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 16:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA18C16D1F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC3242D7D;
	Thu,  8 May 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXgSkB2N"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1D2417EF
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713067; cv=none; b=avPbAiUD9biCFAh6RMKex0DGNQcFGmKSRKPnbv1uhypnRw/x7ryXv923AUEm4jj9ehE65bucv1M1IF37FNyWDiPVlaAuZcQ2E1CQoN19GlNDjkP9pNlsfrc5vvP4bbVLcsfWNQJVGVJ9XfIiUYKSRP9VDm65GupwvhqHoMIDkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713067; c=relaxed/simple;
	bh=RbK/9v+ee2pYpO2N9wpE0C8ABX7e2vw/PINumgYZ1XE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J5EJwb6vMSoFIxdUx9+cInW8dDiCZM8qQZQkn73PMsVKrQZXmDQFkF/u/XTJORfN78KWnpD7AS3XIAZdg3PYofyLMtFM0ps9W6ZvFjxU3Duq6FN/FXEEWGZiArKrrwt8g2DiVSbsb/OCOJMbVUs7lClhqWVbz+F2LG+vjdJyo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXgSkB2N; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b21771c2478so330224a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746713065; x=1747317865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2tf3xEZy1dGL+3t3eFy4J00XNnFfVlwiE6sUM4MGp4=;
        b=eXgSkB2N7iJ0p3fztNgeCYvb2nWZq+W0DWu9tB3u8Wxo8sDcEzXdq4rtYbFa4D47hK
         XjYPu/ikWw4fyudax7CLUQ8gf5KYeeSpmTIZu3Dg26xAFQQVLi8eWzSfIeWQIcKCK2Qf
         8d6pjTy7z1DgldpI6ZEQ1udKyAEpHP8/qitsnM2nZajHG/KrEWg034fLheTnpQqrO/Uh
         aFvThM6gY7UQbuht/FJjHG+Nvuz2c9R68XkCihVCWoCI/mq63GYiBHhvaZLf+5ccX1mV
         h1n+9WLIfbdoeCwntY0r7sOevEuD1oKnlswD/NKebnlidHYmJWW29NDQfIr48nPf0pGO
         SblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713065; x=1747317865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2tf3xEZy1dGL+3t3eFy4J00XNnFfVlwiE6sUM4MGp4=;
        b=MRjztqiVbHD5xqBVCx5aWYFjNLGe9GAMdArXnYM0W9l3kEjK1MaeoUtPPOAkTz0Jts
         ahVxGPRT/CROUCjvsJb925uL+8Zp88QVQt5G9msEy+XdTXnXh4KxGTuyuIGsg/lkG47j
         xaIvDkdAJT7whsjUuOYuwQd+3UriDHdnn07q/0pqzCChr1gQuWJd7j72flRqkbHvBVGt
         p2izpopWP9k1erAVZbCpb/VdRQZzOFc7nHtmhn/sG1G2GUmYmHwCaHd4q27vh+0pnDPb
         rHGUbsmAjiTPf2J/8TvN+5P1WwK/0uLrWXVygyrHrY6sS+/Y7/xuKOVFu3LpwforLGEO
         Zt2A==
X-Forwarded-Encrypted: i=1; AJvYcCUsv5txndPwOc0FNupZS4rrp3iJAii/OWGrIijhWjjzte/xJ0SoyLKprtW6P2zZ5Rr5hF+kMxbPoO0hXiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUmiZNRihnjCWYN59XB6JZ0OCVZAsOQOpskD9KPJupYVGXAYo
	D+38bqrJzlVRHHqEkuwAzOlTeck4/EX7chktpaK6VZkneCgic3tGZkbmTEg84mFjMFuNWwwGBOL
	YTQ==
X-Google-Smtp-Source: AGHT+IHihdEq9WLfghzMNio7YGXsAlKJr+fbU3ATJJQrX+sg9sIwzP998JJJm0pKRjkHt2JyM4XtawG+d/Q=
X-Received: from pjbpb5.prod.google.com ([2002:a17:90b:3c05:b0:30a:8ffa:9154])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e08:b0:2fe:a515:4a98
 with SMTP id 98e67ed59e1d1-30aac2bb314mr10385069a91.31.1746713065404; Thu, 08
 May 2025 07:04:25 -0700 (PDT)
Date: Thu, 8 May 2025 07:04:23 -0700
In-Reply-To: <e87bbc68-0403-4d67-ae2d-64065e36a011@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com> <e0b9d4ad-0d47-499a-9ec8-7307b67cae5c@linuxfoundation.org>
 <3687348f-7ee0-4fe1-a953-d5a2edd02ce8@nvidia.com> <e87bbc68-0403-4d67-ae2d-64065e36a011@linuxfoundation.org>
Message-ID: <aBy5503w_GuNTu9B@google.com>
Subject: Re: The "make headers" requirement, revisited: [PATCH v3 3/3]
 selftests: pidfd: add tests for PIDFD_SELF_*
From: Sean Christopherson <seanjc@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	Christian Brauner <christian@brauner.io>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 07, 2025, Shuah Khan wrote:
> The issues Peter is seeing regarding KHDR_INCLUDES in the following
> tests can be easily fixed by simply changing the test Makefile. These
> aren't framework related.
> 
> kvm/Makefile.kvm:    -I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)

...

> You can make the change to remove the reference to KHDR_INCLUDES.
> If don't have the time/bandwidth to do it, I will take care of it.

Please don't remove the KHDR_INCLUDES usage in KVM's selftests, KVM routinely
adds tests for new uAPI.  Having to manually install headers is annoying, but
IMO it's the least awful solution we have.

