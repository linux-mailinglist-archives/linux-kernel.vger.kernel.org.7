Return-Path: <linux-kernel+bounces-764342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B3B221D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BA5720BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88712E5427;
	Tue, 12 Aug 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWENvyt6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F915ADB4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988151; cv=none; b=J59kahzp07ZayApM1ECTzDW9EaDt/4KbywevtwysSH6tUO5eoFrqnFWkKEi73ycSr5xXqntOmoQaq4wwII97uzGgGgr1VuuaBRI8dMyF1lAT1UU1dFLqvp9LU6l2bQbZ/cjGez2s0ZwuTBwalco2xermEjfYqib+bjZMn1cqYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988151; c=relaxed/simple;
	bh=dtp145XFdvvxFdz1VPHRgGRMPeqyDu9XOfP84PjCvW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qrt9r4W/1OdAEfj8eGB5GabF8N+sehP+/I7txSxR50FIot6Bgo1Ac/WnyAX+VeeK/bPDBOAezOYe93lOGTlx9QPIQZx5R+VIu92rEX5nDBlKF+fw5ztQgVOgBKgQ22NXt1t9VCMlmHRd92b23+MjZGkz1DO8eI2+LKi7fYCQgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWENvyt6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754988148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rccHfIlp6zESJik0ZhO9CP4dAeru0VA0eRlmjizRq6k=;
	b=fWENvyt6dmF5FT2Tv8I54QIjAwc0EeaK4QQqCp5lbI2RuGVHnCvuk1nS5T5cQR0VIc27R0
	DYk5M+p2aG8WprNmLMnu1AKMSQ2y6rd/RJx5KA+0+L53CzDJEI4t9x0jfbC0EStN5Vn60R
	qtIXOZg/itIXWMXulBjazstFyaGLf+U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-_pdD8OkTPxSILJdr-WC2FA-1; Tue, 12 Aug 2025 04:42:27 -0400
X-MC-Unique: _pdD8OkTPxSILJdr-WC2FA-1
X-Mimecast-MFC-AGG-ID: _pdD8OkTPxSILJdr-WC2FA_1754988146
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b07b90d5cdso65763321cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988146; x=1755592946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rccHfIlp6zESJik0ZhO9CP4dAeru0VA0eRlmjizRq6k=;
        b=DzV6Ea+6FWM9DDgX8n5mCq/SfJW3/nmD3EZo3QFsKLitkh0tOQHOOQoLYlK6x+xxy8
         JQkprRkQeK3+ca/4xByitxe+B7ExUzLzdQFK8YSXruG3IrVah9FUoKb/I6zgQNyJd174
         znn5X67SxCOkCSwyLx1oiOi/b/VC9pDjlFpGWkXvYEwfVQGgH7FMUuxycMJS4YXtPgju
         jXPWLqEjsfQhhpNB4VetnxQqLuqviFDE3V4MAyN9Gj2+C1tJR2r1WYbyh/ZfQCXU+kDC
         fJV713eBeD5E9J2Z3GMWTStHJjjDt+NBGRfEl4pMtjhBBIgS3d9kr4TOnlZkappOz7vj
         bbWA==
X-Forwarded-Encrypted: i=1; AJvYcCUm0wMeG0WKB7yRpEen9Xl0SOFEmY7kPHSV0yOfhFds81lxdzrSWwYaJlZAl0+ufkJertycB9TFOElD+DU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7M9rNTNCxGKqKPxkuR1R3DWYVMVjsKFFbQI91pMelAUpqIMr3
	qzUcMR+hsj6fhOW7MxxHStoMliKTeENv75tw5+42zk+eiMwhwsgllAWiCNa3xkab2A109r27xGX
	B4op++yO3gTZGKyW2lbzMhOQNscF0BgG90RbuoEY+JC8rujqv/Ki7v7ocVWNbgisJpg==
X-Gm-Gg: ASbGncueNK++vCy8NOKrpDtG1qlo122szdk5oHnTCjQN0mysRPUg6PrLxMp1OVQE5hZ
	gczvwEP6hVRZA1+Db6GVbB6Vwu9Zf5CLTnMNv7D+y0aTpD5CTvDR0dxaAgpybpQJhbO1EiWHgqU
	AKCD0gsJD0vQ9XiQiSv8Z0uiwr6SvBXi5fyc9GqRvJjkHYARImtXJyTiX2d1uQvQHXJYubKAeUR
	NcOddD5+8mle3O28jC0+JK+G3tyk6/vuLxJmYKPzczg3Vvqpu1jwM9xRNg2ANzySEBWAjNAhcDu
	pbkrTpNeYf9/MZtBG9NCOuOXM/t5R/H9H7cRiZep2J4=
X-Received: by 2002:a05:622a:59c5:b0:4ae:6ac4:69dd with SMTP id d75a77b69052e-4b0eccc774cmr33426471cf.45.1754988146484;
        Tue, 12 Aug 2025 01:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5D94N3cCmDOj4r29T+dIrmG4oDYTtzUGD5bS0Osxk18qa6XeZXwujzAQBdPNy9e3tgUet9w==
X-Received: by 2002:a05:622a:59c5:b0:4ae:6ac4:69dd with SMTP id d75a77b69052e-4b0eccc774cmr33426331cf.45.1754988146093;
        Tue, 12 Aug 2025 01:42:26 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e85d4f5ff4sm74216085a.3.2025.08.12.01.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:42:25 -0700 (PDT)
Message-ID: <83bef808-8f50-4aaa-912e-6ccdb072918f@redhat.com>
Date: Tue, 12 Aug 2025 10:42:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] bonding: fix multicast MAC address synchronization
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20250805080936.39830-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250805080936.39830-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 10:09 AM, Hangbin Liu wrote:
> There is a corner case where the NS (Neighbor Solicitation) target is set to
> an invalid or unreachable address. In such cases, all the slave links are
> marked as down and set to *backup*. This causes the bond to add multicast MAC
> addresses to all slaves. The ARP monitor then cycles through each slave to
> probe them, temporarily marking as *active*.
> 
> Later, if the NS target is changed or cleared during this probe cycle, the
> *active* slave will fail to remove its NS multicast address because
> bond_slave_ns_maddrs_del() only removes addresses from backup slaves.
> This leaves stale multicast MACs on the interface.
> 
> To fix this, we move the NS multicast MAC address handling into
> bond_set_slave_state(), so every slave state transition consistently
> adds/removes NS multicast addresses as needed.
> 
> We also ensure this logic is only active when arp_interval is configured,
> to prevent misconfiguration or accidental behavior in unsupported modes.

As noted by Jay in the previous revision, moving the handling into
bond_set_slave_state() could possibly impact a lot of scenarios, and
it's not obvious to me that restricting to arp_interval != 0 would be
sufficient.

I'm wondering if the issue could/should instead addressed explicitly
handling the mac swap for the active slave at NS target change time. WDYT?

Thanks,

Paolo


