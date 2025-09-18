Return-Path: <linux-kernel+bounces-823250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B141B85E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6AA7BAB20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D9E314D34;
	Thu, 18 Sep 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grSCtQpQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F9314B66
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211601; cv=none; b=dTUIfhx3ezDnl617bfOqys/omgNlCM7cZfPkhxVhfhYBXYifQbph/cl16vr7++o7/MFhnH8iC0PtPJXppXLYfyGIYPzTHjfclU3maQikrBLeU08peeUEaPJwx2hfWMX+gf42BU8QxNz2sIMVuFTxsw3dCYoCCYUCVHydmGjNwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211601; c=relaxed/simple;
	bh=P+Wmf0yqfouH3Oi06gJJiikblIWfpXgZcHs/2usguFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkehAlesQMFVKtDXfQhoqs1Ap/qav+syRYlTKkIw0UKHAs8+PJ3NO6S724TLqZ7dHK6dfe1nWg5SNOvyf3BR9pwZ5ikGzMyB2CZF4rlbS2vClkwvfCMBVM9hMYluZdp2Ay/XNSXIRBfWKkQIuL9CmTff5oUk/nC45QD71ie3fUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grSCtQpQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/W5lCTYIz1tvKkOImL2aA/ps1g+KzlVk0fBujrhKzM=;
	b=grSCtQpQVZ0xrM518WGUe0SaWIldB0iQ+Vyt3UaGLf9noMC8hs2bJo0RZsGeAZSKqp/Lwo
	pb/fneCNehUJmh249tp09jXwQP8t0T09bV0/2KHM048iE0DwwGC1IfBx8goFs4GErsE96M
	iM9bghv1+YonU2Ins/rHzRs10SEdJYc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Q7mNdnHKPQOszufGyQtGJQ-1; Thu, 18 Sep 2025 12:06:36 -0400
X-MC-Unique: Q7mNdnHKPQOszufGyQtGJQ-1
X-Mimecast-MFC-AGG-ID: Q7mNdnHKPQOszufGyQtGJQ_1758211595
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3eb536ac039so862759f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211595; x=1758816395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/W5lCTYIz1tvKkOImL2aA/ps1g+KzlVk0fBujrhKzM=;
        b=RXGpcCpgAbf3M7fY05a2EjLQuTkfKJZiXa8StFykIz2UVrrPvEiKuhYFa4lcWM3yd5
         G98Hr+KIeYCnA3LkWlxjpPgNBiDIgFJxN3DVacUgyoSjtBL5rwJ4MDWLMVJDS5rbjI22
         4buU9pCWsq95C359lwqqShWUzg8fMUueYnQD5fPFTmEEFzfdG+rqAL8+xXkEkcj1OuFi
         JDrABPezbH1GAUiSFu0NUakTjTbdMSiXJ+LXgt0Ukiu8J+LSLOWCTEx/omp3LOmuRWSr
         dxtGBrVQ22eKGnV5YTrH50TBe+M/4rli6AijwV5YLVaTeuZFzqhe2QfH3ezVQmyhOs8R
         3HJw==
X-Forwarded-Encrypted: i=1; AJvYcCWeIf2U23Cbv04j/pLHrsm2C+bj/aSwqDk+GmuWbbupXAJDRtzTrM5ANjTiHQUEKTmioJh9btSgQTqbaq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPFjFmfjjo38Qxvcm4oK3X6FsFShwIY+pyFgo7u+ZR94uEgJY
	1144HdKBjSf3fVoVzLg+Wxy9WfMTHLvrTwyp66kBSJVRCv+Id7FUABcliYvP/NvIAHn7RQdkRE1
	kEa9ByJDa3P/mZR2btpOpQOGBZbcrm4a7uiYenmww//O1QLi7yHQvRvrfaya89v8dXQ==
X-Gm-Gg: ASbGncuB3wJ8DBF2NPouKGOYjLXoSqb8ivwUZGgqEniLahINoOOYRR3uEsjfueZdHP+
	Q50bZX/mGtaaNODp1ACkVIBjZwxLE2HU4GgnMcXV/37sLmJRmEEe2tsstKiTcg2fhtiswCWwDXB
	Qvee8Txjiet/taHIp8byZA7Xboe9d8ON83hmDZfMyTuWoo2ROIeT5EJxuDkEP1d4LT48s2cuxPz
	N9N2fDMxagmqpTH1oFJS5TzujRyGS6q7bBsGNfJWJiNF2nFIRNe0Ih6A7pLhuCJg0xME0nJ397g
	mG8Xi8DDAH+PV965nRpsVSV1ibk6dsNXMf0=
X-Received: by 2002:a05:6000:2881:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-3ecdfa14161mr6207936f8f.40.1758211595339;
        Thu, 18 Sep 2025 09:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk3vFxLumDhq+BR9Bo4nIsWcXRAcKMyNyvcVzS+eyg8tV4+vQBxrdk3o5AQ7UyoiyFo7QtNw==
X-Received: by 2002:a05:6000:2881:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-3ecdfa14161mr6207900f8f.40.1758211594963;
        Thu, 18 Sep 2025 09:06:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7300sm4062735f8f.34.2025.09.18.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:06:34 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:06:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918120607-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918154826.oUc0cW0Y@linutronix.de>

On Thu, Sep 18, 2025 at 05:48:26PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > So how about switching to this approach then?
> > Instead of piling up fixes like we seem to do now ...
> > Sean?
> 
> Since I am in To: here. You want me to resent my diff as a proper patch?
> 
> Sebastian

Yes please, if Sean can ack it.

-- 
MST


