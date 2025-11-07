Return-Path: <linux-kernel+bounces-890526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A57C4042A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046881888E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDD328613;
	Fri,  7 Nov 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jd05a5Y0"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684302C3261
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524636; cv=none; b=IFJ4+3homg2Wp4FHV6HpgALcPp2JN/d6YOSGj9jb4q9DsrKCa1btoacDbPYtl5OmDgRBlvEy6ykMBv9AJca//A6DBpc+E8VSAP0vLQJKhQ0yzaj4xr6adqOuxQfdOKh0VZYE/cq4kaZ3cCQoO9z5V0iw5P3dQvhmHR3mgocJxFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524636; c=relaxed/simple;
	bh=+cZzo8xco90BPe5zTjWVIqWQKXNXcQ8nK2fbETbWVGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrFsAgx8r9fAG81KEHtgHZsJME8fwQmXWN/W4bJDLPenXQ43rlWCCbxyRqQyEN18WMifxHwoINUbwnSBsNv/9fR/tog9kNh0HcDzuxIuPKXl4Y3uzQJVGB4Nxke6nbLt9jaOnwYVSRPUdkSIgEBGkbRAdwZHjLk8iJYOgHPxU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jd05a5Y0; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63f976ef4bdso696584d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762524633; x=1763129433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cZzo8xco90BPe5zTjWVIqWQKXNXcQ8nK2fbETbWVGA=;
        b=Jd05a5Y0VSWEg6+WhsNNNP8SP5sWGXlREIoQ7QL1YSRh5n+xYDYKhN3VVUF5PMauNv
         k1oFQ4XdybJJ816WPMB9wp7ZUPFavSRX9FvwVWWlnnjzf8spk9fKGrSbfOpG51a7JYKF
         JMpQOLl2JhJsh1qCk18sPyzOQBYZ3r135FGyQ8UNNCm2WGWYNy0sLx/uSC7sF3TMmpaJ
         kdDNfQClpuTYwY2H8E+M3n9CfevAXenBf6j91ng0IYu8050N2PJuSKiSSAkjhtZ0pNs+
         4FLdX11mJsMvMSMlOG/nOE9MYyShq60mBDf4ArZr1eLwyOWJw5UexKAaLmIXZWMCF56m
         k+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524633; x=1763129433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cZzo8xco90BPe5zTjWVIqWQKXNXcQ8nK2fbETbWVGA=;
        b=nmF357NT0gMNsvQDn+B6DGCRv0Xus6Z/RRVvMJhuuQ1nonX1rflTYQkUCvvQxQz9O7
         7e//9nBhMZwpcFSQ1mYOFbAiLY3kGNIT22Z+XharicqYR5K5GZCyai5bmZBt4wDD/qCE
         JNzUhgW7ZEGIT3F1xt1tDQzrqQnEsBcHp5MPISGHSBRMta0Xt53XeO/qTZ6d7i0fWvz3
         hUQTh4khPpEOwhLdltgzozq5AUqnM2vLAilwBwKde0VrtqVttQNoog9tBjaWY2Vav8mW
         mP7bNPRG/tQlVfk3voHCLQUwdykF8YKg/nno29Kif9rZ22onz9h45K8A2PVVxY/hOTZV
         lMLg==
X-Forwarded-Encrypted: i=1; AJvYcCWnIFKI4ectrTjZbmV3AQfPeccmgSlWVPCXlP82LiPvT1ipTxXc24KavRP6oD5mwhJtsK/RxDLF71KP2aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpv6xe+crNj6HGIj/CMwAn0ZVKb/8sLuAciljwaly4QXqxQ4z3
	k5Ko7QFKNCXpa0kZJBntHwOFdl9ZBhfRzcVovBIasdEVogrzvDcVghMxrGTflayrbSKWK6JrxwR
	13zpTZS50XkXZAT+RpR5qcKoEtf4VoP/jpECLJi5U
X-Gm-Gg: ASbGncss1+GXElhFMXBcG9OLiQDKwUG7bFf7Z647AqifeyaDICeLTdCkNjuv3zICEIb
	nR480avIuypO0bj/FUovqwAzu9DGIJPkpWYaGBGd4TVBK1xKqzpdVT7zPoQ9iPHuvLJNQ1lfjxM
	jOUosMRI+A1Pq5uYT8DI8GQTwYcB+KljU5p/o12TH9kk5ZwddHywdKXvOrMpXIFsDSfJHCYRmvK
	d1roLjtXEdMUYIvDavHrqxnWftT6PH3hd432RxpWiRbmZUI1J2l4k+wiMNS/zQe2ABI6MQ=
X-Google-Smtp-Source: AGHT+IF4MNPjtjkI0HykYzQ/N+DjSl09Uwih8EXv3NQX/RBzR++OlV/O2BGN0tPhSnQ92UawBVQW3Cb0VrPm4WrY5A8=
X-Received: by 2002:a05:690e:2557:b0:63f:a48d:b7ce with SMTP id
 956f58d0204a3-640c41c6a29mr2059410d50.27.1762524633098; Fri, 07 Nov 2025
 06:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106175615.26948-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20251106175615.26948-1-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 06:10:21 -0800
X-Gm-Features: AWmQ_blZgftDNHs4-HzNXdI8nrjDZ7hGHov3wbswer-i55xUXiO1FMu9wnhdIiA
Message-ID: <CANn89i+Cc=y_Powx5aWC9fkASsMpuDZsL5TxDxEQiHmSjj4khw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:56=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> In the current implementation, usbnet uses a fixed tx_qlen of:
>
> USB2: 60 * 1518 bytes =3D 91.08 KB
> USB3: 60 * 5 * 1518 bytes =3D 454.80 KB
>
> Such large transmit queues can be problematic, especially for cellular
> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
> fully occupied USB3 transmit queue results in:
>
> 454.80 KB / (10 Mbit/s / 8 bit/byte) =3D 363.84 ms
>
> of additional latency.
>
> This patch adds support for Byte Queue Limits (BQL) [1] to dynamically
> manage the transmit queue size and reduce latency without sacrificing
> throughput.
>
> Testing was performed on various devices using the usbnet driver for
> packet transmission:
>
> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
> - Quectel RM520: 5G modem (qmi_wwan)
> - USB2 Android tethering (cdc_ncm)
>
> No performance degradation was observed for iperf3 TCP or UDP traffic,
> while latency for a prioritized ping application was significantly
> reduced. For example, using the USB3 to 2.5 GbE adapter, which was fully
> utilized by iperf3 UDP traffic, the prioritized ping was improved from
> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
> connection, the prioritized ping was improved from 35 ms to 5 ms.
>
> [1] https://lwn.net/Articles/469652/
>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

