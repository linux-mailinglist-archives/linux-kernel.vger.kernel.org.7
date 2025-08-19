Return-Path: <linux-kernel+bounces-775395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B168BB2BEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E455F1892722
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653DF32255E;
	Tue, 19 Aug 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6vMpkKo"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7731A3167
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598496; cv=none; b=nJL8A4FHKx+/15YC9XAix4pn5OKPVREmlkPDDntlCNtpgtTnTXZ26BuMSeJuu7aXBo7XwsYoUQdp3hAeJHLtIaGlQJG7Hwvsk6bsL2BtUP1wrpfnlshjuVXHlq8I4Gv+cwkv54CCovT2BBXmrHOATIF5U3IKj2IZwI99LODz3is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598496; c=relaxed/simple;
	bh=xs95ecbsHBS98kdZmQYC1sEgD29qwsaCQXTwkKAmBZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5N+FLWHazD0ivZ3bg/weungjPiT1H39jlsbVW/wOmtX0AhQCjH9Knqu4HB64JUrP//YVyQKYWge8va8N4N06rUedY+o/zvEWDzR3GchheCvU5DDLDMtBUBMbuKy2RopdBk3xemBdE0Sq99NdTO1TppxJZ9dsyXz/fsU2dqEszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e6vMpkKo; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f8f0dd71so39674561fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755598493; x=1756203293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs95ecbsHBS98kdZmQYC1sEgD29qwsaCQXTwkKAmBZ0=;
        b=e6vMpkKoNoVB00do+Kh/e1XkOGESIfpZsHBBRBqpNWr5NCa73X0HlB004zfYBBVFcB
         HytRO2aVmRhgEhAAS9vn5Z461VW0kDdPjt0emQc54tZTb87CQorgGA6oTCYt+HLZntyt
         oZuXPAx2a6i/tmUmdmKehXRwHdZiKB8OwyrK4Pm9tA7kgDTHiKRJnuXP1HDIK2fhC1/+
         AoZLWgmBCn5pfpCxsdkCqQHq5MXsubAraXhlmo6/Q3Cr10s8Hks/nY4FpHWbaVxGAOJi
         hDBywKZGL2BPHUk3t7kJfwee2cDLnL/gYXabUTRk8QnKzbbTdgRo432fo5gbCSapiBH+
         uCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598493; x=1756203293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xs95ecbsHBS98kdZmQYC1sEgD29qwsaCQXTwkKAmBZ0=;
        b=FdJo6zCNb78qBRgVMxLdWGD77ADzjswH3ieb99IzbZ3risDF+U8hkYW/3DnPmpDgfe
         AZS7zGkW1xPhGwbmHJl27n3V5S+db0LxQh+66BzeoE7u9CUcXBmIIg8VmSrSP7cqbW3n
         pmEpbkgVD+T+HFAj+PWeD6h0RyHPjonzZIOnhep4TyMlbpaAg/g5fg4MD3btlHugETH4
         IdLcFSeFMYDLeT3Tt2lLVP8rqT8cnfgfjdzrv5G941Ac8bcr2bmREFl+D0+w3A3bnsQH
         vvBNrc+hPPwmGraWr/pVs4RbIrOeolezTP7gz5/gzNQ4sZVZvFmHtUcRMMB8+iQQLQ8E
         hQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0YjQMtlG/eI8v+fDQXxevH4h1UDs6S+NJGJ83Sx7zicWXe09a35acIh00Cs79qIOdIN8wSHroltdvSBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0o0o9R3e6i9fGlxH2fNzg1En8Q6Cbmo684x18hwmNS3biBflB
	N123h9NDRXCTMN+GDWBGut0JwU3EwJpI4s2Gq+1gYNnErdnmrs/XVSijKwbF3xIhVEzu7LLL+IV
	VUCyQ0P3n4Ruj2Ty2B7OkExEuZBThySp9UKuTsv5Jcg==
X-Gm-Gg: ASbGnctcSnhQuiGE7W1C06mFfkfS1Mv3gG+3HuoBSjBLkuOBcm8gAJKsSAue892iPvD
	FBGYsqyXrDuP6G9dDfPQDrnRx+XgarVgAYyGvWLVzXahNQBKY58hUvt9CjFtsoi3GR8PzxgM8WJ
	z+HaGNYlNA6tz1xfN2s5hCgBhE9CVfqtPCxrnrQonyKSAgtFkxoiEILfoVLEGYE8GoOPrNvnBky
	ebyUwUVO38IIHYC8HoFcIg=
X-Google-Smtp-Source: AGHT+IFkQ/sC/s/4QAwlclM8xp2og6ZgeUxncw+E1xAHzjFAZWocrPGqkqt0tLwC0mxFcX7fM4H4zSIhQVpHMi/3Qc8=
X-Received: by 2002:a2e:a587:0:b0:333:b656:a685 with SMTP id
 38308e7fff4ca-33530534824mr7201021fa.1.1755598493156; Tue, 19 Aug 2025
 03:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812081243.22659-1-zhao.xichao@vivo.com>
In-Reply-To: <20250812081243.22659-1-zhao.xichao@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 12:14:42 +0200
X-Gm-Features: Ac12FXzU4f68lx-vnPMu0MlwjuQwlOsOhgF-cfcAJ8aW8LkUUYsFjc86GjLFFFg
Message-ID: <CACRpkdYjsS1q1mF=SYA1J7YFGnmd6+m8aj=YBPFWthxVoJSnwg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm: use PTR_ERR_OR_ZERO() to simplify code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:12=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com>=
 wrote:

> Use the standard error pointer macro to shorten the code and simplify.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Patch applied!

Yours,
Linus Walleij

