Return-Path: <linux-kernel+bounces-864474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E0BFADD6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 392824F6800
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9C309EF6;
	Wed, 22 Oct 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJ9I1qmu"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F9307AE6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121338; cv=none; b=VfohJupuEjsGZHib2Li2Thu6eSQABxh57BmY1AcTb3QlL66v6syle7eskSoc5jMAGSVI8xLMXR3NNSxQNB3r2+T7W86eaVNrIe6TiCV7wgYN8v78BInh8kPc6HLL5aPaEqdbyrMpQRFVfZbmwQSggJl15lkCBfwfbHQwMCVPycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121338; c=relaxed/simple;
	bh=UqT6M+d3rQbKlZc3qmh6lN+YMLpp1h22m9HmL4uGIGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z0VjcEqRN1X58NICA8SJtBFqmBrWHZrdR3PDHCwsuUkE4V/DMhcRzdsIr72uBroTzW8FyqObIbVK7VXuSNZHJUQ5yehPEqU+gA9zJY06iankyRR8FXsRI+FP7ByZ4uvvKhOUMlOKciijcbDbpmtMOZBRnIp+4Sp2YQLtyeg6NnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJ9I1qmu; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471001b980eso39622545e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761121335; x=1761726135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=72guOijUHSJJlKe6a2UltCzLUYrTwKqyoEB2MPidRfA=;
        b=yJ9I1qmu1AcpfVV7yyEk2ZO6gMB5emf62HDoxB9lxLjGdPEax5XntH7yqUCOfjMdyD
         7M0hXdIQregrVYb2qxEYo+k6MVleXSG5UT0eenUzbxLhbiIP3JyM8zxRetWokUfY0Nfm
         8Qn1/waKBIJvyuTl000y+W/FjH8AYrTIq0aol8+wxPYfGCOBxhy1LeQOi7q7p7cC1dKe
         Dx5zPmICKxwihfPFmoE1+YEqm/B98bEJ6yLKqN6yvUlQRvGOXAGzOJOWQ10jFeWCjLTE
         QAnJwzVqDh9ou2kmA5Hh94NPGagczFehgc75ZdQSuMUVcaJ4neNNKkTBr8YEcw00WCF5
         zSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121335; x=1761726135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72guOijUHSJJlKe6a2UltCzLUYrTwKqyoEB2MPidRfA=;
        b=woQ3YpQT5Wi0VNhGY3ywjladLbjapBnL8hxtCnZV+K1beoibJTtmnIUn2zkb9RSV8D
         w6qSudtQcZeEugHhRfXr0aSsD8HRDYKDiijvDhBN3fEV+hMDP3tazqrBtwreOcH1hUCx
         gdFF8mpuvD1zGSTu1ERHESXk9KTBn/afMWv1uaF3HlcAc3lIu0PGEEVrzscHaPUEBoHs
         azhEIrsINLHL42Wqyui+eBjr7losTmm4LIHreKRR48VmOhPSRQjIculWkD3BCYLgsXmG
         Ng9gqkN5tMNudSo0lQ2/wk7Ikt6fNgfzbVK9Qzq3gFZX6XRHx1OJlPNdGKNKDJIA5VO/
         uH1A==
X-Forwarded-Encrypted: i=1; AJvYcCXBbD3X5MCfa/ndCq97HrR2to2g/z6BB+YXLJTCWdQVnVn4X2PQkTQSwWUBuq8M+XF378g2nH2Z2Q9Yfas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzZxpZt35pnm4Qd0415Jdatzj1+oRlcSUdRwuSc7xq3LiqKOR
	YgtY2KEXQh3uSRyvTsUQ7n09ZOqDRI3Fj9v4A0Pc0AyIJ/pzMRctWL0rTiKypbqGb+Etgov7lOE
	5RBxoDy9tmpA8TzgGwA==
X-Google-Smtp-Source: AGHT+IGpiOr8LIFL4RAOFaNgyYQ2Xzrv23KxyRhw3LPR4VoyEhq5aZl74QO5PW3dvKcSclSKhT+9iErVdITwsUk=
X-Received: from wmwp28.prod.google.com ([2002:a05:600d:831c:b0:46e:5603:f679])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:870b:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-4711791cb7amr162298465e9.33.1761121334940;
 Wed, 22 Oct 2025 01:22:14 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:22:14 +0000
