Return-Path: <linux-kernel+bounces-873875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4AC14F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485831AA8186
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254EB2206A7;
	Tue, 28 Oct 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmNNPfWz"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D615442C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659249; cv=none; b=qE/D4x5JDj6zY2DruQsfLL++xneJv7JRAm5igJ4F5jmOkA/UhXJy+fWpX8becQOI9qkRch1/c+IDAE8pRtMoQ2b4oKsrw5AeYJ52O0uRS5ENkifWjxAwVRuiihw2fGnaPBP4QMV33PhBEFGPsiOROkfPaNsCChSDpNw7kjCCXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659249; c=relaxed/simple;
	bh=zawK76MtmH8ufrxR4rfg/Ht+VnEdIN5K5P/OxQhqD1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqL1n1rnBbLYFQC1wvxFfG5nJwDVcbWRac5NeFxWJ9Rc5vhZNEItO+aofyxPUePPwuB8/SXqfy0bPsXQLQwGigf5DV8Ed/aoIfaU6wIyplASPiXz/BNQ+UYJwX1pf+Z+yFDDSw8PfIkB5EC7h8oevybdN6MIpSLmsRi7sEjphto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmNNPfWz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a43936c035so284053b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761659247; x=1762264047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lck/qUF3K17/QD681a6Qx1V7al1MyFus+/Obtk7sHTc=;
        b=KmNNPfWzC511RqEJz0m9q2LzoZkyd1bSlK0vzRAVWE9z4HA3FSf5E/aqgOsN+8IkDd
         txRYdkgDX+L1C/r1c7VW0CaFcXf/2C1qXGfuQQ0qFcb8+eMavq7iF8DocJcPoAFMPd2M
         deMW5RVAPvJXrIj60fvQQ+HFzeqCCWam9mhitxsxdnY73wlLNG9ft1I2vM0TdBFaCBQE
         jXjBgs01ddWuch6q7rUoOBUADpguZhfi+NUPUSLp35vLnrVd5Fr++nU2ek71C64TxwvX
         KDTyRUrgJB73Om3XpoBms5n5azVhAGTGFbTzMO1Ty4EW8NDO06Qp8sPDl5wuViBTdsjC
         qm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659247; x=1762264047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lck/qUF3K17/QD681a6Qx1V7al1MyFus+/Obtk7sHTc=;
        b=HCRIqqaWIICQKP0oxG5PQsE0U+5OiZ389+1yppmnyHmtdo7FqURCdkw1UkAuRjXrRm
         csDWd57bkfPut08a5XkTqVl9kU9up45s4WofUxy5JURyHPTCnEr9bs200bycpQviwovM
         z1Uo2dg8MRkHqfdEncivhXlzt0I5Ds41PqYxr506a/8NSAtWqYe6bYrttbM5BfCJAC5S
         +8Uc0mq1WILAD6hRCmzck2p2Vm0UToV/F1zU/UTtl6AGv6eAakOz//fyW6qxBma9xv58
         NSBI7Kb4Iedk9vf8WW6sRVB4FMKZP3s3D9vBgU2j+A3K9VIoZW1nUTdE4OQwDJgPvxsq
         O3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW1c+vPK8T1I0BuiKdmv/eLRUFBFM18sK7swEKV2vfGUjj1oBVURTq/aB/xmKeNVu7V3SVd2xQBRuN4nFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydYCVxUbcBZ1JdSuAB3gNLTA7S9obMeFcljAAPutHr+wiPCUN
	Mst6PEIckZkDVoBz0GoU37FT0pfW3cpKN9HbEAQpWTyj+ZcpfSfx9uvbc+et+B/LEkpyuvjSR2r
	nJYIMojxfCQa+3yCYKGpBNRJPZgmp1po=
X-Gm-Gg: ASbGncsa9o793MxG1VS2+7JsAN8FFvE1LInehj887sxu1xaiIUYQmYSShFgdaPUvKWo
	zJoQOgRlBPm/+Xp8OEwRLJWTDWtlvIViZlYU5nfwXEDbnu8eWZOJiX7OZS+cB6V6BsV6kWNc/x+
	Lq8OobgVY8zDO76LpfvIpebdjG39w/eJiwko1VwLRfwjwPndA+Gm/ffESnfbN4LNs+I1LmniURK
	q/hlrMuNDWfAxnfQtW3AIJ6kO4eG9aMrZxiaTDt19E+bNqo3u6eYN98+vumRvK/eKAcNjnEYK7H
	bYF9Q9Z/hWxu/3mVp+AQ5u0NU8x6frAYGo2RMOumbFv6g19ERx/O0qVHqx1oNWoT7icvQ9XQmir
	aqvA=
X-Google-Smtp-Source: AGHT+IESXoECX6lb+KHpmsbAfcJAT0GbZQiS04Og6y3R0qXxL+rFcZNSFEWU136JZUGwifFE09Yqi8TDGf+dQjOFZ4U=
X-Received: by 2002:a17:902:db11:b0:25c:9a33:95fb with SMTP id
 d9443c01a7336-294cb502797mr22038715ad.8.1761659247125; Tue, 28 Oct 2025
 06:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-1-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 14:47:13 +0100
X-Gm-Features: AWmQ_bludoF7dxQQKoaDhrz1B9YQeI7e37qaHz0Oa7sW-yAdS1QG2o8R7Wm1Nqs
Message-ID: <CANiq72kjuGDAkwhYOM0BTn_WRruYn88C_MmYqytpJW=UMELV_w@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Binary Large Objects for Rust DebugFS
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
>   rust: uaccess: add UserSliceReader::read_slice_partial()
>   rust: uaccess: add UserSliceReader::read_slice_file()
>   rust: uaccess: add UserSliceWriter::write_slice_partial()
>   rust: uaccess: add UserSliceWriter::write_slice_file()

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

