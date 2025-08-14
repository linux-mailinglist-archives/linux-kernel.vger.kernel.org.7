Return-Path: <linux-kernel+bounces-768226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CBAB25E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D946562EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E232E7199;
	Thu, 14 Aug 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkEm5sQz"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210622D78F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159188; cv=none; b=WGnrQGhHWImzh3cPgySlSHmAlKQkE9diRLL/l3wjw3OxmaY1npi4Ky3zZDOtkOkkTucfRCZI2Quzmd0Y7M6Fjt2i13WJF0ozJSyM+xS95dWGKfz13vX/W5yUee4heJ80QYysIP+/Tgx5sjptNtr51SXr0Le+k5CwuCvnPEjMduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159188; c=relaxed/simple;
	bh=BKeIEPdgx1Yr0aP+47s/5kOZDM0elo0Ce7jkvP34sQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dYLaKCTnXo/dKpwUH0zX2B2YMtx8UvWRbvShmFZ5I0buUOLFy++Leo/OiLphrYglkaKKsUGATg3Vcun48VEALaA7POlnMSFUVUFYt0uGd1fSs8Jncy9hDbxC9vRFU/u+lDwYDpJ2Df8ap1Doz2FUpjqjq89npf+BFI/Tz9VQ1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkEm5sQz; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-afcb7ae03ebso56769866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755159185; x=1755763985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUVJLjhJjYfPZGYawsfN3qdob23UWt0Rkn4PBgxrSwU=;
        b=AkEm5sQzJGOKq+F2xY49/ijTTW6Na2jfQu/EM0rhVTTk6Fa50trzcZ4hIg71W8KhMN
         5E1Y2bBWpEWPeaLMZg0JaGe+7OKm3yzuXxjUYEFMR5dKOflJTWPmsVBHMLqIAQC978sr
         w1L5SGLI05ZocAWWfi31iV0AbVKrwfhn96tpj09bMdMZJ0DrCJK1HbMbpd8Eau67GPla
         sstVaetvpym38KzI/7pXIxrY/VbF+/9+pCAgh6+RvNkTwGygQHNfKHynhmfeknbx6l9G
         p5Zgu/0lu4LFBGD9KCv2ggCIq94YBUwE84iyx0Jn3IcMoMkODa8L4F+2vf2pj0buZ9iq
         dCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755159185; x=1755763985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUVJLjhJjYfPZGYawsfN3qdob23UWt0Rkn4PBgxrSwU=;
        b=pgaw7KdLN/UtRfSQNyIgUyKTvxPeRAf70TfkciHlxdNfkOZ7Rp3p5n2Z1GTT37RdKk
         lTmKu8dP6mOr4f4+XGw5LccQkJmW145SiKSmYl2k6ON6Adxa6DPdwDNnpvZgLiRo7Xde
         x67kzL43x8vvdejhoqZi0NU9uSJnRtZDuCiByRAGfv+gK4o/u8E38J+trIspqF71NBcT
         XNoVOYwaU31TUkL5K24RZ34f8jsn0FC6M9iyNZzZejC6Mc3wWTWTwO3GqgTqWvfMD9bd
         cMKk1mJ1RVNWreSBoky6mV/MXeLpSSUDmiI+9K8eWWmPwTMBuiwdzCrZMKJU6HEVywoJ
         uGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrx/KmNQxZ72mZwnhGMmBF3EQa+6AXIkkA9DfbdWd0W5er2VpavGTePT1X/eOdceajh1q7E34NvVz9mG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoURHFdPFur+clt39cKOdROm+DLVCtiQ33OArHLpisK4THd8L
	xcs9gcgT9AMTv8q8d+x4+NU0Hp+BvlWkKN7Sr+gbbr+epxD+kPicaEiljd9G88nhW77o3yMS2yW
	OnfDvARIJzwgqaBpE3w==
X-Google-Smtp-Source: AGHT+IGDK25s3mGVbqV4mde9ao+gXJj5qscZZLzoR07Uks9qBQi84mrlQGWiLRHKrTfsHPo8A4vI/B2xpju3rbQ=
X-Received: from ejcso11.prod.google.com ([2002:a17:907:390b:b0:ae3:5480:d3fb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9623:b0:ad8:a329:b490 with SMTP id a640c23a62f3a-afcb97d3e31mr183972366b.23.1755159185217;
 Thu, 14 Aug 2025 01:13:05 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:13:04 +0000
In-Reply-To: <DC1E72OCYMMU.1C1EWX0YPDEOT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812130928.11075-1-dakr@kernel.org> <aJw7sx0p0Ec-oLkz@google.com>
 <DC1E72OCYMMU.1C1EWX0YPDEOT@kernel.org>
Message-ID: <aJ2akK9rVo2XwgQB@google.com>
Subject: Re: [PATCH v2] rust: devres: fix leaking call to devm_add_action()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 13, 2025 at 05:07:41PM +0200, Danilo Krummrich wrote:
> On Wed Aug 13, 2025 at 9:16 AM CEST, Alice Ryhl wrote:
> > On Tue, Aug 12, 2025 at 03:09:06PM +0200, Danilo Krummrich wrote:
> >> When the data argument of Devres::new() is Err(), we leak the preceding
> >> call to devm_add_action().
> >> 
> >> In order to fix this, call devm_add_action() in a unit type initializer in
> >> try_pin_init!() after the initializers of all other fields.
> >> 
> >> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> > This looks ok:
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> > But can't we do it like this instead?
> > 1. Allocate devm job.
> > 2. Initialize inner field.
> > 3. Use allocation from (1.) to devm_add_action() infallibly.
> 
> Theoretically, we could with a few additions to the C API. But I don't think
> it's worth and I don't think we should do it in the context of this patch.
> 
> > This way, there's no risk that the inner value may get dropped, which
> > could be an expensive operation.
> 
> If we actually fail to allocate a devres node on the C side, I'm not that
> concerned about having to drop data.
> 
> However, there's also another reason why I think there's no need to consider it
> now: I still have the rework on my list to get devres callbacks in place such
> that we can first revoke the Revocable objects of all corresponding Devres
> objects, call synchronize_rcu() once, and then drop the contained data in-place.
> 
> In this context I also plan to directly embedd a struct devres_node in the Rust
> Devres type, such that the *only* allocation that remains is the final one when
> the user of Devres allocates for the final impl PinInit, that directly or
> indirectly contains the Devres.
> 
> Once we have that, adding the devres node will also always be infallible.

Embedding devres_node in Devres sounds look a good plan.

Alice

