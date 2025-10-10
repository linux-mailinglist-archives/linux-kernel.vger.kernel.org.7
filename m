Return-Path: <linux-kernel+bounces-848554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8430ABCE040
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D651B2081F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B0A2FC895;
	Fri, 10 Oct 2025 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVTg8c3A"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952D2FC866
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115492; cv=none; b=TiQ0dU84zkhCKzJ0fJndnAO/HRfDTJpaIN1K5zrgPpzVen7mCLhB8ogGp6bhnnSacW8Jm6H2mZaKSif0T+9X/n+J9MYFaB0O4CpNtsKGsipygxhBwOKdm5wfwfXwMZ0IYvuyHUiT6oiTI56t4GquaB6wBAU7HML3Eiil0AN7OKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115492; c=relaxed/simple;
	bh=YQIzgJBxlzPG5AlRv9L+UYbZx6Wu2WPPbf0x9Y29Mts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=U5EApcBsvnCnNtl83PmIIkDNrruhvouWM4RMCB8DbJQCcdJBjNYwU1ScKH3EXH1TzsK6omqH4j4FAGwdbbX04uhDazZl6muJdRVPHg0S4aX2UXcaXbU2f7JDil9Pdq/4YLW+anwITCMmDum8CnUhu3Pu41Ubpl+t14xy3Oa20ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVTg8c3A; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so1774679a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760115491; x=1760720291; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQIzgJBxlzPG5AlRv9L+UYbZx6Wu2WPPbf0x9Y29Mts=;
        b=IVTg8c3Aj6VRZ9oSUNVWWb31sDwJwi0JGoyCtWNmkGB5qHshdK2u0c2b9ZDYDaY1Fd
         a1QCDSfJSM/Ova+7O48NUEprNfuOl6BytiBe/JgG7mn5w41qVIeZGgFwg1SFOtbPr0DI
         H2IskcjC/CfgqGcr8/K127IDoXaomYcf0f/vPnnBqCM4ZIFKaY1KJRymUb0kamswiFA8
         neAq970dBldmoB9PfEtXmEpTgJwMCebbebDD1qWl4CcnFTHDIF1ahj0gUTc/OCVrvvQ2
         hwXfmKOMyR7iuFMscZGwVa8dM7MJ5JeCazeb5xvEnPbIiZxaavNcIbMPjUI4Lq8RUDj8
         EZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760115491; x=1760720291;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQIzgJBxlzPG5AlRv9L+UYbZx6Wu2WPPbf0x9Y29Mts=;
        b=doqR72QaPGyycz/1k8ZkJJYckpViraRfIUMQ1Ipy8fWxqoN9uA37WQ75OVHFAZmkSe
         ZbmnIW7YswjS2wqDiEMB7o4CqvI65zEoAisqjVukm9MkyOx1gENt1yacVstO68mjzPl9
         RuPmjt3mN9pjMgyZCHHJ3bB+z997tro4AnhfwF43j0X5E8qcEXMy1JXbqtI1QLHm3m91
         HEaF8qR6ATIq0GnRRmBTzRksBHewZSS2ZXmrU/xrQd/CLExUfdMnImguvkYHFjqbR4ga
         hfoyRUMR4vM41gMfd/uvHb+JwftC48s6WGcQN9XIZfjW36Nb0PjBlPOokYL/+5E+jyGx
         YRGw==
X-Forwarded-Encrypted: i=1; AJvYcCXbB7gR+K50C+nByP0SdmUthpoMebZBRk9K7Sdz5qHUvgDhlmLjv8NQpRDfUxBvaZ5DHNmxkAEJXT5dpEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/b5BfWndwW5nAdIEWweVztdUbKZAwoN0G3Eq0Rd4AN9fQrZAW
	jb3VcVPnC6oxRC7L4PpSGDr8PevPGhW3wQJuZ+MY4cx5RA0kBZlZ3j6G
X-Gm-Gg: ASbGnctfyrOYYA7+02jHiLovP/vCOD3aELUnf1HEst+KdprpozWY3P2bT/pO6PpjTX5
	S0d7L8nwaUEpXI76qhmh+DmbTzQSei6QQVmQSJ0RE4/S27kKbJT1CFsCdAhbqS3j014RdB/HuS/
	TIO+EGhxNt4gNssKASeuTUqfGoaYlMCKOOHnpsEzCfIieKkV1txgi8jA+OiIh9oHkkIA+ZEOIbl
	8k25sjUcaoZn+fN9qoyx0yaOeTF1cA6lYWAmO5hr/6OFMC9yYKPWBJCXplYkbZpWYYz0/eYrMA+
	SFOpUjQLtdLeIdWLKymwyytVAks/xqtOkGvmOGDQE8GXVV5B2GXuqZwTKDwg/Oo3UkQKL+lXUsi
	ghRsuCJwCoy4avNi54KQISA5MfWaI4heCpCH84w==
X-Google-Smtp-Source: AGHT+IFe5XfGJsLG96cHOz2cIoZiFjCxmIX4mzf9nbE5HrQUc4cqUqYqn0FJn0Nd1KULwqb0Pe1Evg==
X-Received: by 2002:a17:902:fc46:b0:27e:ef12:6e94 with SMTP id d9443c01a7336-29027418f97mr154166675ad.55.1760115490627;
        Fri, 10 Oct 2025 09:58:10 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f362fasm61712045ad.97.2025.10.10.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Oct 2025 01:58:07 +0900
Message-Id: <DDESV8839WLY.MLMFM3ZOOQPN@gmail.com>
Subject: Re: [PATCH net] net: dlink: fix null dereference in
 receive_packet()
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251009190222.4777-1-yyyynoom@gmail.com>
 <20251010071835.GB3115768@horms.kernel.org>
In-Reply-To: <20251010071835.GB3115768@horms.kernel.org>

On Fri Oct 10, 2025 at 4:18 PM KST, Simon Horman wrote:
> On Fri, Oct 10, 2025 at 04:02:22AM +0900, Yeounsu Moon wrote:
>> If `np->rx_skbuff[entry]` was not allocated before
>> reuse, `receive_packet()` will cause null dereference.
>>=20
>> This patch fixes the issue by breaking out of the loop when
>> `np->rx_skbuff[entry]` is `NULL`.
>
> I see that if np->rx_skbuff[entry] there will be a dereference.
> But I'm less clear on how this situation can occur.
When it failed to reallocate `skb`, and then a lot of packets come in at
that time, `skb_put()` in `receive_packet()` will cause a null dereference
and the kernel will panic.

> So I think it would be worth adding some explanation of that
> to the commit message.
Sorry, I'll make sure to describe the scenario more clearly in the commit
message next time.
>
> Also, I do see that break will result in np->rx_skbuff[entry],
> and other empty entries in that array, being refilled.
> This is due to the refill loop that towards the end of receive_packet().
Exactly, that is correct.
> But perhaps it is worth mentioning that in the commit message too?
You are right. I should mention the effect of the break in the commit
message as well. Sorry for making you point it out twice.

