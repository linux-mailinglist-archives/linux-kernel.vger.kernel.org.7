Return-Path: <linux-kernel+bounces-733653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9FFB07771
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C321722EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6941E25E1;
	Wed, 16 Jul 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L61GihwD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007914A09C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674220; cv=none; b=R/Of0jrLYTbgIvRU0dCzGTrwKPlFCu40HQ2JwAfudZizCexb8I1c84uOYwK57+3SPlsEboaAaC5ofaWptKPoSbsJqyqEuV5e88xvo3iSovsT27VtqZCHE0zh+KNhtOiQnW9IKuLVeCMBTghIQvq4XmUPC/fEO74Vx/e9BTbhyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674220; c=relaxed/simple;
	bh=iPt/IuCgv7X6wzHFK3I4GCGSIo9yuavU0rKQEyFHi4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqnomWujjtdJwNJeJK0bX2Dd6WdMamXlHpEKRf+W0yiQ+F46u6X4uW4VY9DBqqdBXnrwl4n9BOXntN7pq+N8ebR7N3Y1/bwwcQ8OcJUkMbsK3w2svKH53LvKmOl9hEx/vEqysf76XXsMtquZyf6Ly6kBD+rTQoJLnTRHY4alnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L61GihwD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8fU90Rrx5Q2FZQjCI0B6EMx3qMx3LCWE+lzijdY4q10=;
	b=L61GihwDy/vdDkbxdH5X7JDQTKh273eATNLOMvg0jHLdLvF/by76EUwI819bfvtskglYVE
	jAmAb8+GMRXE209O2mm+ZYJ2jreY7MaKUoPEGOtCYYAN9t8cAjBqOLkETiZzgnQIEON4VX
	wWvxb8jhLe8UcZ1wwTH0YAE1nm/bsQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-C-tTMQ7FMEeTGTCEWopb4g-1; Wed, 16 Jul 2025 09:56:56 -0400
X-MC-Unique: C-tTMQ7FMEeTGTCEWopb4g-1
X-Mimecast-MFC-AGG-ID: C-tTMQ7FMEeTGTCEWopb4g_1752674215
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2811590f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674215; x=1753279015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fU90Rrx5Q2FZQjCI0B6EMx3qMx3LCWE+lzijdY4q10=;
        b=WvDthYglwerpfw0zOShMJ7Hx+6v+0rcGvHFSRtCro44ssNoVsVu0wV94rIlvfaXVC3
         sBZdSzXrUKknmOtcEvruy55+KpJxiZiUTxESPwwAGUNMsEJwSDIwVn8oXAMeQbixfz4A
         jAPJyAWp/JGzBq8u/WUZ59IyqtuTB2DxCVPM4vMF5bZXVu0TDKaRItsiTs22neBO0K1z
         8V2y/BsXhX9trMB6x2k1kkt92J+FqrReVo+WO2xxUCh38Mc061DBS2ioMA+5qMLrmUfQ
         Nak99jObkgMXwz2n7zogVveB77ZoUJZakxS0NbbsudX2yzVUAxHPiZ72GynqPW8evl/k
         nJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcaCPkQaAbEgxVEl/vCL31Pd7iOkJbEwco8gpHj20I/dujjkHMp68J4orLw6SQz21JIEF5NuICCA7FKEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4CoP6ocGFTP3Ll8obezqGa9j8sqmdqQC7uLKFYLm++oJ3UGp
	krMmCfrfuZqLyh+ILY0o10EQ1KsNQgFB+THo6/9+EYhng3rjssybBbWuYVe0y+Qv2M/EO8zP7cn
	+qpHNL1YsJYE7rKLiP+3DyCyRMwdMeUQDfHnCFx7IVG7vpZHGGdZUuenbXW8AKXYnvg==
X-Gm-Gg: ASbGnctvgnCiaEb+jyWL/SIB/8Nuf6CbvdkCWwT+iBXz4M+A4PQVJAu5CsBLNsysFtP
	o1arPikGWfbBxDz2xyF/7FniQnaMIbR3gCKFcyo773IYb6cLI4YLIWoQUrJ3jb9jsYMggFfanna
	55SIeRFxkg/0VbkS6CgjTspBxzM8Djeu1yqDT1ukPw1ofA4kMUdkKmUewJhIe9zyQOTwung5ZYR
	cUALN1xtHQGmMdbAUrozO4IjfFWAHg5oZV0DOVOboKOBb6/L7GAPLlMLxjmtbX+BlrXo3N0uIll
	fqJmho4BkNldhseTRiukls/CTue1mhKw
X-Received: by 2002:adf:f64b:0:b0:3b6:936:92fa with SMTP id ffacd0b85a97d-3b60dd8df46mr2367238f8f.52.1752674215040;
        Wed, 16 Jul 2025 06:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDkw4tjXyAdhQ6LVjUDIf1HaSWqF1ZS/CeOQWr/qZekbvwZ8qxdZocOeTQ+5WAYNkarEumJw==
