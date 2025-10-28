Return-Path: <linux-kernel+bounces-874473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC5C166D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02B03B44D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D91EAE7;
	Tue, 28 Oct 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hos7kiH1"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65549225402
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675315; cv=none; b=lbTa0vpGx8riO/oEViE/y9/BnhhWBmgwjYAVrkW9Op1kGi/MPx9cShRd+k58guDn3xjzAFo7aEzT4g02Vo3Wa4Bzkk7qRUOPwoA66SImTeRvqow48SsD0rE4NZF6eL353AWfy2VQCTQMM9W7UcmTu09CAgaCHMlzluSKhoIUVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675315; c=relaxed/simple;
	bh=IdoA2Hsz3DXflOJ/uWb+OTuJMtFaS4jo6XzpS3PQUeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH51YSvF/nbXUvxMv+SG/MgwZXSBf5e2svqbzSO1TymPKH2cMzuLYPMpGMZ4ZFFJjpMYDx+VUVGv0Df/lJAxTkC9kPMXqsurTSaGUv+/TmxSvI1Azu+WlZ7sK0yDH4ZeybYkAgHxjp8dIZ8J5kS/ai7ggLnW/0tkIkqWO5cEAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hos7kiH1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290d48e9f1fso22765ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761675313; x=1762280113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdoA2Hsz3DXflOJ/uWb+OTuJMtFaS4jo6XzpS3PQUeQ=;
        b=hos7kiH1QkxP5Yn+Mr7DeH8J/uhebmsARHUY36bT4jEhsJsW1ZLZUMQocC2fUFLn7G
         CYQEjpBNMWxnWRJ14kJiv4ReQjDVydfTYiWoAI8zyQR/BfwJ3TxkAHXVEfkHt6kaXLiw
         b6nudCd2hwD5KAG0IddF0HpHsDHN4sMhrzG6I8PfYbJu9ffE4mSIVfq1hDz4LqlC5cYV
         exyNic+sSo8c08Uy9Kg+n9VqB9bibtOw7DrK/97ycbx/0NyI1Nv+XrVVSA0QCDj5y/nB
         dW2fKXGCjiELmy6dzxoNmoY9oQnX6PUcxTCXcB8VOon5uHioFilht5+IlmdemcJQbfLa
         nJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675313; x=1762280113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdoA2Hsz3DXflOJ/uWb+OTuJMtFaS4jo6XzpS3PQUeQ=;
        b=BE/hd6oaez9cIbqwCLSrJJCAj237dL6J6DpZp+1KJoLyeT1l2TV0e/31WFMRiphxE5
         ny1iBrPSWdIqWWZqAX9e1tVYGSBDwJyt6d6qyFRMW51S9HDHay6U2AVQrOg2Gwgv0Fg4
         X+wjRnK1/nbsAZcaSWxziN7WUxVm8eavc4zgHW2IYD69gNyNDN+AqyBOJMvNVFZeVwq/
         LRM2DoHEwg+PQODgyZSgyMB7YohLCFxJuVrX/bLoXnSv7QUuB4WGj/PR/hC016iHVctm
         q4Q2mtDKaRuWTNUL9MMSKqp0Yk25OBYMIhIWG5l3J5ZTwrdr7/sdh9EipMdx0P/KJXJ0
         I52Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwQ0NzeghwJ7I2x2qcz18M+8s5yv4fYsROtsGUp3S0/QTDsKzIicJBzGX3NL1Ov8/0kRzSR9MmshSvrLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxgmPxG+iyzJRkktbduUDqzLvOREbRi8ykcS0TUg6jrOgw7dc
	RJVq5r1C6p9VYnQUWLdDwUrP1t+lMF0NemCikjHLceZ6d7CoTAHYJsn3XCJSMaW3n2CXOQwpp56
	QPg9Rhq7cBFcegYkKmHgRcAmq+sjKxYmoiY8SNoOp
X-Gm-Gg: ASbGncvMCIQU+hsdV/CKx5UR06iG508YNHArqt4u2+iKGXG/S2mtTkssTsAWhLblJFz
	2f/kViLKUXHv5o9WBbH2e/VgZ8e/0ii4P5WG7Vq10rBYas6lG8Mf4o5JZ9Qm+X7+IJcaeGs+0Ae
	6DTcnC3spne3Wf7Z7/jtjhDt7C1TqhqccqlCcCwXCbfAIhZ03Byxbg/DSe/GURHVQCL3LEgWupF
	vwBtMDese3XWVTeLW5MYPR7MgQOKXMEP7qE9GVM0CcPaSqsPylk0jedWw==
X-Google-Smtp-Source: AGHT+IERGgSXUSFxn2JeNfQ2C86EuHjvzEyZOaIycK2W0jkA78IAxEYdTtDG+mA9d+7pqLJIChA0NWObPqGrobS4WTk=
X-Received: by 2002:a17:903:22c3:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-294de36e83fmr559985ad.4.1761675312071; Tue, 28 Oct 2025
 11:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org>
 <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
 <CACRpkdaeOYEcK9w1oy59WBqjNrK7q5zT2rzg8pHgDdZdKWVKZg@mail.gmail.com> <20251028175243.GB1548965@ax162>
In-Reply-To: <20251028175243.GB1548965@ax162>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 28 Oct 2025 11:14:35 -0700
X-Gm-Features: AWmQ_bnDLfsfNIG5--yjR8bWyBut4gyt9iExhd25ip84kUhmdr4d3xv1vPYI1-Q
Message-ID: <CABCJKudsbd6=8B+fkzbw6TkL-dVvSoT3Co=fW+jWOnuBtxsLKg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kees Cook <kees@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Russell King <linux@armlinux.org.uk>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Michal Kubiak <michal.kubiak@intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:52=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Mon, Oct 27, 2025 at 11:56:21PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 4:54=E2=80=AFPM Sami Tolvanen <samitolvanen@goo=
gle.com> wrote:
> > > Instead of working around issues with the generic pass, would it make
> > > more sense to just disable arm32 CFI with older Clang versions
> > > entirely? Linus, any thoughts?
> >
> > We have people using this with the default compilers that come with
> > Debiand and Fedora. I would say as soon as the latest release of
> > the major distributions supports this, we can drop support for older
> > compilers.
>
> Okay, I think that is reasonable enough. This is not a very large
> workaround and I do not expect these type of workarounds to be necessary
> frequently so I think it is worth keeping this working if people are
> actually using it. That means we could mandate the backend version of
> kCFI for ARM with Debian Forky in 2027.

Yeah, it's a bit unfortunate, but I agree that we shouldn't break
existing users until newer Clang is actually available in distros.

Sami

