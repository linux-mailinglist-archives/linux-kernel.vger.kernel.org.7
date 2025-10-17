Return-Path: <linux-kernel+bounces-858319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC985BEA3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD017479FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E41336EF5;
	Fri, 17 Oct 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEaJ7/ZM"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66854336EE8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715224; cv=none; b=oEjctVa3FvNLSsCv2761JIsputy6EU7LDAy/knftHiAe7T6aLUkLzgDKTUGRh5FAAkRGgASjUF5ISBdK6eHxw6+JYl1DlReyT5o4xc3OsjY6fZJwsZlv3nrWPZqTSPlnzUkYtwv/bGtm3hKOk7FAPBSUkOpyaiU1kKaSrLWXyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715224; c=relaxed/simple;
	bh=AYDyBoqSGxp3sLQaIrRnQxkp9h8SmM+W9ExXpNQDIpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXweFqksuqIGWtm2o3qJYqN7kSd2MAEo5K3bDE8Z/twN5Ow1PG7eXduwxaEhONDIEV1AtBDoP5OiM3LN2U8FGhuc5HaDQgaUBv2QsFYwgLfB/ftLbAMOhKNQAqiKw18tWDw+/gXjxveGiIqyDzvrkK3gWX8TOeqXoWbZphGCiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEaJ7/ZM; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63cd60ca2b2so2259608d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760715221; x=1761320021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AYDyBoqSGxp3sLQaIrRnQxkp9h8SmM+W9ExXpNQDIpQ=;
        b=eEaJ7/ZM/13IWVXw5oeqXMk1MU7bmREGEhXoPRf3bWnphypliFm33zeJvZfiqMA1OL
         OFnKpKMyQEEkte88DkzZY894ZdIsgdPmfXILgGRijbpGLIAwxYk3RTOXlYHL8fxWG/e4
         deM+QGs4XY3zHqQFPSZsjZwEN8HFAE8JpZgxl58TU7tNfaoEa6zYthERlDv2LStD+go+
         NegOKgLZiHVI9U0QlvIUFqF1MYEFNbPcx1/kc3nIpd8ksce9jyMT57xTkbANFtkSZSiP
         u6Qn/JaUcv6sDEy9BNoGV0MP3oFPrQhvmEdhC8hfl2GBi/qp30LD5YdmrxY8RAK+Sboa
         /Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760715221; x=1761320021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYDyBoqSGxp3sLQaIrRnQxkp9h8SmM+W9ExXpNQDIpQ=;
        b=IaRNfEeauA3IAAoJM10qOQlQYEjcu4DD2uWvGR4SW8fQ6IchZ0N+AM+QJWQ9uCMw2S
         AdR57hc6eoH7JmIzfZ1BN74MixHZYXyo2KBHKJ5CCLmbzCPrjrxgeDB7VcqQlwgDgEPe
         RGPml5wssxNInWAOCiAgXc+WeCKwVs+/1D905ixtnn8x+GG/La8ZKDvLNEjx9LGZVGhQ
         K0n6Q2dYeDCO8kVeY8V+NAjUhvPDUBwzYKvW27cuJ0LAMou1gwSRGapkW1yQY5ZtSfZS
         q6ujYb/6PrvJquiD9/xUiJ4A1i577Fhr10VbNE4LpJJQ2rlGeSoxTD7eWQzEZbfRK7mT
         LH4g==
X-Forwarded-Encrypted: i=1; AJvYcCXCRnXPZW78peFs6t9pDY1lIZJf18ytqKZaWJc7KDh5BdMOxSuPCkS4pss0asFvmAXAFcwtZy/2elC8RPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjWzvpo5BU7DbRQW7uq/mFpqzKKItLfR79kwDXEoG/e9gPaN8
	dimQU84aBQG/Zh8GgtULvzYs10ArshkYSgOWZaTBcNzdWPKrS7D5DPEPDncFovDqZq/ZXLO15c9
	smMDEh3JCfjXm7zjS7+UqxtIXg02uo2E=
X-Gm-Gg: ASbGncs2l/7HX952Q75xHKlMd9+R/WfcC/utavhF7PfwERLxxj19BoG+8rYQ0zxEatw
	JSoBvySrBrR+vhVaiMLeK6eFXC3IuWfTpXZZW/u4hmVEFBTo76MGZ0mvFnISOpWP0c6h/wqJ6sk
	ucXKKuJH/OQkqFOMPNwPhWrprDJM6dKHsne2EaGRfgDV8KBmDoYFoTR9x9IlqFWl83ClXofkbaE
	sHbRdNf7fqMzChd5uiFYTPUXlem4Aoph1i0ZXP9iQloNQQYZn5et8ivwSE=
X-Google-Smtp-Source: AGHT+IEO4gGGrFgVxNj0joSKzwqK7reU4snr2LDuZWleqTcw0PJZE1dEBv7ao9Zj2BRol9e9zJSHmaElOFROlCzKKb4=
X-Received: by 2002:a05:690e:408e:b0:63e:17d8:d97f with SMTP id
 956f58d0204a3-63e17d8dbbamr2676488d50.34.1760715221313; Fri, 17 Oct 2025
 08:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017100106.3180482-1-michael.opdenacker@rootcommit.com> <20251017100106.3180482-3-michael.opdenacker@rootcommit.com>
In-Reply-To: <20251017100106.3180482-3-michael.opdenacker@rootcommit.com>
From: Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date: Fri, 17 Oct 2025 17:33:29 +0200
X-Gm-Features: AS18NWBsu3k9OEM7-rP5g6-76bcKbcZ1KDEc8v6XA3KbUIJDEMiQsuWyEbUxtbo
Message-ID: <CANBLGcykz77U_V4CqE7PHvtgmeXiKFo0FXy-sHHiAoZ11HnCjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: spacemit: compile k1_emac driver as built-in by default
To: michael.opdenacker@rootcommit.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 12:03, <michael.opdenacker@rootcommit.com> wrote:
>
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>
> Supports booting boards on NFS filesystems, without going
> through an initramfs.

Please don't do this. If we build in every ethernet driver that might
be used to boot from NFS we'll end up with almost every driver
built-in and huge kernels. If you need this there is nothing
preventing you from building the driver in, but please don't bloat
defconfig kernels for everyone else.

/Emil

