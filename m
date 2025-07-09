Return-Path: <linux-kernel+bounces-723092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CBBAFE2C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB5D169E32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD8D27AC28;
	Wed,  9 Jul 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NheigJPq"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407F27AC48
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050226; cv=none; b=ceyIBKiwfYaOncs8t2IKf2kRI9PG4r6OFoFBtc+cKb7EWjAp87PNIzerJVVLEXydPUZyNBroiRV2jCUVHc4A5lfewsh1T8FpAZxrTrmPKy9TRlO8/JqlPXOwi4QTLVav48OrDIOBst+y/k3HvMTCLSvQbiPOGf2kDQywrDuijk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050226; c=relaxed/simple;
	bh=/sqyq/N0S+vrqZhURmiXH//1HHfZWh7QUV5WIVAK484=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rY5HqcFDtExBLH3FVWUT+nmjWmj5t/SqzAro2DmtSHLGg1A8bwcL+1LRqe4hQ9C1OAYLGylkN+hAHlMXwd+RhZ0oDUDwhx19X6tmDiNQDawU7sUElloK8qMVKfNOmTN5//4oi5YsIdLFu9v7ztmojdeEJj1CIda8bh2ZPjqFw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NheigJPq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3b336e936so972358666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752050223; x=1752655023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sqyq/N0S+vrqZhURmiXH//1HHfZWh7QUV5WIVAK484=;
        b=NheigJPq/IIjSwpXAjKf2r7Aou7crTfg32YyzufW9MpYQbCoKx1iWiOvDQj+H3MzPP
         qoJvxW8pHTAdjltrXVE+LWnFPu8A6bF+IwKmfYUnQWqYkAvSE6h+vgvD7tQjjKQVcO3/
         T/EcfxoS/7PkJ0YBvQio8Mu7kaZWlOtt/N7OMLI8PZVCxfNovqLLbRVzoPlAtrBUa0yM
         OQlUWSzxOnnEQvU8Yc/PlNMrQncslDqeM6bnMrM9Fww/fMtWtdL9VvL/uHj1uJfgYKrI
         xIhmLLO9mtLmOSm5vnuKZ/QTgs68zemlJK0UCOms+82yzUWMG+WbX+hRP7sH8Kg9dfUr
         JNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752050223; x=1752655023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sqyq/N0S+vrqZhURmiXH//1HHfZWh7QUV5WIVAK484=;
        b=NaMzMV/NfK8lE/w0eYnECWqzDOCXLAgihDMByBRVE8KwQMqRPEt/oLy+7DhGJXNDFA
         ABh4rIVI9ywfN9YQTp/ZRj4hquUqpGyKN7btciwb9PyMaeBqdiQvtmvXR4bM+53oSOMG
         rmKTRMCqnPfs6/e7KIMRPjtNQngxpnIZ8Vlni6Gj+Yc4m99ZfYH2hTy5YKqSr85aGy5C
         63cbIHq/+mnTFNhBpBUf1UG2643L0wUTtavyEhHqb8CABg7L6ULIkTTXNV02MD83i4Rv
         QwgPgMoiJenknWvBPw0/+8h+SfRmNR2E/EqvBv9ilN01xOd/8eGBR9qVvpTt1VeMfo9k
         c4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWXxkvvNYpfw+GS5Sr3ed9oZkidPRLW28oYpsCDnHGOaIsmGbXkOBs8sHqDRkzGQ8D5YG6s8ZX1I5KfF3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUNPAYudRiuL0pVaPdRwzpaGB6MVfu/xSbhPX+s136UmaLnRf
	jHrZ4OudrSbQqH6F8jsnn2K857rPE45+RKPDQiUtflbAJQNKVIiDcuSo638v/p1Oxwb/viSNYJ7
	JZEiUoTUOUyv+V7hucgRnlWunNSPVt5M=
X-Gm-Gg: ASbGncv368G3JZ5hE8XB7lEytdZeFMpW16D1HynAjCb1MNys/s9WjlDB8BMbxl2Q7aP
	SMtpCoppcT4Gp8Pvw7QwK1DwTPCb7Kop0Cba0P23vjFzHS4UXW4jh5vpu+ZCmiV3d2wOt06ikMM
	wRK6lscpdX2e9usGKnS8Vi3DYQ1/r8fkhi4wIupf6QPm1WdA==
X-Google-Smtp-Source: AGHT+IFarB/pAhthZGxSmaigTl2Ns6OchHfYde2Yzn0xyUq9bfdzMcRihHWLHDvkY8Gvv6JTCGCQcfx1A2RnI4cRCV8=
X-Received: by 2002:a17:906:9fd1:b0:ae3:c610:d4f8 with SMTP id
 a640c23a62f3a-ae6cfc833eemr154726466b.56.1752050222797; Wed, 09 Jul 2025
 01:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6ab943f4660e39b8112ff58fa97af0507cd89e9.1752026324.git.cy_huang@richtek.com>
In-Reply-To: <a6ab943f4660e39b8112ff58fa97af0507cd89e9.1752026324.git.cy_huang@richtek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 9 Jul 2025 11:36:25 +0300
X-Gm-Features: Ac12FXx6YH-CdoPfxUdo-nUC4uLppBywrRRRss5w3iOnMSu9H6ystcaHXc03s6o
Message-ID: <CAHp75VdXjXgdoZBgKHc-YcGFR-voPboXK8DHbN3ztWuf5jKigA@mail.gmail.com>
Subject: Re: [PATCH] mfd: mt6370: Fix the interrupt naming typo
To: cy_huang@richtek.com
Cc: Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:00=E2=80=AFAM <cy_huang@richtek.com> wrote:
>
> Modify the lowercase character to uppercase.

...

> Fixes: b2adf788e603 ("mfd: mt6370: Add MediaTek MT6370 support")

Doesn't look like a real fix to me, although code looks good.

--=20
With Best Regards,
Andy Shevchenko

