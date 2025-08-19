Return-Path: <linux-kernel+bounces-774722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE7FB2B671
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2CC7B0DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB73285419;
	Tue, 19 Aug 2025 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IokYRN4M"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D9285077
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568002; cv=none; b=JYjozWJtNN0gtB7ClBYEcVKckdVBy8PoNECY1ra7a0eoX2s538SNZS5lxobAbmSOYeN/UoZ4RqKZ/sgDpXNJVbN/ill5yfP8IypYGKysgVI3a3PewwwUcgTnrY+34yRHFaS01gp8Q8gyzyCzB1QmcwqXFCRp9uXDOdCb+Hu7phw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568002; c=relaxed/simple;
	bh=tEGknVAKb+PN/lYStQKRG0VhNOO+rKcQSO2jl7NQgp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZeJce6/DWN8cmA1ODVHO2/xWELmYp5CWAHcyJcb05I3Fz+Ju//A1Mo2WPEhPAECf8bgDWL/qg6Hqqmc7BPil0B++tiaBVBnI44+dash3txJbiLVP0ygABvVG+O8LqG/KZHr/+8tYyg0fncOzfNvo7xoK5MP1/H331tSUO/dppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IokYRN4M; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55df3796649so4645e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567997; x=1756172797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEGknVAKb+PN/lYStQKRG0VhNOO+rKcQSO2jl7NQgp8=;
        b=IokYRN4M43p2bMRqsHErNjuCfRonPyDYs0/z/4/QCe2o/E73wCHKqUlM5yxowQJUnc
         ik5DDsyjaF1790X/dzdS1Ap4t0BgN009H2yg4YjW682QyQOskarPQ149oKa4YVHWdEzc
         FosV+35D4DOoEMINeXE1pWUaqXZxZjOabuLBRjJYU098lhpBQBHnmH8E1GPAoGcyPEAI
         CVSf5AI9V6kUlRWOcllnbS3uMt6+OyiSbrD8jIwQtiBsUzqmr2HB28ixuQc0OMSV/YBt
         FrSr8l5jDqVwAv1HJucWyy1esItrmXIAn9n9ILCtb911EJjBLoLoOOF4QNRA9tqa7MAL
         0gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567997; x=1756172797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEGknVAKb+PN/lYStQKRG0VhNOO+rKcQSO2jl7NQgp8=;
        b=cAGs3FybaT/ZQEM2cHae2ar7n1XpbORE46tsX4a1j/NaRM3yGotVD0oBgCRrVLNT5p
         azBlIREZgJdaOBLgBYEp6JdW4Ajjh47OgfA2Y1x9tmcC1CbS5Ei+dY+EvE27Ey7pfbJe
         p6GB1FFoUx3dRNY6dUnWlIcKjmhhqIo86eVwJudPaYGx5HkPwPWE6pPygSXoOcuzLvV7
         ww5EGqdJDoAyG+8fd6DBiQzzS6+7Qdpb4MT5mrYovrfvcm04N/9bX+u737TDFRLu19um
         1Oc6FVgcKNfvSaa9JzoUzV46t0DFV4Le91GsCYeOY3JKV70JA4gZO2P+qLRHnLx6R2BB
         Iw2A==
X-Forwarded-Encrypted: i=1; AJvYcCWbuCA2BdMTR2ePOgZ5CEbB20/qEn45YVHDaZolnjbwvv2fsCralR8bgRiRCMUyABUmwrpa0nB/SC/Smkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8hOSt7EtI0L1g7HyAjSmiA8Icdqx5Jtjxg0UfGgjIvI8/f2a
	JMgIfPj1ltaoFdaYMOea46vxJW5nbJo9u5w0sSYAacmsx/aRxtEDBNs2o7U9rq6swg2AfWx1P9d
	6Xh/pxgDkesoojaKoihmfB0cJg0EoDYIjeuBGFRIz
X-Gm-Gg: ASbGncvuBh6OrCePZvS4q7BF+al/B2GhJx4Eqym1ljqXrEoSJ8vPK6pAlX1nktVbMZZ
	SRXeGHir4/GF1pFNCL0TnL46jQL14EoOjoQZSDSZ1m82i+g4CgobzAOn+GjXfStZYxdozcz6XdZ
	ZLXVrdSWHn3f6GGSHrpEehAPPal2fdMoMFeN/zTp8yyIEGQ+SiyJXQ4I8NN95FRD9q/b+YHca9K
	JaL3pvDgr1o+NE=
X-Google-Smtp-Source: AGHT+IFMUp3WY4nxgsRLh9qsELNl/XFP9KJPv82ZlJwh8Of7VRvx5KMBcmdg5ew6Blf3tzjdDHHPFM335ASvYbURfxM=
X-Received: by 2002:a05:6512:e86:b0:55d:9f5:8846 with SMTP id
 2adb3069b0e04-55e008bca39mr113505e87.0.1755567997069; Mon, 18 Aug 2025
 18:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <8669b80579316a12d5b1eb652edb475db2f535e7.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <8669b80579316a12d5b1eb652edb475db2f535e7.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 18:46:24 -0700
X-Gm-Features: Ac12FXz-VQtX5NnWQl1oIQj3f2utu39W7Ga73n3qvm15FFIanSkTTYHkB_pEaFw
Message-ID: <CAHS8izMO=6oHN4w9XiL0yw7x86LF8iw-LhMA4qZe2rXOu0Cmbg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/23] net: clarify the meaning of
 netdev_config members
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> hds_thresh and hds_config are both inside struct netdev_config
> but have quite different semantics. hds_config is the user config
> with ternary semantics (on/off/unset). hds_thresh is a straight
> up value, populated by the driver at init and only modified by
> user space. We don't expect the drivers to have to pick a special
> hds_thresh value based on other configuration.
>
> The two approaches have different advantages and downsides.
> hds_thresh ("direct value") gives core easy access to current
> device settings, but there's no way to express whether the value
> comes from the user. It also requires the initialization by
> the driver.
>
> hds_config ("user config values") tells us what user wanted, but
> doesn't give us the current value in the core.
>
> Try to explain this a bit in the comments, so at we make a conscious
> choice for new values which semantics we expect.
>
> Move the init inside ethtool_ringparam_get_cfg() to reflect the semantics=
.
> Commit 216a61d33c07 ("net: ethtool: fix ethtool_ringparam_get_cfg()
> returns a hds_thresh value always as 0.") added the setting for the
> benefit of netdevsim which doesn't touch the value at all on get.
> Again, this is just to clarify the intention, shouldn't cause any
> functional change.
>

TBH I can't say that moving the init to before
dev->ethtool_ops->get_ringparam(dev, param, kparam, extack) made me
understand semantics better. If you do a respin, maybe a comment above
the kparam->hds_thresh to say what you mean would help the next reader
understand.

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [pavel: applied clarification on relationship b/w HDS thresh and config]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

