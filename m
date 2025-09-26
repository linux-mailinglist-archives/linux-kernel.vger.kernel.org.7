Return-Path: <linux-kernel+bounces-834549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43BFBA4EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43864C1652
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56CD30DECF;
	Fri, 26 Sep 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir8tCqGS"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB130CB2D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912378; cv=none; b=e8Wic4m6kLmJzsOh0lfsuNRSFZ/M7+3oW/o+lzX3zGwraXigNiojS90egFc6uuOOoTi9EC5QnOkTa5PLD0ikELQ/btNTcfqp4ll3apQBoKqZBd/zxaN6Yv5QYWDRrcuSG7YOMftO03uc1e/OcwGq7uBBo1cthC/1BFHMAblGVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912378; c=relaxed/simple;
	bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOLAhbPLmmtDQR+KafL50W/SxZy6yGvVO+zSF96Fsi3F98a+gZOsEH8J8X8ys4IYzqFV9JZ7lgyGWdnnUEBF4ApA8gx4OEYxL4PQ/KeRNanOl3OeWDCEop46FfcZ7FuEe/d7FcWydCb4QbUv/oyrVD8eHZ0tTe067q7vrf0mrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir8tCqGS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26808b24a00so3504255ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758912375; x=1759517175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
        b=Ir8tCqGSjY7fG2+bMbC96eCICN3DWieYr8p8kZM26oAb8TrwhFr29tYMG/ONxQzbhI
         puWXlM8u0Q/ag9hzXKOcnG1H1gYk+GWzOmRqMqf7QZRDOhSEBjPgwtjTGkIuxzGNe76m
         senx55Q/JSlzOXZdLQGNP3dWBDTDFPDc9TqBj2LwayJlJSz85XEg6iYkKtAOn6cEcejK
         gZdDrDv4o0ljXNe4ocrYkDiz0lHnPxTft6uGPnUXIJA0bMU3+UDSpSEkJrLr5/ipVEZ2
         k8xjcViUkWhGBy4OvfS093phtP+nnKdokgXmth9qax+zdJJNV6oYPZaGVtL6zKq5gg5o
         Y6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758912375; x=1759517175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
        b=VR0scHNVxshmTOC9Eq0xzQNIC6itx7fIHuDls4JPrEK6xw69PTs+r368eWnOz+UGp8
         TxeOUxy3RFX2qNhUDkWbQPP5LV77uNTFHulDLIR+nJNyWXoreW7acQlU7zw6vmbg/334
         NSicBYK+hY8awGzEm1HK5K8ZuP+etC0eVjdh1e/mrrLg9k9Yac4TxNLL8f+e7Hdr7q7R
         UfOOuGdt4Pp7a0Rrl7rX2flLbz1nx/FViASAsCa+DaTbn7fDOZy0O4Oiuqz9jsTDroNS
         uQ8360SIfu6IOy3L/L5ojZcwZ3jl4sq8t6T3oIjR2DJij4/PT84tSD56YnUByUfBtleD
         82wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6lhzSqwOluz3cwRLbTXckflsldy0nZr1txSWSFEnvZ0+uSiec2LFl8MJ3ixkxXr0F0DlkeERGDDAKmbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPhL+A8z59KP1GdwGzC+a8YV1OkSDbL5cvgFHSeXB+VsHnByt
	9Pj9AUZjtneoIGbU6BdpmlKMRKSq0WvHl/ePTQegeezdDYK5kAa0GFr/IfPAbffVBnHeGiexmJd
	f0suArbMrUPFNBNNyvg8dP3p9Qmvtfpk=
X-Gm-Gg: ASbGnctBBFjO7MUEiy4O8uqZhcWyAW5u+aYvVGnilZvFXQjEhzpEj4FfXHabk+dKcUo
	LRHDQpRkYc4EXgb3y24/6xk1/zN5gjWUcA/GfEQmCTYWhmIAURcg1noSOiRrG20HUd6UuuvRPMj
	6n9CzuOKdWVb5hOc6PHZndeZHTGBpqwutm3x3oz34WLuP5KU/Skcjm6xfJ40OUfTkXTCHCIXPqD
	VHplvuPoAf2WfP68267h/3digqCz78SEMDJ0ZOM3+cSh1mOzRnc7EcAA1akMMApywrzK6CtMqT6
	pDk2+hncmi5B+t89dVUNVQbpvA==
X-Google-Smtp-Source: AGHT+IGICCMscDDR09yJt5H0iPKTO2HVhFlo2/cy7JDDWeiBMU3GNUjCo5LwRgqW0USPT3MDqhixj3g/rTT4Pi3J0GM=
X-Received: by 2002:a17:902:d508:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27ed5b0a538mr51481475ad.0.1758912374667; Fri, 26 Sep 2025
 11:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <111409f1-33cd-4cd1-b3fd-e38402a82c9f@sirena.org.uk>
In-Reply-To: <111409f1-33cd-4cd1-b3fd-e38402a82c9f@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Sep 2025 20:46:02 +0200
X-Gm-Features: AS18NWDpMwmpfdQtAlAM5mfbOpZzjcwdG8Vuf5peZ5dotzDbBFdbC1UDMcnVE7M
Message-ID: <CANiq72kNr32NKHGn=gfH52C5VLr9S0Xk0HNzroPqYhx4GngkXA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
To: Mark Brown <broonie@debian.org>
Cc: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:01=E2=80=AFPM Mark Brown <broonie@debian.org> wro=
te:
>
> Given that we're almost at the merge window isn't it likely that these
> will get applied once the current rust tree is in mainline?

Yeah, I am submitting the PR to Linus very soon anyway.

Cheers,
Miguel

