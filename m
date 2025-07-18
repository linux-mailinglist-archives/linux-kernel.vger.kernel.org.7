Return-Path: <linux-kernel+bounces-736598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9180BB09F21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053DCA825B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7929826D;
	Fri, 18 Jul 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbMJwHnl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4967296163
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830374; cv=none; b=nk8lFVQ1+l+aWo7sBccrSzGKBWoKAqvE1PUIXSh6HzF4jNPSllnR1mT2qy7uZzsYMzpn0NVnnevtBnuv7Aqjz0mbxPF0iE9VOjGtKjPZJvL+qJGAW7aMBrFtrEawUXRaqorrmXA/FJm1gcPosIsAouCy0FDwlOe3P3XaY6nXK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830374; c=relaxed/simple;
	bh=9OGXC+HPAx7wjOFmvBxnXdWUJNWtIqbDCCH7mHqqr6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/uqsmHv/upSacZFYjtRjWV6sX4qG7z3MyuoAdo9zNi65vvqTgLDAQzdNxbOMEfJk3t0/HZSiV9eZ1aw3wExpFR9io0GzYmw67g95ellgX315eD0ErB/UP5jl1Hm3gMwJC7qfQm5co0rRJTUjHi0S/YBD2JOwpUzOL81A4na2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbMJwHnl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz7VEdzguNgZR75iuoM9tSMqqnHJY/Hj/MLHh0vHLZM=;
	b=CbMJwHnlkstLQpf5jyc/1JXPdwrjWhd7Jesbu8p1dseqEZ+ga49ps3iZja5hNVQ+N2pcRD
	3VSaQuT41QPkmkxi2kB2bDEmFZQfkc4zH1JuuNxxt+sac3SIi6VmKFGvTW/ZWcYauWMh+A
	mV3uq+21LPx44mpNLbBYreKXn+aZ0uI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-Dki8DEKDPamYJRbe2gXfRg-1; Fri, 18 Jul 2025 05:19:30 -0400
X-MC-Unique: Dki8DEKDPamYJRbe2gXfRg-1
X-Mimecast-MFC-AGG-ID: Dki8DEKDPamYJRbe2gXfRg_1752830369
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4538f375e86so17251205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830369; x=1753435169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz7VEdzguNgZR75iuoM9tSMqqnHJY/Hj/MLHh0vHLZM=;
        b=AlM8w6WaFrkEaRvG4NXD3+krsE6k28VDWdePYn374uYHbKO/Fz1gtwvHGrOGWkVV9W
         KlL6rXWVv/6Ty37LGAbm4UA50ugIv/mKhQbkVkLeusO/AD/o+vMa8o9IiRTV81Iop9dM
         4Drp4YNvftSAsEL03pjtGus5fi+YB+0KBwXD+ux+LSe8A17q5gmx9k99NLiYLnpJQZH1
         ZugcRqiXx9KyaJ6Vs3nxNLCw22fI/oUF/kXDy9ONybXkHe2Qa2iUPNRBSODpwfNPXtsK
         vNPiUXxVUczaANqizGIY32TxQDgmb6ZNE0GEhcz+SB6sO0h9oLGA2Fpx6Z4WA4C3AML5
         AcFw==
X-Forwarded-Encrypted: i=1; AJvYcCWlNmGPd9uFsBAUeFFg2hH9xKL2kCypZP5J6skOA2gew9yrqzHCfsLOkODxhEYshB0tO/YBarlVRu0LNsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbEuVcLBqzp8jJ/BcsOvKoybxR2PLg/+La6W/H0YpkgqzmpYC
	/YWMOoYhzMpQmmbLbMdAhlpto7Mly8afOSkFBEo30sn9sQ6UuIgOovLKVm4khnek4LOlAD9q7+b
	VyEYaKWqW6wdfmLZDt9gthf5XSrFD+QMm2S6CF1muAeWFYX3I+8dHOUhIdI16EISK2Q==
X-Gm-Gg: ASbGncvtHD5tbzG5pL6J7nc7cQ0YHTbvOPhmtwUzwobZa3uZb0Lwwq7M04wuagXHXWX
	7y7Gohzg9y6/8UI3Bd2qrct4X81hRyBN0rF/EfNFtSdBI2U9V3yoixfXCborXiBZXjWY5HB82eI
	asRlFQIv2Fsg3sbVuCe6JrDaHlvnIkuIHufEbFRG+ZPMI8IGSiqj0cH7AOPUzc6nsNmIEegLj9W
	LEP4QN4CYoCvzv5wbhlPAQsLHR/0gM2ctOZqep4bowOCiqk41LFsbdnjcmdj9TvzMbCWWXGaJqU
	04nrqxUnF9o+rwR6wiSLZHCKj9qdAM5FFM5mU113YMjhjFdDuxMKTT/odl0AkMpxrBFTVMrtWjI
	5FHjBa5YBGl0=
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr5390087f8f.38.1752830368955;
        Fri, 18 Jul 2025 02:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTjhEq8p44r045oEYKw5E0umkCtE+yHNEk65pXbCxLQ3y2DbvrtoknVhu/Al+Bpx9xmKqa4Q==
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr5390060f8f.38.1752830368389;
        Fri, 18 Jul 2025 02:19:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm1288433f8f.36.2025.07.18.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:19:27 -0700 (PDT)
Message-ID: <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>
Date: Fri, 18 Jul 2025 11:19:26 +0200
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
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
 <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/25 4:04 AM, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 9:52 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/17/25 8:01 AM, Jason Wang wrote:
>>> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
>>>>> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
>>>>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
>>>>>>> feature is designed to improve the performance of the virtio ring by
>>>>>>> optimizing descriptor processing.
>>>>>>>
>>>>>>> Benchmarks show a notable improvement. Please see patch 3 for details.
>>>>>>
>>>>>> You tagged these as net-next but just to be clear -- these don't apply
>>>>>> for us in the current form.
>>>>>>
>>>>>
>>>>> Will rebase and send a new version.
>>>>>
>>>>> Thanks
>>>>
>>>> Indeed these look as if they are for my tree (so I put them in
>>>> linux-next, without noticing the tag).
>>>
>>> I think that's also fine.
>>>
>>> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
>>>
>>> (Note that the reason for the conflict is because net-next gets UDP
>>> GSO feature merged).
>>
>> FTR, I thought that such patches should have been pulled into the vhost
>> tree, too. Did I miss something?
> 
> See: https://www.spinics.net/lists/netdev/msg1108896.html

I'm sorry I likely was not clear in my previous message. My question is:
any special reason to not pull the UDP tunnel GSO series into the vhost
tree, too?

Thanks,

Paolo


