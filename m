Return-Path: <linux-kernel+bounces-774632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6877BB2B549
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6503A2A3313
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906075FDA7;
	Tue, 19 Aug 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DicVXpmg"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9213596D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562856; cv=none; b=R+ThF/NT8P+vZMrCBjB9VztTt6irNHEVuHezQfnuVWpxcqZzElJN4auQM7wgd72UYEJnP2WrvFvIo1iheA7zqeoJ+LGyEVe6XzP9rOVSMuUrGIjTFKyY3xqQAXL908IWksdcCuNPPfPrfz4CpKiiSthvuGGPt5SAE/EHdbTklBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562856; c=relaxed/simple;
	bh=atJmxdGeijGiXSExn+ZNLici/r4lWKBuniPkNBYv9iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFDPUOXz+r0sJ0rf28l3ctKXhu/ndOftPCt/LPJauRsj/UCRt7ioO7WJWVZLH/TJJ6OeBsFbZ7NFkgTIPdzGQ6N3ACnIx2IeY/jOmOw2jg87oFt3qkfxbu3X8Tx356GvVpE197QkXfryvk1sLldhR3PNoVvqYFL8Qut188tBbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DicVXpmg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70a928ffd37so51080736d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755562853; x=1756167653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwm+TVO3IE31QnUKkVxKkaPevhmZdZk1VLFBsWnyn6o=;
        b=DicVXpmgkTQZjFi9nytWca1uPxFD0adbDO0MbcUZDIh+QxBPVHXnGnm5jSYJBx3rjz
         Xp4UFOB/mVd4gKDdr7l72RMeYBWSHR/MjfTL3JMMf6g1+VAZl5UJKat62zj3FQoar+LC
         EnG5WvUcOM+XHq6kx7BgWtR39XOzx9in4x9MX3qijuFuAeHWt/OFrTGDNAdKA50TOmYK
         4Hmel5GIQIQYbtgBRoVFediUGzHtdzQrOnHr2/PjnSvZCjowS+MWKlHiTdUKH3ZwVls0
         pCU3jefQzPwc3iKuS3MsQldYagbFCHxQ9pn+MHvm/RNBqY1pLPqwy4l0W09c1DiFr5CA
         C6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755562853; x=1756167653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwm+TVO3IE31QnUKkVxKkaPevhmZdZk1VLFBsWnyn6o=;
        b=eSk4TSS59vAr4EgwILSwt4eZU6NbE7qCjtuA6xhCMoEzJ3Fthv9pgh3mYu5mZi2vrz
         Qvwk8NeMD2y7qY1MiTpLQuDDxU/oXpSxCAu9iEmQEcXPT7zwKgw5zY2z57HxoCd+AyWE
         Pw/ue/7PUgVXof0POXNKU9c75JbE9RA/cYpItivjwNKxTVSorEP7vXtW97OjudtE5zrL
         JdgkXtYnoUfDy2A5PHfKXKQNROez/jmyWHI/8+eGp89M44QsKycJOQoHXStKhUwwDGgQ
         uSQelolHkrWLdNccLZGMLIisNZHv59Nh08YwnJ0UKZRzSl+DVoRLfwEl5+hYeyhjcv1w
         PAPA==
X-Forwarded-Encrypted: i=1; AJvYcCVCZcM8KsCEdY2kXHaAlZBvnfLEb8okBiXmC1TiUGeoZVUGTPC04SCJP3zISuURd1saEYHljf7wLJpiziM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrideoP8xLqIXoAIxSvopRyyjiAh6n/wpFDsH5lHUfK+tMDmJ
	3gNCaG5z4/I5yPJBUrUDnX/4Cga5dqeXRT2CS13KBd/bcmbUeOxnJ5190KxUzYhHyA0=
X-Gm-Gg: ASbGncsOjbgi1QbSm1akZh5ECzVkO/Q16KaSG5DFpsMQwKaByMj/srcsIP+WPVBdfK4
	NBB5u1ncVk5Ye43AfGbqYBud29+UK3EiNZEud/URyejp1xIn9G77fpVWtbjHVVrhNcvDvIreXlV
	TXahqVEyYuItiBkWWKfUUqQ9R1JywzD/SWi8LwL0Xshzj2xFS/xM+fQErI7vGbd/pV5VBpLeYsk
	LpuGTjFIee0lFnYon5XA4Ho7U40bR9/EhnMlxxgtj2UbkopmgUtfpzQaQziUGeeq5nKD68O2jyR
	qa6qbNk8+iwBd6RWk2l0LKNrfBX/Lo3IKmN5gPX7y/HZ/SnxEyzl4VhY/Ss0wSvBXcad0Up0gn4
	UwJyoBvMsX2DNjVcbdruQuBc=
X-Google-Smtp-Source: AGHT+IGUgrllTL7Y8fMaxyBiG7OjFs5eQq62OO4Qg66bHPzC0RUUqBKv3WgzNhUUD2BQ4eiTpGJ75A==
X-Received: by 2002:a05:6214:2b0f:b0:707:7694:4604 with SMTP id 6a1803df08f44-70c2b6f4f67mr8160386d6.30.1755562853487;
        Mon, 18 Aug 2025 17:20:53 -0700 (PDT)
Received: from localhost ([173.23.183.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba92f89e7sm60632856d6.45.2025.08.18.17.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:20:53 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:20:52 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: dayss1224@gmail.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 0/3] KVM: riscv: selftests: Enable supported test cases
Message-ID: <20250818-be8ccd84eebf62dafa95caa3@orel>
References: <cover.1754308799.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754308799.git.dayss1224@gmail.com>

On Thu, Aug 07, 2025 at 10:59:27PM +0800, dayss1224@gmail.com wrote:
> From: Dong Yang <dayss1224@gmail.com>
> 
> Add supported KVM test cases and fix the compilation dependencies.
> ---
> Changes in v2:
> - Delete some repeat KVM test cases on riscv
> - Add missing headers to fix the build for new RISC-V KVM selftests
> 
> Dong Yang (1):
>   KVM: riscv: selftests: Add missing headers for new testcases
> 
> Quan Zhou (2):
>   KVM: riscv: selftests: Add common supported test cases
>   KVM: riscv: selftests: Use the existing RISCV_FENCE macro in
>     `rseq-riscv.h`
> 
>  tools/testing/selftests/kvm/Makefile.kvm              | 6 ++++++
>  tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
>  tools/testing/selftests/rseq/rseq-riscv.h             | 3 +--
>  3 files changed, 9 insertions(+), 2 deletions(-)
>

The two fix patches need to come before the Makefile patch in order to
avoid breaking the build.

Thanks,
drew

