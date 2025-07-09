Return-Path: <linux-kernel+bounces-723729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF78AFEA5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D531C81F43
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F892DECB4;
	Wed,  9 Jul 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hf5W1YXP"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C3C226D1D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068251; cv=none; b=UkxAprB1yDyAk97vRl8eFEe2KIfFbCZkGkN8fBRALR+9SN5LYVO5sVsm9DWxB3X+S9wwuMjV6QvlbqWGCcO+8D9gB1WRxFdZI4/aH7WBa9toe/IePfipV3crWOjAD9iwYoLo4+TPILLKggR0Ha7Es9sVOt0OthNhhRZjQWaRJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068251; c=relaxed/simple;
	bh=x1O3yV0tYWPYFSK8SczYbxy40k33Giz5zO0qk0GiNPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU3NevsWi73w5x9T8CLQgOld8QVG76MBnGxShcc2cG1HL+UQJwbwiDzHYXMADDtYS2Li3rIOhjlmuTNAfDAU8YbJktXNSjxxQ5cACJWak/YELmgEKO4XoDeKWvsSYosqjN0H2ZzWKeWrYpzycQakaDQNTcwiNK33RaLd36Q/NyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hf5W1YXP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3050200f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752068248; x=1752673048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1O3yV0tYWPYFSK8SczYbxy40k33Giz5zO0qk0GiNPk=;
        b=hf5W1YXPtxZSSzDSdszBMY8gTXr/oFFGyWLDNSCCQ0dOvd7B+VCaY9Ql19NRv9oPUL
         A3plrVSFhLytYsY7m3teRtBFNpiU2F5vA6gy9z7ruqr9MqXv2P/7evyOR3KHNY1Q8h/d
         1mPa3JlegriI6WyRoOb9jZB9EGdFTx2s6f6Hb4r+7d3g1m6u22pWS74nG+61m45NtzT9
         rfGOe0WASEkT15p+I7xF8ORURKai/JhaIoJ9AdhWNbvIExpXS2PA+LTQWx2SDoeYBpfa
         oacEByb7Eo4Udj2Lq5gnxgq1VLWCK7YvfXs72XsDa+/htpIC481oQyLso1MZsygt6b3j
         ssOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068248; x=1752673048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1O3yV0tYWPYFSK8SczYbxy40k33Giz5zO0qk0GiNPk=;
        b=llsdRuhQC4zOb5mfZj6MLGoPGNwagTHZCxABDDS9VJ9gC3ijKM3NFVrKGx4sfWtiel
         kHpvSrA8jUmqbGYWKs+F6Jj7/se9DejvUH1zIEdz3oR/w4KVzESH/853kdu0842wP1s0
         VCE+Gi6SEU+IJO1/8rvu65lNdui9FiNQPsSuciw7SyDnEEhIQMjr7b7/wvn3waomS1lL
         sPt9UYdNZnOXAPvhcdTVXCod89DGqO2cwMYaFTrjccfcuYyssxyE2PuZc5K1ZMHSLhog
         Ot9g8v1vTatzxzxj5EVBDrTidLxIkW7wp530/dxOZV31KCRZkrqPvDPvBDD/vJe4w5RU
         T4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUQejpWxiC30Bl5nwc5O93AbFS6D6XVnvRNVXfjbazVW8p+Nps9A9dhLeeoGnRxP7s0A7tUxu1lnVRJfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtO2HnBh7tTM9AF4TvFyCOoHPxdaXqq1ktozxjZeLvN4ZMuON
	TmMXFGwF/tTkyKGWpFhldp/mc6p+m3v8rEln2uNxq+l0ueL5hd7pz+17pVT2ytr3p+mM3THHQ8B
	p23SDc8iWeV+QthYMTXpBccY4EjO7fw3TEjPzAyQo
X-Gm-Gg: ASbGncsfwCnOwVQVbingyzdUVUJKy92KWny4vlJNu4lO2rha1g3UpiV8bbadczFO2r0
	LdV1uKG4bcPHOId628fSrbWcKLNamOdzWWJNjIcChfhVQV+SgZ5IUa89nMTzz+x70n0vbaq6ygC
	scLVb9rpe/+QjbWWKUYfq0rwhoKMX0MLLkdYlgXh6tJOBVn/mPRhFo4F3PDlhD36VRj2+xCmCE3
	g==
X-Google-Smtp-Source: AGHT+IEA716nulAqRa5a2S60pK57wjynJP6MZeuoqr0aItMDvDtiVKvSCOQ7tPSH50CZIlyU0jurvE61IyCCQaR9h4E=
X-Received: by 2002:a05:6000:178f:b0:3a5:25e0:1851 with SMTP id
 ffacd0b85a97d-3b5e44e3f6amr2141108f8f.7.1752068248159; Wed, 09 Jul 2025
 06:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
In-Reply-To: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 9 Jul 2025 15:37:16 +0200
X-Gm-Features: Ac12FXyCr_gESQ0NBGSVDz1Tvd9THD57xkpCcUipxVzlzPqqz_epCDTU0SghXaQ
Message-ID: <CAH5fLghgRy_B6kJ9c4HDWw-EUTcUQC6qhm81zizeRk+mZPu_0w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rust: list: remove HasListLinks::OFFSET
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 6:30=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> The bulk of this change occurs in the last commit, please its commit
> messages for details.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

