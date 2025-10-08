Return-Path: <linux-kernel+bounces-846021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08208BC6CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 00:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46B96344363
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832F2C21EF;
	Wed,  8 Oct 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p63Ul3tv"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2E24DCF9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759962753; cv=none; b=ZhWM5Cqzu/61Bz1WUdohU/mgI6FkCs2FQjJhgyERRLu32QpFsv14BqV+yOZxkRCJ9eUgtrNuWmj74ZjgeiXmeauAYcMKJokTUgvqnU2myxd2q6lVSzCVF/gR+PAbPSRgG5OLxrJYK83D09Z5pqCcl72SgeTjnRXV3XtHudPOEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759962753; c=relaxed/simple;
	bh=QLJvDD80Ts+jq/Te/fByXHFw2lX7qriJtxUTxcdfGYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNYWT9v957j7DvSkLlrVeZVHAY1+ws17y1dPafqUVGk56TGtscC8a751TIfeuu/lvqWlkweaqeOCX1ey076J8jAb37+6oJyK/b34uTGxQr8Ls0QmYaJ0+pbrYgBvl8eU/lcLpy7tbIKusIn05Czh81mIBk0jGqfkS9lvhckbxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p63Ul3tv; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6352a77add0so502976d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759962750; x=1760567550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQg/oGPX3QlPO44vwiPmFn7QHJjEMDGpRp1ZFhGCDj0=;
        b=p63Ul3tvVv7UXIhLQOrEO8Q+8x0ggDdXHHumYvlIk5LVRcGyaEwvb0cdCdRj9dTd79
         xbsmJKRhxeb/WxQAoiiqbhZx4+G0ZEnmL45MA0WsCnEThlskv668oE8OrIgOpV7NuxTd
         jSekOhApeJS2/kn/TnFQ85KWtemB+ptXyuh11P/V5QlgzG5CrcQws9H9g89c+fhCOQ2x
         18v5XsHEm7fkzaRQ5z7RIAuVGJZOZzn5KF+IaYWDFv+3XIRoKYmbF9FRfmfsokCrXw25
         GYqHEjKhyrdYMptloNaIkZpqlM+fUNqysJlNjJ4ALDi8GYeDAUjjYIie7hSBpy9Jw8Us
         ZTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759962750; x=1760567550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQg/oGPX3QlPO44vwiPmFn7QHJjEMDGpRp1ZFhGCDj0=;
        b=OgfsA8ZLR/O5JZv1TR9i1GP5q4E0HG3tZqdFOoCoq10BvQRPLpxonHp7cOZw+NE4mW
         2uxhwo36pYoQBoRh1OQqXEup3AvkHOhZGCljwIK8TgH2q3F7lb5wfaFbdYZNW2DdB0Ym
         4aeLaw+W7umhCZabcY2KyRCUu4zlXoCvS5RiO/XtK1csCHsnbOzU245oBrdKHfcpc4/U
         5aw6W4E0vzbeiwvhNIUx/1u7SZBPzcVGnppXUfNYuBckPaMjWg6nlnz1+wmOa7+FqC8E
         wPPoUObOFRN4wpxNk7IPiKqFHkAJkfCv/3UnNg+irCGmaReKcE2zIkHgcefUTtYbhF3T
         aNWA==
X-Forwarded-Encrypted: i=1; AJvYcCUczkiUYvCe7TvOO/Y1rD8LSlvfX42yOnsx0C25tSj7wZkzpjyTUZML+ECLnK/LSMr8eTo+tK/YadOLQCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wXt5fDdjpTCi8etU/sRZ2StAjB41wGYyg8ZbEVMLjj2UB0VL
	HqNaNe7iazfnTXcqxl+6+z7gEQhFtvkHcQ7fp/BImoiCdVEA7osVQkDfle3tnUbAOkxtsR6xGN9
	P/r70jONgBIS7wifrtqvc9UzIHn6t8Wq2VgKQLN2g
