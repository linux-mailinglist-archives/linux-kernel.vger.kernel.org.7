Return-Path: <linux-kernel+bounces-865511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFDBFD5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DB8756391F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D4C358D17;
	Wed, 22 Oct 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmHf6n1o"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E63587B0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150367; cv=none; b=mIX2Rsy+oMDmRXxDVe1xqygBgjWJUYT0pIeYI0C8QUIKC2eNk2PP8UljknvMzq+vp9nGfb+hLQgtFBXhHf26oFyhgPD4aW18/4SnDJnYnFsoclFD4ww833yHIUi/DkANlNfEdDNyaaQ6R9xOMTpqlEQnWDSqOv5Aux4ZdNqG4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150367; c=relaxed/simple;
	bh=gIw1kriFuplFJlOu4lyyAKijl5rEMdkuXjxlFUcX/H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjhogFqKYg/ozqnAv6SuVX2Q0gsecWAC29tL/r2oMxDkWPEqgEQ3X2kFyGxKD678HrWTNpAFvwGzxx2+LVHij3WFKUiRnuQG3+qZzL+ORzEmbDlxi5jKkk96jrDYN5Px8iyFGzc8RtWJxfpSjKHRyGkAWk7s4MakbOUORmvGgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmHf6n1o; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so12296a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761150362; x=1761755162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIw1kriFuplFJlOu4lyyAKijl5rEMdkuXjxlFUcX/H0=;
        b=LmHf6n1ofLAjq8HgFzzJBvd5LqVEikKJdlTMHoz69g2WAJZAZvMxUwh5URrt74XG96
         rmc5c7RMF7O4qweeUq5/p7zVP7XdmFO74WjqiWX8MsY4Bpg7FTuq3VWpt0VAdtr9tQbr
         sAsSxzo7hsXK2fOZ6cCp3R0P/kzrk5k4qr8MqJoFvs2vFWV/f4dXzEvHDJ7/XBbnplcC
         J0055dbo+jBOGV/K8cRD70lzQ9GNU5j0KOO6TtSAboqk/s3bLPrztk9TuVODXGUGvIso
         jey5EhsM+/XOx6xoV/axU4CKr1Qjt+S1GqLTncalj7aDMCLEjo4/5NMiks8T/8dycdT9
         5BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150362; x=1761755162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIw1kriFuplFJlOu4lyyAKijl5rEMdkuXjxlFUcX/H0=;
        b=cU5CCpj4FpQTQ54voc4dFYO22ZPc9NtdaRgVyP9ah8NXmlbwvrWqHawM5to7ilAx6H
         wZz0RmfCGdVX6AA+e0SanDNg97eIWvVuAGZeM5lXu6dYm0urqodsjB3IaXZhjByQae7+
         Z+4hTxgujsrW9g7IeE7TjzfxjlLM+fTvZ8XN9prs4We2F2B3Y71ctHVspuyqu1XAOHRi
         RPCundQlVXY9WtHTP7kSNSySeP5wNptXwybpQbX4FGM/rXezXzLN6qwACC+6ghRy23fo
         S1wZy+B8aYqzTKJW0zO/PT7Cl0u6RMVLif8GZcnMmv7eSf4OJAVGPCJCvIMwAYc37OJU
         IreA==
X-Forwarded-Encrypted: i=1; AJvYcCVgJA6z7nKahYVLBYSRxVWGTlUXb6h/VJgeIPLGuPhOMc9I700eE983pC+DLCIoW73Khj+CJn7sn37spTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvna5orgSL9eQDx/tGF26tjInA7TEQEPzUFcCQA+vqzZspCdD
	YzAD/B5xPPt5QJmvq8NY30C94A2vxkoo3ualyDcjiW2Ym87f4RuOHV1VvmrZQTK98wek7K+VPEv
	lYeW06kG0ypC790zD/tmm8XuJp/72ZF0PUJjJHTR9
X-Gm-Gg: ASbGnctLUgcOSjn6Uq+Y8hNYVYtC2L97pU15vyx6CPD9lXMgXvVqkHhLa/7W1LGqGxQ
	YR40LMfhtpSvRjoBRQ2n7tdyeUJd3HNwu1kRC6/lutwAWZaWhQSIEyy2IXFxkvktl+TFE9Xqa/I
	S3Bo6otItDwINCZ6VZPDHMZI926aJaneSMHYZRqSzx5+bPAb+vL8DZxiStMxULpEjz57pWDnZQS
	SOSYylfngD3juFYL3pTFEyYboAvZEle/93Rm0TjsswMJJgYovSmUnZ2kDfh9SbLbcbiHTEpN5jm
	AgRwPp4nyfMJFCo=
X-Google-Smtp-Source: AGHT+IEkvw6aGBiyj17QM5779QXlZYvCVowncplpH/uSCnE1bqWGQ2ML0a40foJQ2EvGykJFnPbW/Xu6ziwwDK3dt1A=
X-Received: by 2002:a05:6402:14c4:b0:63c:4ca6:605d with SMTP id
 4fb4d7f45d1cf-63e1d983a91mr47142a12.1.1761150361564; Wed, 22 Oct 2025
 09:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022035324.70785-1-boqun.feng@gmail.com> <20251022035324.70785-4-boqun.feng@gmail.com>
In-Reply-To: <20251022035324.70785-4-boqun.feng@gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 22 Oct 2025 09:25:50 -0700
X-Gm-Features: AS18NWBnbWpnEFlfGFR8ot6NPG7P_TnmbfK-bFy8u2QTY8SZZlNCsPcjGEOE11Y
Message-ID: <CAGSQo039P_FK_D_dOr_5t8C6DOQPBKu_WamqLQijqfcT-gsFqg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: debugfs: Replace the usage of Rust native atomics
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:53=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Rust native atomics are not allowed to use in kernel due to the mismatch
> of memory model with Linux kernel memory model, hence remove the usage
> of Rust native atomics in debufs.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Matthew Maurer <mmaurer@google.com>

