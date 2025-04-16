Return-Path: <linux-kernel+bounces-607279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D09A90437
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 15:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473431905760
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC681F63C1;
	Wed, 16 Apr 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws0CLdWG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73B1F417B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809512; cv=none; b=Bm5qW1wxCFwDFM/Ian1/F4jlkzW7Cg5CoGgp5P+Yrh6GMxRGgM/12Ro5xNW00TSdfN3LjoXNQMcW/K03UcB8aJAEqDyj2qg5IwZPzICziFq5TXxWTkOZEdBYuB9sUzQvomG5wLlBmIV5l5Hw4lTnyAqSn8y+Wh0RfxbQ/78o84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809512; c=relaxed/simple;
	bh=40MZITXjlno7tjCb4AHyz9gkWr5g4kZZoOXV6Xt6QLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGD5CU3Reu5+V0WYoRx9HPY5c8gx81C+DWEyaSwzVm/xLRtp6S75foY921b/0TUknE3+wvMTm4edzcPmpdV24LhKxhS+f9zDWrb9oJLyvRyQ2X6CHbQop5xNOvoIn6QZllEJ4SD3O1/v75s/yLB2UIt5jGgXvCHsnn17E3zOq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws0CLdWG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744809509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYYwLTuVZAD8yB0aza7qR8SAg9Lr+TNGrhR+c2xdSYI=;
	b=Ws0CLdWGrUyJkbB0xg5i3ZslKsr4a0Xjfc9vSGXrmKV5rXueEgFSnZcJ57NB4HrgsTPthH
	acTrq2jovv7XJrMb1oRyS0qR77FdWEciS/WhdxZcQ6DC5XLvKOOTpzN7peoyAC98vd42cj
	jmOdFjRPErN6v9ZJvLKoTNLvq1uq+LM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-0QdYiOkpO66OvG4nwyEFpA-1; Wed, 16 Apr 2025 09:18:28 -0400
X-MC-Unique: 0QdYiOkpO66OvG4nwyEFpA-1
X-Mimecast-MFC-AGG-ID: 0QdYiOkpO66OvG4nwyEFpA_1744809507
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so42097425e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 06:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744809507; x=1745414307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYYwLTuVZAD8yB0aza7qR8SAg9Lr+TNGrhR+c2xdSYI=;
        b=Z0o+HxAA1PmuO9hFgnqFI5l8w7CBllG05hWZX8DTnU+E1gXe1rcjrdxrbQQqD0lXZL
         lfIkQ0YCRum/rOWeg+iQn5cX34W5EOEwiuFCHzGoROqk6TtS6Rb1vW5kOpm0Zt9UkCwp
         IoOms+rM9RDet+fm4hgUp1gBTGAsFHa6oLzZmew1ZreaBkcsDjYcRAaKmTBCYE/NzsZf
         86FAMStK8ToKUxb5t896uWEW3COX1ivKniG2oq+oGBue5sMKzpoKUOAbqcadP6xX2lCS
         +CGy16brYpwPaA3rQnDqbLf7UDKfHEpYGkzy18fWGIxnkULtjumeUGGNDqFj8MH9LDW5
         DbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkRB5iHNouqtGLLuPOQ5w+PCOu1VEVnf1YUnf+WFFJAPjXVaTWPVTp7FwgeGF/YIVugfsAcDsJYvXIPSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDLmHmpiw+jiyGZRY42bByyELyshRv4TCz12v3ue3EdDS75rv
	7ZAgzLdk9xqdJwmNCZv4wmvy86BIFPfxqYwU2JYHtuXMxH/0OLt4amsGa3gDR0zmvIv2xO5gJdJ
	gtTTrQ8SLMqfPS0jGpMrFMXrJ+nyg/pO1AD1n2Xo1urpX1sGmWDxxIRIwWl744975vR14cg==
X-Gm-Gg: ASbGncu4a5GfAJLpFndFHcrjpCI/SV5R6Zckdi7fAtsSFqwrhF7M6lz75lpeABcxf3X
	wq1aIbo/CMPTBLNOXWiOERg0oCXzlgdJfXhjeZGi+/+GckFFeLyc3sVABRVeIIDnhILAbC0ShU0
	tiHfcbEG9UfC1RrcLi+wPA1+WXsphCYUQ9yAnY8tZ05zuqmJ0HYMvnTbmaduac9L7qNDovFn6f3
	ijo7s4v5rbsKdXI0mtupiOB4m80UMVGnrLrf5nvARCeCuDf1YIoTbwm/wKcYVYgZEXmzHS0PVtV
	dCsgv7taiKDM2Ihv8Ep39GqlFLp72IxABDR+DoSz5ZZTfalx0vE=
X-Received: by 2002:a05:600c:1d2a:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-4405d61ca24mr19761355e9.13.1744809506783;
        Wed, 16 Apr 2025 06:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwLxrssU1ldVAsWqYITreGih0SWn1/lrOXhFExpzdKQmsh4xxqB+dzhCbmzH3Ij6WFE80fmA==
X-Received: by 2002:a05:600c:1d2a:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-4405d61ca24mr19760785e9.13.1744809506096;
        Wed, 16 Apr 2025 06:18:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4c8378sm21587785e9.6.2025.04.16.06.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:18:25 -0700 (PDT)
Message-ID: <7e54be7d-9c67-45ad-819c-fba6d2da16fc@redhat.com>
Date: Wed, 16 Apr 2025 15:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: use `///` for private items too
To: Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Gaynor <alex.gaynor@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20250416122106.2554208-1-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250416122106.2554208-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2025 14:21, Miguel Ojeda wrote:
> `///` should still be used for private items [1]. Some of the items in
> this file do so already, so do it for a few other clear candidates in
> the file.

