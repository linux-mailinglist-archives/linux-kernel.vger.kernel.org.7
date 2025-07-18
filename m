Return-Path: <linux-kernel+bounces-736646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F78B09FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FAA5A3882
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5029994E;
	Fri, 18 Jul 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay3N3eBF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB2298CB6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831855; cv=none; b=m/GoaDGD8diV6vZfukmWXzxJciZBG5JbDIEyXDKIKWqxB9lcdRXDg9tYKy6lktUvxbgpmClt9pSAl3lS98w/dAl61qatKXuM8dnKS/mKCYYPmuWa00svI7nuPSCrhBnQTwEOsJea3+BsBBKuVKVXe/GXSkvu5D7Iu1fFd8G+CQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831855; c=relaxed/simple;
	bh=T53jj+uGYaYf52lKowm0CpjH/Cq7fLwZZogKpiquQjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=le+9JO5qlFF+YOKHzRmZhg1yb0xcXAKxfwX9Fx47dYGSch1/HVkf4Le0k8z52YkmHusOZZQRsZEC+X1h7/ew5XVm7hl66SyhNGqwM97uIwdJVgAMQHTEm2KG69gYsMJdrvOvwXDGRF58V/0Rzib3x24urrwn7RBjHqXaQ/DdVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ay3N3eBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752831853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T53jj+uGYaYf52lKowm0CpjH/Cq7fLwZZogKpiquQjg=;
	b=Ay3N3eBFesABuQCUTL+iAbg5xX2Fco53b5u87XHFHAu0NqQst1a24IUKzNW/5mBpSDi9qK
	CY1Aa0bzBGEcCX1z3JvWBx56WAfmmVGv9hxbUX/kc6k6GA9cJdOxsKo2qhiYwMJ5auS2jh
	WA7s/CByaVwCibnMLDLvdWLZFM/cRdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-zmVawsAyPAOsvlvmy6m6vQ-1; Fri, 18 Jul 2025 05:44:11 -0400
X-MC-Unique: zmVawsAyPAOsvlvmy6m6vQ-1
X-Mimecast-MFC-AGG-ID: zmVawsAyPAOsvlvmy6m6vQ_1752831850
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so1216074f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831850; x=1753436650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T53jj+uGYaYf52lKowm0CpjH/Cq7fLwZZogKpiquQjg=;
        b=FJRFs/v2mwc5QLs0Jyr2uEB5BllNQBo71M6f7qVI5BFuM7eVYiXAoxat+Lq4ckedIc
         y/B/yjXkEK2JjE1HC8lSxydLpG5BVgU8jIour5Ml41lPXQI3ZM5j2+evpWsm6U+rr+OM
         hWgtLvN3Rv7gOm9gT9JrqgR7f350aBb2GJTwEzLI8WG69/I2w8Qm3XeR0aEq03rp7/IF
         hjVpVmUnapvIpzYqK9TVR/WlBr3JcvT3ynxMXqDhYCF+P8WVzE4vEgGy9HEJBpbmimHw
         X4k8FexMMree5dNH57+DGM/sy4Esk3vxvSNS65ZI/ZppxwRsjV08HWZb9NyRko/lIq69
         tDxw==
X-Forwarded-Encrypted: i=1; AJvYcCVIvZ6tCUx1TJPlOQXX1t97sxtNEsaiMlj6EMpdrjuYOj1RhYfFKIyRRuaFBGagq5gipE4LWgrMj9S8bIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfE6bFceuchWKcuZSh958xVnF/w20Jezw9NSlIh94P61QOFkv
	yc1GcQzOFoWMuBokM573Ptv/eOMww2gau++Lw8bI7eOmihPLN4IYPpJYjlnJz1J4e7BcN173Tn0
	vzMEqWWlqzyPPVqWun8xijxiJUXNVT68N164OzTwOsTwpKybRYmYFYLDzbXUH5tiPVw==
X-Gm-Gg: ASbGncss95J+J47Zf/JNsv+zJ/yaJvPdwhcmLk7xaC+866R0Dymiil5IkItUEqqlOfc
	wYsKxND0NCAs2kSlswJw1gc1AflEJHmuQ6h3CPnA4aUbEQsyVnGDN6L2Y8Mjougef91gDrGifrp
	hrGwhIp5ZJstMIIs26xz8QnUIDxKJGCYp2h85ZcEblm+b1BJd1GOYEwu+lBuUj8cELhnirtWPP4
	5RPD/veiBNQrKZJ3mBRZG4TszWjdELCYjAPbXTseXLWgM0oRI2++d4JDb0OolDorlHAhmpOZygL
	QbmFdZF2ZISziYVke1JDrbJRsJGxBxiegExImu9ULic9p9JUw2vA8Lqhcoa4Zb/ZZ+EN6zhePWv
	8UmRhUoH1aKs=
X-Received: by 2002:a05:6000:2485:b0:3a4:eb92:39b6 with SMTP id ffacd0b85a97d-3b60e5188a9mr7814166f8f.54.1752831849695;
        Fri, 18 Jul 2025 02:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwyvbO1naMxXvga0v2Mf459n4z6Zb+LqD86VjK+yx3D7c4jUHgFpj1B2IMb4iTSN7BmDYzvA==
X-Received: by 2002:a05:6000:2485:b0:3a4:eb92:39b6 with SMTP id ffacd0b85a97d-3b60e5188a9mr7814146f8f.54.1752831849175;
        Fri, 18 Jul 2025 02:44:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca487a5sm1334017f8f.42.2025.07.18.02.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:44:08 -0700 (PDT)
Message-ID: <3fe2d2e6-993c-4344-8fb3-ff6625aa91f7@redhat.com>
Date: Fri, 18 Jul 2025 11:44:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
 <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
 <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>
 <20250718052747-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250718052747-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/25 11:29 AM, Michael S. Tsirkin wrote:
> Paolo I'm likely confused. That series is in net-next, right?
> So now it would be work to drop it from there, and invalidate
> all the testing it got there, for little benefit -
> the merge conflict is easy to resolve.

Yes, that series is in net-next now.

My understanding of the merge plan was to pull such series in _both_ the
net-next and the vhost tree.

Pulling from a stable public branch allows constant commit hashes in
both trees, avoids conflicts with later vhost patches in the vhost tree
and with later virtio_net/tun/tap patches in net-next and also avoid
conflicts at merge window time.

We do (in net-next) that sort of hashes sharing from time to time for
cross-subtrees changes, like this one.

But not a big deal if you didn't/don't pull the thing in the vhost tree.
At this point, merging it will be likely quite complex and there will be
likely no gains on vhost tree management side.

Perhaps we could use this schema next time.

Thanks,

Paolo




