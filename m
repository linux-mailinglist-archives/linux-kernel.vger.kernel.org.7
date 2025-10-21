Return-Path: <linux-kernel+bounces-863214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB396BF7451
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F16422B69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2CB3431F0;
	Tue, 21 Oct 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDmQNpyl"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADD342C95
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059310; cv=none; b=MSdZRQFSxxUQUQx+gWtAphSKe4i2T+0aCJrR/pF5g25s/gRp/sL7qz6O+thB99vrd56X4qredHtcK78yUfhdfZrNu2RBvTwXVxy/nGkPe9sVBhYjLOVw9CqdzgBWEee2Jcuxh3Zucv7+3bF2/b8CExpVnWmdjkhKhORSNPTKvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059310; c=relaxed/simple;
	bh=qFg4+yNAZ27UrKFa/0jY50pQQ/TyaCnL0WzY/AbT3Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOCiOg8NtETW+rFXKf91wIol/zdJ7nv5IapAaHbgrjn3DtSbk2OrnhEjRh0Skd1zqsrjRm5rgO4U5F+V8oARRb/Wt0tfyvxlwS3hnhHufJ0fu00KK1GF2ZBqQHeJiCJ+4yJCfbJA2UU1ASnTngE9d2ymvSSbb1IurA62icwjtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDmQNpyl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eca7297a7so7438765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761059308; x=1761664108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFg4+yNAZ27UrKFa/0jY50pQQ/TyaCnL0WzY/AbT3Uk=;
        b=GDmQNpylqDx1ao5zQVD847VGaErTwC9mikxRVUvxuQkmWPTmtaWf00RSlc40/i+kQo
         XKfjdgsq9RUAcjdjyrXvf+g7lvZwAmLrzH21U2JZsI8Xe4hG5BUajmvHwJ5B37tiri+e
         VRviq/6rBOC0/4MIRCOD64U7lRo6Bndb/9TMH3MYtcRcp0Zr+B3gRkD6VV/pVOPwPrgr
         X3Prcmrwnx3CHQz48nQJ/PlpbEwBdRWpL7hOFaNLxEyaXi0qJtkMkg86nlHDtJM7uIKG
         iXtTUI3s3UWtP6mL5uqDpvIz1wlIaIfYgF5MYOon2T5l3wxvrI9N3G+9DPze33/14P75
         MTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761059308; x=1761664108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFg4+yNAZ27UrKFa/0jY50pQQ/TyaCnL0WzY/AbT3Uk=;
        b=q0CsnCR5vJNDZagQIJUWllFqG6aoGP16SJzgshlIm4QpL1gM7D7ACgFOHruGhL8IX8
         IT/mN5q9qZaimGgmwh5uvBvuN9iH2jmrSnU3CSmqMcF4yqiNtAXHDeRfxAjLuPB4dPtU
         hR94EYlvPANetGFOvqi1CLvZhrlb1lct4UB+On4cRnSlmo2KyXH1kXeUyOs1pIlDLlGq
         lP01GlDnOvUuHXK4haRj8TF0bzSusBz/EYWY4eM1xF1G6/vAUrwI+74SzA5MzkRcUVbI
         H/qJTuubpzi7PfgT0/GjdmmrMEeYBA5Lmy/XAUHZxmk+gsv/1EsPQx+IrrjcjgdPcfnp
         AWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/C5ik5enDMwuAc/iXvNnZWTQImyfM27SkcX09UmFtL89xrO2BoXCXq8UWqDV115aXj5TLKi8UDSvFd5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJliSTegjASJgb3LrfNFm5Gcd1j6nVTZYGgjAUqMTWB6SMTfGU
	/nkXKcYeXQgG1BAJ1YSbAOHLv4algNgbNkhryyyked3enAhDYAzb/4WlabfT7cR0+JRoQOhi7B9
	x5XHNRDEc0TBtA0CG3JRbOThNOVwJNHg=
X-Gm-Gg: ASbGnctm2r1peWVkN9RSY6UD0bWwtRobR1FskftoW+PU7i7B+LwYp0aN5IJV7BbmIVp
	PRrIwuY9sqxoB0yLdV8YADHr+JauVTFmTSWPD5LGBelK407N8mwdI2L7ZFUJASdkclJnKX26nCh
	fsiS6L4gLxKNZcixKxfLlV74VDH1qWf9MHEpOnNzCLL+7WkqFqn/1Xwec3Y73ZdUO3VUA8FN5Q7
	byX0pJUVO+T/FXSdAt5iZoRJ6E2qh90QT+CzaSomKld9jJ6pi3XTQobu6+KPcVNf/8RWUVKhcxG
	tulEnuQvyd9bRFFGZ1ImGaP9olK+xlKWlGTCFEhM4+ijWZV3aSOSSxYDU8uUdIwj/IUQyzERB/r
	CWa4=
X-Google-Smtp-Source: AGHT+IFreHdov+uVhNjI+vb4zuqGdoRtHfpLdbPpRiyIyY5EB+5Z0lQXG7LeNg1R8D52vs+phURtS3CNMV6Qy7+3LW0=
X-Received: by 2002:a17:903:22cc:b0:26b:1871:1f70 with SMTP id
 d9443c01a7336-292d3f7212amr26756455ad.5.1761059307987; Tue, 21 Oct 2025
 08:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-2-dakr@kernel.org>
In-Reply-To: <20251020222722.240473-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 17:08:14 +0200
X-Gm-Features: AS18NWCCy2kjmOIA6ceL9V6OXhZcSR6v5l_FF-ORfDMjRgq5VddXOb7GOLYgjmY
Message-ID: <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Add a type alias for file offsets, i.e. bindings::loff_t. Trying to
> avoid using raw bindings types, this seems to be the better alternative
> compared to just using i64.

Would a newtype be too painful?

Note: I didn't actually check if it is a sensible idea, but when I see
an alias I tend to ask myself that so it would be nice to know the
pros/cons (we could ideally mention why in the commit message in cases
like this).

Thanks!

Cheers,
Miguel

