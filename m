Return-Path: <linux-kernel+bounces-730456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDCB044CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EFF4A59C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1925A640;
	Mon, 14 Jul 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ7RCpJ9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AE2AD32
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508460; cv=none; b=AlksmL8JDqDpxcExOGDsb26WXQeoJh4FKZ8PmtB2LCUMa1bmK62OJ9E5T/RK49wRkgVAwaXYOIZtHB8BRN6MneDE0oIak71xuMwPV8GF0kWjupkYAv5FjThFR6+z8kJhyzeEsEAEDdDTL4cnQMxiKBrz+bo/RJZMsBNayAkOHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508460; c=relaxed/simple;
	bh=xom1hiROMVoy31v8NMzvv1RMs9VUBOjI5tx8PtHgbo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+qkWzJ3IuAq056d9u2tXx5zbmzo+6cKUZ0S3hp089hP9kN6HG+f6TyzQ4+Ra6j6r36jY6wENq8sXqk6ioA+wz6dlVy0Hfra+C7ykJEaPpCzpc0oR/T1yUO0K7Q8jUqupYu8MKlp/i/ORw1QOGhOeiBHWmx9oDKj0r6+bXwlUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQ7RCpJ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752508458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fafrMpU6qWwGQeEh/ZULn8SQLSmZiDDyM4ZSSsSMLQM=;
	b=HQ7RCpJ9eSB4CfCegb6KIjtIP5aDKX6ARLamJNhvyjvk0etI0UIwvJh+9JaPfJ/h8x+T/j
	lN3RLKo5M1PIEC4D/Cfzie8INi4Yaf84JXhQTJZCdX68JZlUwO7vV+PP4CIbtmp/KEInPm
	eNu3w2u2tO4h/OhNHz9N6XbOrQkYtCs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-2l1xNBe7MFubcxkGWlPc5Q-1; Mon, 14 Jul 2025 11:54:11 -0400
X-MC-Unique: 2l1xNBe7MFubcxkGWlPc5Q-1
X-Mimecast-MFC-AGG-ID: 2l1xNBe7MFubcxkGWlPc5Q_1752508451
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561a196f70so6724405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508450; x=1753113250;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fafrMpU6qWwGQeEh/ZULn8SQLSmZiDDyM4ZSSsSMLQM=;
        b=MUXzke8ElvduCddnZt9VCvoXlUCF0x4oNEZX4gtzFfq8x87kw57oXeE6AYIM+2I2Ac
         dV+knXGnSIO0LYW/+mfKI8T9IK1g4FsysqOza9lHZWfSEC5ZOcEqUmpWSyCLH6dJjpAS
         jRYnHzR+Nm/nwn+Z8nJOSVbJg/wAtoGj6v4CPvmXO19WLNr/FN0h68+ipo4Z0g/oPhvt
         m/YwVyddCYLgoipb+7SnGV+7E6j8M2EAopbKU3v3G8xpEIytJH2fz70bnAnH7qgZabYC
         9icBKcI5SRnel/hRwX1GHTfYSm6fhzTHuB2IrMZxcFSg7hPD6h066TQlRX1nmxpgizNn
         /7GQ==
X-Gm-Message-State: AOJu0YxQLIxpMJniJ+VtlijH9yf9C1GrnNEzFyrRmBIPoEiYTryZJEJa
	zpAj7gsIJxKYRED025en41gP8yco+9hCbkhIhGyO+ZvwQMu6VHoGOzSu1i2sDQOMt5boSR75HGN
	qMSbJq5Gqg5ii2CH2Ri9M6acjIeciJyY/leZrspxbg84ZTxP3gwYxgWG3Z4M4qOH79Q==
X-Gm-Gg: ASbGncs4zbJVCQrId7rS6yWnaxcHxRHBG2DLafmXBZp55aj1+0nd8VY/ksONDmQGe2o
	v46cj4fAT+Y2cx/41gVoe/mMtGUW5T5YeF4DvzWYIBOABCeJI0hk8CxFEhsH2iA93Z1UMingfNu
	LKAb4VFUH9qiBrw8MFjy7RHKZ8Oqhe9pH42Mbk7AVxy4AZEMjId9i885gMccrqJsVcrqZJnAV1j
	kk3mBXjWE2wW8VeEw+RU9DihG1ov9ntTVCp4eWXuOFfNXThdhn1ciGJp2oEisioCxYM7B1el3vs
	VzG0TqTgJsjLaYaKC5atC1pqQIMuls1njgK3H3tun2OscZ1fJkj4iJion+zVfa/RSQ==
X-Received: by 2002:a05:600c:4e03:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-45621428198mr29093855e9.12.1752508450415;
        Mon, 14 Jul 2025 08:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCHe6mq8+XZn09BZU3bdrlf7cL8nFRYa64ZMeYLY281d4Q1xY8HGui6z7vV3S6rkcrDKdxyw==
X-Received: by 2002:a05:600c:4e03:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-45621428198mr29093445e9.12.1752508449939;
        Mon, 14 Jul 2025 08:54:09 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560ddf5e0esm70962005e9.18.2025.07.14.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:54:09 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/5] drm/sitronix/st7571-i2c: Fix encoder callbacks
 function names
In-Reply-To: <aHTy3tbDKA0QVqBt@gmail.com>
References: <20250714104421.323753-1-javierm@redhat.com>
 <20250714104421.323753-2-javierm@redhat.com> <aHTy3tbDKA0QVqBt@gmail.com>
Date: Mon, 14 Jul 2025 17:54:07 +0200
Message-ID: <877c0a22g0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

Hello Marcus,

> On Mon, Jul 14, 2025 at 12:44:00PM +0200, Javier Martinez Canillas wrote:
>> It seems the driver took some inspiration from ssd130x and some of the
>> functions (encoder callbacks) were not renamed to use a st7571_ prefix.
>
> Outch, shame on me.

On the contrary, I'm glad to know that the ssd130x driver was useful :)

>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>

Thanks for your review!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


