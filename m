Return-Path: <linux-kernel+bounces-735383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFBEB08E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259E23BB527
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D8A2F49E3;
	Thu, 17 Jul 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhxaB/k1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96021ABA4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760354; cv=none; b=J2HQ25H9cYnezOglVcHxJOojZGCYoj2V30vyCkEJSl3F5OM17CWlOZMit7aq6JiouCSycZRD7alkRbKFyYehPMhDZYPJJPfZ+raXHq3o5p8WlGX6U/7qznJmgike0U72SpSt6LOpREMYgWkDWifLoeq8gYTlqjv/OdRPPz0oUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760354; c=relaxed/simple;
	bh=FOknZPaa0ET0wOU5En/aokMYWIKU8p4UDlNpWqYvkSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6p9QaFgObp+BVI5XOWpLpZL9j3ISyDsd9DoxgKQ94eH/nFBTqXYX6/xdQeB+W7KSVt59HdNw1xmfdcyxUiUKmBgE+NCOETfMnXukiPlcOl8onoanivt5J9+c0rcgf8NPFrN0zOiyyvSYTz94uEFCufihgytoap0zt44n8twBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhxaB/k1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752760352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGvAbY32RFgpjRdN6+3XL6T/YF5F5zsdWuL3mzQK87Y=;
	b=VhxaB/k1tkzsvJ4im3oxGdWOFzDtVcwd+T0I7PD/MimspYFT6y+RMgTolT0rbYJhlVqxip
	+9dqLz7iouxzCBILBHqOT7lhOAQhyyXQtqIxDulCwKpCHbrGYoYfNT13i5l/0VeCEKhptY
	S6ah3ur24HZXA5E9Z8nJ9PUuLICBFTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-nGXFueaMM42UCxdGTE9ATQ-1; Thu, 17 Jul 2025 09:52:31 -0400
X-MC-Unique: nGXFueaMM42UCxdGTE9ATQ-1
X-Mimecast-MFC-AGG-ID: nGXFueaMM42UCxdGTE9ATQ_1752760349
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso779531f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760349; x=1753365149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGvAbY32RFgpjRdN6+3XL6T/YF5F5zsdWuL3mzQK87Y=;
        b=TCSnRosVO9Q9XeXF84op/Q5W7tm5ymU2ioG3MHmii1Z8MK2OyT4l7o9NSaVS5yA5YI
         dBmqACnwRdA7jY9/2X8gBjgxD63zTTHc6TMuXMVEgQNCFsKFE955fUN8rdzJdp3pqe8E
         UrCDj6KQ5u0vaquqCZmkNQb0KwP+ev3AzAmJef1JL1HwP4xFta8o+nkAQPd60SNgMXc1
         TBbV/dvzXU8SqstvIY0UqFcJlA4PaG8FOWJ7ODziSvpFTsYJXHdmNVWLYfFKgDd2jIFn
         OTcryPbEz9mEKmxoEIFczpUaMrENKvEBQi4NAJRSQVMEDaOH7RC4TOYQHwo0sqEbjQF7
         YmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNH2SRUhP95HCLPXBM0PWd0hyuEEce4TTip7CJ9nX3CjQNnvMaiptGi1TVvdmUdwnUmjuEeFcxNYGFWpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHfoVSaz8qMryI4Yle+A4S8EQQt6324JtGK7P66pQeY0TNbY46
	axoRXSkQsNWCH04Bl75l2UeMAYisMCj5vvDJJqa+AlMN+YMXu48qFzfJ4DXrv+pYEdPE/D+8wD6
	J2nFEQhi3s5zVHMWfTHcJr7g7DQrLJDreN6PrhOzLRDFpJckShzSucm83YZC4n217qg==
X-Gm-Gg: ASbGncuKQn4sc3UNEqb2K13Tjsk1d+IuahuD29lG4TYextNjQ3lFLG1VdneYiNeji14
	ec9/87KPQVIaREtEXYHwsavj61D5oVXiQ8snXjE8w238sCMxW2A8yakxVQEbBALSiIYYrXTraEo
	MCuJ1EMpACVRDYMt/Ox/HqFmQDVots2vkxeD9qEs0AqH1pap8KZYbnwvF/0/03XKeuIx+C7aDjq
	eMzL2/Dx6vU9M2z1TChUs/PhYnSbRMKDqRg+el8cXU5L/GLQQ4HVRzbt8cICVovEeEEta6yDAEp
	3wufV5nMGSXyMt7gYiJS9fcNUFCau74UPiCUEMyYjLmmqWs2VD9GQTC4ZZZPZ3KVt1ujksM0kZO
	Ti/pO85NR9Sc=
X-Received: by 2002:a05:6000:2006:b0:3b3:9c94:eff8 with SMTP id ffacd0b85a97d-3b60e51c895mr5115038f8f.27.1752760348628;
        Thu, 17 Jul 2025 06:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe2UZsHx0A1qd64C0wPihrY+x7o7vx2ATqKIuSJI84BF2RqSh+4TT6WPjrhFeuw06hYTdARg==
X-Received: by 2002:a05:6000:2006:b0:3b3:9c94:eff8 with SMTP id ffacd0b85a97d-3b60e51c895mr5115019f8f.27.1752760348124;
        Thu, 17 Jul 2025 06:52:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d4b5sm21113467f8f.53.2025.07.17.06.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 06:52:27 -0700 (PDT)
Message-ID: <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
Date: Thu, 17 Jul 2025 15:52:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/17/25 8:01 AM, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
>>> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
>>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
>>>>> feature is designed to improve the performance of the virtio ring by
>>>>> optimizing descriptor processing.
>>>>>
>>>>> Benchmarks show a notable improvement. Please see patch 3 for details.
>>>>
>>>> You tagged these as net-next but just to be clear -- these don't apply
>>>> for us in the current form.
>>>>
>>>
>>> Will rebase and send a new version.
>>>
>>> Thanks
>>
>> Indeed these look as if they are for my tree (so I put them in
>> linux-next, without noticing the tag).
> 
> I think that's also fine.
> 
> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
> 
> (Note that the reason for the conflict is because net-next gets UDP
> GSO feature merged).

FTR, I thought that such patches should have been pulled into the vhost
tree, too. Did I miss something?

Thanks,

Paolo


