Return-Path: <linux-kernel+bounces-873318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F105C13A76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2D15E220E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F902D7D42;
	Tue, 28 Oct 2025 08:55:22 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E0201278
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641721; cv=none; b=lGWVkxgYpPzjfV2+gP+bRqKFgsPcLM79FdaiyqOjPagcTERxkxO5Yg/1RjSXLRQQvaVpIFGb4Dy5WPnRncYBU6+U2fI9VlerG3RvAhwnKh60vgJRyuOfkp7DdT227sMnLxFsWterqX0tsvfSVnRE86sZWAEKD1nG0ZHFz+E8TYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641721; c=relaxed/simple;
	bh=1jyWSd8rThlMmAxW26mizdIiW7Y8wEdGgOKDeOYErtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElEx8XFT7rvaW6VVwrac5yblurh3zSted4HBr4rMJGmY40tEh5o4uN0E6NfPEnWv8s8GIN+lq6gAaf5U6HQnjSHhzjx/Lb1ayyqXtJ6MFd7oEeNWfbi0EOsUbRivvYGimXGuTnDfnZRZjbaz2edrx9TbZLJ0zeiZQCrW16uPwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b27b50090so1008955266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761641717; x=1762246517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgSr1Sq3rmkvSifWsaqV5UJXWYKlFIY0mGeJWjM3fUg=;
        b=W+SOfbSBMYuT+Y9K7eBZravAHvr/4QB5P11GX6kpFL0rtY0ARHCEh/FIv0ioR7aFkQ
         B+z3MEDgoWqgnUq9IS8bFjda65J+A5Cw1xiGZKv69dpRTPDSbOPVs7/xVGet5liMm7iJ
         C8d5k6gQ8LHTSIEzsaXghfiQvfZpX7659+1DV4gKYNCuivSs4v/ul27otYXf7qE3ZVWT
         YuqwK28prE9PWA7EOiz7w2I5lwIeUpRs00IlNJkZhP8/UsDrtDDczydhF21nLA9C8hx9
         kcHiS0gQ4hlE/L2E7xenTtmo3b1/+vs14dNzPCfntA9VxwSBOmaJKRtLa3PsLYzNK5qP
         7zbg==
X-Forwarded-Encrypted: i=1; AJvYcCVrkDDwMCdtzpTp9iEtjj+qzChhIGC0LE9A7fPIUnAHofKuyivY6Q56otYw0e8wmcFdZabmh8QQeI2zW4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqmpPk1N8FyU2srVml0OKEwWfUrtBjAUIifjmwnY/pVOpGEb+
	L6JVl/p6JUDXY/rWYuZ+H9kMQs/z5rM4QrSIY4zLqc/WhEqAM4uvZaaAFxbepLPpM4s=
X-Gm-Gg: ASbGncv81LGCmHD8eD4KT94g7RJYxusV6xvhwqlWXrQFVpwr1t7ldDOG+GNCtPzhKxV
	nEgqMdI2lL7vCUGd7DYz/roXunP8zzTtQqOEiafoAM+b5gk6VfjMI5qikUQC5msICZV0bD90ASv
	/wKxBGMyf0BesxlgEY0UeFCxxTmXDpFe3NnvTUstnw+DpyPH1zTDrBmpmo9UpJL2O2IudVbDfoB
	7oCCy9ihDeGdURnMLXfQjjOblS0vU0KrWFPrs1kA0bL6USvu5bP7JuJdiA3PRMxYQs+pq7ez0iE
	cSVvJnYDVoKwFcNqk05HAjoJG+he5AIZMpFfbFMsbsAPRSoWX7tKG8QVdxTqMieZ7J4KX34UJA6
	/7gRqa7OQ2V7r+Y+WYZAJGOG9RX1hEbPEg6aVQgr3sCz/WNNNyUjj7IRQ+tjc4ZSeVSCLXQGsCS
	CGZ6WcvyuJIO9gMRWqeu2WniLERt6GCJq5n27cbw==
X-Google-Smtp-Source: AGHT+IHe3hED+inHDsB4TouUzsjkbdJdDMwRjSTV9ZLj00jrc3hLfbEr5NdMxWUEC0xzOftJin6NkA==
X-Received: by 2002:a17:906:c143:b0:b3d:30d8:b897 with SMTP id a640c23a62f3a-b6dba4852fbmr319493366b.14.1761641716588;
        Tue, 28 Oct 2025 01:55:16 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8530905dsm1028671966b.6.2025.10.28.01.55.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 01:55:15 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso992889366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:55:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFZvvhphpO8Up6FV/E/A3HBjHltvj3AJQtGhOfqLpMoOPPteDvsNaDuzSvCHKyE5ONKETKhrRlCOpj4sQ=@vger.kernel.org
