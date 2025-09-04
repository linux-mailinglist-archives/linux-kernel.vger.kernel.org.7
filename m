Return-Path: <linux-kernel+bounces-800341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2861B43680
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34FB161ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9EB2DD60E;
	Thu,  4 Sep 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="k50We7Xu"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A892D63E4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976549; cv=none; b=MbBKm/QMiZJ+nDGb65PffHpa8TQnCOMvCtSiWzY5mK17K/qgsLXoXM+E+aKVRqzHjLSbWkhf605s7iNmKX5IlJizS1JW4TJGBRSOF5wAMHGcp3Gud649mRu/95u9wylvUHRFUEoTbcOey4ldsEWGl8CIhadPxcY4n3RE/WMOjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976549; c=relaxed/simple;
	bh=t3pzkYuGU2tYuRTyuDW5/Wc33zKbBI7wfB66Rtab/NE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3sRMjfkF+W9xp5WCFinuS4jv+UDZl4WZ4IQR67TFKybTvaGnAZNUp40Gw4yrthuUV9SGQkykGs/+yABVVvaQgF2Ia8cjB1gcC62s8mFxK/hfsaR2GWSmz0WjI/ASFR5Qe8r/vSkvx9RLZ4Z5hAGHv5WgXYlYyA6q8nRzhtjFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=k50We7Xu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 357373F6B2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1756976545;
	bh=W5tXZLE9U8ZLxM4XnYQFYNA7WVcvzE7u2s5SMaMyKfs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=k50We7Xuom84tD6AoaIJjVxCwfgxmanRSqjOuPwfjO2Bkl7XVE/01msqMhSGhepN6
	 ot1uE5UWvoe+LFkzz0RbggtKVw82o+NnlOfps4EL/loEf4ttglJ0wOWQ2jpCpFkjX7
	 bAYTfdd52yHJdUf8KkxmIzNVN1ulHcOVXlefpUkEI8ex5T+MAWpHkBcURVZmSxSbGd
	 ORUHbHnehYG2lZ9Ke4cK7HDoJ4S3pQHdKjayN/oFGAW4QMbvGLVM8y2uo9eefYGkqh
	 C30jjKMHFrlQg7H0MUxveRoyfrI8pzx/uaRwoOChZSv4ron7SLCoCUOOFKa0TcVQ+7
	 fHxy7S0KY11tA==
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-52e090c943cso210838137.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976544; x=1757581344;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5tXZLE9U8ZLxM4XnYQFYNA7WVcvzE7u2s5SMaMyKfs=;
        b=VU0UeR+WjWgVCSZec222IKW2398Ab1XbCvw2l5usCHUPvRNMr87n7eiqcSKYQZpKeh
         ZXIs7ug+Rev9BBukT5rJH97jk3vERFgKHwD6m3nV14FOoU901TXg3Hd4sKjIdfxBFCbi
         nDfPmJJxX6EjdSchlMV5hsqL6pxxLEQuM2gaJplzty9ZEbacn8yq4zB+i3lDELt8gcsf
         u0vmQLm4uoCX8gsVlVE6Fp6gvXGLjcbD3xEMkpK/M8/cItVI3db4c7G752NnVDdo5J+G
         h/MQZjj0h8XqT8nJ4yv+bGcrULTPA37DCNzRvoooyJyz54OdzxlVeJzWR/8gyBE8vi/X
         /Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCXOSkc/Ip8ee7l+RdIss3JcZB1Jmy23yewhAofZ3h8LYXpdY5Ou6Mlclj7xEuSeQXvkov2ZnV6F55ULsPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1P6SIi1oJeXEdH2fKi5k2ADgP340+ezz5JZ1eMQwN5nxXKIY
	bd206iXSn1Aj1iqaUOq+ODKZnTsFXqTtoiVsQKb8IPp5PTyczzKAGQnocpnIaJEqtSXjzyuXLKE
	1ELrq6Dtl4C8tdYmP59ZP4NVGLWiK/OvOMY4+CWdf3NbkIwTcur3YWdWz7N/sAnUzUG9QBWSoQy
	3AAV9i2hCR1cn2tmnldQLqrj6qAXYag8Q5wfb8S7XAbD0tsLXu87yRl/tJ
X-Gm-Gg: ASbGncuI0HOhPF+ngypAKmw8974FpW54ynHHyXHhWBlYPOc9skNbt11vs5Xmfa1zAZG
	rzj1AbMTdiRuSM5Gmlx7sE8yX3clpSkT+S0DcmSTAb4Na+DunPPM+6yqb3E0YUOzop98MniqE/b
	rpxNQ2bNbxO/kBEBjk780=
X-Received: by 2002:a05:6102:549f:b0:51a:4906:f195 with SMTP id ada2fe7eead31-52b1bc21699mr6330767137.29.1756976544059;
        Thu, 04 Sep 2025 02:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfwrOh3ZXQWUEYw7cNtkkSuMIylybKSVsj1rE0ILOBF18eeNxhb8j1NXutX/Bv0RybyaBlTDCviu/T9BrHNss=
X-Received: by 2002:a05:6102:549f:b0:51a:4906:f195 with SMTP id
 ada2fe7eead31-52b1bc21699mr6330758137.29.1756976543690; Thu, 04 Sep 2025
 02:02:23 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Sep 2025 02:02:22 -0700
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Sep 2025 02:02:22 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250823100159.203925-1-e@freeshell.de>
References: <20250823100159.203925-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 4 Sep 2025 02:02:22 -0700
X-Gm-Features: Ac12FXx9BokiA1zWTAcPCh_5RS6LljOLjGyyWFJoP9qUWJdcuwYzY8X--Neq5V0
Message-ID: <CAJM55Z9KJNPOp1ngDqKz0BDpxWu-_cqOMALSE_Jou9FU2TPK9g@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 0/3] riscv: dts: starfive: jh7110: More U-Boot
 downstream changes for JH7110
To: E Shattow <e@freeshell.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>, 
	Minda Chen <minda.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

E Shattow wrote:
> Bring in additional downstream U-Boot boot loader changes for StarFive
> VisionFive2 board target (and related JH7110 common boards). Create a
> basic dt-binding (and not any Linux driver) in support of the
> memory-controller dts node used in mainline U-Boot. Also add
> bootph-pre-ram hinting to jh7110.dtsi needed at SPL boot phase.
>
> Changes since v2:
>
> - patch 1/3 "add StarFive JH7110 SoC DMC": wrap at 80 col, clock-names
>   const is 'pll'.
>
> - patch 2/3 "add memory controller node": memory-controller node follows
>   sorting style by reg address, between watchdog and crypto nodes. Update
>   clock-names to 'pll'.
>
> - patch 3/3 "bootph-pre-ram hinting needed by boot loader": add missing
>   hints for syscrg dependencies 'gmac1_rgmii_rxin', 'gmac1_rmii_refin',
>   and 'pllclk'.
>
> E Shattow (3):
>   dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
>   riscv: dts: starfive: jh7110: add DMC memory controller
>   riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot
>     loader
>
>  .../starfive,jh7110-dmc.yaml                  | 74 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 24 ++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml

Thank you!

For the whole series:

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

