Return-Path: <linux-kernel+bounces-761951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F593B20056
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F93AA5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8A2D94B3;
	Mon, 11 Aug 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afvh1dJD"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CC1F8725;
	Mon, 11 Aug 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897534; cv=none; b=GP36N/5ULns/zVRlsMhJKHwB8+jGVW/ayCNWO14L17lsfTh+qame2LViTaryjdd38irqY6EFNLGMgmhHpMvoO4TjRG1ProlZEArv/oulz5ArYUFObbFKfbnH+Xeh6uPByLULE/ptCysghoABjI4JE8ipgYko34bU0qpwgQ//LhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897534; c=relaxed/simple;
	bh=tbQ6ECzo7yrvKoKhbN3OqhuH+nyjidDfXNeDUmldEos=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z78vJPHF9svfXZFRUWEIjPE6fff0tTPyRAuPkV6PYItbiycYiIIgFR7MRON8tNYI9GFgOfyho8VeJMF+8h4rrTMhhX/SdvkeQT2SbimmkZsPldvUdQSAbZFrhVUTsEn4KUradSLaiA7CRHPwApfsY+6Rbm3LKPmMKfn3W5HDvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afvh1dJD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240763b322fso40968965ad.0;
        Mon, 11 Aug 2025 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754897532; x=1755502332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmAvaOe6j5EmRYWGU1fBubg+Cb6vql9Hba/ceuT9oGM=;
        b=afvh1dJDEyKUDRlqAgMH20HU8TkyEuSkmhIC8iCJihea7iq7mU2jV5G9Qv0hCxBCmO
         gn78kByCSjkOU9ae+3xpf341ZuMsqH56Me+aZYkmGzfj/FhQ/h/7HqQloQemBl9ytsgb
         i+ucWyyCcvpQJrrclib256aqyNmcb6AUUkgTEwYHS2ZOi+uYSdx8M2zUeje5cVmOcxHf
         CaGPHG1GPPg3OB+ZEzS9ns/mVGJogZG5V/R5I0UIjDgDrjzInNK1pPQnwo1V0YxiLHF0
         kWm8v1/HKtc1vP5fmnp0ND+MrcfbLAzakL3I7mZouGUqH6hI4LtunL/sLhUykYgb6Be9
         5lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897532; x=1755502332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmAvaOe6j5EmRYWGU1fBubg+Cb6vql9Hba/ceuT9oGM=;
        b=vs/JUI7692lgK/URQ0kHxCKrEBvxffutuQDQwlcXE1G8NlBZ/1OsxPz6VOG+o3SJox
         Boi3fOy3//xMaWjBauNiQbGo6JhK8EJsHChfTKwmcOqxCfMhUuzjmIAFjVOavG32/3cz
         KQFZnmLUGo2QIpXH5MHnkTEDA5KNWm2m+6Q4JRKYTEdsOmCdQ16kWxaYZzQF+Vi2jkyJ
         SybKeim7BmOdoTa3UJGP2KlGAAlcfSAnhPpOEEsdraSLYoTWzP0BbCTTc59TKIIIHBRk
         9yD4595YFFI1h9uPhfZzkL1uCmyIl/YQ6EBf/MIi00CxyxYKTB5lHR1/xF1g97LnoByA
         CJjA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGmT4qs/cNE5IMtS0WOWKQxxxryZ6GfPZ8RoO3utuj3Nt07c96tXWlolTHdStyrHylUIB+Q1/fjZVE4f0@vger.kernel.org, AJvYcCXcClJeGetnOkhvE83QsUXhD/1UpjBxQ1neAmNTPfzeE7ykvKzUKyJ0KsEwGxRWc6LVTfRmLLQxIT/6@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHzy/gsI8hJ52f9tBGqXq/oo15gW2tgbonwHftww4wT0ZDUPp
	mr2dIvxANOL/sYuHVapeEy6pc05GOCO205wcmi31MlszToWU4MbC9BJL
X-Gm-Gg: ASbGncv21sA/cPW/vvB33LpkbPNUhdgBDZ+Orh7O8HGST8AybQc0IzyC/Dq46ocWtzs
	aO2OGwDao2NibarV1jwCYY3Yumluj14MuRP6WiiByZTy9e3WyJweQbY37yhbx2TVmv+FBkOyU6n
	hMNS5WhLV1mf1BxBEyX+FN8/x7CFfipSNuXbbhUuEUIhfbw9RrXqiikcTJIj60AeqA4XqyEmQcb
	QnZ1At8GBmHS9ZRM6FxbEQhJLaJMVWDiDdJTORqlDHU3a+s9kv/X6b/HlznDLrkJ9Ow4L+rLU4l
	qY06tAcBUmslfW24US9d6QGjcPfA8NUm5ljeh2OBzO53rt31UW9ROKaOtIRZftUOxX5FK4GDC/e
	xrOs/Lwdqgk+CbsL1jzyp/33vnLHM4MolYnRhjHpyGt/8ES13oa1tD+mvSI+vZVj8ULt2mbw5Fr
	5ouG7gfIKuP5tk4UhnX2ION7zoDsMh
X-Google-Smtp-Source: AGHT+IFXbN/ROk/rj/EE6wkBjU2Pa6lHobrT5on+fm9tiIBjWD7PK7FkSOu7E5PIF5JTYu2m2sIOTg==
X-Received: by 2002:a17:902:f78e:b0:240:1831:eede with SMTP id d9443c01a7336-242c21e043dmr224354695ad.32.1754897532487;
        Mon, 11 Aug 2025 00:32:12 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e388-d3b1-e90a-ba63-d547-4584.emome-ip6.hinet.net. [2001:b400:e388:d3b1:e90a:ba63:d547:4584])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm267624575ad.7.2025.08.11.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:32:12 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Mon, 11 Aug 2025 15:32:05 +0800
Message-ID: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

commit-id: 2236141ed3d6f31f53147c26208dafef6051ae43

v1
  - Patch 0001 - add power monitor support
  - Patch 0002 - revise gpio name

Peter Yin (2):
  ARM: dts: aspeed: harma: add power monitor support
  ARM: dts: aspeed: harma: revise gpio name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.25.1


