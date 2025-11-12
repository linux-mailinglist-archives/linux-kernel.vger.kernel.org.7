Return-Path: <linux-kernel+bounces-897112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5CC51FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5E4034DE43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649233101C5;
	Wed, 12 Nov 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjVdOQYk"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBE30E0D1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947037; cv=none; b=nwXDwnWFuFLA+SdUusr6jCvd66HxrXpocT9dT67VNZd+D1AkMADH9eWKajSV7OdNdXVblRsqa6smX93VZBP5bGSMQP44j3cD0D3UjxK3osOtCBfal3yGSVNHR6B4P2TNEPcxcS/p6sSkHWcmboydc0fGDF0c1X+QrR6CwKzCqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947037; c=relaxed/simple;
	bh=iTAh58xsSTK/DPrCrA9XXO9oOUT/gyUSwdPtMZDZRY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STvXr1VDi7jlEm6VGs2IA7ttLxO6l2P02kUu7I4TCLOEbufUrPwEGAi4ynqwuIM4YKdbQdNu8glS4yrq6YYl4YIbKMdAGXIVF/KE5hzZ9SlgYvGn5D9FGBTJsOBVXMmPhNQ9PQYgL4JPy8km1Q4pQOHE4BkkOMeErWHKR6lY8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjVdOQYk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47117f92e32so5616285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762947034; x=1763551834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/oUH46h86/olGMZU+XghYpDhfAZ96DwWr356lECM4A=;
        b=BjVdOQYkNn1GugyEtpXSuZbkJ+6NMebvOiOl+vQATSk4DKzy9dP0IzIfF7t7DTxIc0
         h79Cayo4rd1tZHnm3UF6iP16NquA/XmQD1sqR08B0brtBRUm4ITnOXvc+1xwtwV2k7jX
         IqISyf0r5iDNq2JTyIpuefvmlX6xXMDkd9TrEWPtwqTgWsn4oyqRRTyIYNo4RHtFR6mP
         09DYULt2CWaTGcv8PemxgkCUZjwV0kIiNzt5YSy402YM+Flyd34wvMhjIH7WNREJLZoB
         3ZNkEHdsDRfFf3C6aBNo8t5pZGT8AXJXDZZepxyvwuUsqBbgn11CFPp+iptlcxfzy8jr
         FszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947034; x=1763551834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/oUH46h86/olGMZU+XghYpDhfAZ96DwWr356lECM4A=;
        b=n3SD88D5wuu2fyErR1dmQjkbxsPRnYufPVwqZAZ+hqHulrz35XyTEDe4fGu/opnNPG
         duo4YbM2djwqNL+0iNcXornEYOnfTHYyKOT/s6i6F1sCalgHgxvIMwbWI7d+xpmA3w0O
         n3yZoG2bYdOVFj2YT5jP/sJLhlsO5fzpG8FTVwjdcoEZ94RiZsrDANxKAzUPj5LmHDI8
         DRMK58O17e+zBZHCKq1QK6r3Xgdjd69ZJdjnrP+nPstPACJfmo3tOdZXrQ3dqltphaPE
         RlQoVMR1KIS9igPt/J/PnS5W+NKz3pdG+Tg6GQgtkA731GFWyVPxN1txECruiafCq0hJ
         CT7A==
X-Forwarded-Encrypted: i=1; AJvYcCXPmhtg4lOZo0RexbaG2hp0aRcbCJvCYbjmGc12FSZzjN38IHS7FfGBUQFoTLYRdhthXpV8mNwsoZLYfUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVZIakJKhG6LrXVxMgkzgbaF7o/lg85IjK2as2ZyycLultj+Y
	456W/EMkghSXdAkptKNHeH94MV6dxBrWNUMrsSZ4otDbf+9J2nCDHfwy
X-Gm-Gg: ASbGncvnCSYsc9NW/gWM+2DTsjQOMm5s5PwwluEJ5qhM+xjtHsVNkdXzWRae8/VRHBc
	WqOlY4e20E45tua3HPBDBmBl12HAsRk9KNVGxtbBeoOVimxumhu77RmZjft5M9UD2PB6n2ABAPt
	WQcP0j8htLLpHjqeTua2eF0x1HMJOh7RfaUmImSjwkSHnCefQXFyg/tYRzm4F4//Y8jEBFSTmkX
	3b1uZCwvafofKRvg3/yMie1fiFtjxBnDhb+5pdXMiU9sgNJl07YG3opA5fLabXhlcNhLR0gpJhX
	nPLYjlNGhRpaN/9U40iFrm7+ql6dvssLjobiUhqToSMINOAOO3cunDatOKaj0UFlrvZc8isK5Wn
	nIfqFTZXWmRT9vRBxT81oJ0gfwhotBGrvIFVMOvSjh6tG6Tu4tL3q3Dbgx4nCKfUz8rYSFo6j5j
	Dwb/xmaViTN3PeymJQP5RtmsQ=
X-Google-Smtp-Source: AGHT+IFzZn82+HqmV7Z5oaduLfvBaDy2CYnyKKDWs/rhY5yLhynN3LzPM9CdU2cQ0vUhoC+2FQjWgA==
X-Received: by 2002:a05:600c:4f93:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-47787095d98mr24817395e9.22.1762947034215;
        Wed, 12 Nov 2025 03:30:34 -0800 (PST)
Received: from [10.125.200.88] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2ad4csm31122115e9.1.2025.11.12.03.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:30:33 -0800 (PST)
Message-ID: <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
Date: Wed, 12 Nov 2025 13:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 William Tu <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <874iqzldvq.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 12:54, Toke Høiland-Jørgensen wrote:
> Tariq Toukan <tariqt@nvidia.com> writes:
> 
>> Hi,
>>
>> This series significantly improves the latency of channel configuration
>> operations, like interface up (create channels), interface down (destroy
>> channels), and channels reconfiguration (create new set, destroy old
>> one).
> 
> On the topic of improving ifup/ifdown times, I noticed at some point
> that mlx5 will call synchronize_net() once for every queue when they are
> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
> that to amortise the sync latency over the full interface bringdown? :)
> 
> -Toke
> 
> 

Correct!
This can be improved and I actually have WIP patches for this, as I'm 
revisiting this code area recently.

