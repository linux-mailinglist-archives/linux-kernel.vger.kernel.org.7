Return-Path: <linux-kernel+bounces-891554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FFEC42EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCC86348169
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF31F8723;
	Sat,  8 Nov 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQNfsCSX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFaNJfJa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AF3D561
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762613592; cv=none; b=EbpzZki4bRS2eaJdsowXc5HkSdP/tccZClvmUU1P2wD5PLmWhvewnlM8cWzO33wA/zUDukQRWuNVRrTcvIvKpNUsHCpUMBIWscTE9aYLPGKmZ4j65S1jnmXD22Kfnl6kALQ7geFHAySPblj4p6dogS9T6HaOBsv4WxbTPzpWtUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762613592; c=relaxed/simple;
	bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3x5G1m+jG0wHap3Sfs7Nt27Kd8/UAd/RvPKX8AimW4bo/soj3uOGDYvd0qq12u3wktG4i/CjJYS0Amxb+Ds4tRvKpgMadkkjV4q5gnk8M3uzYWFMUfIZBOkJQnyILRJFDIN2Y7+Xx30sctnzT9oERwXuc7a9ANIG4zXu2vBo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQNfsCSX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hFaNJfJa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762613589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
	b=ZQNfsCSXIol1DwjW8eiuYg3yxtQaZeeoFZRkFXbYOE02VaruNyVEZtZXWWWzDUPOn+L7l0
	nv9F8bYEtCHMu6XgSDYmK+2LICuDoonyFzkQVEBwWFGWBzA9awu8Y0Uiu1fO8FBXGaWD44
	fnAWWwR9iy+9XMZPeOmvciwYLXOpBZ8=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-FL02wneiNuO50BN01A7MOQ-1; Sat, 08 Nov 2025 09:53:08 -0500
X-MC-Unique: FL02wneiNuO50BN01A7MOQ-1
X-Mimecast-MFC-AGG-ID: FL02wneiNuO50BN01A7MOQ_1762613588
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-930dc545b31so933693241.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 06:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762613588; x=1763218388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
        b=hFaNJfJaOfiYJakUF6UJf8OL0wN8Ah/lg8PALKRTQBS+jJaMoE6EyBo+/uapfwk89C
         rXiGTUUNCx7vjSCXCF7tVue4qANVqns2wrTWpq/Zym3eQ5/M/PzxqpuxvLIDa4BvukST
         WPZ59CpXgntVjce+UHp0IgbmxgEDHOMs0YENyOiL8gW/cn3eksBus+82ghC9pTN6b1+M
         uIoV4xBwAGE6OhJGgyvSFDY6qW1sBEzE9H5SyAGzXfzJPczULzzRi79RtY836bsnZq4U
         5ZcESq4L33CNqf1vTz1cObXADav4EXsnoJsYLH8bMeTdi2A91k31+Ezod3aGL5ehX+k+
         bjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762613588; x=1763218388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/pvfdvLz2kekRf1KXJQIhxor6Ncywo3beSJvOhSq/s=;
        b=vnCZW50KT9u15+xuEyMdJBNy+6JxxQpi0nQ64XKcP/g5xfBe5vk18c2f2K3wPqdYIv
         76/jOMkOupSOSbV8YzAqBXOqQ/tYLOb8RyrsCrgZ6vnDIZBKpYaCGhevs0ItDS/9HbcX
         ApLhgtsQo/CY3sqZTW3Xg0X8r4BmdbcSLg005Y+Y0bO7zkJAwfMvKuzYUiBcf/md9bgr
         jmDwKjaR9ptusKtFEEOfgIPRRSRzAQ0eOd35z13pn1V4Mr7/hXgNPjiQNbisyH9pIHYR
         s515MpOCoq1q2iiXEEV7xGtDeaVdaplTALcJrqwcMIEUf4E5yArCk4QMfnbrO3ifnTKa
         3gFA==
X-Forwarded-Encrypted: i=1; AJvYcCUHTJZ5fGSZK6fXt5/J2gUJ5suppZuLuKPMd9os9oKRXufnRi4YbNg3UQ02mPOINMzZdp3g8MZeTmaCjDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotYYO2/GirIi83lmmnz4sn3Zer/udYNMOp5vJjtmOAPhhjjvw
	b8qqpqPj3x0K9lvFZwoIACbvYMRfXPLHV+v+QFxbsrFwefyzGNfRt9cATwP/Ow0qWE1mfkuL/hX
	2i9vGwX7zUSQ+LBqCvtUz4lQvHHOaF1gPWC/t69GAYmzYBeno5gLW14saf90B3kCij9NSXislwr
	jwiwiyABSQT9OrjsCbniaQq391efHjMGUqmvAscDIz
X-Gm-Gg: ASbGncszxqc/63lzVx4Mc59u9iTlSrq2rhR90Hbs/PG4YmR2N/WZ8E2FxhcvNZfxf/K
	IzYD2aP6YNysBGJceC2aBfTHC8E7wHOSBYCYUhI9fN4D+J1+8UPyF8InZRB3J1Fm+jMaO5izNbS
	TFjb+9RScWQnIGBe1ajQNiq6gXOEIe5riWeV/AnDIHiqu4JNTgolRbALx3
X-Received: by 2002:a05:6122:2a0e:b0:559:65d6:1674 with SMTP id 71dfb90a1353d-559b32ecfc1mr781023e0c.14.1762613588150;
        Sat, 08 Nov 2025 06:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpfXbjTTSMaE4v8qrE291tFIS6TN2LcX8U6LtZK6fslNq6XbOw/4b7sE2PjVGHDcg2ww2yKZ6a9/OifUdY/Ng=
X-Received: by 2002:a05:6122:2a0e:b0:559:65d6:1674 with SMTP id
 71dfb90a1353d-559b32ecfc1mr781005e0c.14.1762613587832; Sat, 08 Nov 2025
 06:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108042317.3569682-1-csander@purestorage.com>
In-Reply-To: <20251108042317.3569682-1-csander@purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 8 Nov 2025 22:52:55 +0800
X-Gm-Features: AWmQ_bn54L_mrL-XH2_W-7fM1t6V8FDDbIvOrhBipY_MR5DvmqHYfqpmmtoUoy8
Message-ID: <CAFj5m9+P9FmNk6kQb6GUgFvTwGm9orGF1ycnvSxGk5QiYx7Lpw@mail.gmail.com>
Subject: Re: [PATCH] ublk: return unsigned from ublk_{,un}map_io()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 12:23=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> ublk_map_io() and ublk_unmap_io() never return negative values, and
> their return values are stored in variables of type unsigned. Clarify
> that they can't fail by making their return types unsigned.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


