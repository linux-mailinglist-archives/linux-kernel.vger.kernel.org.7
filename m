Return-Path: <linux-kernel+bounces-866125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462BBBFEF13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E793A59ED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789321F4E4F;
	Thu, 23 Oct 2025 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0VjIQzI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9E1474CC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187032; cv=none; b=D2f+H8ABUOtPv8jTiseGRo1akCJkPgENcB+LDaix/z7tNkz7pp6NU1HIkEKjNABh6v3eG1R6VjQnyTTBLOu2CcTHOT6xnzAuoZBxYrdOF7hRWmW+Wg5aYjsw4A8ntdvCtz5zYbtgNXJPUxLy+DIPf0NDwEiugeic+sjHN0Unngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187032; c=relaxed/simple;
	bh=tLELmYBjrIVt2tIe7/6pOjA4rz1yWYE0gX8fXO7gYBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klrUEPq8k4UqVXvbau+zKJZG4dkpJpzjk6sNTuvNETtllzgQm3HhLZbXxu5r2lAKE21iZmNYsmtwmSURBF1EwJTExr9kaL5MTHbXlLSkaBYNlxQfkyyEh+pEP+t1NCIYWFJriGSVMu/5LP7b1RI9gfmI2gHfsYwHrZUQZVNAPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0VjIQzI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761187029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLELmYBjrIVt2tIe7/6pOjA4rz1yWYE0gX8fXO7gYBQ=;
	b=T0VjIQzIEVygxqlCxCUPXhfCvghQFPj959XuD8cGcOUPUgHvjwkBOIjCHPYKwFyKEPLeFo
	7wgfTSemkz8B1iv4rfmipZQQ7v8WgLpw4agYuApVUzl2HDS/mJej3k46DnibXXxKfhtvoW
	c6bdfLO3R6m7+Ht54qW2588rwb09c3c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-hLFwQCgXO6-q00A2L7yBgg-1; Wed, 22 Oct 2025 22:37:06 -0400
X-MC-Unique: hLFwQCgXO6-q00A2L7yBgg-1
X-Mimecast-MFC-AGG-ID: hLFwQCgXO6-q00A2L7yBgg_1761187025
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bba464b08so306741a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761187025; x=1761791825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLELmYBjrIVt2tIe7/6pOjA4rz1yWYE0gX8fXO7gYBQ=;
        b=m6PU2mLAMe9n7HSL+1HlV/mYi4XZow1vr/nEnPlJSSjTltWiKT5xeFdYH9m5CCYfYl
         qR2Qzz/D024b+KudgVDhHyVYf2XkSUvZxLg9CbDeDX9cXt4PUgoYpMACDapXclnaxzAa
         SOquV7cWYmhyGOgrndnMf9UNS8IJrKnBnpiQZTb/t/2W+uhWVEhVH1RJD2OWqyf8b3jX
         alkTzRq3LNb28GO4gR3Eb4xd44S/K5fiqcAML5VTORoeesxZcj3RG7jL/9TiSOfBb+Fg
         DZFecGu6U4uO6SZp2NX5JB4QFUVuDGzPCNp7dWXBPqEu26oT4rEhXrTcNz5NBDxVEcY5
         Xh/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhpyy9Azs9R5k80OpS4eSM6sPUOT9AP4/yThV9yN/A8+wFHS1OJJ6Y9ealhSlVwkLn/L2+G0b3kQ6iPXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIdbtDQqIacvZvCwlDTTtxN2VgCZ9PjwG7bH4X5HteJlxTdir
	rmiB7t2eytGNvoiNhdqk3cQtOd9zpktYAcm+1L/TdVJHcBjlWXOWcRTV2GohOyOA82f8QF9efSE
	MaexuRj+kRfd5Q6FUYJfS9K6ZmpmGF0VqjYSLVJXo0CaS9Y4WwJdi++v0MXDT00iJ9UboTj/mQy
	IRtCT8hU4H3Y7etgdwS3laWKToCJyWMlBB6MGACbnl
X-Gm-Gg: ASbGncsPyNXC0I3ViMQxUFCb+k9xP8WsY+huOqEoDdcCEk4/iMA115/ahVHGZsTjSO2
	wsatKuIG+BzrTGI4wBe6yGILdxdtPIuTQtcjYEqzCKa6ZyodXlNc0YaJ47XXWqhPOt42V7I30xf
	tINwOFQPjJrTNPo1YHK9XBfPp8LB+klSqSCIqiJS+/6JrnvbQdur6R
X-Received: by 2002:a17:90b:39cd:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-33bcf85acb9mr34016682a91.4.1761187025443;
        Wed, 22 Oct 2025 19:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/QyyERiH1ne1uh++OITBKUZJwW+GZJEUDxDewU6cwuEnbMhLwGR91ccFPAr3mIMgDlrYfBjy0UH2GlIRXE0=
X-Received: by 2002:a17:90b:39cd:b0:332:3515:3049 with SMTP id
 98e67ed59e1d1-33bcf85acb9mr34016661a91.4.1761187025008; Wed, 22 Oct 2025
 19:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022160623.51191-1-minhquangbui99@gmail.com>
In-Reply-To: <20251022160623.51191-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Oct 2025 10:36:53 +0800
X-Gm-Features: AS18NWAKWzREjF0AApyvOANK-aDy0vhZRfRMkPBOWaAVhrOoGWAFI9xvVg3gyH4
Message-ID: <CACGkMEtrdXOCsRQiw659Ygze7AXAHw4-uK_Z+zdi3r9V5XDLZQ@mail.gmail.com>
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:08=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), when guest gso is off, the allocated size for big
> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> negotiated MTU. The number of allocated frags for big packets is stored
> in vi->big_packets_num_skbfrags.
>
> Because the host announced buffer length can be malicious (e.g. the host
> vhost_net driver's get_rx_bufs is modified to announce incorrect
> length), we need a check in virtio_net receive path. Currently, the
> check is not adapted to the new change which can lead to NULL page
> pointer dereference in the below while loop when receiving length that
> is larger than the allocated one.
>
> This commit fixes the received length check corresponding to the new
> change.
>
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big p=
ackets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v4:
> - Remove unrelated changes, add more comments
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> Changes in v2:
> - Remove incorrect give_pages call
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


