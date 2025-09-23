Return-Path: <linux-kernel+bounces-829568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904EB975C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B802E830F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FBB2749C1;
	Tue, 23 Sep 2025 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ukmcn1ym"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A196213E9F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656101; cv=none; b=cUgH5PB2DR9CptUeihSMMmIY6/w2dlhH+HYVAe3Th7WY4tTDq7RQ1sOS+EM3V1EnKlRNZobw81tBe+gELf+q9J5fZYagPzWP2g2Lnkoo2Eku2TfZ/NlmYS8PtSrvgkR/MycwBifBRoFXjJ5gTZih9JlZY6zZ7pX4My4ayCfRwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656101; c=relaxed/simple;
	bh=VfBc75bYAIYd21aYLblJNcbN6t+rYn1Prdaa+EetOCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3TseaKEAT4UDUc362OZ9F11CYWEIDuOtjGMovFHoKp0VpSBgNWTDRFzELJfiDTdDv+iXtka8UPsTS4xgHGhQKaZQ2Qk6F7o0jVauGw7uJRpTxx8K6OnhffrJOPXRJmcsCe3626gPFQ3Imn1eiKVbG4yBaOzKHyGY+RV+JpzHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ukmcn1ym; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2699ed6d473so45965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758656099; x=1759260899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zewo0mhIoTcxNO/9A7yjzXwrm/KIOI+nyjxjOFoxQhU=;
        b=Ukmcn1ymJBZPMmT9t3oJ+pPLmZ7p3mhHE5IPGWhEVeIE2ZbGCaPACUB4nWpn0KtR1r
         EXMu8h9N1si+YzEMShkN2rD0axbJdqU/WBr4LC4NQi15bc6ueLCeASw4MIChTCPW1ueD
         r2Y56IzQ9I0NgiG81cMhztWPucMqvzJJOiZeXAQMfK31XDqx0R0eWzmYT1PSTlKbQIvc
         eN0Y/zW5OIniQdigl3+x3LczPgkKyzblCBPU1/sojYlzNAfzfmxmxcnr5h23+aluW1ke
         cfStwRiLFbRQOfiHJXiBSHJQjNgiEFLmvDvZpRh+qK3tPjIkJ9Wuj7BYh4D8QQmILLW0
         EGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656099; x=1759260899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zewo0mhIoTcxNO/9A7yjzXwrm/KIOI+nyjxjOFoxQhU=;
        b=ApNEphx+/Xege9UD2mtILADn+LfzZlVnxlrJA/NxVEg9iigYIGc5AgamkQ1dlMjpxA
         +JCmQCJGBn2JzG+tRYCLwfWlWrFEX25uxje3C13ThYj3rNBJtzHjX2cE2g6rtPsGIcTv
         9P3Gj1W4LGqaK1DpxZzHyj0hKF3Xpzn9GyZ+IwK/JL8d0mBRddrGFWlu2tnxpvVUgSfY
         dESMaZ/UVSDWRNIWnC03lTBNXNLAu71D1ayTw9evd9/TEAeUX2y/g6TFfFmCNXO4ghGL
         of1OH/+Lo6sPBimS2hjmVCOR4cFPWq32+08GiKnyFFu9+rdrBAmL/SKsmfHnd9WbBCY2
         spkg==
X-Forwarded-Encrypted: i=1; AJvYcCWJf5Lb3RIWrc2JecEfS7yuolpw96m8m4SEPdm+mkm8HSz3Httygx3GzhFXHNpTmBZyKHpqewY8byrTbpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcFHRbp/smHIrFnDySRQqSSACBhmNqkNe7Vz2oDT4DSFsjbEp
	EHA+RVbpxnfJ5WcKz8BO5jtE76CigZkyz8vV32H7ilhcRs6NxgK+8vfFIeyrDItKtw==
X-Gm-Gg: ASbGncvXQAYZoKE0F3SxWao+HrSUYD+BzpKfd5KXOVa/ONHBWMhphFFfxTZ/C+YLn41
	mi8pWWHha8u6kQK/C/P2KC2OETRTHmKpL808mj+/77tZdXBqui/zxod/1Ht7WlJWxOemLXb++Wa
	TqEBtPsseNAQQlKMkw2A2xGxS1VCv4oRQ7E/5aTiB2gulVsjgBp/wVCo1zrmpYBUG3IalDbVJg8
	6WiBEHrM8tAb0ZGlxeiOEIKUN4AZ+fLx5qHOZ5a1gWTtV2W8l6NkTqYqlaAAT2cxWjhs33Zxu78
	Vrb/Ilimluot63Vnew5QXQY1F5mI/Jz6Q1R2+XUU3K9LFKdDlEeDx8vnDw9I6JCp4QbhaVHLCrF
	KfPB0RZXGdTn2IHl8vHuIAmzdh6GCxeGada5UzdbLkKMeQJIpBgQ4DrUnA2+Fva0=
X-Google-Smtp-Source: AGHT+IGcLnWCz9d4nYxuf65Ty9MkZA/5wp1lFrLjgKZSwPv3qhQduS9rYWSQL1OpaLq3vwTFgQJI9A==
X-Received: by 2002:a17:902:da90:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-27ebf19022amr701305ad.13.1758656098489;
        Tue, 23 Sep 2025 12:34:58 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c2e1sm170372665ad.128.2025.09.23.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:34:57 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:34:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <aNL2XFd4Mb_dvaMy@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-5-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:28AM +0000, Mostafa Saleh wrote:
> Integrate the selftests as part of kunit.
> 
> Now instead of the test only being run at boot, it can run:
> 
> - With CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST=y
>   It will automatically run at boot as before.
> 
> - Otherwise with CONFIG_IOMMU_IO_PGTABLE_KUNIT_TEST=m:
>   1) on module load:
>      Once the module load the self test will run
>      # modprobe io-pgtable-arm-selftests
> 
>   2) debugfs
>      With CONFIG_KUNIT_DEBUGFS=y You can run the test with
>      # echo 1 > /sys/kernel/debug/kunit/io-pgtable-arm-test/run
> 
>   3) Using kunit.py
>      You can also use the helper script which uses Qemu in the background
> 
>      # ./tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 \
>        --make_options LLVM=1 --kunitconfig ./kunit/kunitconfig
>       [18:01:09] ============= io-pgtable-arm-test (1 subtest) ==============
>       [18:01:09] [PASSED] arm_lpae_do_selftests
>       [18:01:09] =============== [PASSED] io-pgtable-arm-test ===============
>       [18:01:09] ============================================================
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    | 11 ++--
>  drivers/iommu/Makefile                   |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 82 +++++++++++++-----------
>  3 files changed, 51 insertions(+), 44 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Moving the io-pgtable selftests out of the main driver code and
the integration with the KUnit framework looks good to me.

I was able to apply, build and test the series with multiple configs on
QEMU virt. 

   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 40 OAS 44
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 42 OAS 44
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 44 OAS 44
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 32 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 36 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 40 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 42 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 44 OAS 48
   # arm_lpae_do_selftests: selftest: pgsize_bitmap 0x20010000, IAS 48 OAS 48
   # arm_lpae_do_selftests: selftest: completed with 63 PASS 0 FAIL
   ok 1 arm_lpae_do_selftests
 ok 1 io-pgtable-arm-test

Thanks,
Praan

