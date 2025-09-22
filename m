Return-Path: <linux-kernel+bounces-827378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA8B91956
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F0424093
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC011A9F99;
	Mon, 22 Sep 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="13oRaIfE"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951051A23B9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550072; cv=none; b=dFgBOIGrnU31gwOLoWuA+rS10p62IxiERu74UQdR4OP5hMX8W0CKResFa7yU1oT37a9MCdyoEseT5QYZ9+Bd8TWb+znu52pWOXJ9QLKWOIflG0aTpkNyalj/oKsG+/kHR6cpuA6ukzPyaHHu4f1XLqJY/Z+kp8ENym5iQxi9cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550072; c=relaxed/simple;
	bh=2gKCZnS8Y0kw7LI52aPWPye+cd/qPIjBzxQKuWEn6pk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=B8sgbvnTXo1OUeAAys0Bxeod9hKWjE1JmEIZtIkHp7HenhobaXhN2d7f9yrd6TrAa1VxKC/EVIOLeVVWX+9k+Dm4d4+LFakNARdjPXETyrCvgO4LSxrIW/FlF9gnwT2awkcqzCdktBn649vWqOn7IWvnL/Y3y3kqh+tS5p+PDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=13oRaIfE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so624142466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758550068; x=1759154868; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gKCZnS8Y0kw7LI52aPWPye+cd/qPIjBzxQKuWEn6pk=;
        b=13oRaIfEW+73jLfqkyekNErZbMJqXdnSYacGoyP2XAv6ZfSQf1RXPcha8atJOZl8As
         46vhi5spf6uugfF2HRkrCGnngBkhpSKwqsOkk5OYk85LfSrz7LbfLsPwhVRYToYTXkqz
         +1ZLJuSe2KBcwjuxVw6YY4LVO98aDuiisfokbLUcSNYz8kMw5HJx39snWC62fR7VVmIP
         7zM85Qj96lClyr/B8O5QVaul7SKe33eNJP5xRF1zUmd3u4ylwb/kRSmRTW86aOz2gvbF
         kXslc/8QQmixEmS3PCXkkdI8irlBHJ+OMliP64r1Viic8ND2F7FfAIGtHgJIMlOJM+3/
         URdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550068; x=1759154868;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2gKCZnS8Y0kw7LI52aPWPye+cd/qPIjBzxQKuWEn6pk=;
        b=Aid+nIQfi94m4Tq1CkRkK8KnPSgICKOjmqEwAXzxp6Yz2NY0QANhOwoi+IELPBbpLY
         3UcSifEcFM5tBRXAm2rXj4lhZCmrjweRZnraReBI/SUvrxe6Gwy8f8bJ/cVm8l5YM6KD
         +26ZW4/Ltw/F82oyHasaqyDvtVE4jJ8uCX0QknMeiuX/sl8aFYJcGUAWEwpNd3bvBP+R
         EuGI5d4R29d9HQ0c5fqMmGmJMdrjcZsrwVcAinIkUTWpQQ5lxdTVKnoQPNZth4kycePg
         Uz+3SdCw95WQyH9UwRMTiE4/ugRTN/CeJ/+jiI+iS98zW6a84fk1OINYjKdgXvst+DJz
         cvfg==
X-Forwarded-Encrypted: i=1; AJvYcCVm88rMwT2izJe7UGOoHrlV4PM9TRPucufd4xHUGsRctSsGNXElc4kwoo5P2IyeGG9BE3ydS5/pbq5IK8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15Q4XEe9AKmg0GcF5Fk+ppaAOhIu1sSGVLRZB9ry3fhVyDrfc
	F6sV5hghePJ3q77cZNpqa7TUaqquLOSHV9Xm1E/Dg5O05PnEI6zzMFbGxPPSFt0mlCM=
X-Gm-Gg: ASbGncsfW6X/OvCYdv49I5FTaUkDnYJ2fWhwMWXPNGnFYJzKrKwvEIxizcBc6Jb/hVb
	XUOUVDK5aYif8qJl6uwFDBT4gq4gu8NWmA+i5y6s/eUEDAWrKlNwvZUan2z2fValVlAeeyKwGo0
	vz0JvYyNGuatleI529Juo2CUFm2RtsfmLKmKt9f666B4QFk448qew21/EyYcs7P/jwiCDL9pky+
	zY4PAwnL5OsOzy9BeFyGIpzBX2n9gzqyV/lKAcT2ndcB7d5NDz0L2N8Nh3uHZ6RrMbqZtEoCtf8
	+I3LEtiYEWCVHg9aQ85npMihJrtOwUsR3gZFGKldqcwxQdfGZJCtx3wFouLdJOpMvJxQsO5yB/d
	CRrYrmUC3iuXLI13vSRwULhj8LLJL8rFvogwHY4xPSmekJq2O1Yb3QZmr0Dw49IPmto0w
X-Google-Smtp-Source: AGHT+IG2LQi+1Jve61dJzJPf3p6C4wK2oRc2C6Ic3zD7ZHI0AKL2Y3hhz823ekZ6+r+8VVvfemU3qw==
X-Received: by 2002:a17:907:972a:b0:b04:4046:db6b with SMTP id a640c23a62f3a-b24f567c816mr1300784166b.45.1758550067866;
        Mon, 22 Sep 2025 07:07:47 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29b80eaec6sm484442766b.87.2025.09.22.07.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 07:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Sep 2025 16:07:47 +0200
Message-Id: <DCZDZ037P56C.3MS3HI55IN41J@fairphone.com>
Cc: <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] fbdev/simplefb: Sort headers correctly
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Hans de Goede" <hdegoede@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Helge Deller" <deller@gmx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-4-f69b86cd3d7d@fairphone.com>
 <87o6u9d3kg.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87o6u9d3kg.fsf@minerva.mail-host-address-is-not-set>

Hi all,

On Fri Jun 27, 2025 at 9:52 AM CEST, Javier Martinez Canillas wrote:
> Luca Weiss <luca.weiss@fairphone.com> writes:
>
>> Make sure the headers are sorted alphabetically to ensure consistent
>> code.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

While there's still some open questions surrounding dt-bindings and how
exactly to do that, I think it would be good to pick up the two
"Sort headers correctly" patches so that they already get in. They're
good to have in any case in my opinion.

Regards
Luca

