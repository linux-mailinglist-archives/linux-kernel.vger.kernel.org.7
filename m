Return-Path: <linux-kernel+bounces-806681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EDEB49A51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B9A1B26F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E72D46A9;
	Mon,  8 Sep 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rykNTnHO"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066062D3751
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360897; cv=none; b=nmv2K4iylSscDeZ1FI4ucyHAC8Oz85gU32SqSBpnhXyN5BBl6CnHNKTxbxlBsCNFl/gOb+43dGg9LwDd6fxqn8Pu/oplkmkeZSZEwWaH36f8iAng0Xp57tmk0Mkf2CrpdTGU/4SCjxfbAlzR8OLMAPiH1WaU1KF4N7LBjENjy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360897; c=relaxed/simple;
	bh=jmcLddsM1rSmyuBEhmQTe6QzWT65ZsqYoD7U2JXM3bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pyfh6a/52Nk4sB8U9pu0TXc+8w2Jmds0LqfxSOxOTd3oqZIhIyhiA1w1aJdczxdHpuIjWlLN5hv/YgZawC8YzJ00leZmsxHpCSiVtMY68OWU+jcafYZBX7MaBlb9KQYQ35H5TyZ2lXpWUS+3tFUv5IxC6oaDW5F6PVCx7wMqWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rykNTnHO; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3381df3b950so32588801fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757360892; x=1757965692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3INsSU1uTYQupmizf/+V0CpP7n8ujecpPRfiWEL0UCE=;
        b=rykNTnHOg+5Hh1ScgAlTgO4g+Dl9cziV0mJ3XCQUpwgPSFoY9K+ATM3kq2d1eByOzD
         2TKAgpEPdsC1PkmBSSuu8yGE9XKCXNjRiXgIwKGeBVyRtBzeispJuWCzRzBHHNISatqQ
         cMNlSVb0p/guBHOHzmBbmd8wyaZaBmcnfYcexxkPWJJ7VSyexoP4Sqx2LjVq+NHHklQ9
         Xm4TZ6pz8r1NyAOvaA2ICRinTVqSqLlKLVH8lE6ZF8y7ImBRd5O62vSTQwa9BoDKTIXu
         aGnphQLsyWPjCmy363qTFOdKLozb4MF2dR0pHeAk27GeD/VRDHSvOnNzaxlyFQ0W9p4A
         p7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360892; x=1757965692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3INsSU1uTYQupmizf/+V0CpP7n8ujecpPRfiWEL0UCE=;
        b=AGqYQFREmfqR3HSf7MDBvk2xNTN0HSD+W0w8vPHh38ooqCmYKDzw2A9NdhRVjoRtnM
         FZ5hO/iD6orjHHIL1VVyaXQI4r0jNShQR6U3sG5kEGfsTsuDBhU2VjD3fRFtHTG/7v3p
         /4MKwl+2wJ7l5+9jFdu62nYpU2kXwQAuWxl4gkUVU9E71tNgADHkVPzxnbeylgh9CSRS
         R3SORmyN/d30NPMtfLtbRjRE50bwUxv6+rsAyYEkCqC0xmXqG81VlrwfNnN3X0dEvXwT
         D4wF/PaNFOqZedT8sEzLFCXtQtUI5LX8YgNnkRJaFO3kFYKUrLOi2oh7hj2TDZWV79l1
         wqmg==
X-Forwarded-Encrypted: i=1; AJvYcCW+y8abqxF+xBA2pqUmUaRsdQGRjx/VtITyaL6IsJi+KmJPhqkFHg7EPDDDR5jTPodZwaYLbARIajXvvf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0I5ai367HI4kb2zhvOmagIlyu7W4z74KsF+YPGtpxpizNeut
	MChxEM084EW/1PE0THUeqAAX6FV7gkd7vt9hDe+fvtZUd4r1Y5zItcQIkbQx9nO1IGeQh2BVvGu
	ggjDgUzAZWDckZJS/HN3A84mt8jk3djLZ3+4nnDJUdA==
X-Gm-Gg: ASbGncs4dJ9HyutAi4693tWY55LOWLWkjD6xoMga3vRON20tje/Uu30IA+s1azRYkey
	43xqLHyoRgMhwFMH2TYppLjaQyDdM/JmGQaiJrlaZrEMUywC8okXXhnPRvBp/JkP6KmRsGZP1B7
	lt9DKbhcpgsvxeYPaZDwCvhVS6NvRDnkRzMT4keg+5z7lOEukl5VJWaemdarG6wygYpP7UButAH
	GmGJxoxY0gDEoioVw==
X-Google-Smtp-Source: AGHT+IECsnVMplJOvU1wSeDf+UtwgKH+GUnENKyyNmAGanLxQEiq6JDDQKehxdXdClMMDAwVmWV+qsEKFt9fd6U9X9w=
X-Received: by 2002:a2e:bc09:0:b0:336:e32f:7a07 with SMTP id
 38308e7fff4ca-33b526a8613mr21819761fa.24.1757360892038; Mon, 08 Sep 2025
 12:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87segwyc3p.fsf@trenco.lwn.net>
In-Reply-To: <87segwyc3p.fsf@trenco.lwn.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Sep 2025 21:48:01 +0200
X-Gm-Features: Ac12FXwlhaA_zh5PcQMw0KQlzwm74NsSx5Pd--nbogRPFrwMhW7PG6XBm2TCOmk
Message-ID: <CACRpkdbbzV=ximWZkkfNiGpdCRCkB=--x818ikf0APdQo=5J3w@mail.gmail.com>
Subject: Re: [PATCH] docs: update the guidance for Link: tags
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:32=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wro=
te:

> As stated definitively by Linus, the use of Link: tags should be limited =
to
> situations where there is additional useful information to be found at th=
e
> far end of the link.  Update our documentation to reflect that policy, an=
d
> to remove the suggestion for a Git hook to add those tags automatically.
>
> Link: https://lore.kernel.org/all/CAHk-=3Dwh5AyuvEhNY9a57v-vwyr7EkPVRUKMP=
wj92yF_K0dJHVg@mail.gmail.com/
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

