Return-Path: <linux-kernel+bounces-881292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6150C27ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DE4F4E1761
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1F02F5A03;
	Sat,  1 Nov 2025 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmzLBTeX"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9E2874F8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001963; cv=none; b=MfGhZJgGD8JiYbEMoKo8FaXOSEm2d6qRB3O0j/sjyLeiCzTsO8Gj4x/pD4txFkRfReqC7iGJUNZICL4C8iT2wMGloCo0g0WlTajwZ+o673u/qzQ7Qm00oj6AXWgRCyHNTRWDxI284MHQ5BWcHrD1X4od8UyqGFr+jb18kfPhJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001963; c=relaxed/simple;
	bh=q0wnPO6LZkJSYa2KQQEDnYK/8cjLmnoYdIYFwsMDMPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hvLTbEceDI1UhDD42j9olclykBw79l4v0B5/2jYCR55bd1X8NDzHcbHtSdOhWZ5EEd0M9+rduZLyTAmkHVTQ2azdLCJ+tb9b3XGJw+43mv75rJK1oDgHHQaasgLyElBo3FK88m1k9y8V+9LBfki/1v0MiLNsYZGQyXmDJ+mdqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmzLBTeX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98983baeacso68297a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762001961; x=1762606761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q0wnPO6LZkJSYa2KQQEDnYK/8cjLmnoYdIYFwsMDMPU=;
        b=OmzLBTeXxwLFjsX3L6AeIvN+QE5znkQUPjihIezEqdVLQgCOEtnglZ+2nKtxmn8mIF
         z9uXkjed9eo/ktbs4GvDk/2CrNqK6wAXwuUqogRU9tdTrKFrtj2ofXSM/BpvkMYHDwHe
         Wz76n+rmtQIyoUv3q+eRPyBmnrTt4CSN5ECP4QRruz8Drj8DRbC1tiGlU4cUvIjHKV/i
         KFkFbYygeMtKnIuxo0CUA//8y7T9aTcj/BTBu65SHVf2d3bJpuZP+BEmeuT3uumJPY20
         2y8OsQXS52BZY4uvWKJBDE/oX98smps0w5aW0vKIWGJcn1WwQrA5gKfKI/A0plPL6etp
         zZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762001961; x=1762606761;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0wnPO6LZkJSYa2KQQEDnYK/8cjLmnoYdIYFwsMDMPU=;
        b=CySkI8ROHT10Ra/Sk4nZ7z10McUHdMk2ZbXHsGMd2Cdx9aq5TXfAUUOoGbko8MVF2o
         8SXZlahp0bn7gf6WTZJ6SUd3B6R1yPNwfVlMsd1hwVhG+k/2M4ZN0aPdN9gJd9wFUAtV
         exDXvwBInZ93tyWntK1hOE5C/jUOjKZ7DBJhV6KUmuaBGCLnPYNTadCz/TPFVmJ0ZHt4
         HmnGbjO7Bubeq3znYX/EpJSuet0ZOX/v4UBby8p7DiUB3+UCauooPZtPHIpl0VYiwVjh
         zwB26IH7aECPb75yacB/wy0GGcK4JBSqc+tijeIKQHg3iM4IYo2NlMea6AYHmZjfAUfT
         tlrA==
X-Gm-Message-State: AOJu0YxZYuvJFDwBKAyJ5oWsf198SR6sLz32YSCwxj6TJUUDsIu7s85V
	SfpmQCPtSaGyFPJNsAz79aDo5G69LrnVeoKP00+NH05SHv/6EE5Qye9hz2qoxHZuBJLjKMgmMLx
	+n/0Hso2YN6dgXGbfe4oWraVTZILfvN/Zzzq7
X-Gm-Gg: ASbGncsl45/3KPVfGxhAaPSU9vg3qXzS9LhZuM/JX3redFze0ozthDyaqxCzjcZz2pr
	Q1HWgXdwrXtlCLkQdazkSFYbEqVmMbO/0zUeF+46R0vmoiSEPW9/eMdNdEd6GZacGUaylappMZ9
	+JhycDVV8/X75tnHN6sS5g4qW6eyUJfHCIGFxv6Y2Ymdipilqc0j8X/lTwdxKrcdMUNrEKHTt3H
	NHGptfTJfjR8qcucQFzpByuCdgd9FLwpjM+czuhIYpLUO1HC0Q66Wn9jLW6ajNkmOqbQ89Lw6le
	zp4xEVdXj+gMtG7Q6XWaSSFkA31BMZ/ixhmjTGOP
X-Google-Smtp-Source: AGHT+IECTxEDYbXR5/YWjfROEd2DbX82PbnlXyKMNPDssRDbW4sB6vrDAV1stFo8/wkvP21NG8bXG9HbSIJj3s1n0Aw=
X-Received: by 2002:a17:902:ec8f:b0:267:cdb8:c683 with SMTP id
 d9443c01a7336-2951a49dd78mr107251275ad.27.1762001960837; Sat, 01 Nov 2025
 05:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vlad Ilie <vladflorin.ilie@gmail.com>
Date: Sat, 1 Nov 2025 14:59:08 +0200
X-Gm-Features: AWmQ_blh5_uNJsw_pUZvb5z29KWdjETm1QxEUWBYtz0RNt194g1IH59OC6dDVmQ
Message-ID: <CALR5YtV3tiH8azka+d8=QiucMBCUTC5jOguScoioaDZg+-h35Q@mail.gmail.com>
Subject: [QUESTION] EDAC/igen6: Missing PCI ID for Intel "Arrow Lake-S" Host
 Bridge (8086:7d1a)
To: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am running a system with a new Intel "Arrow Lake-S" CPU (Core Ultra
9 285T) on an ASRock IMB-X1317-10G motherboard, which supports In-Band
ECC.

I have confirmed ECC is enabled in the BIOS, and dmidecode reports an
80-bit total width, so the hardware is active.

However, the igen6_edac driver fails to attach, and edac-util reports
"No memory controllers found."

I've diagnosed the issue:

1. My CPU's Host Bridge PCI ID is [8086:7d1a] (from lspci -nn -s 00:00.0).

2. I checked the igen6_edac driver's latest source, and this PCI ID is
missing. The driver has support for "Arrow Lake-UH" (e.g., 7d06) and
even future "Wildcat Lake" CPUs, but not the "Arrow Lake-S" desktop
variant.

Is adding the 8086:7d1a PCI ID for Arrow Lake-S on the roadmap?

Thank you.

