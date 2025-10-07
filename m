Return-Path: <linux-kernel+bounces-844847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 877AABC2E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 755804E8167
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883E258EC1;
	Tue,  7 Oct 2025 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Xz+mr3W"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931D253950
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877702; cv=none; b=tZwRHhWS1gNhTEdQxF5Zueu4rKcbJCPv4lU6EGbq49zIV2TlQNRaNBgtVuqVj3Q07wxlLpOZaxHvY5ol3DN9vU6LQqBKw2RNsyg0Xt/irSAmmSSW8JsB0pVOmP+w8kdseUeayLAIBm2z5hlFhxJJpVgv+gEgtZeIhxEQgJKpR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877702; c=relaxed/simple;
	bh=8oNP3BZbf1btZ1468oDc50oyYmgfiFq9VwACSNKV4IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE4uTdFdwyHwLmoDn0/0rABQ7bqOQAr4uzrbkpNTJRnBPoUtUXYderOkHNfUgsteMzYRce/m4lIU5gLe3VA8koz5BEhfiT8X8yruIsCiWcV9Mqtb/Xctn25I7+7thwWxbqfN8w2Fq+h+QBiadrFFELsqTJPkDYxe6vDCl8YLkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Xz+mr3W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27d67abd215so98535ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759877700; x=1760482500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMvzl2nrbvAe4h4fchRl02Iz4TUcxMlupJfG41EnDNM=;
        b=2Xz+mr3WLHKRL80v4EP+LIq4071Q7FIzPZjJRV9unaZ+ScsW8H1A306ewURzpI6j13
         atw7SqO+oxmFft72mnxzyPSBmlYfnMr6SL3guva73UY6ZdGiJDaKkYqldC6p5SQJxi10
         7I3e7EsuFjdjQ1LjwupvKNFjAelTd5jQ2z9XsSnZvy6ehJiZbg2MA6TKm2OJ00YumkkV
         TYFzIshJmQQcWOylJul5j3IVDnYusRK7gatZRrjo5sSXrcVcUvU2tPCRfx+aQuO0Rmky
         X7ewB7Md7ndW4vdD2kNgc/IkhwFQ7ffBIUbrbxVwMHfFZ1FCjIeEkc2WuFRuJxPxgdG8
         hRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877700; x=1760482500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMvzl2nrbvAe4h4fchRl02Iz4TUcxMlupJfG41EnDNM=;
        b=vyRbl34PYu4jWW5FKR+qgmKEWnKaw+kLUWdITbZZcA/Qm0yraso81j6Au7hsaZ5spK
         68o3aqDwyX/a4R5/h2IChi3w13ARhHnlrpD7PzUfnYX3vta62WjwfN7dsoThZjQhdni5
         BdNSS5C7LbmVmPqzphGeXBbTcaVgQ0Xtjrr6Ah/rBrr2Hy0A+IJRmxJdPkDMhprNtV8w
         8Bi98rBQmepaOWC2JeTJoC1+Pan7LdK6b9OpnzdmXsL8VwJ+8tIMb1p35tSNKlad13Vy
         QzKj2o1IoBFO5wh/U3MGaIucJEKcjVMdr3VTkOwC+Zw+7d8j6lBkn6y7TfxgkoB7+fOP
         YFNw==
X-Forwarded-Encrypted: i=1; AJvYcCWfkEnXDNoZkxzEOHPLVTpg0MjnyWUl0OXRlpJvjT+hI9xpX9KVankdua1id6e7dJiTy6hj/Qz6d4l4nvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGR/BzaTzslNYzs6ONN54pm83exoMW1/cnfAxspJyPYK4V5CAd
	ktpaJv45wzd+IYWTCNi23r01zKdgKTLRZVen2qYTImhu1XxLriS3yY8mEqF7Zpo50g==
X-Gm-Gg: ASbGncvLG6IcBjLndSFB06xbleZn0s7KqC/RzkcTstgnNY+1VUFGSsAp1sHK330jHvh
	C1fWZomVWxKqCuDD8OqrpCeo5NlO/3C7vUnbbyGKkKQnYxSxp9/RnW5f2tZFhiG3U3Ie7GeMUH3
	0w2cYT3JD7DJCZES0h41pnbld03hQDsQG1ylv9Lu5AO7RSFQYIZ9kk7jkEsBImQkoXa5VgGdFAZ
	pTKudP2tG5x4AzSL9UwNM9oRh5TdtHX3cj6uXlSPUUwz2Sr16TX7WJoqF/fxPt9Sv8GB0MNHOmb
	oNuU8dPCXGiryP7sD/IflNa/vDTMPSbZ0akZrt63MW9Fq6pBnj68h3tyJJU4Xz3O3EJaVq5PAgp
	zcDbldv4Zt3LSHjHpT5gZF3xsPvdY2gGKXa9wjEhvr9eGTj3kSkGLoIg9+Qwpah3buAGMqI3Z2M
	L59auo5tcI420ssRHsP27rUAqTBseR
X-Google-Smtp-Source: AGHT+IG8Nm6+KKK6nouMNhSocbt9fiuZN24e9MLJcH0B6n9gn4kwDgKajjlNaGGEjtfG0qL6q/cyxg==
X-Received: by 2002:a17:902:d4d0:b0:265:e66:6c10 with SMTP id d9443c01a7336-290275dda96mr2685295ad.4.1759877699504;
        Tue, 07 Oct 2025 15:54:59 -0700 (PDT)
Received: from google.com (115.112.199.104.bc.googleusercontent.com. [104.199.112.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d12807csm177505315ad.52.2025.10.07.15.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:54:58 -0700 (PDT)
Date: Tue, 7 Oct 2025 22:54:55 +0000
From: Lisa Wang <wyihan@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Fuad Tabba <tabba@google.com>,
	Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v2 07/13] KVM: selftests: Create a new guest_memfd for
 each testcase
Message-ID: <aOWaP4n7wsTfySHk@google.com>
References: <20251003232606.4070510-1-seanjc@google.com>
 <20251003232606.4070510-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003232606.4070510-8-seanjc@google.com>

Fri, Oct 03, 2025 at 04:26:00PM -0700, Sean Christopherson wrote:
> Refactor the guest_memfd selftest to improve test isolation by creating a
> a new guest_memfd for each testcase.  Currently, the test reuses a single
> guest_memfd instance for all testcases, and thus creates dependencies
> between tests, e.g. not truncating folios from the guest_memfd instance
> at the end of a test could lead to unexpected results (see the PUNCH_HOLE
> purging that needs to done by in-flight the NUMA testcases[1]).
> 
> Invoke each test via a macro wrapper to create and close a guest_memfd
> to cut down on the boilerplate copy+paste needed to create a test.
> 
> Link: https://lore.kernel.org/all/20250827175247.83322-10-shivankg@amd.com
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> [...snip...]
> 

Reviewed-by: Lisa Wang <wyihan@google.com>
Tested-by: Lisa Wang <wyihan@google.com>


