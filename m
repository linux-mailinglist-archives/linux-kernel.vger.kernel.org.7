Return-Path: <linux-kernel+bounces-740027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C584B0CED0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBE6C614C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09635548EE;
	Tue, 22 Jul 2025 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="aMZNjbU6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AF2E36E8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145030; cv=none; b=ZURtl9dESeB4KIEMMqhDxZTF+qIInQunPeJu+Jrkf3SdGy33rND2MF0DpkEv2ZO+pn48k9dNwRuwQGTdk/NB3JzADWoTTqYTIIs5PDp9Ayy16TfWnyICfcNSCTva2gMHlUte2N+fug+ZqLBwiRZS84+u66jQq67TuRQ6O522gZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145030; c=relaxed/simple;
	bh=JeKxGwRxw8G0SEH/FXh9RSoQLmI9d281N19UPNitG/c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kcOHxTAuWK0ceBb8Ju5qIynhSINuTf9eL2VHjo5Gc06XgrMd6m3kLAmDmlGDx82PeYtlV4sAcwiYavLFRIQLKLvduTWmgN0anh6mCk/Iirhbg5v1SIoywY5M8dtmXhx4A4giM7aUxrm06zI/EtRv8YLCg3L1e1dlAUnh7DmUD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=aMZNjbU6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234bfe37cccso38012855ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753145028; x=1753749828; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWKESiOhzPub7HbCpVfb6VDAUw8MhO0B1PWXFEOdxNM=;
        b=aMZNjbU6LoQV81DNl0GY6tAoV0ya67Uc2UaVKtyBEIzHfvH8XqjzdWSlrY71RL8MqT
         1VTljEO11ojAuU5+sxCPH0GzQO7bfgcIpZU5gPEvBXhsVjgI99KCJT0q2Jep7lLyBmiA
         D88mPjQUnk03hwLNn44Y/1fA7QKBxJYvWD8WMfzpGN6dv5vt+ZBohforA87hNCb0mvn3
         KjvOa9lqwkg9Z80341MmpaC58ANhT/LBH7F5ZbpHoQJah0adTpEcMjXNgX0/8rkS7Ewh
         bPW5SkANhRevXqbWKKwtlzZQUPTN7GI5KfESFuRFZ1k7TfZWdvf//ykS8gow7BhtV9YX
         z/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753145028; x=1753749828;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tWKESiOhzPub7HbCpVfb6VDAUw8MhO0B1PWXFEOdxNM=;
        b=MswKsvNVfzNiaHls5RC79Bf/tNXWSK1hOS9gbG3219RDcjRb52ixl18fmiAPF0gLL4
         H96DyDzM1uJCg6ruENJtZMasOqtGFCqSbe+YpzYbI2FL1jJ1udJZJajYvisr6lUYZb5S
         ggDT6Pvrih6Zle89V/XeegQI8r7yrZ74JF70CNFdTGdHv30nI4tOWfuleH+Irr+tLIUS
         nJWoSt8l4ti+ALwMR9UhcjpVMO8e9Xg7BI9NX01+HqFahxHBNZ4ZwI8gPYnaVeZKn7YM
         2tTY4tISS++Ljb0YBK8kTHkkFstPl7BHrmrqUnRz/pvpFgr0Jyrb38l8fX+N7Pga/EaF
         PwMg==
X-Forwarded-Encrypted: i=1; AJvYcCW4KaPa3jQSwnBhd+kfRXa1UHz8KkD72+QepD85C1CeZFiLtuQJhW99tPABf9J38ixu7MxMMXmCh57LSqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzREt9EP5EgQVFUanU8Ya5wqVqrTp8gPRnjMgHsHEOi0hCHD0iS
	4Vxl+SCUj8UyFdsvJDd7+fBTy37wKLN6SElds4sx+yeToe+c4FMJ1Jlp6ybq6uf83G0=
X-Gm-Gg: ASbGncs9WEZyaPw3x2rQANbvekcIo//tQ3eg5c3pSokCvTNb0OwcnnTK4S++1SYFatL
	DhXMypWl2TVBzKDMOQB/B1ePUNhTokPiVxlPRAZS4QmRvZTAhm1O33ZatS7irB2yx6cElbXU2s9
	3ER1t26AYAdO+dtwivai2rjf+lUwZ37nX0xGb5bl29IXIghlrSXoW8FVnuooHB/V5KHUMlPIpKA
	Uq7bJz8jo5x4uZ6eBS0xgj+ge+6XPVxMwbm1pHDy4wLDIDaTyFR6WDOZ+l2uR4Yw9ybGs4EU12z
	o7Yq9dRI3R5rBPV5KwnrK2ux58XVtUfPP8vMVhTxsdsZ1sSaGjB2kDZ9bHzC18DvBp8G7ToNip2
	6FDCLh9f2YEZovCZ2ODI=
