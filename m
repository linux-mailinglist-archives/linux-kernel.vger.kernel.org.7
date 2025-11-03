Return-Path: <linux-kernel+bounces-883188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CF0C2CB58
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EC31890088
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2D31D758;
	Mon,  3 Nov 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/+PRojJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11F301708
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182705; cv=none; b=Fc5mLVEZiVt3G+3qR6u8+fF1XW9tQ9BubWgT9vEf04wsa8QRNtcn6fb2QX9citORtyUpR7oh2mdFhnDilrnhJxL8sB8JMexK/P1x8cx5A179HFE8DzfSVF9WXVyfPP0hnv4CJNOcAoFKg+HlN83JopcOzlCgxPwpHVpjnZMhNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182705; c=relaxed/simple;
	bh=1GaNNFCtknV83Jv0cqtYzHzLamBzWC1xpyIlAkgm43A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLK8x0+mGFNAYZflCZ9W3E5tPbcYgeXiq1y4uH9a+5Zw97oC7qiMqsYUMv9utm96jxPn4iyUzGhYqnQnMusH+8pm7rZeFiBt9Oy6XNqkEpHboAs0Mw+zmcD/WaQauUT3IxzGtRZoY/9KO5kCb0mpEXlWxDjx7gy13Q921aL37YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/+PRojJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8311AC116B1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762182705;
	bh=1GaNNFCtknV83Jv0cqtYzHzLamBzWC1xpyIlAkgm43A=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=I/+PRojJO4YN8h2bvBzoZeo7h6nDwnL4uefQQ0bkGpg0hgJyjWPTgYEx6AdTd5QJp
	 AzTwDamL3PBHLQjiuApsSqieDLII7glvyihzMk4QqVa8TnIkan+uP6eIyG93znND1+
	 JKnVe9R3de9Eop1zv8OZPMzRuOwAY+0r03H93pkuKe5ENGc7xZJRuuWxc1srof2LwV
	 IsH/gLKF8vbbaDS5nBuB/cQ4B+Vg0S9sh5SX7jr5o2T8L59JcNXvBB/PSXOov+iJbn
	 ian9DlT39jN7IPbmsG2kDWdTkVBFssO0Od9kxeNeZWuUZ+onjLjiYNBZoN9FmlT/9s
	 jEz2SSuoi4pkA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378d54f657fso42967041fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:11:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdvYPMVa2Dmdx92Dy5AfhhlItabr/6hfvH6Cm4gyuVvek1aLhqvMeb4N6FtiR29vmbQp5tcSdtHo1OTFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFX9NQpSQGxd+Bcc1Iw89Fq1+3fZ6C6vJyZIp34GOFXpoS9gId
	D67PUNnKN7hJ3pxBQtU4O4AUogptIZyaBzJh/mne8/041vrrYUWXGu0CkOGUhltr4MNUwbyaowy
	PnN7R/Jm8qRwZ0W+4Q3kuxJIsKfZAdVU=
X-Google-Smtp-Source: AGHT+IGWElttgB4rVGH++HgAV2+aJjHaHeGIca+Uf5ByxP1uF8tUjDilXB/buasyrsMUHZXVPNFUTSxNQSiSwWns+Qo=
X-Received: by 2002:a2e:8848:0:b0:36e:21a0:f212 with SMTP id
 38308e7fff4ca-37a18dc65b7mr29472661fa.29.1762182703902; Mon, 03 Nov 2025
 07:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-23-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-23-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 3 Nov 2025 23:11:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v663GuEnxxVK0v+zOJ=p_HbqmJjFhP45_9FFvhAtenABPw@mail.gmail.com>
X-Gm-Features: AWmQ_bm-fOqGieMMsHUhvs-YpT1nnfXeuYJQ_6Z3gI_-gHcMItjN5vkHcjHc7cg
Message-ID: <CAGb2v663GuEnxxVK0v+zOJ=p_HbqmJjFhP45_9FFvhAtenABPw@mail.gmail.com>
Subject: Re: [PATCH 22/30] drm/sun4i: layers: add physical index arg
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:24=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> This avoids plane mapping in layers code, which allows future
> refactoring, when layer code will move away from accessing mixer
> structure.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

