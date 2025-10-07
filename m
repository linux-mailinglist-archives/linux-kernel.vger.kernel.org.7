Return-Path: <linux-kernel+bounces-843615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50911BBFD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2B3C4F3168
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E2CA6F;
	Tue,  7 Oct 2025 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjmKVfo7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A2125B2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795361; cv=none; b=tjG+X6WZ3deNkPtb+Q/Q60V6k9aTLsYg8roQDdx5xgeypaopkjHiCKxL7nRZe5jyCMCKhGHP4s/mEt4xJ0v/X/7yNqOAxejWgBTPrqImVb0ZEMQclmE+WVs9zboqfaqWTBVFE3iPjuvIprKKmxyWO6JtB8U9l3I/3Ys0z0idyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795361; c=relaxed/simple;
	bh=GwSFfmTyex/Og8tIgQnlCm7Ltt0AWUYILU/NMPicnRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzbwHm5hnUaXBhg2OdEQLp9lJ/6UKw0ugBlfvOsadY7sBz/nlM6aX6ltIsGwSGn3CuJDWO4R512Q6/v6/y6+Mrdx+wBJU5lA4oehWuX+oQSvqftOBkBs3TMp71tCcGQ1O/UW3Hm5QN5AijWg/yKT/JrA/v0Lx5hbQsd+7hpwSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjmKVfo7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46b303f7469so35647525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795358; x=1760400158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwSFfmTyex/Og8tIgQnlCm7Ltt0AWUYILU/NMPicnRk=;
        b=EjmKVfo780mrVqvXanCoq7mLf+7DTlTs06Fqtzbmr1LH0F/HW/npNa5zgeU1scG51K
         XCAlyY7l6k0TywmNFa7FvFip5W1cZVmJ94p1Oyz0/lxYikfsxmoDilV7o7KSEZZkJw8t
         ExFIv7k5D6zdWBbTxJmhd5TyH0Ht5GznVRjpiylqbh5JRp+myIyrrdAzWZ3efybbt+jW
         8J27YspbfHwBsLhTyDhWXJt2cZSidtjo3URvAxRwLEW2O+pjAL1Mm6kBWpDImdCG5PTB
         oZSKvZQNL/m2TJhq/kQULpEBjSUv6qiMWkTb9iw4FLhIWPToR687ka/xT/4tLVzUPf5s
         aiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795358; x=1760400158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwSFfmTyex/Og8tIgQnlCm7Ltt0AWUYILU/NMPicnRk=;
        b=iWzu6RqvaZfjrqJ0Z0c50z3er9Zl/7lOBhHLNPATXBjvahr6lEd7/0cgffabvOqUEt
         0moM7C2wsUIW8Tho4LrzXWk2/tjHo6phYdHneLKEg8xx1R8mTcDTWc2tMWZ+BL1O8IT5
         ujiGzGN+pAr9mNOESaVTZUA3gNIihduNq4wMjkFH+AiWM1frtNWRNjnWwBpbaepqEbGv
         Iw9VhQYALVjrhGwLnN5yCiVLhi6xhPU/OpmEf0oGWi2lf4VBhut1DbzN5k7wATPtOz/r
         3Mkyey04aXUdKSGJtMU8+MwE1JDayU6zk2UCHeggEsEVDNO9mZn6VP4SzTuF/xHHJYfb
         SPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdaCPKrFtukmdmxrVjctlc3RmQkEoPQMYIesxQ83X4Jo3+6zvNnku6NlkuD18QdwiWp+f5Y/6aHrNLi2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMr2AYeG5Na0mubzZJwSLqPrwKVLnP4Iowd8SK4Yi8iXMIxLh
	42jHoZSB/VCKucC85Pa0stl1+dGAcDDvh+0QcVON63jc+t84tggcThA5RhN1+7AJfux1Cp8+rKe
	XFxkadEwtZpatZsYRZ81PwLKZ8KXK03Q/RigqCdy8
X-Gm-Gg: ASbGncvG3mF56xn9Km1sT3SDJnaYSWCux/hVPYRSmzyg68hYKwhOVHQpUZhRR72hJvH
	YDbPClv7gnsEr07aPu1y9uBvzC6oOg8g9X65wNFMEPDe3YPSxJpW0t1dWx+VI1p0LQ4t/bbuK/M
	Moi2qDIYr5n21DPJPFM6adDZ9YyN1RK6aKHefMo0U1u4mgjkxlwugSBgKqjHAQkNHvxdwpMt97F
	UAFudxG7p1Dqjipm4nLpX97gQoa3kWQsI6NM7fae37LNSurxt/tgtMVd5yAK++cakm/
X-Google-Smtp-Source: AGHT+IFu3eahCb6HJmJNeqU0wWf58q+EC/8RvlKhhU41gVbmjp7uomfLvsENYszTvLbyaEuRfiMuIjvaNdO4L8NtC1E=
X-Received: by 2002:a05:600c:680a:b0:46e:42cb:d93f with SMTP id
 5b1f17b1804b1-46fa26df6f0mr9764035e9.15.1759795358233; Mon, 06 Oct 2025
 17:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926202234.3064386-1-jthies@google.com> <aN5iyOsHILi40AIp@tzungbi-laptop>
 <CAMFSAReHEt7nUZvsnB5pyPTaddSVSdtiiX-RLpY4MfKq3qfX1Q@mail.gmail.com> <aN80BqZrhisWGY6p@google.com>
In-Reply-To: <aN80BqZrhisWGY6p@google.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 6 Oct 2025 17:02:25 -0700
X-Gm-Features: AS18NWBm6TS3dyOBYNW2SS83PPwxqu5Xwod9WP1KlWrgtte3M27gAsgDllBt5tA
Message-ID: <CAMFSARc5hb1v91mN6PAuUVw7Girn5QCkr7NgCxCUQbHPGEzckg@mail.gmail.com>
Subject: Re: [PATCH v1] platform/chrome: cros_usbpd_notify: defer probe when
 parent EC driver isn't ready
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: akuchynski@chromium.org, bleung@chromium.org, abhishekpandit@chromium.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I think fwnode_get_parent() should be preferred to use from maintenance
> aspect.

Sounds good to me. I'll upload a v2 patch using fwnode_get_parent().