X-Received: by 2002:a17:906:ee89:b0:b6d:7b77:ff33 with SMTP id
 a640c23a62f3a-b6dba4871fbmr312874166b.19.1761641715408; Tue, 28 Oct 2025
 01:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com>
In-Reply-To: <20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Oct 2025 09:55:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=zEi4XjG2Qrvj=jCa9LPBRU7HBTwEQVbe0zoz5mV_XA@mail.gmail.com>
X-Gm-Features: AWmQ_bkdfJ6sxxwu_pnYfZtG1vuGmDjY7HjwwEBTeHE2OWnxEnhaAiEho61lejE
Message-ID: <CAMuHMdW=zEi4XjG2Qrvj=jCa9LPBRU7HBTwEQVbe0zoz5mV_XA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/display: bridge_connector: get/put the stored bridges
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Luca,

On Sun, 28 Sept 2025 at 16:25, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> drm_bridge_connector_init() takes eight pointers to various bridges, some
> of which can be identical, and stores them in pointers inside struct
> drm_bridge_connector. Get a reference to each of the taken bridges and put
> it on cleanup.
>
> This is tricky because the pointers are currently stored directly in the
> drm_bridge_connector in the loop, but there is no nice and clean way to put
> those pointers on error return paths. To overcome this, store all pointers
> in temporary local variables with a cleanup action, and only on success
> copy them into struct drm_bridge_connector (getting another ref while
> copying).
>
> Additionally four of these pointers (edid, hpd, detect and modes) can be
> written in multiple loop iterations, in order to eventually store the last
> matching bridge. However, when one of those pointers is overwritten, we
> need to put the reference that we got during the previous assignment. Add a
> drm_bridge_put() before writing them to handle this.
>
> Finally, there is also a function-local panel_bridge pointer taken inside
> the loop and used after the loop. Use a cleanup action as well to ensure it
> is put on return.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks for your patch, which is now commit 2be300f9a0b6f6b0
("drm/display: bridge_connector: get/put the stored bridges")
in drm-misc/drm-misc-next.

FTR, this causes the following crash on Koelsch (R-Car M2-W):

    Unable to handle kernel NULL pointer dereference at virtual