X-Gm-Gg: ASbGnctkOvlc84o7Vrp/D9NoT/a5M0QvQ/Blip3blLpbl+2Kak4fTGDh+JEceL2t/4q
	c11IVZaTjOK9CRU+dRFevOtAR9HOSMYn4BHw99jfw21qPa25I6abVb4WpdbY0B4rltX97fc5f+e
	MZ9/VaFYFajZnrNwloFyyYFPn6oNBRWlZewOrJv6ZEqquKuMnDCs/bjRN7BmBEfX8llT6T0CGTL
	BViY+KBno9Mo7WlJzn4h43cD19IUzDLJOIKcaf9EtC6JKvGyAA7VG8eXj/kegyspFhVzpoIly0H
	KnY=
X-Google-Smtp-Source: AGHT+IHIwhJ1jTa6pSoNA6/xh10XCnJ12TGkOcCTYPDGo29d1Uylhw3j/X7DZaX30WkFO3YvYercS8T1QZ1hYdEvctA=
X-Received: by 2002:a05:690e:1551:20b0:635:4ecf:bdcc with SMTP id
 956f58d0204a3-63ccb964b4bmr4231044d50.46.1759962749615; Wed, 08 Oct 2025
 15:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930172850.598938-1-jthoughton@google.com> <202510041919.LaZWBcDN-lkp@intel.com>
In-Reply-To: <202510041919.LaZWBcDN-lkp@intel.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 8 Oct 2025 15:31:53 -0700
X-Gm-Features: AS18NWACWefjyXnJ3mzO_5c1LrSHUfnzIGfip6tiGf7K_b7r41zRxk-Vv_BIoCI
Message-ID: <CADrL8HXOPOhWXa9o36m5wh-YJyVoMOXyj4R0_7EdUQ6nhJ-avQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: For manual-protect GET_DIRTY_LOG, do not hold
 slots lock
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:33=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hi James,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/James-Houghton/KVM=
-selftests-Add-parallel-KVM_GET_DIRTY_LOG-to-dirty_log_perf_test/20251001-0=
13306
> base:   a6ad54137af92535cfe32e19e5f3bc1bb7dbd383
> patch link:    https://lore.kernel.org/r/20250930172850.598938-1-jthought=
on%40google.com
> patch subject: [PATCH 1/2] KVM: For manual-protect GET_DIRTY_LOG, do not =
hold slots lock
> config: x86_64-randconfig-161-20251004 (https://download.01.org/0day-ci/a=
rchive/20251004/202510041919.LaZWBcDN-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202510041919.LaZWBcDN-lkp@intel.com/
>
> New smatch warnings:
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:2290 kvm_get_dirty_log_protect(=
) error: uninitialized symbol 'flush'.
>
> vim +/flush +2290 arch/x86/kvm/../../../virt/kvm/kvm_main.c
>
> ba0513b5b8ffbcb virt/kvm/kvm_main.c    Mario Smarduch      2015-01-15  22=
55     n =3D kvm_dirty_bitmap_bytes(memslot);
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
56     if (!protect) {
> 2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  22=
57             /*
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
58              * Unlike kvm_get_dirty_log, we never flush, because no flus=
h is
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
59              * needed until KVM_CLEAR_DIRTY_LOG.  There is some code
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
60              * duplication between this function and kvm_get_dirty_log, =
but
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
61              * hopefully all architecture transition to
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
62              * kvm_get_dirty_log_protect and kvm_get_dirty_log can be
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
63              * eliminated.
> 2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  22=
64              */
> 2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  22=
65             dirty_bitmap_buffer =3D dirty_bitmap;
> 2a31b9db153530d virt/kvm/kvm_main.c    Paolo Bonzini       2018-10-23  22=
66     } else {
> 82fb1294f7ad3ee virt/kvm/kvm_main.c    James Houghton      2025-09-30  22=
67             bool flush;
>
> flush needs to be initialized to false.

I'll fix this and the other bug about not documenting the new
parameter, my mistake. :(

I think in a v2 I'll also merge kvm_get_dirty_log() into
kvm_get_dirty_log_protect(); might as well.

