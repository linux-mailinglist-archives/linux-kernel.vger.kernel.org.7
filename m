Return-Path: <linux-kernel+bounces-750037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C3B1562B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0547B0679
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01134566A;
	Wed, 30 Jul 2025 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="MIE8NEoc"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26632A55
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753833768; cv=none; b=V83h+PPKb0IMXp07KXO0HjkywJYoGEoO/tN1Fg5hppmjwB45MoQU7uzzZAqoQfm79LsmM36W3vD3JjR+g1MVh5pyxuCRJwwN0FZVaLC7CmRaQr314hpZEJqOCXHVWICEOd8UQWQ7BHd3DxKe6pIV1Le0qFAgop5HEaKpc8TaKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753833768; c=relaxed/simple;
	bh=Y/M5/sPM670c0P9olu2X4VtHM3mcoU/sU4qAieG2bB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nLxCCuaNs5XYcYPuY84+Wa9bzi97JQArBcR61uKLdix1CEGuLUxvj5IPUwLKjyK4BJpa8bX/nZvqgNDCxbcvg67Rzwhgk545hlFC0jDnYYKfz2oiaTHr/q9S7MULkj0fmO64UoA2h1EE0bLPfsYPjF4v03eXsWCaM3Tu4anlNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=MIE8NEoc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3804806b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753833766; x=1754438566; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/M5/sPM670c0P9olu2X4VtHM3mcoU/sU4qAieG2bB0=;
        b=MIE8NEocn9xQeZrOuFRRCH6SnDSzl0EFamNwhIvgBsv6VVeN9tyewealMQXnkB42iQ
         Ax5ajoeKHS22bbqnVTpSzLA4O78xM9WqKo88hqD+g9WZZrFC34cGCqmrwzc2xF+BPY9h
         7dU8yOa45R7Sl6xq7tJiB8XGuggLqQ22Mxi3m2xxjcWAJXQrYwpGBTka9AFnnkvcTjej
         xtdYyb6vpFtOGwykAR8lD/FKjEHbpwaQmgM6A46Mq+cErnTWJAyVGEPse3P0T4I+i8cT
         QBWFdjclPdh4tVy1cphKJ52/f4hnIG9ZFzaYQNlvTXZ3KHsM++VZJIYkhM+CLkYUe3Vp
         05Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753833766; x=1754438566;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/M5/sPM670c0P9olu2X4VtHM3mcoU/sU4qAieG2bB0=;
        b=ueTJJYpVutT3tMx3wv2gM/cqAsftb7WXoZKGz/c1jnbG/dbLHC+pp+8XHuPweNeYzV
         buxlwLrVKvbDDp3vE3eLTNHbkZF2x9J/KwC0YVnHctZH7/atTXs9O8eNc+3FUpt7BHcF
         1mJYXvPIDvsKTS8r14LRX0yOSIjf10o/6VbUcdzhlHe0mQHvuaxGqjgd4gkOc0SEDgsJ
         KdDJDX498GakzqD0rR23pW1nvXNb/yWbHkjvlMNzq4KqPFgtuLCVvYTM5tz7b5c63d4x
         chLy6VkAJ8vTMJLERkelZgQ/9+1DptxwXQvwuC6qwdzoqP+ESljNM0gNN6cVmsQIWIrS
         bOAw==
X-Forwarded-Encrypted: i=1; AJvYcCWZQyKl0YWlJ8s7WVjF0+6qOQXkpyQrGhkn2HFmVyxSiQVh76ORW/XbE4kZG7sSo0AHFxJyWA1Q0qM21YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAMVj/KHIOIc0MBWTtkkREp1Kls3R80IWS2wACFm29m+x6TW7
	mVgmbKvMqo4+F8p1kLX1J1YF50pR+d78V/gcMdxeCdjPbRmb3qFQtmJ6aRGZxpAPsTs=
X-Gm-Gg: ASbGncvpDYtNkWmDKed2zonqAcb9/He3jPGxoSAwjbX+kFKGitVZxmndsAze14s69q2
	NhNvTt9OT9HUd5Zkz4G3WBcUmdrgBnccPzpgX6YPhCTNbncSwdh7jpoA+jl/2SF+4Vy/xW41Q3q
	wUPTv1QcbkuZqvZBsWCHz/roKaPISsfyc4u3Vh9rZGRe9JQ13H1KZI51wHNuij8YWOHTNVB/P9V
	ThggMkY9LJ7qCpRrFiGvFwgdzWpyp6SgxIDG8tpPtMO+OfYfbkSGazXFnQ5jT4/sPrT7FtzRi1e
	0xrVHW4E/xfLI7WcceW3/ioaciyKcdRGUMJoiu6/SIlo6VPJ/pBVLHiiy/455hBTVCbl+6mScnR
	wmAku8nMk+Yun7lAZHbcEfYYFj6vcEA==
X-Google-Smtp-Source: AGHT+IHVlZ6q95uroEIypdpjQbCuABwWzb7jPvXq7QWXyjT6+dlzAgyJCRMwTznOfewVnzIM/Cjhyw==
X-Received: by 2002:a05:6a00:2450:b0:74c:f1d8:c402 with SMTP id d2e1a72fcca58-76ab101929fmr2149656b3a.8.1753833766071;
        Tue, 29 Jul 2025 17:02:46 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8516sm8967780b3a.106.2025.07.29.17.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 17:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 18:02:43 -0600
Message-Id: <DBOY6KA7U0VE.1QR5VMO09T27H@brighamcampbell.com>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <linus.walleij@linaro.org>, <neil.armstrong@linaro.org>,
 <jessica.zhang@oss.qualcomm.com>, <sam@ravnborg.org>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] drm/panel: novatek-nt35560: Fix invalid return
 value
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250729054435.1209156-1-me@brighamcampbell.com>
 <20250729054435.1209156-2-me@brighamcampbell.com>
 <CAD=FV=VUdfTT4AJk77BFXWy7q_je0EbRKWc=nUVevbgitkn0gw@mail.gmail.com>
In-Reply-To: <CAD=FV=VUdfTT4AJk77BFXWy7q_je0EbRKWc=nUVevbgitkn0gw@mail.gmail.com>

On Tue Jul 29, 2025 at 3:33 PM MDT, Doug Anderson wrote:
>>
>> Fixes: 7835ed6a9e86 ("drm/panel-sony-acx424akp: Modernize backlight hand=
ling")
>
> I think your Fixes tag is wrong, actually. I think it needs to be:
>
> Fixes: 8152c2bfd780 ("drm/panel: Add driver for Sony ACX424AKP panel")

Oh, good catch! I thought that 7835ed6a9e86 introduced that code instead
of just reorganizing it. I'll remember to take a closer look at the git
tree next time I add a Fixes tag to a commit and I'll address this in
v3.

Thanks,
Brigham

