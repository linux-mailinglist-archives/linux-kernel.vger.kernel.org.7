Return-Path: <linux-kernel+bounces-817925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B14B588BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA187B313A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1034886334;
	Tue, 16 Sep 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvC7vPkv"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41E1F94A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980913; cv=none; b=ucdEJUpL7wCs3P0c1IvdL2SK1FaHUFeJJCX1LKv4Q0vuqZkK4/rCWgDMmDNGF9DcOPNVAX5x6nrY/MoXRDGdrvlgoHKUr/r7VJDk9qLPifQs0YsKQZmV3KrnUL4XrqSXCDjjnJu0rSLD5GI3AeCy4OzVWpnAw1uBpcKbx1zzomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980913; c=relaxed/simple;
	bh=OGGD+kObc2F8RK1KPO2tRg5YhSB7GSmN9r4+FXRdiU8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NFLQ2k4ajAFZPakzxoHx9cPnpn5PTsk7LSlBjd/XEb5cD5KZ67ReL+SUE2vivPpPrQq+bOgIdN0uCFmpnCLyhS/hK1XbomtytK5gBzr81G2bXKUTB5iBZQi5P3WUmOcMs+hWS9MavGMnkKD4sAeONY4opd/YVifE9yw3XUxfYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvC7vPkv; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-82946485d12so166505385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757980911; x=1758585711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km5Y2enaETffJi393MZ/B/rn6VFmUTZwKRF4EtXN2SI=;
        b=fvC7vPkv+fNB+PWLIfgbo4FiMvrfAR0UjxOt3sCsShzX91ABaemqKhYagFtneLmyyN
         AMgkhxYlRX+Gk+2eFe8fFjVwOwTJ/f0kQo2+ZT6Ardk0jH6gVsfxnuIs2DNyvHxX/uJh
         tEoIwl6mXqRMNb8FNPiu4WSOWXDkFK9aeR5Yyqbq46Zbv8dgi3VDuw0HzzSDVPFV94K9
         7gt4zeuy/FjsdbDeqcoeGia+pBCPTH+AvXiPGYUvIqqY5PXKMTnTb0MjHwZ4YvUHKY2Y
         byQeEP8eXd/awD2+4ismaClURubSVQNU1hTcwfjgceAJfHnFe82MrDdTcJ+xPsWFO2WP
         BjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757980911; x=1758585711;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Km5Y2enaETffJi393MZ/B/rn6VFmUTZwKRF4EtXN2SI=;
        b=IJBRXg0LFmrfJmMGT38w7GNYEHUjF+lT577ihB04bH0Es40Q2OqTcZqsYFpVDcG2uQ
         pdrSSrsp/6zzercsWjkzlvpEn7UG/2vf75IFJU68rA2Q66a5F1p4wYERbIVErLDkbQcR
         4sUbfMWLkg+AQvoRylIUGZGdu3j8Yg6Cdu10DgA3/f1nTFU96oTBDHfcf9VdTYH9a+sM
         OZDUpH9hoift1ogbM+7rSSeB8DshDznhaJV8Y3LEadwGsaxxhLp6yfNkl6eAahc7Mv9a
         6H/4zlfhv3zpkU2xkp5zFYff0NJqlp+ISC+2ssjlo7g4IoibAun8yZRHuwwavfiMGgdd
         2hMg==
X-Forwarded-Encrypted: i=1; AJvYcCW7+M3fe7w6dLhuEMnVqQKTvcjN4+k5iTpBLthJx1a5Qr9AnQOCt7PhJohhRDqOjC1KZDpCzhNYxPyTP1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLE0uyZ+6LVVRyUmdWvwM05ocrh4oshh+rwG0zPQlmIoJ1cd0
	MARcYT2AOXwjPzZkNKux5gds+WbkMmzsWT1mVBvREr0TvtuF0ybanyjb
X-Gm-Gg: ASbGncvrer1lM/FxzUAW7IlMcHWOaTSMh/ieIvXCBUu02x788Q5MAzkZM4Nd9AA4qum
	eBnCtBl4hP2PkmR9/3037jUGNnjaPUEyA2xChAQOhPPQp/ZdUMD3VyzpLNlyZR/yw69or4aFrss
	ODsyv3T8qoDBaiPJp0MMoBuU4raCDRHygT64/lC7qhztw3mh/5Aiyrf5JVXQhWjB1v55pZLs1fn
	B75tVoCtpWjcIHAndQ14aGIJfsX3mOHjYGQz72OFgpYDuoF+b4TGXWj+9B/cOMXaKS8BmHSmx1W
	9fYWxMWYDHgylT10CnbWmL958CzOeETBbiA71VWhi3BoqCzjnkPPDZzXmkTCfiKHfVkbCVxO9Hq
	RHXgs2oKC0YcpTpBjtLtQYnVmhTloyY3of6a9JM3j4/QKzp4dBMa03rCXEqgbDqXt3KkeMynx4F
	bHqaWu1hyNORJX
X-Google-Smtp-Source: AGHT+IFqxyzlxIdJJRSkJ2g3wJFGm2A/PhKso66jv8vm3GpnTZZg0yc6FDwEhLZjKevphIjKV/wmHA==
X-Received: by 2002:a05:620a:1720:b0:81a:9d8c:7b26 with SMTP id af79cd13be357-823ff6db1a9mr1804763785a.34.1757980910684;
        Mon, 15 Sep 2025 17:01:50 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-783c85f16a1sm26696386d6.14.2025.09.15.17.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:01:49 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:01:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.163f3efc42108@gmail.com>
In-Reply-To: <20250915113933.3293-2-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v5 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
> This frees up space for another ip_fixedid bit that will be added
> in the next commit.
> 
> udp_sock_create always creates either a AP_INET or a AF_INET6 socket,

tiny typo: AP_INET -> AF_INET

> so using sk->sk_family is reliable. In IPv6-FOU, cfg->ipv6_v6only is
> always enabled.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

