Return-Path: <linux-kernel+bounces-864078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF4BF9DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32311188CFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328C2D2384;
	Wed, 22 Oct 2025 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNB9+QYw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B52D12EC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104531; cv=none; b=NnVHp026rBlhvhKEMaCvQS2gwo5ZmYsRlU488OUXfXd8DkL+7DLteAf8qpkPtYM7PeCwaUrA5J+2F9L+HWviBfgWkNHd185fNVgTcB/P+Pm1NcVqEuiNid+YC7aTXX3q5F8tgJskzp7bDhoHPNxEKrTJRvdKa2jmIaSqamH+cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104531; c=relaxed/simple;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJ+riZgFmukxI4SUDBMuRdOiEUCqRx8dI6MR9IrAfZUuI0KTvs4B69EgMaUoqY89y/FFdRoSRUxoGsz5LA0rQAEOMR42xTipj34hw8QVExYuHZFKFndPWhfvwY7ZdxDG7Eerrqxb2d2KwnRh/INlEbPkoqHDIy65APmJHc/fk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNB9+QYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761104527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
	b=HNB9+QYwU/hlwidmnzylFJwkl3Hbs8qwdnHmEbjOoKJ8jm//jgjEmuZ950FdD0S0EGnrIo
	ikwOO6M2180DUg0r/7k01YNIfO3FKCSKXPyDoDZB+wbusqrGSRPSeoO0ef1Z0mvWXxEEjP
	IGLwYzq4DxYHVb5ukQOeBXLut/+3c9I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-fDMU42KHMPWlPHaVdzrCCw-1; Tue, 21 Oct 2025 23:42:06 -0400
X-MC-Unique: fDMU42KHMPWlPHaVdzrCCw-1
X-Mimecast-MFC-AGG-ID: fDMU42KHMPWlPHaVdzrCCw_1761104525
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so5758313a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761104525; x=1761709325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMZaRHd3QBC0oWYyy9CqpnKYlqU3jX1Jp7DLd0mUWxo=;
        b=qNsxKuhxLWK+HaMUZaHKuqoMR9Ug+umQ09TP9Ur0aHFM3aD48k5jKNoCjsCVXjV1QB
         VEgi/fPVMv128sj/1+14pLw5PyuuCmjTWlGM1jvoxdAt4gGIpNgu5WM84SpgRmuPCJN3
         nODX4GBPmLu1An1WcyPC0d/4pd7zySn1gfY2LAmx+fm3C3WY9vQM5ewvHs7MLRapjlby
         NV747YCllcAk9OIVsQFp+79vTmCD3qhbTs73jx0cgaX+NujosSNLrRTBi+BYjJGQvn6/
         fDWNuV8xYjIGFg2eJdE3gWlmef85XyURjKB9cZFsUti8da5QuhfI3zmPzBimxgwRBNpx
         biEA==
X-Forwarded-Encrypted: i=1; AJvYcCWQDXj1dhyTMwMV/GpAI97vS3surE9MJQJQ7fLygCRbX4tOcUcE3f69Tuxe6/hTRQ0XJGHRAhFhU+i2SIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5FmRaHHwTS49gKo738NjYmAoQ3S226GvC+4iqCVp3EdS49vX
	ga6ppSBNJXJx2fXs3rGLMOBbSF8VnV5Zrxl8j6PfyXER98bjnUVbznozY0pREMykx7+yZyc8n70
	rYV2Kr6QMnNrmOERetrHp3doTq2BT45pqidX9iAevt9foXg/suuiMMYsXnfI3EjN58sV3URnSqo
	SBgIe4R0253ltjYdcV/0SuQzriUGHKpW3AGs5F5Syt
X-Gm-Gg: ASbGncvSDqKRM/2EYSmDFgdf8WzWrEnO2Riv25saDlcqi7SuVcIDgkUjsHuqwdtrlKT
	wpV7zxRyeCrWtjPPJkUNowKGFT80HAC1yRgduZT4Y1IUSA7++xAfSxjSa6y98vN/zoGU4Yt/mFw
	rA3CPKNVnhUMxs4AvUSAW7NXj1hVX+yTve6LoK3fVd/dO863OtQMyu
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id 98e67ed59e1d1-33bcf8628ebmr27742373a91.4.1761104525157;
        Tue, 21 Oct 2025 20:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfFJjBBe9gj2JxeQntVU5I+I/K52WZIsvD7m3axHWRDtjxyFzVKU1vVPQFwjwwB3wSt/W9MIela5+BXvbcA7U=
X-Received: by 2002:a17:90b:4b:b0:334:cb89:bde6 with SMTP id
 98e67ed59e1d1-33bcf8628ebmr27742351a91.4.1761104524805; Tue, 21 Oct 2025
 20:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021040155.47707-1-jasowang@redhat.com> <20251021042820-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021042820-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 11:41:50 +0800
X-Gm-Features: AS18NWAAJdWZmZZaokLYDDF4FQaIYsA-DM4Fq2y-aLHj75kmJUbkmf7MCRS75P0
Message-ID: <CACGkMEtUjP2UN4s2ZRF8UGV6Bb3-6oPkU50oJ0ek8qfYwxjv1w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: zero unused hash fields
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pabeni@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:28=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 12:01:55PM +0800, Jason Wang wrote:
> > When GSO tunnel is negotiated virtio_net_hdr_tnl_from_skb() tries to
> > initialize the tunnel metadata but forget to zero unused rxhash
> > fields. This may leak information to another side. Fixing this by
> > zeroing the unused hash fields.
> >
> > Fixes: a2fb4bc4e2a6a ("net: implement virtio helpers to handle UDP GSO =
tunneling")x

I just spotted this has an unnecessary trailing 'x'. Will post V2.

> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks


