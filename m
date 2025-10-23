Return-Path: <linux-kernel+bounces-866502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9AEBFFF04
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF5124F83A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C372FFDD2;
	Thu, 23 Oct 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+NiMcQ2"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB032F9DA0
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208214; cv=none; b=Kj23dgj6eDFE1iEeazM9yzHP8kZ3hFYFgmDl+fqx3PaUf7ESayf8KxwRYkHS/zc0r5X7kzUn0HFFLmUAWu50+dYA9CWWEbHkg/oZVZ3BKNU5mBcoWZveTCbEHmOyday6xGk/YhIY9dMe8B+9O6WnTZlT/PDr0oDgKHXJ4XKj7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208214; c=relaxed/simple;
	bh=+F0xWxetq0uJhy7xzwMN209SUUvvEBc1Vx+dg1vIZ6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CmOikPAVjD+fafGhjDUJeOZyTp1TVUkc8FoxzbAKzqwnQ7qxroXOHMEGwhp6JmoMxeWdQhLKctd0+zUW5YPOGlY2hHoFJsylcf1f2UHUtEwMsDPTmuxHiXqKjqt35/8Yk74rue5RXaqUu49Es25DYJpqYb74sRuqACq252hb4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+NiMcQ2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so2962595e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761208211; x=1761813011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dn2WRikqhcE3CQH1RfFoKYxVs6WPSYK+duqO3DtgGIw=;
        b=l+NiMcQ23EOrHbSqr3EVLabTwaWU15oxC4D4IOrxBkW71iH92toCJKpBl4/LCGEJKv
         fdbVt6QXdYDSfgbOucBBiElaE6+K37+oMQazgsScnmzIahRvw0ygnZqlig3rWo7u14W5
         R8aJZUrBpwqgs2Of51YOhx1RoNwjYuoh7YSsdh1g+MbjBZek1MnJWszv86Gar5qPKwdY
         vQSeeBakL893AZbFfzKPvg6oNsKIkh/byj5CKUA4jGjM4L+CN9O13JXHGmviGnvPHz0L
         3bwY/8xw53vr1q9fHZ4+2RgbMPPsFU9KFTGVH9IM094sn+2mrhWzhhEcsv63W3zVVp2k
         nqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208211; x=1761813011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dn2WRikqhcE3CQH1RfFoKYxVs6WPSYK+duqO3DtgGIw=;
        b=VjN7PnIR5IkPNm0XGB7CJXTQvBwSwIGF1Yje2hdJ15LmrTfx76dc3JhTNQFs03FOcV
         KgiA35liNTx7f5C0ZIuNPezQpT96UcN+pqMjk0PXNfnIG3sqxldbQgl4yTJDSFos3wR4
         tBjzQTB9FQw5ygkRLXYLOvwsiXGdf1zi76IBttqa5sS8lU4NQGGYTl+yQ+kaekGadZAA
         lREXS6GzWDnokp3X1nEvXiKMt+WEGrn4+M3L0aqT4+56UprrqmMi/d5zdvD0+RSxqoKW
         LZzrSysGzAOpW+r0LrnJb7qfxidFKC3go+mSn84a4HjqcRjPqxLMCAiHvh5Y55wGNLM1
         PgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJsrxFwYGtmpODIGt9PxEXiaByYiZ4F3qqOIDoFa7hGN0Mh4DSqAZbo4bPfaWYynoi30J4qv/YvpCmHNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKV8O5E+Hbtmu72eBMjY+9J6YGvLOvkfbZqSvORgSEVolrUGGz
	itHVrxTn4E30Rr/eJs/Ki7Wo3c4XxS9qZKl0k8PRDEIrPB8p0r0GIS+Kms51P2Nf2GaS2Jnk0yU
	p4f4dzGl89SI+3FomIQ==
X-Google-Smtp-Source: AGHT+IGg+LSnQo6vibvjrS5qWozQjW5MNaffdqRfjcCBQJ7iPK24ykKjp0cY1RmxyPOafr+mGOXCfbkKf8lcCFU=
X-Received: from wmcq10.prod.google.com ([2002:a05:600c:c10a:b0:46f:aa50:d706])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37c7:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-4711790c31emr141389685e9.23.1761208210774;
 Thu, 23 Oct 2025 01:30:10 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:30:09 +0000
In-Reply-To: <20251022143158.64475-6-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
Message-ID: <aPnnkU3IWwgERuT3@google.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:39PM +0200, Danilo Krummrich wrote:
> Add UserSliceWriter::write_slice_file(), which is the same as
> UserSliceWriter::write_slice_partial() but updates the given
> file::Offset by the number of bytes written.
> 
> This is equivalent to C's `simple_read_from_buffer()` and useful when
> dealing with file offsets from file operations.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 539e77a09cbc..20ea31781efb 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -495,6 +495,30 @@ pub fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<usiz
>              .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.len()))
>      }
>  
> +    /// Writes raw data to this user pointer from a kernel buffer partially.
> +    ///
> +    /// This is the same as [`Self::write_slice_partial`] but updates the given [`file::Offset`] by
> +    /// the number of bytes written.
> +    ///
> +    /// This is equivalent to C's `simple_read_from_buffer()`.
> +    ///
> +    /// On success, returns the number of bytes written.
> +    pub fn write_slice_file(&mut self, data: &[u8], offset: &mut file::Offset) -> Result<usize> {
> +        if offset.is_negative() {
> +            return Err(EINVAL);
> +        }
> +
> +        let Ok(offset_index) = (*offset).try_into() else {
> +            return Ok(0);
> +        };
> +
> +        let written = self.write_slice_partial(data, offset_index)?;
> +
> +        *offset = offset.saturating_add_usize(written);

This addition should never overflow:

	offset + written <= data.len() <= isize::MAX <= Offset::MAX

I can't help but think that maybe this should be a + operation instead?

Alice