X-Google-Smtp-Source: AGHT+IH5Ggw8HxNgNkIhkji1CsHIN+X1UuZlwLFphz3TWfdvpPzaUl2/O/py3sSxVD4cx62zQnYvpA==
X-Received: by 2002:a17:903:138a:b0:235:ef79:2997 with SMTP id d9443c01a7336-23e3b88343bmr193293005ad.47.1753145028092;
        Mon, 21 Jul 2025 17:43:48 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d85d2sm64086765ad.168.2025.07.21.17.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 17:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 18:43:45 -0600
Message-Id: <DBI61MARVMJA.1DDSNK4TZE5TG@brighamcampbell.com>
Cc: <tejasvipin76@gmail.com>, <diogo.ivo@tecnico.ulisboa.pt>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH v5 1/4] drm: Create mipi_dsi_dual* macros
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250719082639.307545-1-me@brighamcampbell.com>
 <20250719082639.307545-2-me@brighamcampbell.com>
 <CAD=FV=Xzno3ReSyp9w+DC+nLoy1AXmcwd+j1=_XRxFi_k+bmng@mail.gmail.com>
In-Reply-To: <CAD=FV=Xzno3ReSyp9w+DC+nLoy1AXmcwd+j1=_XRxFi_k+bmng@mail.gmail.com>

On Mon Jul 21, 2025 at 10:30 AM MDT, Doug Anderson wrote:
>> +void mpi_dsi_dual_generic_write_multi(struct mipi_dsi_device *dsi1,
>
> BUG: above should be "mipi", not "mpi"
>
>> +                                     struct mipi_dsi_device *dsi2,
>> +                                     struct mipi_dsi_multi_context *ctx=
,
>> +                                     const void *payload, size_t size)
>> +{
>> +       ctx->dsi =3D dsi1;
>> +       mipi_dsi_generic_write_multi(ctx, data, len);
>
> BUG: "data" and "len" are not valid local variables...
>
>> + * mipi_dsi_dual - send the same MIPI DSI command to two interfaces
>
> It could be worth also pointing people to
> mipi_dsi_dual_generic_write_seq_multi() and
> mipi_dsi_dual_dcs_write_seq_multi() below?
>
>> + * @_func: MIPI DSI function or macro to pass context and arguments int=
o
>
> nit: remove "or macro".
>
>> +               struct mipi_dsi_multi_context *_ctxcpy =3D (_ctx); \
>> +               (_ctxcpy)->dsi =3D (_dsi1);                        \
>
> nit: now that "_ctxcpy" is a local variable you no longer need the
> extra parenthesis around it.
>
>> +               mipi_dsi_dual_generic_write_multi(_dsi1, _dsi2, _ctx, d,=
        \
>> +                                                        ARRAY_SIZE(d));=
        \
>
> nit: the indentation of ARRAY_SIZE() is slightly off.
>
>> +#define mipi_dsi_dual_dcs_write_seq_multi(_dsi1, _dsi2, _ctx, _cmd, _se=
q)   \
>
> BUG: doesn't "_seq" need to be "_seq..." ?
>
> BUG: You need to remove the definition of this macro from
> `panel-novatek-nt36523.c` or else it won't compile anymore since the
> name of your macro is the exact same as theirs and they include this
> header file. It would be OK w/ me if you squashed that into the same
> patch since otherwise rejiggering things would just be churn...

Sorry to have sent out such a poor quality patch, Doug! I always compile
changed files and test my changes when I can, but I think I must have
compiled just the lpm102a188a panel C source file itself by mistake when
I sent out this series revision. From now on, I'll simply enable the
relevant kernel config options and rebuild the entire kernel.

I'll address each of these items in v6.

> I guess we also chose different argument orders than they did (that's
> probably my fault, sorry!). They had the "ctx" still first and this
> patch consistently has "dsi1" and "dsi2" first. I don't think it
> really matters, but we should be consistent which means either
> adjusting your patch or theirs. It's probably worth confirming that
> the novatek driver at least compiles before you submit v6.

No, this was my fault. You had suggested the correct order. When I
implemented the change, I preferred to put `ctx` after `dsi1` and `dsi2`
because that's what I had done when I implemented the mipi_dsi_dual
macro. I'll swap up the order, remove the function definition from the
novatek driver, and compile both lpm102a188a and the novatek driver
before sending out v6.

By the way, we can discuss this further when I've sent out v6, but the
novatek driver appears to pass a mipi_dsi_context struct into the
write_seq_multi macro directly instead of a mipi_dsi_context struct
pointer. We opted to use a pointer in this patch series so that it can
be passed to a function in order to reduce the compiled size of drivers.
For now, I'll plan to solve this by changing calls to write_seq_multi in
the novatek driver to pass a pointer. I hope that the churn that this
will cause in the novatek driver isn't unacceptable.

Thanks for your patience,
Brigham

