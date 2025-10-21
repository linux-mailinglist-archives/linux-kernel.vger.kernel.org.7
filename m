Return-Path: <linux-kernel+bounces-862380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C9BF5203
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB64F2CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680E2877FC;
	Tue, 21 Oct 2025 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPYnrdyH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19422874F0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033518; cv=none; b=PjpBwRAk1oJ8c+LAie4y7T2BwW/YBb/YlQRoyrhCOvlWPuafmh6di/w6DSSKuxv6lOfBMqT65y3bjmgKOC98vYOfmG+cYnBurgp1V/t9NmjW8B1VrFbiOGY2Y1dOqngsHtOmyZYH/LUGdlkbJhmshZ2aRRgDNQIsfGkwC8wHSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033518; c=relaxed/simple;
	bh=mjvBaJHGfy9bQLWbCLTTwB+4pIKUwbXpvvTlIuu0Res=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pnL3ljwuFZScdpihJTrAHypOYstPFz5M3axF8eHr871DegUif5M9sJZttTRsiHby8NFtDv72HIHg9rud8MGPSI2+GYMyVwzaJPJVtZHHZJjOp7qHDY3bqNLBnJv85kvMwzV3A1n0uPo0ezoVj7IukwSv4ln6xn+7XWasjAY7kGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPYnrdyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761033515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjvBaJHGfy9bQLWbCLTTwB+4pIKUwbXpvvTlIuu0Res=;
	b=DPYnrdyHRN6GFUbgRfHym5s4H2bBY9Kr9mxr+8AN3mjHcpt7jn3d6MPhg2Xzm4SYDnIAvB
	FXtD1w9c94oRY/Npxg1hVvxt8T6wyyhy94l1QZjMOH6D281k3RwbFpv6gDLkWm0OgWBmNf
	6qDYhCdCKh5tCAr8+9IQ2T0SewmseIg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-UN_BiSVdM4u10eDjGr0SLA-1; Tue, 21 Oct 2025 03:58:33 -0400
X-MC-Unique: UN_BiSVdM4u10eDjGr0SLA-1
X-Mimecast-MFC-AGG-ID: UN_BiSVdM4u10eDjGr0SLA_1761033512
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e39567579so31670595e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033511; x=1761638311;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjvBaJHGfy9bQLWbCLTTwB+4pIKUwbXpvvTlIuu0Res=;
        b=ZqhepS1NWCes/BTsjuGI8QbAlTwfcLz5CVNA16ckIUYpp7yX4Z1XEfKDhsviRLXAaR
         INS8l3pUR7LFfBbcRYASJ9vayKG21OMKyr5yRuP028orhF+MUwOBVQdo8F7X5JBQuEsa
         /GRJE3BCs4sv44LG/KRW1jP17j6ArL/tZXKUatRDFpn4YKWIOzqD/gmEupNTEeSXfHgb
         cq2s3z0lSP8h9G/kaOyNFRlxUhTN6jm/xjhW1BjJy/Mpnd5LEw+VgVncDTp4vBspfvtd
         OAgR9NplTD53cRsA3frccPZusFE/wkOaD1kYio6V96syIcyjnFI0GMv2gUmQLLZZZV3y
         5u+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3sGzT41o8mwFY9uzE/e95L8NHoVMA60yxrWpx+nQm7lY3ZWC5tJPHwgCD6mr/9mK3zPy15xg1DXkjc9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNzH6DXeZtV5Lg2NScio3tmo5ukGTB9vj4NFfT27kZ4JZrFOc
	dFVM5L0orgeU9s/hBmyYDYVFKTqMOlfCdknnOJS39p3SmFK0P1EVHdN3geSiU5Iqzdu3UAHKdF9
	X6bFdUTqGhkd4XTwRVw6ffJTkfDx2cGkf0ESBLGzTQ4VkES8YuwOYvGU3BcxpG8S/BI1Uzi646r
	rN/DOjs6QEDBWrTWo6jT8oHadSSZKELaXuYBgziI36i3CGRtnJUw==
X-Gm-Gg: ASbGncvymE8Pq2+z6qqB2d0CgCdG9uJvVlNz6yFKcZVCGfvrweR8nf/mAoU4lMgmiQ3
	YZ436itUunRhcT/TB18JlsH86b3H/V7Z4rIsMwzjsC0hVqsxmtkKx02ZJWKliJ+zzXWrp9PRYI4
	Km21cJaGadaHWsmDmzI0+J0PLPb4t45az5/DHDjmFT0sysDUVcbK6cqQu+6M/tnjXIH1254fPcq
	7z0R6AlhBxLua17loiMZIL4ELoMPn+iYi0ayrJUhwUCVYRwlbiISPwwr1tzbDQmN33XUxGa5LLm
	wKf4AqR5ZD6mhyW5xVqzN+cXjFzkCcLtwZlowXy5eMxyQyDpLKBQmOZbZKevRMt7Z7STtRC/rV/
	+Ahk5cN/rmpM5WdWlv0lqrq0hGtIPwwhbX+fdUZED222SmK/7iKP5VH+ldi/H
X-Received: by 2002:a05:6000:40ca:b0:427:a3d:71ff with SMTP id ffacd0b85a97d-4270a3d7470mr8519409f8f.58.1761033511123;
        Tue, 21 Oct 2025 00:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCwIT++Gjy8YaInsSTn0foSDjK81YGWL3IdFs0wngfxFg9r/8F2CY+eiU9q0Dc2DGG9DULRA==
X-Received: by 2002:a05:6000:40ca:b0:427:a3d:71ff with SMTP id ffacd0b85a97d-4270a3d7470mr8519384f8f.58.1761033510693;
        Tue, 21 Oct 2025 00:58:30 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm19554247f8f.28.2025.10.21.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 00:58:30 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aditya Gollamudi <adigollamudi@gmail.com>, mingo@redhat.com
Cc: adigollamudi@gmail.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/sched: removed unused *cpumask ptr in
 kernel/sched/sched.h
In-Reply-To: <20251020221728.177983-1-adigollamudi@gmail.com>
References: <20251020220601.176639-1-adigollamudi@gmail.com>
 <20251020221728.177983-1-adigollamudi@gmail.com>
Date: Tue, 21 Oct 2025 09:58:29 +0200
Message-ID: <xhsmho6q0lm8q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/10/25 15:17, Aditya Gollamudi wrote:
> From: Adi Gollamudi <adigollamudi@gmail.com>
>
> v2: fix formatting and style errors found by checkpatch.pl. no actual functional changes
>
> v1: remove use of cpumask ptr initialized at the top of the mm_cid_get() function to nothing.
> remove initialization of cpumask ptr in the same function, "cpumask = mm_cidmask(mm);" because
> it is not used later.
>

Please see Documentation/process/submitting-patches; the version changelogs
don't belong in the patch body but should rather be put after the '---'
marker line.


