Return-Path: <linux-kernel+bounces-876447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A6C1B832
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31CC18926EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5662C0296;
	Wed, 29 Oct 2025 14:52:54 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B024DCFD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749573; cv=none; b=m+sf5psqpKMI7KtatRYuWlp003SaW1s8Lwset3IcRL5x0nFd69ulVNj6EIxYMHKkSBORgxf5raRmQ+fyzr4L4NpBBCR3fvh7/mle2rHy2yl9yuVFbruf6zrNeVQY/4yn+FYx4x0RDEwKn7GLydaeW1KnrseqIN085HC4haadgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749573; c=relaxed/simple;
	bh=9zqV6jhB56NFXTaKlUcgOIVmNv3vcWwq2ciUZhAwPaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOv04mTBSBgugh9z1DYK5ncCaXKS1VCQy2Mfl2IXr87TTU9Bh3xNDxAl0WSgSoIgH+ilPc8PgIsFDFPFlIVZbnWg93q0zVZRopWSRITAlaAiW1Q+Wp9DJw8L8eNJv+/eTFrJd/q6A/lyGD2CjM75FhkV3f4LpxcOi5PYSADDMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5563c36f5dfso900688e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749571; x=1762354371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQvv7exwOArMoYZGDke0hdGiWbyAHG9S2KTmO/d6Kf0=;
        b=B06lH+X321jZKnsriX8fOQwHCW6GPc/cHSpCenlf5efcS9aDNgOPiWRH8WyJefoBMB
         C55vhFsPe3dlhn5IbtFhFd3lozvPV6m75avvVS3UV3+GoYKE3rAFfYKxR2PotMUOS1rG
         sifJn+gteHur7qheLgZZDsNm6UrgrJvbvbCleWF7VoqZboJYL7zIBOWk4wQ5PDcy6xks
         Ww12vP7XgpZIMsyX6RSPa6F1Q1xWGsY+pZ6Gy52ZAVkBdQP41+X0rDhYtydAhk+phk4+
         W0oRqg7OvaNprMVcIq1oCKPbbCZ2yNQr79x0YUMEx60fDmLC9lW2p9xHVbllyUW0fxVh
         Tr4w==
X-Forwarded-Encrypted: i=1; AJvYcCW4wdnaS9Du7e+ZzFwmNLMMUTUrkkzyKWtb24H2AIcdV6Y5/4fggiQbWMfEtGLjD6yMnYqCsfnA9TkhXP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEdlQFRe/UOwFjJbipLkyczaI2DCFh+xTX+9/l0+/pS7KEFVv
	tHQPf4hkd8h8tzgG3/m4vAoxona9nR1QwUfTL5umC5oAJcoHSdFkgZqw+DSqKUsk
X-Gm-Gg: ASbGncvd7Gk4sFUDe2IVR4fkJ+WOs0LfXK83tMABbApiD6d5crb6QJYhRQC9jwyi3pQ
	Qbku8WE+Q4IyhOedU/KGPvDuOUN/5ZY5kjlyClbNcrqUGD0pvhVnxiuQvxClqZpGHGDHKBZbOog
	7si0sjo5HxqL3eFwbHs6lsyy5SMbVpU/KbaDIxRbPc0PkZYe1WbUpBAw70tVGxhUsdCjS6zf+tB
	gvVexvbGmeYEdLy4gbkTaDg73RjGgfPzSPj7EWFt0HCq6sQYfEUSq5RRFDEUUp/pAp6mjMDGZEV
	HSZK2F/TFGsGaM19bAAV7zi/7MCt5cylLwRYZ4kzuBuLycl1ILy6Xe/hiVLdf12FEr9u2L0SWzB
	w/dhvZke9A24TEhHWq1w7SnNKMqhM9xm6erF4R0Dw5DZ2U88fPoxq3AsP7vkGCQpYGt0a9toefM
	xwUcXhf0V4+R4rtivvR2gw9lv1uTqRNL4eyqEojlseDCCRceFnoqno
X-Google-Smtp-Source: AGHT+IG0gacISQOwQrXnVKvfcqIyagj7VU3DAXWy+WiOpDLZp9vJdM/oI+fEwy6EVamCZCylcQqB4w==
X-Received: by 2002:a05:6122:614a:b0:53b:1998:dbf5 with SMTP id 71dfb90a1353d-558140a5a3dmr853150e0c.1.1761749570842;
        Wed, 29 Oct 2025 07:52:50 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddac1836sm5404810e0c.3.2025.10.29.07.52.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:52:50 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-59a8c1eb90cso4357251137.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:52:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWknNaUCg060d67i1vKBKj89MrEHPrpYr8tvt2XoWWeuEO0vtlaD2Gj8Hjmya079NJTQT99W4sUuT01QXg=@vger.kernel.org
X-Received: by 2002:a05:6102:1624:b0:5d5:d1ba:439b with SMTP id
 ada2fe7eead31-5db905d8f89mr990736137.11.1761749569699; Wed, 29 Oct 2025
 07:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027211249.95826-1-marek.vasut+renesas@mailbox.org> <20251027211249.95826-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027211249.95826-3-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:52:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_9nSn1M8MA3K_trWW2niB21Tj3+VSQgg0zrNOd166iA@mail.gmail.com>
X-Gm-Features: AWmQ_bmu-VsyNsgrWByxIwZ6BxxZOq0ku33A5vZwj4heK_7OuwvDxVVNAt1ifsw
Message-ID: <CAMuHMdV_9nSn1M8MA3K_trWW2niB21Tj3+VSQgg0zrNOd166iA@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r8a77960-salvator-xs: Enable GPU support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 22:13, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on Salvator-X 2nd version with R-Car M3-W.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

