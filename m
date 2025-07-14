Return-Path: <linux-kernel+bounces-729859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D85B03C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D9B17EF34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27A24C09E;
	Mon, 14 Jul 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDFaZ3Jw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13760246332
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490144; cv=none; b=OzYNDdiFxSZTIgHX++NSRMC29Jn67Vmp/NDN2zOM3nyvOPNOc9k10NMc3j2RgSeUE5Ui7BMv0NYzS29GDnw2Dr6EIUnEPMOF8pYAVpcIVpHwf6ZLKobrDbXndJFl2ijr4ShOlOCtNvnqTXPEFIpGaCzpPE3i89wCIJ3r+Blvi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490144; c=relaxed/simple;
	bh=k7otKPrVfPHtsH232FjME5rT7LJfHaZqqtlPb+Pnihk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTj2uCfyukTKFjZjI/lGHEbfBWegxgFQ76NV+lCBUr+sPBun8XC/HI4onzknS2gPsEf6iWH6Ci9ojBpMv2qW61cs5x8yEGexqITV+0e8wzCn9R1opV0r1UO+//UyIcHNE5ZdVTPNLI0zByuhLBuOE3sLHOKpBczODL+EREZDw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDFaZ3Jw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752490142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ltPdQyqHBsra0GyTjq74zXTigFI2B8itXhZ/svYCZPs=;
	b=LDFaZ3JwBP+jKZGA3cIYXAl2q2xfNbjwqxbZPVfo4kh3xTdg5mKV03QcCUKDfvdVB26pn/
	jhaVykxO5qXPODrnyOaV6Bw8SIqKkY+Vsplnwzqkchq/kje2DaWwkF0WjXBaDCfrZgJK6N
	BGys9Kxc0+ZZi3YhyrqsJ9qBcd2wU/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-VxoFon7UMUqZDQ53iZ08HQ-1; Mon, 14 Jul 2025 06:49:00 -0400
X-MC-Unique: VxoFon7UMUqZDQ53iZ08HQ-1
X-Mimecast-MFC-AGG-ID: VxoFon7UMUqZDQ53iZ08HQ_1752490139
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so2136392f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490139; x=1753094939;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltPdQyqHBsra0GyTjq74zXTigFI2B8itXhZ/svYCZPs=;
        b=qkbJKZuRrCzuIq1+nVENJIY7dEX0xJyw4EdHWZNQBbIpohbkaIcd3OIKrc+7sVjvL3
         RPJxdRZivKSoX3QexWFBGLD9HCy/KTVlpMZY80zqimNbI7xqG0JoUYy7vvPNXtPRU9vE
         xhk3DOqkLExkIsrbPDhKtHPXJNnyqbNG04kzLE+SQDBmwYOT1Qk0w/bWCXktp309L9xN
         fT30Rx3bEoeVSRMfPJsWD56kcgp1wqNR0GauxwGYp7L5xMEOh60naHC/hqn7u9vWLEsK
         jQcrnNUSs3JzPlpqKuUEoxmskTW/sD/xbFnVy/HlXrpD7HrFSMoHpd5Si0OP2o9tLv+S
         8zUw==
X-Forwarded-Encrypted: i=1; AJvYcCWwuMsUwPE2mMAVFn1uMojlco16MSiZU3LciTUoC7c1Sh+6nfC2Y/C6IVmeY2wl61SFJSLgIwU8xVdsT9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRPC4XYQUz8+dyE0jMM4Exo8rCLzqpQMlBzBP6UxBTzw/Ryc5
	FGsVjYUPFM2j0FOntM+w34dzGiGVcbId5qQAx6u9YvNBhcxBSM1iJgxfV6kuDVjXYJewDzgMvM6
	RjiLzYGAAgGweXLPrkR0iWBl/BT+hCPnf8Hm0Kp0FvJBOGocJDa3d3cMrVrVOO2DoZA==
X-Gm-Gg: ASbGncuUriuoUk7lS/TcPGjW0RZL8tpbKGm5Pbe9e/zgB1PyNmWaF2gz2EuTmFR5L8T
	wG0nlZzsis3LOnSmQg7DzPoKY5DUq38W0cPX8xPojtG0LQ3N4QeRkDglaj21jqOCeL8S+xf/ns/
	GoyFSLMbhQ1kLU4cSwmM88htmRmEP/+B6h6Udj6CPEtx5L2p5UgSekSHsxY/8aMgZD2WRpFZHZL
	zGQmWwU5yEz/XKDlOgjeTZcKsLmE5BOa4IXsK3EHgoyQLaotcnWqz59TilB++eLtYLreJwFel9Z
	1spzGWnSKteuGIRv2+2KFhfI4v2WiPwcIGaJWkCsmI8Vf8kA0mHWjVEMZ9P9HQfPdw==
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id ffacd0b85a97d-3b5f18dc957mr9051335f8f.46.1752490139161;
        Mon, 14 Jul 2025 03:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHImDSBSOZrXKdE7d+lK2DHEqPaurxGJM74dxsib/ppONQQBriF16K2WMaXixkeJMLS5CC1Jg==
X-Received: by 2002:a5d:54c1:0:b0:3b5:def6:4e4 with SMTP id ffacd0b85a97d-3b5f18dc957mr9051311f8f.46.1752490138729;
        Mon, 14 Jul 2025 03:48:58 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d76fsm12336085f8f.64.2025.07.14.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:48:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH 1/5] drm/st7571-i2c: correct pixel data format description
In-Reply-To: <20250714-st7571-format-v1-1-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
 <20250714-st7571-format-v1-1-a27e5112baff@gmail.com>
Date: Mon, 14 Jul 2025 12:48:56 +0200
Message-ID: <87qzyjkpyf.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> The comment describes the pixel data format as stated in
> the st7571 datasheet, which is not necessary the same
> as for the connected display.
>
> Instead, describe the expected pixel data format which is used for
> R1/R2/XRGB8888.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


