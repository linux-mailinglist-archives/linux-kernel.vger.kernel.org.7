Return-Path: <linux-kernel+bounces-785005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0D5B3449E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F0418925F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC62FAC1E;
	Mon, 25 Aug 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBWTNcPV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB341E8342;
	Mon, 25 Aug 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133581; cv=none; b=cMYANdOgPUX7CZng5yOTnHLzrvtMrfwrc9Oy2SdDnG9bQSVwafYojcc8aKiHr86R+g9tbcYg7IZ09a1FnFxcOB1ZMi6GEnyn03TVHl02Fd8CSLWsuwP1rjwDbFiuIKDoXarQPcdYP40PAnjM5sW3ajigFcFF+hvCXBXQye+4doo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133581; c=relaxed/simple;
	bh=jdp+Dn66hw2Wru62LNH5z1u2PJFmRRQqDonu9m9n4OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXGCCywthaaFVvZd4giPiqKSOJPRTQ0zR1IJ6YEWzwZZufrZ7wVsyPcOQF1ilFCblIb4NjON3GCM0FK99V+qr/ZGsUeb8oLj+uplwhV5kYkjpZ8MhN0QMetmuQL4lL9gfh0MkODvJ5Tzvcv0mR2+Q6mHTj0e6/wV2xm10zeK4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBWTNcPV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-246163711caso6092445ad.3;
        Mon, 25 Aug 2025 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756133579; x=1756738379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdp+Dn66hw2Wru62LNH5z1u2PJFmRRQqDonu9m9n4OQ=;
        b=WBWTNcPV21wWfq9eZmUpoiIY6hDPmGqROzqGjf9cPIqQkhq447M0Om9wGDiX4Hwxh1
         uYpFhHqYkoskQro4DMNVHxWR5o+Mts5xyJVGPtaAyOv4gxvYcwWAKcKdzeJZrnUUVHvB
         GRkRDEzKnkKkAMuKSgi0rk7aCTLoql1gKizDgO2VYZJq1yAhlgQXYzKqlBfaqkPYRCd8
         pwLAdncgxf0OrWt1EjQ1fQhzOdGMGt1+GnK2HBu92BJMRekCd8KokvqR6qBAF6I+zvAj
         T+dIZT4qumPDOln6bPTgoHqfXis1wJxcOuL+z1E8c5C8wFBmMcWWDqy8sM4OFJa1zVKE
         wN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133579; x=1756738379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdp+Dn66hw2Wru62LNH5z1u2PJFmRRQqDonu9m9n4OQ=;
        b=I519rzTrTBBEXt4baQrxRd7LmkQRRmTypY5pHsjaFYHU529u2gitKlqzKHponfx68V
         OLYVprv0Qaq0Z0+uURIqAfuoQ+VnFxasRbVOCbqLc1ckyQxvmFTDLvs7Vpy0Zn9KQY0V
         ib/E2yadmOCEa90uncBsquvFKeZINz8ed70Y9YdrXuPdoGVWfc5dY9jq6OQM0YavEoiy
         hyCWZdSZPgwWifcgyjiW7xHtDnFQRBMgFJcppqJ9g42dkDgjzy9nYxj+ljNIvIH312JF
         wd9IDgZEyUlHJCkrCjie4zhxCsbTPlo+w5LgX6K4SZtaAPJiS7u01P6t6qts+oev4Onm
         e6lA==
X-Forwarded-Encrypted: i=1; AJvYcCUzfZC8eUHHkTXFY/ghz1+X09XK8EPwz3bBg1IK+ESMiOZ7BEpjmDAKohxvRaeBYpWKCmzvMPTiv+bokUkdxMY=@vger.kernel.org, AJvYcCWsI+r+IQhUHiCzTZ4naGPjDZFqIDH6wrAX+I1lfOsb9WivodXVhcJxUTE9EHg7lmUWZUyOCJVOB/6BT7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkZK2qcWLeiEIZqQQ6sBHDvZqgIODzwHVl4A/ORVVTxDGK1JG
	feFoOKZNpipY8iLT6U1O/FU9URNBHccx1McaI044LSAZpoIz38PB4yVaJgA+H3Piw2cV0akqFL3
	pFZEDCHjir9jhjOoTb99N+GNo7cbwGws=
X-Gm-Gg: ASbGncuDUYwl6jhM7AzrJ+0a3dyOI8olDX4JkUodPCTWPvnNGVRQFu4Sh45ozNAduMj
	MZIGWegSHKmVcr0i8P7griTT8N0e4Rt3rOELN46Nsb7bA2DbnGFbgfuYFQ0aW/En8acIBk19En9
	AjganbqVwBwrpK+dPdDTcUzOJKBXpSba/1opVFjl6kh50lBwvDvgqlGC4pRdvMlhcr2iCR3HKB7
	5UDiD2KI2gehwOuTp+vwPX8bDDoaT3E+ttHxIkgREFbGWi5XLEnY0xxZYuPpDcrMq2UZaGdzRcW
	6QXEQHZ6Hfg2Dc6kJlm5AmdLHw==
X-Google-Smtp-Source: AGHT+IEHBpZefOCUneOQRV8WbG9X3NxEPMF/mPQo7W3X0zslHQ5O136Fe77jQkBCjfyXAqKStaast3gO+vGOIlHcugA=
X-Received: by 2002:a17:902:cec7:b0:246:c843:6e07 with SMTP id
 d9443c01a7336-246c843713bmr30833395ad.8.1756133578611; Mon, 25 Aug 2025
 07:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824213134.27079-1-christiansantoslima21@gmail.com> <DCBG0345JTPY.3A6MSWZU7AZE5@nvidia.com>
In-Reply-To: <DCBG0345JTPY.3A6MSWZU7AZE5@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Aug 2025 16:52:46 +0200
X-Gm-Features: Ac12FXyoy0imn7GqM5iD7umILrViwsh3vyvPrLY9Z9QbTur0Co9822DtOevM-58
Message-ID: <CANiq72nrG37BZv8YzcH0vrqJKMSnaiw6gffzPVNMU1=SHJhr7g@mail.gmail.com>
Subject: Re: [PATCH v10] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 12:39=E2=80=AFPM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> If that works with everybody, I would like to take this into the Nova
> tree (after a few more days of review) as we will be using it this
> cycle. Miguel, is that ok with you?

Sure! I am leaving a few notes in another reply of things I would have
probably fixed on apply, in case it helps.

Thanks!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

