Return-Path: <linux-kernel+bounces-823595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB50B86F12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5ACA4E14D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBFF2F5498;
	Thu, 18 Sep 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjZnR+kJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455E305E2B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228315; cv=none; b=MaKTl/TXdTPS6eJbdEFGDFy8I7fls2LYoH3fa0rd0Efh628FbHJg95nkUqKRvRhd0jNDRj/FF5a5ysyu+ZtAPyeheZvzRzWUyOuUf4IlQQ5MtRfuD+n8FFqBZy9tAnr0pc0W4m/Tq9+pMrCcAlUHSX3cotkbXMYrRxDGRPdkZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228315; c=relaxed/simple;
	bh=GGg6d/r4jDGzehwcYIRRjIy+qluRFFKgKPsa5MqzzFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=al9pi0fpTG3Tef9tRi/2u5Y7Z43OUeMcuMxuJEVcJF2rAQDD8dT/BYjLZaYw5zUp0a2DrF/k1KiAOQZp8ddU30mKAW/ndwakE+clpaJ5ajIOPnqNTdhf2lZ2Xcku1k7X1Ytb28iSgl0wPPT0UXE0EehwR0No4VcXadB1DFhYH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjZnR+kJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77b0a93e067so1339535b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758228313; x=1758833113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OndiLXsBaZlIfnc6wgFkQBsEvn2pe7regfwA2hv/6vI=;
        b=TjZnR+kJHVwb7ZqsIxQ4Fplc2xS75O8S2fvbwi5MYYCasqvOcu2KwaE/LDe02VZbSA
         PMtxNu6Soy+69zZQ0Hj0Qw5i9N16004aAnHZGGRU0Qm+vCiQq5yyVf8ch/WPQQppHB8g
         +xzDvRAibDwvfxrDxVF1a6JL1yTVanROUTJlX8EiKyZ65tdOSa+H/An22mMGahXTMQ+A
         sWfxMODtbJfTfLkKG+Bn+uej8+o+qA0NC3/YYOTf/Ydiz4vSDRN4SOVfU3RPsMOASVmm
         q6RjtAq7fUzANCq0328g1V59/c2JFhZKf353SIevDTut6BD3tWuhBLg7BWTEBEjXe6ME
         a3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228313; x=1758833113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OndiLXsBaZlIfnc6wgFkQBsEvn2pe7regfwA2hv/6vI=;
        b=aFG/6rORSirx41zODKdaxrWAqu1BfsLRc8JFvve7uXk3L2yu96khTl+uMFW1WThuoF
         KWrgcjiRItur04cS5jJZPa7EqJE194DGX1PVwO1wIjuDW8lo9YcFRxTzbN6f7J/38P20
         X697RjG7POgkJPgvwoGniw5D9kn3Ta+h6UaytjW9+2ylzEvGF8meuJ/Sj6ODbyQZ12LR
         SW+AitlL2WXdynuftPkHaENaE1rIlpXj2DSkwGaPCFgpE/h2lw4uBMkjTifptT7bKM+W
         9cwxQUFJGhjosQw2CtrtuDPtH6HExykdpj4roF3fOOv8NlNMHQ3DvACFSS498UTYYlf9
         2MRw==
X-Forwarded-Encrypted: i=1; AJvYcCVDwp/ZeMaapQAQ7Xq2iQ7wxMIiq31oSJD1ZEQalGLWSlDjfFakBU/9LZnBLLJF44R1Fup3awlGxSFSbI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDklgqGMamloiOMFd6tugwvN1JPkef/I5QAbnQYK0gdwS/ZGk9
	VfejPclxHyX1XSmOYauZRg/rhecfoNXEPY16IBf8SVfCGfBNzM7P1Fo5
X-Gm-Gg: ASbGncvUT7NGy0hTKge4tOuUaG5bLltBtEz72tKrav/MXpEnlog/FKEPuFZH9ZoBqT2
	unJ2jrbkuubPv88ah9vO9ZFd0odTOfP+G0+6jpVNG2ePSZswA0kv4jNJY67UqugYs3gLlvjxSLk
	JRZOOXnKsk5EETA9bnEy6TvzWNhf7K792MVnkp8kmUAZ03XKSJQGQOo+NZFE2gfneCaIxeQc3p4
	/AXO95CmgFW+GToIXLjD67si/AVXucNRkXA4Gx6c7HqQWbYvHqx6uhqowna3EoBKX/A4WNTsIf3
	yxHnWyiq4Y+jGQpUi7Q4ccXsr8ooY4XuIE1vqyWb+7UnpvLcrfm0LSe4weC2o9tugNQH21CIjgh
	etJZVlbK1YCcgVbgBLdV1fxgIDKg5ThA02pNS7gbk0cAvr6iNPEE=
X-Google-Smtp-Source: AGHT+IH6nT7K0iPQvyubO2xs7c/GfuU5J21G9ftRRvl+G+ljHMvaAOMJ9VufECcV+u3dMud2d7dvVw==
X-Received: by 2002:a05:6a20:7f9e:b0:245:fdeb:d26b with SMTP id adf61e73a8af0-2925e23aaa3mr1419052637.15.1758228313064;
        Thu, 18 Sep 2025 13:45:13 -0700 (PDT)
Received: from localhost.localdomain ([119.8.44.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35aff2sm3178181a12.1.2025.09.18.13.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:45:12 -0700 (PDT)
From: Han Gao <rabenda.cn@gmail.com>
To: devicetree@vger.kernel.org,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] riscv: dts: thead: add more th1520 isa extension support
Date: Fri, 19 Sep 2025 04:44:46 +0800
Message-ID: <cover.1758228055.git.rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add xtheadvector & ziccrse & zfh for th1520

Updated the commit message for the patchset

Thanks,
Han

---
v1: https://lore.kernel.org/all/20250911184528.1512543-1-rabenda.cn@gmail.com/

Han Gao (3):
  riscv: dts: thead: add xtheadvector to the th1520 devicetree
  riscv: dts: thead: add ziccrse for th1520
  riscv: dts: thead: add zfh for th1520

 arch/riscv/boot/dts/thead/th1520.dtsi | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
2.47.3


