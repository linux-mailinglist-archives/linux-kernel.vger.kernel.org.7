Return-Path: <linux-kernel+bounces-839205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1755FBB10D9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493143C22EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7BF2E54DE;
	Wed,  1 Oct 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH7uO8lF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3151B4F2C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332217; cv=none; b=pNtEjmhADVs5NUolwKadpl+sXwBf/t2Inzz2Ov4scml73hKNLXMpOLDqHoKyMCg2LnRcFD+mqIBUdoSgC8MXnkcefkzY4YnJ4VEckYdB3aFAuHitbZMWPwUohGqpA06AYyMQn/JMxePNjjNwbMzhOCG9Y2LKU7MH53NuXuOFypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332217; c=relaxed/simple;
	bh=iBktchbTFIkQVIZCHXu3rzcyooPQa8aMp3zZsKHXgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPgr1yIvDhrEFDGVr5W0PadJTGeEFeaCMQkZqlUEyqhQLTAVgGLPuhaJrHy+VLmSH1PIP/lRXUJjw/jjNT+kL79nJm1LDDJBVAyvS5tvzkxwhtN/DN80tQvoQaeNSkvSJgglYN8bmB7j+vrnnjpDXW6jcXUXwkj6VAJpDb3j9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH7uO8lF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759332215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
	b=GH7uO8lFlsJxIzeLsHnlbzvlaNsjM2d9U2+BHelLUzqKdl5HbKoyahFZpcS+dcmAmDNl2A
	/B0yEOuSUnyGfiukhaeQsxRiXESMpBnJhnX8QS9NXM7UuW/StibAx6BLx0zT/yb2+0mWj+
	JHTN9icponRAEA/Oo9Z2mvKU/dRBIZ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-iyyNEWCwOtmGDg8dwzgIPQ-1; Wed, 01 Oct 2025 11:23:33 -0400
X-MC-Unique: iyyNEWCwOtmGDg8dwzgIPQ-1
X-Mimecast-MFC-AGG-ID: iyyNEWCwOtmGDg8dwzgIPQ_1759332212
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42557bdbe50so625665f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759332212; x=1759937012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8KTVkxDaTugQkJkjdBtyRDidD31YHiR8yeBnSmByJ8=;
        b=DAj163agUbuIk9Dr1gPSugsXXpFSKBoJBUPQe9NY4Twzy2XQ1ig7wgwm5uBxh4gtQl
         Ieg6M5O6NoZARGjtQFPWy7UwfrFvRhZB7iY/OIB2FrEdvEIFDz/R6L7pAVF3Bz2g1L/6
         a8qO11M1jmab62RYVMPsuiUy3I8HN62/6+/Ltm2vSwiJyN6iur541/GYO9FrmUtkHxO9
         QJfBhvJBKWFLHFXQGg/v1kgltohY2Jl9wDCXgsTrVKZ9X2Q4XHzE1W1w41EuhM0fJ0uF
         gHGVynn/V/HSjIuHmM3ZYXAqDG9/o1Sx9AaRK4WWFGMKdHQl7zpxFEaM0PizuUK5+DcJ
         Dt2g==
X-Forwarded-Encrypted: i=1; AJvYcCW+Cc8IbLBOcyP0rvSmHdMPRO0CP6h/s0GKgx06HhKslEFJB71axfvEofI2xs1pDVegaOz2olG3bYjNp6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnpHUs5yKTZ0k4e4mTTTfANoS7y3DOr6gVDxmv/lG4Ed+4BZn
	PR5oJzlB/WGwDjNFIwrbIhanIz6/vTtLs+taWf+eDanIdlnX1iwn4ICfNvdO9HAyC9dVniHaA7W
	LhURBzcXuDJhaIp9u/v9PpUeSjKmPy8wXm11M2ZIiEumYVNpuC+NNWEY8sSGo7KxHow==
X-Gm-Gg: ASbGncvqCKzCRyka+s1Ye/Bp2hYHtOb5h87Q5K9JPymrNxxZC49bHU1a/d4XGRPwvlh
	z9nmghLe3nTXm52EocTCIqSxu4apDI4bLUVKvOFWhayxis8yIt6hgN2zj7ykbd7b+XJscsOwcEQ
	DufAIoXcmWOnidUTEb0R4l3ehMpKce7q6R70U6zaxQF+cFWcdvhcoa2mlB5tWwD3RM7UprhTIlp
	YEv6NYRXYujVzZ6R3rr/FUeV7qQ7wu50Q0QmfWbu9TILQuCxuZ330iP9D/Yx0Bzf5xCRkWKk/Rb
	tu9pJv3XT3nQ5doKXIADynNxD08GzaSNcMUwmQ6YqRcGcot6rO3BomLfp0CPPUQXSypyFFoDC+l
	7wcaEgerhyA==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217874f8f.30.1759332211755;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0F9XwtcVPf6wB/WoKqvKR5BovvccvzXbrj2loiPZ9rqJZd0tUbtbAeri7VVwEh087dav6lw==
X-Received: by 2002:a05:6000:40c7:b0:407:d776:4434 with SMTP id ffacd0b85a97d-4241227789emr7217838f8f.30.1759332211348;
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Received: from fedora (193-248-58-176.ftth.fr.orangecustomers.net. [193.248.58.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm29483495f8f.54.2025.10.01.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:23:31 -0700 (PDT)
Date: Wed, 1 Oct 2025 17:23:29 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me, francesco@valla.it
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aN1HcWZ4Q1lV+FdP@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2243144.yiUUSuA9gR@fedora.fritz.box>

On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> Hello Mikhail, Harald,
> 
> hoping there will be a v6 of this patch soon, a few comments:
> 

I am thinking to send a v6 that addresses all the comments soon. 


Matias


