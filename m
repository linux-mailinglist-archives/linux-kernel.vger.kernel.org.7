Return-Path: <linux-kernel+bounces-736693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B2B0A09D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDF21C45C38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CBF29E11E;
	Fri, 18 Jul 2025 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey+0tlEA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EB29B76B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834424; cv=none; b=dYVYSL502avGNTisZEO72P/7zkFXL42xFzN/gEU/Xw3OOJD89d5H9QHObg/bQEhgk31mG9HBzYRIqCB6B65S3MvWnVV8IReufMIgb7O7NZnoNrB/V//0867HratzB3gZPsw70Ij1+JdnE+MqpcrYHsAbSCPDjWGFI0G4EzAYOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834424; c=relaxed/simple;
	bh=d71UqziCB1PEqXMxGJqpbsDzqYOwk82CEFioZiPyyZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTgerFQ1MQb8C2SV53qksrUhzSFdYqCU6fEg5aeMy4ZSpzxY0a/j6PgFPampx+LhGXnl4o3yCHPG6be9bDOrLC7KfD26lI5XvaTfBR1wkApHV+BLN2JczhCJzUtkFysbAgXUYelScTgkNFMkpaywXpnXYyuEBSXOCORzRmCcl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey+0tlEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752834422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d71UqziCB1PEqXMxGJqpbsDzqYOwk82CEFioZiPyyZQ=;
	b=ey+0tlEArXMNs/tr3wxApEYjW65lI8yKtgKyr8/YvPkCONpExPbBRUHbKrgdFqqmLG16PE
	J9155tug0fBuAF4pNf2LUuB0xJtOGz2cMvymIzX4nTVxh8HcIjIy0Ci6RrYspm56jVfkma
	VKqkcWVmwGxRUKI9KcMMc4sNot22cE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-CfQGWZVuPRyAnxu3TJzUcQ-1; Fri, 18 Jul 2025 06:27:00 -0400
X-MC-Unique: CfQGWZVuPRyAnxu3TJzUcQ-1
X-Mimecast-MFC-AGG-ID: CfQGWZVuPRyAnxu3TJzUcQ_1752834420
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so795324f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834419; x=1753439219;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d71UqziCB1PEqXMxGJqpbsDzqYOwk82CEFioZiPyyZQ=;
        b=iYVX7QvrOV8k1EL651U7NQAH/LvpUXKBz/lNtpw0SbjSZTas0vLkNplnr80GfgMP/Q
         gLqhtObKjHSqrWh3yFPGDvzVsJocH4zauxyvfxEefsAmbU77u5iCob/D1oxnoUS6/ssw
         SjD16xTcF7uQXq9BboQbxlRUSmtsVdKMTRrVLnEDR04QOYKjBq8O6VmwrVxeS7F2B+1Z
         gJnqTu3Xd72lXbCbK/+GG7L9WpYCXJ+dXncylz3XkZVgOKzg6Z92F3KOCupFREF3FTBX
         9lE5gHx3e6gkdIV5j5+0DXHTnJ84carrhtdJeFQnI3Wp9wDh8GxNmDHJ/UaCpX81Zc7i
         p4ZA==
X-Gm-Message-State: AOJu0Yxt/BYW8NfUUgJrXgzQBqV7e/k2pu5e5DRHY6LH1qrdt+w2zPnB
	xkjXVWrq0CzGZag3eC0SqD6wSpg/rBBGsRsnFXVh57lDJlx5CeX7DHsex9/KeJuX0f0FbzCHNXg
	K64cbUOrdUyaCvFEJ0QQKtfSIu3plA+anRyEOx/hxCAfT92S7GffuY2DU2/r3903dcQ==
X-Gm-Gg: ASbGncsxyCmF4g9vLM3Lv/FZwGB+FL0Fi1dedBlazWpE2GA1CTDDPhzYNCm65EQ7QtX
	1SDK5qasC18rOFVPIhuUboIY7GRwPj5Mc9brkcOHUTBkjrqR0bw/Y04J7hL/8Cuk6uTQlh/miE+
	JOVN7RYSLBmA2lFFex3aqZH6zcD6UAvpswxWAZX6C+7nzy7WKOGCKhhqnDChBAGpUlETqyTiAdS
	ny19rDwSaO1A3b2oWIpJ2Tg7zclpikAAValxqxSh0qYsyzu4PqaXOWsBDF+I/TiX2IORQiwHr9M
	uzZXUro4vZHF0zRFv+5rZbEIEWxlVxo6U6vTqmAACq4BT1lqM3SOAV1aUL3itqhCVA==
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b613e66eaemr5223585f8f.13.1752834419493;
        Fri, 18 Jul 2025 03:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpi/oLZSfF2NXEYGs/7vTSjp4YTnet4cpMnngioIMkIsZI/XYrA/Hg+gK4DTjgtUrkSgaj9A==
X-Received: by 2002:a05:6000:250d:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3b613e66eaemr5223568f8f.13.1752834419110;
        Fri, 18 Jul 2025 03:26:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74029bsm15741565e9.22.2025.07.18.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:26:58 -0700 (PDT)
Message-ID: <b9b66047398157a26ea78017d3b36482fb67226d.camel@redhat.com>
Subject: Re: [PATCH v3 17/17] rv: Add opid per-cpu monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 18 Jul 2025 12:26:56 +0200
In-Reply-To: <20250716093825.rWXnBtv5@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-18-gmonaco@redhat.com>
	 <20250716093825.rWXnBtv5@linutronix.de>
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

On Wed, 2025-07-16 at 11:38 +0200, Nam Cao wrote:
> And the monitor reports some errors on riscv64 with PREEMPT_RT=3Dy:
>=20
> root@riscv:~/rv-tests# uname -a
> Linux riscv 6.16.0-rc6-00054-g7590637d9ca2 #87 SMP PREEMPT_RT Wed Jul
> 16 11:26:00 CEST 2025 riscv64 GNU/Linux
> root@riscv:~/rv-tests# stress-ng --cpu-sched -1
> stress-ng: info:=C2=A0 [452] defaulting to a 1 day run per stressor
> stress-ng: info:=C2=A0 [452] dispatching hogs: 4 cpu-sched
> [=C2=A0 614.390462] rv: monitor opid does not allow event irq_entry on
> state in_irq

Finally managed to bootstrap a riscv VM, that is an error I thought I'd
fixed and I'm genuinely surprised I didn't notice on other
architectures.

Thanks again for catching it though!
Gabriele


