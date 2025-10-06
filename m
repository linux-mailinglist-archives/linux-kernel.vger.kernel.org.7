Return-Path: <linux-kernel+bounces-843542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F325BBFB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80C2434BA5C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6651F7098;
	Mon,  6 Oct 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAyFTRD3"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885501A9F82
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789769; cv=none; b=TsLiljIipeuyvViJnXv9mbvw19juZ4I+crjooiROsQ7pVXm36+/KgL8oJw4nN03hRad2kB1mCqoeO87CHai41iTp0sCcgh3r3Ka9o/Gc9hAJ8exa4udm6yS1We0smYxoTPZhlfS1xjDtSGR4tZietC68PHlmcdOunbn/0rebqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789769; c=relaxed/simple;
	bh=mFaBUuFsiRPLWNcrtm0mYjeFmk0YgNWS4VulFHRDEJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMTd7chRXG6HxQ8D2uHHVq4ROpdOOgRwQlA9WTqKyl8lDhYMfAd7HYAxzAwvA/82kunf5J9lwTz4DelYKYHO/Cpu4M+54cvOTsfHLqcnEFeEjQiwrSrNHa0naDtiwzCh1QhYI7SwR82v/TsD8Lu5okTyBuNfaJpUe4MhSVcDu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAyFTRD3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4db0b56f6e7so58788561cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759789765; x=1760394565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVmyDp3clLGLS8kIW7yJXXQisPoyp+nIoQv6rloL8GA=;
        b=bAyFTRD3P4l/cuUJhSyHgJIYruvNH05P/gg28FrSBtp4pEUVX+3dZPXVI29eNGAaJf
         kGHGFLveS1fPIK0To5gL4gtxAajE1uQ7H4iNtbNeyl9EBceDjpbyxEsGfMFobUzvfBRU
         s03pVQIwvNpJWF/ruoUkdKLvyPHP7zwMFMF6Mq7tSRTuafBU+iwcwcG4EtL/oc5Md2vo
         gjIe37zg1FLbz34Mdm28MFIG1IN9GpPCPyAX/elxPbrjhWLIOKZ9Faq5KgmlfyoPMNuv
         TjwL395AIrE6KSOFRdJhqcnq/Vj9X4ZTN307JkxDuCKzYpzdTd8Amtm68ciKEdEEg2Ur
         pKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789765; x=1760394565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVmyDp3clLGLS8kIW7yJXXQisPoyp+nIoQv6rloL8GA=;
        b=GYJtg6HS7ys96DuzGM180GzwS0xUAcbbQWod6k5+b4MTdduMe7Wr3oW+mQb70ZQzoI
         z32qfDp6VQVvok7rwAeKIR45GQyFVfbCKA3wWFr1bMfiZ1VdhGF22w04JnVK/YrWd2ju
         Yu7M8Wj49LkJUzQEdscpATH0di7vC9UelY2ET7rKgyE05eDqQxKEvle3+8+xdc12ESmI
         vHF9PZxzA4o8GsGTkHFlI09IUXvLM0nznk9XEWf+k3zW8shEorcNsd1NRbGlTDGzz1Cz
         2WZWmxFaEy8qOg5aThMEzBPKZpc+KeUlxBgIR7b9EWgWgFcIo4NQ4Us9scjn7/gfLjw8
         KLng==
X-Gm-Message-State: AOJu0Yyi1KPo9LqzXIjsZBcqu5TU9Q3zl5vFLcddfZkf7QQKVvCIO8ki
	QGgw1L2a2iVavF5YBOBASNBiS02HsVqw0/szonKlql+l76WJ294wVMcq
X-Gm-Gg: ASbGncvj5b+7QFobm34Wv24LFPT+L1J5rlkhlz97EPn4bsxvN83ydmBbps6K2RXIck5
	ylfNCx0GepRrXeFHS75mmBVR3h+tiEBB/b6qC16bgrDUTdX4RiwJmi1R33me3+S4FLCDRpfKyuD
	iqZ67FoU0rUguLhCf6Fhe/dFtMKOAYfNvnb3Zj3Z8fwJ79jTEWAqAFBM4ILeRIIFlg/53JbX2qa
	+mTOuyq+VjORhOUolLeIbuSNOlaGpmnzs24ZadMyGJox+nXX378qoHrUAzU68bmRRa14jUcEi/U
	uKdy3AsF/A91OtpNAGeIIlmjxQxLS39tOchQsxQWkBKyedyZXnYnjco+eudmiqHde97qdlurtv/
	JvR6Q8APQYpmyg94PJBAKRMyttqeVlCeFo/bG+epL1gE=
