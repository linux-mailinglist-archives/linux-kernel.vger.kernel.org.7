Return-Path: <linux-kernel+bounces-862504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 614CABF579A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F375F4F7042
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549F32AABC;
	Tue, 21 Oct 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha4Rrdsr"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447D221F0C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038500; cv=none; b=OVvlwND6YQxEPhZ6gBIqJrmqiI9tequ0ztmV5JRZ3rBmPZHUL5d4JKrbsVgXknNjpxAb7X54k/hxzX1yX4pjPiMXlXWQ/gCEDIjaqmB82G9Mk+4wtkMKO6p3xchGgTAch1iBZEaf8wT5m3x0wYk2tm/mScXsXwSogpVSGPs9lkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038500; c=relaxed/simple;
	bh=p01lvtAkubw3P7gATroU37aqWeyYWjQizBSn1FePr/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgBkzvfvAeXimJkV5wqliLRsDVfLvvXZKogGNhzFr402TqFyPbYYfJHCfJc0xMs1caGD38sVo9hYOO25dmsEwRzWL2lFfKnLBBltmcgoihXWv05QUpTvROA3w1O8VnQdfwso4Anh8eFwxhhfNWlDR9Dt0JoTqKX1WR88MGLAoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha4Rrdsr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88e1a22125bso725800885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038498; x=1761643298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p01lvtAkubw3P7gATroU37aqWeyYWjQizBSn1FePr/g=;
        b=Ha4RrdsrjZPlEMj+XbvPkHKxwXkQCOqD3gRzCJn6366dFCcbvNBZuPwYzgFT2B65G+
         3byyumg2Dk4bfCTvTB7haEAd3PM67yaXv8k2OBf0cjnh3cC1CUdtAy4jHF4YUQHNzSrY
         C2tiOEAc14NZafbOVGIn5uTY4Jz05Hj9xUddmRGxswSObhok4uZUkLpoxEwf6lhW94R0
         hiSFlbEJA5yaVSw3Y9LWHxu5hqnXUbzocR+/Dbyy9VWRhT/u61ZjRK6hkpkREyfhjH8o
         zDG6R3ko/WGkxWxIe09S0jpGyY3HReG1M5ZS4+bV07H4GwA6ZCneVeu7eoIy8QXjUz4F
         Nl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038498; x=1761643298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p01lvtAkubw3P7gATroU37aqWeyYWjQizBSn1FePr/g=;
        b=wjo5XTX0iFiZm8pOp5I9Qs4X5UZ1RMT7fyDn1+RYBeR+BT/RTJ7WZDJYbYe53DAime
         hEqq4mBKSU4U9zraX3KHHwkOPZFJAwirIB1d28DXgwIuV4AoOvo18flZNwoX+ACN8cPg
         uHkVsOl0yyA4xVb8dC56zXxjE0ckK8lZQOoCnl+CGCxmk24u/IEOwdXL5gPFSiYKLhnq
         zKS81LypDa1XjZN7AvIxlDqqVbUIVsScvwt9JFoqNH1fvJ1F8tBdSZVaxQKtFdLinbo1
         w9dj3SZTpaa5pXkFJ3O9VLOmnS2iT4dIpsWJPVcgaJz4TxJhVx/l5lanBlLjeIhUsjIn
         YuWA==
X-Forwarded-Encrypted: i=1; AJvYcCVMkwPvoM1ik8taycpkhHTagZD8gz90efxDLPo3OJD2+rJh9iFbyAzeM9UOEYdJmLsj9s6i+shuU0JHGO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRRqcYZ3w+p8ZwuAMaw8KPZ0YtYwad3i8uIFx4D5Z0FQsTCFs
	cR0rrJ9Fb0Ax0VLtDVgMCfrXgbNeqN+JhdkIa8NDPo4l2Y1DXxHa01UV41Etzga17kF0dR4+MlN
	yxh+oD0Qoovn9yaMq9sDqB2NiL7YjyDs=
X-Gm-Gg: ASbGncvm3QR4I1XxXRLDQuSNJFHXaw22tTzBCGxkMQ2yu0pLNc7YSRbd/WKcyscLcl7
	WcAUXF98Etwqichr3bQ3W7gjln6IfvsAAK6ALha/JW5Rv8EqhsodFCHOhIDe/stgVJ5amABhp4B
	3StSbaHzXIg0OdFacD+zuS+K3SNrbFrPI5U5zePjAydzrtb1LCOAURvqSfwS2QNhl2V6fBLAu72
	Spf/p1dW4L7CPhU/CgC4EJk+nTi8Hm+2hI7jZgHZWXDq+3jSB126LpwrVQFpydR8yhldoK4aFwj
	wu/lXTlJVmFUjTJY
X-Google-Smtp-Source: AGHT+IHhgM7bMW5QJl9FIYl79SdfNp/QCrgiJHhu4uKLWjqEKOJ6gOltQwVNcNZJNhrG3v3rJK+ee1dF69tzG3DZmKU=
X-Received: by 2002:a05:620a:6cc2:b0:85e:8106:f7c1 with SMTP id
 af79cd13be357-8906eb94740mr1863410985a.21.1761038497682; Tue, 21 Oct 2025
 02:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021011739.1468912-1-xiaqinxin@huawei.com>
 <CAGsJ_4zF4JOPXpkzmR+invqefLstcaB=xaGEfueHEQRSg2oLOg@mail.gmail.com>
 <47cc4984-a424-410d-a1b8-9947c1a42ccb@huawei.com> <CAGsJ_4zf31seJif1N93yk_mUaEYh4SzwedASK9VPnPm_JJ6t3Q@mail.gmail.com>
 <caeedd6c-4aa8-4787-b1a6-5df7928f1fde@huawei.com>
In-Reply-To: <caeedd6c-4aa8-4787-b1a6-5df7928f1fde@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 21 Oct 2025 22:21:25 +1300
X-Gm-Features: AS18NWDfw714FM5DzKPZ_XxRc9dqXIC9cBJl7sO0yihjTbCAB3GlS9lEoKWeVA8
Message-ID: <CAGsJ_4xSMa+8hExgLMp8R0m9SsRnVxQxP42NxD13xPpQ52SOQQ@mail.gmail.com>
Subject: Re: [PATCH v3] tools/dma: move dma_map_benchmark from selftests to tools/dma
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

> Hello Barry:
>
> Sorry, I don't think it a workaround.When kernel builds with
> 'CONFIG_UAPI_HEADER_TEST=y'. The build system will checks on the
> user space API header files in the usr/include directory.
> The header file must be compiled independently.
>
> '__u32' '__u64' in map_benchmark.h depends on the definition of linux/
> types.h. If map_benchmark.h does not include types.h,there will lead to
> hdrtest error.
>
> That's why I do that.
>

Ok. Thanks for the clarification. make sense to me now.

Best regards
Barry

