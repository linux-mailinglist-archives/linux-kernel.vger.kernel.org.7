Return-Path: <linux-kernel+bounces-844765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A15BC2B52
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0250E4E36E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3623D298;
	Tue,  7 Oct 2025 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlGUFpSs"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96523C50C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870412; cv=none; b=nF5aRdNmuQP7W6TshfFwHJhROtHZtHXSeUGAxmc0K5o83gsi8MsRXJEFG5QZJKYApc3T0sgSYPZWMgrRMrGGBNAnwAXFAGUJoxn1bLIHk3fmu4Re9T/Ddv8yFYKg5+c7F+FEmj65/3VZjAQlPzCYrStyUKeEZ/szENIzD7jJaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870412; c=relaxed/simple;
	bh=/hCZP75SmDHrCZY5PWLz8NOVMBMSMd1PrqQADWHi6tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsBfaYYYF0I7+9I7XtFOqTlBea3sV3sRW7eymEicjJWdnLF4hWaW/t4jZBe5uHTJYYlBRAIjTMAaP4Fyplu+uXTFD0yyt3R5HFocD++1i1Vl1HGiqdIq8CMEyIloA55NcKJiNUrxNlWsDaDuFJWoLhh4Kpq+wda9S/iVOTbQBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlGUFpSs; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-79d36a6298dso2620191a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759870409; x=1760475209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hCZP75SmDHrCZY5PWLz8NOVMBMSMd1PrqQADWHi6tM=;
        b=SlGUFpSspz44Aw5wUKlHa342PN49vvlrUAMNLdS7xKJR2gulKpDZtYd70s33EVMqUB
         d2k3McBx8l0aDVxdmSsZYHq7L/xqAPwE8CZjoHAllk/QjDD5JiHdDeNEhI8oiAVpOzhi
         8hZrwkurrQLZdIa7JXTR0wxcwFACOC66xYgoSX0HRda5WnPfsxGs6DNKq4NQvnrnZaIc
         sk80RjesUNWg6H2sQwMcC4WbFP9/AY9uqfQaUHVxfhKflrpPxDr5eUfyBk4tdFa036G5
         E+ttBI2bX6sr1uowZuA8z/ToSCxC7e/00glVZRQ5OT3Tvbddfh11h7E/BXYBOJsBAzPl
         /F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759870409; x=1760475209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hCZP75SmDHrCZY5PWLz8NOVMBMSMd1PrqQADWHi6tM=;
        b=HeAjXbbnbBgPT5Ki+pGzHcGY2GRh2RTkOvJIG1oL6Df4HAx7zXkQPdyYE8o5vXmSmt
         qhme+8Cwv+4ESzC0Lh3YVUMwjIry6QbRQD1uInDLBu0ZQxgKvjN0SXt2Tt/xF3TlAp6e
         xo3YBS9QdMl5o+pChZ28efzqwdra4CAF6IB7xRcEfBli6ZkLq042ZgQ36jTzPGLiCefd
         uAF2Ad/0r+3vXCed6Op09yyT/yiKu53mUC41QWhWKGUd4kVAAkLN7EJn8r6VChOmMg46
         kAxd7x9wlpjRartDUmEQNpO/srp7uUq5t1m9+e72B7iLAdoN6awS78ZnV0TMefdqzpfY
         5DxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8mwShfOZ5RpHExIFIIKwhWpZp8IAnTBpLAXCi+3N7irL16Dg1CMLCzkwx15Cvcmqg5xeCNv6nS1Iuqnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWWqm6BnMs9SYVWaLmFwP5Uya7nk/KNDBdRzF5L5SvFloF2w3
	fG5dtfm/ouWjwUSURB9JG7UhB60MTTyWhINwwn3iwJKh1jjkzkKnfc0GvN8gTuFNmJCjrw6zOdu
	persBgGsonsXNRDRrmfL3pa9k/JIot4ndVXsu9cIQnQ==
X-Gm-Gg: ASbGnctcggYF+MyNpcfi5fdgzW0I4GQCeI+IELX4swN6mt1PzLTig9fVyhAFaKhMEZZ
	sLGI2AyJRX3Yw+xfYq1SxC8mzQPPNL6Rzx/0SLplU1Z8V7jcp2KvLjsjdMwdrZ4JT8s30Rr3vU5
	MbnS0s5ghOscUz9RPcqcoR1WbK/fYxa1MRvPBi7069XQlWup3GcSTY1pkSpX95dPOriKYnKZcnR
	t/L/B4sgHDtTg1TXktTQ0qhuOtNNYelxY//9Q==
X-Google-Smtp-Source: AGHT+IFQJZVs4LBnBVbWSGDsdN3906KKw4UjF5sMiH1fvSeD9gn0otajPAH5kYHA1+VAEseWAd1TdVpRyCmSlYYSQ1w=
X-Received: by 2002:a05:6808:1988:b0:43f:57cb:7f83 with SMTP id
 5614622812f47-4417b3e3209mr436998b6e.46.1759870409126; Tue, 07 Oct 2025
 13:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org> <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-3-f0cb0c01ea7b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:53:17 +0100
X-Gm-Features: AS18NWAUUQxOHKEKFHDJ43bMyMuc1k66q_SOXE8Wv3pAaENJrBaMTokvZjBYJtQ
Message-ID: <CADrjBPoharrk2BwLuFaAicErLxZXre+gSSqwws6Q07E4C9f8nA@mail.gmail.com>
Subject: Re: [PATCH 03/10] pmdomain: samsung: use to devm_kstrdup_const() to
 simplify error handling
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 17:43, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Convert to using devm_kstrdup_const() so as to simplify cleanup during
> error handling.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

