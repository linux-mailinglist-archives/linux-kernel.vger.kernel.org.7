Return-Path: <linux-kernel+bounces-861313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1F5BF2598
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8622C34DF45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F5C285C8C;
	Mon, 20 Oct 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJn04CwI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE52149E17
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976939; cv=none; b=Rao5k62VKESi9a9AcgAHpa9mvLcIQ6pD5MUbR2cEGNCYZsEpd0zQlSyEZCI4bTJphaQ7yudsvlq3lv8RSFWJkELohJWMj9BBEiNvkcbv8rgYMeV508jyDjgfiXBSdEWvFzebJ+jaSEu4UjC9bwMFr/FtAuX2db+XfiGRzaQWrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976939; c=relaxed/simple;
	bh=cPmhMPpHMf9OZXvBCKCLmUgibMzQ5xtsqijFgeLuud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbDU4mmVmtaBXq8+d3xLX4uEv9fKqlPuRv/4HuTELwydw3hL1J5BG7HdseEN+JRT/Gfyebj70I7RsFvKEWx9mA7YGSNilHAzaRSThIQ+4BTZhDs2L7yYyB0PNAETMGN0ym9aJVX5ICgTjXbNEio6cxMDiuXOCr0boaNtDARhdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJn04CwI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760976937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJxplQWUUgvPACnS8sqBaCwMVjdrCjqo1EJhgx6jkt8=;
	b=TJn04CwIEkQMGVbjoYG2e4UqcA7sGipkn1/aEZ1RX4CcFjx+VejJ/wCHaI/dGY6ommV6Vg
	niVPJfZV8uW9thtmshIeoHx5gtW0l7kjRPhArFmkvyikT7W6h/qPxlTZYrQBsfIq+G4TSu
	5LHqYDfDpjMyNu4Q6PVBXAQtjojESg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-T3D5TdA6NSWAh3FWh3CnkA-1; Mon, 20 Oct 2025 12:15:35 -0400
X-MC-Unique: T3D5TdA6NSWAh3FWh3CnkA-1
X-Mimecast-MFC-AGG-ID: T3D5TdA6NSWAh3FWh3CnkA_1760976934
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-470fd59d325so25007845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976934; x=1761581734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJxplQWUUgvPACnS8sqBaCwMVjdrCjqo1EJhgx6jkt8=;
        b=UiQGwWquhPd9vJqc7MPSQE4cu6gpKocpH8pEKpXwX2Ha3m6xswyA/oKSFhIvLQvR3h
         zgb8iZ0dpJ7krpmT7byjtH5+gE7F7k/GVwyV9xbv1YfYiV4yL2KF/0S6UC5U68vrSRVe
         O5xf66NqwNSNZsDuVPo5G4UeudiXOZe6ljPOpYtgmMSH+ExrlXNpLQ28cjDQXB93ibp5
         MG4EmAq55ow/Xkcg/R5cVZKe9I7qFp4n25UMeMXENoP+vLu+/sCiepn7fbnpNBsH2SR/
         YLnJYM4MXPjKfLsQ7jSrb7pHtKGxw1bo5BPSilIPi41ft/sYcCsScIICFFkymGParnQv
         l2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/N1U5NjFLwXik/AyrDGI0sslWmm38MqDJqOPfaQjGdetTVomniWQ4HieOjiMTNqsWx3hQQbui9osHNCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+pasYoIXRXua/OW1ifgoH49/SGQo7flI71gh28pvUIhf+KtEh
	Tw7BWvePmC09FIrlKtgjDECoI9LGwpTA38QrCrGACIaPflrDQEnN+rlDk+IRbA5lBZPXBLKsfwG
	1NITcynshhHo4LOBYx+RveaZ+fIgz1hhfMJ2uli/NpFdNOV94Jq1VNUz5ntxkX3CwAw==
X-Gm-Gg: ASbGncsOLxYUealeBRXcFnggzWCJTe7wWWLoEsW701543AWerhuQX+haxORUN3A936i
	POykXNojeYdhMubx07JLIpb/1THuTpf9P3ML66NgkXEKmk7JWfus3DTslAcgm13o4FVHneZUImJ
	SuBfCE9Wkp4vjjDfM7RJRnBzp5v/x4Wt6i1icE+/UzKwsWN4zhGs3JnLK11emTgiZ6R01eUycKO
	AI7kSTjKgKFpllD5xy7H3mSXsda7FqrogNaTLdAzfW6inMnu1rrw3PuW7gDWQ9yGefbKSWNbepI
	876G+kLsPzb5a/fkD9as2JZHfzkHZVqk1m0OKuO8yKkP4EAgv3gLI/9ieNt0/T1KhMGr
X-Received: by 2002:a05:600c:540c:b0:46e:46c8:edac with SMTP id 5b1f17b1804b1-471178a6f9emr90894785e9.11.1760976934205;
        Mon, 20 Oct 2025 09:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfD1sVXteUr24GtFdMBM0eLxjgwGriWkSrDglWOuWS3Nl4AUBUsgwyoowFrJaYLNlrtXxv8g==
X-Received: by 2002:a05:600c:540c:b0:46e:46c8:edac with SMTP id 5b1f17b1804b1-471178a6f9emr90893495e9.11.1760976931307;
        Mon, 20 Oct 2025 09:15:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm16201513f8f.5.2025.10.20.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:15:30 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:15:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 12/19] virtio_ring: switch to use unsigned int for
 virtqueue_poll_packed()
Message-ID: <20251020121235-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-13-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020071003.28834-13-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:09:56PM +0800, Jason Wang wrote:
> Switch to use unsigned int for virtqueue_poll_packed() to match
> virtqueue_poll() and virtqueue_poll_split() and ease

and to ease

> the abstraction
> the virtqueue ops.

of the virtqueue ops


> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58c03a8aab85..73dcc6984e33 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1699,7 +1699,8 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  	return avail == used && used == used_wrap_counter;
>  }
>  
> -static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
> +static bool virtqueue_poll_packed(const struct vring_virtqueue *vq,
> +				  unsigned int off_wrap)
>  {
>  	bool wrap_counter;
>  	u16 used_idx;
> -- 
> 2.31.1


