Return-Path: <linux-kernel+bounces-741181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AEDB0E11D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F82D58113D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089D27A46F;
	Tue, 22 Jul 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="paXIAdS4"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B6279DC6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200013; cv=none; b=A5iVm94qP8zzNfR/YF8MICwzzCbFX7xqCHKtnlEc+orfwnZLLl5/r9r8z6NbPo8vftNqt5AzLCmDxD0ENfqW67u04J5GD1hWVlITW5hOOH7otQAbgGrqBUZXE8FDdZSuAyfEZ1bgghwmOqB0j3yjIT9z3dNA4iCw9m7dMxzho1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200013; c=relaxed/simple;
	bh=WsBdtMBoj90iQrQ03XPwqb6NRyogIO1bWG+l+t48EYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKrSTWxVDRt4wZye9+hEQ1ZHWFdAPpvv9VuA19WfCBtcgrYPA/lqTsOWIf8fNus3lu6cVoVZa8HPRdNttBuR/4mkwEa80iubzGHlPhdImarwG/x+Mq9ZC+n6MyZT/9KDEL0nln+ulSIleDRxEDKUQQZ2zWfta007rsP+eU+x188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=paXIAdS4; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e293a3b426so55828125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753200009; x=1753804809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMWmh8ZJz4RNGTpOucEqzMgM2GUTJ0q3JCmyXuVkkBU=;
        b=paXIAdS4yEQEeoOz+1Qx4mXFmRogL/wgNcERpdDBj4Y9LuHBMAZvKmHVA9GzcMK3AZ
         EM9ArHIxTg6JirsClaQnyhgwrnywRr6VXQrRxwrrIZL1tCU1y1pXd6ob1F5UmC/q3xC6
         wTlHXYpV9pPMwHx2rc0JTFDodekXPEo1nFM1y7dC7xrVjOLDf+EFAsOJUm/OI6jHNuFc
         fa8EyTbTyCPdbhoIgou7vyXf21DsK0JqjeJHKBnkLXhxvYY5B/v/MmJbu4NWK0JYErf4
         X9/UNo8NKCGvC5+doafJ18S21slnblOCEQWTt2QsU5Miz4JjpXiPW5qFo5x/UCuRVHcb
         7HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200009; x=1753804809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMWmh8ZJz4RNGTpOucEqzMgM2GUTJ0q3JCmyXuVkkBU=;
        b=I/9P3WnQ6wpfH3WMIN4DD1BLWCNoX65QjD3Cr8PxYADBtHqOne4EA3xuZ6Q7rDJ1jx
         9Del/Y9j8mb+02l9wgXz+46vD40XTi2b/A0jPvWl5BTo4fUTfdQmGRLZcVwhXQhIifNa
         1p+MreJq2Hk66kzM7ZGkJGkwlBYo9VhA9PHYRj3NTHYIet9XvZbL/Rvyo7m285IlKx2W
         Zm/HAhllVYOsLp1W6Bl46bkZfttbHu4lub9X2oOIk9wFn6OmG8kYkk2g8lQnA0zGf0LD
         V9bVQ8uvpQ2AIKdUl1sZ1CbNpv2Gdwe+7rk8hueJdUtntMZoPr2U6R4wrHQbofTZN+l9
         P7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVuH28O7v8jIEEE/bHlK7uOn1Xb2iedKzUkzdoD4OATMSU2E239l/UDB8LrzVxyF/UiN4+8RfaMiHgUjx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlfmfM0Ygw8gq756Sm+cVfJD7IGJU7rqD7S7khGFhfpPjf6jm
	DIoVuarZRxOInXk6hpS0f2Gisb4CQSrtm9vNm2EH9eoNLTB9/nwBfd/x3pGH1PuOkShLmjbHsQ0
	YjNhf
X-Gm-Gg: ASbGncvlQLIeX8zguo4H3jD8nQpZxRUTWzrh2gID7qVaKdj7W49v1x6yYln9luQZQhY
	0GXIQysj0vLreAq4AnAroGu48Fqb9pkhkZzqvucrnDPAtxxfIcrs+jwknrqljhXJ+UgjdEgTqng
	JDq+/qRuxScAcoEJBGtLjbMuNmYa2z4Umj4KvS7T4gTpVDT1dqO9mFgi6KFvJyrErv9mxb0MaDi
	lF4x3jNYSqy3XzFNqu3oYdGKiUfr4DZJHSMPmZ+4DHaLTmIv6dc73l6753gsTY30jl2HBL9C0Ld
	HUqClAiNvjcykYQyFIBB5lnomGcaw/nhFOznjWnDhb+QRd/ver9XBgKicYCIy0RzOa0/BO6oKYh
	NiRVvi78KnZXl2gkWIg==
X-Google-Smtp-Source: AGHT+IG1W0AUZPbeKYtFg/1aC8vr5dH/lfI/B/kWb/+3OVUMQfy9fizHB+LNH9J+P2Mnz+t7jVQSdA==
X-Received: by 2002:a05:6e02:1a89:b0:3e2:c215:138a with SMTP id e9e14a558f8ab-3e2c2151564mr46618355ab.12.1753200008339;
        Tue, 22 Jul 2025 09:00:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c8042f4sm2578678173.57.2025.07.22.09.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 09:00:07 -0700 (PDT)
Message-ID: <ef2ee915-a74f-4fe8-80f7-dc940827b302@kernel.dk>
Date: Tue, 22 Jul 2025 10:00:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: fix race between polling and detaching
To: Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 H Hartley Sweeten <hsweeten@visionengravers.com>, stable@vger.kernel.org,
 syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
References: <20250722155316.27432-1-abbotti@mev.co.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722155316.27432-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 9:53 AM, Ian Abbott wrote:
> syzbot reports a use-after-free in comedi in the below link, which is
> due to comedi gladly removing the allocated async area even though poll
> requests are still active on the wait_queue_head inside of it. This can
> cause a use-after-free when the poll entries are later triggered or
> removed, as the memory for the wait_queue_head has been freed.  We need
> to check there are no tasks queued on any of the subdevices' wait queues
> before allowing the device to be detached by the `COMEDI_DEVCONFIG`
> ioctl.
> 
> Tasks will read-lock `dev->attach_lock` before adding themselves to the
> subdevice wait queue, so fix the problem in the `COMEDI_DEVCONFIG` ioctl
> handler by write-locking `dev->attach_lock` before checking that all of
> the subdevices are safe to be deleted.  This includes testing for any
> sleepers on the subdevices' wait queues.  It remains locked until the
> device has been detached.  This requires the `comedi_device_detach()`
> function to be refactored slightly, moving the bulk of it into new
> function `comedi_device_detach_locked()`.
> 
> Note that the refactor of `comedi_device_detach()` results in
> `comedi_device_cancel_all()` now being called while `dev->attach_lock`
> is write-locked, which wasn't the case previously, but that does not
> matter.
> 
> Thanks to Jens Axboe for diagnosing the problem and co-developing this
> patch.

Thanks for taking care of this!

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


