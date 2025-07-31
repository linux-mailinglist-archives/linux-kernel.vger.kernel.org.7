Return-Path: <linux-kernel+bounces-752219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1823B172A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B9516A53A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837092D2380;
	Thu, 31 Jul 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe92orvU"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23592D028F;
	Thu, 31 Jul 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970411; cv=none; b=D5AVFyji1fcdlyIgsWVZr8X0su1rmauwALWIgozZzUiu3kHWFvpM7eFNPEKpLdLjwYiCuI/Pw1y5HKSw16pvogFZW4apzcQSzZdcfI7n4lOvHXWNqhQ+3W6k68aq2vUldLJ5Gh/lhNONIG6idFghA8OfkDodK7/+4Mjjk5FhzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970411; c=relaxed/simple;
	bh=xpxdtsF6STFJ1b1gtyzUBoLHf3NnZC0dsUVPA/2imnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuVlppFkqn2viIa+Sne2g6+YeGgTRFwg0FIkIR0be2ckZN0IduZYDcVCQgQIsE/KZiZqOfg5ct3EolE+GwoPrWzyfELHV8Z4yBxouPuaEaOz3ySIG50scOEpC7cT3WLwafilYtITTtElCbBvqX3vyYpktjhNtDMzhxANSC4gvr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe92orvU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31d578e774so1382159a12.1;
        Thu, 31 Jul 2025 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753970409; x=1754575209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpxdtsF6STFJ1b1gtyzUBoLHf3NnZC0dsUVPA/2imnM=;
        b=Qe92orvU1/WnkelNbxFtMHA5jEr/e4UsF+ToctneAmbcpi0Taw1HAYkS8ifPusAu4a
         TY017jjRiirYZ/C54PYHyjZ21uWyAyhFEtSmlHEtMPlKBh95oLDZ34d3Quyab+XWu8xL
         IEP0IXrINzVMUQdWkBFgL4SMwJDHg44qxRwa0eJPLxgS+KEu06yWkXaQl+isnurVt+y+
         HUaqROMdswz7dKGZ0jUeTNHYDZHy0TEXt7WM4IycpYQNHOF/61yXgSZfB4kr9i6//xHF
         Aiy5hbZ1P/PeXw1UKNErPNkAp5zWF96QjnrPcohM0YBoUCTo/IUev9WEIpIfMFpcN/gN
         l5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970409; x=1754575209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpxdtsF6STFJ1b1gtyzUBoLHf3NnZC0dsUVPA/2imnM=;
        b=uj4pvLnTP5Yxtt0LiziUZtJeANNh/TBEiBG5Lyo5UWYD+8w07bwCxaGu6t7qXpnmwX
         Kyx79K0A6rsOYz76yEhi7BOC950er5tl5wlMVMBftPIszvP07z2j7OYYHojdiJhixFgE
         zAlVi3RH8D3HMupLevli+YRtHe5fH/hudogrvkddtcJbu/l+or+FdwnvnUBshQPkz/7m
         JF7jm4BsQ0Y/QRo4EcFXme7j4/ZN7daZ8blyprjR6STIvVHB9PXESpVc2wHerhK0w+Fe
         XHwUuKwa3s3sBKcnvUkcLy8xDBCMGJeqJDw6cIgANlMO5WLGCEDgEF9nojBBzPWlIOQT
         lIag==
X-Forwarded-Encrypted: i=1; AJvYcCVORgQ/4TnhjJddnvvkaJvetX5kbbkeT2HDX0+feKNcdcIUH/KPzuxSxlYCfa8zfxfhOso+AbGdgnKC4iarb8w=@vger.kernel.org, AJvYcCVrVmsv4/EnN0r7YoIhl+DIUs6uvWs8f7rWCJyv8CVRHCbajMRP7xGHCiUocjSlvdeBr0mBiPlQMFJixV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymbjt9iD9lWY6GkMg+pOnwDt+hVkPxmWKADl9qQ0w59u7b+wS/
	/pGgxumb1b90xXN4dyrO+bu8KE/aYM1w/tp4ouwGp3JLBnqhcCX6a34ezugtrIANJEVthX7fWZl
	bKtchyuSZjFbNDY9jxqwRjWwEmhWH0P0=
X-Gm-Gg: ASbGncs3ASBCbGgRHiu4DvobmlFXBFFMQpUgRbn1Il98oYWFuwJrpD2ErdP4s3p5p7d
	AKXPJ0PiCbSB7F6LMq/urmG6B0zEwjQc02YKP9dgnHYBXTfcHy3XEszkeSJjs02y1Q5rxgioHZ6
	tN4oXDDnQObK0YzLoFHNagOwVSzv0d2sE6eavj9nSVG5RLDCaviB8h760fdCk6RvvAWSkBShoP4
	ewPzwTcIJecVFZX
X-Google-Smtp-Source: AGHT+IGFdQmve3dFiAbG+K2R8APsI8dmb9w8628lNOWn16iqpUJ5Zb+gv34TOYrMvzyX8aomM7PW0PVi7xXuZtn9Nu0=
X-Received: by 2002:a17:90b:3b48:b0:313:d342:448c with SMTP id
 98e67ed59e1d1-320da5f8db1mr3138951a91.17.1753970408798; Thu, 31 Jul 2025
 07:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716090941.811418-1-shankari.ak0208@gmail.com>
 <CAPRMd3n-1nx6BnL=OtrrJqS1gCxYAw2wSaHUQ19174Y=ShqO6g@mail.gmail.com> <f958ac81-c092-4958-a61a-d30c8389f431@kernel.org>
In-Reply-To: <f958ac81-c092-4958-a61a-d30c8389f431@kernel.org>
From: Shankari Anand <shankari.ak0208@gmail.com>
Date: Thu, 31 Jul 2025 19:29:57 +0530
X-Gm-Features: Ac12FXxelyuvvgNeGoa45lYo9RSBJ4RlQNxrFo8Exnt-dB5VecXZqRsfuenXgUs
Message-ID: <CAPRMd3kvemvtEM4976+MGRbLJV+4X8Hwvodc0q8+0jtgT_V3Rg@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Where is the rest of the series?
So actually it's spread across various subsystems. I had given the
notation (2/7) to have a count of the patches under the same effort.
Apologies for the misinterpretation.
But yes, recently Miguel suggested discontinuing using the notation
but as I had sent the patch long back, I didn't resend it.

If it is confusing, then I'll resend it without the series notation.
But, this is basically a standalone patch.

Thanks




On Thu, Jul 31, 2025 at 7:23=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 7/31/25 3:37 PM, Shankari Anand wrote:
> > Hello, can this patch be picked up for review?
>
> Where is the rest of the series?

