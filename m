Return-Path: <linux-kernel+bounces-731629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8EB05763
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09221C236D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9985A2D6604;
	Tue, 15 Jul 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MD+LNN9F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27D233722
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573734; cv=none; b=G4FZiwMGoQFH/hpAWQLWX8oWOaC00hh/hxCUs6IABwVrdNPUrwrR/Nv4J7edXnzupKDanHXueYtJ483eEKvjUkeaIAXqST21gf55ZIoLOQSgnlTwSt+lNtWQaA0d/cEz7yb0dNz0xY5NvqDPHCr9d8mb6Sg3NGrgCFJGuIzKBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573734; c=relaxed/simple;
	bh=/Esi2LSscF1WVQ+nHVOWsWxA9bkfWvoVCVYFUIPTLtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORCslP7a/cpm2MFNpHGM+24HC/uSpS4BeYdXiNIzvbXOYzIpSgtl8u0c6sbzSZCYt9Q5qo+h7UWvFdVDFaERhfxjTxYpToTpIaZ2JKkwQnc+Bx9z9CSgoo7fMOqFnlJpC13qwJePHx7tB+d4FaC2rTz1M3RYDX7uUNhM1umuv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MD+LNN9F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3zlyD+g41O/WUW7kV6Hmu8sGawQ+GSL4IABN4nr960=;
	b=MD+LNN9FnMsiHHmBIu41HGcYmDBZxgkLNKxaUlkCi6VnjacUoa8UM+1iPC7FndyOVbz9qt
	oaUki+LuaQSBMOzhliDH5Cscfi0sjx2V3/2IqSB7OYprcS/pc4/y3U66Ro1CMpQ41gBCMs
	JpcxxUR3B//Q/x2JwGyoS2Uo7951/SY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-ygH8Bz_0PaO3_NFEHJQ5QA-1; Tue, 15 Jul 2025 06:02:09 -0400
X-MC-Unique: ygH8Bz_0PaO3_NFEHJQ5QA-1
X-Mimecast-MFC-AGG-ID: ygH8Bz_0PaO3_NFEHJQ5QA_1752573728
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315b60c19d4so4708709a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573728; x=1753178528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3zlyD+g41O/WUW7kV6Hmu8sGawQ+GSL4IABN4nr960=;
        b=G3LQLJ6l43bdW8XQwvMo0ljif6CRs90qruVVFsJQEOi4ETyzKRkEZ5WCxniRmP0OAh
         EWMa7cmvKxSZQCDsWm2/OxIVPvya9+e8a+uzz34rPUxvxt6erBEnvs5Slewzz1MnUW2w
         edL4bTQUDMDJ5Idq3HNPzi4oTcb0UarJSNESfZJP6J77S2mwuUQTAgrBzj1MIHooOi3L
         5/QLblB8bsXB6Lrw50dju1xLTr9Cw40UtLcu+6vKv77/np4XequUf2tdTfj9GHT6wQk0
         CwHWEZfYIX5wadRMkINah1paYDC9flKZo+Wv+KV48vwlZE+V0fyK5NWudd9awlKlgNRO
         Nwkg==
X-Gm-Message-State: AOJu0YwevrCMFoaS7WevMUzrd2oMghfkjj+az5Sg0FWJEu2Z/y9bSnFi
	uGjRjLiKeHVSVZAP/MKrps6aLBMwD+Lb0PUULYTg6LHsIDHfC0UxmdTTOt8a1bhZVdKEnIDhPfA
	UsSQuSSbodDQp0odjywni+62ieQMsmJjRiBAQNs3v/uNLXb/MbDc8WeeLQzsYhbgEgw==
X-Gm-Gg: ASbGnct+KSaAPlAGUonTubTF1NAFJtuHBqCErhyDcSfSSLc5DXoybz7FopxJrZVYPj9
	10+QD61QFJ6xDsGMhaPUdJ/7wFOEZ0YCZlKek8KlB4r+gdnuuVl6itbzfe6j9TtPJ/MKck0FcRz
	YDnTOQR5RjYDPst5CqBKLijVV1MXRuNvP4QYCOIQlFOWgkRKwuprpa6wa8iEBu3IU4JFa/6Db7U
	IxwrEnMGE054dIHCTCB/7GparlBXMXlN9Ycels8lI/pSAFJsjqE2aUkeKagWyCdb8GUTfgdbNlN
	Sv+pTsLdbeRJXM3N+nG/jqQlIjCPBpKKPNh6WP4dQQ==
X-Received: by 2002:a17:90b:3e4b:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-31c4ca674cemr26556985a91.2.1752573728007;
        Tue, 15 Jul 2025 03:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF43KPk0Mv+KOem1eKuyhOhWAxYn+8QkkyVrOQLCDBIs5jSRYrwTAbV1ZjwkxKobKwqVaLB3w==
X-Received: by 2002:a17:90b:3e4b:b0:31c:36f5:d95 with SMTP id 98e67ed59e1d1-31c4ca674cemr26556922a91.2.1752573727386;
        Tue, 15 Jul 2025 03:02:07 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e958166sm11589778a91.5.2025.07.15.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:02:06 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:01:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <opdsodne4zsvgdkp4v3q2xggjzwjtk22j3knvpntlo63h6t767@jsuxmvgucatu>
References: <20250714152103.6949-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-1-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:54PM +0100, Will Deacon wrote:
>Hi folks,
>
>Here is version three of the patches I previously posted here:
>
>  v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
>  v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
>
>Changes since v2 include:
>
>  * Pass payload length as a parameter to virtio_vsock_skb_put()
>
>  * Reinstate VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE based on a 4KiB total
>    allocation size
>
>  * Split movement of bounds check into a separate patch
>
>Thanks again to Stefano for all the review feedback so far.

Thanks for the series!
I left just a small comment on a patch, the rest LGTM!

I run my test suite without any issue!

Thanks,
Stefano


