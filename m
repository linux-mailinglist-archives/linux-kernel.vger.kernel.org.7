Return-Path: <linux-kernel+bounces-876445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196DC1BB82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6482F587301
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35232D593D;
	Wed, 29 Oct 2025 14:52:09 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96230262FFF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749529; cv=none; b=OylsCIBVKn1ugfsjrFnbR0y1BbcQaMKXTpld1tespQIpfQtq7q9JZnzlOS2xzCRrk/fatBHQOXiYfQsfpKLWpwWFzM5koZgUbFMHsdcW8sttTqkivSD2KwA1/5z3+D+1RRb9fDSo/CTUB5R/vPXJk5AU1688fL9zsGYIp1bKWjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749529; c=relaxed/simple;
	bh=x8Q6phZmuf/56rhTPcAI9gNeRvjsr//c9Go6x2HJnsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOA8zU0Ef37dswSukPKS0JD6uX2G93rBsc5RQtRswktn6aTAc+pYKenQz/4OBsfc+6fLkC5R4LfllYMoQPN7jtF4MRgfRXCEdGPFY+R138HQPXNX10tih8+YALEVzsLvklVY/cD9I5u4u3nZ3RVMd23aPbNNkyhqeI0aDVQWFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db308cddf0so7596967137.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749526; x=1762354326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6X2VdOjut9PuIWiMUTBESV6nSJnAJvEj2IyZk3vIzkk=;
        b=o6DJFk5J8dx4BSaCmLU2W9PZ47T6jRFx3Ti6hgaoTwyC4hUWJyWW3TjL3YtL2/NUgM
         opZ0aWvlFlSKL7ztDpXTYvzJ+3/PYbfTO4wxgZ2FaILCP7TV6oo0Q5Dbqujv+9Y1J8uB
         Nk/YEOLq419eSSCZq5dw6vnZHOGNaiO1umzJ46jMFCfqzx8xtXaC5OFXRSSBOJkw8RvY
         ekJhv6sD+VT471DaOj+Eviort2aC6QNpPINKHI8Lm+AzibgHlP6f1R+QDEPFA8dAiNfl
         gd2dT861z1xqhpxVaqtBwA+mZd7FDWqeJUHI7SYe1yX5B0ET1kDvSoExwGAxlFMGY71k
         iO5A==
X-Forwarded-Encrypted: i=1; AJvYcCWNKlXRLDi334vJEnL+ylvdOcz8oQXKjIswrQqv0xp/43CGJD3fKUKJJ3DAsZq+pdjzld19xeAfoVA/Kk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdqUBrpmY/8LhAfEvMimSa9rjlWGCAFB7JgtmgbrIG06nLU8MX
	WoWVDr4+LD2UHCqmwd4Ok/xnMV72IvacsHMZSNebKK1VOjiAVP6pXEyMGozcnC1q
X-Gm-Gg: ASbGncs9t+fPA0UTp8Nt007QvhQkqXC0U4v0CksYI1EPqvhMEmp/OdLvPkpAxIbFpWo
	8LDP/2Nt69KLb9+5VGCATVc2YQxqFsHGW1V6oR8/pt/DvNQ/YdTWEQgebK4FSYaGv38116LsQpj
	meGwNDO8lgkWLbiaUxj9Obo2JXoU0eosK8P2D/j14MecSNQgXr4IJJ5OO6UNVMa2dA3+iY6v+LK
	5Wrty7d2Jd4WGnKIck1B+KwzhgWg1ToYkQLpgREK0P6noVa0Uhq7QzVWex/LCBqbQ56eTkogDVA
	Kfpuhg8HVDxpLkBiXReUMD/5HTnh+eNSzKJLscIS0XV60M76ojWnsmbnpov/ou6IxR6gtPUA0xm
	UlTIh/XeIROekfnmfDJVT7NXdPfY8TKhsMhHOXaStZ5LQyzXnRPR3UlOPzca3SMPLCqYX6XASmd
	8OicKhL9EPKs8mMixZtU++rxP2GrqIZN+Fr0C6z6r/dn7djkynZWaE
X-Google-Smtp-Source: AGHT+IGKR8KyvQCt2k6fUda6VsZobc+igbjTHibxZw7uj0Fk4eDMQfXlDOSgm1ftAGPVaPYyxC3w+g==
X-Received: by 2002:a05:6102:5cc5:b0:56c:eed1:276d with SMTP id ada2fe7eead31-5db905b0c98mr1075351137.18.1761749526064;
        Wed, 29 Oct 2025 07:52:06 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db4e5718d4sm5209869137.10.2025.10.29.07.52.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:52:05 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-934c9de5cacso3945520241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:52:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWClWO7hP941F1as+uzRdLhjf537Ty8i+zmRFaCXcfjrZi3/jSsyBzybam25sRVcalszRbMSok764PViWY=@vger.kernel.org
X-Received: by 2002:a05:6102:2927:b0:59d:ad3:e1e4 with SMTP id
 ada2fe7eead31-5db90575883mr955429137.5.1761749525479; Wed, 29 Oct 2025
 07:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027211249.95826-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027211249.95826-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:51:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwXjE0Bq1KjENkN4m2h0_nN0F2S=CC8mW3B92NdpN2_g@mail.gmail.com>
X-Gm-Features: AWmQ_bmfWRMn93VJbp2i3KyknET1ZJrYFFCyir3HovrKjiX49vnsC4NYomuCi4I
Message-ID: <CAMuHMdVwXjE0Bq1KjENkN4m2h0_nN0F2S=CC8mW3B92NdpN2_g@mail.gmail.com>
Subject: Re: [PATCH 1/5] arm64: dts: renesas: r8a77960-ulcb: Enable GPU support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 22:13, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Enable GPU on M3ULCB with R-Car M3-W.
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

