Return-Path: <linux-kernel+bounces-805775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D432B48D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D0D17177E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609732F8BF5;
	Mon,  8 Sep 2025 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRj0wY5v"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5BC2FA0C7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333929; cv=none; b=RXlxDzPOzRaPb3Lf5iv0+PJgEf2GQUyxTMHxBP037IFaZfxPN+qYT4RRzrE+MdmtDaV41yuvgHOxErLaozjMSgH6a6Zuh/f1UQHnMnMYOTEg8cMNmM4IxKdgfHsice6ky/B4QeQVotNPqWQJByFnAyhMerG5UvJ3xByCvZQQ8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333929; c=relaxed/simple;
	bh=D03VLSx8qWcHMylhQkNfYVr1yuDfARwAcjhSzmKUp4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC9NT9lFRj6WzEX451P/2WIZ182RnXxfT7ukOJP94lfgGrA7ko+TkGe/7VGW/7uE0dcwez/ilxuybx+4InUvpcGOylnHwNrLliPJ/2HFDW77YKAvRxlwYxVGBS3Al3r8oOOB0UJAutANT1BicydxfpL3FBNvkzPOiXGRy0Fqb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bRj0wY5v; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336b88c5362so39148651fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757333926; x=1757938726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D03VLSx8qWcHMylhQkNfYVr1yuDfARwAcjhSzmKUp4o=;
        b=bRj0wY5vx42hNu/oUuC5Cm/9lcsT9/hRuPE9Oje20Z1pFGQkuaDKH+5HV2HRwmiw7T
         d4Mg6aqxBZv12/y0DQgz1/VdVODPH0Y6aRqiBtYtTIRswO+4rV88Ur4BY4B0G8j90i8Z
         U9omj4Unq5PQEoqFPMkDEfm/V5lqIV5e40nVgUeMPOkCAYF8/q3AwtIJ82pFlsojBeoO
         mgQ3f8sQifmQBTVHT+InmiABGE3jSjHwqASAei1EJdgXqpJ91hctA2wqUncnVTLPfAZb
         c2Dio9MRHOq3Kans/ajYODY0Uqg1zhjeRQa44EGSPFSv1bnPqhCzrilYn+WhYW/yop0J
         ++xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333926; x=1757938726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D03VLSx8qWcHMylhQkNfYVr1yuDfARwAcjhSzmKUp4o=;
        b=rfKBcFMIEe1N2Qm8mMvLcfPA43NRkCKMilSEq9+bR5aMcyqu5tzWofhQoSZPJNqI8b
         j1k19mvgLU8S5ov6EmEJgRfx/Dhd8Cgnyns1HQqIU6RC4572DH92xfhKX9MjYBkafrXv
         PVbQ97hL3G6efE3rLp1nPD9MF/vpJlrKfERQQ7extFmwKINBB4Ul2yuAlhLBw5c7jfPV
         VKNLJ1Ndn6veFfojBBfysHo5hGwi1Kwebo5eNZaCpv+vGWBc5NkDHJwmYInzeiAYZjK4
         1orHNZRxB3Qw3UyfR2pC5r02+jamVUqcmjMDSWmtCKZiQU0Y9Lvax8ik1Qot0sNcHMaH
         4Tgg==
X-Forwarded-Encrypted: i=1; AJvYcCXRsEHJ5QY+SXDXzVXlJ1CXeXtQ7JpmPiTWGkY3YCLtgYCFzsxZZgiSAt+OrvtgHESLn4yKOBQNkoinZwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw84FqFO5hCmIa0PWBWcJ0aZ1Z0jd1yvnzTus6JuEVwMGZ6Ms6w
	/6JIehl1oN7J5Bt23TbALiGx2wz42jvUQokKWUrbFuaRhVfwuEG1TKuzCLUTU11mB6TT8lMdXb5
	ELCZisdBTrQWghnjR6WGyGApM8ya4rC7Km/Lacl177Q==
X-Gm-Gg: ASbGncs31gt872yHgrT2IDUv7QJ2P9juzOdk9WxvJgLUONsA4Wk/bGz59zeiyfuF9VQ
	e1jzh+Vf9nk6gi+cym3p6/Dxj7LHQQqZ/gbJ25ltOREcScIkEAa+rp0TQb3tJgGQd/NGBcXrTCf
	oHiN+qAs1OF96bn3SDWe4RlCGN4OfJ+EjWQNS4vmqZ4Q5lK5h6rHUhYaSUBzG6CudFJixkCcb54
	o7rqht6JWhNIgAKOQ==
X-Google-Smtp-Source: AGHT+IHM/asPiTx9epOD6oTfJGUKN67uaWlwZQ78ImQd67LcYMxVaHUE3T7Mz8CkVcX10agc5tRhs6MCp4IvPGbhEmU=
X-Received: by 2002:a05:651c:20ce:10b0:336:80e3:b1aa with SMTP id
 38308e7fff4ca-33b57396e4emr16467561fa.40.1757333926321; Mon, 08 Sep 2025
 05:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-sdm660-lpass-lpi-v5-0-fe171098b6a1@mainlining.org>
In-Reply-To: <20250903-sdm660-lpass-lpi-v5-0-fe171098b6a1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Sep 2025 14:18:35 +0200
X-Gm-Features: Ac12FXw45K3T8l4lkY0i6QN88olXVHwaoVRfqMYPmh8yFo1l5iil-Ht1oK5lLbQ
Message-ID: <CACRpkdY2o7PB-1t5kwGFpWjDu4QfKG_gf0_pGA=V1=_KFCqqiA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add SDM660 LPASS LPI TLMM
To: Nickolay Goppen <setotau@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	linux@mainlining.org, Nickolay Goppen <setotau@yandex.ru>, 
	Richard Acayan <mailingradian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 3:43=E2=80=AFPM Nickolay Goppen <setotau@mainlining.=
org> wrote:

> This patch series adds SDM660 LPASS LPI TLMM pinctrl driver and
> introduces pin_offset field for LPI pinctrl drivers to support
> SDM660's quirky pin_offsets taken from an array with
> predefined offsets from downstream [1].
>
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/LA.UM.7.2.c27=
-07400-sdm660.0/drivers/pinctrl/qcom/pinctrl-lpi.c#L107
>
> Signed-off-by: Nickolay Goppen <setotau@yandex.ru>

This seems ready for merge if you fix the last few comments
and collect the ACKs/Reviewed-by, can you send a v6
addressing this?

Yours,
Linus Walleij

