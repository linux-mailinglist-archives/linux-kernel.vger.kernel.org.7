Return-Path: <linux-kernel+bounces-829410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE6B97067
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6334318A63C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732827F74C;
	Tue, 23 Sep 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FAqaVTnB"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81427F017
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648507; cv=none; b=Yoy+G/tA1A42nCfesSUKyTxwNM31SgQ6up3ycCExAlrQi8HukaZrnnSmafvQBQ905GWNs1S7WHRBvJGrImHW4j2H8/sbtaYNbIr4pgvJbiWk6DMQgLWwcfi3iqa1RzaNYPcZxN+55L+BCYo94zGOWi6rEIV14hs9wl7EYpimzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648507; c=relaxed/simple;
	bh=rm0zpamzSlH4DEq0dUlATfwUA9MF2ck42Ac1m4noXSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZuye3QutyMqUtkuhoERDOucMG49cKmc4WpLLeFHEbHvczewh0lEPUid2RMzqqLKGTYq2l/9JhBqFhsAW5Q9YDdMtMYkcgBmkPPCkB391gNVj2Udr+UiRpu273Hz3PsCDcU3ykZ9jjEOZNT0g+SV18NluodsY4ZgAwV+cHCwQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FAqaVTnB; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74526ca7d64so6128853a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758648504; x=1759253304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u6dWZkUtEIhCKSzVnN43oxLxMyj4Y+53RYCJvMVElVY=;
        b=FAqaVTnB0jhDAh6TIkIw/xwU4TX/WaqN90LWExfRVq5ZW5aXQ6xPgxSXjIEd+iB3uc
         pRmN+fcx+7AC3oVGRCAfikXjUVuDjD44i5OWKdGRGBWH5FHsuKKHYDUQeAzMuT42ntap
         RGURWVDPztS3LTYd5dl+Ze1anaORrqiHWZSRXvLXv7qiex90JoWrjYoZ5MQdfKl6mOjN
         nbT981JyImz6li+7B6exz2RepB3mRhmQ1MMi3oR+J56wznQj562ACjeCKlydEN4KW7Wc
         n740ugbn2pbPJSwl59xEmYyHMYKKR7Bz1/0w4aLBiAFrbjMt+aC8o8p8GkU4qzoIPbkS
         ytiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648504; x=1759253304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6dWZkUtEIhCKSzVnN43oxLxMyj4Y+53RYCJvMVElVY=;
        b=ngGQV2g8ah73AatnWnly6mYN9060tyatnjPuOTOQqmUQ14K3A+xyCAAVCBa6qU29/X
         Hr5UDv3J7THnMFWjUu2pNKR07C3abLuC4vR4NTyF0JScsLHyrXgR9JuXc2q9zFUGbpym
         vJZw5Ua4MdX/CcLptnr0BVcqRejVZghx/PHll2Uhzk97XKruuy70AQcLToufz0y/fI0z
         VyjyMfAcux9kQtwA+/ffVLjzYTWl6SOU6U7/W/3eKBLT7L+Ca/8g7AuPUF405IFKQkan
         FfSaGgKR6rx/K0eFTod78G5DEnG8e1SdNfKth0FjCyJ3oGAE5+ne48rLNHlAr3CsRAOm
         noXA==
X-Forwarded-Encrypted: i=1; AJvYcCXNne96NVITwOPsBGcExRtkKJOJ7khjXnxbKlhZ+smw4n8FS1uIidcacaZMF8nszWtRV/QRuBCR5FNIoRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8gkFNQTlc3yuOksCi7hK0lSs0BKUUw2vmsvYJ4XGCLxs/gmWS
	v03QPuqCLsbVuR8s2kiK005SBKTWBoKrPG8UtEv1OZHMlRmY/BQEbp8//0/Cl8HVhq4=
X-Gm-Gg: ASbGncseuI5/8KLtlhYvB/WpV6+jPAAJ8q/VRLfYzzILOZRmsdfDbs06ip6HhBesONc
	ivdKGWiPebYuK/Z3ctdxBzk22e+PUhJf0Yz/fWk1ayZ+OO6xo/khaeewqvfCvhTiB5guZsA3lIX
	CrVisJGBCLuStizm/jtlRQT8OX5kIZYjM6qFZhZoKdvr3eLBnwMGOy7stAcFon7XbsKAusCOvTP
	8KaKGbcRYRMwyPYbVfh2ev1nCrmxWHRL4VbMkdWYbArn8NFcrjEvDq8mUPssFP3GTamrDoyjAuW
	8KOeZjGkpFJYxXIGjW2GuauIQnv5pcEeL1ThxafJhaLw70443KAeCT0UtlO+KAS5qxAI90KrXmd
	b9cc76LY=
X-Google-Smtp-Source: AGHT+IEhJoh9bfS3LwRMvAxSN3OC81t2mQJ9E+F0hth3IE2HHSqVNFy7roXE+4egOcnXUsNFA2Ldjw==
X-Received: by 2002:a05:6830:d84:b0:789:6393:5c49 with SMTP id 46e09a7af769-79154e16ffcmr2637994a34.25.1758648504424;
        Tue, 23 Sep 2025 10:28:24 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-636811d34e7sm48621eaf.22.2025.09.23.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:28:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v16oQ-0000000AyOX-3yTq;
	Tue, 23 Sep 2025 14:28:22 -0300
Date: Tue, 23 Sep 2025 14:28:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: prevent use of uninitialized variable
Message-ID: <20250923172822.GD2547959@ziepe.ca>
References: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923150108.34309-1-alessandro.zanni87@gmail.com>

On Tue, Sep 23, 2025 at 05:01:06PM +0200, Alessandro Zanni wrote:
> Fix to avoid the usage of the `res` variable uninitialized in the
> following macro expansions.
> 
> It solves the following warning:
> In function ‘iommufd_viommu_vdevice_alloc’,
>   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>   760 |   if (!(__exp _t __seen)) { \
>       |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>       |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>       |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>  2924 |   test_cmd_trigger_vevents(dev_id, 3);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think it should be like this?

@@ -1042,15 +1042,12 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
                        .dev_id = dev_id,
                },
        };
-       int ret;
 
-       while (nvevents--) {
-               ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
-                           &trigger_vevent_cmd);
-               if (ret < 0)
+       while (nvevents--)
+               if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
+                         &trigger_vevent_cmd))
                        return -1;
-       }
-       return ret;
+       return 0;
 }

And add a fixes line?

Jason

