Return-Path: <linux-kernel+bounces-878715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F23C2153B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC6A562CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA8365D30;
	Thu, 30 Oct 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlMB7Dxw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453431197E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843019; cv=none; b=il5dB9NGycrWmdfClAPyCnr+8vyGMVPODohJisTxj/HzLe7djprTb3X7m0ffd+0xr7A7cc9zx+t5Pcp6kO+InSU8qcXsV1IH3L+Daa6SvRayx6yBpGlOqlklJ3RjnqyLracGd4BSeQlq7Fk6Az0edf3c85RZU0DQq1Y0A5J0Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843019; c=relaxed/simple;
	bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkK9bBZIfws9okvRrc5KulOB0rXMEA7EW3qBeh2uZEwpZSs/7ra/MDdDOHeFb/oFeWh/UjCHK4oihE29zDHLF05AsMUBlQpuGB4IwgnkTEpQ9miesFwRgsI+Gao23QkX0decip4gfNhWGthDWSbMYrz8dsGAw5Hb16w97eBvfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlMB7Dxw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eca7297a7so1474135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843017; x=1762447817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=QlMB7Dxw+aVrAdbSUWU0bipn23Xfve7pppXiQG79QFpCrpXyoMO8KZBNoq7a1rtmbS
         4gxFGT15a65Fa8TM8upk3VOQqJZ5+VbO7fjKGR8abQX3rkTCSXPaP1yOnflhCMKpEgcO
         +3cy3G2+WLq6HNbhVZHDlbKmvgZoXkttFBiI1iBPqSF4RVCgoFK3Svji5aq7nLJBixog
         Qg6bDb6tpIU7GTKMq+Y0EHmyfgfwhq3mzPbmmjNlXw23muzhxx7hGoalRFR2UQShT5oY
         DTuB+/obSiIxwhudLi7GcUKBacHSmw/s5yKkiN+NVzuBoBzVyDMFb6ZQSdxvPFOE3n5C
         AreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843017; x=1762447817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=cBdZtz0ZOsD1JcH49AER9BCzX5eONPj5SVvyGrjU3mjMj7pQFYzognRuMKQouJFzH7
         IWAsvA5PvGoy2OTDbtGopHXeQEsVpmN7pPeyA8vdFyZL0io3kiybGumbHHZGwAuOK1VA
         fw+jnzyblovzjGUzNhkRJzmHn0NXzI7qjhvqlr1n8285UU9v544AmxFNhgE/N0ltgljY
         yOR61Wj1kfCjBd4t6t3hS1ttIL3Exj0koPPzAM+YQAwKhXfnavR4L1h36cwTQL6E1hpt
         DE8dK2qBVfrR45tqjGkVoH9s6JSZ6UnOV7e+ll+BXZ8U1biLxPqxd8JuFSvA6L27B+vS
         8Kbw==
X-Forwarded-Encrypted: i=1; AJvYcCVw81spK2qezAnR9CrliBmBr/zr9xrX4wbdzM6U70KVp513g4C0YoDym326GxBsBP/PVPdVnI7MXF6pCcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+ux/ufgBX043xcIaJSLVdEVI9fL8XsNFbi7ny28odHM+8NPp
	1XUvVZCioAfOUJ+PNuYBpxExuXowFWwZUcO5HdWIlfcoHeQK7UFCRMzsMOYpkgE0K+IbSwJ5WP2
	YIoq1LuG+x25427thTFIT/qMENge4lCA=
X-Gm-Gg: ASbGnctqhYWQX3JRB7aDSrm2H4WXuJrEIf5JLt5e0Z0ywICF1oT9Dyo4vxnjjEs8lVU
	R4wqo6P9U95cchqIj9SE8+fhHuulTQRLOm3Tp51JDSfetXZZYrzgoYSlAZHfh/T3E331WYgnPwv
	bbprUu45FPCmS+Hh8PJfzXPUvCH7uShmkxIk5/QLKErorPhC7lJSOA3Qmp2S9OxW0FZ7Hkq9X5G
	HP1bM5KtyiusVu0oJSdSoo+jvRb2EvifGRxgQ7nUXPZSz0UDMDX/y8w+lhh3GnXJJjREhJcb2/R
	RYGCHVpy03BtuP57/NSyZs6iU9hoq4iwPNilOAerZtNTIjsq99GjgCufYMytrRNAwB5R0u3OiRo
	Q+NY=
X-Google-Smtp-Source: AGHT+IHIwOHRSXqelvV1Sdf63ytImuxsi6mN867ttFRk6bB9U4Bt6FvCqQWaRN3cWMuEbnRRwlVbLx8M4DZOhZxBczg=
X-Received: by 2002:a17:903:234e:b0:294:b58e:6580 with SMTP id
 d9443c01a7336-2951a545f7fmr2497775ad.10.1761843017022; Thu, 30 Oct 2025
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me> <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
 <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Oct 2025 17:50:04 +0100
X-Gm-Features: AWmQ_bkaCQLlBdplFGaXs_s6rBEi5hnyY5mzRPNbjRg2sfBfQKwQOTLK3O0jQnQ
Message-ID: <CANiq72kuRNvovHK5r24kh23mo5wp2bpx-EjGMOyNBOF1YzukvA@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] `AlwaysRefCounted` is renamed to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:57=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Since this patch touches so many moving parts of the rust tree, it is
> going to be a cat and mouse game regarding rebasing this thing. It also
> touches a lot if peoples code. I am not sure how something like this
> would merge. Do we need ACK from everyone @Miguel?

Yeah, any rename (or generally namespace/path change) is always
painful due to the flag day change, and thus ideally best avoided if
there is a practical way to do so (e.g. keeping the old name for a
while).

And, yeah, treewide changes generally need Acked-by's from the
relevant maintainers.

Cheers,
Miguel

