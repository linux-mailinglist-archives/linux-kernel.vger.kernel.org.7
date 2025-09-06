Return-Path: <linux-kernel+bounces-804053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F8B46948
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2636F582DC7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D937265281;
	Sat,  6 Sep 2025 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzfcPqs8"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176661367
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757136307; cv=none; b=KMQeiZqo/P2nWuso2rNVMMTSUyTbFioA25yvSNhNfBEIDiPig1Su9aKKM1VftQZlziM9geWnJeFmNLyMJaFVQpwQMfyvkGZSo9Ozf7NxSVCY4CS2pWAm/xiGbsiy5oipKTadt5VMmG2rCoBX09sBNdpej7MIAriXdSmIW7mqE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757136307; c=relaxed/simple;
	bh=e1WhUKTBxcgVfgvRyMM4JxOt23VvOa871eMQHq2RQlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njqRWwS4/sYDt0jrWaBYcGE9r0cdLxYzJ9sffwBs8Kz0vg9aJsfUk0aH0xJICejJLOyfBjlrNkEnQMoUaeAMssyvzgnh23eE5GRaaUP3TLum1843+UHagCUVHlTErTaaP1awqXrNG2e1oEarq47w16iAPC9C5O/N7/HsqY+JHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PzfcPqs8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24884d9e54bso29081915ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 22:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757136305; x=1757741105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZGo+T7amOY1lETbh1kJa9AjOv0PBB9f7/HBJ+WiqwM=;
        b=PzfcPqs8EkiZ1nWQyM5Z7sqC1KmX00IskGai70RUAVEEoBIeLb468R1YG9AjGFRKXz
         B1PsK6s8z//mfdp4qOQhFzyW7zkBnRI8nX4KZV8k3B/xjYdc95Z8usTvNIcRFLPQCydC
         8o8y26IeFvlLbE+RzpzhZ6Av853MkeMk90NKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757136305; x=1757741105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZGo+T7amOY1lETbh1kJa9AjOv0PBB9f7/HBJ+WiqwM=;
        b=UJoQdJmiy1xMdYSx3sgrser21kDU3QwL1WYxhwBzGwmHexcUXakW4S2Nt8TpQLgy15
         Ox7Mt2vY1ViuKKI3quxJW2dOcAugLO9/1UbSPVW++xfoiu9J9+l/rkfS4aTgXAn9MI6H
         0E5yYWd43zexr/YU/I7kAZRmzgqQdKP4m3MG5ReJZXxLSxCzsGL3RpymRa/gwPgNd8KF
         dQO7H+NzlhL9EToXcDvOuaeBogT5jB5c2y/BF3S5U7ns/8rod5UpOhy3FGqbIMCT7lFn
         Uzzse7hmusE+oIhjZHiNwD0EbojuPpkicVXW/kUhNnpoYTBHoS7ZBzM5h7NKTfb8n4Iz
         J7qA==
X-Forwarded-Encrypted: i=1; AJvYcCXDUlKNcLzYqsJrv2N1ySSwbPRvFU6wjTPt8WSD0exUjfa311LXMbyp8VK9LqGsKU0LTekHXp2e3MOYVM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHsGBvAj1UHsY1/ifOjt+tefgb1uU+P1i4L5ySYQqlMF9vEh/
	+2hrmSX61HyrrtwrRzUGF1GfJA0fvC34EhB0o5MDjvZEA44jlbTRentDE4ndEgpbGQ==
X-Gm-Gg: ASbGncu9bf9LJ+1hwf3G5Cqo5MfwKUQZDKtHnbjy0grk88JI13vNAS7yDftnEYy91El
	2n7FUiAptAc+fkTqGrtjcPUH8/qngdecqOkShuugWBAZPWzSfQYCEzOH9cC5blSGTf1FLkrWVUM
	HB0cLpYj3ZbjZ5khdsNUXEh52ZilFCQlLIy7Ya6skKzuWY0g0jr8ovYIMEB+3dFZaTM1j3BmGWz
	5Ik2YiAiJvcn7Si19d1/uOL2mBApQTNdV1xROaBW90ErGEk7yFc8zgWLTpOp+LwnKRQZXfnOBgZ
	ABOZCD5+kYfy5boO5NlAUmgHWwd1vjwWBo0tQyVh5f7VeyPZ2dSZ5MFem+z8V317vPGS66vKNB+
	pdgy2WzQu9JxvOgUuonyuOWjFFGONONnTVbk=
X-Google-Smtp-Source: AGHT+IEoDHKsfNZjYJYHiPgDcwHYSGs1lR2jb/L8ZEYHKch3JPG8uNbquge4NeIL4yWvY+k0jKXftA==
X-Received: by 2002:a17:902:da92:b0:24c:cc7c:daa7 with SMTP id d9443c01a7336-251736dedf9mr17725615ad.38.1757136305265;
        Fri, 05 Sep 2025 22:25:05 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:788:b55a:785c:1e68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9e39094dsm82041125ad.84.2025.09.05.22.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 22:25:04 -0700 (PDT)
Date: Sat, 6 Sep 2025 14:25:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, 
	Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>

On (25/09/05 19:57), Yosry Ahmed wrote:
> I think Android uses zram+zsmalloc with 16K pages. Perhaps Sergey could
> confirm.

I'm not working on android directly,

I can confirm that android uses zram+zsmalloc.  As of 16K pages, there
was a way to toggle 16k pages on android (via system settings), I don't
know if this is the default now.

