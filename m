Return-Path: <linux-kernel+bounces-872274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84316C0FC88
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70C8188BBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149633191A8;
	Mon, 27 Oct 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX85SV5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8D2E5407
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587457; cv=none; b=ikSkQVIeqQDBHR9K2uepvaNdQT8QAD2+FSIr8NyC6YFK6TeACB9/uMdcK8lRdhBNQGs3IRrUyXnRKc2WA9qAciuxWrKqQJiBXiJshMPBSV3MWvhhwxaGo4wr3FUPJuFPt9CJjicHAsgiU/kLAUN7CeN29YiZFQiDfCBBMPxevxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587457; c=relaxed/simple;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB9wHvlJLCGxkbCe9cp02qkGWFjIpwlSofDzK9ujt1/nhZ9S2TOlfr91aThBjECyaWiIdU6AvqovEKLxJXGpbDZUdATbLLuAaFbUZWF+Enxc2ztT5eDZSwWt7iv5nNepFaWa3JNK308YSVltWI79NXmN8BHpcdp4ytrFiERU8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX85SV5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10234C116B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761587457;
	bh=jc/356FpIO5fq3wbVBLhYJF7QyfRlww33yCqXERm6yM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=QX85SV5IPfGzOsBynpyHwugp0CyyVgKShCIr1Q7lnl8ZklOUGkFlOBFSI3nTLg6ke
	 9ertPoek6SjQirRqvnVzkKMldV1MdeybOpXHGbkwvNOGArQhDZ8j+P9JxYNn8lu8Qj
	 7eKET5JcnhsKQcC6BGqI8hs/20lU8/T9dTksPA/K9Mglk/SbLStYe4qfDVJgH6p1MR
	 iubxIkr7EgXHfMYBH5y6ivTOPe9YPaZSwBsc7kZ4zcsFa8sVisBEgvUru5dZNdkBAQ
	 pPtjP+qGBaSnuJC8BXvLVHeXqKPzT12/1o1WVtLvEvWF52VA5X1r+vJFynid+XEQES
	 3UJ1dApDTm3xA==
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-431d65ad973so21080595ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:50:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxZ8RG2dC0eB3dXV/kikGr4s4Si2pminkfAhrHV412Qp3FoZkewgFzw/eYMq1zxPgz1kv3Pj8guOSBfok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDfsSbI5fXIfsz74tMLsQuFl+P+w9D4gpJ1lDUaIFtDxC/+jH
	wpDpS0QkbBbvpmCs0reMqCYFrJWzmOX2uzNtFMwrDj21cN9e11sfXeS6c/Y8ddAVSI4EL3hCFZb
	gmGqkEMD29dhfVC9Mlwc9DPoBR9PxRLM=
X-Google-Smtp-Source: AGHT+IGnc89exOTZE3mKHcEYS+jts1LyngerTZI24ol1+00dieJ+BnfWVo6DyciMsJbIRCI98YsRjlcZ+jytqeDhnWA=
X-Received: by 2002:a05:6e02:1c06:b0:42e:d74:7260 with SMTP id
 e9e14a558f8ab-4320f866607mr12752885ab.29.1761587456395; Mon, 27 Oct 2025
 10:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-20-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-20-jernej.skrabec@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 28 Oct 2025 01:50:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67mHaxFAZ_OtPoOfoKbV8x7EFCAmhiq7D0NY0zdRZ627w@mail.gmail.com>
X-Gm-Features: AWmQ_blzThNj1vSmpmbdGuHWVfAbSef_0wIVgxBtON1FA8iGGT9ZN-SnXracJEg
Message-ID: <CAGb2v67mHaxFAZ_OtPoOfoKbV8x7EFCAmhiq7D0NY0zdRZ627w@mail.gmail.com>
Subject: Re: [PATCH 19/30] drm/sun4i: vi_scaler: use layer instead of mixer
 for args
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
> Layer related peripherals should take layer struct as a input. This
> looks cleaner and also necessary for proper DE33 support later.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

