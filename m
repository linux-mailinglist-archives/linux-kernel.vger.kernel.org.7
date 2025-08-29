Return-Path: <linux-kernel+bounces-791136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893BB3B25F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71FE3AFD47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0C21019E;
	Fri, 29 Aug 2025 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUIV6qea"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117D8488
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444803; cv=none; b=fYtnaRa86AvwTdRwStoc8OjTw6voekmWoJivEQhIzfhKZZK880Yjrf5gGhLuBiUE6Sr93WKWLUl1js9sCZRQa/NRGjrW6R0gFDsHb7q8PIIfDKmlEWkCCs96u8RGyALW8GUj7yp5qrqYX6dDRVOl60niG4xrnVCuoXhADf+dPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444803; c=relaxed/simple;
	bh=wknwVsea7dk4TZRwIgYgEBL1gm061dQg4hfpunhqPGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTp+BNeLbQnoH75HHR6yZnCa0+Vz8oCKH/Gdi1ca04e5CQoEdcwyqx7qpJL242f9iKS/CyKZojywvMZbkzkIIALzAmvUD+/vkE+/B+SZr2jaxCis2XUkBc4JXfZ1a+g8bVDYZzGAZi7ntWdy39Pbn+l0HOWoqS7mgHNkTq44GMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUIV6qea; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7704f3c4708so2088024b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756444801; x=1757049601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4CA+JjSxoJjZGOZZpzLlfb+zTcQOsCT88TOzSkzLZw=;
        b=NUIV6qeaavh8DE+h4Gr/Ht8K8VcaDLPeaHddGAd7uLtqkzjaSBIzYYwQoSoQrOdtsP
         0k9cwcOc4NMJgyYj2ybQKXc3Dlv0oinhZR9TuX3mIg6w6A4JWXr2wrxc5xrNvgYBkx3D
         3bVimFroah4pJUKnPiPlhMKsqOEiJTbfBep/ixn5ULw7BwjiTQsL7oOf0Q/sym99eoMs
         5WOWwuFqRdYTbgIzKYHT/rplEpKpWwX7+Zi2gnCBJNft4yQgsPCdnJTZi7kIeICHRW0S
         TD3ZH9l2ywLjxp8hyXhW02AMu+XewTsNYvUv3fV5rauctycl2qdmNnQEx/0hswCX6xIZ
         cOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756444801; x=1757049601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4CA+JjSxoJjZGOZZpzLlfb+zTcQOsCT88TOzSkzLZw=;
        b=ZPVTcmBRIbDWx59brLYUyd4TWmdWfk2ZKapsdkfWOSwW4LABGRaJGDPYoYkzd44fGa
         +u4xhONac/4fGeqP0LJj2Y03BgLxmkYGrETTPY3Kj0tZ0HacIdyZ8R9MRqGpG5umpRhO
         ees3piJfwrGk/37wksWlLBXZIrNFEEK8kCjfqi7fLo8J9eozTSb5avWJjcVJhhu7yl/a
         +4sFnzdpU+B1XDrjIFBjNBYwJjEWEoiFFzgJhJL2yx/78N5AMHttl/C/7uT4ddmsqT4x
         MBRqqXUeFRJgDFDMMhHWiuPSqMiaY+4cuKGQEVlmaLVr5tD3DzWi9LH7Rk56eaxyf1c7
         4g4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoEZfkmzFsF4wBn3IAQiR3Lpu//eSXQkjm1b7r56ggpde5YLZQHNCirh7bzOkVPYC+ksUHTI0er8wnzFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SnK+D1wXU2F5aRBJvROdVjOOqJACycoGuqtGELJY7LI5ZnIn
	17JOuSDx0W+U6551neqQYHuSWrIxagqVd7xpJtqN4A94nbLbF9MCvSaHkR2qWd+Mawo=
X-Gm-Gg: ASbGnctiTAuI8zOBVis07wOHX1gBeW19L9xcDL1xuAQlRg2PiccUfGhLJ+CbJrNDBjT
	lVcTJeQjZPaVU3BH2W49TGMysgIptcpaHRJtjEfk0z0VxxJ2UKb+tUbfQia6REq/Cc9H5Y/Pq9H
	DsLqjFe/vWAPyLq4Dg4N16KT8N5YQtCblu3QqQHMAhuFSiBSD+Z/A8DM7/HkrfT3XfeM/fweXfF
	ftM0H7E9zs9TONkJlTqCDISIisygM9Ga2FiwuxamPs0oCCpCHYWPAh7n11CWHkNWRoRORnAPjMH
	4Gsk6op82kDNsgtKl8Zy2UX8KWetMeOXARfcdC4aJYxHqT6Psxlq47V3V1Ya9HQsgf72//WXpj7
	N2ONpxff8mTczRTuN8MsPlzsW/JvxqIqsHzo=
X-Google-Smtp-Source: AGHT+IETrKdzQi92QZKgjAfQhANfI2QmqLxzCiedM4++QowtrwcfkvZwuaEDKRt3EM2lOAmU2MJx8w==
X-Received: by 2002:a05:6a20:7291:b0:243:b144:adaa with SMTP id adf61e73a8af0-243b144b09emr7531411637.54.1756444801693;
        Thu, 28 Aug 2025 22:20:01 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006c340sm1082278a12.1.2025.08.28.22.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 22:20:01 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:49:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mitchell Levy <levymitchell0@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/7] rust: cpumask: Add a `Cpumask` iterator
Message-ID: <20250829051958.s4635ztvmctki7ol@vireshk-i7>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
 <20250828-rust-percpu-v3-3-4dd92e1e7904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-rust-percpu-v3-3-4dd92e1e7904@gmail.com>

On 28-08-25, 12:00, Mitchell Levy wrote:
> Add an iterator for `Cpumask` making use of C's `cpumask_next`.
> 
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
>  rust/helpers/cpumask.c |  5 +++++
>  rust/kernel/cpumask.rs | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

