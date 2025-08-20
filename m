Return-Path: <linux-kernel+bounces-777518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D71B2DA64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52474725875
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BFE2E2EE7;
	Wed, 20 Aug 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+8tucjU"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86912E2DF6;
	Wed, 20 Aug 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687350; cv=none; b=eO4xStmM4yrUc9pn87y/nqK0kG+HOTRILPuwMh90JDddZu6irvbxvCPWb+m95+vqstruR214kz8T00lcn8ct5pfn1RUwdG1fGEW10BJ6WYWmEoasEFdxryW5eJ1ta54TpMtdu542eBqlSdwlygnTGzbsl3REYXaTO41JRha1Taw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687350; c=relaxed/simple;
	bh=217B9hy9pihDYkabeC50zl1Fz58tNd7lSsJGgFAvhas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uLwXK6di1DUFDhRsCjzgIFvzQXdhc7NSqxAhNrlC9nSz4isZA5r015Nrvk7yEpdnRFWG+j/dkB1LsbTZ2JqYutRWjjCqvrQ71zumBqVDs8Y71a8IcgEFtl+Cx+z5sHeS0xi8zgNN6NiKJHsz3ZDr081lQ5e+bpelFwi5JVh6gRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+8tucjU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471740e488so5844081a12.1;
        Wed, 20 Aug 2025 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755687348; x=1756292148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgJJpH6iTUOWXc1A5qBQjc73BKP4uJ5CGPZRjUlQ9+E=;
        b=R+8tucjU+wX07+xJS1YmrX/syXzuMHYqyf8NtKkwvx+JkZeLMNMc6r2qgpMaJGu7rS
         EZvta7R2g62Z7RtUUT1UiuTYimXsUvIBvT9QrH6xnH6ZFl1gSQ0uxKGF/WkRUm2cJ7ca
         fYyMvxf5y2Xl4ZfJNXeZdChLd37/3bfQ47MEuiI+GmFIt9EmBsgqswU6m9GMqfAD6xWs
         KALkF05xdMJlEKpopbl2LFgb+DUXWxKjcMTVKajEhDTZBbamfNe5937JdxABikL7atbV
         tFYWaxIbDgx6kIiIsn4k42rGUqFLi+IftzviDuMlUYuAgd0FhS9eDeGBPglawAARkCxa
         iYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755687348; x=1756292148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgJJpH6iTUOWXc1A5qBQjc73BKP4uJ5CGPZRjUlQ9+E=;
        b=JCJzvVbscdp1V0Bsh783grAM80aYGQKINRrypgetxLizwaN+d+73rNvA0W1hXE9jEF
         OrmC47cWQTuyGkdpvejixZxueELx0LT6NHC77KISoqgtCgyTtMbtK2wh/vtFu6PuHZAP
         GHpIJbinB2M6G6H+rxN1IHpqFZIYzkkQsFQAEfsSUPFhvqUVnVzMNC4ccW3j730c8PSp
         2oC8hsKlclPIQeapa0sthHqeX8fht1fXraV3bFMCs9y5hRetZhjQBT80DHgBVSlDISd1
         01jfxUdw3kbaCABN+LNwhQGAJVMKrZ/lSyqls2p/hVR2E1WRqvBFqnrfcNXWR0zOGbaG
         Iitg==
X-Forwarded-Encrypted: i=1; AJvYcCVrC2H2noW6AwxiSSPsbHB+884Ts5h2ku6V5vlZDxpwBG7oGWLwRUCD0T4mvbfwDipgtomKTMgzdo8n0n4=@vger.kernel.org, AJvYcCWDpo3ODZxBLFUwW7+ftwnjTRz1Fpy83lgeMdHUX7/1kSphYJ4W++pfAkoeusVefoI906boU4SW8g0D1c1kdzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv6/IRlwX2RnM/tnmYpNWOQXirAuV8G3OAmHQtF0MGKp394Bdw
	FipGqtTW+YWdyLY2z5thDOtV6XEnIndL8KSSiNT50P8KTA766jvyKUnL
X-Gm-Gg: ASbGncuzdYCbOlpr/eXyvSukwXZ1FihihkDClGqolJfNqqjReKpaMJ0r1cyAsZyIbgS
	C4lQgLBUiP9fhG3EWMBVx28rvPv2rqX02bH/4UT7nKoYmY2flkmkPoBVZUvXpOLbA+eKCQ+2tEr
	GxRgmCOmZQiA0W5gHEETZ0MjMU01kDh5711dJM2Xd1RLrhfS4pZBGj8E2rgL6FQ2Lcd8CKe98vp
	mOHtMTe22PuZSPQ6NKkJXk5/Ae3h6mkmOmwyBjPrFARt3QnEiim7F1MNGiLzm4oxoSCfsXTg8QQ
	Di/0SIP2kAxeTBIEd7canTb1xGCRZP9/FtPwyQNEYdykuk1Va0GIjLRd/Lt8xi1NFbp7rl8E2gC
	Aj+3ivz46NbVHBQYCQcTYI1pUxLB8jxyBqtiA
X-Google-Smtp-Source: AGHT+IEtfLVZNVwl0IyUvIn4BlCmewakgSbKBlPGLB79Pdi84ShdWnG4i5K2D0eZ+0OG3JW7Ij6kuA==
X-Received: by 2002:a17:903:2352:b0:240:8ec:fe2 with SMTP id d9443c01a7336-245ef0fe508mr29453655ad.4.1755687347892;
        Wed, 20 Aug 2025 03:55:47 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090714sm1946300a12.32.2025.08.20.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 03:55:47 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH RESEND] rust: fs: update ARef and AlwaysRefCounted imports from sync::aref
Date: Wed, 20 Aug 2025 16:25:36 +0530
Message-Id: <20250820105536.8086-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819-blinken-boykott-624b88ca7f02@brauner>
References: <20250819-blinken-boykott-624b88ca7f02@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 19, 2025 at 01:26:11PM +0200, Christian Brauner wrote:
> On Thu, Aug 14, 2025 at 03:31:01PM +0530, Shankari Anand wrote:
> > Update call sites in the fs subsystem to import `ARef` and
> > `AlwaysRefCounted` from `sync::aref` instead of `types`.
> > 
> > This aligns with the ongoing effort to move `ARef` and
> > `AlwaysRefCounted` to sync.
> > 
> > Suggested-by: Benno Lossin <lossin@kernel.org>
> > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > Acked-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> > ---
> > It part of a subsystem-wise split series, as suggested in:
> > https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> > This split series is intended to ease review and subsystem-level maintenance.
> > 
> > The original moving patch is here: (commit 07dad44aa9a93)
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> > 
> > Gradually the re-export from types.rs will be eliminated in the
> > future cycle.
> > 
> > (Carry-forwarded acked-by tag and added Christian and Alexander as recipient)
> > ---
> 
> I think it would be nice if we could get all fs related patches sent to
> fsdevel so list-only subscribers get them. :)
> 

Sure, I'll take care next time. Thanks for pointing out!

Regards,
Shankari

