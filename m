Return-Path: <linux-kernel+bounces-797400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA1CB40FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9EF1A82FC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E10277CBD;
	Tue,  2 Sep 2025 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ew59oYmv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D789D275AFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851775; cv=none; b=bQrSQEzNfZzDu4s7l6/jnC4kUaWcO9Q68XBM8N6etIyfo7LSI3zGwlwqTSmupl8OTOAePHp4i52lNPCPl0apFbjrBXdwNF2NdbKb67fMDqvBJwDDOlpb71uh8n+WcFP6+Tl4MH9QnQbItnId+7SWNOginvY/r8F5rNKH9YSrjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851775; c=relaxed/simple;
	bh=c5ZAWb2I5q99uD6aQ+b8A4cpEjo1rdI5DVDKG4LuqrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw5NjUN+KoRcygF5yYj1aNLEqY+6ehxnZIaMvy42wYKsmO7qpE264Fmb5BE3dxfDLvhRDws81ZtCsRSSkXKZl28/kSLo1BJkUT6prLEENo78x52CR68vBfS7Q8L80Vmqd7E8Bi55kQ6SaLYs6bEPvmYPcMwRSJrKc0HyqA3ud5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ew59oYmv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f6abcd26bso439738e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756851772; x=1757456572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5ZAWb2I5q99uD6aQ+b8A4cpEjo1rdI5DVDKG4LuqrA=;
        b=Ew59oYmvI2PWBHlr9KQZ36tIKwxIqKzy8soRQdUFxNFmWYcLMEInLJmm3Q3N6kq7Xo
         FhIcj5X2fk7fMxTmnVq1Y0UOmIscUpGcTlwiBrrJSHqrIccOufcvQp/R2DkVzE9WmdvY
         AcpROhifRJvpu9arXJ0kZFoUx5q2DhtYin0vm/mzGl1qcZg4+LDq9rQyA27O1/wus2V2
         ogkm/OEkSLcIscBSwvsT0c9UcqrYXX7tT+X1u9Gk6Iq2xKSz3PBYziZMtTjuxRyPUDKl
         rkrMo2xce83HsQB4HHAglHQop1ssKhlj8pxTz9jJm3DMTbwh9oZJaS9xmzt9mXp6gAbt
         1Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851772; x=1757456572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5ZAWb2I5q99uD6aQ+b8A4cpEjo1rdI5DVDKG4LuqrA=;
        b=Kl6KuXxbQ/dPVsf6gqlGpESRlGs6DWC3RdlexiM+fIFYvyJ5Md8DBj4pq/veOjUgjD
         yTT5hozCwEGTg1MM1ELB56Hm6vOQLgTLSZG1hj0NllqQRlIMHI1NCqQCcul+wrLb1YiI
         f8aD/2Q1UAgbh6q1K3AU1ENL8gOXCPVb/74UtGbedrql4+V5lEIqWVEQQa2EjbFGYSWc
         MWDHf806qyzb+K90EmikKwoAGj0D/1NwOQT16oseH9EUztXKBOGARbL7COz/dnP4lSaG
         VjIqYKAvbAw6nuawgwyKYt0y8CiHx32YYIzKCTjCxwfdqoMrDOHjgojSQPDdILb/+6Q5
         rV5A==
X-Forwarded-Encrypted: i=1; AJvYcCX3fcM1yyF8Uwclg5iNo9dIAnWuA/KIFoaU0/gLsEJfrlmRSnutfZvB4+dZRNfdeSl+Rbe4DtWayv+MsN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY40vrMif7nGSYuJhBtyWgoWPDdyNU0lKeEhc4x6F+zaGcQCCi
	uJSDcqvpWioYAx7raDOCs18OK/S+bV6qL5jZ0wAKHWLXRsRMiI33ZgRvWK2hS6wiP87S1Uf00iL
	/IwtK9WpTETfnyGJwwygFmC6Z921tZtVpEVPm17GEiw==
X-Gm-Gg: ASbGnct19zj9SNNkvqPAh/JzEDekjgk/xK+IoFFRN5y4Fd16NhNtU1CQiR9brXLGjBz
	hMEZIbx5dzHE6mUgBPPJRwTu38CiMRRpAcma8qtylTGLSiKj/ucQmEAduxImMfKdEeVagTEEBgm
	2ZKRsJ5Hkpz51XmNPe/EfNnJn643kClW8HH6bMROSr1HZYgOA9WgI1sP1nyx4+iCPoa6EZbYi2K
	PQQ/dI=
X-Google-Smtp-Source: AGHT+IFQRGeGkqSRHlpbbwEEe+BktSC7N09qc9dXiOntfH/vXYvWup1CnGQRGCfnRYYYVhfmTuJ9U+CboIOl/bTErjA=
X-Received: by 2002:a05:6512:2443:b0:55f:5621:3db4 with SMTP id
 2adb3069b0e04-55f70567e41mr3922521e87.0.1756851771955; Tue, 02 Sep 2025
 15:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-leds-v1-0-4a31e125276b@vinarskis.com> <010201990a1f6559-9e836a40-f534-4535-bd59-5e967d80559a-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201990a1f6559-9e836a40-f534-4535-bd59-5e967d80559a-000000@eu-west-1.amazonses.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Sep 2025 00:22:40 +0200
X-Gm-Features: Ac12FXyRf_pKEWPlPHi9SeHKYYB-Zq6KNU81FKSVa0b4KkGrn0kE1luoxtWISEo
Message-ID: <CACRpkdanKRPHOzpUV5muwCkNraRDZgoGJnEJ+_=udrtBrqVxwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] leds: led-class: Add devicetree support to led_get()
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:10=E2=80=AFPM Aleksandrs Vinarskis <alex@vinarskis=
.com> wrote:

> From: Hans de Goede <hansg@kernel.org>
>
> Turn of_led_get() into a more generic __of_led_get() helper function,
> which can lookup LEDs in devicetree by either name or index.

I don't really like __inner_function() as naming since it
is easily confused with __COMPILER_FLAGS__ and also
with __non_atomic_bitset().

I would name it of_led_get_inner() simply.

Admitted it's nitpicky, feel free to ignore this remark, my
reviewed-by holds.

Yours,
Linus Walleij

