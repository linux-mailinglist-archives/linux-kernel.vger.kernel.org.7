Return-Path: <linux-kernel+bounces-826136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF76B8D9ED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B32B189DC7B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED32641F9;
	Sun, 21 Sep 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cToEv8ou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748D25A35E;
	Sun, 21 Sep 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453786; cv=none; b=LYK0fD24SzDS2ZFe0kPXgGlHMWoFfApi7x/hwH6oteEsrhhjHwSEtMAKuFmNilIjN34i1PVKAxfYax53Rt3re7tabzGN6VCfpsD+l/vhyRoPc9evzyM2PZBzE2mN9RjHbS/XIe56PK5QMToMcnITGi9d3Y2PGOJZfimZ5evhxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453786; c=relaxed/simple;
	bh=xZADwwqDSNPHGEJ8PpQUJjxdyZCNqEbjTS3lQUkoZ3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj6hFcJJbvppHS1gWKZrL+nAWpyqEs8UVSw40dkRecBHvnVgCpOKfsrd3qm2iRmBMNt+igCvDzBqvZL87GGDgbkseZ5Hig9MxWup4n0uWJGqOQOjjNvcPaSVe9pmVFIDyTijkQTJV5geuFHqieDnsfbWFgbvYJZlGuMm3izBdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cToEv8ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7C9C4CEE7;
	Sun, 21 Sep 2025 11:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758453786;
	bh=xZADwwqDSNPHGEJ8PpQUJjxdyZCNqEbjTS3lQUkoZ3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cToEv8our3HW0yuRBchrTdZdREF/tWpBE7R+6dHrhUADoAZI1fXzLYdoSgjVO7stu
	 7xm+uhl0xTjXziRtB/xWwNj9yuYOR/70of4Om/taeyoa+qqBgzytEJozgfme8kXoej
	 BjyYO/HdtiK0uTJtSvO4L7xEYGXmfOklOymr2+ow=
Date: Sun, 21 Sep 2025 13:23:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Yury Norov <yury.norov@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v4 1/6] nova-core: bitfield: Move bitfield-specific code
 from register! into new macro
Message-ID: <2025092148-huntsman-existing-5052@gregkh>
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com>
 <2025092157-pauper-snap-aad1@gregkh>
 <CANiq72mk1-Ew11RB0kfep5BtB8M_5H6o_Rb2MwamrZd-FmzFWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mk1-Ew11RB0kfep5BtB8M_5H6o_Rb2MwamrZd-FmzFWA@mail.gmail.com>

On Sun, Sep 21, 2025 at 11:59:05AM +0200, Miguel Ojeda wrote:
> On Sun, Sep 21, 2025 at 11:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > And where does this allow us to define things like BIT(2) for values?
> > (ok, that's kind of not the point of this patch series, but it will come
> > up over time...)
> 
> We have the `bits` module since 6.17:
> 
>     https://rust.docs.kernel.org/kernel/bits/index.html
> 
> (Or do you mean something else?)

No, that's exactly what I was thinking of, sorry, I missed that :)

greg k-h