X-Received: by 2002:adf:f64b:0:b0:3b6:936:92fa with SMTP id ffacd0b85a97d-3b60dd8df46mr2367218f8f.52.1752674214534;
        Wed, 16 Jul 2025 06:56:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd15bfsm18252140f8f.19.2025.07.16.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:56:54 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:56:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: jiang.peng9@zte.com.cn
Cc: jasowang@redhat.com, krzk@kernel.org, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH v2] virtio: Update kerneldoc in
 drivers/virtio/virtio_dma_buf.c
Message-ID: <20250716095046-mutt-send-email-mst@kernel.org>
References: <20250705105803198ff11jYCkg1TxntcCEb00R@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705105803198ff11jYCkg1TxntcCEb00R@zte.com.cn>

On Sat, Jul 05, 2025 at 10:58:03AM +0800, jiang.peng9@zte.com.cn wrote:
> From: Peng Jiang <jiang.peng9@zte.com.cn>
> 
> Fix kernel-doc descriptions in virtio_dma_buf.c to fix W=1 warnings:
> 
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
> drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'
> 
> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>


The extra documentation unfortunately just mechanically repeats what the
code does. Code comments should explain the reasoning behind the code,
instead.


> ---
>  drivers/virtio/virtio_dma_buf.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 3fe1d03b0645..0b39b1b209ee 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -9,13 +9,20 @@
>  #include <linux/virtio_dma_buf.h>
> 
>  /**
> - * virtio_dma_buf_export - Creates a new dma-buf for a virtio exported object
> + * virtio_dma_buf_export() - Creates a new dma-buf for a virtio exported object

virtio core uses the form without () consistently, everywhere.



>   * @exp_info: [in] see dma_buf_export(). ops MUST refer to a dma_buf_ops
>   *     struct embedded in a virtio_dma_buf_ops.
>   *
>   * This wraps dma_buf_export() to allow virtio drivers to create a dma-buf
>   * for an virtio exported object that can be queried by other virtio drivers
>   * for the object's UUID.
> + *
> + * Returns:
> + *   - Valid struct dma_buf pointer on success
> + *   - ERR_PTR(-EINVAL) if:
> + *     - exp_info->ops is NULL
> + *     - attach callback isn't virtio_dma_buf_attach()
> + *     - virtio_ops->get_uuid() is not implemented

Too verbose, no one will rememeber to update this when changing code.
Just 
	Returns the dma_buf or ERR_PTR

is enough.


>   */
>  struct dma_buf *virtio_dma_buf_export
>         (const struct dma_buf_export_info *exp_info)
> @@ -35,7 +42,16 @@ struct dma_buf *virtio_dma_buf_export
>  EXPORT_SYMBOL(virtio_dma_buf_export);
> 
>  /**
> - * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * virtio_dma_buf_attach() - Mandatory attach callback for virtio dma-bufs
> + * @dma_buf: Pointer to the shared dma-buf structure
> + * @attach: Pointer to the newly created attachment metadata
> + *
> + * Implements the standard dma-buf attach operation for virtio devices.
> + * Retrieves virtio-specific operations through container_of macro,
> + * then invokes device-specific attach callback if present.
> + * This enables virtio devices to participate in dma-buf sharing.
> + *

Same thing pls do not repeat all of code.

> + * Return: 0 on success, error code on failure

we say "Returns zero or a negative error" elsewhere. seems clearer.

>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>                           struct dma_buf_attachment *attach)
> @@ -55,8 +71,12 @@ int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>  EXPORT_SYMBOL(virtio_dma_buf_attach);
> 
>  /**
> - * is_virtio_dma_buf - returns true if the given dma-buf is a virtio dma-buf
> - * @dma_buf: buffer to query
> + * is_virtio_dma_buf() - Check if a dma-buf was created by virtio DMA framework
> + * @dma_buf: [in] buffer to query
> + *
> + * Returns:
> + *   - true  if the dma-buf uses virtio_dma_buf_attach() as its attach callback
> + *   - false otherwise


one is return one is returns ... no consistency.

>   */
>  bool is_virtio_dma_buf(struct dma_buf *dma_buf)
>  {
> @@ -65,7 +85,7 @@ bool is_virtio_dma_buf(struct dma_buf *dma_buf)
>  EXPORT_SYMBOL(is_virtio_dma_buf);
> 
>  /**
> - * virtio_dma_buf_get_uuid - gets a virtio dma-buf's exported object's uuid
> + * virtio_dma_buf_get_uuid() - gets a virtio dma-buf's exported object's uuid
>   * @dma_buf: [in] buffer to query
>   * @uuid: [out] the uuid
>   *
> -- 
> 2.25.1


