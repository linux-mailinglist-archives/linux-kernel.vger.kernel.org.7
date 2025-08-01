Return-Path: <linux-kernel+bounces-753720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DFB186E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6832BA87B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425628C5B1;
	Fri,  1 Aug 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHQbacqd"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF101AAA1B;
	Fri,  1 Aug 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070487; cv=none; b=NYdaALR49BI6wg8E1ERPbdOJm0fFriU0JLqlsLIN/rKmKSEDp9dC2E+bIvQnwVkrMjUQRM4m1sjiizxKWb2b9o5wQ5cEcwdPuoh2Th06Bi2kUbKX4oJscbPlQzkLe/SOzad3f3dtav7x5DmJWSZi+zXaOoImifzxqFcCbp79bfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070487; c=relaxed/simple;
	bh=L01UpakPWB7W7eF8bPP27h39LE33E/0r7RFySxIL7/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dV6rnyo95v+dkwq1WMHAS5fTtqY9nTbOshnpCH2d6p+HoKwAGr+rqFAmEgg53EsGbD0rpyeJUcT1Bk7pZzt3Xez0wCbLP+LX3Wvc013qgTipPHILVXmw9WopniJLGRWue+1FDWhy+xkdsv9oZ9L5CePj6o5JncuGvj7THmpRvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHQbacqd; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4f13dbfb221so105031137.0;
        Fri, 01 Aug 2025 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754070484; x=1754675284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0MRjFCqM4TrxxgK8fACJJHf6TvlgNz6tRrWpYNeTO8=;
        b=LHQbacqdzVgJ8txDskZAC7zvWYRdzart15Ft1mxuKwFWyZHURubK9NeCpCAT1/ljsq
         UIzPvCpM8xO5qB1lYrf8ubpAnSj7ctRugmxujgonQicZTelOFOy9Z4URHban6z6zxwjJ
         KrSD7APy7pF9rQR5YLo7upvufLK8OeFWzO+k8g4ZYheDfSnQBDQSWxzBphyr/BnIwMct
         fihwLmlo1XjbUms+s0Mep7RwPSBkhZx+0xTksbASiC0zblkVwvilnBJJHICgMKaG/xX0
         Ri64FEb9CVEEL16vb8P3nUPaWjUpqCBX8QNnXooK5+zwxEvVpWVihChlg3Z+0e8ubR0b
         q0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070484; x=1754675284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0MRjFCqM4TrxxgK8fACJJHf6TvlgNz6tRrWpYNeTO8=;
        b=GB9UGltcwlhxmYRS+8o8SoeEP0DBF0bigrApjoahWJ9aZLj/f3rVT8YVFBwpxx8bKe
         rpVhiOs8hwLNGAbOZ5LLm4zwC4UQHwlkQE6HCXgX0oA3oQvLEygZAGLBzNj/0dT7AKBp
         0Jo29lBz04C8I2ICEu1RzxzRAFhcYjndX5mcEqhNgOwgRPMYbybqkOXfY83NqJfn6H2/
         yRshhnz1/IlFlX5c6ofgBkWBNudGc0TEeUmlmppvj3Ix3RecFGex9q4AwIqcCTmRfmP2
         6DkPXmEWlDJxQHo2oPohBItDvLswTz34nAm0pyQH2mziPYbj9hpfh2FkVlX3GcN/ObCG
         Tltw==
X-Forwarded-Encrypted: i=1; AJvYcCVWATgiJHXArtwIGz+rkMasItn3AIQZwLFDh5puFfJfsLoUrpD3U5f5qbv6dqrzZPfxUt8ec9+05IIjeyE=@vger.kernel.org, AJvYcCWv34ynImIc+7y+EROYUg2Rsde37i1r2OA8DQerEcLD0tHx3fi+POIFi0Z3skIZOynYNjpUqsgdLNL+qZ7PNxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMJ/4K51vyGvGtrJi2rIhvDnTDjw4nboryMbzSqrSm2p9+Jbs
	HWyIPSMbxefVoijJ20AMFmLOkaIjR8F54BW1EUDOXjQwNS2rGAXqwOJx+HH/u3QjzpuVcPpmTPC
	jKP5u+ANOk1PnxgkMVjJFWHofcAwgBvI=
X-Gm-Gg: ASbGncsAOZ2VM61bvwaXIN1WXuVzsAXMCCxiBKaPT5B2zBPrKNycxHGlo84JFCI74GY
	wTk+Odr1CRmX7awkaCyZ286OV0tfPup5uKP2lkkmJtw/a9zCZqWH8U2bHvNwvV6eoBMXUCKl1hZ
	SC6IdAdu/7gvocxwSnaKXiykmWkif7U/mWDo9Gj5i9M09Pf6cImhm9cb0WM03KUc8j0b5JFlt+q
	VBQUWw8
X-Google-Smtp-Source: AGHT+IFRXd0XceRHT3M4dfEbxWDM9aiQwR9V8aa36tguoPA1FbEVb4pkr+s1pGHduJbHvva81GT+kdg5Fk+PVmsvB3k=
X-Received: by 2002:a05:6102:5ccb:b0:4ec:c4fa:c23a with SMTP id
 ada2fe7eead31-4fdc1b4e2b8mr39938137.1.1754070484460; Fri, 01 Aug 2025
 10:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624042802.105623-1-christiansantoslima21@gmail.com> <DBR3913BFPSK.18K4JBYOPQVRG@nvidia.com>
In-Reply-To: <DBR3913BFPSK.18K4JBYOPQVRG@nvidia.com>
From: Christian <christiansantoslima21@gmail.com>
Date: Fri, 1 Aug 2025 14:47:51 -0300
X-Gm-Features: Ac12FXzRc0hJeQNV_cJ-PTralj6IbzQlNpNqLwcXyReZXjuJjKDrGwJrhUSzgGg
Message-ID: <CABm2a9f9mTu-jT9h87dnY0jbjZf_7anbFN3a496e_S4tPeF_yg@mail.gmail.com>
Subject: Re: [PATCH v8] rust: transmute: Add methods for FromBytes trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi, Alexandre.

> Any plan for a v9 soon? I would like to make sure we secure this into
> the Nova tree as we are highly dependent on this feature.

Yeah, I'm studying to implement the changes addressed by Kane. [1]

Thanks,
Christian

[1]  https://lore.kernel.org/rust-for-linux/CABeNrKWn4_qsAE2pqgGwVuspf7wnzT=xe_hZpuy-0HVTLD92DQ@mail.gmail.com

