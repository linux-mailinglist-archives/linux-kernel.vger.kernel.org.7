Return-Path: <linux-kernel+bounces-862375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCABF51A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31303188A423
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EDE2BE655;
	Tue, 21 Oct 2025 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPiBy/9i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E82874E4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033073; cv=none; b=DFozJ0+kVapKO8SJl6ADZuN9xo2/6AE5UahR24VaUlVc6+VkSAXJtBQiqTwppM5vpv87xllZ+s8TJRTEe55TMXm2AFu6lTIVRuqWNZBGdmWJ6g+Amw0FwNczCYhRMQQI684NoqmVLAq0ZnisXD+xY+zRrjCMlY3s5s5gOf+i/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033073; c=relaxed/simple;
	bh=YTsIbx04l5qgIFskYWd59hgzfuTSY/THNv/uSHG8Xqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uq2aj7+gA4UZ+GkoA4pHhwzY1B5Iagf2uSHmH6zj2ubWSO1w7Km64NDiv9DJgheaf9cj09nWIQcr9G+/92mzXhSeQgfLbPbHuxTn/IJlc7WgyproS+6Xm/ntCT711neDKQJ1sPakcFtQ2GsVY81iCzsgbeSWNSyHiLTmQs+pOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPiBy/9i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761033070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h6fa2qbHoy++SvDQf77xOSpwekaCSKBmi7FZ2f1xQY=;
	b=DPiBy/9iPpWv6wJZ2mYKnhsjh8DUYZ0F9ZxMwNS++1NJk0MrWJiBMwU1QXw8jhmLWAUFUW
	gQlxlj7KhzVNeaFvSyPrDEHlRnQ1anjl/aabQz7EHMX4CiLQHeet29/F9p1fRY27AgcBs0
	1mv+3NQmZbTEcT1daTwptvnMc07q9YY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-IxMY83J9NpywQ651aTL1VA-1; Tue, 21 Oct 2025 03:51:08 -0400
X-MC-Unique: IxMY83J9NpywQ651aTL1VA-1
X-Mimecast-MFC-AGG-ID: IxMY83J9NpywQ651aTL1VA_1761033067
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3027757f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033067; x=1761637867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1h6fa2qbHoy++SvDQf77xOSpwekaCSKBmi7FZ2f1xQY=;
        b=Spsii/NUv5C45/insDI6kJuiB9+2veYzO9yb2yme4BGw9qxNwsolREnKID+3eMo1at
         pBKohmDSHM4sOlaCdRlyyOxQy2ymAPjOYdUSFmZJNglKjYQP1w1b4YoGd40ep3ljvLVJ
         y4ZxvVltSUrfBQZ8ndtKAC+2J+sraQU8rcjpXup5iBGnYhjK33fIRyq/qo8Ch60HQp4d
         5l1F6jvctFg1haHbgvu4zwOn17+2ksTCly7LrGQsOVPEzpu6keaKn8VEI7V+Sihvs6dg
         DVoVvRRl47gezaMlnotjfGB+HCHG12RKBxAeqtkG82SacH42picQCCz/HO8JtcV76gL9
         LVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUML/RhsU3Z6W09E1CluI2atWwh9jdTm487VIMs6CnnBG6oNAEfpcMerYPlqDvgWbYV98tslM/fjgCoIVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4E4qlXTCHde0pe1vNwRSg4Pmg0ghrgViMJy0jUHX16SmaeJy
	1ticILrsYz5lU9r3VmOZx+H7nFjAae33pvQ7hVCeZxOlkCLsVeRd2gAmcNy9B+aHSGqRi7avrZJ
	h24IcJpydJEbSWZTfd1h+AYZCJKWh74o8Rj/Ys26jb0G/uMl/WCcvRQRVMQJ1/mdrEg==
X-Gm-Gg: ASbGncuwg7XATomx8s4T6++UQxUTVbw70hmhsNiCaEFcQtG4OGK8WGVCjgy/mSszrvl
	YnxKNV9ruVrfC8G0tL0uMvxmy4ThuBvDB8QzCNwFgoSlfBj5/X/Fu9QZ6lpVQB767x2Kcq7LTkJ
	2T7O6go2tfi3gHpTSWC4ovrBHJYlybh47Z7vMEcrzE43sYy4UlInAZXfh5tsR3NSnfrlqmtHM8G
	l+KM1itWhIXmINEZKL2xucWF8akQO0GvzbbbxopH8s+yEg1oFyX7dC9i4VBePH+4XFppGvCsE9B
	kkkcHVqRr8Ui6R+1JmD6xSJfawVh2XWNdKEXUZ5qX6obdWU2Y27TH9SedEEuqZOQwRmIpLKJuOd
	6W00vlvPs6oQW9IHwguidkt3tQnwGC/S+4bgcU0DkvV4Ey04msCs2bzn6rw==
X-Received: by 2002:a5d:64e7:0:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-42704bc0e86mr14036924f8f.16.1761033067215;
        Tue, 21 Oct 2025 00:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz8/veJYRT8JadPcK7SQ32pn8LgrM+ivv/Y11OS7FOCN/IU1aUPsxB4lxzjs+wdp1rzZtnZQ==
X-Received: by 2002:a5d:64e7:0:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-42704bc0e86mr14036895f8f.16.1761033066816;
        Tue, 21 Oct 2025 00:51:06 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427e1be5d6csm18888806f8f.0.2025.10.21.00.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:51:06 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drm/solomon: Use kmalloc_array() instead of kmalloc()
In-Reply-To: <8dc12a18-58ee-4df6-a9f3-12d8c05a0954@gmail.com>
References: <20251019145927.167544-1-mehdi.benhadjkhelifa@gmail.com>
 <2541f99c-1081-4253-ae58-97654694cd78@linuxfoundation.org>
 <e4f0290b-5d15-472f-acee-e1e1b0629ec0@gmail.com>
 <3f523293-8a8d-4136-b4bc-4ad0d4a50c59@linuxfoundation.org>
 <8dc12a18-58ee-4df6-a9f3-12d8c05a0954@gmail.com>
Date: Tue, 21 Oct 2025 09:51:05 +0200
Message-ID: <878qh4ae1i.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> writes:

Hello Mehdi,

> On 10/20/25 9:56 PM, Shuah Khan wrote:

[...]

>>> I have a raspberrypi zero 2 wh that i'm using in combination with the 
>>> ssd1306 OLED panel via I2C to test it's rendering and it's working 
>>> properly by using modetest and seeing no regressions or warnings in 
>>> dmesg.
>>>
>> 
>> Send v2 with all these details and why this change is needed
>> in the first place.
>> 
> Okay, I will do that as soon as possible.> When and how does this 
> potential problem trigger? Is this a
>> theoretical or does this happen in this code path and how?
>> Next time include all of these details people understand the
>> problem better.
>> 
> We'll do in the next iteration.Thanks
>

A similar patch was posted by another developer a couple of weeks
ago and is now queued already in the drm-misc-next branch:

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=940dd88c5f5bdb1f3e19873a856a677ebada63a9

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


