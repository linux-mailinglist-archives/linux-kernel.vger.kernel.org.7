Return-Path: <linux-kernel+bounces-765527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B874FB2397B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015436E5372
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330922FF15D;
	Tue, 12 Aug 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYnrnmDQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA02D0607;
	Tue, 12 Aug 2025 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028808; cv=none; b=JDk83y7JTt1QMzUeTD8hFdZVw01qAi0FcBkHBrdoCTZ0P4uVM5G41jzwRKhzf8q2O+ERu/cIHZgyV9daFxJRdX+2t3GOh5f5DDqahA6aTAXGdxR9Yddo5FewPzeCzGKs9jmwQ3aG42Qbpu8Zz5IO0MT0ANgLYs3Am6G0FjOZFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028808; c=relaxed/simple;
	bh=GzE/fgPQej2FTmYMnJMsxMATwFl8iRmRP2ZrYIoscBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IzL5sWFXUAqrjRgeNCug3hT8JGMd919VpNs0j46fNRgW/nQ+sm5aqbvjJ1Lwrrxzgppi6TOdxDODe94xGKxkOstd6o3RltdG6UYFpjN42p9WNAY3IbU/tErQmPsoamCbJ1WTnB9uZZ/e1fd+NZ7zH3UnSO+wngIkaWN8VY1cJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYnrnmDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD53DC4CEF0;
	Tue, 12 Aug 2025 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755028808;
	bh=GzE/fgPQej2FTmYMnJMsxMATwFl8iRmRP2ZrYIoscBQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uYnrnmDQdTRfYQS5s+Yv0cTOYj1BGESpyMf7SD6LHeuKVczrf7ExRQpGCqJU9Kf12
	 eKvPh6g8EOFWn2tg7cKLYqxYc9vI7YKea9V2kzWHR6UBNUE8Xv/FbMdTWETMNZSXqh
	 x4JjU1NOFU8uiLlKsRscwlQhw+gcVQPUhOCYCxkOqtwOXkLDF1ciDE1yVPJ2rv9/t8
	 Uk2qjD1Qlf+8XLQ84nX5Onkb9NmxqzN7311GXijvWcyil3W132u8CBvj5m4ji7C4ho
	 47yQUdx3szHLbLIhhzkbptTIQcDsElGctKMQQB4Icv1mDcJJ8wqP0t6fYbQIlhO49y
	 vHqJJgj8kGuOg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 22:00:02 +0200
Message-Id: <DC0PSDBCPGVO.38EGYXRFQVM8N@kernel.org>
Subject: Re: [PATCH 1/4] rust: alloc: replace aligned_size() with
 Kmalloc::aligned_layout()
Cc: <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
 <Liam.Howlett@oracle.com>, <urezki@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250731154919.4132-1-dakr@kernel.org>
 <20250731154919.4132-2-dakr@kernel.org>
 <CANiq72mWVmso1yMYGYih-NDwjB9E1iVE=_oSpPiSvqTu5mkE0g@mail.gmail.com>
In-Reply-To: <CANiq72mWVmso1yMYGYih-NDwjB9E1iVE=_oSpPiSvqTu5mkE0g@mail.gmail.com>

On Tue Aug 12, 2025 at 9:52 PM CEST, Miguel Ojeda wrote:
> Did this need Cc: stable or was it skipped since it is just extra padding=
?

I don't think so, it just lead to pad to the alignment for Vmalloc too.

Technically, this makes no difference, since Vmalloc is always PAGE_SIZE al=
igned
and the size always a multiple of PAGE_SIZE.

However, the patch is a prerequisite for the DRM device fix in patch 2.

- Danilo

