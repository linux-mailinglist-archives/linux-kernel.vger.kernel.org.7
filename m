Return-Path: <linux-kernel+bounces-883447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C2FC2D7A9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B79D4EB335
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB331C58F;
	Mon,  3 Nov 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbC7Vn2l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B231B81D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191127; cv=none; b=KV+f9Hx7o9UfTmtG5irllEWb7iMXq2EojEBsEMLhUripX6fkyVu/TShRM+Da5Oo8H+Ua5vt5TGLiHT87SQ7lz3RbevQFuWIsSyT/QdKO5MlJZu6gJvwpdDfAa4nxWyNjoCf2rjVzoKrF87iCs6go0eqMPEYZKJA8n1wdYXJcL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191127; c=relaxed/simple;
	bh=3fRrsqvpg1Q6JCWfd2TcBUF0ojUJZfugzjbRvfHErgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWuhjXACCiOiS/t94B22DC0w7r68Z8kanuEbRiyRFkKPqw5MiJVC7SKOfuGS7LgfP28pXAbR6aRRMGFYTupLBAcF+JSftTUuB3Tofd4kJTf7tOAV9oTUpabdEcnu/MIcmpQQO5973gmpiV/FZ0HgTLLbJ4/MLk7YpliFis7iOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbC7Vn2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5184FC116D0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762191127;
	bh=3fRrsqvpg1Q6JCWfd2TcBUF0ojUJZfugzjbRvfHErgU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=qbC7Vn2l1XVkEmbWdOLCxZ9QlnsD6iVlXEOqjhnQoDuyIdu57Q0yPEvT9k1fGGDE0
	 fFUX6As5NT5W5+Lphtv9vA45c9gmC4XtCj7ScBUv1pv+i2QTbwzhBPFTWOxjAKXnxe
	 WC4AaeZ4k7y9bAQKVbeHpIH8ucC+a2jEqfw8VKCdyuN3OnaHRIVNE9VSltHs5PV4pS
	 3EZytlnUZUtG7TiSjVZFq7mLIIXCMV81cV7I5TpwQKw02FFIePxgBVjUJv+HOVKcTs
	 uWdXdeCrFhB1Shov85+kAht0uo8lz8xBuGwCxDUrOaz2weuHm+BQjYj+58FjKV9tP9
	 UkMgZUrN4acug==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a38e56dd5so8543231fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:32:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyLOx1UArbMTSIllz8GV5fObeJC1lXAIE4IqpgQ1eMfOkbzFDbCSMaKdNswpgHYyE203T1Mmo/5e9YCqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6u3P1i07hOi/DR5/jqkN1zQ6q8/oU/z/ZxDjuOpM1d+83drQ
	hk/Szldy0/cHQ9ab9O7G9DYwlunnD71Y5paDuKvdhZ7ve5G83W1GSEaVzG4PRXRKM1xMD4e0pFD
	WqbUNoulAgzolA6oSWopbt9REKgE/3xQ=
X-Google-Smtp-Source: AGHT+IFTQffhb5i+F71J3LOhF5jx6hQRYOqxomHkplL/413quHMbU44WrYZZRRChAb5ZISTcoMgWobqdOxBAKEL0T+s=
X-Received: by 2002:a05:651c:1c8:b0:37a:415a:1fb4 with SMTP id
 38308e7fff4ca-37a415a2387mr3245231fa.0.1762191125657; Mon, 03 Nov 2025
 09:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-29-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-29-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 01:31:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v65btpVvsJV0wJ1zNgyej7LEkd85v7ivpPp8ppzuDxUkow@mail.gmail.com>
X-Gm-Features: AWmQ_bkXFHKrewU0eoPao6ZZMOh9kve-I6lS6VpRvTzlPCKA65lorBRFqLDielk
Message-ID: <CAGb2v65btpVvsJV0wJ1zNgyej7LEkd85v7ivpPp8ppzuDxUkow@mail.gmail.com>
Subject: Re: [PATCH 28/30] drm/sun4i: layer: replace mixer with layer struct
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
> This allows to almost completely decouple layer code from mixer. This is
> important for DE33.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

