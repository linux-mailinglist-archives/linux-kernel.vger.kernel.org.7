Return-Path: <linux-kernel+bounces-872179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79729C0F7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2407B4E4FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7A313526;
	Mon, 27 Oct 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwct5VBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6D312815
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583929; cv=none; b=UuC7ad+2BrLeEaZWKrKVXNiOikbVMSJaliKKcORumsLoqofjdcnw6tDlaPT6D+UzupN7soPk1gj54odG9Q28GKhYvC3uIdDFzto5Gv6mnnriLKhO1Dx6zJhUFECwB0JWhBX/WryHdH+TEpiFhYG2N03vxN3idB79r1Vpf4FYPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583929; c=relaxed/simple;
	bh=qXSUYkzcaxBwT7PR3VqEg24D+wripCaqvcwPYVLA5qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gleLdXLUbtwRUam1dccmSCklDowZN0O88w8etsrgIK6WBcO1+xIdmz0S0Yb3zYq0NpvwJpGlhRDHQ20l/o06Weqyhbt5ry7jr4Za4OpEF2Xkcm/hxf76kHHwJz5ndERfEhbRERqYqc711UvGUin78gt37onFthX0+/EpEP/tmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwct5VBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40759C113D0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583929;
	bh=qXSUYkzcaxBwT7PR3VqEg24D+wripCaqvcwPYVLA5qI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Iwct5VBPLz0VkdkDSWA+HrPfq9WSIDgOiBU1SFjAF1AcNrlIMqb/K6BJEIAGdqnDo
	 nSYm5SFwJ0O3gfuFSQuRtXlC8uvgpY9QZVV/RqPJlFRUdoiTZ0OKMcG76JmTNCyhtL
	 WbbrviiIdewI9HQpiX1ojEqgxxlwT3YuG1d1NxPvTzKPrix72aQsZI6VhdLrmi6S6V
	 FaOb6ftKOOF809X6BKto2rZEPE5roKhFJmZ0V3/pOEkikBV+jYcTxfhbXqLmYjhBzV
	 09iymB7lCmWV2jWUt2Oiacanu77v+Gm2HVuxvqIRJc/VbiYEJ3g63piplTXo9niAXS
	 PDsb9hJOVP+ng==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378d50e1cccso51576821fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:52:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIoemJXLhpyqb7uDQuB0f7ZDU+MUiQUnGP9CFloScRTJdgepC6TTAiGxXh1z8ONMBRVMc0iCJFX1h3ejc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNcQQiqnJjk7c1nw+ECjtI6KE/JbPLhpF3RQEEkVPttp6NNJp
	OoBZ+PWk9qYW4uFtxVvxKX6a66u9P5yWhQCaLlilJ+fhaMnJGnUv9HlJl2DyIazhDxSgT3yVKvT
	dhXw/dMZfWhsdkxzrflR2cvXf4W5ZXt4=
X-Google-Smtp-Source: AGHT+IFBPJYi1S4vop7Gb683MwdHCr7hm0ZlNxSJGBcGt42mr3LXF0sb06/EOe6oCAtgC1Lcmldr3eesncU595uaptE=
X-Received: by 2002:a2e:320b:0:b0:36d:1f0e:1c02 with SMTP id
 38308e7fff4ca-3790778cbc4mr742181fa.39.1761583927610; Mon, 27 Oct 2025
 09:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-13-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-13-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 00:51:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66hnO5ZQHR8US=TdCY=o2TJRgntCDFonKY4=aQi69oSBg@mail.gmail.com>
X-Gm-Features: AWmQ_bkqru6Db363dehTH0eyDlHZatRKL_5iBGTqBIvG6dXZWDY255VHS1_NOZM
Message-ID: <CAGb2v66hnO5ZQHR8US=TdCY=o2TJRgntCDFonKY4=aQi69oSBg@mail.gmail.com>
Subject: Re: [PATCH 12/30] drm/sun4i: csc: Simplify arguments with taking
 plane state
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Taking plane state directly reduces number of arguments, avoids copying
> values and allows making additional decisions. For example, when plane
> is disabled, CSC should be turned off.
>
> This is also cleanup for later patches which will move call to another
> place.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

