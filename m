Return-Path: <linux-kernel+bounces-775529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8113B2C029
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCEC1BC4A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F332A3C1;
	Tue, 19 Aug 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJBkTHKC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A4322C92
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602555; cv=none; b=JV5ShWzFXJA8Nw1N4q6NbMV7XAa6tHp3FDAaL9UDZOrlXVZxVApK9j8lglyr8HywFK7hP+xRDJ8tbpQC3TMBh12MBXUIN5nV/F9EwzfLicBUgePdwJ4Q4BZ9xk3yTg9lXW2JddQcTN4dgsojSLAxBOhi5gfuiDdYFdv+J72Kfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602555; c=relaxed/simple;
	bh=ljNmmhgO9RaVR5EfsrA+jtClGqwH4Ncw0+lLHEpMKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtI6o6mbNVf6+J1LNSnriIvuiGXW/O5uUGN63nIwPYhP+E7qTOimJGCDaILGEHFU6du7WJvB0WHFC+8Fix67Aq7qzl8cSeswK4lnLAl/utBy6iAJTVPkXZWiao2FKeaXS4XbezVEXnl+WbQypuwdSm5cv43dxGYiOQIpcIJsXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJBkTHKC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755602552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdBinzdAYenwJX8OAfplMqIPm3EH+LTM0TGcBywLoj0=;
	b=hJBkTHKC7xxyZ4/aReLPGO6dnGHI0VuzD9ue40LzqzTUCaFa22oEO+Aee5LY4H7avjoocK
	xy4G/qOfFTpBUgzk4wz+fb4Ijnogh/P5EFr5ruyD8aC0fO2nbR9qlcaTvhMt3M93UAZm+W
	VIQn9OPz+nipXbShXDeQqGDr5t1csLY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-fLkQNyXSMqGeQ99fEJSAgQ-1; Tue, 19 Aug 2025 07:22:31 -0400
X-MC-Unique: fLkQNyXSMqGeQ99fEJSAgQ-1
X-Mimecast-MFC-AGG-ID: fLkQNyXSMqGeQ99fEJSAgQ_1755602550
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41bda7bso3158254f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602550; x=1756207350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdBinzdAYenwJX8OAfplMqIPm3EH+LTM0TGcBywLoj0=;
        b=rtWtRiTSQXzFY7w8Qd30tZnrVba/UMeq4nLEGxTlZkewpirJQqmtXf8L43R4KuPJJt
         2C7hljxXgprMhwtV4NngsE8X8GzYl2AQvrqqbmsMqYxaobB/uv/nvN4Tf390WqJr1STj
         5wKJ7aZSy1O7GgFMho/JDmF5pCdRHw/DoVXYyg4fURlivErbXuOsLV+4WSLFeeXEtfD4
         xMc060DyvL8V5638bDfQ8QS5YU1hIYkD63kQAdbKf6lHddeR5ZAA4f8QJIZ+SI2LrYhX
         1jnCj+NB319nxZiUBM1HQg2RLcLDCN5n/+jT8qWTiAOwf/fQqxsAjf5CJ2FgSPCYEblw
         yMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmpRCC7XWhrPPQf8PmvNvnORQaPoQDDQufDPn+QNXTr52YSQ7cSpBZNmHgddpkSM7bNA4rGERvYQ30Yog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjVBv4mZL8xCNed8sUyeammN++29f3J9LQ4xIuFo7hfbz8if2
	9toRqChSZam5W4QVQadlwoXDzDbWNs1FtHGZm2PJEBZpFyzy9QlH6ClVOdNB9MXmGhpHjS1zVRY
	X0J5jD4BhIRfYShiqUSKNTzbF6KvFVOxKjdoeScqUyRnzrMlBzEbHFkKZ8B6hNzsYcA==
X-Gm-Gg: ASbGncs4ylUpJj1iD9yEbt2BSgEdZrZa58D06yzgggKpEvTkE2fACvreP6hmbvX2qYS
	TU+XWg+n/WqAveEbbd+BeRm/rF2E4OmckUk/iqC5hhaNTOfwNZjTXD8rJt04hY3F6GDrvQ15KWF
	JLJKZt5DxjZZYnhXAgqJd1ad5Cg1kA25M+eFDLwRn5NFwL+qlDrYX2OPym1GJv5Q9y+/cfu2pHv
	qt0Zy1bGNATElGZB9pGwyqQCeZcgGEgXhnPId0WuFc0uQ59UFI2SHyvWmEawK8r+ZFk9dblRZWK
	mBR0blEJ3nJg3fGDUlS78IYBEk59/BJJ
X-Received: by 2002:a05:6000:2387:b0:3b7:9aff:ef22 with SMTP id ffacd0b85a97d-3c0ecc3206dmr1914962f8f.27.1755602549981;
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv8ySp3Cp9nuKkaFnxvZbN6GvUwPZexJl3kz+HR/Y9XxHDTyVom8LjTJyyFuYXs6XeX/e9Gg==
X-Received: by 2002:a05:6000:2387:b0:3b7:9aff:ef22 with SMTP id ffacd0b85a97d-3c0ecc3206dmr1914938f8f.27.1755602549506;
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a84417sm36364775e9.13.2025.08.19.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:22:29 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:22:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
Message-ID: <20250819072216-mutt-send-email-mst@kernel.org>
References: <CACGkMEvm-wFV8TqX039CZU1JKnztft5Hp7kt6hqoqHCNyn3=jg@mail.gmail.com>
 <20250819063958.833770-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819063958.833770-1-namhyung@kernel.org>

On Mon, Aug 18, 2025 at 11:39:57PM -0700, Namhyung Kim wrote:
> The VHOST_[GS]ET_FEATURES_ARRAY ioctl already took 0x83 and it would
> result in a build error when the vhost uapi header is used for perf tool
> build like below.
> 
>   In file included from trace/beauty/ioctl.c:93:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: In function ‘ioctl__scnprintf_vhost_virtio_cmd’:
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: error: initialized field overwritten [-Werror=override-init]
>      36 |         [0x83] = "SET_FORK_FROM_OWNER",
>         |                  ^~~~~~~~~~~~~~~~~~~~~
>   tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: note: (near initialization for ‘vhost_virtio_ioctl_cmds[131]’)
> 
> Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode selection")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Applied, thanks a lot!

> ---
>  include/uapi/linux/vhost.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 283348b64af9ac59..c57674a6aa0dbbea 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -260,7 +260,7 @@
>   * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
>   *   - Vhost will create vhost workers as kernel threads.
>   */
> -#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
>  
>  /**
>   * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
> @@ -268,6 +268,6 @@
>   *
>   * @return: An 8-bit value indicating the current thread mode.
>   */
> -#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
>  
>  #endif
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog


