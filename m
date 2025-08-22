Return-Path: <linux-kernel+bounces-781344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38510B31150
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC8E3B3B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0912D027F;
	Fri, 22 Aug 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn3OR8ti"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A210248867;
	Fri, 22 Aug 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850085; cv=none; b=i7Ey4M5QolyqtZ2B5W5GnlfTHpnr7/LLe4QGWXbgAx6hNOrFZMvT0LGzWhYK0CmiIc8tsELLt5K3jarvnFHQQonr4824VBN/2j6oPgtfDKKqFm1oP8TPuKAJY3ONHi8fbHQ+opcoIsK5eAssEvkmkd3Ldg6hwfFuJ4js0MBl0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850085; c=relaxed/simple;
	bh=lq/cU+eoWOE/sdQ7KpO7knU5EeiYpBjsnA6Xx0gMHBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajJEYoUL6jTSI+VgWWuAf5a2yGxGRtcjofoNhjEV1QnFvh2tejO4rpKVzDKrDlJ/7oFb+6T4E66e4DWL+BSXNB7i3cy0/jaxweot3JO3LVpgmGYYU7hT/hd8mQoVXMf/GjXZ0FJ26gU9SzZkkMQJnj+DpWYcd0K5H/hX9YVkZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn3OR8ti; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244581eab34so3710935ad.2;
        Fri, 22 Aug 2025 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755850083; x=1756454883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq/cU+eoWOE/sdQ7KpO7knU5EeiYpBjsnA6Xx0gMHBY=;
        b=Sn3OR8ti3JZ0XiuWH+QI6vM6RlCL5uuYDPl+po6m/uxzFEdpbA7gO/rbz7igxdj1mm
         jP0sBolV/oKpOeAwxAhcLuWpZAHwrH/oF516360tCXR3mbTlfKG3pZ9KcVguqsRE4i9L
         yDIioGqB9iFV4wjDcpe7JZyfDmbQ0sjBGdm9Ee2NNiP7a0F3vEAIu9skXyZZjxAGF0TC
         JjPIdRlvDMRIMYFVVszasZkvbsog/8Bt84viGnI3qfXw/OLYRUmsvnIybttgXm4TT28T
         V0pJS9nKTMkpTk8jvQb2s2Y2YEQ3BDa20sg8jqi8+H5J9Tu0N4Nro3jIBP49pLUZNK2X
         123g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850083; x=1756454883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lq/cU+eoWOE/sdQ7KpO7knU5EeiYpBjsnA6Xx0gMHBY=;
        b=eV0K6ijDcULUmV64sDUfJilE5a5d8/QhTUrlBDBGfQd28GP9HXGO2j0eQX5fCAkRjK
         6aZcg/3DTHIvZ1DMTynJYSFq3unWlve/WWGOQSdC4/IH7qCrfzgiwe5kwdY12qChuftN
         oTUVr8MTI68fWkJDRjKz2Dleve2tCdredg8UFwj1kvGAHWHIgOsJuiA4isP0wAYt1ypB
         zATnDTAO7AumGnBTZXp8VQGG6hLcG+JH5IMxp4kp5XQq7txj17/RR6yt5sIhKsbs533V
         zWx5FaQ0xKu3w9d0IZBXztdo2/0VnsIFAG0OWP1+0IXz4yaeDCMxLa/2ruLy3/oaB7qp
         NGAg==
X-Forwarded-Encrypted: i=1; AJvYcCWS2pSsm8wOJa14g7FJaHAk97tPUOPl3AzH1YdBYlxekVpZFyFl39rEmeRAy+k++y+3emdKYvjLUDNOaAk/+xg=@vger.kernel.org, AJvYcCXRaUYGcwzxP9COw9x53ghkHH5PHpQhu322IKBSH4FuiOLhIcHv+fL5CZmBIj2VwH5BrY4EvRUxQqnRBKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhEOv2fbKhxHPUm6Xz+dgMEoeYV9bvakJtg3wJE1V4Np/UEp/
	m1DwTiyx7o2WzPNdogA7cAEO2PYcIs4sDOf4gM2Qyz6Akxa6wI2RWyNQgxPjUvM7M7vi/4f4Cwb
	x7Nqrkgk4B9FvSjj9fQQnrQDfnU9duJg=
X-Gm-Gg: ASbGncs8mff6xOvvSiN5u88VovGtrPVec3lo4oR2o77pge1OlF9q1uTnGQUTe9/zYUM
	6dT6fdCZLO5adU4whKkTTIKfZpk83JlbgHXDGbdod97K0k4MGJD/uauuwdQtLqBEovg1ZvcTc4B
	laIo9H++FPuT9EQUdAF5+suAtSneLScmagRzlC0M65hfy5XH+IEXIv+DwUElX3oHEpVZCVQVl7D
	jlXt/W+gx/YV8JQ45mTpQKTMSonfjGZYVSh5VNuM2MsxH7UD4wjqDp7sRVlZDiibTcyusBVJjUB
	qhOiFvn4qoerDbJnpGtpYjm34w==
X-Google-Smtp-Source: AGHT+IGeowWPQoQbdovHnOpwzIkuEDwyZJGkAAUZvngmY93YjTMRs33AqqIxgCLByzPbtKA23dwrGNrrN7J62DCUbNM=
X-Received: by 2002:a17:902:f682:b0:240:1879:c2fd with SMTP id
 d9443c01a7336-2462edd76b2mr16991645ad.2.1755850083518; Fri, 22 Aug 2025
 01:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com> <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com> <CABm2a9cyvsXd1OS+tvDoDDEfMgBOJeetBVQU0x3m5E1vV1CApw@mail.gmail.com>
 <DC828042PKDV.16NDVKIGBNTJH@nvidia.com> <CANiq72kDUK0nScg+nK-M2U=MmxTmhayyRUv7n4E3UMQHr8RLQg@mail.gmail.com>
 <DC8MK2TAQ5D7.GHE5F2OREOD7@nvidia.com>
In-Reply-To: <DC8MK2TAQ5D7.GHE5F2OREOD7@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 10:07:50 +0200
X-Gm-Features: Ac12FXz73QnSgmeYZL6x5-ZlcFIy811Pu9i7jylnOGmmXV8QOjuXHFfTdZu_eFA
Message-ID: <CANiq72mWYBAQYj_kWc+6XxrPVzguOd1vUB9f5JXzYdNx9EoXyw@mail.gmail.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Christian <christiansantoslima21@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:10=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> The methods making use of this feature are definitely usable by other
> crates, and can also be inlined by the compiler. Would that be a
> problem?

No, that is fine.

Cheers,
Miguel

