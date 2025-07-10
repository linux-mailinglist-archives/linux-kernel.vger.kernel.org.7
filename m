Return-Path: <linux-kernel+bounces-725836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F57B0047E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AC55C57F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC882749F6;
	Thu, 10 Jul 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hd36/yZu"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066682727F9;
	Thu, 10 Jul 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155653; cv=none; b=IrXSdn+7Gy1POAXUZ9J3zkyVD5fqikERErsy69tqmNf9La4bkiAEeBJ+r/pPdBu7wCJy4q/Z8844UuuxqH11xDufb2+/GMoF/3FiOabc9/fKgVoAzTpWRgI7voWB46Wz/D6HgMOerLxzTVCdZ4A3WCPhPhqBPyZHlUfx8WqDbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155653; c=relaxed/simple;
	bh=ucvdGfSAD6BNiqV/MexDFRF6BGv69Ix8outD2J2Fl5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXFIbwTS1XeY4zQhhaBbF0w5p18YQ8UFq9U2689RYWTR8Ps/LoBbxNAVT53WLlMMLacjz8bKAzc7xiXYE/AiXGnp8YMBdO+ug5xMNXOs94PPOndlmBp0AhciO3m7FxjrQGV9WE7hohA5zMjIXE5iBH2ZW0ZAozWfMQt0GIRw++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hd36/yZu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710f39f5cb9so9827937b3.3;
        Thu, 10 Jul 2025 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752155651; x=1752760451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucvdGfSAD6BNiqV/MexDFRF6BGv69Ix8outD2J2Fl5c=;
        b=Hd36/yZu1r8xEfG1tYV27AWIdD4UxvZb8qKnIxSiyTRJ7ARdNNtccxVGk0jQv7sJ3G
         uU/JhRCH0DxlikYvt/wtq3v20zWIlJ1Gim+gQpiV0odCIn/Qpf1eBX330IWuhdW+JJfW
         /JrDvuNmFo40LjAOPaB1P1NvmJlDF/v+Q6wxqpYIoBAjp+diXsY7uR7KJoTQpJ+boCBR
         Ai4xWcjryC3cTMhZH5dr+rV79odHDthVTvb+ixCMT/jKvC5K2Q36O3z9uzjFO3YKrcn5
         1uAPsrqFe6krV70vUOgGxk5vWxlZi/3kbVrpesdaPpRzm3yWb/z8V9LdKpiV+yVjPiqD
         2QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155651; x=1752760451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucvdGfSAD6BNiqV/MexDFRF6BGv69Ix8outD2J2Fl5c=;
        b=QvvcCRrfl8qXtiAwGY6L8sg4G0/7shkQ1P+FXAdPUYHDbUu5I1H16z7NvNA9PPky5A
         khuOl8XDnOEag+NovItmtkNdArB+UE1Xu/SmgpynIYiIOyuxLdSZzy8aU8eTj9Wa8JrU
         BHeERNCCbNJskG39nsu5ZjY1B1O9xfB/q7nyCfWGzBZjZWzxW76uLJhfUfoBkIfjmVZG
         SgVkVasG5ib7BMc7iKs6PaPGqLqv2Yjtf3vPSomgncPU8kZl5JuDra1Y31Iujl+law0n
         8o+OBzTPveAOOdSWFAQQUD/0goYEyrJdiyqrcsxJBKp5BXat7omtB93+2t3wiuqkDLdN
         IU8g==
X-Forwarded-Encrypted: i=1; AJvYcCVw9agdHPJkU52pwe8X6O42fDCV7wIukL9WZ58VtNQic2FaUylG4uNOkURqlTZ0AUPLVs3C5TxBkdonBjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0BKTxii6ce6UL0YNEIEk+CwR8K265lwateIAAR5NitosrTs2Y
	c4POra8wYllktYWCnDsdlo4DwabY0LS1U6e9bl7x9U650Zr492atrcyE2YcvL2M5ZIUuHoqFuTu
	yTJfHurYJg91hj2+RCV14eRRLXum+PGw=
X-Gm-Gg: ASbGncsvYI8pqjYgSXWF6G1QOq40IirXyIsWC4ALGoWY1uNPGQ+zMRTdcfvLJzVb8sz
	pydpWtDzk0mjAUBg6urfzSVf+8k5zsDcRJKuz5FsF3jpd4/OPhYRkFJCrofESEVVSmK6kw1OBXT
	hrTworljiDIMlB73KI+3uh71lN6ROHT/7OtFyA+KvBjA==
X-Google-Smtp-Source: AGHT+IGEs6mjRSoRv4DuwjhMRI12lBJa8IqS+/Fzcgdccj93qN1nI3jcEoogDoLBGHOtc2jgXEbMvX49hnrkdMtBpEc=
X-Received: by 2002:a05:690c:6103:b0:70e:7ae4:5a21 with SMTP id
 00721157ae682-717b16a5e4amr91278037b3.4.1752155650931; Thu, 10 Jul 2025
 06:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
 <20250709220714.85697-2-stefano.radaelli21@gmail.com> <9b503f65-5c8c-4f04-a1b1-40d7a1202e8b@kernel.org>
 <CAK+owohgk3CkQRv_PBDWXh44X2uN3p8FWBU2t9VtmO-xzOKTow@mail.gmail.com> <6656b2f0-5258-4f23-8988-567a7b598497@kernel.org>
In-Reply-To: <6656b2f0-5258-4f23-8988-567a7b598497@kernel.org>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Thu, 10 Jul 2025 15:53:55 +0200
X-Gm-Features: Ac12FXyh1DZvJM7tmmJAkdYGtcey-gUnTnYuleZqhE3wLHbYgj5zc8qvxVjp4t4
Message-ID: <CAK+owogfXDNpjT5Ywcvjaegf0H8-pS109039WadhxHXHbe3GSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> Then why do you define it reversed here? How this som-factor-processor
> is an argument to my request to use som-factor-processor?

I apologize for the confusion in my previous email. I made an error in
my explanation - our compatible strings actually follow the format
"processor"-"som-factor", not "som-factor"-"processor" as I
incorrectly stated. That's why our compatible string is
"variscite,am62p-var-som" (processor-som-factor), consistent with the
examples I provided of Variscite kernel like
"variscite,imx93-var-som", "variscite,imx8mp-var-som", and
"variscite,imx91-var-som".

>
> I asked to reply with mailing list style already. Why are you still
> top-posting? It makes the discussion difficult.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

I apologize for the top-posting. I didn't realize I was doing it and
will ensure to follow proper mailing list etiquette going forward.

Best Regards,
Stefano

