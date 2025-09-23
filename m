Return-Path: <linux-kernel+bounces-829666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559CB97971
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AEB320E58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261130CB41;
	Tue, 23 Sep 2025 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmFNjcKz"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534932741C9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663501; cv=none; b=jGIzV1euLH/IAr733XuT1eenMbuHZM7cXaTbyLwVwh5TS2C+FT3ieKYiIYdmQcUW0aeKtArlfRgrAKl2qh6nHuSSqNDS/+XFROWcLcUsjI7Qb/fv7Qqqh2Itff34/y7glAfRdaxUFL62lLefr3Ts/dzdpMRAV7dCDMNd6nQt/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663501; c=relaxed/simple;
	bh=0+sTDOXCBKnKH/E8c0etG8KcxzezgfK+5x0cwjx0dXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d53lvSzqz15WdEyPn8obg9mEJu76gPGs1Hdyin/Z81aHc7wcfcsZQkF4HJbzKsvc2PuyWyLur+6MdQrw3qh1i97f4u025rvALDPevHGmIbjPqLYVifXweEdXIrQhhZX+BGc2Gz3UoSjEMnrUEBC2IBg9Rjc8a7FNwX6mOIrjnfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmFNjcKz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b256c8ca246so868661366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758663497; x=1759268297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DjUCuu3OWodmRQYhhBu9wo7DG2M9yDqPmVSCIb0J94s=;
        b=MmFNjcKz0tUCS1PBrTDugQekTj6OehYnhNXQzSY6YaSdffgYW7begB/0ph9/9sDUPO
         dW6K7bTOCuxdvIhZqLLMGu0R0+S88Rk5LbfPqpdq+5BCasZwQXgma1+Kd8xCbpubBFmK
         uYApODTks1LlI1b8W7DnM9vlyS3/dq9tpFV/HMQDJ0+9zSdpnvnhZ7T0o6m89VEW5mSu
         Pq8wuNNaU/zmpL007lkCzuKh8a7WR3dcUj/v8xfG7wEBe7AFr0K0nbesU24j/qErsj3g
         1176Hp2e+assgZzO+xYE3RqRgbjC7/12tOfnT92rhJyrYaBUCeI1o6/h6SMC1ao0LPkB
         Wr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758663497; x=1759268297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjUCuu3OWodmRQYhhBu9wo7DG2M9yDqPmVSCIb0J94s=;
        b=OMKiqqhmLM07h67rGmtA/WKTSOCVzs1Ffg3uP1UMLhHitCJ/L+cvcIuIXJwtNKvlDF
         xY6uJG9IjrDc0LuVTC11R622eI3lkeFAHMgA4JOu8v6ZBzNZ1DlhhuBvaJPPpkXd7eH7
         +DPhPyN9pQvhS4o5xg8yfQZBZuKIciTYCY5x8m/WGzMwU0dgFs3yast3yX2r/t2nq5/F
         uDMuWD1/ObWuVSxM9orALh0kMF3wokvCLfgAfW6ncFqB5UFmovhru7h4hmEIlrGZWkLS
         d32xsS0HkLQQIsEuMXyUKc0UBPRxGgg8pStTd2Xldp6AUDzPx1Qr/vmkj1r1qaodoJKj
         hA9g==
X-Forwarded-Encrypted: i=1; AJvYcCW+dNl9gtDZulV1PlzIBCpHCfHk4XuITbTuf6giR38vu/kt9yx30mCxgBvSPVsyIfv2AbtQVO4CLafgF8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHS7oO0UWLsLOXmZgQdNnVvGvfO8Dsxnt6Hm2YbXFT05+uY8f
	4QB/68WPZHerUxpiYAqpuXzr+cenRBKxjFfNGJ3J9Y1Llk9Al5UR5RcE
X-Gm-Gg: ASbGncuPVYFf3cA4drN0Ly+NuKZ3NUNpfJnsZj25jQTxh6pKZxG3ALRRP+bGof9DtnC
	zQkMcO/d1l4wvQRQrJRShLqauFELdx5PWUgzJAP3jmsV/U6NkXpAfCHIPgyAR6PsnIx3Beia3xe
	0qO37YHwouu6c4/rXEFKcxtxmZORIq4dkWHo6Kc2wZ/z9I3J1+6NgMyM416+aY9LSyILrT+afOQ
	LvPGq+6p8p2tu93rhcuFMk0IyUw0jbc3eBfQiPTXM4xtSePBzTZm54BqNslgmaXAsFMJLescifs
	Lhhk+EoOiADypVwyQmm90VR4O7mAXDRjUmKdTrAYnxn6x7uNIINR3p0p2t8DuVWNbHnHJSuKsNI
	TCDXq5k0I1keijvLc3zGkm3k/C/IIHhnDymM61rpJRJgWHUDqiHN96O+ZDWw0DNjDC2gr1o0a
X-Google-Smtp-Source: AGHT+IHxozFTQ2+DY5RuRtE+n73rly9QqmgY4I9v3ctYiEzc8tI31JUkH2hxHnGKb+bQ1Sc7TQ8YRg==
X-Received: by 2002:a17:907:7f92:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b302c4f1810mr388461766b.60.1758663496494;
        Tue, 23 Sep 2025 14:38:16 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2adc17af65sm681037166b.19.2025.09.23.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:38:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:38:13 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, kevin.tian@intel.com, 
	shuah@kernel.org, iommu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: prevent use of uninitialized variable
Message-ID: <y7xzjzbquglgrmbufbbqksvshuaofod6alql6gqfbzhq6s33pk@dw4ma6kctr5s>
References: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
 <20250923172822.GD2547959@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923172822.GD2547959@ziepe.ca>

On Tue, Sep 23, 2025 at 02:28:22PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 05:01:06PM +0200, Alessandro Zanni wrote:
> > Fix to avoid the usage of the `res` variable uninitialized in the
> > following macro expansions.
> > 
> > It solves the following warning:
> > In function ‘iommufd_viommu_vdevice_alloc’,
> >   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> > iommufd.c:2889:1:
> > ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> > [-Wmaybe-uninitialized]
> >   760 |   if (!(__exp _t __seen)) { \
> >       |      ^
> > ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
> >   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
> >       |   ^~~~~~~~
> > iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
> >  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> > nvevents))
> >       |   ^~~~~~~~~
> > iommufd.c:2924:17: note: in expansion of macro
> > ‘test_cmd_trigger_vevents’
> >  2924 |   test_cmd_trigger_vevents(dev_id, 3);
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The issue can be reproduced, building the tests, with the command:
> > make -C tools/testing/selftests TARGETS=iommu
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I think it should be like this?
> 
> @@ -1042,15 +1042,12 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
>                         .dev_id = dev_id,
>                 },
>         };
> -       int ret;
>  
> -       while (nvevents--) {
> -               ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> -                           &trigger_vevent_cmd);
> -               if (ret < 0)
> +       while (nvevents--)
> +               if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> +                         &trigger_vevent_cmd))
>                         return -1;
> -       }
> -       return ret;
> +       return 0;
>  }
> 
> And add a fixes line?
> 
> Jason

Thank you for the reply.
I'm not sure the right behavior the test should have:
- in the version you proposed, when ioctl() returns a positive
value the loop ends and the next tests are skipped.
- in the original version, if the function ioctl() returns a
positive value the loop continues with the following tests.

Which one is the desired behavior?

Thanks,
Alessandro

