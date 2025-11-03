Return-Path: <linux-kernel+bounces-883449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A398FC2D7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4918B34A38B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D112EDD71;
	Mon,  3 Nov 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l64bn1uh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46393191D2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191212; cv=none; b=rYynBvXE14/9QoLrH3O1cJYm15TgURcS7vSUpqpgqcBjr2KjoGu0ch8/K0RDxCTRn7hhY3dK13c/Lciev0/Ifri4gLoDv1fJ2ki+aMOyjPHMFB3sJd4CZ8eYZVdEMisc4EglGIZmklkrU+De3USZkHxl4iz2sMn7/7NscLQH8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191212; c=relaxed/simple;
	bh=+o5dV5iJcb6acg+vuRYXWjvoxYCIxuxArBBgYrKL5qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzKP+azfDlxo/jIq02RETbqU7frO3V9PAlNPke8/zFU8fEct54dk0jGwftPW6sP9CvN0+2m8w7e3I+SYhPhbIu1z0sSg6Cm24YCyeFMRfqm971TJvjAIVzlewIZn+f6rIF4FSzjWMiV02wVoIaWWWV4HuQ9B+mz/EUnGoDBXoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l64bn1uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73409C4CEFD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762191212;
	bh=+o5dV5iJcb6acg+vuRYXWjvoxYCIxuxArBBgYrKL5qg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=l64bn1uhzi4UXNLPwabx0bXjOyAkO9VVfL0LTdtFR/2gX7cNFuxjdk8tlJHEMHpyM
	 owLu67ClCwCfmon160zMBZN1i+AStX68zSifyc49ftP6AKQnREwma9qBU5iB1lNU9V
	 16vZhgTAVAA/uuZRiWm6J8hR8zpZEqyVMOUJfKLNMe+KK9VNvR+MyORJ3OnJrCl9QS
	 P6P4/MfQvzG7x0E0bAAoNX5iHdEHDxx3wQiGF2s/bnV19PgVmeuSMHc5as3RajIj/l
	 THOP74aC6hSLmKPl0TVEtuuJZN+Nyu95idQzisimIplPIKvPC/3rQoOMfciCDKHKzW
	 Z8VQYd2IIwA2Q==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592f22b1e49so4288376e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:33:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU++m2w95XbK4fmOTg0KLD5+piTIYAwD5B7pfqwy1UIKq1FrxibCeV7g0C9tGpXZ6/MjMU5sNszpJkPaF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSGxmqj9VdVYYPuAePj7L70/Es6QrtaAgrFkUxrDWRM86Vmkr
	mDSFVCc/CpiGWBm3ou1HqvjwZg+HGHgTlFwBVeopK6Dpcf5sm+OQWaVU8cULI4aP7T2Nd0jFYUw
	cvlQfXIUo5ocIRXpjEsGZ3xHhLxACrIk=
X-Google-Smtp-Source: AGHT+IHeAV6gvUZakhroG+cdQ4cS//FtPIAPmnBlEfHgFaH6azoAUjYMPV9zLQGb7u1TcrlPCM1uYxkpaGVsOmKJEms=
X-Received: by 2002:a05:6512:63cb:b0:594:253c:209a with SMTP id
 2adb3069b0e04-594253c245fmr1658107e87.14.1762191210885; Mon, 03 Nov 2025
 09:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-30-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-30-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 01:33:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v66+oGwTnu_wtLwjcR4R6Owpb3PY5YTAoN0VUReB5+JePQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkzN1dsVffW7_6vHF-fIc5cl498aftDpvEUp2fdEJedEOeYbOYD0a_NxwI
Message-ID: <CAGb2v66+oGwTnu_wtLwjcR4R6Owpb3PY5YTAoN0VUReB5+JePQ@mail.gmail.com>
Subject: Re: [PATCH 29/30] drm/sun4i: vi_scaler: Find mixer from crtc
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
> With "floating" planes in DE33, mixer can't be stored in layer structure
> anymore. Find mixer using currently bound crtc.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

