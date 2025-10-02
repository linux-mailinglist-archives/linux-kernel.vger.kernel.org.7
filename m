Return-Path: <linux-kernel+bounces-839876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A85BB2A01
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9E93B65A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579D28C2A6;
	Thu,  2 Oct 2025 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzF0HKtU"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2859263C9E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386968; cv=none; b=fgbJJ+XMvbExFK4vuc31D33q+AvC2l7BvJ6KPN8svSBf+ZnX39CCT9cFbhoula+TJklmInRwsYI2FJx8SEKWO8hFdIboIWtrgQ4WbK6PQ+nqTnmm4T95ibHFdV/FlCGDH2m57zUL/AnRcfZXzRcHCJ8/rC6NWpmVUhdgEFTv+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386968; c=relaxed/simple;
	bh=+JxJRHM7RKVe2VKLf1OZeMJvur9jkhqQvZ7AlHIqtmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2S3pj+pM16Pn9S9WJk420c/9WQijwZ1y7oXvwzaKqFqkJaJyQF4tqoC2/34pNAAuOALaoy/2CIL2/3Hr/KUyFUPCzy9WCEei20MhCPsIYYzjwTz8xWnzsFQlu+q1n8b5CE6GfeM1kpgZD1hgWEP+JiuCzL9kw8vazudoEgyyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzF0HKtU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e36125e8aso642501e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759386965; x=1759991765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JxJRHM7RKVe2VKLf1OZeMJvur9jkhqQvZ7AlHIqtmE=;
        b=XzF0HKtUp3JhSd5aBjxb+mlaVzAKzDGAjkbrKCxDyQFXDLcqyGqY2iLKr5X/RXZB0y
         4iPJx5IbHo0beVb7eGLrZp30q8G1k1tcpi0yFIcG1f0NpzEOxBexAUAON6By0nAXm/1a
         HBA0qTOwCKN6zkfIjSN/81VXUo8x33e1kfaZ5B2xt0guv6h63yxwDopeaJQsRZElGW21
         PWxVkEliaS9e8v67IOF2P3cBE115zy7qhyQrn8Aj2qBdYesVSNADP2RaMH4vUWIqnpyP
         6m70q610h98RqRx5sSjDuamJA4dRLvRZFUpg/bbrV1jS5xUoZtlhzWTnilcdABHxiPcD
         qIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759386965; x=1759991765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JxJRHM7RKVe2VKLf1OZeMJvur9jkhqQvZ7AlHIqtmE=;
        b=WGZFSJdQYATu8BTCQliEfKIfNYzvYd/83Fch6LnmkwGx9CD+1IUor1XKYsINzSkAVj
         E8lCKTsHNAh9j6uowT4fF2Le9GcsaJAFura68FdRPfXi2fYN2qvPRg1FdU21v0xroaiV
         S8xdRp+puoYitjG6ceVrW0qp1FLgRJU+hwlesQycwQNibkWkiLAjg7oUWWwg+uDidORn
         tb1FW47WmPnhKnlk+irkZPU5r7Tn3Crx4aEoMGuNZnRzZvONb3LI0nAiSDXtFm/8rlVR
         8gw9Tlv38/SO8q6NbBiujQXTeeyKRZX6y3teO5O2X0gIpU/UOYugNXZNamoKPHgK2m7X
         iQJg==
X-Forwarded-Encrypted: i=1; AJvYcCXKMVaQWGQ6cDq3whTOb6OP16r2UuqRZm5THex7MHgneUoE2yP6VimUSjYGJKhSyZ7FwhFudcn6g5ywCDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKyrDTnZ8dqHmLtg9pWOC+hm1oGPORvh7AexksE7mKnia1c18
	tPxDFEXVGZhmUgBkfKlAl47QwpSZquwdEA9mBnWL7wVSbL+nYkcs6WXGZ80234kVv+EeeU7eO24
	NEx3WgkODdqT+5fvzKHIc2srKE3botHk=
X-Gm-Gg: ASbGncvLyu7khOtMUFTkB0SnJXPtLao0sxfP8vcxxMd73InePNn13QEncfSVjAx51C9
	p3eruBN4oB60So0azkN6jUFSMYnAMh9OJHqS8Oh9IyiODpoweaIHFUVl2P4KMVwQRrYkLzEVSQJ
	hj9Ov+M+XNgN+wForNojf4PIaMW3yS7431Lxa/VohHPGxb7oCDY9lhO94DCntS9fujNQeJH2Bqc
	ShW38zAbD747U8mvED2Pkeb5uSlHYiVIEBn9pSASTF5264VjV1bc36OJ8soqhlOHQ==
X-Google-Smtp-Source: AGHT+IF99G3AYiAUEQrPtjf+2h2PSZdL5Ih8yjphXmvu9P7cETElAJxwS9A+P9E5rAaBZ1LwUTeNFcGEcpOdmxasB90=
X-Received: by 2002:a05:6512:3b8d:b0:573:68fd:7ad2 with SMTP id
 2adb3069b0e04-58af9f6b129mr2083801e87.35.1759386964675; Wed, 01 Oct 2025
 23:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924175743.6790-1-hsukrut3@gmail.com> <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
In-Reply-To: <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Thu, 2 Oct 2025 08:35:53 +0200
X-Gm-Features: AS18NWAtwoESXok4b8-OK2ehiGbNAGs6cVgv71Xx2MQ4h4uKtcLLpvhfJQAkNZ0
Message-ID: <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: David Hunter <david.hunter.linux@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Helge Deller <deller@gmx.de>, Bernie Thompson <bernie@plugable.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zsolt Kajtar <soci@c64.rulez.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,
Apologies for the late reply,

On Mon, Sep 29, 2025 at 1:29=E2=80=AFAM David Hunter
<david.hunter.linux@gmail.com> wrote:
>
> On 9/27/25 12:12, kernel test robot wrote:
> > Hi Sukrut,
> >
> > kernel test robot noticed the following build errors:
> >
>
> Did you compile and test this code before submitting this patch?
>
>

Yes, I had compiled & loaded the udlfb module with no errors. Please
let me know how to proceed
in this case.

