Return-Path: <linux-kernel+bounces-826113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE58B8D917
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85085441C75
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F62571A5;
	Sun, 21 Sep 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhq/q7Tu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27284255F24
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758448761; cv=none; b=Y2EQuOHwKGP4eCXF0UYDBaR3SMDOLvJnBr0Yy8x630GHgIajGu5KrXTAZleM0DFb5fIQbpKvwFYEi0+ReLmyu2DPyfGByGkqpWSr3vZPfQ22Tm8KxxPiiDfIo3gcLkKjfcQLHSZBS1LfRIVGJkUb73RVPXKLmpoB+gKaX8ySMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758448761; c=relaxed/simple;
	bh=wQ4XKRzPEjC8IN9Dos/AJv1tyfP3n9GhDuIrZCE5xS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecj7ZiUb2DFccSvm9k9ESI0t4eXb5GELRq0dLBn+iW7kCyXR34htewSOv+lHYctDgstB+/XJvkYgap0aEV2fxfIhhglHulTC8P0ow+po7ez+/nLA3XbvRH+lwjHsUiRjBQVmnu1Svpo5NO5KNl7NK0HxRKtFYUrnjIEjj+HfCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhq/q7Tu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698d47e6e7so7439275ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758448758; x=1759053558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWKmsQdl2jsGwScL3RcU3RgGD8V6ji7p/wbvV6vfnGU=;
        b=mhq/q7Tuolhipn8mAQFQ/SjBEj3ebDz0SVo89ri0gPqIHyWjPlyLGw3H38qp17RPlI
         Au5OuqFTXwho9lARQ87YbfVI05BJwf6xhUza0RfzlumBBJrlrBzq6xpqdY5VnMtPPcK0
         IZApttdwP8SnHoX0lwLeHpx3h1ID0MzZ3tex5pUVfrrsCBBRSN/k8rQpHpCzawZap5Le
         q6KOvh5gxrzR5nf5At+UgBIR74bTNu3TZtqUtm2o3XhBIjtfqUi3TPiSJHYW0lpaySiv
         mFq1B24xpuZhViChx3+DYl/M9OWNAoZoiV1YDfV09sWk9Ayv7tBJVVlnQKwKX++rgwDf
         KrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758448758; x=1759053558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWKmsQdl2jsGwScL3RcU3RgGD8V6ji7p/wbvV6vfnGU=;
        b=GaUzMx2gdiWJKX+vM/fLhArWiOcoqF0cHJFfnGEtjTUOanbUABRBnSfK+tWSD8MJRG
         //05LHt+t3LYq42U7q8uNyf6/IcbE73cyQeneZYsKwTasI7KV1BoxTW1Ck6TePSMRv8p
         myVM3sPyU3kLxfjlXi38Db1C5oJw7Jjmlwoq8TJfcqlozp7VSsv/LB0ElAuvOZqxqzgo
         7VffiVHgNsTgJDBVuiM5n07DRj2yqJ+Ud8i10ruLqZ50HKb3ZDOtydlKIRQxfq6kxeWs
         2jPy5La+jz9LEj6DcFZ4N34UBLosXSgVmXnbp8ZZ0WS7H7Isshyps2TGGXizudg5LaQ6
         jh5w==
X-Forwarded-Encrypted: i=1; AJvYcCVaxVdcxxitEf/2aBds1obx4SHoDFlzg1YywWStquiiFa3FwzdVWuKNmSoCkkpfkYyk9a7u+0bzRFSQh1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrD9EA+ZoNSmC1nRv0+DJ41H4TNJ7WL8wI8lo7LYTtBL17pdYP
	4e9UqNgV+ujZmaNEHNp7TwAgPr8Spdd6+XC4V13uW3bE4oNBGWldHvdCm4UIeqyvI80EzFwAZPX
	VHKwUfkDL41TR9cyujvCaL82n3eAWpEQ=
X-Gm-Gg: ASbGncsHUslXOu499nzIXZL+ZUTGe1bgbkwUg8mfLeONHk7jMnAgZk0/Wnr3wEaVSHD
	AFCV+6fCykHsyDdbuiYi6q7+Irlr1cPSSz1ITMy+q4c7hw8Deec6QDv4U23zAupxW4CrBWk9xEa
	QRgDsKGwNIEaloyigJ+79lV9kB/dh3ln6jwYypokhLZCTtkeb5pQJHHsNAPrjkybUVu7Nz6AWiJ
	gaT6sPliLjgeXdg62WV3PrTlxm5QYvmamx7x48FgdnY8EPZJ9+iyQuPR9ANJ1A5fxI9JCWmAVmN
	Ae9aNXTgYTrkdlVTbXmHAhwhi6EBeYq8FUbk
X-Google-Smtp-Source: AGHT+IE/M5n7k5EV9oBMoTKSdZYNJ8k/u28SAzpBTSTXvI/1sciYsCvywr3oY6EDALdphOvsgrpqPOmhVakNTvvKCsI=
X-Received: by 2002:a17:903:110c:b0:266:914a:2e7a with SMTP id
 d9443c01a7336-269ba50450bmr70599375ad.6.1758448758376; Sun, 21 Sep 2025
 02:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com> <2025092157-pauper-snap-aad1@gregkh>
In-Reply-To: <2025092157-pauper-snap-aad1@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 21 Sep 2025 11:59:05 +0200
X-Gm-Features: AS18NWAX2coIcjtRAeKTjf4CFDI4YK6EYgm8hWO5NK1pOl2WGGAfjpcS8VVdy_0
Message-ID: <CANiq72mk1-Ew11RB0kfep5BtB8M_5H6o_Rb2MwamrZd-FmzFWA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] nova-core: bitfield: Move bitfield-specific code
 from register! into new macro
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Yury Norov <yury.norov@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 11:36=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> And where does this allow us to define things like BIT(2) for values?
> (ok, that's kind of not the point of this patch series, but it will come
> up over time...)

We have the `bits` module since 6.17:

    https://rust.docs.kernel.org/kernel/bits/index.html

(Or do you mean something else?)

Cheers,
Miguel

