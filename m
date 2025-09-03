Return-Path: <linux-kernel+bounces-798262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46EB41B69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4308B3B5912
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23092ED84F;
	Wed,  3 Sep 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUd8z/vV"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49E284662;
	Wed,  3 Sep 2025 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894291; cv=none; b=Y6yH3fY1afRxS17cUMiMiVE4PHTQ3Skvr6UElwOPKLdwSpbhQRBEGWZ1IYOxdl9a9kx97izzmGyZAP9WY8+OQOn7i5ntdt9eNWZvTvQhHYLTd0yJaep+x2pbna4iUAemVUVpo2HCB1LPupOcoVwjkiwlIhqTaVYZESRFhLhVcd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894291; c=relaxed/simple;
	bh=U4MZoi8oLGDJoMxDELHFZu0xWz5d5A+jT4oMO7QogZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7ZPnX3erhHVlrf5YkS6pf33q2c82Hj+uNQd4gwFmFUA4Gpni/TWqrwEMSpAsuxZvQBZBtQj6hme1yFags0uKMwaqvhuyI0J+FPerj1nvoDfXxooVyG5rHxuTYLhCfWXIA71ud9eSWJsKMNNaidJBVs39DiKe+08DkNWkYHrTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUd8z/vV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b1331cb98so3005365ad.2;
        Wed, 03 Sep 2025 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756894290; x=1757499090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4MZoi8oLGDJoMxDELHFZu0xWz5d5A+jT4oMO7QogZU=;
        b=FUd8z/vVaM5HM7OIA3SNe3iN28T+7erbkyFpPTZQkaqG3Fipwko07dYjODEiYZIU2A
         3KqnLKAQlrneIjVDptjxeMnAlISufnJiVJd5dus3z3fMoGlDyY5P8IMFIrC9pmLfSX1F
         KF9+kgwqeVfkZ6PU5vzXl1D+tblaAyhIIaV0BgXhso0qv7LC4HPQGnxa2cUllyrrmzyD
         TSco2l1JNX2OTCRVbrYBhBpq35l9XUEbmuiRWxGXf2PZ3LeIchCQcagSMeIDOi0P2M9u
         dYeQQdgZKBNeJIh25J2wUhd5e4x14c70hIeekxCrlG04kJC0x+lC17n0oxKyIeVfiQrU
         Bf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894290; x=1757499090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4MZoi8oLGDJoMxDELHFZu0xWz5d5A+jT4oMO7QogZU=;
        b=jC3y7l/Tmncfi8NjePlsUkGDr8H1HvqhpgYQYO9HSamXtxZ1TKsiYOB/PcdCOm1iml
         HdTROrOc1DIZY3Z8CF56i9Jsvqy5iniiSU9ltOBI/vWkxHtHP6xTdj7a17jevOjNieTY
         KY/vNtvKQ7Ckc/s1WklkvB8r1d60jmxuwhuT4Xs1RYzMzEb0AVeCkXV5Df9IV9YFv69D
         rlkI65PNuE2QscoR8w7PK0GfCUqBgXW1NDG7HMxe1fzc1cW0z08mmi5aGaOQb07rfEPi
         F50BHpqDhxmgQ+cZYpAlZ81Qe52YymRSoMgFFk1PRPQfrT777zf9ps0oSCCQiKaZoPcY
         tPpw==
X-Forwarded-Encrypted: i=1; AJvYcCUNYl3BkSmRiDR5ub+ILZNaL/sFfsF67t4MSwlQ50n5qy09b8OVJ9ugX3fg9J4RB2fOsU9ofhUJNqxomebjfsA=@vger.kernel.org, AJvYcCXQjBzLGAbIUwr5q1MGOKGZcYxFRI13RpBbo7SBWB9B8BXyC/l91muRXMeZHBAvTnseTJo1i1SiDExRqgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxOZBnL1An1c5oshsCCvyxheKbjYuV7MeA1S6TNtPqNz6Msos
	kPyRrXNwhRlTeY5oV6IZf2//zZ0s/ecA8AqF9CkPZl3GWjAkwoOzqTflcHTHtF8MWTEcfJKEbP/
	rxkopNS6RTvkS6SbpOHzR5V3xjbfchhigIqhuSPEUsg==
X-Gm-Gg: ASbGncsbevKZive5KAcAUzDnOMOnOozmtpH07B/Z5q3W9ykU0+0rzUfFkjnoRotMkg4
	7Ns4XAsR57QzDGE6pBcx+aHBWj6LaoUxlyv3iQ8NkMvBTDY1Fy2PvvRa59rUvlGJ+uGofm86Bf+
	XJBh+P81rYapSf5LHMZ/3vuwUNLAnbt7JQsmjUqtrenrP7jX8XuqQOMW519h2my8F2Un5JN9cJK
	Xr0IWtOFnVyLWRgqCWNtDaPlzSgQavPrI8xY4wMF0OAlJWXA5+A1U5R0E3dGPS9SJ2y94putcyu
	xZYRidVKtixS50LPWG+ua0VS7Q==
X-Google-Smtp-Source: AGHT+IFwGI9nyWNoJg8uwXwGJ3TxB4TNP09lA7q7e9wGdXtNR/k17bCYNPM3BYw+7ukDm+E8vdiADOOngjA3baARINM=
X-Received: by 2002:a17:902:e804:b0:245:f85c:8c6f with SMTP id
 d9443c01a7336-2491e5df36fmr128836005ad.3.1756894289581; Wed, 03 Sep 2025
 03:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903095315.15057-1-yangtiezhu@loongson.cn> <20250903095315.15057-2-yangtiezhu@loongson.cn>
In-Reply-To: <20250903095315.15057-2-yangtiezhu@loongson.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 3 Sep 2025 12:11:16 +0200
X-Gm-Features: Ac12FXx73Wpq1b-4qjn_jQh2j4PxEmWDtbARo9rp6bgf8M0PObw8Mg54qeDFzjg
Message-ID: <CANiq72m0HO91gFcVuH3kPz6b6fZ_vrbO3BGmb3DpyhuRnvGkeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] docs: rust: quick-start: Add another way to install
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:53=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> It seems that the latest version of rustc is not compatible, in order to

This is only in nightly Rust -- we have a couple commits in -next that
make Rust >=3D 1.91 work. Could you please try those? i.e. starting at
8851e27d2cb9 ("rust: support Rust >=3D 1.91.0 target spec"). They should
land in e.g. -rc5.

Regarding `rustup`: we could link to the install instructions, but I
don't think it is a good idea to replicate a particular `curl` line
that could change upstream (e.g. the domain changing hands),
especially one that installs something on the fly.

Thanks!

Cheers,
Miguel

