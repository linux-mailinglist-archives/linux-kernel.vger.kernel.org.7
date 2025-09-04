Return-Path: <linux-kernel+bounces-800830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CDB43CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BB0174C83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072830102A;
	Thu,  4 Sep 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfIcCaTD"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5202FCBF9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991408; cv=none; b=c4WSZGOCVy5B16Rhu8bO+pp+Go2PFJpm9QKFir92s1LZOxRwaeN1jyaOh85IMymm8/O3hwK8TrNJR5TGxFu1iH5z4VicMKcshjd+EuZKvEZG8VZASoUGhXbQ9qzF4KQ1xRF6V16xFKC1fMU9AZYS1UUDB0Oiy8S+qYokk2ylxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991408; c=relaxed/simple;
	bh=aa/yg978l0hp656ZEYGts+dDXE6SPkPYz7Q3QwwfGGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhxeFu0llOBCojrJ3fXey7MpSD59Wm/HIRkUpMleYFp30kK0b5G3TMC53079FZxPF8AT9Vtbf0B2R50bsChwSoXq3dJVKqUcMOdKR+t/NpGNHkXvTvcf98gHXJv7ruZRfZwtCVsbDPvX0ng+0f20rWBVLg/0BlQXk4h/RzQ2Snw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfIcCaTD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so952560f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756991404; x=1757596204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUmGcnb9DOoFKF6N0qbvgApw3pjqcT4j1CgQZsy8ec8=;
        b=tfIcCaTDXfGHtHbu+OU/RAJCaIPkXvfxqjwYQJWI7WUy2gSo6krZ7SEA4sAnQHpBsG
         sy/s5nfnVFv7XcQgdAPXZ/K6Y/idlH4/dd9pivmZGfHGga6WXyR81zMmR6Y4IRmvalfu
         3XBAA6ZJ2lqzCWccj0wWI4JZm4RdgMieEYCPgIrhz75ZggZwe1am3ULdpmMPmiyJB58H
         02vxJbHpLm3yXAo0fA7IfyZ3YUkOl1tW5vEP/cHfJPj9yK3esO9eJKJ0ecOplhhfgkfA
         d57CAGz58C8HShOEEXAWS87wGOplO3QFwvLc5EBhc6kVhnLiUSzU9Oe9lySxWyDJa2Tp
         +IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991404; x=1757596204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUmGcnb9DOoFKF6N0qbvgApw3pjqcT4j1CgQZsy8ec8=;
        b=YD6xetRNNQds9jsBzYgs3fe6oYE9pPXaM00T3uSii+OxRb2uToxxXX5UVy39VSb5OX
         fl4fjIMd++XNydGbE1KisZBZJf4xMbONjzRiOFZdYE+Toumy/0Dw3q6sqHTF6oPipcSn
         weSo0eMM/kksBEygvUoYn5A9FT+YcgR7gyghH6PiN8yb7dzPqBYPqyXhhax7tO+HhCSB
         IJ07jWJCmGwYhnKjlOXNvAhoHROUvIEtr/phmpsl98jPIAcZjUiumiF55cZq9RbKp83l
         eb2uS2r0WZSVNos2rFGtYg+e8LYVkoz874cFfBBeVsiCImRbczzYk0RfgOJJcqz/kGwp
         WVKA==
X-Forwarded-Encrypted: i=1; AJvYcCVDRyNc20qk1P1NKTMUfFzZVVT5V50k6kicb1KNaqPPdYS9ztqkbrn43W3X/uL8/b7pkYX499xJtLddSk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6vEtJv8eGsGsacW9wWt3JbutzGgujldRuLZmdFugOjG6JXMC
	wEsB+S3C+HfAtaU3rLQo+Od4wTV7pPtQmCpXSuGLzcWG1BY8QVwf1IiDDKm6t9OfoXFhOBl8ITw
	Yy6NqGTIYswvbXinCH735kBTceFai8VSknOdXNSDc
X-Gm-Gg: ASbGncsfLvYSMHnjXRSPyhwCZPt0Au/gWMQho574RnnlCEWz/+Ms3bBzKuW/6TNk0gX
	2KDP3+VLZepnLtpH8Mi5cnxpu25j5S8cwenjKjIbrasCnJ65ey9984kuUBhxDdoUzVnEc0AYsSt
	LvOkLx6lzbg44WzaZeqTLQX+7qkxPMQWXbfKc1lRlJF7F1hA156DskLd6VB1MYKCyeXMiNXMMqT
	Lzwmeev7lVGw+0rS+MBNwr2HVNI0N1q2HkdmpGGc3gkkxDAWuXlr2FUOt3G8lrQhYDiXcNOKQtI
	9h0dEDgCdbk=
X-Google-Smtp-Source: AGHT+IFHJ2ZrBugJMZBEfCi74IIrGqgkQHBE6XqdlI+XjphUPOfhoV+znXePJUYjgikhYscUmFzUrXSIaK4FVkPPW1w=
X-Received: by 2002:a05:6000:1ac8:b0:3e1:2d70:6785 with SMTP id
 ffacd0b85a97d-3e12d706fa9mr1875838f8f.31.1756991404184; Thu, 04 Sep 2025
 06:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829224116.477990-1-lyude@redhat.com> <20250829224116.477990-7-lyude@redhat.com>
In-Reply-To: <20250829224116.477990-7-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Sep 2025 15:09:51 +0200
X-Gm-Features: Ac12FXy8H7G6oV4EU2UIFIgA0FDxXvR6Hytw96Q6mBmUHCGBN96sbfN9dB0h2Kk
Message-ID: <CAH5fLgjFePwYmyivpU-Vk2KbKtu7t5DJ1cZUJmEQ_Y+Dgynk9w@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] rust: drm: gem: Add raw_dma_resv() function
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Asahi Lina <lina+kernel@asahilina.net>, 
	"open list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linux-media@vger.kernel.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK:Keyword:bdma_(?:buf|fence|resv)b" <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 12:42=E2=80=AFAM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> For retrieving a pointer to the struct dma_resv for a given GEM object. W=
e
> also introduce it in a new trait, BaseObjectPrivate, which we automatical=
ly
> implement for all gem objects and don't expose to users outside of the
> crate.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/drm/gem/mod.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index ec36cd9ea69ed..f901d4263ee87 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -186,6 +186,18 @@ fn create_mmap_offset(&self) -> Result<u64> {
>
>  impl<T: IntoGEMObject> BaseObject for T {}
>
> +/// Crate-private base operations shared by all GEM object classes.
> +#[expect(unused)]
> +pub(crate) trait BaseObjectPrivate: IntoGEMObject {
> +    /// Return a pointer to this object's dma_resv.
> +    fn raw_dma_resv(&self) -> *mut bindings::dma_resv {
> +        // SAFETY: `as_gem_obj()` always returns a valid pointer to the =
base DRM gem object
> +        unsafe { (*self.as_raw()).resv }
> +    }
> +}
> +
> +impl<T: IntoGEMObject> BaseObjectPrivate for T {}

I think this use of a trait is somewhat of an antipattern. I would
probably have suggested a standalone method instead.

Alice

