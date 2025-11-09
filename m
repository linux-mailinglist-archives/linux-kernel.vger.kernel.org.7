Return-Path: <linux-kernel+bounces-891813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C083EC43902
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 07:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E6DB4E28D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 06:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73421ABC1;
	Sun,  9 Nov 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK7TK6ie"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F341494C3
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762668491; cv=none; b=VSaISP5KDHAqRMrw5KJBi68xAdnWInkDTqCMGW78UIKgLa6zPzxSNv9lx64J2f8bo4DzxuczKB0eE0WOphq01nU5Ves/Mn76jQPpQlW/Ko5Q9dyiW8fB9/7ho9Enr6vWbFpAsx2t/BXl3duSZTJ31dpiPkJcaUSltbYa0eSw7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762668491; c=relaxed/simple;
	bh=ZUPe8DA5eBEM0OM6UFFD2uba+Vu1eUEBps3LlQE0kTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nx1SmDUHYSbZbv5SauzhmKJcakCPvF5ySS+RSHIkXxedO5hkYkJAihM2iVJMuyAWJbLdik336VtobJV8Q9WAVxP1kinYTpDEMaFZwVXULTg0jUIJaHueMIK4/fMDhUc2W7c9tVJGHkZ4K1lK7TWUqGaBsPqmaaDL0QNLx/0Fj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK7TK6ie; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e982506fso9274125ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 22:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762668490; x=1763273290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G69bVr1VjY3rXYJFWqH2x9QAFvW62OSXLU6HasiAsNs=;
        b=CK7TK6ieLE/BungZzmtIg10Kl7JHfD97GIAnZXc6U1a1d2s2Bso9SbRpJMAorldvmM
         Vwq/9r2uACDsAvYYXRbeF/JKpZMSiLill01nkpj9qMzs/6KLmmXl2bB9CWS8us/AKMfg
         Wr7Xf9VKZJk3+tFfOVklMp3oSr9Gvph/4lPNGa4r9o7oYibYa4sbeDP7XrFFZGvw8ZQ0
         TZjZd1cSuRrWUfyIaI86S6J013Zg4Qu/+YS8Ocs7j+Rko05RH0snlW30Wrghm4Q0rtAw
         b86audjXEBLuzbwGCO08YWmzVT08btKjQmEnFoPCUPPejq9jzWml34WUsEjKkYjDeB08
         Kquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762668490; x=1763273290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G69bVr1VjY3rXYJFWqH2x9QAFvW62OSXLU6HasiAsNs=;
        b=fI+3yRebwU5f8k++OPbuUHkndqIYcrvSRH07qPdJS2Xiu/tYcyvIgxzqEchafTbDBG
         EILuW0CWeCSpHUbeGQI2eyu3XOGW5pcOZsfDNenXqydBGhQWzFdAKXfxlf71/RPKJ4Yy
         DZVIjxU58sIk7u/S0LXo+jOXncekHUuW5G+j8AsiFpfToTJzE9gO200TkCaFUc/gRC28
         wiqn40iovTdfypZGG3o4jvcGE62f8h7NrUnpfxukPsVnCwnJdyz3xAERWNXEWl1HCFG1
         T6aGyoyBwNoFiHu6qNmOmkJovPFG+4e53bGSkHQh8Ket6LW4BHflf1Q7REHG76MgOyn3
         sklA==
X-Forwarded-Encrypted: i=1; AJvYcCXO6NA5x6+dHWYIo6kHP2xVUqGhZPuLLECqye87+onzqdT1OqfhH9xqBA2mlqOK9aXufviP6LY48ZiDi+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSXRi1klvlh0n6ExCXcyviX37uY2ruzjtpIcUUitsAEP9BC/aO
	eTSRQVm+Rfnio8PRqSwgb7jZg8WCgKTq4BFgyQ0AHlp8rWmMKCS/2Z05
X-Gm-Gg: ASbGncvTNfTtk846T/Ch+zq43Lg3mYYLnyNI/GIuINuncjo5u/ctdBfNm3NXO2d4B8G
	su4hHQCTEHTMO6Xp6bC9Toee68qNzTyVpea8nAY/apAJQV7FDOeFytp1uhFTvVaJOIqUW+XlCJ0
	gs+gRzz4IUKkWYrns+hqZvzJMrR25BYQBg4SGlZBf5JL//D2m4Z0+Rwys3nBfRs4sRbrENs2vlI
	P/smIFbQnz8uGK/rXuVmQ2jKDxZbJib2Y3SoGOSJEddo1hv7TVdAAM8yXcenE2MVyKGTzfV7+Hx
	mZyEU/Ct9TtvAcTz1445YsoAW9ycFwiQWakHgUAitgYfoy6JfolBuUJEKzrQm+6VsbH0LGHZZlq
	VBrEoo96RQMY9Et3plpEkj9pVKEC1wRQw4weFNfTuXPGgR7xzx5W4wkcjedBfmhpkWctYVKHHWk
	xb0zEv2qo=
X-Google-Smtp-Source: AGHT+IFHp7CcRk8EuGvVXBMAKV14iJdboR7Qx/894f3C5vZTBB1ISPfpE7T83gPsFbY8zHpntT65lA==
X-Received: by 2002:a17:902:ce10:b0:295:57f6:76b with SMTP id d9443c01a7336-297e53e7b0bmr65195835ad.7.1762668489563;
        Sat, 08 Nov 2025 22:08:09 -0800 (PST)
Received: from LilGuy ([2409:40c2:1042:913d:b798:80c3:5bd2:24ee])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ba8ffe36bafsm9722322a12.23.2025.11.08.22.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 22:08:09 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	linux-kernel@vger.kernel.org (open list)
Cc: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [RFC] Guidance on contributing to the MM subsystem and finding tasks
Date: Sun,  9 Nov 2025 11:37:38 +0000
Message-ID: <20251109113741.102337-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,
I’ve been following the MM subsystem for a while and have submitted a few
small patches (mostly cleanups and basic fixes).I’d really like to become
more involved and contribute to meaningful memory management work, but I’m
having some trouble figuring out how to identify useful areas to work on.

I have also looked at some TODOs in the mm/ code and submitted a patch for
one of them. I’ve tried looking into syzbot reports as well, but often by
the time I finish understanding the issue, someone else has already sent a
fix. I’d still like to learn from such debugging efforts, but it would be
great to find areas where I can make steady progress and contribute patches
that are actually helpful.

Could someone please share some guidance or suggestions on:
  - How to find open problems or areas that need help in MM?
  - Any advice for someone trying to move from small fixes toward more
    substantial contributions?
  - And if possible, could you suggest a few small or medium tasks that are
    suitable for new contributors to the MM subsystem, the kind of things that
    would be genuinely helpful and likely to be accepted?

I’d really appreciate any pointers or direction.
Thanks for your time and for maintaining this amazing subsystem.

Best regards,
Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

