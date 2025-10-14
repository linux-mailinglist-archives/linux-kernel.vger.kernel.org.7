Return-Path: <linux-kernel+bounces-852028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C057BD7F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7001B18A3399
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2E2ECE89;
	Tue, 14 Oct 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQLDKaai"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D922A4DA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427553; cv=none; b=AsZwTOzcEZaiFb6N4pPztcWtZSB+ijGbHGnOYNZ2JOMqjlI+PGuqo1PTQJNDRL8mkscLcV9zpwlvjL1u+Y7kcvQhdYxHsWmQ9//OGJMqyZZCN+2Cg6GW4T3eJY0T1UPLolqyW1qeAm7QomzactKXYmff5olIkyIMKKOycQaz73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427553; c=relaxed/simple;
	bh=Ws25b5KIlwTyCP8dDyVIBLRtzRsitC0cQKdPkKx5rKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h2/iScnpVmOotPoXAHGxgIcGKbIWhRZq/xcXKgo5FGkG5iR1Hqigm5spLbBMecC8ORnkI0rTzhYtTZSsGpzV0P1WQohFnls6ZMV4GDe5KBl7OxtaD4lDYQABJNmSWo8+zKi5CTOEPpHqJdztXg2A+GsHGZ95gF8gN1qamOmGzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQLDKaai; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+mNHQsLdfiv7vvTT3E1UI4YOke0x16loHcS0d4AOZ4=;
	b=MQLDKaai5WqoMeKkVhL5qiNYP7gjBPWmj1uk8J0VWoMR1Tgo01ja4mstwwH5QZNOo7dJmz
	v6Mfp7r7day3XuNRRhUVxjsE+IQGkuBFGTxrjovQRpfeZ2fGNAO3AARdUaksgJIyPu9614
	OXF0KZqH1EmjUAk8Z6jx5ZGmNDx4Huc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-ZK0_ab1bM1WDvPzXqHRJ3Q-1; Tue, 14 Oct 2025 03:32:50 -0400
X-MC-Unique: ZK0_ab1bM1WDvPzXqHRJ3Q-1
X-Mimecast-MFC-AGG-ID: ZK0_ab1bM1WDvPzXqHRJ3Q_1760427169
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so3287588f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427169; x=1761031969;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+mNHQsLdfiv7vvTT3E1UI4YOke0x16loHcS0d4AOZ4=;
        b=LgSuHtfRr8GiGIEf7i4fVSk3/5NtyPqStKfcQqMOeRiZe6AdlH+0GJrOmXdUd0zvuO
         l8BMoh30VEVMJLdM30PXR2JdGNGNS5xgRSliNC5a+z2UlqP7YVlJ+qX+BuK4vgPWzhfI
         3haOUcWyNdCPS4fZbdkXXkKDiAEB8GtNknenbSeSH1Od5uhunxuZUw+noZNVzO4hzrPe
         iltiOS9xzn9pyMSDXsRxKcZP2zcvixLWj+kIDxTVveDgte5Al6ckWwPKW5wEyjGWRsng
         AUgLykisbPsXox6rr+xFtLf3h8Khv2NsbcIJYx8wRJvHsY0sB/xTToZSunV/r9bd9ngy
         W1sw==
X-Forwarded-Encrypted: i=1; AJvYcCXPssg2BhQ7y/tjl6FmBevKlzwDPaf1iYcSdOAlv4fmeba1Sjm+96EOl41cQG7vUZITmXS1Gbq4XsqrxTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBq7izr9vYKS9VleB6+w5K+9IYiLoH2qHNLg4ZO9EkV/sDex4n
	VJDozq/w3xP4aSkwDho/RHNPbUfGe/UnOBrRijkVbI5HF1ydKXfxhUZvdHExKevtDGLdVF7QiAQ
	FLbWzrLo9YggXyxtU7ZzE/2/dkCKJ0PwxSb4q828q7Kl+/dBlL2bkeQtMczzpmSBL4w==
X-Gm-Gg: ASbGncsPABinX/3TXq59kTxRKx13hrmnXXhfXyrARyG4hd8hYWG9wgq6HqBT0fHsV1F
	WnssvOnAUKqSi8jbRBjkrvMxtMkPjXVx14GP6dvhfKugzaZU1hmpY3uV6xN/PzXXhv0JpyjHw4Q
	7EFNbw1ImLldL9tmv9/E55S+9kF/0hOvlugx0Fawt2Mhq+tvsR/NyGzMwx0FvBtP2IXUMGx9O9k
	Ng8/4lSZBQa2ybAKbCMdaPLv21xFBj55ZErG9ibtSQ2+bpfyQRjzUBNsp5GNFdAUseq8pwQzeyE
	hoMa8npxESaG2joO2n/GQDHEivVXq8WiYJxn+2E0+y8jpvQHPvYI7goNKqhe6cC8/v/H20rs2Z5
	1TjeZbq8BhBfkAuLarTIrQmM=
X-Received: by 2002:a05:6000:4023:b0:3ec:e277:288c with SMTP id ffacd0b85a97d-4266e7d90e2mr15348989f8f.31.1760427169478;
        Tue, 14 Oct 2025 00:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpkrFos/JoFF/exw8H13iEBsM6KPGAsZOyXjflOcvr7yhgSOkA9HU+kH6Zn/mcbepjNdm+gQ==
X-Received: by 2002:a05:6000:4023:b0:3ec:e277:288c with SMTP id ffacd0b85a97d-4266e7d90e2mr15348979f8f.31.1760427169091;
        Tue, 14 Oct 2025 00:32:49 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5833dcsm22073162f8f.19.2025.10.14.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:32:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 2/6] drm/panic: Fix overlap between qr code and logo
In-Reply-To: <20251009122955.562888-3-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-3-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:32:47 +0200
Message-ID: <87frbmq6ow.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> The borders of the qr code was not taken into account to check if it
> overlap with the logo, leading to the logo being partially covered.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


