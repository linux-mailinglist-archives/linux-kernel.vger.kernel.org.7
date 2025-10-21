Return-Path: <linux-kernel+bounces-862154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8CBF48C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B772B4EBFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA42225791;
	Tue, 21 Oct 2025 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5FwZXNm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B01DE3A4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018743; cv=none; b=lbme63mSVsVhr+1ONqEZN6KWz9nTjTiziya3z4TNaz9zu5IjMerdQxKXrK5yUvMVzu0CrlOlJyYn42TFk9WsXWBBAuG3v6HBzpw9FgqXy/Qa/7Dh1ZwDkblMwbRZAMgk8GEpxFc1xrFrsFhIckQ/NQrW0hwq6kZZbNvAaYbsZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018743; c=relaxed/simple;
	bh=iVkOHE6r8V/HSXvgt8DsSmJrn6uXZ3xc5+jtvyk87a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNJ0t29zle9f0iNgtDBDx4B1+UU+jD4aPxNzEmE5DrkylWYPHOixlTOLOGKVjQ4O4hYeyKmEyW4oSslXMxv7fcstROa6Bsav1TCEMvWQOQ6Rr3BnkNNqEy5qYgpS8EjXpf5fSWkuC54dtLNjB3GMsKf7dT3NGHmb4jgchXA5eRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5FwZXNm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVkOHE6r8V/HSXvgt8DsSmJrn6uXZ3xc5+jtvyk87a4=;
	b=a5FwZXNmvuSwfo8Y8g5soTxRpXyA9Aekv4yeyq02gW9FKU+JWYNBD4WJO6C/znVyrxpxX2
	+xAt76XxEU2hBQ9w9Dot09WmYkyFOSO3zU8s82MLQz5cyT2QdNjccatrHz49CPkp2vHeZL
	Md85O4Rn/u4uTvHIr+IMUBN9fqMMQUI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-pS6pPweGMHeRc0LVkTeXFw-1; Mon, 20 Oct 2025 23:52:18 -0400
X-MC-Unique: pS6pPweGMHeRc0LVkTeXFw-1
X-Mimecast-MFC-AGG-ID: pS6pPweGMHeRc0LVkTeXFw_1761018738
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b63038a6350so4110636a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018738; x=1761623538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVkOHE6r8V/HSXvgt8DsSmJrn6uXZ3xc5+jtvyk87a4=;
        b=Q+XuJYushNX85C5fvWKzyVJt9E4uC5kwf5nyvOxfXzXSp/t63IZ/acGQjNkAh70Sbu
         eSoEjZIy2GgdI9nYfXsLoqeM+UvlCbfDaTG13y1xWHqso9h0toSQmY8j+Uhj1+g4G/6W
         gL5VXJ66ZGZQPoSfWs0oJy7gGW5F6EcuICvev7c6AEYsJg74fFGv3FeFnm1uvdDqcvY1
         UIccp+T9PNQcWt9YHK3hsssUa1XqZX25h2p8ezYs7zW107nc2CdIKiqm5qM4SdE2Lpvl
         9BoCGJMRN45FsmEh0WGDbS9Hx2R1hnih2EyTMfLd3Ye5FtHiGKsjV08I1PKynfqhu3/4
         fsXg==
X-Forwarded-Encrypted: i=1; AJvYcCVEuy/L7IyWEw94QICvyyU4IvuT/LPH+XlXtFroWlzIwJMhI0OIRkbAQSiETePbV6xRxrRR14ttZWZFzSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbSkHPvj/s9Z4WP7xCN0AJRYN9IP7WAu4SrD+P5/fuyl5A67Q
	fL8A6MWgFkb4w/kqsnxsCqZTi4OK8asAjLUgpCdGhfNSVoHtSJbPyyPnBd1/AwsWOmf/b37dY4/
	TdtH/seeZSx/bQ9sKHY17Ho3eP6+hCRzelk5+HO0FufbTExgEH0lxDfZEZRVM3v0WKTTCxUTxSW
	dFf2W9IlhJ8Wu0kvgd5N4DzaeIs2GuPp9UGBLD7Gz3
X-Gm-Gg: ASbGnct7XeBekaM4yPbE2MXJ7UpbYarjGribvXnnrmFv+VK9iz/oyMAnY5l0lffje41
	z1pLDL1KHlefgivWb9y45cJP6q7QMroWXcnlOnfKUY4hkZeKK9ZBnPxsKO8h11I1z0cyD150IEV
	8KKR6TPE9uj1rpHW5Vx+7/icnAkY3j9QZpdsWfZkbD9nbW7X2GDazhVkx4
X-Received: by 2002:a17:902:d588:b0:290:d4d4:212f with SMTP id d9443c01a7336-290d4d42213mr162169505ad.22.1761018737919;
        Mon, 20 Oct 2025 20:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBB/PdvbziwlczPPyCYr7kdKsMuEgc5kO5aFnH0SuRpY6ZXhjmD7d3u1YgdwWaIXJHHU8PINDbSLTyZpI1mPQ=
X-Received: by 2002:a17:902:d588:b0:290:d4d4:212f with SMTP id
 d9443c01a7336-290d4d42213mr162169335ad.22.1761018737567; Mon, 20 Oct 2025
 20:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-14-jasowang@redhat.com>
 <20251020111938-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020111938-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:52:06 +0800
X-Gm-Features: AS18NWB-g5Vdvff9aJwtHaMfAhyHzMhdHIZZitkZLVIiwHSy8PIubnL7FbKzkgw
Message-ID: <CACGkMEuZK9nr_gnkMvNti2BMt+ZPKtSpJwqoA1wPZdMDp-4=pg@mail.gmail.com>
Subject: Re: [PATCH V8 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:21=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:09:57PM +0800, Jason Wang wrote:
> > This patch introduces virtqueue ops which is a set of the callbacks
>
> a set of callbacks
>
>

Fixed.

Thanks


