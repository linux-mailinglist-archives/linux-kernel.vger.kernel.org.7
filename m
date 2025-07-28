Return-Path: <linux-kernel+bounces-747880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81EB139A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745BE3A2818
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3121ADB9;
	Mon, 28 Jul 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFtYPbyN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD13256C8A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700858; cv=none; b=l0uAq+gza0qoNfyBwCqaAfveEwlwCJjMe1pQGvUTnDxl7F6U+fpOLQhhW8FSdS7x/jDaIDhu+7Wmu2eJnYGfv4V/CAINeuY4AZ3PZbmoMjoJ0q314Wwp3rP1tUns0BGpt76BneHBt12FdK39jCdZ7FYMZ83B3BaQvX3qJtr9oqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700858; c=relaxed/simple;
	bh=3pLYVdF0nsoFSAeexE3LC5Q4ZaY3uvZPzbJ5RP104kw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXYJ5yL+KdrlSxtBhncnDq4uiE+DGU156QuTksSZci+HXk3pshYzAT1qlAstXBOJ5mFTHuz3w/8nOWt9y7DXM2BPeYa8M4DzipVlNyrGkAIJcmTkaHsvuxRA7KDBIiZ9x3d7JSR6ZqNGixRr5Lx36zERg2drwDTu4VvEdN9oWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFtYPbyN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753700855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3pLYVdF0nsoFSAeexE3LC5Q4ZaY3uvZPzbJ5RP104kw=;
	b=SFtYPbyN7O9idVotXqppmllDRewcGD++72RQ8jRZ0W2lpqesLqTt9c1s0Cud1XbC92k+Ph
	rehI1a588A7o0foZQZssgMCFb5lPd7lPgYEM1dvHw4P4nPk+BjanikLTHItV4k97N1sqdm
	tBzJ60etsUK8FqvRPAkSAgdXx5SXtts=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-BFHVw7cHPQG2qNib3i3Evg-1; Mon, 28 Jul 2025 07:07:34 -0400
X-MC-Unique: BFHVw7cHPQG2qNib3i3Evg-1
X-Mimecast-MFC-AGG-ID: BFHVw7cHPQG2qNib3i3Evg_1753700853
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b788d00e26so456813f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753700853; x=1754305653;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pLYVdF0nsoFSAeexE3LC5Q4ZaY3uvZPzbJ5RP104kw=;
        b=nQCOhW9SsLOfr/ohvcuBmd2w2tAkLxlF7dVb/fS0L/4p//99lx1++NzqKxl9gJgK8z
         xyZAyW9a1MLTGEBslQ9VQ228D82/NkgkYeoqaQsVDD5+E7DAJY7gQezxNq1SxUTr0wBf
         3WOuZJION1tgnem25at3Cd+5bp34ANDhW1EvAhKzHD2gXAZam6xBWqMqPPpi75NFD4Vs
         bszsYyJhCyIoOKjdpvXdg5In7Ayv+MPnOIAFXZVCwEndiUpAaASuVtqf7ELTu3y8JXP+
         LTP8jSeWdzVPBgwEPX+mLYc4svdHt5QdqG7IKHkQNR3fZYP6PonEHMLIU1vLaj8VOda/
         B8Og==
X-Forwarded-Encrypted: i=1; AJvYcCWX+D/6x7MAZWCX6b4HNLDa4EP5ClBG4qz3L//+Hv/n5I4NicBj7XB5NLL1S7vxXfEJ0aZc0/J2XckcWWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIs/Gl0T0cncN/qVB+iRvVVHHU1eTawzLHJL4tb4xeK4D9HPe
	+4tfwZhLh/cVLDyYReHMbdYOqw6MTvyZzoGytTsOHt/3X0h5Yjq26WZL+umalizPLIMnkynM3LN
	xYuHeaVuvxBQcnO5YOOAdLuxmwViqSDE6a/8eUgVsh0plJSbNXnMFSrPlO4rLt1rSmw==
X-Gm-Gg: ASbGnct1MYyIpiiEkjgZn9hIUfcVSDZbYS/eg3+0o/PiLIM1NwmISiRpGHTb4FMNJnC
	0eBzn+QSWq7j+buO6abYYaR4oB8p+ugiJKi+UbQ9+sNotwVkJxP3bCtZv7w+UJ3JdWXcifQ6Vds
	MRpApeAkVILVHatMQ+SbVEkHq28CW/Rr8dEdnTxLRvrw/oHJZJ7qrpRTwR65uzeXSvjl2fbOF0D
	x1S5XAQ3gww4nv+Mr+P3pEpuev7BFkGTqzm85HnlzmZ44zUPMRKbjwdykci8RK4+H/Ha+FfTm+O
	Cdo8OR32jnyfByKupf+00M+xbgJsHZp2ODNSM61TdTesIj6r5+YNNFlJ6ijDRd9XvQ==
X-Received: by 2002:a5d:5d0d:0:b0:3b7:8ac1:5e30 with SMTP id ffacd0b85a97d-3b78ac161c4mr1349607f8f.52.1753700852643;
        Mon, 28 Jul 2025 04:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc9z70EWwmlpMr+OkfM8TnShKy6POOVuw5YobTxWmrC2LyX9zPwQLNTb4Hr7NxYaUNLOK9aQ==
X-Received: by 2002:a5d:5d0d:0:b0:3b7:8ac1:5e30 with SMTP id ffacd0b85a97d-3b78ac161c4mr1349575f8f.52.1753700852173;
        Mon, 28 Jul 2025 04:07:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abeb39esm93840635e9.13.2025.07.28.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 04:07:31 -0700 (PDT)
Message-ID: <8d2c34e9d1ac5534ccf856242c13f2fd3c1000bd.camel@redhat.com>
Subject: Re: [PATCH 1/2] rv: Fix wrong type cast in monitors_show()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Jul 2025 13:07:30 +0200
In-Reply-To: <20250728092756.C8zMlJtT@linutronix.de>
References: <cover.1753625621.git.namcao@linutronix.de>
	 <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
	 <786688d8a5ab0d5228d271861416d49cc3a8ebc3.camel@redhat.com>
	 <20250728092756.C8zMlJtT@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-28 at 11:36 +0200, Nam Cao wrote:
> On Mon, Jul 28, 2025 at 10:59:01AM +0200, Gabriele Monaco wrote:
> > Good catch, thanks! The container_of is the way to go.
> > Do you have valid reasons not to move the list_head to the top?
> > It's
> > not a big deal but it would save computing and summing the offset.
> > It
> > doesn't seem name (the current first element) really needs to stay
> > there.
>=20
> I checked x86_64 and riscv64, the generated assembly of this function
> before & after moving the list_head on top is almost the same except
> for
> some instructions' intermediate values. Both architectures have
> instructions which load data at (pointer + offset), so this offset
> computing does not require any extra instruction.
>=20
> Best regards,
> Nam

Alright then, thanks for checking!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>


