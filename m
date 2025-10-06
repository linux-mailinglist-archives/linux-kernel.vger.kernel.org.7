Return-Path: <linux-kernel+bounces-842641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE8BBBD375
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605EC3B45BB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE24E257820;
	Mon,  6 Oct 2025 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x76G3bbJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB014F125
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736001; cv=none; b=j5eRG+TQJfd9ERcx/Zvsen3LwV7nAt2/CYGsWeZPdH/Y+m4ui2In1MARbbiaIjK3kSBYgFfFsSXWl3OI0nf6XJ93QjPF7Ke1meUQ0TwJ1zAxyTknHfmsGv2K3SK4u5xNnmYRP/DPNy0esBfcVU5W2lWmCN86fekuwveDHe0OAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736001; c=relaxed/simple;
	bh=SZzGHvqd25HlgCSKTD0VdSNQ1UMIgyKDNBEAI3lCnbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r60GL1Rb+eVgKs4p9FM0o8FhgybWtP4PaaA9t+ZWwXi8pxP6ua2l3dgV9Odtn3mgxc5/j5shwypK5zS7NT0Dy58hWQYQu9K6Z4MaYgAJrpui3vc4oBYYAtS1+NxSNvgpj770W17jesBz0IP6c/hsH46ThbJeR+R1hguKNg3jjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x76G3bbJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e52279279so29028365e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759735998; x=1760340798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3ZEr2d7pwTIHaluHUG7JQgfUgOPLmXul/6qgxWDE8g=;
        b=x76G3bbJJU9UulOBMq1iVa2xP4AQ37YYUOpeq1mPs6YeTrMyz/dIp0RM14ATLjUc9e
         MwAKw19Zf1dVPlMMY8i5B/og3vN+nleo/NVGOTyQ+CjZCAKG0MeNc5YtGc11ahDsHPhH
         i58LkRy/SxRXDqq7rEdoOw3tY5M9OJQAh40X6PH7fOa6TTsalvkYrcCQvWSOol5J8hY8
         vsuoe3wxQoddbcaM43aZ7GjSxHZbrbWal+cwgFXG+rP41YmnGhOqqjNnZ1Iv9PWuAPgb
         jcQajjwKcJawsIobNJj5QFuCY1LUuFrOhsQakaP2mRITdnyUngCvcB0c9c+5lRjXJPRi
         BMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759735998; x=1760340798;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3ZEr2d7pwTIHaluHUG7JQgfUgOPLmXul/6qgxWDE8g=;
        b=fI+GDrq1KRvddcA3ZGbdqbKe9QygH4bKXnsTwscvZ3iJnw/M8pJebtz+aglKd8FOV9
         3mFejdbnV8hm4qEY4ztQLjpujzXWeSqxjhwIqJmczFt/CyuU6AnocCAqHmhxBU2PMjzu
         ukw75sOg/vwNSJsXAmLJHTOoIDSsY5sFaNOkLfHE/ldW4nJGLTS5+4iyIMV0k4v5Bd7U
         bd3J95AIa49lgwi66AP913T2pxxM8hNbNUDnF9RSRhqkvRhLwjY2/aH+O2DOdqPrlEM1
         mz9UvmhfdHMTY25z0H8T4OTRTif4E0ud+gk9ZzMVzei4QrHkMRRAGgYQrCjDvaFYdTua
         /xQA==
X-Forwarded-Encrypted: i=1; AJvYcCWW06XN4aGyVfV7IwF2qgktlwoojsBfLtBMgCLBwvxcKE5xeZGvR+6v4O90+5+tSwbySSH755T4rjhqxac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGovMdUiIMTCtpN6lb1NyGoyaqeRq9Q/41SUuvHSC7NdRl2Hy
	Cnn7QsgHm0QRAwwYEhTx5UYj9t/WCQNdVR0ZcvSVhoyZQ0w9KJRalncApuQc7ZH9+CI=
X-Gm-Gg: ASbGncupTrgOOUDgbici5zu9N57n6gJtGKpuTEmqEbMvw0jEfncckY8aBsbGif9RuXf
	iwqNI0Y4o/p2KmeK6Z3nTl6vXxeR5kz+BL8Gtp+bVc/JXs3g1Z9HM8TLExQL2AQhaDAchcEjdtO
	PWJfUd0CRs9vB76R2HCPwzvCMyWCdW5IKbc5VovIJnKNWdkPvsb1Ub9X8CcBq3tNDX4QdK1Sqbb
	OvTMaYiFpkfKwnQtHN3qploicFEfBW5c0f9c+OvJD7VplBK8rP9bHLRKyj4ISloCJ3LgSOlzZND
	JACrHYXWnZbQ7XJWwShxX/Ad4kFcfAmjNxp/RtvucBdyaPOYLLpukcBmgznuZTGqjzyleZ3Q6jz
	MbQ3IqKp+LRsBXu2ch1RPDEBMhMY1H2vyeteHCVcxDh7x0F586WjgEVHDQ/kaUxVH0OU=
