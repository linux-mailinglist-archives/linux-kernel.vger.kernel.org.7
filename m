Return-Path: <linux-kernel+bounces-802660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AA1B45546
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC229583BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97052EB870;
	Fri,  5 Sep 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYaKJiyi"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735C2EB844
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069239; cv=none; b=bEwSLzKpReh14VgTh3qQQAz7D7W6TbzKrK7k+ieSK2rB/ZdoyFzvxyPifEp21HQOe2TjHndG0cXhxS17AfrVuWmeR/9FEDuQrNG3j3MGWc/cQjvYzUKwv/vCDh5y8j2AHNLxS8cbNb4jn+3uoTFy78Lwmx+dQWLLRBc5Qww8+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069239; c=relaxed/simple;
	bh=tqiu3s9zFltkSv11AxpsXkUUUkqMUieGxD3BL7JwWec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji3ZxkX/sVB6Q50RVUUQtybnXoPxQAp7USuMm1SlokxK35R0LvxiH/yuM079vUENrH82JdkCXsJsB8ugg7ZUVJCBA0Vu65QO6/mqpdM2RetlXqPLIxiuxRkUVPeQ+BfDX7P9Qp5BYnE1GGCa8CK4e3DXOfoEeYwxkKwrf6qgxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYaKJiyi; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-811dc3fdc11so16701585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757069234; x=1757674034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy3M+/QDMFTe34OIV0nD0yl53yFOocCSebdPGEJFkD0=;
        b=WYaKJiyimC59PycZD+Wl6RgPGCNG7VhTffk98C//szr3/mhYdc2yP1J4kJGcsCetyQ
         vvCwhkNCkv6am91orhrcgj6yl4ZrjyjrOscI2xnBEO9HnYrxnTGpLma/VJqKGF52BLSA
         usEdJDTV8nHIU9bk6LzpAOUWMUztse7/SQaOHUT+ic3xjE3bJxkhUlh3UI6Ugeeiwi3w
         IC816SC8yC1QhfgtKs6WWiBJ2pI+N4BKPIv6UWeEsQxgfbTDZZh0N3ULBKxrWpmI7FSk
         vdxJpwGXIYz+D9oTUeq6YHgtoRuqb8UwFAd5mPryJ41W7CnWw47hfQiTzsjQitVjq8D6
         tbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069234; x=1757674034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy3M+/QDMFTe34OIV0nD0yl53yFOocCSebdPGEJFkD0=;
        b=jGbDM/Zx//I9iz46OZEQITOfAOB269X/H8rzj45LzrAYHK+5ZkS8jUQJ1MoTjwBJ68
         svREJzjDwZvCOD1+UCmhYCCFs6ggsJwbZ8nrLby7wq9bV3y9dzam9JhFVRk6RzmanUXX
         ywJFh/01wMa7MDGzKj1u6g6/EjIgDUe6uZ7g22QCc0EDIIDTpIqXW3TU/JJ4S3VXUrpj
         uZdTptlL+78NzjK1d4y8Ppr/Rgcp/lmFBXuHNOlKeoGSIuB7x3+mVXi58F4jNx7e2EAB
         o6Zv7sDkpSsUVmVNDglQnMb+1IZSaZRY2UUtWhVndNDlGf7McXpYGYjRzLRs3FZJ+qgW
         M5ag==
X-Forwarded-Encrypted: i=1; AJvYcCWYX6lbzt/QQglZs2ZCci7ylKzD/vUkKNGyE4kMW1oK1N8RRZc7/n9DIVletqBlxpDRRRzCQkmw5Edvdeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+PfXe0ps6pIMSJeNZKDXldM+zz1VnT0vTFVkYSD23vZ144RE
	vdAiDJdAxzK9Uu8vUdNxIUebEaWUqx5pquDfqAw5brWPQkD/TjQ0HE/KDGvLftirSck1jk9HwbY
	kYh5Mvlm7cmPSdZS6LPXKyOctZVVtFxzVtl9PMGrB
X-Gm-Gg: ASbGnctHtGUF0jGX7Qkq1mkJ84sg9dsn3f4amK4GDoGJVQUlOeUV88IfaQVC5aSlclY
	dm2/YTEMIwKHBvhi/iRy2HDMVZH3tytVK9ZK8HwXhiWvccJuU4TMjbtSHcQgXgVnJOEE2/c5PHy
	yB0IJMfzgky3KvWqJ8rH8BYEfx4boaRTOAwKcliI7cxg/eHMORemmF7ZS61GkQ+Ce0BEY7VS8So
	o0ks07FQp2i8/+9YnwcO4NY
X-Google-Smtp-Source: AGHT+IEf/phnrXIkufCTZk4sFshrIxsZkHhdjyS4/aEGRW+A2spzOP7s35tJPyhD8Xp2ObBAoTmD8NeiPLucXfyQr3w=
X-Received: by 2002:a05:620a:4016:b0:7e7:fe1e:80ce with SMTP id
 af79cd13be357-7ff27b20314mr2475069885a.19.1757069233923; Fri, 05 Sep 2025
 03:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902112652.26293-1-disclosure@aisle.com> <20250903181915.6359-1-disclosure@aisle.com>
In-Reply-To: <20250903181915.6359-1-disclosure@aisle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Sep 2025 03:47:02 -0700
X-Gm-Features: Ac12FXzy0Cy-WdhGEnYslQBiaE0zk7uzikMaUzSMrpzivq_gHWsb4MyLhAXuOfI
Message-ID: <CANn89iJKZCfsNzM8D=JQqQ=vyaun38oXfcC77AC6BTC0MWvUog@mail.gmail.com>
Subject: Re: [PATCH net v3] netrom: linearize and validate lengths in nr_rx_frame()
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:19=E2=80=AFAM Stanislav Fort <stanislav.fort@aisl=
e.com> wrote:
>
> Linearize skb and add targeted length checks in nr_rx_frame() to avoid ou=
t-of-bounds reads and potential use-after-free when processing malformed NE=
T/ROM frames.
>
> - Linearize skb and require at least NR_NETWORK_LEN + NR_TRANSPORT_LEN (2=
0 bytes) before reading network/transport fields.
> - For existing sockets path, ensure NR_CONNACK includes the window byte (=
>=3D 21 bytes).
> - For CONNREQ handling, ensure window (byte 20) and user address (bytes 2=
1-27) are present (>=3D 28 bytes).
> - Maintain existing BPQ extension handling:
>   - NR_CONNACK len =3D=3D 22 implies 1 extra byte (TTL)
>   - NR_CONNREQ len =3D=3D 37 implies 2 extra bytes (timeout)
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

