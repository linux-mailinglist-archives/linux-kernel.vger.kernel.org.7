Return-Path: <linux-kernel+bounces-768210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D597DB25E41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA71888053
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F92E2DD8;
	Thu, 14 Aug 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0GLFzrP"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC81C9DE5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158459; cv=none; b=eq/jjN/o5bBDWMPEqU96mL+b9GEH30Uk40+i38IMoqdLkKzCot80s4WiSgcCgvGOIn5shFYLhIbeD0Lwa5rUqwLCzaI+xmFu1uXGp46ZEZRDUohGfUhFnQLOmAhQz+bh+7pdm348q9mVV3bfMER7qXx8Iy6nzi4xd5+yXv7/4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158459; c=relaxed/simple;
	bh=n70nGhvWz6Vpr8NHMWaTGqVNUV776vq89TNauT5t+Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaQTyq8VGzJMg2HifQpH9A4Ns6sHBVeX57b2k9nsbBp7yghRi0go2RxELadryYx/5a55XUCkPWsExQOisKDrpaLL2lX1XrCFxyesZx5+qRONLkbY7I6RpddRrSulnuOFVRO24WubBDcK3Add0ii2a0teIWE4HHkUqbZyQ9Hxp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0GLFzrP; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cceb749d7so268850fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755158456; x=1755763256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n70nGhvWz6Vpr8NHMWaTGqVNUV776vq89TNauT5t+Vs=;
        b=r0GLFzrPJ1tjBXbsfuMBJzKMnLpqNljyUuRCQ/uOpBEj7r6rNbmoOkfHftEhptjKuI
         7346nTARQVFGHY4F26yR+45r+uAgrFUvZLtz290Rn0uFpSOH9RMr2i3uFcZVq6tzXt6k
         77g6OI5IM8H+XopxX+SGfSuVUWWLIgfJY255CaL2Ld2jQ2bpoSYU+UScddovi/3hTgqT
         NBWbu5eR6orKJ/JQE02//ipgdKURyGljLlAGhvaBtEd+QfwNgvClK0ga6+jyIvziLh5N
         SpBaP/kTEAEvzIAMbqbQZmOK2X/zS6ua0QCYk6ape4amdsSg096dq9gCO3IYmInHsxel
         0XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158456; x=1755763256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n70nGhvWz6Vpr8NHMWaTGqVNUV776vq89TNauT5t+Vs=;
        b=WxAO6uL+FO7lSxk5KOwIhDTG++wl7lRfQNnytm3yqxlTCSurfAZorRkRLDZKy2FDmU
         I+LfsApc2xnKye+GG9Do1BvLCwgCOZlxL4qUpef8xdJ8mk3fBMzQNOyrZzz2lLdAV6KF
         5aDtImyVboyCZmC+2BXCEFSALMGCn2EpFtKDZtO62JkAs2JhfG8aSXeQwtlfos0ra0uN
         S2dRqvGAlCgMwe0ctK8ErXmXvPqc48huD/uhcaRV2OODvUeuCZmzPoS9CeQlWWbOS66v
         evACrQ1ONEMcLsl5xFAMQszsMVTXMBCTGqLU9I3wq/8cLeAm3IiAQiZ2jIJLDhjYxR2y
         Q32Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMfpjvPwuj42B1GmOr+5ycBNYomQulXYzEWWCivPVpvfkrbv7UBG14PrjsqangMH7dJqYz5CZ9iveywj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5DqqjwmYvS8TKJlnWbaDs7XhkoDgE+4aeVwsXaZEn9nehbBw
	sHn9AlIGnJC5xE7JUVcldyS+I2km23gmnY59t/QxB717MWfIYZ/DWkeQOjEYK5IFt1DXyZIv2bt
	UE25cgja8bqXaID83nKzsHTQ7YKDAlz4y3De2WJqp7A==
X-Gm-Gg: ASbGncvHrg0TGRASmVI8QvNZLlR5s4aolCWNWOOtuMORjUrUloWbvJrHRJeXj1TKonz
	5JTfxkSwf42lLyzjo2daUz9oTtYpv0Z6G7lIJHpjyhtY8W5hYchDS+VBwnVWhyRHMM41+34SdH4
	WXFUjCYR6nJtVa84My1eKcSZ/rFFepfJ5/ypVm3c23pToJr2j/j4iM8LwnS78VRytvfUSuYCosl
	1Kyy/L3
X-Google-Smtp-Source: AGHT+IGTBMwMw+gzWgxP9b5nguwG0dbCgs193lvPsSCGkN0VzG4a8mD8pVivm8MI/iAjnF7DolsTQBv4YPj5EujlUoM=
X-Received: by 2002:a05:6870:b491:b0:2ff:a4c2:b52c with SMTP id
 586e51a60fabf-30cd1390b93mr1399807fac.34.1755158456494; Thu, 14 Aug 2025
 01:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJmChHa_BxNO74cB@sumit-X1> <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJnJY5hV-Pul8QzN@sumit-X1> <SJ2PR12MB8689CB7106ECD0EDB2534208B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB8689CB7106ECD0EDB2534208B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 14 Aug 2025 10:00:45 +0200
X-Gm-Features: Ac12FXxqNjdN08EUBkW_hi248QaNUjOt1HWt7kCngST3BNpBgYKS5WS7Ah6vKqE
Message-ID: <CAHUa44E97D4res6VX84XCSStsisPp0E3B4v8xJQoohKijkzf4A@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"
To: Sungbae Yoo <sungbaey@nvidia.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:31=E2=80=AFPM Sungbae Yoo <sungbaey@nvidia.com> w=
rote:
>
> Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()
> because compatbile is a typo of compatible.
>
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>

Looks good. I'm picking up this.

Thanks,
Jens

