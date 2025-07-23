Return-Path: <linux-kernel+bounces-741827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B59B0E969
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647577A3270
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCDE20DD52;
	Wed, 23 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fm6DS/KA"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9C5D8F0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243431; cv=none; b=JQ/lyztJT6CASJawC8diGJwTPsEiwLTAoC2XVBHZJYxCCfbRkDqb1ArPg8mu3Yit9rngoRO2VTu0NmOwuLyqiSfHmUCTD79FARLH5kgDlzuo+z9C9RUauVDpNdhqpcv9Fk1/jMUnxXnrJcB8xgyQZG/By7AF1Jgz8glkASrJlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243431; c=relaxed/simple;
	bh=Rc50L5ygkLlfY0W8MHoidgWKMab2YxF8ZESR2DWtl8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blxH588P9fa0/s2rMJ3yDdV7lpqb/+4wWHnJ4CtVPQ2UP0U8O4AJM332ITLYMOxmtOogCSdzTSlXB2Lcs7Y+iDfGCv5MzvGYbHXAoLIsB+KGoLhPD5A7YkClwyLcxiEyVU3rLyEbffcIhdBvu9CG8Q8vazmMGbzjUGEnP+F5JWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fm6DS/KA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7600271f3e9so490028b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753243430; x=1753848230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA745yoKZM+y1Z9ywfes2QtRwxYl5/Ynbkdt1hGqcxM=;
        b=Fm6DS/KAswCGIHOhky3H7IyoehCWzxea7Noay11U/6GAUcC9vc2mkQ7s1usYnGrGki
         NuxqSDxmmbm94OrXNzKLFUOQ4+0Omf/vhkRmCfyZrQAbFpP21TdZX3OuNkKikj+zl01W
         iBIWVh0zAzV9bQsCLwXvnTBrwX9fAO40kMMJLIsWUqNNPt9pTFgIRh3Ggzu+9T76F4ef
         pqZgKqQ2tZpfnVHS+FHmO330TrnhTU0bwmd+1lbwxtKd3Np1y8kLTGBHdrfh1DvCkrpc
         rTdrZyQA/vmuUFhTb7fs6mlAc++qOTUF3ZRzKCGu3U/OJx/kaq8+ccKihWi/QxvTcfP0
         QJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753243430; x=1753848230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA745yoKZM+y1Z9ywfes2QtRwxYl5/Ynbkdt1hGqcxM=;
        b=IocdF3723q2rojQmZyOCUsHnoFDzqYqE+NKaXzH7czcvetFxysZL92Q1NVzvdp6Kr8
         SJB6j17Dv9WhI7coFc1RL9VN9jHWGA8jp8vXR3Cd/vdnyBbhO2XQb/xz9JkcEuYHxieX
         zCFJe7xYpbGzo6s+4luOB40Dh8pRcdo6lLptBH2cACUvHamBk8LMD86sIZQWwKd4NeDh
         3NWZ/IBwWHLyc6lIBwuvmYjz2kog8YmIUsjy5R6CwYXYI0+s0jiIqblHHeTXcYnLQA/K
         cUL2ifxzQmzCkz8kcz52z3FLfhc22AGF7hQk9os4w0m1cJfjJLYNMGGgQlbHA/jN1Xn3
         sd1g==
X-Forwarded-Encrypted: i=1; AJvYcCVohvS/8Umfw5yccMoNCE8OfEHVTenjY0ihqz380AWlY93Pnr6zK+fuRadSHdIXIFlcayjHKIUJsCXqlSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzln8XHTap+A8SGzG3MI16lEb6Y05jv4WteNYgBfogLQxjQ9TuQ
	kCYEvZ8DDKwc6Ku58ePo0Q9Y9yEWjRmuEp30aXloxS/a1w9ud96so8Pr8Z9p0YUTT+I=
X-Gm-Gg: ASbGncsCJQ9mQXfj557MonfgjBfgJNI1ocYFFBlKYsdfHkIZax6eoWEtZHpnHS9bwFB
	0+AW3jbd8dcyD1coI61zIpaAf+d6Rnaky9Nk8EwUlf39O9en9PKJmJWra4EC4RsmelxTshDNbpf
	P+TAd1SXzDQPM5FbbySLAhi+c7qHv9UPjlRinnG3hmiDyAgPYVaoYxu1Fw1u2XlTjNbCQitN7Tu
	kufR/qlhEHcj/JNxrG3wQ+JyTUmX5DeGj6hsReP+N4jfSfvJT65NklAHLHRWpu0SHmT/nnZkkKN
	iKucRVFvLechdYSPtjaxib9Gyy/vArIuk6S0j8zBdt1ou3hgaO23c+4kCV1aCg6E5UUrPt0h0Na
	3F7DaGBtWNtpiZtEyR42QxvL2hBqs58prdTs=
X-Google-Smtp-Source: AGHT+IHWWupLuqc8e5GXXzUXDSlEt7hhxnTZrQ9aJK/Vr+sC9tvcbfe/C8gT9skU6Vf1zOtykYPZzQ==
X-Received: by 2002:a05:6a00:4b56:b0:744:a240:fb1b with SMTP id d2e1a72fcca58-7604b947a05mr2140480b3a.5.1753243429711;
        Tue, 22 Jul 2025 21:03:49 -0700 (PDT)
Received: from ziepe.ca (S010670037e345dea.cg.shawcable.net. [68.146.128.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff62789sm6731701a12.44.2025.07.22.21.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:03:48 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ueQhn-0003Ip-M3;
	Wed, 23 Jul 2025 01:03:47 -0300
Date: Wed, 23 Jul 2025 01:03:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] *** GPU Direct RDMA (P2P DMA) for Device Private
 Pages ***
Message-ID: <aIBfIxVBR/3ig/O/@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250720103003.GH402218@unreal>
 <35ff6080-9cb8-43cf-b77a-9ef3afd2ae59@nvidia.com>
 <20250721064904.GK402218@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721064904.GK402218@unreal>

On Mon, Jul 21, 2025 at 09:49:04AM +0300, Leon Romanovsky wrote:
> > In fact, hmm_range_fault doesn't have information about the destination
> > device that will perform the DMA mapping.
> 
> So probably you need to teach HMM to perform page_faults on specific device.

That isn't how the HMM side is supposed to work, this API is just
giving the one and only P2P page that is backing the device private.

The providing driver shouldn't be doing any p2pdma operations to check
feasibility.

Otherwise we are doing p2p operations twice on every page, doesn't
make sense.

We've consistently been saying the P2P is done during the DMA mapping
side only, I think we should stick with that. Failing P2P is an
exception case, and the fix is to trigger page migration which the
general hmm code knows how to do. So calling hmm range fault again
makes sense to me. I wouldn't want drivers open coding the migration
logic in the new callback.

Jason

