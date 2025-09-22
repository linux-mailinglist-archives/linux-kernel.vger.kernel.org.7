Return-Path: <linux-kernel+bounces-827612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD07B92375
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B851603D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F23112DD;
	Mon, 22 Sep 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoPfoQFg"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE02D94B3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558386; cv=none; b=n+njyA6dJNixntffAP83gXPSOfU92cQugRcHMbY4IJdzh+x4GN7O6piaWfxfuJnmJQp+B+n7UeOGaQycdsFRjdCfnL614aEL8Fw8bLVOkmQmhcPEQOSUhnlz17XOF6Jik4mG91JKfD6MRMaj0tLSwDfRnxH85KMhbrc2x9RoJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558386; c=relaxed/simple;
	bh=/xJ274f5aneSc5WlQLY2bHc3cINv3xqFVLL3V+eAL3Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ht4w2smXXpi976f2O1a/81211fN+vrltpHj7SGyXVECXP6ouzmMyi7g22X+ANBrZEAnWjAlc/taPXLeEQY0WW3+D2hollaEAbH4eJfrxa7qOf81hM/xbpmyzCdnD8s2SVRZCSzfLkQ6WfYNpWLi58EJuW2p3Mve3AKtsbtTc+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoPfoQFg; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54bbe260539so372045e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758558383; x=1759163183; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/xJ274f5aneSc5WlQLY2bHc3cINv3xqFVLL3V+eAL3Q=;
        b=EoPfoQFgYniyYx67DzuGbuyG0uqa86z+yQgiQgO8iHALdQvCUgblz7J/byUwDos+2H
         TGA5X0p7YKnnyD7V8/EEWoAOV7B6dR5hQThCF6M2qVKfRrO0a8oXzwkyYHdFIC4g+YAN
         2QAWPmzNA1/a34lGFWDzLtl42Z+fTIBGbw+BXXLDSwk5uaBEiJQe/3j8MwGTfV0VlUkv
         ZeWySi8n1R15+TtQaQT+jSkBYFmCDi+xUk8LSlheGyxWQ+1iNSltV7pJLyN9ymGadCLM
         vVyWJiRuVxzE0NKpP8IZcG1sKSY/nxCrlNiN+/n7o7yC84ssbC9r6QEhuNPjGMGe9uvA
         nFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758558383; x=1759163183;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xJ274f5aneSc5WlQLY2bHc3cINv3xqFVLL3V+eAL3Q=;
        b=ni8+68tMOixkxA0k2hvrsRE5+WVEZeHljIC2WwPAIw6VBt9Ebcavxb/1ol4fXZfEha
         puwjxEUNJUacz46mvjiyUg7AENl1z0FWX+Aitv9teBv+v9W46V+3bCgqEjodX0df+1CZ
         ML455fZKIydl5AE7+SFWY4DGSLFpodi1GV8twnb0FeXwaOtfxmm3MzO/EiodjMs0pvYZ
         lmH0Yux8BCVKHTm24MNCe2xzFa6vYNlecLeBPx7tB/luXa7kE3alx769VCUcxy5Fkb1q
         O4yogZcjCGnW4kyfkHB/BUmz7CnjzIjtkI1AOWLgq9PHbiWAehon1FkHxXETxSfR1zHQ
         uoOg==
X-Gm-Message-State: AOJu0YzfQ05RfnnAHc78DC/hyQlrE9QC0yD5Tosis0oW63IfumkHquLZ
	FXI2T279A8Gd8/EY7iyw5H0wixUCJ5fQ0ArvRJ9sJh/y0p7yW0VwHwbJWy95GnheRHApY8NGgxN
	/gIpK/aKzx8SuTj10Y/K/WSE7MvXtm4reg6ZJ
X-Gm-Gg: ASbGncvxzRMX+EC42O0i+m/eA9c2lG8uJnKd2Ttcr5zrON/vS1V1xbYDdPizHjeTTfE
	CbkR/K4oK8D2R0k1ViLaSl3zrWgFUYL1qw7OQ9WzabaKBIfia15TWQfW0qppdnuf7DAnlAIszJp
	eHYI5zDsgDABKNqLuGh6rRj5I321+NBcrrYZEuRfiDy6OdIwKS4d+ywob4S0wOC5zqsaLU1oF1I
	bnJzWnonLra8u77yPA5JIOAbZaOMXBTV9UsRJfP
X-Google-Smtp-Source: AGHT+IHdkz0tUDw8zR22Ryh6xogoAjoIiil2auBs/HOG4U6NDNkxMujxev/AXW4BRicPKn9zpKd/WzMLFyZYC2OPyqI=
X-Received: by 2002:a05:6122:3187:b0:54a:71f6:900f with SMTP id
 71dfb90a1353d-54a83581f10mr3304214e0c.0.1758558382962; Mon, 22 Sep 2025
 09:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 22 Sep 2025 09:26:11 -0700
X-Gm-Features: AS18NWD2eoCPlcAE5ZCvxHxbb9JtM3JaxRWzodkfDMWSK-UVEhNbi5lZUcWFlpU
Message-ID: <CAM_iQpWph7_w9tve4zci3hdH0oPbe9rdeQbhnv_ZJb=nY9wpfA@mail.gmail.com>
Subject: [ANNOUNCE] New mailing list for multikernel: multikernel@lists.linux.dev
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers,

I'm pleased to announce the creation of a new community mailing list
dedicated to multikernel architecture research, development and
discussion: multikernel@lists.linux.dev

1) Purpose and Scope

This mailing list serves as a neutral, community-driven forum for
discussing multikernel architectures with a specific focus on Linux
implementation. Our goal is to foster collaboration on research,
design, and development of multikernel architecture that can advance
the Linux ecosystem.

Key focus areas include (but not limited to):
Multikernel architecture design and implementation for Linux
Kernel isolation and resource management techniques
Security enhancements via kernel-level isolation
Zero-downtime kernel updates with multikernel

2) Community Guidelines

This is a vendor-neutral community mailing list. We welcome
participation from developers across all organizations, academic
institutions, and independent contributors. The list is not affiliated
with or controlled by any single company or commercial entity.

Discussion scope:
Primary focus: Linux-based multikernel implementations, patches, and research
Secondary: Non-Linux multikernel research for inspiration and
comparative analysis only
Off-topic: Purely theoretical discussions unrelated to Linux
General virtualization topic: Please consider using
virtualization@lists.linux.dev and/or containers@lists.linux.dev.

We encourage technical discussions, patch reviews, research paper
sharing, and collaborative development efforts that advance
multikernel capabilities within the Linux ecosystem.

3) Participation

This mailing list is open to all interested developers, researchers,
and contributors. Please subscribe if you are interested in this
topic.

We look forward to building a collaborative community around
multikernel Linux development and advancing this promising area for
the Linux community.

Best regards,
Cong Wang

