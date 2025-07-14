Return-Path: <linux-kernel+bounces-730457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23D3B044D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD521882E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE925BEF0;
	Mon, 14 Jul 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiB6JPZA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A152AD32
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508492; cv=none; b=MtwbOoC8PLSfu9x0zwhqM4QCRdnm3kjLxzgYUKANdSHRLHa/gKqUxAPEFYiDHij4gG46HKP6cFVH/61wZlECp1w2D1MXPA0J69uWZGSwlhQ25Gy/pfBp5fkdkdN9IKSAK+cM7KZdaIGS2afCUGSKZfwNh5hB7UIwf4iUL8yFsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508492; c=relaxed/simple;
	bh=IqukGYnJBM/DV41H6y2aluGx3nsl+OW1Y29A/ncH0as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pGcwvTSI2bBKFAKWdj2NXX0NhVpQ9BipAinEymLWS+ZELiAbELVto8NT5bEsYSjlwJSA7GcGDlwcpZlNjWU364iadOUgEoqTcpZ/CHnRiUNakiGXR2kAsGKzmroJq1cR5qA8KrO8A1sEYBkcsR5wOrcaoSwodqotp4Z3SX4wrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AiB6JPZA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752508489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zOG1Nvo/l+gwKO8BFDZuLd2b0R76dEBumOlOk4xJ6DU=;
	b=AiB6JPZAuobbR+7/1MQ3kzFIpxiImsSbGNz6ykUQWKS2k/bRDp6FlqrK/CYWu43rg6pcbU
	6v6B9cVZ89Jq9gH5nyyprfCNeTO9g5N/N8l5ktT9Q/cKRGACM8o6r+YFklANnRaxehXZXi
	lyYO/6RObNrMaHFVVg5ZmRrvTVPChm8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623--If2AyGMP3ioYJG5fWn0gg-1; Mon, 14 Jul 2025 11:54:46 -0400
X-MC-Unique: -If2AyGMP3ioYJG5fWn0gg-1
X-Mimecast-MFC-AGG-ID: -If2AyGMP3ioYJG5fWn0gg_1752508485
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so32941635e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752508485; x=1753113285;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOG1Nvo/l+gwKO8BFDZuLd2b0R76dEBumOlOk4xJ6DU=;
        b=a5eKoHnQrDmTjjCXRlvzQxWLPG4X+g8HpOIjQcohEWoWYjaMxqBfSSoZMQEhaATJrF
         4LWH/A6CXcBwSKy0buBdYcQ+UVuUxXQWhbNG6qmMjKrdU8eplXAt3QU3ilznNWsLsbQL
         Rx7R+f/QSEMqHwriybRn/lpQFHeOn+q6pUm+SaN9SQ3t5vlOBiNCxqUijeCyNcM9rZmV
         VIOutvfbMjT1GB2VFYJWNfn/w7nksgZBwV3ZzzJQHgvH5tzIu9quhIF+8+VVWqnVCJ8P
         CbeoQzDyiGk0xTcgIJkY8HfKfieRh2p/lGPk+FHHXUFiU1NkP1XuhML8XUIowWv1QVzv
         oAVA==
X-Gm-Message-State: AOJu0YzvTsqYC7s0gQYOMujVhDvZDZF9WccrnUSiLeiafi+bFs67dsnS
	3QnUbwaYCNpbcPMI010mfYFQCeLc4JZU5iRdRviQ9qNj1BbVZujRea7PJYzF6+ZUikVEnluWNYS
	va/PMWqG8ZAS0E4IrALFZmUokZhZj09rLhciwKKGHZStorVHxoQPoMm5Jl9jxHbXUjg==
X-Gm-Gg: ASbGncu2+O1UgyWMX2CoX+YeckKHA5WFR7YmcYXN/HpwVWz1/YHLR3QKgWKEPeAwWOT
	8ZdIIzvxg4+6QhirEygGITpbSoPqTlm3BWUWvPhUnt6zCIroXuVR2EKtWGDm5pJLX83A2acfaiS
	TCqV6mS3/UOwWhhu7sf5qYuNAqfHpcDK5W54KCiQEpB5Dljc/cbkMWIyRah4Nr+99p89zhkl2yL
	plJw8uogw1CU22bXYRA0NKkjR1Yq64Y8Umeoon6buh3kO+F62A9kpJGxduuYbMFEMshoKNUIrVn
	SVUmUzbV6SNenAzsYrgKkN+wc+JIHI+6CGr7kTXHzEChCso+CeuHgblWbGagUseaLw==
X-Received: by 2002:a05:6000:2707:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b5f8d55e64mr4732088f8f.30.1752508485442;
        Mon, 14 Jul 2025 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGz92D4MS71muOuG5qTgK18jL+PvOXMZCtPLjCp6/q9A5nOHQ2DyRXHcgTNMlTfI+AggOmBA==
X-Received: by 2002:a05:6000:2707:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b5f8d55e64mr4732073f8f.30.1752508485008;
        Mon, 14 Jul 2025 08:54:45 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103c2asm173094775e9.33.2025.07.14.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:54:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-kernel@vger.kernel.org, ipedrosa@redhat.com, David Airlie
 <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/5] drm/sitronix/st7571-i2c: Log probe deferral
 cause for GPIO get failure
In-Reply-To: <aHTyTsFuakcQsEm7@gmail.com>
References: <20250714104421.323753-1-javierm@redhat.com>
 <20250714104421.323753-3-javierm@redhat.com> <aHTyTsFuakcQsEm7@gmail.com>
Date: Mon, 14 Jul 2025 17:54:43 +0200
Message-ID: <874ive22f0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> On Mon, Jul 14, 2025 at 12:44:01PM +0200, Javier Martinez Canillas wrote:
>> The driver already uses the dev_err_probe() helper (that only prints error
>> messages for the -EPROBE_DEFER case) when fails to get any other resource.
>> 
>> Also do the same when it fails to obtain the rest GPIO.
> reset GPIO

Ups, I'll fix the typo when applying the patches.

>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


