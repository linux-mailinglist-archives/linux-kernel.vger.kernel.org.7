Return-Path: <linux-kernel+bounces-845835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D48BC63F8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4FA04EDB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530E02C0F89;
	Wed,  8 Oct 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H4qVZdrO"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9142C0278
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947054; cv=none; b=MaqZ148bhLDzTGdv4xPpVDTG2DSI6r0hlNV5qHdcH3K4sFXEKV8fhn5hJXd1hCLmB7Sy14XNK/ZU6MOgnL6ka1nPtKXP3dz6eJ7g0GPZy1ebJm6MhWDKlmtfn7aheY9EWZWUYuQQNdnFB2HsUn30KCYo2kPp/jnwiGlzFBaRbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947054; c=relaxed/simple;
	bh=R7bhRsHgsGdQvD5A36Q4KsbjK8LfsQHzx+qwMdc6W0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQdcG55FYvzpGlF6aQD3tRjXmMj7w6G09ftAV3HsKqHttVO4GEeOqBS1gsBxKR5/KHEvB+po7PU7f6GaiTy2WF/YDSsLuwrc/yAvHDiyJVRrG3YX+g+LKSVwg2O1lMZ2oLW5priwJ9rHa0JRpbEcwC99yM51VUycbHZZFuGClM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H4qVZdrO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-782023ca359so97746b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759947052; x=1760551852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uj37ChrtUbB/AYpUwT6DPbeSkZ8S2CUiy1YBfCcIMAc=;
        b=H4qVZdrOfRe34F7JSF316u4C77cLy9t3Mj6UEWqdLghR+AhbnPjO/qcKCjfxQvgfG4
         O0ulJusiUTzEkz2Y+TWJju4hY5Gx5msuOh1Hp1DGaE3FxTyciUjZRudmpvHRLzyMTU4n
         abWYygkPFmQfWDSlEN7JZZc6gKBl65JyWlCZcBYdMVx43m6tYYnvAOUklflT768HRBZP
         qpfSz94PfyXMuaSF0+YawMTbrBJKhL97Q7s8kWVRt6HXUb6kOJywg/dEDQWKiNE5E5Ig
         VQhujmT3Xe2L8ccr5le8cw/lm+MpUkWtKh0GvUdLB5tOmn4GsgbTTnWGE6COHQ8rwA5V
         cjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759947052; x=1760551852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj37ChrtUbB/AYpUwT6DPbeSkZ8S2CUiy1YBfCcIMAc=;
        b=PhZaUJN8PZm2dhKdgALcveqT9wKfmoTuKlO7/SgFGWDQhUx37SzNw5ICSRSwz6B+yB
         fbKjYqWIgTOnqg5Ry0Oi/+7lf6uCjD5PLGJia0NNI2Wu39iLYIeKIlIG+zS5DPwjHJ8t
         7QHHtRDV8BCiyLDhQ7gRy6zR81fnHsit4fCHMaF7e+9K8soMHV0TljZQSpFunR2jftM8
         OKZJVnQjn3lgr+JIC6nPr1KH9cvTQO7ylP40A03wo52KmaDpcYKtHISdC0PjsKJ5GH3b
         n+AaXLacXSwmjaLWerMHUj0mOHHwLlv/Wh+k2Nwk+lJp/pHNmeTboluTAGM4CYMqgbVO
         A5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXhYgkXsJkC4RxxcFbX6mt20wMYCquxuQKjo1QQp2xktbshE7TaMOfNUD0+R+LH7AKFNP9tFZqKpAdtEjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqeP8uplQX01AdW68sJwVoJ98QLUB39dWU1tuNrWwyjtgQcLID
	HE4LLsj5A3vX+4TSydYSYX9ifQmsGd1AchVAdhbzSWlaTigYX59AygpVqlSuQtJTYR0=
X-Gm-Gg: ASbGncsijtgz71MM0EM5n2HfKiVJLYSSujBVZfZFZr0THJg3PCrQIds4iO+MCClht1Q
	4Cfrj31ElZmUmdns0bMCPPMCJz2GvPEMwesz+0rmLSyqvg9C1chOGYvEIzNg7Zq8Y4sBuMYeM04
	muEAPc5w8qRqHKy5Ywf5JVlR4b6qLQ2yw3FYUG8e3P/gF0BJPwc9/4j9/aFnjF0aPAd7nO1o0p9
	4c+8NzQWf8YZhJ0XZ+3CX87BCUTq+mB09TO/HzQYV+MFURXdPpaT6Ai7H7RMXKJykhCMUiOKkeO
	QoSXDzZSb0/mAsAsMX07hEgAv/vcv7NN1Yo6MR5A+Mb32YuZNTcl6ltGG//u0nBydn064VQjC0u
	1ozbiXj+L7DpE5yEzDX/cPg==
X-Google-Smtp-Source: AGHT+IGmSrJJTln0Rckoxqd9caMwgvpvSlEbbc2DiVubFKH8XU3waZCHMA9b6JvSrYUbQpW2fn4CnA==
X-Received: by 2002:a05:6a20:6a22:b0:32b:6e35:9050 with SMTP id adf61e73a8af0-32da83dd7cdmr6035562637.35.1759947052195;
        Wed, 08 Oct 2025 11:10:52 -0700 (PDT)
Received: from ziepe.ca ([140.209.225.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4b3c43asm393694b3a.1.2025.10.08.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:10:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v6Yck-0000000GA19-0vdm;
	Wed, 08 Oct 2025 15:10:50 -0300
Date: Wed, 8 Oct 2025 15:10:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [PATCH] iommufd: Prevent the use of nil data
Message-ID: <20251008181050.GA3833649@ziepe.ca>
References: <68e5a30d.050a0220.256323.002e.GAE@google.com>
 <tencent_E46183A88440D77C977DA6CBD37DC362A905@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E46183A88440D77C977DA6CBD37DC362A905@qq.com>

On Wed, Oct 08, 2025 at 03:53:07PM +0800, Edward Adam Davis wrote:
> The division exception occurs because:
> The denominator bitmap->bitmap is 0, which is derived from the nil value
> of bitmap->data passed in by the reproducer.

No, that just causes the reproducer to bail early. The reported
problem is divide by zero. Which is caused by this:

	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;

	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);


  //  ioctl$IOMMU_HWPT_GET_DIRTY_BITMAP arguments: [
  //    fd: fd_iommufd (resource)
  //    cmd: const = 0x3b8c (4 bytes)
  //    arg: ptr[in, iommu_hwpt_get_dirty_bitmap] {
  //      iommu_hwpt_get_dirty_bitmap {
  //        size: len = 0x30 (4 bytes)
  //        hwpt_id: hwpt_handle (resource)
  //        flags: iommufd_hwpt_get_dirty_bitmap_flags = 0x0 (4 bytes)
  //        __reserved: const = 0x0 (4 bytes)
  //        iova: int64 = 0x0 (8 bytes)
  //        length: int64 = 0x0 (8 bytes)
  //        page_size: int64 = 0x8000000000000000 (8 bytes)
                          ^^^^^^^^^^^^^^^^^^^^^^^^^

0x8000000000000000 * BITS_PER_TYPE(*bitmap->bitmap) == 0

It should be fixed by adjusting the logic:

+       return (iova >> bitmap->mapped.pgshift) /
+              BITS_PER_TYPE(*bitmap->bitmap);

I will send a patch.

Jason

