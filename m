Return-Path: <linux-kernel+bounces-872624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B7C119B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3B6422691
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407B313E21;
	Mon, 27 Oct 2025 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeXom3uw"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A22D7812
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761602619; cv=none; b=gilRdjLBpIr+mdAAwXX9U590yBffxt3Jk8Ejcu5TSNfXbPUf8cKlGs/o0uZGQrnfKuDCXMhHoxVusKkgz7h41zaIWEO1DRtZflL1ZsN9C8HywXK6sq1Az5PxP0eni7wwRrbU9DHHVLGiMb6NKqHZPcJxzHLgTatZPfm/mrdyYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761602619; c=relaxed/simple;
	bh=o2yvo08Ip4ydQArcoPeQZZ9iA6ySykeNGAN58HBmLGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkE+Z7ihDwdPiF1F4THd3DzlNAxZ5+UWgCKDeCF7imSTvB82CciF+ggU+mNxYi4lvE8W4CI4etoKtVTbFyyD9tdGrgQG08Vo3IraBmqFjTuUbuXwSBiTq9JQ/9vcuosMmScBBfbJEUbJSYhOrWU0g/U43ZfNHGxuOcSzbeKp1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeXom3uw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so3991a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761602616; x=1762207416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2yvo08Ip4ydQArcoPeQZZ9iA6ySykeNGAN58HBmLGI=;
        b=eeXom3uwT4g+9P/RhdrWTyKuQqPL14o6Hn0xHj0OX8dE3hSqjc0mcRVpOIRTRaM7es
         aRmVPWQHXgUAproPolF7ok25yMyA/1SMR8Gnj1vPDPeUWWr7myJ7vugSW9ZsW9LxY0/I
         ehvHAWqb07lxGTsUBtDWRsMJk4zLRZzoECnMwjNHvHnI96ob4D06JjR6Nkf2iDRDB1eT
         w2gfRp/Ztm3PIbm1w+Hc2xMp2OzTOnWfvLyFdjGy+LrJMmPSN2hrZpOzLiGqG3HQAcHv
         BYh9tSuPuU+NeEIKJXPMydPLphOtTsWgww+skVviZXL359zQtS5qDScob1PWcN/xiAHe
         Nx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761602616; x=1762207416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2yvo08Ip4ydQArcoPeQZZ9iA6ySykeNGAN58HBmLGI=;
        b=jILwf4SdG34+RbxF7seZ6D5eT7kvLDlfRU7Aye3ypqq2BQDmgLDYvB9o+K26+NQ+7A
         +pYRDmyyoPmUcSvJOix9H/M7iGhQzmHMdFI3Yjv+T3Ko6XPEy1ddoaJ907xFPEN0Qd2R
         H4cdrMAWh76WjVDexubZBTUhkuk2UmWQUJnWn8ZX1EjZK2vBcs3KMS9SIob1raoWRA1m
         ZKjTuV1oeHp26rofY6o9xvFZ2zlQB9iKccweMoU9YIocrE50rOcd7uFlE3+wik+PkZeP
         zWPP6GAXdI2PhOQXZ201H0SoQOwfvmssP4IVsXB+x+vNZ5W3ywxadv5KoTsQWiIOcN08
         hiJw==
X-Forwarded-Encrypted: i=1; AJvYcCWxunTYV43w+YTiA1euCmtgnQlA/KgbF0MaYzDlF+XIu3qERLTaNbWPilbMr9e3Yb4xq+89dymglgfhfj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKE5MGJHVqTAujYvD7P0uuAp3YKpd4nTAESaiH7Ek7NxXu/cDj
	g0TTaOvx2NoBlIkHc6xBLmKeYuur/fFnCBBIhGtnNoBuWqyKMIEk9ZqB01yR49pmyy2ijgCKina
	R9fKfmBfRmYhmAkSnQv0qTL7TddnRjfOvFev4It4m
X-Gm-Gg: ASbGncuxdzdKDPC2M8/JXL9N69SlB4O5JGJAucj9RAgvtYGlRjy52dI6pZDbKLxiUW2
	IQFIkJERwSH/U49lazywSP/AK4AWHCnH8QNCXQrH6zWrP3eD1zi6V7N3l/EvHRfp8Pefhb2IAC9
	WSHWXq+p9o/mWcPmgQ/M6hn2urWK8WyiVjBpqHu6uRtt7X3uc2jO3Ctpp4BbXGkghvnZjPxp+ex
	Paw1WStEH4lK/awL7aylKnuiLND5FuUDQ5oWsPrDwae1EdrBjgqKNZT2PxiOUFdZX5S0E4=
X-Google-Smtp-Source: AGHT+IEmQpmkPe9yoXOjQqwkeSYWcEwxmIwno18/dHKODLPNMJTY4Qfi6Uf3STcl/iHL8V6tAR93s5hrkHsVZz2OBcw=
X-Received: by 2002:aa7:c495:0:b0:63e:11ae:ff2e with SMTP id
 4fb4d7f45d1cf-63fdc443d68mr12253a12.3.1761602615812; Mon, 27 Oct 2025
 15:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016200417.97003-1-seanjc@google.com> <20251016200417.97003-2-seanjc@google.com>
 <DDO1FFOJKSTK.3LSOUFU5RM6PD@google.com> <aPe5XpjqItip9KbP@google.com>
 <20251021233012.2k5scwldd3jzt2vb@desk> <20251022012021.sbymuvzzvx4qeztf@desk>
In-Reply-To: <20251022012021.sbymuvzzvx4qeztf@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 27 Oct 2025 15:03:23 -0700
X-Gm-Features: AWmQ_blpuvtqRlYpWMPesPOu7B07-0aNn7e54b89gCEZ2S--g3Rb0i2EBbNBq0M
Message-ID: <CALMp9eRpP0LvMJ=aYf45xxz1fRrx5Sf9ZrqRE8yKRcMX-+f4+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] KVM: VMX: Flush CPU buffers as needed if L1D cache
 flush is skipped
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:20=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> ...
> Thinking more on this, the software sequence is only invoked when the
> system doesn't have the L1D flushing feature added by a microcode update.
> In such a case system is not expected to have a flushing VERW either, whi=
ch
> was introduced after L1TF. Also, the admin needs to have a very good reas=
on
> for not updating the microcode for 5+ years :-)

KVM started reporting MD_CLEAR to userspace in Linux v5.2, but it
didn't report L1D_FLUSH to userspace until Linux v6.4, so there are
plenty of virtual CPUs with a flushing VERW that don't have the L1D
flushing feature.