Thanks, it looks good to me.
As it's only comments, I think it's not worth to mark it as a fix, and 
to backport it to older releases.

I plan to push it to drm-misc-next tomorrow.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>


Best regards,

-- 

Jocelyn

> 
> Link: https://lore.kernel.org/rust-for-linux/20250416112454.2503872-1-ojeda@kernel.org/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Not sure if you would consider it a fix, but please feel free to add Fixes: etc.
> if so. Thanks!
> 
>   drivers/gpu/drm/drm_panic_qr.rs | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index f2a99681b998..642e3240a014 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -315,7 +315,7 @@ fn get_header(&self) -> (u16, usize) {
>           }
>       }
> 
> -    // Returns the size of the length field in bits, depending on QR Version.
> +    /// Returns the size of the length field in bits, depending on QR Version.
>       fn length_bits_count(&self, version: Version) -> usize {
>           let Version(v) = version;
>           match self {
> @@ -331,7 +331,7 @@ fn length_bits_count(&self, version: Version) -> usize {
>           }
>       }
> 
> -    // Number of characters in the segment.
> +    /// Number of characters in the segment.
>       fn character_count(&self) -> usize {
>           match self {
>               Segment::Binary(data) => data.len(),
> @@ -569,8 +569,8 @@ struct EncodedMsgIterator<'a> {
>   impl Iterator for EncodedMsgIterator<'_> {
>       type Item = u8;
> 
> -    // Send the bytes in interleaved mode, first byte of first block of group1,
> -    // then first byte of second block of group1, ...
> +    /// Send the bytes in interleaved mode, first byte of first block of group1,
> +    /// then first byte of second block of group1, ...
>       fn next(&mut self) -> Option<Self::Item> {
>           let em = self.em;
>           let blocks = em.g1_blocks + em.g2_blocks;
> @@ -638,7 +638,7 @@ fn clear(&mut self) {
>           self.data.fill(0);
>       }
> 
> -    // Set pixel to light color.
> +    /// Set pixel to light color.
>       fn set(&mut self, x: u8, y: u8) {
>           let off = y as usize * self.stride as usize + x as usize / 8;
>           let mut v = self.data[off];
> @@ -646,13 +646,13 @@ fn set(&mut self, x: u8, y: u8) {
>           self.data[off] = v;
>       }
> 
> -    // Invert a module color.
> +    /// Invert a module color.
>       fn xor(&mut self, x: u8, y: u8) {
>           let off = y as usize * self.stride as usize + x as usize / 8;
>           self.data[off] ^= 0x80 >> (x % 8);
>       }
> 
> -    // Draw a light square at (x, y) top left corner.
> +    /// Draw a light square at (x, y) top left corner.
>       fn draw_square(&mut self, x: u8, y: u8, size: u8) {
>           for k in 0..size {
>               self.set(x + k, y);
> @@ -784,7 +784,7 @@ fn is_version_info(&self, x: u8, y: u8) -> bool {
>           vinfo != 0 && ((x >= pos && x < pos + 3 && y < 6) || (y >= pos && y < pos + 3 && x < 6))
>       }
> 
> -    // Returns true if the module is reserved (Not usable for data and EC).
> +    /// Returns true if the module is reserved (Not usable for data and EC).
>       fn is_reserved(&self, x: u8, y: u8) -> bool {
>           self.is_alignment(x, y)
>               || self.is_finder(x, y)
> @@ -793,13 +793,14 @@ fn is_reserved(&self, x: u8, y: u8) -> bool {
>               || self.is_version_info(x, y)
>       }
> 
> -    // Last module to draw, at bottom left corner.
> +    /// Last module to draw, at bottom left corner.
>       fn is_last(&self, x: u8, y: u8) -> bool {
>           x == 0 && y == self.width - 1
>       }
> 
> -    // Move to the next module according to QR code order.
> -    // From bottom right corner, to bottom left corner.
> +    /// Move to the next module according to QR code order.
> +    ///
> +    /// From bottom right corner, to bottom left corner.
>       fn next(&self, x: u8, y: u8) -> (u8, u8) {
>           let x_adj = if x <= 6 { x + 1 } else { x };
>           let column_type = (self.width - x_adj) % 4;
> @@ -812,7 +813,7 @@ fn next(&self, x: u8, y: u8) -> (u8, u8) {
>           }
>       }
> 
> -    // Find next module that can hold data.
> +    /// Find next module that can hold data.
>       fn next_available(&self, x: u8, y: u8) -> (u8, u8) {
>           let (mut x, mut y) = self.next(x, y);
>           while self.is_reserved(x, y) && !self.is_last(x, y) {
> @@ -841,7 +842,7 @@ fn draw_data(&mut self, data: impl Iterator<Item = u8>) {
>           }
>       }
> 
> -    // Apply checkerboard mask to all non-reserved modules.
> +    /// Apply checkerboard mask to all non-reserved modules.
>       fn apply_mask(&mut self) {
>           for x in 0..self.width {
>               for y in 0..self.width {
> @@ -852,7 +853,7 @@ fn apply_mask(&mut self) {
>           }
>       }
> 
> -    // Draw the QR code with the provided data iterator.
> +    /// Draw the QR code with the provided data iterator.
>       fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>           // First clear the table, as it may have already some data.
>           self.clear();
> 
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> --
> 2.49.0
> 