X-Google-Smtp-Source: AGHT+IEY3Vdz6DSENDPXWHaU3Pw3qJ2jmGm2AQUbIDp0HgmMLAwC9lJKK+vWRw7LBtZ3XAYcVnYPJQ==
X-Received: by 2002:a05:600c:3149:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-46e7114829cmr64921245e9.32.1759735998124;
        Mon, 06 Oct 2025 00:33:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e619b8507sm243679325e9.3.2025.10.06.00.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:33:17 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:33:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, James Houghton <jthoughton@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: For manual-protect GET_DIRTY_LOG, do not hold
 slots lock
Message-ID: <202510041919.LaZWBcDN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930172850.598938-1-jthoughton@google.com>

Hi James,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/James-Houghton/KVM-selftests-Add-parallel-KVM_GET_DIRTY_LOG-to-dirty_log_perf_test/20251001-013306
base:   a6ad54137af92535cfe32e19e5f3bc1bb7dbd383
patch link:    https://lore.kernel.org/r/20250930172850.598938-1-jthoughton%40google.com
patch subject: [PATCH 1/2] KVM: For manual-protect GET_DIRTY_LOG, do not hold slots lock
config: x86_64-randconfig-161-20251004 (https://download.01.org/0day-ci/archive/20251004/202510041919.LaZWBcDN-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510041919.LaZWBcDN-lkp@intel.com/

New smatch warnings:
arch/x86/kvm/../../../virt/kvm/kvm_main.c:2290 kvm_get_dirty_log_protect() error: uninitialized symbol 'flush'.

vim +/flush +2290 arch/x86/kvm/../../../virt/kvm/kvm_main.c

ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2255  	n = kvm_dirty_bitmap_bytes(memslot);
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2256  	if (!protect) {
2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  2257  		/*
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2258  		 * Unlike kvm_get_dirty_log, we never flush, because no flush is
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2259  		 * needed until KVM_CLEAR_DIRTY_LOG.  There is some code
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2260  		 * duplication between this function and kvm_get_dirty_log, but
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2261  		 * hopefully all architecture transition to
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2262  		 * kvm_get_dirty_log_protect and kvm_get_dirty_log can be
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2263  		 * eliminated.
2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  2264  		 */
2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  2265  		dirty_bitmap_buffer = dirty_bitmap;
2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  2266  	} else {
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2267  		bool flush;

flush needs to be initialized to false.

82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2268  
03133347b4452ef virt/kvm/kvm_main.c    Claudio Imbrenda    2018-04-30  2269  		dirty_bitmap_buffer = kvm_second_dirty_bitmap(memslot);
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2270  		memset(dirty_bitmap_buffer, 0, n);
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2271  
531810caa9f4bc9 virt/kvm/kvm_main.c    Ben Gardon          2021-02-02  2272  		KVM_MMU_LOCK(kvm);
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2273  		for (i = 0; i < n / sizeof(long); i++) {
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2274  			unsigned long mask;
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2275  			gfn_t offset;
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2276  
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2277  			if (!dirty_bitmap[i])
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2278  				continue;
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2279  
0dff084607bd555 virt/kvm/kvm_main.c    Sean Christopherson 2020-02-18  2280  			flush = true;
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2281  			mask = xchg(&dirty_bitmap[i], 0);
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2282  			dirty_bitmap_buffer[i] = mask;
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2283  
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2284  			offset = i * BITS_PER_LONG;
58d2930f4ee335a virt/kvm/kvm_main.c    Takuya Yoshikawa    2015-03-17  2285  			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
58d2930f4ee335a virt/kvm/kvm_main.c    Takuya Yoshikawa    2015-03-17  2286  								offset, mask);
58d2930f4ee335a virt/kvm/kvm_main.c    Takuya Yoshikawa    2015-03-17  2287  		}
531810caa9f4bc9 virt/kvm/kvm_main.c    Ben Gardon          2021-02-02  2288  		KVM_MMU_UNLOCK(kvm);
2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  2289  
0dff084607bd555 virt/kvm/kvm_main.c    Sean Christopherson 2020-02-18 @2290  		if (flush)

Either uninitialized or true.  Never false.

619b5072443c05c virt/kvm/kvm_main.c    David Matlack       2023-08-11  2291  			kvm_flush_remote_tlbs_memslot(kvm, memslot);
82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  2292  	}
0dff084607bd555 virt/kvm/kvm_main.c    Sean Christopherson 2020-02-18  2293  
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2294  	if (copy_to_user(log->dirty_bitmap, dirty_bitmap_buffer, n))
58d6db349172786 virt/kvm/kvm_main.c    Markus Elfring      2017-01-22  2295  		return -EFAULT;
58d6db349172786 virt/kvm/kvm_main.c    Markus Elfring      2017-01-22  2296  	return 0;
ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  2297  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


