Return-Path: <linux-kernel+bounces-850098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F23BD1D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77071898A88
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584772E8DE2;
	Mon, 13 Oct 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXip1egU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E512E7F1A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341061; cv=none; b=o2+ZYFJTuV8IMUxR48VflI5D5Jfmlceb5zgSYHzKFNuVwXCb3FrrSSzStBqutmQbAoK/gT3Kr/t3PNUKecly953skCnNt9vr3Tvt4AMdiC2UeWEmG/lyy95dowxnZO7myXfo0+LaXn94DQhA5hzUE4ZFPvFl7yNzRQDUz+LiUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341061; c=relaxed/simple;
	bh=QavRGcr5us+t7ZQ0SiFAKkIUSpfw/02p2jIBPVYNY8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpn8ZZl5Py5yyTN+zZ9pk3F1umCqyP7jAynn8ZmQO/YYL5MK6eTYSiuYCA2vYFF8ffUizgaeaBEZTvwrZWrur9hamNJzW0al8bBDK1QzpPOwZG5CIdKkpN+pqLW5gYMO0Wlnq4szVpcTa8n+4UE9uLhPuMCsjGGZSRBt/YTX/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXip1egU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760341058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhV9pCLfuO4+7vfM+XZ8BJUrYFHf5xM/gGd3XHGNreI=;
	b=VXip1egUKOafzpWmQZnXhFXTRP5y+5/CLADz0U26Ch9wA9HwafSlqloQ/PyMPqpbQLMfK1
	1wAB2k3sLH6mjKF+Aju7yHGWZcBw+zrsKLkB5YwGgdmGXcFUBjVruJ1ooKXDHlYQoicceV
	vAvrs7LQuEcJsEZSFoa3ReJzufy2gYM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-7ojU8Rm9OVWIC353t3WWHw-1; Mon, 13 Oct 2025 03:37:37 -0400
X-MC-Unique: 7ojU8Rm9OVWIC353t3WWHw-1
X-Mimecast-MFC-AGG-ID: 7ojU8Rm9OVWIC353t3WWHw_1760341056
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3a049abaso29636025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341056; x=1760945856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhV9pCLfuO4+7vfM+XZ8BJUrYFHf5xM/gGd3XHGNreI=;
        b=r2KIKQ10YHwHKkJChj/v0+6m+sr9HC+Dz9PqWC2h/MoFHklUFZmdL8qI0XiVwzaZjt
         4+33AyDzd/ERqAYOAHV50F/WxORf16HAbHJUlsVFo+54/vTF4FxIFsaBsxX4QAIQr42E
         8V9uGKzNHABUUZ4SjzilJ7gxRs8fZHDHeby9+czqErcgXHoZOquACdN+JCPY3xqOHsg1
         yTWIPbyI0sq8xXnO828h/oPDMW8xrUtNwWuY4USNoWwPjc7UDNiThiW+WdfW7Iu4K3Y+
         57ST/D8Y0wGJf3uQCI+/qnilOsxjccaT8n9MKwkAE/XstnZXKSzXWnNx8Ikz1xJAY11t
         DRZA==
X-Forwarded-Encrypted: i=1; AJvYcCXmmkbK0nWdWwI04UnAQPh6TgUU+Nyr5sNsI+2F5qQRmLxU2n2OUJFil2e53JHFFOx/TGKGwpcxJR0ntPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLUhVzqDabM/BOn7y+jogfrRHdtmLfRjSPSOVZF2cGSJtEUID
	GcZFz/vyS5kg1kZEUTfqdjxlLCxPa49TpY930VsMV9bnLQTy5G+zI2BKNXlw7mYbKxA55oUuiHz
	qBklQ4hPn1r8KW/w+XcoSdcAlQXAg0wKMY7g54jd/xL8A/B7dyBCQNVJx5Q/OUIAK7XMv6yhNRg
	==
X-Gm-Gg: ASbGncupsyDGoy3ZCFJwlAxT/jbDaHrFbSL9Rsrm1Le6psNA/mlMSI3aRZcrqFyZYO3
	OiEki0Vka3zn5QLG51Olxm64oCdjba/4m2IwZB/57JaSEZZDGjxS+5lOIK71CiL/AjWhl1f10AV
	GaVHAP9TOpGVFlvqEstRpnndfbajUZp1dZg0JODkCudlSIWh8p7tVrwcpo4vbdEaGNrilUdC8gB
	Toaf0ylUS68Qjs0yPCuGPGeNdwLI9THGqbN7gc4Jad9InH97aQLNqkwy6/7jQutPSQ07fwyFMhQ
	gksSrllNyHnGShJysH/JMGi+M3s4SLp2yLQGS2QU27S5
X-Received: by 2002:a05:600c:5297:b0:46e:5a5b:db53 with SMTP id 5b1f17b1804b1-46fa9af30f0mr121221175e9.20.1760341055656;
        Mon, 13 Oct 2025 00:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hJl5V5jje4Mv3eVG6dVD7tglU9SGsJ2gOGFWCHIkFUforeKvUDKoupvg2eTp/qCQ7E7BCA==
X-Received: by 2002:a05:600c:5297:b0:46e:5a5b:db53 with SMTP id 5b1f17b1804b1-46fa9af30f0mr121221045e9.20.1760341055271;
        Mon, 13 Oct 2025 00:37:35 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49c3e54sm171604185e9.15.2025.10.13.00.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 00:37:34 -0700 (PDT)
Message-ID: <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
Date: Mon, 13 Oct 2025 09:37:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
To: Jason Wang <jasowang@redhat.com>,
 syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
 <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 9:20 AM, Jason Wang wrote:
> On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>
>>> #syz test
>>>
>>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>>
>> Paolo, it looks like the GSO tunnel features will leave uninitialized
>> vnet header field which trigger KMSAN warning.
>>
>> Please have a look at the patch (which has been tested by syzbot) or
>> propose another one.
> 
> Forget the attachment.

I have a few questions. The report mentions both UaF and uninit; the
patch addresses "just" the uninit access. It's not clear to me if and
how the UaF is addressed, and why/if it's related to the uninit access.
Do you know better?

It looks like the uninit root cause is on "the other side"? i.e. the
device not initializing properly the header. Would unconditionally
clearing the hash info implicitly disable such feature?

The syzbot dashboard mentions a (no more available) reproducer. Do you
have it cached somewhere?

Thanks,

Paolo


