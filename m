Return-Path: <linux-kernel+bounces-830121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C85B98C56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C573AE8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4918C28136B;
	Wed, 24 Sep 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8VtmVm9"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BC280CF1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701526; cv=none; b=jIIJeGVeXT/kw90AIWN3YrHSZZregqKRBiyGuTifQK4rf4i20amhbuq752vUuPXmAzz+0LayQhYV7IrLNRszo0zZF2aBrpEhvvplLwRMeoBZo0Efe59J0kpTHvg9krrQQJY0nfPbn/Nhy199Ti2HGy6kwEb3/pgGH2tIR9UjHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701526; c=relaxed/simple;
	bh=VmkA7XO9iwCF3zoLLDk+sKiWrqkJeeL94QJkshniWFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5EIS6OwW47Fb0u+x6ttuAmgAbKWkKfoTuBRTKCMSV/u4DWAwbCI1+spY81yf7stoOGWGmqFdEeOQByUk5Cpx2umOq4zRjbuuLmmG6u6wnS2TQoTvx/1DyyND6mtfb2GmDKFqCbkyIPmqY73WVJmukD1cLaErE03BmDQDbcWk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8VtmVm9; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36c0b946cb5so23050671fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758701521; x=1759306321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmkA7XO9iwCF3zoLLDk+sKiWrqkJeeL94QJkshniWFg=;
        b=E8VtmVm9URhqNg+j8xJaQGu+VqOc4Kd2xTVxkG4u5vWblDIRsT6ur5+1X7Bw51RZhE
         oPI7MVpoHRe2Gj8VeDoT4Bsa3wme+LaLrzhUaPXdJ7fjJX0zxG01kNkrotfxRMVrakLF
         ucmHok/GTXYj75TySLC5mnA9RNc02SXrsyX1CXiRvbQ34tkswJlPeViZLBp/rVFMl7SU
         L4U6kYbe2FeWuXPQUr0FBK0G4E4v4yvx0lppttA/6DZBDUDy/mufR+xYVLR1qDw1qm8T
         rfFY4G76e1R6rYtitcLkXvS5yqTIFhzNPkMKWIfuUJHDCEkrD8jtKYGLytFJ6uXtx8wH
         g8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701521; x=1759306321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmkA7XO9iwCF3zoLLDk+sKiWrqkJeeL94QJkshniWFg=;
        b=S5LaNtAgdDSat9oTZ2b3hszet+m2de3RzA6DOAXY4a5+lDFAz/pEm52DpGj3i2remM
         oVzeEGFgf5Dk2JiP1+sJmSutoA7kBm2UO8r2sQfaNcCrgycAUEYcDtuHS2ZjcxWv6qAS
         Kh5bfukbvxhV6kHgBpPcsIks2+UIfNTSHy4pOvYl/Hne2lvB6kIqpYYZulqVUQO2jOE7
         IzRrQggmLYY4i9RXENVj3FD4pCqwzo8D0W+FV26lQFQatLIacQpEO1tOoWETjhAwdQc3
         O7HmUJbLfM6s0h7IVeqVhMXpjA39gkDovmvK7zBXOGS64X1roZsJEDcFDlOINy/MvlNj
         Wq7w==
X-Gm-Message-State: AOJu0Yz9WjwA3bgunA3PsqvWxs93+Ydbf8PEnWReQ4+fxC0BN3XeNbZF
	2VG+s3oAk2hRHHx1iGcDHSn2Ye+946c/fIRadPf4Y9n4gTwrXmPyEEBte6/jdFM28haOXegtqO8
	0339SPy6kHRJDKb+d5nCHaQMckTwcdV9gXpCNfZ3vslT2jUitj44T
X-Gm-Gg: ASbGnctwT8JIoOuzIFRZKrQBZM/dz5l4gLPksmj3vb6USfq6A+35V15hs89WjEqRoCl
	N+hVxTyORuShBoGJsvSFMaHCkq5nj1o/xm6dQOZdW5PxhtpXh5cylCuwXzQwmWTYhpNztJkGcKJ
	MWlvsjlarpOiS3pBnwAexVMrm4Zj1T+shufIdPHqU6ANkJy+aANu2fhUftMH3hESxzz9mxOVq4h
	G6V2Y6YDjiJ16J6HVk0XWum43x6Oys2NOZFkfim3Ksa+Fx1/6o=
X-Google-Smtp-Source: AGHT+IHPQ1a0UxwW+MuOyVJBRCeoASaGWNoAoc7NUPlGBb+q7qMkCVHVIzSZMXDix4Vz2Xa6LdPqxoU5tzdwpGZNqd4=
X-Received: by 2002:a2e:bea3:0:b0:36e:4481:9eaf with SMTP id
 38308e7fff4ca-36e4481a41amr6707431fa.15.1758701521434; Wed, 24 Sep 2025
 01:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153859.363593-1-marco.crivellari@suse.com>
 <20250917153859.363593-4-marco.crivellari@suse.com> <72d10c3f-c036-4813-a256-9d7adba4bfec@linux.ibm.com>
In-Reply-To: <72d10c3f-c036-4813-a256-9d7adba4bfec@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Sep 2025 10:11:50 +0200
X-Gm-Features: AS18NWD24pmUR_DcuMreVDvQhvWrlztpWLqsqSgOJKvqVmAcXh5G04QuDlvKZjU
Message-ID: <CAAofZF5KbMqyrhraMJkuWYwyPtn+W10vMNa0LfPYF7ZEd5evdw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] s390: replace use of system_wq with system_dfl_wq
To: Mete Durlu <meted@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:05=E2=80=AFAM Mete Durlu <meted@linux.ibm.com> w=
rote:
> [...]
> Thank you for making the change from *_percpu_wq to *_dfl_wq.
> I am not sure if its too late but you can have my r-b
>
> Reviewed-by: Mete Durlu <meted@linux.ibm.com>

Many thanks, Mete! :-)

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

