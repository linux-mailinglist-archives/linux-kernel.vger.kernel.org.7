Return-Path: <linux-kernel+bounces-864609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D18BFB2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27FE14EE3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E632289376;
	Wed, 22 Oct 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J45qznwe"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A3350A23
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125612; cv=none; b=jM53ErBhuaASVi3UbbNQy1e/VPmLcUK453KvS55Fpg17qL5IZ6Bi4BHgYgvtxAgPjEK/YalNgSEzDo68AgPiDDNkG4tEEfsDOEjOX8CcEZZ4zhBeWvyBAUnHbaRPOVJmTfIud7fdpWnJK+/GQgRqrm5ragboVbbKCYfjP6cVIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125612; c=relaxed/simple;
	bh=bORZD0ftv7lafNnlIcD9A5BgmKTBJMkDSOwHEr6W5TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfJY2TPwg7gtcmOZ12EOebMhI/98JXido1amhexl/80CGgAJiQTlC0CpH0/4tWJgk+yHqcmPiTwms9xHUvuqaCIsMZwxpQZHfPzVFnmlpC4qj1j0SsNQYi2J5e1lBufUg93p7/+IKeu9y+BOorpi4S/NbMkSZHl+LuNgfRLSbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J45qznwe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b67684e2904so4714089a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761125610; x=1761730410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bZO3gd3aaKtlSHxfTafUpJfSGcnBTUPfcxPRHPTW+vk=;
        b=J45qznwePGQb3za57aey8i0LRLc8xsfRXgWsBiyIB6dnYdgEJJaBUA+ya8/BZW7j8K
         mNSETv8mnpBNyBNM/ImjFozXv5aYZL9hX0S3+0inWDw0VnHquhBV5wE7GkUrrboYUvNy
         WAZ6JdDsaU7Kn/yQuBQx17u2kCvPdNxZj5n+yN7xyS0b3Tdj3JaeE/vAyIH68oZ02rUi
         YkXU1S159J7Z6R11h1paEXdpIkz+iLmjk3ooNkd3gotvEfOSTsOAPnm+kgk9LA8BWZBQ
         sMvxdA+jj5yGJ5xPHFgbX/xxbXLoIxCkRTQsBxzkzDqd8g0R1Rf+aKOAbjZX8sI67UoL
         Wh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125610; x=1761730410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZO3gd3aaKtlSHxfTafUpJfSGcnBTUPfcxPRHPTW+vk=;
        b=lmLzYpda2fj1WCmjpvKN8BmcvWTYuyR7QC0mpbgb33+1bZ6JgxYQLsqo3DUpSGL0dv
         wiN4zdCmwicq4VGyF8iBbjgcGHy1sSvowsn6M3fu5ncJ6CTlZaBsCU+8zw6LbtXJde1X
         /KsA+ajzCdBguUevTK4iYydP609Elpubiqb9r+V3jhOKHb8llJKwYykK0+IQmBHfHnwb
         Mx4VXfD1N8vWTloS0L407xAzivtFbpzWE9VlhMVdrJy8hFUPypkK5NMOUu6IrQM7SBsT
         ccOMqJFjhNApMvnLPf5C1vLUVz6rGvKDY/Mm+WFFcReaJxevjOy7T+xvXXC4pKcgEWYl
         OhtA==
X-Forwarded-Encrypted: i=1; AJvYcCXNsnch/X+URu7uG5ik3F6bKDfigcivE3U1MakgXHuKZIefdxUSsCPyGu6ldzH9xVhelJKs3bg1fZLEH1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3Ch7I+XWZcFzSjgWG4x9N6aBI78v4DgqUsrDRP1PrPkUMp+B
	tXnI0Ngo3ASCAgfsPSlOkSIGZgRASISM+ze6osfCeC5QFcsB7vL8s1yR+qTj945LYTI=
X-Gm-Gg: ASbGnctemaaispP3gVglh5Lr9OeGuHfSQqM3T+SJCpTy3uh04L7s1Hz99mv+vurqQ/P
	k/wQH3ULLft8svzHjOfAf41BRONFF4zje7K1jwo5UiWRhYv7uLPWznQNWlKCD/gfmkM4PQVBxUK
	mS/DuSIdvRjolLnbxntmmNj9UPjOQX7V3YhudZjPhs3lca7AOGnv5w55gaygNsGrOtQvU498zsh
	BOUgsJNwp+AvUFKL8NHcYkT5lXMDSiPUuEAId/AsM8ZTX73dqPXGBfS/z/bxmGP4BM195HyW0Nj
	vlZ00q9fgXnDtZadnsoUZ1xEhSFZ0E0tp9Si1N0Kx9JyufwdbemrWh73PICBbwwLrgEJ15tqmRm
	Pv4GSLwhR9jTjylQavyXJlUjHeuX+ec6hyr/bDgwFKCt7+I27mkKcjLHVU7z2IVm3/ZPhf9AAsS
	0BpOT60XlcbAFp
X-Google-Smtp-Source: AGHT+IG0h0QLiAXdO5f90+3enocmFMBYwXQQom51lDBPViwF3k673sJ3nLkZON4IZuqLIkcwKdYDtg==
X-Received: by 2002:a17:902:d584:b0:275:f156:965c with SMTP id d9443c01a7336-290cb65b61dmr234660325ad.52.1761125609766;
        Wed, 22 Oct 2025 02:33:29 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd5d76sm133879585ad.39.2025.10.22.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:33:29 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:03:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
Message-ID: <jnpqitx2yup2cvt7ey4b3fgzsi62i2pkasjxgx6xfi2r45hhhn@qqle4nvlcbu2>
References: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
 <20251020-clk-send-sync-v2-1-44ab533ae084@google.com>
 <ghaqgzgnk6mkv6tm4inm2e24jyidsk7qhbff6zwc46kefojw5p@3jvwnn3q4bxw>
 <aPiTm7Pb9WguOd9j@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPiTm7Pb9WguOd9j@google.com>

On 22-10-25, 08:19, Alice Ryhl wrote:
> I'm guessing this means you want me to take it through drm-rust? See
> what I put in the cover letter about choice of tree.

I was expecting Stephen to pick it up directly.

-- 
viresh

