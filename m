Return-Path: <linux-kernel+bounces-794648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E3B3E4B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE8E7A1873
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5EF2FFDDA;
	Mon,  1 Sep 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JF18vQ3W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6885188715
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732997; cv=none; b=MYTXdKjCxWvDRxFf4RS4DHHgX097q2bVdJttFNy4yi1ZmNQqrfxUlbxT5SpMhBs544LszgsyqSn8ES+xgOnDcbBDa575HALfWhx5u233wHg+lJH7vk5X0qeteh6IYynAWqsx0iV66XIP/zbYKnD9eqj+RISzcs0c5NCbbG98XrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732997; c=relaxed/simple;
	bh=pPRviCeIe/MNw3hM3xOHiKjB0T4T7gISDfSenvPnK6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DOVzbTO7yMVnrQmm/psz46hG3MBvE5eYeJ7hDexvBd8v74LZGxWXoiJF+XclYVnRWKNFoH2u93mr6Eu+HHu0m3xfF1u3aCeO/iYVJcSL1dc7o7HgMFnib7MVQOHoRR3H1HDDlFum+xvfhqRapg4Pe3tKGoMwE/e4QCARQS38ktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JF18vQ3W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756732994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cxq7T2V7lpPnrYC2+PR+qicjY5gpUXVxT7pGCrLEVTk=;
	b=JF18vQ3W7uOpL1tFH3uwHV5tDJv5BJwtWfdhbi3rFOhlzW9tMnSKqXEASGKtWSUcmrAH8Q
	PR1jit980vz7WhYx4JnYM6SPelllEwLwinW3KlOXPWAvcDkWV08pRIaFGaenkGGW1sigte
	gJqb1WyofHaBV1nPdnvg9gA7G+Ln40w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-JUFpxihuOkWR2jiqlD8U0w-1; Mon, 01 Sep 2025 09:23:11 -0400
X-MC-Unique: JUFpxihuOkWR2jiqlD8U0w-1
X-Mimecast-MFC-AGG-ID: JUFpxihuOkWR2jiqlD8U0w_1756732990
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b87bc6869so12336365e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756732990; x=1757337790;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxq7T2V7lpPnrYC2+PR+qicjY5gpUXVxT7pGCrLEVTk=;
        b=tmdpkIPXa+bzqgYjVoM+WeSGmqKo/ow5c9aa0br25rnu0Wwatx8Mb0P78/g7g86mrP
         BLCpz+ObVZ6zWCsQmHe7z4M7aDw2njDL/z2DB1dZT88oED91cG6wFW1nt569dJkv0lP8
         F4HxO0C1p6MoDGb0kAcKrySkot4Ab/EAFXG/B0XWoYI1lFas7+EwNsloykjbgLAc0kWF
         2UgcxhVR9S5NCTnvUiOo0RU5n3W2eCKpnVKgdlfP3p6xqKXAmNWpcQV2KT2z8QhfgVv1
         Noapx14flgHRWjxcbbLtN2XbHol8FDZSmc4zfKUPZM+etEDvtn6UfQdklH71YHT/YXdf
         TUXA==
X-Forwarded-Encrypted: i=1; AJvYcCVK21Jq2fEUujXzXIXwTdWGCRDr1LIs5Oa3TSTNClkG6GAI8snSBl73LAS+E907z51G9e3A92W5OkIosf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7EVLLM/af2D3hIhrHiybmYNO76q7KwI7EyOYm+TKh8hZEyXD
	bI+diJnTxmeIBea27WgFy7q7+/jMEhTOXKLMWZ/+NT98PdHFQYpQ+BJj15Ub6/WrYodR646YF85
	8vY69W85eaCS6wgImuTsx5kXU8FpUv2M6MrcCJ4HYpxwpY2HmXZFdM0Uyb37CXc/BJg==
X-Gm-Gg: ASbGncs4/4VU2SLVec6fJSRRrLOQTLlB+AzGqCSjQdah7qEnMWQjps8RgmOGkF6JM6a
	XLSvjV7agFwFNqppqroCmc1fGNwfrMldxb2SsSvrS2pM9gn8J5LtDdxwxe2MhoKJogyKec3XY3o
	8nMMAUBoQmDzPFtL/O+sAJlr9wIf+JDUPfCusqgbpxajNL34Dcp5gLupCH3n1gNdYFwd9ZrWbuO
	sRoNRip8bM6mhhUDUmv++EXFbtS2M+/ZnS5p8TAfOjSi91lO9qAlQddso6zdVTAJDLywOzbgI3f
	64PgdRmGL6kNxbH+5I4jnAYr7gHXSpB6UHJuljOTJ9V5tKmOnb5xMMRFZU6n9k5riQ==
X-Received: by 2002:a05:600c:8b42:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-45b8558be6emr57927725e9.34.1756732990185;
        Mon, 01 Sep 2025 06:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+xR292CYaY9FGMba3rZUFGRMyeIqFOQQHajodDM19zB/eMHw015CBudwcpdCSUn47hWdZg==
X-Received: by 2002:a05:600c:8b42:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-45b8558be6emr57927525e9.34.1756732989773;
        Mon, 01 Sep 2025 06:23:09 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm209197995e9.17.2025.09.01.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:23:09 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Marcus Folkesson
 <marcus.folkesson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/6] drm/format-helper: introduce
 drm_fb_xrgb8888_to_gray2()
In-Reply-To: <2b0eee63-2b7d-4ca5-b673-4f3761d2e386@suse.de>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
 <20250721-st7571-format-v2-5-159f4134098c@gmail.com>
 <87y0sh947w.fsf@minerva.mail-host-address-is-not-set>
 <aJnc36ojqSb3-Ti2@gmail.com>
 <2b0eee63-2b7d-4ca5-b673-4f3761d2e386@suse.de>
Date: Mon, 01 Sep 2025 15:23:07 +0200
Message-ID: <87v7m2fgsk.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi
>
> Am 11.08.25 um 14:06 schrieb Marcus Folkesson:
>> On Mon, Jul 21, 2025 at 01:24:19PM +0200, Javier Martinez Canillas wrote:
>>> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
>>>
>>>> Convert XRGB8888 to 2bit grayscale.
>>>>
>>>> It uses drm_fb_xrgb8888_to_gray8() to convert the pixels to gray8 as an
>>>> intermediate step before converting to gray2.
>>>>
>>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>>> ---
>>> I would like Thomas to review it too, but for me the change looks good.
>> A friendly ping to Thomas.
>
> Apologies for the late review.
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>

No worries and thanks a lot for your review.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


