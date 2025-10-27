Return-Path: <linux-kernel+bounces-872215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD2C0F99C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF80462215
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B913168FC;
	Mon, 27 Oct 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqZr+eK4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BD316905
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585312; cv=none; b=dyfVhiczoVsLGIgrPmIfVdb4VKtm8l/p28Bl8Gm9Wy6967AUulxv6/8hhRdB5Zwpl0QgekcEfBPClLWGzwHPcrO/bpv2z2eWpGkUG0zKirqy2F4h+ZdbSZQmmho2oSWbqhO4lUI6TIltgHdlyo11FpFgasZHH19SwD8EVHm911M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585312; c=relaxed/simple;
	bh=n10NlR5AQZVuyebRk7B2SUL8HffpvVGuK0dPunXc6Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFpOKdAGh4Ydj0/ScvwGLetZ1xuSwooTsmA70mbOxqdFX266ZTnMBMsSCVdltUPdxzmrr2KhjFfUFJTOmcQRNbVxH9CGqRYK9utftmHvajmWLJLsZDdpQeGrpbbztMvMlFLtSdaiUl60wE1cz3cqEtTIWU3AdyS6tkQnnUSIN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqZr+eK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AE2C4CEFD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761585311;
	bh=n10NlR5AQZVuyebRk7B2SUL8HffpvVGuK0dPunXc6Is=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=HqZr+eK4r0DzyGqvmeYi5mqxzyyqHWBykNMpoMfE03X5z6pt5O8eOzMRYd9U8ZUQh
	 eYITan5jDOYW+kPveVqXTdkK4/68+CF7oh5DF96MzpETlIk0uh4aLwwmhsahp6rIJn
	 hb9MZzElerUW3qdZGtZinkVPXmRKFFox7+oXIB2S4M/pqJ4Ql57IqzMoKRgUaT6FkK
	 jOYZyLvn00EyjpiJgUwyHOibmTJxoa1uwMGwn7D4dhkQA2/m62ejGggHXJUpSlXPII
	 kuefpXpMvSLts30670r1p/D5DybsVniH/C5X0jaqa2xC7Rx2pLw3QgoPR/rDlC8ft3
	 9Jha6fJS1+a+A==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430ce2c7581so21427955ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:15:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqaOouWELuh2YwmFuI3YcmPFKElFId/WsVfFiWDbzaW7WxFjQGJZzl4LXBqOycM9wh/X4SHtUE9Or9zQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78/H/CYV0vzp4fC0UJliV7kO3P5FNqTLia6Ut+HZu+FQFEoRH
	3QwGJD/NE82CiTlzsw1MCz2gozjq3xEwuidj5i1Y2ymf0i7BZkbSTQtY638P/Ved7Upc1e1g/H6
	A8c44N9HbUtTWyJ398vob/y5C3C4k3yw=
X-Google-Smtp-Source: AGHT+IHX7Cu0cAsXytC3RTDyLGsbQ6D3nuir1yy3lnzLJPUDYwnFPuEpRZmXHsx20REcyJQHIoGh74zShF/YlLRFw2s=
X-Received: by 2002:a05:6e02:1686:b0:430:a4ba:d098 with SMTP id
 e9e14a558f8ab-4320f6e72b5mr13684325ab.14.1761585309545; Mon, 27 Oct 2025
 10:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-14-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-14-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 01:14:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v654iKx+2_GrFAJYF0VGXSd=ssxE6UYpN3jSAspEC9t3LQ@mail.gmail.com>
X-Gm-Features: AWmQ_bldcoQqUG3m9k_m37cYhHNBmzCyQWdekxIPdWuxn4IqUUTfMQc9GRDtYCo
Message-ID: <CAGb2v654iKx+2_GrFAJYF0VGXSd=ssxE6UYpN3jSAspEC9t3LQ@mail.gmail.com>
Subject: Re: [PATCH 13/30] drm/sun4i: de2/de3: Move plane type determination
 to mixer
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
> Plane type determination logic inside layer init functions doesn't allow
> index register to be repurposed to plane sequence, which it almost is.
>
> So move out the logic to mixer, which allows furter rework for DE33

                                               ^ further

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

