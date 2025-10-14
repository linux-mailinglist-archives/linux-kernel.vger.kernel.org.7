Return-Path: <linux-kernel+bounces-853351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C6BDB5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960AC4EB511
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401F730BBBF;
	Tue, 14 Oct 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoCGmm7F"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317DE2D0625
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476048; cv=none; b=bwa6ohQ6AFpoxRiNuwO4c55aJh8Mo+Coxt7/R3YjOYAwzMWK8YtXJqbTKdpOU3kALEw4tNHoL8c9foQQk3ps4DOfI2Ii6d1hEWBupw6Wy7fIofxhBnxZO/AE3Wd2FPEcUUfQi+a9/t+P8UibS7K8T1Aq9u/F0cQkqj9UhFKfMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476048; c=relaxed/simple;
	bh=GNwjrlMf4NgMt1O+flBZOgiRb0audvb5vOfI78Nxxik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rC8+aj3ST3NkcvZnSeDhOpvOPiasd5IXWf/6vrW6ZdjTt9sf1oR94kQe8g87QEFaxJkNNe4mKgbB0VJrsK2LZp0NvpNIuH5TmWlMLL+LotOeoiyee0QssZBBE793fpUoNtcuWWlSZTZe0XPYWSBZpyik+ntEX5pNudCfbAZyW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoCGmm7F; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42f9f5a9992so39008055ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760476045; x=1761080845; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEnJ2EbDgmTA6kuvnOcLzd06zHMf9mvUsxdzD6saYmQ=;
        b=NoCGmm7FrGliYyvM70+m/zelKOfLgfWxAYem9H5deGuCnHHS7XKPqA+j6Qhatwhce7
         krUhJa44QMysoYveygD06MtL/NbZwQYepKNNj18TRmI8zP/W8ppB9IX5jJUxMCjZq4B2
         6E1DpkfVB+W6W4uT17bK5m512EYRstaiYlYPmncSdfZm6TGxQ9d679VQhW4pIXs1JlnF
         LI4990yjH+fKbdm/EvTRzIDycw0oXoGC7It9UwzJ33FR1ccCmhP7uID2Woo9ml0XaLoa
         pD852Eew6UlHgeeMIEyGvNwa0sSoHbnTkz4siHgKynXCCFH7KbaIEva76zMroZnR/lyP
         f3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760476045; x=1761080845;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEnJ2EbDgmTA6kuvnOcLzd06zHMf9mvUsxdzD6saYmQ=;
        b=dO7WpkXRKId1K6l0Bqm/5tqNcka9y/3emAOBeM1OWT/ACQqZBT3rLMIUqEHb7Gx6Vq
         Hmua3eG8DxC/0grp/DcwZbAs08t22/cn30jRlgnxfHs6YS6oFz9lio8zcokYjeM5TGn+
         OK+sqVL8NoCH996fWVzgU+gMUHJxkIzeMSvGiCXXQxRnNvywPYpAjG24kefA4pVn+3ej
         6wqlPdll5pJ0lOHuwMdcmlcxxWZ5/ZqOU5Ghwyc1pd2HpISZStOLH37Rzt5GtlkGosj1
         oEKzg+R3iuqhAZ48LKNRBXqywbQlGaDpf/WoqkP/9NOMnl6qV7GRdEUwsbn2M+p1tsJe
         wwWw==
X-Gm-Message-State: AOJu0Yxp0nfsNbp73dywSOVqdMtDqXg5uvUnTzE7jnEP8FRUFKwgBNwS
	erPRL5pr2FjMmWqCj9pVfE4cFZCVBs81kjBEvS3AXTJzV52+aSmqzLudmN6kOYXt99Qoq+lWSHm
	qXQidtE4pflUoU7ZB2Wr/NGGlNy81kulDrBb3AZQ84g==
X-Gm-Gg: ASbGncsDBu4B5+zV2S1EoYoLGgVcUaHWhOG5ofX335/29HVnxDNlPRL5QQ4zkfCQtYk
	cb699PblX8pTTVSCQAEJMUX9Rt41gXv5sXB1fDcpwJ+xSGrE2AwCL4mzhZjG8a5RLLuJAdxx6FK
	GtFv0dqCI9nbQE+tRP5/s83n6lE7Xy9A5H1w/VEwkvermcrZL+kw3EzaSWmxuQBOsJzQJ9aga2B
	YJIjxKfw6CCirOQgs6vgXSaApQpzTyTmk5W
X-Google-Smtp-Source: AGHT+IEgFuLu9zqN2LYrHGofT4Wf3efzz6Ce3y/VGpCDMAZgTN07xEoX2qzOMw8qrmQOKzYAkkY2sbG7EjEcZtRqc1g=
X-Received: by 2002:a05:6e02:1a88:b0:42d:86cc:1bd2 with SMTP id
 e9e14a558f8ab-42f87410bd5mr285250055ab.32.1760476045278; Tue, 14 Oct 2025
 14:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Tue, 14 Oct 2025 23:07:14 +0200
X-Gm-Features: AS18NWD5H9hq0FhmQy7Up5AJ6dLTrgCkCjjLIlkhXqvyXvYneZiPwNdVTnw2WZo
Message-ID: <CAKSQd8WQDfSax83Fyja0Y_aF-jq+7qfOpDo3GU5bz-8wEVUA1A@mail.gmail.com>
Subject: x86 opcode/CPUID/MSR allocations
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If x86 opcode/CPUID/MSR allocations are not
of your concern, then you can stop reading.

-------------------- 8< -------------------

I was asked to relay this to binutils/LKML.

As of 2025, the following are in active use
by a corporate entity other than Intel/AMD.

Any collisions with them should be avoided.

- opcode 0Eh in PM64 - x86 PUSH CS that got
  removed by x86-64 in 2002; not used since

- opcode 0Fh,36h and opcode 0Fh,3Eh - there
  is a historic collision with Cyrix RDSHR,
  but that is not considered to be an issue

- opcode 0Fh,3Ah,E0h...EFh in classic, VEX,
  EVEX, Map3, and Map7 encodings, without a
  prefix, or CS/SS/DS/ES/FS/GS, LOCK, REPE/
  REPNE, or ASIZE/OSIZE/REX (but not REX2!)
  prefixes - a historic collision with K10M
  VCVTFXPNTPD2DQ (at MVEX opcode E6h prefix
  F2) exists but is not considered an issue

- opcode 0Fh,1Eh,/0 - a "hinting NOP" group

- CPUID range E000_xxxxh - unspecified leaf
  return values at this particular time

- MSR range E000_xxxxh - unspecified values
  after RESET - unchanged values after INIT

I have documented them at www.sandpile.org.

-------------------- 8< -------------------

--
C.