address 00000050 when read
    [00000050] *pgd=00000000
    Internal error: Oops: 5 [#1] SMP ARM
    CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted
6.17.0-rc6-shmobile-01124-g2be300f9a0b6 #2283 NONE
    Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
    Workqueue: events_unbound deferred_probe_work_func
    PC is at drm_bridge_connector_hdmi_cec_init+0x8/0x24
    LR is at drmm_connector_hdmi_cec_register+0x104/0x1a8
    pc : [<c0507240>]    lr : [<c051460c>]    psr: 60000013
    sp : f0849c50  ip : 00000000  fp : 00000008
    r10: c1f865c8  r9 : c1f84820  r8 : c1d32ecc
    r7 : c1e4a980  r6 : c1f94000  r5 : c1d32840  r4 : c0a97930
    r3 : c0507238  r2 : c151e040  r1 : c1d32840  r0 : 00000000
    Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
    Control: 10c5387d  Table: 4000406a  DAC: 00000051
    Register r0 information: NULL pointer
    Register r1 information: slab kmalloc-2k start c1d32800 pointer
offset 64 size 2048
    Register r2 information: slab task_struct start c151e040 pointer
offset 0 size 2240
    Register r3 information: non-slab/vmalloc memory
    Register r4 information: non-slab/vmalloc memory
    Register r5 information: slab kmalloc-2k start c1d32800 pointer
offset 64 size 2048
    Register r6 information: slab kmalloc-1k start c1f94000 pointer
offset 0 size 1024
    Register r7 information: slab kmalloc-64 start c1e4a980 pointer
offset 0 size 64
    Register r8 information: slab kmalloc-2k start c1d32800 pointer
offset 1740 size 2048
    Register r9 information: slab kmalloc-1k start c1f84800 pointer
offset 32 size 1024
    Register r10 information: slab kmalloc-1k start c1f86400 pointer
offset 456 size 1024
    Register r11 information: non-paged memory
    Register r12 information: NULL pointer
    Process kworker/u8:0 (pid: 12, stack limit = 0x(ptrval))
    Stack: (0xf0849c50 to 0xf084a000)
    9c40:                                     00000003 00000011
00000001 00000000
    9c60: 00000049 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    9c80: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 a8bfa8e4
    9ca0: c1d32840 c1d32840 c1f865c8 c1f865c8 00000000 c1d32840
00000000 c0507ba0
    9cc0: c1f84820 00000011 00000001 00000002 00000001 00000008
c04fba80 c204800c
    9ce0: 00000dc0 00000000 c1f865c8 c1f865c8 c1f865c8 00000000
c1f865c8 c1f865c8
    9d00: 00000000 c1f865c8 00000000 a8bfa8e4 c1e42a00 00000000
00000000 c2048000
    9d20: c1f865c8 c1e42a00 c204800c c0c66958 ef7f7b44 c0517ab4
00000000 00000000
    9d40: c2048000 00000000 00000000 c204b000 ef7f0794 00000000
00000000 c0518ab8
    9d60: 00000000 00000000 01ffffff 00000000 c204800c ef7f0214
f0f40000 c204f000
    9d80: 00000000 00000000 ef7f0794 c2081f80 c0c7a60d c052d728
c1588c10 a0000013
    9da0: c2081fc0 c052d780 f0f40000 c2081fc0 00040000 c1588c10
f0f40000 c03f57f4
    9dc0: c0c4fe58 feb00000 c1588c10 c16683c0 00000000 a8bfa8e4
00000000 00000000
    9de0: c2048000 c204800c c1588c00 00000000 c1588c10 00000000
c0fe8e30 c0517818
    9e00: c1588c10 c0fe8670 c0fe8670 00000000 00000005 c140ed0d
61c88647 c052c148
    9e20: 00000000 c1588c10 c0fe8670 c052a118 c1588c10 c0fe8670
f0849ecc c1588c10
    9e40: 00000005 c052a3e8 c0fe8670 c1588c10 c10773d0 c10773d8
f0849ecc c1588c10
    9e60: 00000005 61c88647 c0fe8e30 c052a490 00000001 c0fe8670
f0849ecc c1588c10
    9e80: c102fc00 c052a568 00000000 c14ac400 f0849ecc c052a510
c102fc00 c05287fc
    9ea0: c140ed0d c14ac46c c1594db8 a8bfa8e4 c1588c10 c1588c10
c14ac400 00000001
    9ec0: c1588c54 c0529f80 c1588c10 c1588c10 00000001 a8bfa8e4
c14ac400 c1588c10
    9ee0: c14ac400 c1588c10 00000000 c05290f4 c1588c10 c0fe8e10
c0fe8e68 00000000
    9f00: c102fc00 c0529b3c c1496180 c140ed00 c1406600 c0fe8e2c
c102fc00 c01414ac
    9f20: 00000002 a8bfa8e4 c151e040 c151e040 c1406620 c1406600
c140665c c1496180
    9f40: c1406620 c1406600 c140665c c151e040 c14961ac c1030120
c0f03d00 c014173c
    9f60: 00000000 c151e040 c1496400 c1494140 00000001 00000000
c01415cc c1496180
    9f80: 00000000 c01498cc c1494140 a8bfa8e4 c1494140 c014976c
00000000 00000000
    9fa0: 00000000 00000000 00000000 c010014c 00000000 00000000
00000000 00000000
    9fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
00000000 00000000
    Call trace:
     drm_bridge_connector_hdmi_cec_init from
drmm_connector_hdmi_cec_register+0x104/0x1a8
     drmm_connector_hdmi_cec_register from drm_bridge_connector_init+0x4d8/0x5e8
     drm_bridge_connector_init from rcar_du_encoder_init+0x1e4/0x240
     rcar_du_encoder_init from rcar_du_modeset_init+0x4f0/0x640
     rcar_du_modeset_init from rcar_du_probe+0xe0/0x164
     rcar_du_probe from platform_probe+0x58/0x90
     platform_probe from really_probe+0x128/0x28c
     really_probe from __driver_probe_device+0x16c/0x18c
     __driver_probe_device from driver_probe_device+0x3c/0xbc
     driver_probe_device from __device_attach_driver+0x58/0xbc
     __device_attach_driver from bus_for_each_drv+0xc0/0xd4
     bus_for_each_drv from __device_attach+0xec/0x154
     __device_attach from bus_probe_device+0x2c/0x84
     bus_probe_device from deferred_probe_work_func+0x80/0x98
     deferred_probe_work_func from process_scheduled_works+0x1bc/0x2dc
     process_scheduled_works from worker_thread+0x170/0x208
     worker_thread from kthread+0x160/0x1fc
     kthread from ret_from_fork+0x14/0x28
    Exception stack(0xf0849fb0 to 0xf0849ff8)
    9fa0:                                     00000000 00000000
00000000 00000000
    9fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
    Code: e49de004 e12fff1c e1a01000 e59006c8 (e5903050)
    ---[ end trace 0000000000000000 ]---

Applying "[PATCH v2 0/3] drm/display: bridge_connector: get/put the
stored bridges: fix NULL pointer regression"[1] fixes the issue.

[1] https://lore.kernel.org/20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

