Return-Path: <linux-kernel+bounces-883451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95CC2D7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E393B6DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F831B810;
	Mon,  3 Nov 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUx4q78T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5A3191D2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191265; cv=none; b=j7d5vHZN1+4YdJTw/oTYxORIXtKKBniJhcEXXtP1COxBM6XVO98uE1fF4N2VN3+wxqFKRnv58g3UA3gwsYWUlOU9rH5MLL2lZhYR5FkCVOS2i7U0y6E/v9qgQveG1pgTXGNCysleZ+zxvCpNeNB/BZMhUjCSDJYG3I/l4r7XaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191265; c=relaxed/simple;
	bh=U+aH8lUB+El5hnIWJORr7k8qBwm8VSBJwZFvW25Fg/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GX4qgVXUwJgq624JR13aGvLgnKTXbG5Z4riCHKy8p1m9r6jEioTIBh4CyRiOZLKGEnUFyFctK1cnksdFXRO0pS9LK879mcoOc5zFJrI1+lkysk79DlJpNpwfeYmzz57sQJB9TKZ4a4o0pjosqFZO2uIWvQoLYDGb3JQdzQ2LXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUx4q78T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3A2C19421
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762191264;
	bh=U+aH8lUB+El5hnIWJORr7k8qBwm8VSBJwZFvW25Fg/I=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=tUx4q78TJlms91B8kVH3OS4mBEXWsvYo6gIgV6Y0heRMq8vOm1cDId7gsHmz7W3tE
	 7GiOz3MF6wlKLkRekNZ6ukVR+qYIJP7pj1+1I+C0fnW31LlA6+pgdgbsu1yqVjE6lO
	 bvjS/eBSerrLyAuAqTfYt/Jm0i0W3o6czTZv7Ca+Eea98ojf4VLlcwUKvJpLKTQR+W
	 n81B/gcvOWkCN1B1qUtJ1ul7lv3noAm5/SH0L9mrkqMLY/tBb/mPjuKZcG2t902EXh
	 l4Xsnxt08jqN5XmqKhFuD5XCXr1TRB1nQaD8aChq4XcRvAOuYvyd3fS0LpCKAQlOPK
	 kksI4DjMOPIUA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-376466f1280so59275491fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:34:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVAz4CXKmUmuZ6WdfXQpo4uDLd1rjMQN4KhmtYEhScEyJYPR2SIK/IxAsvxqZsxWOeLcJHGJ6JQjjZkHEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlgL1e1ROhmTB70+eLseDhMzHRSrijsucJZkjruUQJSOYQSYi2
	W+bxoHVOwWPm5VYVeBlKEx6nxZ4anZSGSD86Ltp76uWYiRioveuiRg3+zhinn2VmTUjl5Tqrp2J
	BOp8PJ1WQ5mUYGt8i5uHpfcyY6axNc4U=
X-Google-Smtp-Source: AGHT+IEqIvI6roVKypuJ/8lmOG6ruLu/sT6I8PoGyCI0UGJODSsC0TE29OXF/Zmg59uD8vy8TPsUZtJtVFNrzZBQfWQ=
X-Received: by 2002:a2e:960f:0:b0:378:ec14:f79d with SMTP id
 38308e7fff4ca-37a18da804fmr30699451fa.22.1762191263229; Mon, 03 Nov 2025
 09:34:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-31-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-31-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Nov 2025 01:34:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v65v3_uNohrH6PgDaRdVcKzEL0n824kqxGC+m_ZMOjLiNQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkqC2MlJ3l_GaAyIVAX7lpWibpo3rNv2SEIDf6NmFqmG-ysp_S5fUsi28A
Message-ID: <CAGb2v65v3_uNohrH6PgDaRdVcKzEL0n824kqxGC+m_ZMOjLiNQ@mail.gmail.com>
Subject: Re: [PATCH 30/30] drm/sun4i: Nuke mixer pointer from layer code
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
> It's not used anymore, so remove it. This allows trully independent
> layer state from mixer.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

