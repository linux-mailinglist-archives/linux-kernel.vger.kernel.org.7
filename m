Return-Path: <linux-kernel+bounces-860709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B8BF0BED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CFF189F392
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BF2F7AD7;
	Mon, 20 Oct 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLtgBPYj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0592F5A32
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958632; cv=none; b=WQHzi87SE8z/wQIKjJ9b4If3f7jtOxRGHvplNrBJfMe2wFHAg7SO2kU6OVOwP5dGks9LP2G9lcncegS2caflu5WpBKzWZ2rTVvXZxxDfRdp3Pd3F73ttypcTzlBGqgk9Y9a/IQBMUDLQoXgEAH075INTM8znzXUWM0suk2S6daQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958632; c=relaxed/simple;
	bh=lI8ywgeWjN+SfCPlGDPL8Glm1CbFy+WFTO07L/mQ20k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGHjLUHAK1lpABwu7q6ri0cWNaZ6v/7cbcvLFR+1ZKSwXHjwliS49euo2YhI6mYiIuWZ3lwirBDnrgbjWrmCwWFUrNO4mk3FkYPI4ndjc2OYL3H4P50WxzF4nBmKeOlJVpxghNKeNBtTK8h8ceXETnJvqikl8bJd2nhlrb7fE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLtgBPYj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso38366485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958629; x=1761563429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1GwM38mh3nqijwky0hI3l2FSxHPE+1vxrvYPxKuFQQ=;
        b=CLtgBPYjsssf2FMbyyeFhWRPKnzicPMUgyn3lx9LHlp6fN0SBUxAn65ZdYDLgkJ4DM
         Ze7eA7pA3s+Fk2kuYVGQ6mz5mHgkGiAlwS84sOuDX4QFtxcSuc3rpFaDyBu6bhWUrC1n
         nTRq9KBefDuVpbdP6LZdMHtZqLTWoGx/bQ58OZ85WfLqEbfs8UHGho6C6ZmQEluLx167
         fop85s3plpPTOCB2r8wJus0hXD8Ed89Jlmp+GHR3sMEvbM5wIlwillNaUfRpK0glgmQy
         +96EfQECpoXVEN33UH2wQGGcFJm9QRCpce+ZpRJAwA6o05Gn8G5ngFsSn7U+Cfq952VN
         +roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958629; x=1761563429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1GwM38mh3nqijwky0hI3l2FSxHPE+1vxrvYPxKuFQQ=;
        b=ntBvF6vE8FrKJe3yNBFJfEJq303eOvf08kRz0R5/0LzV6s1+3ZAh+hGLa5ZcnJ9jzS
         Rau3vm8Ly0R/EYm/xp/X7O6kwQzCy02GU7/dgG5fVIsDSUhCMa/lpepnODI9r/ANybRt
         lg73yMgHGLdA+Pf+zOzHou35/SSQebW4YGX19T7DIw7ycQNfQZOF+qx1NmIjb7Ll75us
         1lmMIHcQHTeTjhYXH7FTwgJw9djgM8FViEFCq2HUr0VulP2ruhjddAI0/0qL7Bp4V/yD
         NnpMCL0Z9wKUkXCYHGuFDXEJ8CL2MP+4I6NXkaEcGqU533wlCYpsXIlOckvAGPbX6WB2
         dcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU6gP2O8Km61wNQm1fqYdCm12QzltrzB0yfcf+Cl88xwW+k2iewYyNZcm78AfOM4AP5K7hJk4RIlf5m7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuI30LGFnO6eYCNWGQ2taubTxEjKGJROzE/B2mlhRB1fGhYA3s
	/tV4HFVA7ZKFNjd8h269zkVm4fd5gArfrypkx2Uqjs1f49/M9pZdx9OH
X-Gm-Gg: ASbGncsHVYj/pOIdMSP2VNs7IE5ur06FEmvTTJoSonvrpRDLXlinGELiE83D99xxFEb
	iiA/qSIKab694wtuLXfWPhoJQCbTXxSQa2rlnzSr32Ifct1qDt+mYKn6E8ZBwro/soH2/MPKiTI
	PGaWnpd1jB1RB6sHiEnU3Z1xJETZcZ9yZDoQg5iEdT6lbzp2FBKWPVkKkT4u7Fa2DLurON3pV0k
	aG+/J1S3V+ap5rkRMHdSk3AE4K3hpAmzI7p/GCwLRYWOQOEVXV4iiApP0ZJGBKSRd6MN8M4RpDX
	KJxIMq4JAOmjlkJzprF/BUBvtIu1L8NzzMo+x/HuuC83wER5ykHWWYy3dalWPplJ1cXNetdQ1q/
	pcQBjbYVyxzRTUKvqqRhHzUvmsByHrxLrUsOQ6F1feIcZzH5ck7//1+m/W7iRawjxQc09vD81zP
	XkSXodZw==
X-Google-Smtp-Source: AGHT+IEmMMoOjYfBUT5RqT6xtTVyMvQoeiu0xyX3gRg3r0UUnIXnqBqTe5A7yX+Qs8G91aoDug12qQ==
X-Received: by 2002:a05:600c:8505:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-4711786c71cmr94484055e9.3.1760958628958;
        Mon, 20 Oct 2025 04:10:28 -0700 (PDT)
Received: from fedora ([80.195.98.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm218234765e9.13.2025.10.20.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:10:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 04:10:26 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org
Subject: Re: [PATCH] mm/vmalloc: Use kmalloc_array() instead of kmalloc()
Message-ID: <aPYYovFBtHYKpgg4@fedora>
References: <20251018201207.27441-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018201207.27441-1-mehdi.benhadjkhelifa@gmail.com>

On Sat, Oct 18, 2025 at 09:11:48PM +0100, Mehdi Ben Hadj Khelifa wrote:
> The number of NUMA nodes (nr_node_ids) is bounded, so overflow is not a
> practical concern here. However, using kmalloc_array() better reflects the
> intent to allocate an array of unsigned ints, and improves consistency with
> other NUMA-related allocations.
> 
> No functional change intended.
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

