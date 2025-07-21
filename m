Return-Path: <linux-kernel+bounces-739501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7695B0C6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB5E3B7875
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AB28D8FF;
	Mon, 21 Jul 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NMzNZr69"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04C8F6C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109669; cv=none; b=JzvDKlJ4mO+N1HAoAFyVIL/2n6macLhW67pn61rIVdC5sldjcnE75dDZSN1ZJKovMEZ/DBPxTAuWpQC60kpdoY0nfdWwqyRxsPmlALeDZFzCR9KtpUObFA/Po8GHJhYx59g13vWtTOstV3rQweijyLvnmoeXGRjmP6IvmFCYMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109669; c=relaxed/simple;
	bh=Ze8xuiEefpzdImAH28VAEtXKHcp/VW4jpYY97oI6KH8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OoR7VnQtw22kTdjJ1B1yPKhWEcnbEZReDVncpbPW5W7r1Yp5jhxI6zPGDZktQ7VRbyfz6o6oPhaVvItvGwCCOLyAnIVYg1MSaAirdDWW0kLLd7R+QGOSmztYavKm9iPzKfMNrNt48TQJff5v2vSbsql+aG/kbGRElnf1G8IchU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NMzNZr69; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4562421501fso795825e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753109666; x=1753714466; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPgUDPT1QtTlhrXqgycplGAAUMCbMxWO7skkaLEHnJ4=;
        b=NMzNZr69ukZHkhA4COE51DIo8RICLYz2XOHGgjpNmjX/Y/Q+hYnHrnpEAeDbeaNWcc
         UowSWLkXtuOZejKJ6gWxCaY2NvP1LNyihiiVAx0+H3nOV4i8d9hqTq5lyw+EDRZOPzNM
         wVxqO0fCUA0/YGdcJ3cadmwzeQGmGV7LWBeU8GFNer0F7LPJWxWVYqdy+1WP9DjY/cyN
         tiZN/kYC+X5MwJgr5XdJ8IPDnxis+Vj39or4rGZ14I9jb1kc+aeUCp0HIMsTq4mP7u96
         NkaVgSSPtzWjV0AyIu0+dalzl776gfFjSv7T/44y1RJoAQ9sDlq5EfCU9z14HGJvvf3R
         DRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109666; x=1753714466;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OPgUDPT1QtTlhrXqgycplGAAUMCbMxWO7skkaLEHnJ4=;
        b=EpahrY0ybv1utTx764xBC5G7b/IrRmpHH7Afs/QnAq0Mid5Mzp0pMtxK5V6XaaN+bP
         oXsDEp29VHHtMBPKL0y1/Fb8jj/CoMAU0E/SIt6GBVT7oHQfieo9OcRlm/jc5Wt+j9z/
         /BMyeJYrekvaQ/LB/G3wSH06TvcmABPMApQIMCe+aFjn/LutmKDNT0hqlzZd71/1fWVW
         Hb7T1OI0nTUdL0UstvbVY8HucNr8wXVDa+qV79XdLMTkhTY4bq9eowO+GmdkZhzhuz/s
         QeExibyJ0v5r0jZLvx5yj5wC516SbpNXhh7TBoi3Yc0fmQ7gyiyVRj9cO0B6q+DRuSFY
         vO6g==
X-Forwarded-Encrypted: i=1; AJvYcCVsf52nUFKvRslpK+nCIi5dzq/RIjsiTAT43JUWnrSVjGucIhT8j7mUy44enZ5V81E63qmzQyteHwBLACY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziLv1XMGDYyG3obO5TWRFbz8S1mJ5N2TOcS/veKSuV+o2Zja61
	kzrEvhblBlrWKwxSGdI/Ag8IryWh2PyhA61Tn4A/zdTZrXGrZD7nyC28Vf80lCfh3XQ=
X-Gm-Gg: ASbGncs3ML82qxW0MlzpHrr6aNPW2f5r+X+D0OeIsitnLjnKyLfV0OL0cuM1iQQGlsj
	pL6t8/Q0Lvqex2/+ZVCqRvx4Mez3V+Fm3ep6ZyUvywA79oSplSACra+YWm4K4i4YkXg+HJ8Qw+i
	hta8e0wrIn8MuNacdCKBsHfG0ahT/FUbztJjeyf9+BSxLUGcXjlGzlUPVOuvVeAurMemVMATbXl
	gg/5OsTsRoz2nA+Qf/fyXR3ROSsyABHN813L8Pe1EqMeagsU/nGPdp6321YulQjecrFk1xWCJkW
	wqqdLZLCbpSF0dz4911+LqKECLvvbEPEW/0XEKTTakJMss56zOpuMdp4eHVrIZBkZw5oc+FWVOa
	ROAD8y6Zwyy6Vhf4+LChOB15+WGM8kw==
X-Google-Smtp-Source: AGHT+IFB4AvyvQNHh9zFnz+txnd7YiW5vkLPTVzzu8Lge3qC27BCgs7ueXBXbFWRBZzVsv1n9pCaCg==
X-Received: by 2002:a05:600c:1c21:b0:43e:94fa:4aef with SMTP id 5b1f17b1804b1-4563b422b13mr48484025e9.8.1753109666105;
        Mon, 21 Jul 2025 07:54:26 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:25d5:2321:c8db:1609])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca5c8c9sm10755685f8f.85.2025.07.21.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 16:54:25 +0200
Message-Id: <DBHTIDY0HRM0.2B8L1WG7IBCXM@ventanamicro.com>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Cc: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: "Drew Fustini" <fustini@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@rivosinc.com>, "Alexandre Ghiti" <alex@ghiti.fr>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Samuel Holland" <samuel.holland@sifive.com>,
 "Drew Fustini" <dfustini@tenstorrent.com>, "Andy Chiu"
 <andybnac@gmail.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <DBHQK4W9CL9F.1WM8JFVDQZ44F@ventanamicro.com>
In-Reply-To: <DBHQK4W9CL9F.1WM8JFVDQZ44F@ventanamicro.com>

2025-07-21T14:35:38+02:00, Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicr=
o.com>:
> Shouldn't the RISC-V Linux syscall ABI be defined somewhere?

To clarify this point.  My issue is with the following part in
Documentation/arch/riscv/vector.rst:

>>  As indicated by version 1.0 of the V extension [1], vector registers ar=
e
>>  clobbered by system calls.
>>  [...]
>>  1: https://github.com/riscv/riscv-v-spec/blob/master/calling-convention=
.adoc

The ISA does not say that vector registers are clobbered by system
calls.  All the ISA says is:

  "This Appendix is only a placeholder to help explain the conventions
   used in the code examples, and is not considered frozen or
   part of the ratification process.  The official RISC-V psABI document
   is being expanded to specify the vector calling conventions."

while the RISC-V psABI says:

  "The calling convention for system calls does not fall within the
   scope of this document. Please refer to the documentation of the
   RISC-V execution environment interface (e.g OS kernel ABI, SBI)."

We made a circular dependency, misinterpreted the ISA, and probably
implemented a suboptimal syscall ABI -- preserving vector registers
seems strictly better.

> How come we could have broken it with 9657e9b7d253?

We changed the ABI once, so maybe we can change it back?

Thanks.

