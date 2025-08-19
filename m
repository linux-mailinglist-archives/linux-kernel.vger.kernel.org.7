Return-Path: <linux-kernel+bounces-776640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85674B2CFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6767BCC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1A24113D;
	Tue, 19 Aug 2025 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1740cC6o"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F79146593
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645460; cv=none; b=EJ00cuRONGTvlWESOXaspBcntr8mhrTahskNpV3Qv4taJbc1BnYM80RBPQJC9Lp8O8+aVcKl4xcGUrRIuEzcQqZ2r4aW34l4hZBgRF9/eU+ofpl4iiQGeRQGlQ/OpbnAEe7tGp1A9we0YVm0O8vvDOmujhJN/Ul9vpsK6g1lRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645460; c=relaxed/simple;
	bh=out9DGEgrIviYX5OQnXptMfYO2ioMjd8Ge42msARZc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nOtC9OOJzzGtvgtwafGKH3bcqUXSuqTNx+xpib3Iu6ofXdU53GZyAGR3co0ovI5eCalsGcgZ5XZTVzE0wANm0yF9K/rCrfCICCHhifr9nLX6q3xKGvnzgIT9E+n4/Yq8ODA/5P+3ssDEK+1XtYYew6tr821SfJrdGzSahUbCM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1740cC6o; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce388so132419845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645457; x=1756250257; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KryB1aDOMDXsCkNpHOKPKNmk6DDPqkT43yEH/UgBA18=;
        b=1740cC6oU20IzhqJA83v65kjN6zYWxLLcLjRZYMS+wuccAf9LNk/Dc2joHtfIGELvS
         n1GrUw2pMTdjWccvnZy4Rk/A8+zRsBYXUcGnL1yKpXVPcehvvZJmnwuzn58NGV1TO5Ze
         bBl42IqFQ8Mp3LI4fhAEBhcomgXHHkym3l11q6w8g0TvD711GLRJZibL49RGyAARqibN
         WAc5sriTmQ7Rpacc+XYnngfh2lcoL6nZZmwK0nv6QNeb3hHyqqqt3rsotlfStcH1Sqcn
         ENv0AmbRFWGbq3SmAxFYl1Fb6PmX3c8LQLnVONwdeuMguNk51knEGRfeJwR0fP3SKfsA
         ygFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645457; x=1756250257;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KryB1aDOMDXsCkNpHOKPKNmk6DDPqkT43yEH/UgBA18=;
        b=xBRUpWWJ3tQimlaNWIAvJRNbrtQ4SeztuXG2H81LVv2Bu9s3EsnMUJRIBPSgCLfqTd
         dBgfnvy6j4oAdnLpvtT0CIqhuEGc48MO4ziKVU54XCiRyTm3196mvM4hVNR3VaQTFw5g
         MlOS8fOJz3FayptF8LyaUUzWDQEPRn1iejAKZ5k2qtk3/mSWlU2PdmPcr7P9EP4JYy6A
         UKziS0KOPoOcffbiy7Ua1XJiUxEPoS2MeUe6ClEmFOn9neK/HDk2iYbhz2mo1y5DJzDs
         S+se88lt2iLI+Le59KRT2V2rqcsu3+lXI6w1fnhkDsfoqcOh0CFeV1VoJ8RQx82o45O4
         Ux3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8TFZuJvYKmXAWq7CXL3sTCcSz3t56Tkzb0ehUAdzCDeacA7+TdVooMJOqItD+WApfWyCac5c+ISMMlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHAaNBS/fDhxYtRB8szl7T6AyfTse8hsHkrikl4jscKtwUKXC
	Rht89FAgmUaKnG4F0T7Bj49hEUE+0tDXDu5G8KHOXwM0uLrtgGLUkm5oYW+1J4wbTL9iM4m/r8M
	oWat5hA==
X-Google-Smtp-Source: AGHT+IFJ402IKTEOa9VwlQFriR58PGWC72Iwqzb3n0Tzzk6lHP7IhmUL8jFd3gyIq/BVfta1N3jgZezYG70=
X-Received: from pjbhl6.prod.google.com ([2002:a17:90b:1346:b0:31e:d618:a29c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8a:b0:240:7308:aecb
 with SMTP id d9443c01a7336-245ef21760dmr10035045ad.32.1755645456972; Tue, 19
 Aug 2025 16:17:36 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:11 -0700
In-Reply-To: <20250720015846.433956-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250720015846.433956-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564479298.3067605.13013988646799363997.b4-ty@google.com>
Subject: Re: [PATCH] kvm: x86: simplify kvm_vector_to_index()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Sat, 19 Jul 2025 21:58:45 -0400, Yury Norov wrote:
> Use find_nth_bit() and make the function almost a one-liner.

Applied to kvm-x86 misc, thanks!

P.S. I'm amazed you could decipher the intent of the code.  Even with your
     patch, it took me 10+ minutes to understand the "logic".

[1/1] kvm: x86: simplify kvm_vector_to_index()
      https://github.com/kvm-x86/linux/commit/cc63f918a215

--
https://github.com/kvm-x86/linux/tree/next