X-Google-Smtp-Source: AGHT+IHPqikPMwG5q0hEpff7no1z9szaNg+f/yIWTC45aDjchAEueYobJpT+cU5Ru6SV8Xq4v0V8Ug==
X-Received: by 2002:a05:622a:1807:b0:4ab:6e3d:49b4 with SMTP id d75a77b69052e-4e6de794646mr17493561cf.7.1759789765354;
        Mon, 06 Oct 2025 15:29:25 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e77bcsm131484451cf.24.2025.10.06.15.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:29:23 -0700 (PDT)
Date: Mon, 6 Oct 2025 18:29:21 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dakr@kernel.org,
	acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Message-ID: <aORCwckUwZspBMfv@yury>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003154748.1687160-1-joelagnelf@nvidia.com>

On Fri, Oct 03, 2025 at 11:47:43AM -0400, Joel Fernandes wrote:
> Hello!
> 
> These patches extract and enhance the bitfield support in the register macro in
> nova to define Rust structures with bitfields. It then moves out the bitfield
> support into the kenrel crate.
> 
> Since v5, I dropped several patches and only kept the simple ones that do code
> movement, added a few features and added a KUNIT test. After Alex's bounded
> integer [1] support is in, we can rewrite the dropped patches.
> 
> I also dropped the MAINTAINER entry for now, pending more clarity around that.
> I am happy to maintain it, but I need more input on who all will co-maintain,
> now that the last 4 patches were dropped. Perhaps we can maintain it was a part
> of the core rust-for-linux? I suggest let us create the maintainer entry once
> Alex's bounded integer support is integrated but I am open to suggestions.
> 
> Here are the v5 patches [2].
> 
> [1] https://lore.kernel.org/all/20251002-bounded_ints-v1-0-dd60f5804ea4@nvidia.com/
> [2] https://lore.kernel.org/all/20250930144537.3559207-1-joelagnelf@nvidia.com/

Hi Joel,

I returned back to v5 today to just find that you have posted a v6.

There's just 3 days between the versions, and I'm pretty sure most
people were not able to even read the material. Moreover, there's
an -rc1 window ongoing, which means that people may be busy.

You're still receiving feedback to v5, and this makes even more mess
because now I'm completely lost about what I should review and what
should ignore.

Please allow a usual 2 weeks between versions to let people have
a chance to give you a valuable feedback.

It seems that you decided to drop some material, comparing to v5, but
don't even notice what exactly has been removed, except that vague
"code movement and few features" notice.

Regardless, I don't think that this is the right path to move the
bitfields into the core. The natural path for a feature that has
been originally developed on driver side is to mature in there and
get merged to core libraries after a while. Resctrl from Intel is one
recent example.

With that said, I'm OK if you move the bitfields as a whole, like you
do in v5, and I'm also OK if you split out the part essential for nova
and take it into the driver. In that case the bitfields will stay in 
drivers and you'll be able to focus on the features that _you_ need,
not on generic considerations.

I'm not OK to move bitfields in their current (v6) incomplete form in
rust/kernel. We still have no solid understanding on the API and
implementation that we've been all agreed on.

On maintenance: no core functionality can be merged unmaintained - it's
a strict rule. While in drivers, bitfields are maintained by the nova
maintainers as part of the driver. If you make it a generic library,
you need to define a responsible person(s) in advance. It's also a good
practice to add a core maintainer as a reviewer or co-maintainer. Alice
and Burak added me for bitmap/rust because I already look after bitmaps
in C. You can do the same for bitfields, for the same reason.

It looks like you have some offline discussions on the bitfields.
(Particularly with me.) Before we move forward, can you please wrap
up all the input you've got, so we'll all be sure that we are on the
same page. Right now the process look really messy.

Thanks,
Yury

