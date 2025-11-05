Return-Path: <linux-kernel+bounces-887063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F2C372A3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EF814FB6BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BB338912;
	Wed,  5 Nov 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caKRYsdt"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026952F28FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364046; cv=none; b=JoV7H72nnoO59mALlNqSW0xO1vbyv5/miAA3L9zlJRvcJVj3YpuWxI+K9MFy0tuM4EaAj0cmtd17gfM8llusrJbYIP7xLqFNwgRS2SnXsVSq61UFue6cZDm7CH6/msKQOgEzDSi3dxx3QZk2K6zElcwssyaw+xM+QoD4dDM+RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364046; c=relaxed/simple;
	bh=6xrOD9swTEvrak0LhMfPK5DhY7OUNnrkGwLHcRPL30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4m/VdTGxq0keNxCrKjtKpDNSoJrVrKHBJyTQMVlehI32aaEgQCWOGeBDkHmzWyPsHxw6z4rWtRTr9YuOozgJvB0MOuUrPNF1DzPteSiBeB5rGm9G6rs66IADgdJ/SFTC4ggQtHNREy8dSjHday+P+hzkZffrBIMNwpgHOpoA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caKRYsdt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo135889b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762364044; x=1762968844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=caKRYsdtvKllX8CzsiFUc4zpvhzFGohX2iqu8C541hMlaAlV/GArvWcuIUYcNzqtFF
         iZsHa2KgnDOjipZbTsQBxz70O3SdbGvGjErHJFacdd81mG28AvBExOrrIYqB5rnQayHn
         Wlp+5I0CQOH51sTOzZtXst6d/KqjDDh1X2QbZ8V7+8o8slZTSt0YSBChAZC/EWTvN8Xc
         /1bOn/adVeZxgrjzguPfyLMpPT00DAZT15nxWOuBBxWcT1Wo5M5hagVt+GO3LNGUEdqt
         7a9vvGBNhOBjTjs742uZ0lKVPnpPTnpKMyYukgbYWlYody/AKXX+XGmmQPruLqbEEbZD
         mgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762364044; x=1762968844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKdKuNfm1Kcem/uHM3VQr6qkYp9rA4TSkaTwtykO5t4=;
        b=pTLNA2MtgOZIaB9iVGAQ/PKeN15Wou34G5VeoRITxVhH/AocpVRTGpFLUhNG18VRDt
         AhLW1+pvzHtVaoKL/sJNVDZ+Cq5TYhUXAncS3/ZMoiBnttKY4Pk+KGunlMRAqKLTpJE5
         YcDJK/PQpCEi/HYVCe/ZIiCTXzpiIq01QaKY/IKnMsHOdHxVzA9WPfjtRlhBf6T15fFZ
         VCGy7pe8I+iKY3LaA+GL/GDCVCG+RltIGFWMa3mVawK1Gkc9qKJAdawpEnNHyOonhij8
         C8X7woiSboYLmApXOBCsSBKAkqaCnAPn6fHyos+ze+iYt0KQ/eepw7CCmDoDh2auEPPL
         QgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhM7c/F5qII8RzPfkNzrhF9g8F/Itzlk5JAQa/qUNtacdeICBPSaGFoLXDS4q0g4pxc0seeV2dOEiQuuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdyLiEQhkxsHFWak2hu/nHVufE5GTeqbfpeaLh7tMah4heEaO
	wFyZmck1vEodKJ+ZUvK3XmR0RJaH/fYrkK6fyiBXHW/yDWdd2HKEBzM=
X-Gm-Gg: ASbGncttTB29/W2eHuoUAIVoFD9BShC32Z4dGAgld0uTGT77ajncUlz8YW64MBdLjqd
	bjTL62IjXcsKDSUD9Zh0zSl8TzoMrVQOmsZiLIFEKI4zdxOd99h6s1riXa/Wf3zorUH0CC9/Dbv
	jYJW1ouRgFJML1e/tyRZDJJ9nKbcvZcZoKM6wqW6l+m00CCn+knYdvMmYFdtNsoCtmkSoNpaiiD
	21Mfamy8L9JSZqT9aiZyM/BgaJWU+rL/UtmvSjK20p9guq9/Z1QFr1kr+8DazBvOc31disJ1gxg
	rutjxCiDK8ba8WhqwaBqk6nlQaGxYp9u4R49UobtQwBOM3hXorZRTw1yPi3VKn+HEZQMKmnpwq2
	2VwyKNDnqDIAuLGjbQLMXtD0BQEqvp/rKiZnnDLiQGVMFEc3zOUj2c5NClFGiEn32+ye0h41aMr
	sHz2kirUkMFV+/xbp42/iFJkceyUW6Ne4QKvVgu2LlYqGCl754d1ViAC6mAaPFCWjWWQ16YOv1y
	l4T6/Ad4/kdL+f737z3JuIuH/elh1i8vayDJO5Nrm98NMWq1sQBrVyFKOb0poxdqCk=
X-Google-Smtp-Source: AGHT+IGfpYym/+ciEUpgLGEk2Uo4k9tfz1NW01FXx3zpjWrnBawbwhix8S/o00+hWVYZ5LW7eOMiOw==
X-Received: by 2002:a05:6a20:7d9e:b0:341:262f:651c with SMTP id adf61e73a8af0-34f84afbef9mr4621605637.25.1762364044019;
        Wed, 05 Nov 2025 09:34:04 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a8044dsm6027302a12.16.2025.11.05.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:34:03 -0800 (PST)
Date: Wed, 5 Nov 2025 09:34:03 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQuKi535hyWMLBX4@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>

On 11/04, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 

[..]

> +Autorelease Control
> +~~~~~~~~~~~~~~~~~~~

Have you considered an option to have this flag on the dmabuf binding
itself? This will let us keep everything in ynl and not add a new socket
option. I think also semantically, this is a property of the binding
and not the socket? (not sure what's gonna happen if we have
autorelease=on and autorelease=off sockets receiving to the same
dmabuf)

