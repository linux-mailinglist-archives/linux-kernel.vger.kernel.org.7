Return-Path: <linux-kernel+bounces-643732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A9AB30FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6BF7A7602
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8911DE3A0;
	Mon, 12 May 2025 08:00:46 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAF17A2F6;
	Mon, 12 May 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036846; cv=none; b=QZX4iM9ZO9tvrO/WkcE52rxVcG++Q652b1PzVZlQd0CkJis1g76zjDqYD5HbQ5Wro8w4hLfzSwWnJYm+UuXEz+GhTugpBocd8GrqNJ7cc3KFGbRsZbNVaXJiLX3fetYuStHU7yPpFJ74w41vnxlkUk/p5sJ5LrKP00a+K/BZWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036846; c=relaxed/simple;
	bh=pcQufa8Z9ivWcNl6MVSc62lz95ids1blC8LigiDle6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQYrnOQOkAA04wkHPt8JuxldUk7H5UZkyJNzifhBKQbLymvf8f9QiNGgjBUzkJtoB2jTqwCTnrno28t/MoESatmd085fWeF/dbMupN5O4wZw7e3EqH8Kg2c/8C+6QBX92hKj3WDJxNtomceIoVa2oD4weas0H+/Fbn8IUSuzKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-52c5cb15931so1826752e0c.0;
        Mon, 12 May 2025 01:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747036842; x=1747641642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2Xr6rU3pyh1doXsCafY9wNh1BG2tohj2YQ2ikWY5u4=;
        b=Qknp8bPotCihWrg7UFqSx5SJiq6KyseyocxgxwfQCmu4KtvO3ToM2MP9ZWwFV5d6Oy
         rEUauMl+NGjFo2lxbCeVjMy0jtX3XzJ6RBOmu0DmwVbeuCfMtNrYQS8FwXhGMSDcwmFH
         NMRigVHMkTsrzd0f4IwwYDkM+nv6xyK7/di+DH3SjqxRb5PXqbwnYwvjnIlf9x/zuRd/
         A0XeRMpi2Y4kfnVzEC47aU7cGtNpf2sMjTMClNLdYPrENcbUQztDiSggYiIfqTHAG5UW
         PcKC9hWDTdKUClbSSdeb/fUBQ0qwSSGCy2RdJ7XnmPCaYIo64wHJxCsWFEcdHxZlW/Vb
         wZLw==
X-Forwarded-Encrypted: i=1; AJvYcCUO+9x5Gkd9FQMyyQdp0JMiMjVvSh+AHr5gkKe4MIl+Hdj3KpefDRWOYM+c6r79+wfobdPRB1qdMwvqkIq8@vger.kernel.org, AJvYcCWbnZOHhKCcHpQygEr6OZf6U9qNTpa6Z1YTrfcegyTNXhaXQAshw5cXo5KSKyGWkFlLI9vDSHtEfKQJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUhsnd+w/ssMmnKSC+73Uz3U2Y8M5R5BnrlpSr1w8ivewQEQR
	nWldwh1eMPGhPTIyZDokHJE5t9vKBrHd14Zx48h1SGIi6ufRlTNDdv/H1m89
X-Gm-Gg: ASbGncthpx204+Lb83fxiRLOktiI5a7ugSVfN80VHI7y6O/GoJKdTU+SFKcJFmx6oz8
	z+B/mnhLo5SnYnHglksowzZ6qjMNPFaC3a+80A0JdfgHVct5E3Bx18GXQgztacWee2P4zqQjjKS
	uaOMoL2ILTWk+TnViqRG586huvdOSVebyk7XWX2SP/+JnhF69Pb2NwocFZ7i8cfm3Vjrlv935Wh
	rOxZNcbcuYFee9V5KxRikpx8TFQajjOO0/rH0U1wHlq5yw+rKp+yQfxeKKl9Tlkw4dnu3mpR2Y+
	EOWzhg816e7fHs6yAltP62MTMH7Du40AsTSVf9KcvSHhJCLp+fuaHSVWRISHU3R6sCUHHVfyrLx
	JJZUFeBXB4JMHihVtyg==
X-Google-Smtp-Source: AGHT+IHaWpRr7+xlO4iksXsndzXXLEvzMWz0Q2Pk5z+h06nTGYyCm0sCGDBj9hhMSaYQlsdhQE/oVg==
X-Received: by 2002:a05:6122:2a8f:b0:52c:4751:cb79 with SMTP id 71dfb90a1353d-52c4751cd0fmr10603961e0c.2.1747036842347;
        Mon, 12 May 2025 01:00:42 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c53863c8fsm5206438e0c.35.2025.05.12.01.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 01:00:42 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-52c82c67992so145539e0c.0;
        Mon, 12 May 2025 01:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeKTm0tcRSDS6A7p7tOwOwFOoymMY2RkTm+UfxeLQH7OiCty1RL7x1WPhtYJM8wWl0k6MaI3xIbowWM0yg@vger.kernel.org, AJvYcCX6ouAVuCBz34al0frJZsvqKiSJzfFnq4dZnFRKCzIEqlRU51O+1dtsMjnFWH24X3ViPeCawZhtdlTh@vger.kernel.org
X-Received: by 2002:a05:6122:2a8f:b0:52c:4751:cb79 with SMTP id
 71dfb90a1353d-52c4751cd0fmr10603959e0c.2.1747036841991; Mon, 12 May 2025
 01:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-sapling-exhale-72815a023ac1@spud>
In-Reply-To: <20250509-sapling-exhale-72815a023ac1@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 May 2025 10:00:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfPdV0_MYCNeWHC7GOcb5b7GybnhzaiYzBV1Es3KuVaA@mail.gmail.com>
X-Gm-Features: AX0GCFu30jU-MXjUmemDPu1vyUre39ZfWfjYVH1FtkL6G9ermaqV-FJxTuk0Re4
Message-ID: <CAMuHMdWfPdV0_MYCNeWHC7GOcb5b7GybnhzaiYzBV1Es3KuVaA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add specific RZ/Five cache compatible
To: Conor Dooley <conor@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Conor,

On Fri, 9 May 2025 at 17:38, Conor Dooley <conor@kernel.org> wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> I opted not to add fixes tags, but I can create them if you (Prabhakar
> or Geert etc) think that I should.

It depends ;-)

Do you see a need for matching on the new compatible value in the
near future?
Is it OK to postpone the DTS patch to v6.17, or do you want to
fast-track it as a fix? I just sent my last normal PR for v6.16 on
Friday, before this series came in.

Thanks!

> Conor Dooley (2):
>   dt-bindings: cache: add specific RZ/Five compatible to ax45mp
>   riscv: dts: renesas: add specific RZ/Five cache compatible

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

