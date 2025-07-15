Return-Path: <linux-kernel+bounces-731610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D76B0571F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8101C21DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B2B2D6406;
	Tue, 15 Jul 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qb5qdK5I"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC556266568
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573182; cv=none; b=p7Z+TqZiA4xfRWaUsUUP2DHN9AXcKI4ZjET7253217TSotdAyyCQoNzBExcFRq2lF1KylLfeGY2LdJoTg2B/CAqtKtvdGHX1tROhWgkOH9+B/64EB2NmhL5nLPfYJYXJETcfH29amF7xkfYlwUzk4UsSPV/8/qsJoQJXf1iLQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573182; c=relaxed/simple;
	bh=Eu09dYbizFV5acWWRZPs1ODpYDFIFp/NiPu/UthNcbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qjGPgeKd+55iI3EgRe7zsfxPhXaQCcyPnQ+Qc4EOm79UKck2b5Mf+eulLwjllBB1LCf9VcFiUd4MJqWsBJO+96dRaG2NHhLUizJjKznQfqYDw4dnw9QfdsZIp+z2uTZa6jNS7vukhxZz0U6nM8T+ib7lEmuf0RQSLu0lB7Sd5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qb5qdK5I; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a52bfda108so2594704f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752573178; x=1753177978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRCCvDl2EeLJ6W8Qd9isZ4A2S6Wz/e2h3t5fx1/JbTY=;
        b=Qb5qdK5IRz3ntCWNtc6ZjYm5m8vC2PGue8Os9XPzuZjPzC3LXeimvS/FFEPAsGgMmj
         WYQBUaFpIw+U0DVK4oQ9OZ6ZoC5uDMkafDojnmQIkWE3g1hLg54zOLuaDhVd4fjUIPD6
         oMDVLScQ/t51CQ9lE+x//02VDMs8ONtujurAUW9cf2FmJySFEUiZM2EVsKYA8GbdEyFf
         25/NVffQasRZWV6fiQUqZ5dSHrwoqzA8S50e0h6GITrCT9WKJ/8Od964bslJ3TzC6ftz
         JDqenFTfBTTgRd49LPmB1bsIujcNkI0GHca77ji0/Yt+/4sy7UGZ2FrVBz+AYashECIE
         QjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573178; x=1753177978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRCCvDl2EeLJ6W8Qd9isZ4A2S6Wz/e2h3t5fx1/JbTY=;
        b=Qpqmv0HU+00yKSN1/pU5DTS5Z7yFbiBpJgQoy6waYS/yklrqcA2MrXpooAuSLNyLsX
         JjcPVGPjv92IgZHufRYVBXSbzjHJ+1Ui+4FT1l70wThhC2lzPu/enmXAZKLM5YY+hskh
         0vzrV5wE8u2RYad0XTLN20pGJlVcO3u0Ts5G4k69obZj9Pxxih2UOcSI/tGGxVOoivhO
         U6zFSg5ehg9R1bpEbtOtkj5sMwuazRa3fPEBYdPdq+G0G1T6HWywKRQIEbYqJ7snrGCt
         t3ncIw1+vqZFGP6qMhIXJ7qDQh8LQBL+W1MFMBdI5A1/mwUneUOctlLfY3HlEt+2aw7n
         eweg==
X-Forwarded-Encrypted: i=1; AJvYcCVv15RmmmHdVAK+NxOOdfU32kay/oPDxF3LVTE2hlCxtThedtEk0UqGthCbQUPWrtsPFDyinCTv9s6gxJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQkNXw/u8liSSa+FrF5CqsmXokfr8ZvfU584QipeV/A+mr3nY
	QX3eEdQnZozr9syUYBRlvI2Qfy7hoxKz54+36t1QLOsyXIp9nHdvIrrNdE87y4V4DDxe5PaTuc6
	bhQypMdFi0BtJ3aYjuQ==
X-Google-Smtp-Source: AGHT+IF3EotU00orGgUq5/wPVXDbTRCtotoKNHfSWjvULDWdzffUM8q1DiySCXXfqz39cc6WjFVeYT5gQA6uafw=
X-Received: from wruo9.prod.google.com ([2002:a5d:6709:0:b0:3a5:648f:da85])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5c0f:0:b0:3a6:f2c1:5191 with SMTP id ffacd0b85a97d-3b5f351ecc4mr11584212f8f.4.1752573178118;
 Tue, 15 Jul 2025 02:52:58 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:52:57 +0000
In-Reply-To: <20250711-rnull-up-v6-16-v3-15-3a262b4e2921@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711-rnull-up-v6-16-v3-0-3a262b4e2921@kernel.org> <20250711-rnull-up-v6-16-v3-15-3a262b4e2921@kernel.org>
Message-ID: <aHYk-Y5GrJ2WeCJD@google.com>
Subject: Re: [PATCH v3 15/16] rust: block: add remote completion to `Request`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 11, 2025 at 01:43:16PM +0200, Andreas Hindborg wrote:
> Allow users of rust block device driver API to schedule completion of
> requests via `blk_mq_complete_request_remote`.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

