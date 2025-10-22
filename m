Return-Path: <linux-kernel+bounces-864012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013EBBF9B75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B797056583D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC12222C0;
	Wed, 22 Oct 2025 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mg+cjNtW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901A20458A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100024; cv=none; b=Ewa+dracr5ERbV+QpLeNcLhWzLIDZDtg8UCqHIFyoTQYTUd88OElj14hBGn4ND49FXme4bjjOf5eyPOYncbntCbXVrKIH3/sL4P9ne+avUG/yyEajhnwzvgKZaAj7jAWUmu77QD8En/HgIQO3dV9A6BArtnn7utIqSal0yh3WgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100024; c=relaxed/simple;
	bh=GHDQMCS5dEWxKn+0Txm/veOfLoI8l83ajhIWcN5rWOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k27h1QakzanFZnetmGyEA+dAZRDLnsfNejitCI2n4RB7jScwibUpYtlnTNInECeZ1IvGvhbKITmbsU0SIVyZLHH0g1vKoRA5i9xxscVOgCKyrslY08VqnGvJmCy9xHrBzdbTh84WijqJODAs5sMbmAEp0C6GsvB0kOziy2ovmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mg+cjNtW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-789fb76b466so5263820b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100021; x=1761704821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqQzNiLchpkg3pgwyuDiy5UGt+eUDtmLfbzoo0ne91s=;
        b=mg+cjNtWy85MJ5yikxe1d5u3CQrZAjAaOamlRzfbcdkFc85wGXMOx7OimDEizRlL13
         txfW2OZvUMSY5eFEerqT7QTicfB804oqCBqCynrAlYUTxnsBqONIs7uIKiRQx1ktaOGA
         loKeDRjhNZyPV5Rmfbrl4X3ij+Zz7r2XmLJX/ilOvwgPp6gCuFVfiehV2L5iKcnHSVjP
         5PCELIx8MNhXM6fFehUhXBSUX35G/sCuqZ9nS7oBOqa/UsJPWmIfs5B6s5xwP1pBkLYb
         sjSYn6ux8ztx2kOSkpyBJ8c4L5WvphtjFNHRtAArdgUZ25ChBq3laCFW0RNTBtCty38g
         hTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100021; x=1761704821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqQzNiLchpkg3pgwyuDiy5UGt+eUDtmLfbzoo0ne91s=;
        b=xAADu9u3gPxoqSw3T7AhBXUoPYh+G5E/5GveVGEWhGbI4wWF7ZbHhdyUalqTM9aWYf
         uB8Rjwoyk/I/DdniC9If1s7kX53uzwYhesnyKt9IaZsVX+siFWfzzSVhbjN4l+RHlg38
         gT8YnCmwHXv1DRgqtjSMeWCB7FpLwZnVU/vRqQTczlerfl+tFIorPa4H25EZ2bqFHeRg
         rPdpzSJG4eAW0UhQ4mLEmXYDGfQv5Z+jT6BEHO4WZUlpXwa0uh87Y2L8v+8t2Lc1roSj
         0MgZPLKe4aUjLXM2gFH+7jWZjbUuhc94fro4ESxdkALkNiFHoiohTs8W3HDLZPOuFCaw
         yHqg==
X-Forwarded-Encrypted: i=1; AJvYcCUT+Ab7J7uiWrseCsE56acMIt0EhzebeHJd5QEEdmw4mGZVv3jfTDMeYvDac0qhpZakf5/cJsbwaC9rxFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDA1fqYp5M6cbagOJ2Fa0Rt60cyQMATa2XJ3QuI0yw8uKx05Qd
	fcfa4T/3WWvBgMLaHGjzot/hKndkquYN++J6kEf8210xywdekA2EBmE3P75oDActZic=
X-Gm-Gg: ASbGncvtbXYGF219TcfmDhl3M/CK+paItHD2xMiVeMMJR4oOJCasujq6Y+MV/pK3cF6
	1J15HELAv1/ENerVIv699Eyw/+ibpyXR2L6JwAZniVNJDwdZKaRVnN/luXxCaNUhM84RIch7xJe
	DFUmo4pXyW5x5jdNCKdcwYkweI6R/XbOaEtyzwMFl7OFgaCTf69gUiToC2IceKmcC/T0B+hrjgn
	kGr0v0i7YUE9IF2k+G59gXA2aXbGVactF75UgGE6Ti1gbrIR7B5+XEOKPPT8Eq3XveQzcKjb3VQ
	Tbrs3ISZlVlEB/t61QZCaI7R6xXg5/VGVJavq1KZcY+by5cvuD78zsP2ZKQk6JADbsHOdDAy75l
	1yIgGIrS323iw9tveanhF63cr9KiVAfk+gWEO5xA/K23zQePLsaAmRmrMG25h+Ytp4yBDNhzcD4
	cfAA==
X-Google-Smtp-Source: AGHT+IEiODVZTmpBKH4GJGfRgQpdF+p0v4t2QcX4SapXa+98D5HxqE/HG1opMUzT/b2Bq6W9RKZPmQ==
X-Received: by 2002:a05:6a00:2e1f:b0:781:171f:df6f with SMTP id d2e1a72fcca58-7a220b14d80mr26349244b3a.18.1761100020948;
        Tue, 21 Oct 2025 19:27:00 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23011088fsm12778187b3a.65.2025.10.21.19.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:00 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:56:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 10/16] rust: opp: use `CStr::as_char_ptr`
Message-ID: <75keuxnrpd2p2lumgmoxpwt42ovsx4xyltq3dimarvlspjq3gn@cmadekc427tk>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-10-ef3d02760804@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-cstr-core-v18-10-ef3d02760804@gmail.com>

On 18-10-25, 13:45, Tamir Duberstein wrote:
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=&[u8]>`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/opp.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

