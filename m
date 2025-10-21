Return-Path: <linux-kernel+bounces-862155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13640BF48CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 021D24F2167
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC34224245;
	Tue, 21 Oct 2025 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwFsJy/X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B51A3029
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018801; cv=none; b=KHyNYwe+zxjvT5NVvdy9RW5ddqfcwcSkDC8Gvsf/Te0fzKuJ1DjU8QrPaSHBKsK8LrkJc4VqUsTSkIxmUpem740Ausz1LugGBbM3bIi0ag7KAATewT+OyguNytpt+M7NRGE6BYCGbQ2p/A5CxmMMF/TnyLbq3Xz2EXWpASE0Il0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018801; c=relaxed/simple;
	bh=megv8kjqooQLM1LiiG/kSBFGq/XM7K7Yev+NGYD2q24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4d+Ncp93bPllbuwpobYA42LPWNwXEDM5LBoWULPzEFMh07jOT2fZ1a3XzZGsoHgYbYq9PFvASA7uXep5ezjhMQt1uzMnuSXvVJxKj2XnFNCsjJzWPhqGeocM70/1MYgC2u2j8xWdmr6NpQzFKhJggGjuU69Nl9eeUJU7wpiFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwFsJy/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=megv8kjqooQLM1LiiG/kSBFGq/XM7K7Yev+NGYD2q24=;
	b=KwFsJy/X3tYf+Mq/nq1qcWEfmfHyFpGRuj1/Mfw8vHKlBysiFu8GubM6BPa4Ob/zu/Kn1A
	P5mohyLXsXtzkM+sg9ZM6jCW17+Guuv8h/3SP+WPCrXia0uVmT9fXQw+eYqzS1OGIzHmV/
	b3Fr2STyhftFFCEHz4EDvUL0Zlw/LvM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-q1j9oEPAOyuAFqEd1R6NMQ-1; Mon, 20 Oct 2025 23:53:17 -0400
X-MC-Unique: q1j9oEPAOyuAFqEd1R6NMQ-1
X-Mimecast-MFC-AGG-ID: q1j9oEPAOyuAFqEd1R6NMQ_1761018797
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b522037281bso3249300a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018797; x=1761623597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=megv8kjqooQLM1LiiG/kSBFGq/XM7K7Yev+NGYD2q24=;
        b=xJI8pgHFwnTAM+NLctu8BLIGpQjU3SRLvD+fvY5Y4mwrel6wZDBa9AkP6yqjJjtOVQ
         K9FYW6o1BpePT7IhpHzyOoRju/N/kGB8KsX+SbOEaNNVISLJ4W9Sw27exZDgsKIYMMol
         w3rVcYC5nvlJlxs2m5UddTkMnW8jBdi6Anyrs0YyEwNVrfTSdvQRdA9hTibTkec4cWrQ
         oLAneMYKa1flBy+O1IPRgVruT7763sAV53kQkuwvGphTQDX81vRKbvVMEwMZiYFEaVWC
         EtwUbhDjLJUnLWXGoylKKOksV36xJgrJZnlvZn+rqOT8aQeojL9IWFnKP1ZTrgldej4t
         K+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVHfAt3CSqZ+m5n+XYE4qjVVsM3DwuezRfSHqJ2TlO+8IOgSlNKmx1hq9tcMuTiVnaUGydgeafXPbI6O4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpFGiNlD+4IE/IhoE3pSdCzwBhtU3ENYYQJWrIXk4BFax6GBz
	12cslvTqnB2IfTIl4cwyYPZ+OBCtQCc6kWvFR6NxB0ENdc0m/3otet+sCMa8oCxQ4WJegmbgxTX
	mT7nVqesDMTyPx7HW2xXdlWPNSxAE4aG9jYrXv2015Ve+mBGFltDj+p3fxZuVFkfbjs++/Yv0Ca
	PYljzhal3bYg5we4VY9S2CPCsrzXc2HcYZEB6YUuLj
X-Gm-Gg: ASbGncvWfoD62eQQ0VQ3B261HzwKZxVCOWvvl0MMR6ehxZ9mztX6b/f+7fpg3iGMAZI
	qmk5SdJnXmFH+FTptdAYc8lBWmYoHbIq0Vi0xqD5L6MZYSO+jjDrWcf157EmzA1B1F9BuFJZlTw
	jjb5XcfCKG1VXto1zQBHV646qEX6z0Mh6RPJRwmf1JgLI2xNV+fkefDkBB
X-Received: by 2002:a17:90a:ec8b:b0:32e:a10b:ce48 with SMTP id 98e67ed59e1d1-33bcf86c996mr22095233a91.12.1761018796675;
        Mon, 20 Oct 2025 20:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi63QOhdHl4+reIhpkfkeZ3DFMCEMmLNOYUhqCbJ0GGlA69CO3fwpDd+0dlzdH1WDw4MmaLl9VyqbUS+6tor4=
X-Received: by 2002:a17:90a:ec8b:b0:32e:a10b:ce48 with SMTP id
 98e67ed59e1d1-33bcf86c996mr22095216a91.12.1761018796279; Mon, 20 Oct 2025
 20:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-13-jasowang@redhat.com>
 <20251020121235-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020121235-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:53:04 +0800
X-Gm-Features: AS18NWBgdkWVsfyCxmNXmG3s1Y-9ydjIcrYq3r5CHZCpP7XV_l0SWs9P9nh4UAA
Message-ID: <CACGkMEuXrVnO_TdVrw5JRFeBaGgW0U_KEWMcktj4JtBgNH9VPg@mail.gmail.com>
Subject: Re: [PATCH V8 12/19] virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:09:56PM +0800, Jason Wang wrote:
> > Switch to use unsigned int for virtqueue_poll_packed() to match
> > virtqueue_poll() and virtqueue_poll_split() and ease
>
> and to ease
>
> > the abstraction
> > the virtqueue ops.
>
> of the virtqueue ops
>
>

Fixed.

Thanks


