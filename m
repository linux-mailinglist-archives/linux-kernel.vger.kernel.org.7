Return-Path: <linux-kernel+bounces-861761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B1BF39BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5B39351C64
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D9334C08;
	Mon, 20 Oct 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmI7eBD7"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6029333454
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993881; cv=none; b=J4iFH4YJXDdjulXzV34/diyGyO17ko/vnnBXlE3EoZSgQE6RsDDQFV4om3aZmWh7I7efCR7qyzLQUvwHzGg+V37hr5NJDwIFW11kqdznyGaDYMaQ/cTNQ1KMgjN5Jb2tR+ZUJyA69uv3rJJegRCnr/GkAXl0lbp6ZYRVNBqYir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993881; c=relaxed/simple;
	bh=pnGIELu6O3HOFz98MQJ52a4u31e/dW1FZz/2rCRONDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBObYRxroX6X99PSmk2iHQnAJz1HkWdNa8b1L9SbnaaPNZw94/IRrMVoeUIe8KjX9A1NUrCft+VfaLu7Nc5+GFMT1Vfc2bznHKYYZaJzSTxNZ6+zWc79jpoZCGvNkvpDvcg1uLZ4t5QzE8TLwzAmZYsKIOvKCt752tfSeCax1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmI7eBD7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36639c30bb7so42798631fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760993878; x=1761598678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnGIELu6O3HOFz98MQJ52a4u31e/dW1FZz/2rCRONDA=;
        b=WmI7eBD7c/kbXiyRvGUJzFnOd1KS9mNgkAx/wKoeAQB0mlgqIA2U1xsZkEDYK7cEuy
         9WAU+Yd6tVz5yRhqNE5nuKCffhDzR1DSbC5SHojwi9bzoGt/Pjq0nvggRco8qIFUjl2u
         3xPDvs3lqvMTnlQt8VnzJOvzeNIsp56+c+JWaUjc6yfZXcUqVz+as9sMaU2M6IvBCOlc
         BIxXVpS/S7CHaFj8qXiMLDHzxNbzdI2jJr6Yh+JZ/KHa9biHV+IrviCYLHvT9lPU6m1E
         1h9ZSuo5ay4CcPysAivrLy6ECwNdqzD6y9A+5Kl+sdbfci/dpZShoouIoUuYlNoPcejN
         f7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993878; x=1761598678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnGIELu6O3HOFz98MQJ52a4u31e/dW1FZz/2rCRONDA=;
        b=Y3iB0r0QEeIyWD6aBqc7RF3yMkHD9blui0xfzPsZWAzbYfSShxvIs7XrG9x6haARYQ
         hdo4PBzWXAnkkPLM6uDDEEzLDV7L/VaoIa4RdUZs8HskxBumJZNfWJ16c6oZa3QKg5eW
         mSLfevKfqF9wDPy8eowQArgZD6NIiViAmciQqfzDLtceLGVJhF/VqJjyAGIGlDRvre94
         +cuzF5IsD+LGIArO7+mtzyCRii69AmA8vZgoIntUC+pL8qzBJwk1vtkoUf76nsQx1gLO
         0UyJlPWOYOTV1h+aW8ii2ymwZCTUj3k/WFnDJ0PenVSoEc1Fzxq2q2d+0XBztuqsyBSY
         YTGA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ47OzB13M0+Rrq4+bAg4vSlhdn2Tss11Euv2NDr0r2JUbZNN4Ah6ennpqAbcRZA0Vl6QDi1SRr1oYFGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71CPQeXqdVM5P8J7LExxaIMwmw94+JUDJ2IoQBt3ButHXtg4w
	RKp33wEi7Xn265iwzdQsLDbOsBVaFWLocWSPZdD18z7lXtH3PqgqE4kMsM2ReLLsgPVEPhKOdyM
	g4CdP0dmrMlg42rBK0rH6a4KZr5jfEqbVoHexdwRcoQ==
X-Gm-Gg: ASbGncvgG7v1MTH7wk39ivkban7WjhLwIR5mAyNlpZdn6ufRy8Tez17YdqOuRIjP/0m
	6cczoBGnk5cR7qb/EYpaYlM5kbb9QR5QTGjzhPC/wmNiKoVK3JK6f50LFPU+xTN+rgUh+ug8chA
	TXoNUPzs5ztuegN7Q8Js0DgJoZTGP4uDqtKmyZPCXh4SeT3I1Vomb/kArYyfJt/O/Dho+PS2sq1
	iqHEkYMZpH18s/AyRVAUowQD2+fTrN4lu6Ejabgu6oil33nEOGL/TJ5Q+cK
X-Google-Smtp-Source: AGHT+IHiYaMFIB5h1IuCc0gpYw8kK+jaVWftl0vp6vdhycGk4jXf5AqAN9UnlLAvcdiDy+MzLOJyJ3cRLt227uwuZLI=
X-Received: by 2002:a2e:bc87:0:b0:36b:c7d2:3aec with SMTP id
 38308e7fff4ca-37797a3b35bmr47819151fa.31.1760993877917; Mon, 20 Oct 2025
 13:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013191226.4137995-1-robh@kernel.org>
In-Reply-To: <20251013191226.4137995-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 22:57:46 +0200
X-Gm-Features: AS18NWDSPZhI5en_XfH6pnJ7MLfO5Ag8k1dsw9jH3twF_H6jQqdTj7LeE7PJz1k
Message-ID: <CACRpkdZR+vTDcC-F1=bMK20hJm8g4gs3R5Y=APAyANKS4btAXg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert brcm,ns2-pinmux to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:12=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Convert the brcm,ns2-pinmux binding to DT schema format. It's a
> straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

No comments for a week so patch applied.

Yours,
Linus Walleij