In-Reply-To: <DDO2PI0D2L6Q.3OPXNQOV7Y0H6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-4-dakr@kernel.org>
 <aPeSCuFNrV-_qvBf@google.com> <DDO29UN4UBVV.E90DEBURH63A@kernel.org>
 <aPeWOhycOIl_rlI-@google.com> <DDO2PI0D2L6Q.3OPXNQOV7Y0H6@kernel.org>
Message-ID: <aPiUNmAfbefKW__4@google.com>
Subject: Re: [PATCH v2 3/8] rust: uaccess: add UserSliceWriter::write_slice_partial()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 04:34:49PM +0200, Danilo Krummrich wrote:
> On Tue Oct 21, 2025 at 4:18 PM CEST, Alice Ryhl wrote:
> > On Tue, Oct 21, 2025 at 04:14:22PM +0200, Danilo Krummrich wrote:
> >> On Tue Oct 21, 2025 at 4:00 PM CEST, Alice Ryhl wrote:
> >> > On Tue, Oct 21, 2025 at 12:26:15AM +0200, Danilo Krummrich wrote:
> >> >> The existing write_slice() method is a wrapper around copy_to_user() and
> >> >> expects the user buffer to be larger than the source buffer.
> >> >> 
> >> >> However, userspace may split up reads in multiple partial operations
> >> >> providing an offset into the source buffer and a smaller user buffer.
> >> >> 
> >> >> In order to support this common case, provide a helper for partial
> >> >> writes.
> >> >> 
> >> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> >>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
> >> >>  1 file changed, 24 insertions(+)
> >> >> 
> >> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> >> >> index 2061a7e10c65..40d47e94b54f 100644
> >> >> --- a/rust/kernel/uaccess.rs
> >> >> +++ b/rust/kernel/uaccess.rs
> >> >> @@ -463,6 +463,30 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
> >> >>          Ok(())
> >> >>      }
> >> >>  
> >> >> +    /// Writes raw data to this user pointer from a kernel buffer partially.
> >> >> +    ///
> >> >> +    /// This is the same as [`Self::write_slice`] but considers the given `offset` into `data` and
> >> >> +    /// truncates the write to the boundaries of `self` and `data`.
> >> >> +    ///
> >> >> +    /// On success, returns the number of bytes written.
> >> >> +    pub fn write_slice_partial(&mut self, data: &[u8], offset: file::Offset) -> Result<usize> {
> >> >
> >> > I think for the current function signature, it's kind of weird to take a
> >> > file::Offset parameter
> >> >
> >> > On one hand, it is described like a generic function for writing a
> >> > partial slice, and if that's what it is, then I would argue it should
> >> > take usize because it's an offset into the slice.
> >> >
> >> > On another hand, I think what you're actually trying to do is implement
> >> > the simple_[read_from|write_to]_buffer utilities for user slices, but
> >> > it's only a "partial" version of those utilities. The full utility takes
> >> > a `&mut loff_t` so that it can also perform the required modification to
> >> > the offset.
> >> 
> >> Originally, it was intended to be the latter. And, in fact, earlier code (that
> >> did not git the mailing list) had a &mut file::Offset argument (was &mut i64
> >> back then).
> >> 
> >> However, for the version I sent to the list I chose the former because I
> >> considered it to be more flexible.
> >> 
> >> Now, in v2, it's indeed a bit mixed up. I think what we should do is to have
> >> both
> >> 
> >> 	fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<usize>
> >> 
> >> and
> >> 
> >> 	fn write_slice_???(&mut self, data: &[u8], offset: &mut file::Offset) -> Result<usize>
> >> 
> >> which can forward to write_slice_partial() and update the buffer.
> >
> > SGTM.
> >
> >> Any name suggestions?
> >
> > I would suggest keeping the name of the equivalent C method:
> > simple_read_from_buffer/simple_write_to_buffer
> 
> Hm..that's an option, but UserSliceWriter corresponds to
> simple_read_from_buffer() and UserSliceReader corresponds to
> simple_write_to_buffer().
> 
> I think having UserSliceWriter::simple_read_from_buffer() while we have
> UserSliceWriter::write_slice() is confusing. But swapping the semantics of
> simple_read_from_buffer() and simple_write_to_buffer() is even more confusing.
> 
> So, I think using the existing names is not a great fit.
> 
> Maybe something like write_file_slice() or write_slice_file()? The former could
> be read as "slice of files" which would be misleading though.

It's tricky. Perhaps if you make them standalone functions, then using
the simple_read_from_buffer naming is less confusing? Then it's just
kernel::uaccess::simple_read_from_buffer() and it takes a
UserSliceWriter.

Alice

