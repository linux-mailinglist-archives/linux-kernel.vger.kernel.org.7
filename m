Return-Path: <linux-kernel+bounces-821556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC346B819F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F27483783
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BA30C107;
	Wed, 17 Sep 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KHRqYDHY"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA502FE565
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137243; cv=none; b=dgbZ7JPjdcCpRW/bJU44b15UpwJwL+gyApHsDc9RY9Y7ljP5ioLX6wNqfm0ZCCoOspF1FDGcJ4ZfB/z8pQBEGZ57brAX2Cfeq3IgNc+w8T3xp8nVo2wih/prQa9CCz5rxGoGIXtLIW/OExyPWnm5UsnVWaAZa+GVBTd6bGcwcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137243; c=relaxed/simple;
	bh=/lGQoGWo1oVLwX+ZWr0MhUsLDCckySpD+6GSOcPwfpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLwj8Eogus2+/DK3pQSDAKz+uJZ1etFUI4D7FC9eHuAQKUEjMTDKNX64CprWWNXQ1mdJhUi5LfVAF4jBvg++oa51wmat3ko7OTjiUfwVRbeTYHLa6HgtSPELtuYwHCr+Tmsuf1hdOXjfZXzKFxXjxoY9gUQW4UrOUs7JwN8Vtzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KHRqYDHY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-791fd6bffbaso2089436d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758137241; x=1758742041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZVlkWCCuCYTghm7E9xutK12OPPCXr3fuw+E/JSa8+A=;
        b=KHRqYDHYtyUGQisErqVYykGsn+garGU16lwox/bjuVgxUfYczzXujSAa0tjA0X7QBI
         BR8bIe77Eu/EeYi/BOPwvRbQlsdLGJoESFnRoTcJQsizJUwYLIyOezaldoqCWqII2QJo
         7RdkDVZTbX913WHziZIs8D1emxgfZ3v3BTKsG4TE63Emos9IVZY3YdBP0K1xSo0Gf8Mj
         dZvwjK2ZEaOJYWXK8/HjuNjUYHQEJ4g1EFRABRcizdtlDwpljsEvIv46N5fC/6D1XLcm
         HlNrf5x2aat4ivhduvx/hxNdrigSArsqf7FAhx13WH4p5CniQgThqTCjg8WonNuDvGcA
         XRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137241; x=1758742041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZVlkWCCuCYTghm7E9xutK12OPPCXr3fuw+E/JSa8+A=;
        b=t8ORwE1OvCXjHEPGtFfjKRI4gT75NO3rK1ayB85WKTckP7xPC12KVrW2NZaHnD33Xa
         MnpvxjM+uNMgIbWoQCytZuORkMG37Tv4yKvzTjUR2hrtMIe1Mkque2jFNJHwEzQe/YyY
         2Gl8QkFqo7g+esRMCsbdY4T7UP3ig8uQvPbENDaZRnVA3ehPS/vK19rjUJ2QKSgo99Ls
         CdeQxPf3CXVvcj12mhR+IGXWYv31tTSNKw57Kmw6HZgDQr02FOBhQ/FzUBzX2Z4q72av
         xuoPCDaQceBajbwhMXmovXKtHFvCQ/65/rZX0onODM7ZyaKvA5RcDh1LoTdOumath07L
         KAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQx0vvfFgxTLDS9WlAfom7rCJW7OUjnQLQTn1V12tCoYChq1janz7qgTHYJL23ZZl5hKGcrdk6U/Aj/Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWM7UUtOg6A9lrUbvk4FF/C0SlGnvK5P713yDhwIx6C3QngUk
	/PKR7cI1NkOjC3xeoG+UndT6+eFrMRHnmMI65b9SxPw6LlX+0D3/GQHkU0U1OdvLZbY=
X-Gm-Gg: ASbGncsFy/A+M/KmJ6y8L5TJ6Zixx9zhT1ndp9YNQIRnlMpFehni+4KM6K09m3gmvGs
	b5FewrqEE/oNNulpDdmqyOxlxtZq9K3lCIA4MkV8PiRg24XdbAE4VejaWbN4I67ZF0BodpXnaX7
	TbC1cL0mZTRzjT8h0vapi9IK2oZXaAO+0oLmixqh46r2aDLFymfoP5e9Y2Kpwf0I5kq7U6nSIyv
	Hn19hfjlQU01tvbYpjW/K7SlcqxUy6uYUTb1nK6GwAfsBiEANtvi5NiS/0Q2LO/2bZXmD7Edac5
	+JKTWRSXm6TF0njdnDLLuZhu6eUElcBswzIyG19BjL/cueoZ4YAJM3YIPur1EhsEAIRR/auwtI8
	3/Q3uOzSbsLy1EhavuElUf3UdyQyJmbDKOhEMlUFycZHZVYBoMNnbAO16BIg8K13/LBHwg0jU0S
	PnY9hxrf+LK/FXcl79O5cKHQ==
X-Google-Smtp-Source: AGHT+IGM3xhmzXDRFrNe6F6REL+f8AdNqllu9mwFuh9hgnJJGII/zf5nl5KF8jaDrmx00pWc9hQPkQ==
X-Received: by 2002:a05:6214:1d23:b0:711:4042:9484 with SMTP id 6a1803df08f44-78ece45eb76mr37540046d6.35.1758137240831;
        Wed, 17 Sep 2025 12:27:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793543ffae5sm903096d6.53.2025.09.17.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:27:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyxoF-00000008n2r-3JSd;
	Wed, 17 Sep 2025 16:27:19 -0300
Date: Wed, 17 Sep 2025 16:27:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 0/3] Move io-pgtable-arm selftest to KUnit
Message-ID: <20250917192719.GJ1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-1-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:37PM +0000, Mostafa Saleh wrote:
> --------
> - With CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
>   It will automatically run at boot as before this patch series.

I would drop this kconfig, kunit does everything required including
run at boot if you want.

> - Otherwise with CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=m:
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

Suggest to include the above instruction in the commit message adding
the kunit so at least it is in the history

Jason

