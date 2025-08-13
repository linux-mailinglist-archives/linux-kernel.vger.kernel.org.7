Return-Path: <linux-kernel+bounces-767456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC0AB2548A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A822B1C273CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373B247287;
	Wed, 13 Aug 2025 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADIeVCv9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6212628D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117036; cv=none; b=PFzm+2kmrIREMvbttbuE1QhvUlC71RzBuL8pxegAdw+jG4TmTBSKSLmYAILS4f4+pioJzARygPMnI9omVyQ39p/vEJ3nDWVOuS+Ryxf0mKvSHB9IreWnNLvYucfl9Pb6d4l5Yp4J0f3xxUYQXbD+G5XoatNyXn2pvitGdmlXq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117036; c=relaxed/simple;
	bh=TUWUvUZoTPLkbh4j8BITpAkVoVy6W3JXAa84nclCMwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqzIcb+OgjPKO14mX/MsarV5/gjFjahJ1RFi/1c3u40BE5tNFZDD3MUxrPgJwCwudpVpbcQBDdi6UXNCIkkv/pU27umM1NpF9oDGIGYZAOk3Apnze4pUfuZLT8jrYiVdn/t31wdurgJzy8aaWZYvA0wchyOUhfUkFInn3RkueIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADIeVCv9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755117034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybiuLaukfgYUnCV8dSXZqE5iKES2KXuJCfBdh1/Gwr8=;
	b=ADIeVCv9/hgSEbTpBi2UkaVnVRQX/APB/T3h1lHcFJ62Nav5d3i7c4Rkf74zggmkfHil2X
	u+yYIRC4JcQqyyown/7wHkXJ4bJi2oTIRxvRzcPWN5EQROcPK2Ylz1G3uUicL9ZOpTfj9U
	FBi00KiG+Bp8Co+0JXdlEBeM3IcFoac=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-jn_2m2zBNPKqAIRFYEnsLA-1; Wed, 13 Aug 2025 16:30:32 -0400
X-MC-Unique: jn_2m2zBNPKqAIRFYEnsLA-1
X-Mimecast-MFC-AGG-ID: jn_2m2zBNPKqAIRFYEnsLA_1755117032
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e56ff18e4cso584185ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755117032; x=1755721832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybiuLaukfgYUnCV8dSXZqE5iKES2KXuJCfBdh1/Gwr8=;
        b=W+fgXu4QdqpDAm/HuoIY7QbzTD48nmsOaJAEQFvkqp20sl8cXlBRW46rpCUvmJyODq
         YczfFQux3NTFnPZZll50Lk6gNdTUqXynJFj+23wYtg+MNigfKGqxbqjORFm9jwYwEI8X
         7XBd1hMjOZLU6P9bsunZ93VZ2mr9vv1NeQ2RSX+L2CweWLLENcmR43AfqbCa5sM+x7yb
         oJIu0y7rrOeo0KX+zkXywP9BZkyDnbbUglKXp/0lIx9wD583028koq2/MSJiPXfGxgsW
         KiPlyx5aFamLbGzyQ1CIMzjjf188hEd+uJK5jYmRqugGqDlutbtNfSsEGsNxcfIwxQ+u
         0DXA==
X-Forwarded-Encrypted: i=1; AJvYcCWfGmPlvYC1hTHopJsSCAl0jqP2cep51xUy61vPaI29kLHyiY52OLGKNdNx/lvyr9TCg/i89GMsZct+2aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4y64L63uue9OOy/uh2WGXpsWXr/BD0z5dT8/qNFrtcP+pauw
	Jtu9W/4weDrHNZARk6a2VMA2MpvRepysbfXUegdFHTgUciQmK7qHArYxxyEi2x+8Zy7CAMFDkCo
	/OQAZZGfVe0q3c1TWsmkpBtMiJ0rRzYzjU0yjVBtaxpKDBPJfSAS90B6njFiLOyC3UA==
X-Gm-Gg: ASbGnct+94AtQxt4jW7hTqKiMxYb+iKBpAqWo2uklDhZ3l1nxtOjVseWN6BjVfy9k3O
	PzgnifT6WhnfUNiHn18x1nUl2f9Cj5wMKveXoTFPVWwkUlINaCFpmcQL6kMavImd9rQl6yLVJsN
	u1mhpmieV4Ye1UezMJgxkHfu+6Rzgpgxo4ucHwi6qNW2xO5WsezODJBnpkQBFDo+B55G/fkMmwQ
	SNbfY/LBaywCjsKk/6HKtprrt0MD6pTBw02ZF3cxtQhCP8gPZtwSECymaD+7amRxd1vsaJToAz3
	7tNZgVgwkDeAJrOeL++L4nBY1q/9oNGuBMd7S7OhqA0=
X-Received: by 2002:a05:6e02:4801:b0:3e5:6882:661e with SMTP id e9e14a558f8ab-3e568826ad7mr13160245ab.1.1755117032063;
        Wed, 13 Aug 2025 13:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcKo+ouYURgN6xzgrRL/vMnntYrb2krbn/TmGX1YtA8BbnW1ZDyxxp/DIRh8HDMtndTjAL+g==
X-Received: by 2002:a05:6e02:4801:b0:3e5:6882:661e with SMTP id e9e14a558f8ab-3e568826ad7mr13160095ab.1.1755117031676;
        Wed, 13 Aug 2025 13:30:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99cff85sm4118311173.37.2025.08.13.13.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:30:30 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:30:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v1 4/6] vfio-pci/zdev: Setup a zpci memory region for
 error information
Message-ID: <20250813143028.1eb08bea.alex.williamson@redhat.com>
In-Reply-To: <20250813170821.1115-5-alifm@linux.ibm.com>
References: <20250813170821.1115-1-alifm@linux.ibm.com>
	<20250813170821.1115-5-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 10:08:18 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:
> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> index 77f2aff1f27e..bcd06f334a42 100644
> --- a/include/uapi/linux/vfio_zdev.h
> +++ b/include/uapi/linux/vfio_zdev.h
> @@ -82,4 +82,9 @@ struct vfio_device_info_cap_zpci_pfip {
>  	__u8 pfip[];
>  };
>  
> +struct vfio_device_zpci_err_region {
> +	__u16 pec;
> +	int pending_errors;
> +};
> +
>  #endif

If this is uapi it would hopefully include some description, but if
this is the extent of what can be read from the device specific region,
why not just return it via a DEVICE_FEATURE ioctl?  Thanks,

Alex


