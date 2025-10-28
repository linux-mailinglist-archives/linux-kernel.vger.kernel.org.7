Return-Path: <linux-kernel+bounces-874109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8DBC15841
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3881885C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312DB342CB4;
	Tue, 28 Oct 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fauo+yoi"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88193431E6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665702; cv=none; b=tR+LVkPl6Ymv+fkA2bApFMVQEDec1QUV3Yr7Zwilzn6VXPRG/gOR0MOIfGPYoqnKQ+mADN4je4BhNIQyvvi3R8UPA9jab6EH6A6TLbNTTMR26Uzw3BqxljUuVCU0EJhs+4ndl2/mykNCrSb5U1M5j69/7M3T6euawDrrMJ257AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665702; c=relaxed/simple;
	bh=+zf/L6+BpO5HiQmCsVmEtAAefad0gqPlx28ytnkqVYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QioKwnK3pwUtbPMcuDUch8GualuGgG84ci5w/DhJ8o2T/9Iw7pGxdvhEu7MZ+6RwxSGEYgCqTydpPJQh4pPzCAsxO43EM151JCT6MtnzBbpLa62Z+/P5pk188yCnVIdd/IueWUiGMOoUrMH9lTmLypN/uR0WxGzOp3LlCtX9iO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fauo+yoi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4270491e9easo5067401f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761665699; x=1762270499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zf/L6+BpO5HiQmCsVmEtAAefad0gqPlx28ytnkqVYY=;
        b=fauo+yoirp03eUxij6gsr0LAqqhr/HhWKvaC3FIuh8uwj8SyK7IfDi3X4a+MqQyQj6
         vsQuvXZfX6bSyFJNf607+vBKeGsgRQ2hYTKOifWoFwNmmkA9DgKFWwltOXJld95CzFl0
         sbdcmF3MVEKm7YadjCGHP2sPQQ9g27OFgU0tXedTRn81zYb4wQ3nF5s8VfxJ8I5U6MFS
         fhXinAeMvKVjHrCkqfjQcwlTKTYdWLXVy8Pak27fT0BtcHHxyfR32xJ+uyPsfwJkRZQw
         yKPYCK+DaLxieqOfk5YvWxjOE3Mou/Tdly/sgBDneytVJVl8SjR4S7KyaC1oltILMsKb
         EHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665699; x=1762270499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zf/L6+BpO5HiQmCsVmEtAAefad0gqPlx28ytnkqVYY=;
        b=jKINgkI4u+ThjVv7JruCqSaIEi8V+JiKC31GNYFW/yhoxUbqPrGk4MVHDcmF1IOb+d
         PwZVNNDuDM6gQbqX6V5zDq7t0mRXtYmjjzsu8l99Vy7n9tXFXM4hvthihsPQ+ZjD7M4A
         nGYSSq0QXGw+TjlTWEbgpKd6Nycy7F42oUX31YkKekw536johk3W+e7/QYu2scqhjhug
         lHrRcucg98da6nADmRdYiu+/ga28BYxNIBOeEzaCWl/OflAg+IJvVbTGP4r+Tg70TYeb
         Fmq44jr42TlYnz4rVXuX17MHjxTDqRabGOH1LRp31HdVPk/0N1B0SVlSY/LuyrF5RV8b
         2heA==
X-Forwarded-Encrypted: i=1; AJvYcCU+r2qvnFbpUz51Q8ayFf+sRj7Tgs711+09LMyzRGvB42N1vb1A59y8blDbQmBV/lj5Ph2usRRiBPsWZ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdv2VQvJbxVhu83kjv14RPz13zUY7ZaK5WmfAGN6d7nsCNGD18
	j9SchzOnthzmGgPmx6mjrh/DaXjcEpgshoUx6vly1vxa3/7wTCuLb2KN
X-Gm-Gg: ASbGncswyY5VvWRi1p3yJqNlWsTd0pujKtUT9dXxMgrcPpyKYLU3x2eJPxHvS+dQAx8
	WQkkHGkJyWaif+wdtp+OykxQ7e7cnNglQyIWnJ4+QEqUsOPiW+Bp8jYZ02Gy8R+fqrrp+aWgb8z
	y0Ro8nm67vqe4e8sQRVsauL8y1buhdKuRNf6f0KsJayrxMIketMdb2mFU5C6HtHQbxFLeK1TEGD
	gRsSz1U848hNYmu4+QyQ5ZM5OrMpq1zlhMyqizu20mHwRoJ0225PLrhJ66zMApPRgfUFP3mpfRT
	VEPSGgU6yWLpRxVT15FLQki0VuwNBSIhrsqnGhhU9+IIOqJNK3Cg4FWF2fvAqM2WPqeI6UeAtDo
	avYLqn9FwNZPa9hieyO2n/s6+hGuX+bEu8OZwWY9n13IAYnh3zfglXSLZez4stASsqB5ePZ4jKr
	ARL0LIIHsQJWJSuC60x+be+Esbkf4AFmQjj7xAWx+tiqD1+xjkE2SZ/+o1RQ==
X-Google-Smtp-Source: AGHT+IHQaqAyFKg0dIVlFNzHvuX0zpZSii67laWQ5yWofyqAlv0IPJ4MzzJSDYza6+cEoyhxJ1y+9w==
X-Received: by 2002:a5d:5c89:0:b0:428:3f7c:bcf3 with SMTP id ffacd0b85a97d-429a7e86b07mr3600391f8f.49.1761665698923;
        Tue, 28 Oct 2025 08:34:58 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm21334532f8f.6.2025.10.28.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:34:58 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject:
 Re: [PATCH v4 03/16] mtd: rawnand: sunxi: Replace hard coded value by a
 define
Date: Tue, 28 Oct 2025 16:34:57 +0100
Message-ID: <2017172.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20251028073534.526992-4-richard.genoud@bootlin.com>
References:
 <20251028073534.526992-1-richard.genoud@bootlin.com>
 <20251028073534.526992-4-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 28. oktober 2025 ob 08:34:56 Srednjeevropski standardni =C4=8Das=
 je Richard Genoud napisal(a):
> The user data length (4) used all over the code hard coded.
> And sometimes, it's not that trivial to know that it's the user data
> length and not something else.
> Moreover, for the H6/H616 this value is no more fixed by hardware, but
> could be modified.
>=20
> Using a define here makes the code more readable.
>=20
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



