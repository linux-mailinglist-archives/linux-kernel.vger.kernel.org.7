Return-Path: <linux-kernel+bounces-872184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93779C0F7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25A384F77E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D4314A79;
	Mon, 27 Oct 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEgi0eJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0931354C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584136; cv=none; b=C5RtVmIl1kjCpUuNoZif5W/SVP46zdfEHGM368j5GhwPJ4WJENNLyDvPWSQ9pnUyWUMECocYW0pm+Qbsa4iCdSo8TZYJCbBvO15NimIn0yek5kYyrVE2kCdlKlDhOw9qn3Uft3wWz1mp5iAe6XouIbvZykNqQ3yAT4jbKbUqJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584136; c=relaxed/simple;
	bh=KddKMVM5wd0B6J1q1MLWD60MfPMYXHaAJAvI7FQnRAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOTjs82MG3LVAw9YAKrD+VTAJg/x3TmwBQTTFifSBCVJmWvFcLXVg9WoYJNcNqUhwMLxD7DudiP1ee1bVZ6iqQmePmjAWw6VaN7gAh36VXpe3MSB2Bc+QPe2iW833u3+yoh59qqvHzoKMk49Hgk1LRmwHgvHmGEGi/ze+4T7s/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEgi0eJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99085C4AF09
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584135;
	bh=KddKMVM5wd0B6J1q1MLWD60MfPMYXHaAJAvI7FQnRAc=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=OEgi0eJbG5TcR+9LSQwWgmXDBAJ7OpXXhNUs0/2rA0ViWXyq6yyd6gYVyP9h8BbZr
	 126ppYrbnahjMz7WjD46RZQndMzJeJpIZMuRo7F4LjIkSbNfSpcRh5gu7oIOxFmRv0
	 +7qdo63pj8NWI8zknqj0Eq9lMBG7MmXdzgWPjN+r48PbJHSRGc7JoaA5Q/Tgk5/CFT
	 UF/XUvTz0fyJY6uCVzPqxlAbCHIhG1ri3StqZCZBPI4Vrw7SSjF0q5iOGvLfvI1JLv
	 kQEH1CTHFhffVT9SduHwktYAN7AuySBLjEAZHA4F0Mn/kqPuPIO9Zsfy+jL/W0pH5C
	 hnqCiqBjOTpcQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378e622e9e3so43335731fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:55:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzixjDqumo9bQjbAvY0tR/o7voqq9AmmmYfKnxqwAbM/Q8LFnBlDSwZ7z175xzDKcRZrcf+JTJgyBD7Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcKr3a5h9zX6RhDW7NNICQ2S48QCQm8zB7OtXRAFTPMyVO0BL
	W7N+rJ9FCdbw0z8VJsTSDva6l4yfZRy7Itqq7VknP33chh8HbZDzpyjXS5VC0ETWBScZAvqYjON
	cW18eO1klWuM9QfC9K9RDk34AqA6Ulgw=
X-Google-Smtp-Source: AGHT+IGwv/BQ+++SBFxYYP2GD7RTs091hoc1u0QU8IvYs61A4uKZ+F34EWnDa2h9Kf3sdYzwjvjhGmCCjViKq/p155s=
X-Received: by 2002:a05:651c:1444:b0:372:221a:b124 with SMTP id
 38308e7fff4ca-37907b313edmr634581fa.0.1761584133992; Mon, 27 Oct 2025
 09:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-16-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-16-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 00:55:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v66br9q8S0uVOoUsPoMOHxXnO1UExhs2PhbbuFYqhB9-kw@mail.gmail.com>
X-Gm-Features: AWmQ_blFUa5jniV5lL0-JsOEEq2milyC58nrIxK4tO0XvnhoJRoyHMfQHehc-Rc
Message-ID: <CAGb2v66br9q8S0uVOoUsPoMOHxXnO1UExhs2PhbbuFYqhB9-kw@mail.gmail.com>
Subject: Re: [PATCH 15/30] drm/sun4i: layer: move num of planes calc out of
 layer code
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
> With DE33, number of planes no longer depends on mixer because layers
> are shared between all mixers.
>
> Get this value via parameter, so DE specific code can fill in proper
> value.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

