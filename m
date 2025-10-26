Return-Path: <linux-kernel+bounces-870519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1EBC0B07B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20C818927B1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF42FD696;
	Sun, 26 Oct 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAYgRQyD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00427AC4D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761504133; cv=none; b=Zi0F9ctjBPC2ReKKfu0LZRqv7f1MOEqiBjrAG3V+gbyrD8oAvetFGrivj58jbYr5ZlKO8JQc5gvKfAsBzQw3m4Rqw+291pi3s/9kpkrsnBJ4W6BfNfNcbYj99aVCeOd0OsSAL0ZXjYq8pM472rcNRfuAEtAr+1XsD6U8cL2Euko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761504133; c=relaxed/simple;
	bh=YECmhpl3gliFU9MJlFQ7Y/4KTQXZ3yx/kGjMpkedWs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfFuuBifNXRM8I+h+rtPdzf7YcWFDdXpie1CVaXAp1c9e/z1AeRryhcxPXZxlFjgh+/qGYzXOquJvvvSMUf4r5E/PFAIbfin+GXtNDstc0HWHzvmds1ttFGtRQueTzd4016dG3zI19wRMwye94uIvjDrIjuDI0V1FmiLv+YGJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAYgRQyD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711810948aso27279905e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761504130; x=1762108930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMOqrpkxVPTqWPkig9b/RMc/oie+A3OUo7v31zgXEsI=;
        b=nAYgRQyDYY+BrAsu0vy9k38Zduj3SDB2Aws6Bmb52EihSRSQ9fcAATomT9HXT6gnS5
         inxCm3lVI/fqyJmOSlUhENba9J02d+xJjMbKbtx5kudVmc95d6L+/rT7grqBnX6i0y0C
         bgQSsd6udp5t9VO9Cbfx5liwDHKDMkgTT/i917G9TBYltydBaC1O9NfJkSrU25Gg/2eV
         ELVKlmWjN4I/dq0aMoVzKAUfE8Q2tP2p/81X2mp6cQhDQr8V6fPXiGIOFOz50ylJIyMB
         jXh2x53WkOMAOE9DGdxbEvVbgVsXlHEs5bX6QGD0lc+9DgOc3mdIwhzaTq5wuxqezBQG
         JuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761504130; x=1762108930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMOqrpkxVPTqWPkig9b/RMc/oie+A3OUo7v31zgXEsI=;
        b=YhnG9Wf5x9cw7KeCQ4151GQXPttqeFRZULtIGcBg25xXPs7cQkcaX1FZn4d29qOn0S
         RDiYd0BEooSTA+rzSbq13rdD21MQo48tQC58GLuRTLLyu789w4oM/Ic2yfjqmksdXlBe
         PIxHWhDinJHlbZtio0KFkZrbl7P1FLQQLKP/qVFBZyI9yBxhibnIeqsDnUkXXuzi9iK+
         JY4OglvlnnjAdlrewAoExk33NM/XGdxy6pgCPUlmvvG+njAtkGoDq796i6gRYGt406lw
         J810kCM7Al6tIZzSpvcv15IHp38Ht2+b3yo81S7KLC/zw0M4ZAnm8JdzHog0ZO+++QIb
         qfGA==
X-Forwarded-Encrypted: i=1; AJvYcCWbRBz4hEmsV66tvJsSQNDMF9rcfevVG8ZreVIELKY/prKgYifw/SSnq9ajp6t1a35PqnDCISlHm7ZgyhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyJ8cxEEbvEMBJhkze7Z2R6sfGKf5qvRyQyAJVKblEx4Lpd7g
	Q+1Mo0AkgCiRmOk/M8axHql6uJ2fw/5AsL+Kd9iGNqkesHQbb5tCc6+E
X-Gm-Gg: ASbGncu1eBsvvkIodyXrmmJZu+AVVm3fQB6liixC+uuWjVmrtShk5EexOH0TnYQCQ64
	1S18Ey0m2f29Z+9XIsXP+mJAv7c0IJhdCRyehIusr+4AOVn6yvpSNhHDFFum20NxJeXKMzehZ+3
	jMxYY0a1sCCZ9F7yPttwH8zySgK0Pr4rbPZzTdF1oryMwFFKNY5g9zXF1QaGGl/nwCN5ecaidFL
	wgByNK2qCXxzx2aM2AKTbGsErkLE4CF4rMPtmKwKE2PSkD0bkww/HidfMVu7cyv6cL7P/TGAR7M
	Cg3ib/J0rOT/887P84bUwEOJ5KJ1LUvEX0cQzdUbRb51+zmrk5VMqoXVYH71E1phqzZB4OKDEIJ
	VENHEPXSPUIdaZuh2GrTg/50m37SYG+Tm//66hsJ/ESwggJdRIzz3o4OiHuSjQ4OADNpLVaEFfB
	xxuyVoMGOVhQ==
X-Google-Smtp-Source: AGHT+IHyxZhrkI8ims1uagFI2rozSJChvdtN8W8yvoK6WTwYwK/GAbNaihHkbnhAJrGZf39KEuR4Iw==
X-Received: by 2002:a05:600c:5392:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-4770bcb27a0mr21831685e9.22.1761504130100;
        Sun, 26 Oct 2025 11:42:10 -0700 (PDT)
Received: from Vasilio.Home ([2.127.51.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4924e2sm92973365e9.8.2025.10.26.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 11:42:09 -0700 (PDT)
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH v6 2/3] rust: i2c: Add basic I2C driver abstractions
Date: Sun, 26 Oct 2025 18:41:43 +0000
Message-ID: <20251026184143.280797-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <508bd9a1-c75a-4d1d-bed7-ee759ac5a701@kernel.org>
References: <508bd9a1-c75a-4d1d-bed7-ee759ac5a701@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Danilo

> On 10/5/25 12:23 PM, Igor Korotin wrote:
> > +impl Registration {
> > +    /// The C `i2c_new_client_device` function wrapper for manual I2C client creation.
> > +    pub fn new(i2c_adapter: &I2cAdapter, i2c_board_info: &I2cBoardInfo) -> Result<Self> {
> > +        // SAFETY: the kernel guarantees that `i2c_new_client_device()` returns either a valid
> > +        // pointer or NULL. `from_err_ptr` separates errors. Following `NonNull::new` checks for NULL.
> > +        let raw_dev = from_err_ptr(unsafe {
> > +            bindings::i2c_new_client_device(i2c_adapter.as_raw(), i2c_board_info.as_raw())
> > +        })?;
> > +
> > +        let dev_ptr = NonNull::new(raw_dev).ok_or(ENODEV)?;
> > +
> > +        Ok(Self(dev_ptr))
> > +    }
> > +}
> 
> I wonder if we want to ensure that a Registration can't out-live the driver that
> registers the I2C client device.
> 
> This should only ever be called by drivers bound to more complex devices, so if
> the parent driver is unbound I don't think I2C client device registered by this
> driver should be able to survive.
> 
> Hence, I think Registration::new() should return
> impl PinInit<Devres<Self>, Error> instead.

Maybe I'm missing something here, but as far as I understand, Devres is bound to 
an existing device. However `Registration::new` creates new device and registers 
new i2c_client using function `i2c_new_client_device`. Created i2c_client uses 
i2c_adapter as its parent.

The driver that declares Registration doesn't own that i2c_adapter. `Registration` 
itself is not part of the new client’s managed resources, so returning 
`impl PinInit<Devres<Self>, Error>` wouldn’t make sense here.

Drop for Registration calls `i2c_unregister_client()`, which gracefully unregisters
and deallocates the i2c_client.

Cheers 
Igor

