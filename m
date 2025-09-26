Return-Path: <linux-kernel+bounces-834311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5BBA4687
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5261C012CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4920CCCA;
	Fri, 26 Sep 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMUKqUo3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B010FD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900426; cv=none; b=SDwbZ8aprnJG2DxBF4Ti9Z2SBfh4haMak8w+TwibS5I2rSMxq2f3J5hCoG0HYAVS9moWvjC1RodZqP/UoPokbltThx5NirB6vNF8mAt6P6N0NzrHG7Qkwqlb0hKMaWWKuCCbxeNKywiH6C4zvvz1lV38UZTgDtiHEUBONVImSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900426; c=relaxed/simple;
	bh=putA4/rNeFIhlYlD+QDvpcYKjCxUsRvh0XJi+VVJIXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcw0xk7jAN/d0/Xz55MEKuWw5G+0Uhxa2DoGnHPixE46ApsCk4psqYpUfbOD3HIZC2fk8ZVBooZesOPWrtId52ZNwAfQ40htI3/txipd9MiSSn9fz8dA5Rp4zFvKU/zdF4gGgSySOB5Nh1u63LcDVLBHpFXuC6AOgVbDctgydoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMUKqUo3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758900424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7wPkmWYHKYykuMdWFSPz0kKuHgglDc4DfacU/AAzVA=;
	b=fMUKqUo3EfXWJd6qG59TgvcmiADMtHfSDbngOx9xLuPeR8wUkd4XTZarh537udp9DmhCri
	6095guwkCjPolzCmZpfgWAxvBXxRtGO1Mp8b/2wM6GF1VuD5uoOqzbt7ZuvTmiAJDWpnZY
	NaSpSoIbkV1G+vHNac8dKv2RQSD9344=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-dj0yob5ZNKie-5Wi6f8BQg-1; Fri, 26 Sep 2025 11:27:01 -0400
X-MC-Unique: dj0yob5ZNKie-5Wi6f8BQg-1
X-Mimecast-MFC-AGG-ID: dj0yob5ZNKie-5Wi6f8BQg_1758900420
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e23a66122so16262605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900420; x=1759505220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7wPkmWYHKYykuMdWFSPz0kKuHgglDc4DfacU/AAzVA=;
        b=NKTpXz7GYw8PBwSA1zhiAHM+jmClCDmieEytlRunmDVqSFWKgSsnB7vlmKbf5Wx39f
         wciPWjsd3vUUoNKya2HL6++2J6mBXYwW5nSlWx2LbdQzGddZB8VbJdq2hvOURoyHUhH/
         yeed3RqI/TGdjiJaQAmAl9fx278ABu3pA0JTEgUhiIr3hz9umqmHtzbvr2Tm/AkzNVKL
         ItznAj3Ou+GDXX40ngIfrQMxWR+MH7HKtvc6hNmob7NC4Jo8/h38fxfHvZzMkuGyIxHE
         DqCbrydr8PwnpYo2L89dOSnnCorHSKo6We18sJPwYKgZYOAbRQK7ro+trolG0NWwh6MQ
         4I+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0eYYhXkUHYlfkj+ebCZKm7m6vJmumf+jWSPP05gI9GgiGrx0OhDvVHu2VZMn48vbQLxigrJEwHfK+BwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4gMPV8o/96exgPf7vU3RlCzqkdqE/T+sBNiMuPELP5Fn4FmO
	PhBB7mv4OM+xbp4nUlgNGqPyEbmrFZ357s7zRwyam2+f6VnoZGPFEqAnADLUmXS0MTtE9oDWCTA
	BAwtdR/noOPXohGtwnMd5Z73MW+oLthsznfuZuCbH7vz2iMvAycmZOZBPWvx80tOLLA==
X-Gm-Gg: ASbGnct20fuNlw5XXTnWIarmebJuZskLQsD2j++lPkgV+568TTjpYe3pAkcvT8r8Vri
	TtD7rUS5pQBNTG+elxKYrdWadTy+6u1HUKeMlEBrnwkfPaaRV+eFcSRTvbEYl2ypCy5f+gLq0i5
	RHcxgL5RBn8DgNxcB20Xg+8Bwdgz2+YwWq49L7xEH14Dr++C3q4ZyYpo5Y7yos4BI+rkX5C9JbU
	sAUxoc2vU7MeGh/qrjNAeNi+X+QTyJRZ02NVdcNV6RCNgsY8CxWpIvhwOlfJ8EvlSNdX1YCrYTb
	Vx6rFpi5wbIlCoIQgyDoXmwVXB4tQcqfFJg=
X-Received: by 2002:a05:600c:4f16:b0:46c:fc4b:89bb with SMTP id 5b1f17b1804b1-46e32a03464mr75193875e9.29.1758900420407;
        Fri, 26 Sep 2025 08:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEslyH9QMUF46P8aeQxsw5sQc6pwKJ1e4Ko7lKaWkOwfzXLsLJGOUtTaV5VlvftGoYlXC0gFA==
X-Received: by 2002:a05:600c:4f16:b0:46c:fc4b:89bb with SMTP id 5b1f17b1804b1-46e32a03464mr75193585e9.29.1758900419963;
        Fri, 26 Sep 2025 08:26:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33e3b300sm39364095e9.1.2025.09.26.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:26:59 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:26:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>,
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
Message-ID: <20250926112622-mutt-send-email-mst@kernel.org>
References: <20250926101432.2251301-1-eperezma@redhat.com>
 <20250926101432.2251301-4-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926101432.2251301-4-eperezma@redhat.com>

On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio Pérez wrote:
> @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	dev->device_features = config->features;
>  	dev->device_id = config->device_id;
>  	dev->vendor_id = config->vendor_id;
> +	dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;

Is this < 1 same as VDUSE_API_VERSION_1? If so, maybe use that?


