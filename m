Return-Path: <linux-kernel+bounces-843343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA2BBEF97
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AF764F49DC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8FC2DE714;
	Mon,  6 Oct 2025 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soRTtF/X"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBB2DCF4C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775445; cv=none; b=A9AYAX7sEkdN6XKiBTX/hKlWZ1bicqACs8woiPFNFuRxU5FLjmt9lmJ5ZKxHOGZUSeobnTRPyvq+2f250ACcZkaLHb+hQ4T58Hh/HPp3FL1wmkSu8Sl0KeD5qK5im1TCAXkk2I1fYKKfZYGrwhYoYS+tWOclv1Xdr2uygK+aeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775445; c=relaxed/simple;
	bh=5vr/y5eOt1Q5zMH0KcLbl5o9ytN0rfxQ83BRS6U3onw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyqNOyt3UIzGzgMf0ehi4lucuW7Xx7Ct3HjShdbTassbcVw4romGlnJsUi26tCahTRwWcyAzDbb2dMcF9rTJ4DES0mY/eykXy94UOq0u6q5JtTk1S4kOmJ83twX6xlmV5Jgi1fvQnW28D6qxiH7Njf332TsHFBQgqO1p9Sjvp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soRTtF/X; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so7061983a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759775443; x=1760380243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6KhvJbDS1YxGKRb7Xf/09YfqKPPxIFctsq0cFP5ixw=;
        b=soRTtF/XgnSHcUi+x6/Thcd0R7dqjkXndJ2gTIn1YZpwrdlPP5g2MULd5iJoteUZJM
         KnmeL0Khhj1pMJ/QMrnvxLE4jrELc9wQW0tlf8zHYRgICx0W97GsLYDxxmz5eozyj5yy
         9BNsfYZpLCZqmsTHC4TUu6vCRbYIZb+y9q5ftpe5feIIk88ZbgtvZ1LuPvZwVyaG+1JE
         P3i7czcmCTL1YOHa/hgjnzE+jyjV6aLulVA1yslXyciFEtsqX+8spmW9KWM6n2Y/un9a
         DP5VZDN794SefPy8ojHl/UmCAXenZyinPst7KgACADZ/pNYD/ieLWGmMQAWZqFr8OxFK
         Vr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775443; x=1760380243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6KhvJbDS1YxGKRb7Xf/09YfqKPPxIFctsq0cFP5ixw=;
        b=qaw6cSLPn57mbHRNoHJsdNiwN7t1zxFn6rjNTM0ZnJLovCEOy1Ajl6AqmKNdYkcoBB
         lcxOk/8d1NTGDGI5j2u84jSAIxH8zz+aJh/JO0eA51rz2rM15/gMWVbE+ajjq9VXJY9G
         HyVfFgk+gmPw9vQsdnXdOy68ZiODP0ZJNM3zFj6PGRnU6InPAC99rWch+nYL8JyaqqF3
         8fCE4ahewbd0c8v8m6knY42CXQZUFFtSHr4Kd64+U6XLgPe9hidQhhP5vLb+RT5sI0ky
         0I9v9ImCaP86ziQZnMyUzoXnzoQD4H4cBFzW2rrYegPlVEIPmbM85un1UVw/ZJzKvoQz
         uWFA==
X-Forwarded-Encrypted: i=1; AJvYcCWyCp2fP8/3yVlIJZWxqFg3BC/GhZTfYYMbFO0Hti0DgA4Fmz+TtqtRi2K48HceVCfnDGB9bxXt53LVXsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBLiiCrzfatIZiF3vYJM5EF7OZdbqogxNTEiftHSWgcElWPXV
	wnzEJifDYND1y9Jb05sAHFcEVKaVpmBWtIljfGEuYRACNs9LkQhXQFlu7gsB4g0ZbXqne6Pq1HC
	/EHtt8L3+Ld1slbPJD+BmMRYpJQ==
X-Google-Smtp-Source: AGHT+IGPXLDZWdQ01xSF5vwVUEvM63Oa9VbzyN03sgreMMdlCA1lTf5W6fu5gBrFtOdKNhEXd57baollNGh6EzGAMw==
X-Received: from pjux3.prod.google.com ([2002:a17:90a:d683:b0:32e:d03b:ade9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2fc5:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-339ec9cb492mr1079186a91.6.1759775443313;
 Mon, 06 Oct 2025 11:30:43 -0700 (PDT)
Date: Mon, 06 Oct 2025 11:30:41 -0700
In-Reply-To: <20251003232606.4070510-7-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com> <20251003232606.4070510-7-seanjc@google.com>
Message-ID: <diqzsefvevce.fsf@google.com>
Subject: Re: [PATCH v2 06/13] KVM: selftests: Stash the host page size in a
 global in the guest_memfd test
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Use a global variable to track the host page size in the guest_memfd test
> so that the information doesn't need to be constantly passed around.  The
> state is purely a reflection of the underlying system, i.e. can't be set
> by the test and is constant for a given invocation of the test, and thus
> explicitly passing the host page size to individual testcases adds no
> value, e.g. doesn't allow testing different combinations.
>
> Making page_size a global will simplify an upcoming change to create a new
> guest_memfd instance per testcase.
>
> No functional change intended.
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Tested-by: Ackerley Tng <ackerleytng@google.com>

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 37 +++++++++----------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> 
> [...snip...]
> 

