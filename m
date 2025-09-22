Return-Path: <linux-kernel+bounces-827918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F56B936B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774AF443BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D79D3128D3;
	Mon, 22 Sep 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h32Lu0BG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A630ACED
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578390; cv=none; b=isrzRnjeASxTIEWHjBgTFwNhMFnaKLFkWDzk3iUi0Apam+o5DfCyIDqyiQzj8p8bbVpb4BwlmUKN3dFPDesFkKL06onWUmeXQ/P0ffLpm+wvkkxUmtwlcM3Wl4jv0tWtqMTm6sHRWrRCAFeA1iQDtBIBGx4WdFRtLGgVHmCH7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578390; c=relaxed/simple;
	bh=jKUVSnXmSn4FKANXfjyYLOIiAg89nB994b8rJKbFokM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKFPmzHC/J2uIlu0N88AjiYH+qPN6HDMUdaaucvB9lPxs7QdIoRpi5L+nNqspE5Y8yRV4XRbMKKYXQAGKqndBqtLjq394W644pJjTO3tD8rZUszydkP72KVZtFeS/lP1COjGK70qEgcDTUQ2ty9xps3FDoE50a6CDaaZWNiZF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h32Lu0BG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698d47e6e7so10997095ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758578388; x=1759183188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTVCircg+kesKPnjuiU2zmcPm3Wk8hx0LgVUotPUxPg=;
        b=h32Lu0BGY2SAoAMqZEnKFslOWEhtH+8OrSJx2Lkvuzk+ZQ3K6BqOQxq/uJYzfk2CjD
         NVxNIJ0hjjUsBZmsr6XQP2r0m5/RK+VSt4GaRc4CWSBnCBP5L4BuuKq9o9ub1WOQ/fty
         TyP1+OsLaLOfoKIS/6IRcRXZaRW6saWZL/ZnLDf4Jk2Pp9TWv1WF66Hi95F+hCdjQ1QO
         0Udp+ZWgzdxHMAfAJ1X+Bmcw+Zp9lVJWsWX9dqBZ0GxLERIWFaEGJEu0lG5hR2vkd409
         DN+ocLfyZKKreyR0ziuRKoxg/kl8acEWhr8qpjVYslAMGhYs1vWVszkCYOQTCUiILyNN
         UtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578388; x=1759183188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTVCircg+kesKPnjuiU2zmcPm3Wk8hx0LgVUotPUxPg=;
        b=Rx2RCqHOdTpW3GXJcxDoJHx2TXK4dXv+pH2/px3A3TpG+rSV7bRlE6rt7JlqkbxipN
         JYm31F5czh2WFHWG6eMbCGr8kvKvb+p1Jew/9A55RPiHwV0DVVpGqkyU5UUADVKpd9U4
         JveQyxKzsJ9m4bh0JE9u3xrdCDfZ7MxwPfu186e6y2bcQuGVCwOgaProRXQemdmgk1kV
         NG2RyJJm9q6Zka2zcdTpWcdJw8bIgGbhBjRrE+qiuBPXTllGSIuu878IaOGk9/4zauXK
         wVQ1+DozcZnMteCePDGkN9Lfi/5vV/ifFVcjXCGiThKZEYqceysxal++IET6rTQy7IQG
         K7cA==
X-Forwarded-Encrypted: i=1; AJvYcCWuC9oXbAcD4u7mIyHFq47kZRFp6FbKKWZ0n4p2bHMZEnO+8FE/YYMF6KZMUmEtrH1cI08o4/O1/WIIhiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyW/P4vIU7zd/GqoOP6mywHbweAy3+WBJtlg0gwB21U/PGatT5
	wY74l58WE52mtdm82vilNGpv9sg0Ikmf8maan8haSZ88Uz3crghBXq31Ggu8SonoKDGI54oyFuD
	kYrQj5sFvrIEEq9rx6FeCs/NNlolDTnU=
X-Gm-Gg: ASbGncuiwIUB5/LhLGAK0fJYWGz1u+/vFZ2KtjK6MSgFEBONV73kY1ffby3a3puSncR
	umMsFsq9bwg1/T2ZB+Vi635+EyWSjxOFEHvKWcOAP8QYkwUbw/HGHbw1cyJHQF8PIdwex/5k55c
	DPSaTEgvCQfxfRXt3RUyDMY7jBSSFPiLQZ23zzk/HdiNbll+lPa5h9fMFo3Dkr/CcaGmN7V5jMD
	s90yfHGiWARb3QlFCWzeYB2j0M6ksV9fnATaxBvTRKHuCRIga00dSgyeRouKLZZ65n+IVwZ2nj+
	QqHtuczGEECDB++usI4AnXVjXA==
X-Google-Smtp-Source: AGHT+IHO8cJKGFmF6HkfxzDA37dCzzF2eb1sWGALw/BM92tVXUO+gzQ5qLlWsYCyw1t7RNfA8rfVA2phVEot6qjLLv8=
X-Received: by 2002:a17:902:ec8d:b0:269:67e9:4c20 with SMTP id
 d9443c01a7336-27cc41d582fmr2476225ad.5.1758578388477; Mon, 22 Sep 2025
 14:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-num-v5-0-c0f2f681ea96@nvidia.com>
In-Reply-To: <20250908-num-v5-0-c0f2f681ea96@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 22 Sep 2025 23:59:36 +0200
X-Gm-Features: AS18NWD8TsrWVNTwE-9v0GFvv0Ifjza16a049-IVfVsrSbDAQ6mxb5XW5HdMIaY
Message-ID: <CANiq72nP_VwSnFzyM4HKk5GTAwJw+MeX5JXqA-yLBa9JLe9YOQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] rust: add `Alignment` type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:26=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> The first patch makes two additions:
>
> - Bring an equivalent of the nightly upstream `Alignment` type [1] with
>   an near-identical public interface,
> - Add a new `Alignable` extension trait that provides a way to align
>   values up or down according to an `Alignment`, and implement it on
>   unsigned integer types.
>
> The second patch makes use of these in the Nova driver.
>
> [1] https://doc.rust-lang.org/std/ptr/struct.Alignment.html
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Applied to `rust-next` -- thanks everyone!

    [ Used `build_assert!`, added intra-doc link, `allow`ed
      `clippy::incompatible_msrv`, added `feature(const_option)`, capitaliz=
ed
      safety comment. - Miguel ]

Cheers,
Miguel

