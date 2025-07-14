Return-Path: <linux-kernel+bounces-730696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA6AB04841
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88034A5292
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB643246BD9;
	Mon, 14 Jul 2025 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LwDF24gQ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E09233735
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523701; cv=none; b=eiSMprscHr8t5M5MjNuCQH+RIWnxmLoYKmK7fR+H3b/tw1VMKsHAHsPoqj/5NUCVzznrTXP/sAvLMW+kE/6pJBkzGnFg/XfUCU+ciYjGZNYB2OaPnxYTDRzjZNQGcQ9UlOMkFdXztJEiIGWfEtYTLOKb+Ejf8ukZPwtUd2heDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523701; c=relaxed/simple;
	bh=0zDSlRkiOlS0QSI3YIJVzMXfvMcRVm9iZvEXCz8nZYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq+wyZrka9QkYPbldfzCGdAYN36dy/QG3N9jikd9wUW+QXophrLfYi0F+ZBM1C8MZ0nuSEOvNZUTiGt3Z4JeK6bD1VlmRE31nrN0qnWKklxVYl7Wv7br8yQmkxWy7NLjn/NkSsxBk2hPxnixHPzBGhiWehIcvTRNvcpZgZviQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LwDF24gQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2353a2bc210so47514075ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752523698; x=1753128498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdX6wuJVyhd+STM969KIAF+7bNTfgsWX/rffAcR7Ohg=;
        b=LwDF24gQpgysjOheTLqlaoRS0K7Xw+Iec034lX6mASePrWGs2EcHckQbptcB3O8WLD
         2rSOxzRtxXOb9BbdnEcV6TKROfl5Fe25y2E6KDa2xxPj4Ngeu9Q36yaL1SkPQA0aeiu4
         qrqH2LUyMCw1OpnFsSd1cmab+UycGTwMmzhM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523698; x=1753128498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdX6wuJVyhd+STM969KIAF+7bNTfgsWX/rffAcR7Ohg=;
        b=YxXBOojlCctQp91zl8iWwC1lx+rMXfT0bz0Ve1rjjVUXcmBQNJMrOkyjSUyVEXj8jo
         vNBuECvm6+BCfgqg7DrmhoF7GL3BWjd/gflGbHwfQ/+2gP+xixPPhtOrOuSGB6Soz9Ra
         QKjwOl1KlnjHswCsP4ujDkZqN7cbrktczglqZRTZKj8tNmaPnWfakczVOxZqxSnAered
         dXDHQLhwVTmGALDLr/w3ztWRlr6uGjOAwV2mIN+3AYmBj9NCpugEkJA1UIXYuDNuvEq6
         WCcEUD5aD9FLylkuUCQidSHswnDjoFSHEZCviyXYPOjZX0tmTPlwkDKrJDUlwehg0d7y
         obVg==
X-Forwarded-Encrypted: i=1; AJvYcCVpcIYBEIpBKaRV/8aXHxW1SKijleDdPYJ2IeFV/hPXn/A7gzNiS9nlSlx3r6VY+yr2QlgtXy/Wy9rhpwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+KNTJfjomzyiaojywe3TXBnaN5RoTyMzTxWk13VWSNXlZI1Q
	oGWl49p9dNPSlZL6dB+8fz8QQ3qIvd5UA455DxOZrgeLAzWQ/hbSELwNuHWE9+B7W5ZhmnRwwkm
	oEro=
X-Gm-Gg: ASbGncuvTx4/cyrqCupz6GCVIRfgSZmf90sPFCIKZYYNkmDp1VtnF9uKOfiGnTjEvGe
	xyhbni/XHPXqvp3GewypdApzfHbn6o7QAcRm23VqhJEh6r5cN+No0UVZ8rV+WvAQRRAaRrm2Czl
	Ugcv+HTQiwUteyH5rQv8VPK9uYXlT86ZYeTERRQqRrvviiVc3Jvuc6DRO4DOxpoMWDz5Ojy85d3
	zR98B2pnpIDT/7oqoa+gQKh9AdL90XY7Zc8op8SlY5JULgVqjw0zk8LrLzIZR8d8r+CPNPbdryu
	hPpsFDl1uTUmwU+NmMxoH18EeIi/RIuXBkMGDijcMezLCSRDFYkAbgVmIc/IrlGKD2jzszXQLxw
	oheqkM+Xl/3bO3Dp8zpnAGBZv/Rx5/U7J4Hx2s4B11DOnfz/XkASFQ92J7/QKDQ==
X-Google-Smtp-Source: AGHT+IHBM1IdiAm+irgWRBGsjJd2OPrsBjZunR0gFWRzMFKOU6iITWNCIhH/DOMFAnLawvfVNmaV6w==
X-Received: by 2002:a17:902:f745:b0:235:225d:30a2 with SMTP id d9443c01a7336-23dee0ded1fmr214307145ad.48.1752523697952;
        Mon, 14 Jul 2025 13:08:17 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad295sm97297695ad.81.2025.07.14.13.08.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 13:08:16 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3139027b825so3731843a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnKLG38F65mvpnztcpUMuQHzcYEgJdadlYC/2laet4s51U1X9SiB1aUn0xi9rNxoItsNr5EdonkVbs0LQ=@vger.kernel.org
X-Received: by 2002:a17:90b:5645:b0:312:26d9:d5b2 with SMTP id
 98e67ed59e1d1-31c4c972577mr24053371a91.0.1752523695994; Mon, 14 Jul 2025
 13:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202506301704.0SBj6ply-lkp@intel.com>
In-Reply-To: <202506301704.0SBj6ply-lkp@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 13:08:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmY1Hm7H9R1uT3nAcWOC9XFYA5YZUFWj_-xZTX335ZNA@mail.gmail.com>
X-Gm-Features: Ac12FXw2vJl6mE_r2r8DlAbddESOYuqs5UPn3qfeXrUhF4FOOKAlHOvJs75MGjg
Message-ID: <CAD=FV=XmY1Hm7H9R1uT3nAcWOC9XFYA5YZUFWj_-xZTX335ZNA@mail.gmail.com>
Subject: Re: drivers/gpu/drm/bridge/ti-sn65dsi86.c:1376:2-3: Unneeded semicolon
To: kernel test robot <lkp@intel.com>
Cc: Jayesh Choudhary <j-choudhary@ti.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 30, 2025 at 2:14=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> commit: 55e8ff842051b1150461d7595d8f1d033c69d66b drm/bridge: ti-sn65dsi86=
: Add HPD for DisplayPort connector type
> date:   5 days ago
> config: s390-randconfig-r061-20250630 (https://download.01.org/0day-ci/ar=
chive/20250630/202506301704.0SBj6ply-lkp@intel.com/config)
> compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146=
a88f60492b520a36f8f8f3231e15f3cc6082)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506301704.0SBj6ply-lkp=
@intel.com/
>
> cocci warnings: (new ones prefixed by >>)
> >> drivers/gpu/drm/bridge/ti-sn65dsi86.c:1376:2-3: Unneeded semicolon

Posted:

https://lore.kernel.org/r/20250714130631.1.I1cfae3222e344a3b3c770d079ee6b6f=
7f3b5d636@changeid

