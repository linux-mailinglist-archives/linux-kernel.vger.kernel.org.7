Return-Path: <linux-kernel+bounces-850167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C25BD2207
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19524189938D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EF72F7459;
	Mon, 13 Oct 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFzSL+Ku"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884C2F9D86
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345054; cv=none; b=vB09h7udF9gXC5CHq/65CVeD224VlUe5k/7hWl4hS5bPJMLGC8l7b4R17Ub4rY9angsUb0DVMNQepyofTju8XHg5gVVYqIOjgJv2qvwcBeiPTqqXpGiyEdfE6WHjXvtAfY6jiv9/TARZJt6JJ+MdCO2Z7+vV36znWAaTYjHRyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345054; c=relaxed/simple;
	bh=CCiwcbz0Xa80/3Iu0vLGj45hC3B+HOSp/IJLkFWl8I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crZe8VzvctQv8HQfp3F36D1JFpy7qHcqGK8B4tW8O+SamKxdE0sxWbmnS3Eln+bz/ZbIs/MHWeEkcUE7Qs4AKj9O0JYA4snbfjyyuASxQunrfvDXCNnzXrFDAxEl5/Y9SbquNZ9p0Wm1XSoJI04HwPKlWUDoMuSkGLEOKR8+yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFzSL+Ku; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782e93932ffso3569828b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345052; x=1760949852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEm8mSyxrlTqcu1WsEF7ZOgpa+/kS2dzVEZPsYbteWY=;
        b=ZFzSL+KuxWJW5hNFcUUZTqcKt090DExRs4NV9BsWW7oBBGyciz/+hW3vbrjppyBcFc
         hWfSGymMZ1rz8vy6+P3t8oz0Tp9naxxNY/h0965DOCcVHqB2o3UEzKTfw/FjnWPB/Z3v
         iyyFB5d6Dtv5H5KqB2aTZHHejSmSc2aMVBh8Tvm8EIT96dQVMGLDVsHycPgFj3YsR/vr
         tXXSklCvYEXDrJiQbhp4/z1mCbJIBA75SxlVGotuChWshIu8T+QGn4vlDB/JuHz+hDac
         ViYg1kkoqTpIxKz06WxE4qxpXe0RgMN8RdYtGv6Lx8AHLHx8UnOavSuUW6cng+HbYtO5
         6/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345052; x=1760949852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEm8mSyxrlTqcu1WsEF7ZOgpa+/kS2dzVEZPsYbteWY=;
        b=K+NUqGtjgZXysbpHw6bNKFPpZpAVDA1fMEZznlLkV6hUI+SWj4nxkdDumnez2f0mKy
         6QqY5jWRvKFLaBdGc4AQdLAhVFzJ5NtocFt3Lphqmpicv6nKMqRxB7BvdN4kMndk7PWH
         AEc3gFFE52hNzxEgRqTmb/Fj/Wtw4H73Mb24CpNoXVnJl3m/Z+ntBAbHqqhr1Crmn8Ex
         dJyrkV1RVTBJXLnxtX8sWIFIHDJuStomMSIeERGFIo0t5zTXJToUz8lt4uAOc4SGgEet
         MzkPO19mWnqIOLAH40tuYIBxoEEYBV73xcFrLpO8AcC2Xks4Fu4xxFyN2hf+AkiWic1b
         ZIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNio1WvtBx06WxgeFDJAja8u3/7wo01UrMLQIjlGFhkI++cmqDfJ2KIMrRPdwEwRy5XFkIi5/MNgt5ubQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhqqGqrFX6tAL+ZkeXUADdPlGWNM2RPN4luhwOv3gxGhdr3Wxu
	mjyMCnBgwadsQMQdjs6tDejUILkmwb4UhwTDOTWOs5MZcSGe9UUpauDn
X-Gm-Gg: ASbGncsrpuDNDb2mwFtGEeeXGzLKtQA39jtthoNN5DXZuAc6m/dFAZhxayrY3yw5JT2
	tW5A68qVlLFUk3EGdK8MrK5U4Ct9moYRka9j8XgkFdXOQFA6YS7wSoLE1NgmOmxJDZ6aPGQvJKx
	dH5jH1fX3CPvx8WCaWCxFcFnVKMaMo7gg2kdmOBbHtI/0lymBtP41tD/DqtqM8SCb/ljCddlMsi
	ilGjIsmL35TLOZLPQBUVjMq3pe7GaJ1fEB+bN4Aau9okuurW3yETSgmYiXw5KCVy4DiZ+t9F5Yb
	/dzcbpyL+E9NNyguwFu73zny62x7Rp4LWLSp5D5F3YZv+F2fWL0rXjtgqZEaesw3zDqqlbKgCSl
	0zCyaR7OIzkOfoapz4zSjT/C1hwIIqeyMDlyuaZvYyeSLrklSsO0y5o8kQA==
X-Google-Smtp-Source: AGHT+IH8BLldBUPUKFQibBJX7aY+OAIgjY1foYAVc8whufp2ZR2zdRzdCGMjbGvERedS1YiA3XEzRw==
X-Received: by 2002:a05:6a20:a123:b0:2fd:71cb:e908 with SMTP id adf61e73a8af0-32da839f7bdmr27396737637.39.1760345052180;
        Mon, 13 Oct 2025 01:44:12 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9992ddsm10777474b3a.80.2025.10.13.01.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:44:11 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Mon, 13 Oct 2025 14:14:02 +0530
Message-Id: <20251013084402.300397-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com>
References: <CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Oct 12, 2025 at 08:01:19PM +0200, Miguel Ojeda wrote:
> On Sun, Oct 12, 2025 at 4:05 PM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
> >
> > I'll resend it on top of -rc1.
> 
> Yeah, please, thanks! (in v2 I think you say it is on top of
> linux-next -- did you mean -rc1?).
>
I've rebased it on linux-next, and I've included the exact base commit at the end for reference.

Let me know if you'd prefer it to be rebased onto the latest mainline instead.

> 
> I think it is simpler if I apply (even if temporarily) a commit that
> moves everything and removes the re-export in linux-next -- that way
> people will notice when they try to introduce the code during the
> cycle.
> 

That sounds good. Just to confirm - since this spans multiple drivers/subsystems,
is it still okay to send it as a single patch?

Thanks and regards,
Shankari

