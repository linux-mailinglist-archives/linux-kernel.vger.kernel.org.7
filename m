Return-Path: <linux-kernel+bounces-780753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F349EB308FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C0DAE85D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9452D9792;
	Thu, 21 Aug 2025 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddlvl2vF"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36721E5206
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814698; cv=none; b=MDLOK1b76uq3paqOe0uoyXJXt1gxE0hN5P/OWVwGVngi03dFf0ALQCvXrwXqAPEmPSe3wrGzGwiZLvyLURhQIiZRzX3X2aYFk4KpPepPWBUDE/Qd1PTorgJAbvHVP4/lVL4+lnmeYbO5ZnI7+EDKiUBuIEr4Vl2VQ7+SfXdndFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814698; c=relaxed/simple;
	bh=hJvLmDOHRH8htVDkh8Zi3UnZ6HEw3OYx2eFdQyAdZEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1B4ZiusDU4XdIGltQKLDxGLJV9x/NACHIe6bWFy22IE6TaFGSQdIGW9Bll7MRcOPelw6CLCrD1U6kzxFYTLKGmBUnLAYOP27ssNuaM6j7cx6q6WdR2GYZ3wlOV54vOw8hlF1q5rNZcjhintMNOaAvfVRNFVP3nKpjRCF1BydVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ddlvl2vF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f8f02afaso12648731fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755814695; x=1756419495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJvLmDOHRH8htVDkh8Zi3UnZ6HEw3OYx2eFdQyAdZEU=;
        b=ddlvl2vFfSC7cPidCuNjxai5SVOm9E493/urLmHQ8fZL9CMGMmebB+BSNOqXJ0ztVz
         FBnYt4bEkbD8XHQ75DrNuzdo/kraEIRrGBDQALiRnyMBEg56U58tKwOLhS6dr8zbpxEd
         dIE4h9gTiW1mMgoWKqPGHfBl8AQ1epzvNXPRuaqN9dY3KlpFMnzcsEkwb2yyZWeAkp05
         rS2hw8GKg6qkvO6vi/zs9/Jh57ViYDhH3+yUsjnfHNGarUlGf1rPPH8eCwIhK9Nkl6gf
         2XYNfFJlqNLo8cBQH7LKc1+ylEWmuX7dPAC7hKk4xyVkMgO659B00Rrw4CPVjxaUYQBZ
         YgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814695; x=1756419495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJvLmDOHRH8htVDkh8Zi3UnZ6HEw3OYx2eFdQyAdZEU=;
        b=uXt0NMrr4CNZ8O/ZQ4x5K4A8JzZOqByh0aLS4kGOMiHvidC2hokM1Lgw857/0M+nFd
         c503+9iRCiPlJLPkydeJ2YU7DKdA2Yo/D/gV3TU9CvZcJppCU/GPMY5w+CjMkR2TkxJq
         D4rHSSj8AJfpXY0T2DGDfPYxNUWnhCyKQRozQF58rmqqNPGWZbh30ZlGLcgb7uqauOAU
         jw0Oa0e+MvgfmPQUQ9W/94SZPUYvUBcR0furog9o+2tqiEPdwRwOHzifMClZwXXFwJYW
         KThQZDbSsFKoiD3i799JET/HCu4NTZT7qklyQY5krqgsH+PLfgtDyNVyiH7ZCBGETNtn
         +iHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7wmTUXKTbSB8rECqUxgh6KYv1h5abJRzy8c5QgFb0j8nrcYp/W2iCI4JerHP0Ckg+TayMZt0g4RkSuNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvmAHxQY5O4q1TFDTzRH9qYsP9Q2i7U+ne2ZiNUmPf9JR4pGX
	xyJ5OVlEqHLpuVA/Oh2Gj0bvi9vrcFF7/AAJCYSSiMUyLVg2PfD3KfYYL3hlAgdps4seo0lk8I8
	0GG/WQGGf5dNkP1LDMb9zFqzpEjhpw5VjX62GF2Atjw==
X-Gm-Gg: ASbGncvPNGmoCgJrnwXg6Ngm8EU9s2ExSmnxDD/qUBSyBScd10LPyFvvFlY3UPSbjsT
	PcFsfDbw0D0UYzM1yEMWZW8HYs7Ix2mWjcwwja4T4aCFs1jkUl26cpsDicER7n34W7zilbhPJfZ
	ADWy0S4Zb769Rk02z8jJAciYuczYaYLqDEzPaM/rsFFeq22MmULiwbrSTepf9w5AYBOi0bHrm17
	GMjsiM=
X-Google-Smtp-Source: AGHT+IFrY2hS5SsxaMer/fv4j+sLFV7Lrat9cyli9ISfVkjiqJsId841iqyuhRGNs237tnPBVWSS/MeqLwPZ7xMQfUE=
X-Received: by 2002:a2e:be2b:0:b0:333:b1c4:4d8e with SMTP id
 38308e7fff4ca-33650f9e9c7mr1818881fa.35.1755814694915; Thu, 21 Aug 2025
 15:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821215703.869628-1-robh@kernel.org>
In-Reply-To: <20250821215703.869628-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Aug 2025 00:18:04 +0200
X-Gm-Features: Ac12FXxrs--F6z9RMfNLzTHaN2eK8D_83wEqiGwNidiDTMP6YOpUfEK7YMZn4RM
Message-ID: <CACRpkdZMJ-wY-jtonjJaNufGG3L_OhA4_CeWqfODto-TAHhEVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Fix Xicor X1205 vendor prefix
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:57=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> The vendor for the Xircom X1205 RTC is not Xircom, but Xicor which was
> acquired by Intersil.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Aw shoot. My misspelling.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

