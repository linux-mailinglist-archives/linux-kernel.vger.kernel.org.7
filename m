Return-Path: <linux-kernel+bounces-746050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3FB12269
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2891792CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE42EF65B;
	Fri, 25 Jul 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fN+8J4kw"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8102EE971
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462623; cv=none; b=RHHLSTIQMZQbY5TVGCxbTYzXcVgsXma28vPxdZzRaDqrlqAXZmS7uZxV0/g1deEtk6ShHNHmGF9+3UUsrf8WVEsloNvOf4luJAyWxY+HUZm7FpbQYG1tZDGJvlW5mHHEYi/EPIxCe7FjkalY1TiHix+I4Jvj06WEqu08ozQuKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462623; c=relaxed/simple;
	bh=Iwnstctz0F5k0YYnku+BSS1B0snViT86om+eFqsbKyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rqxBsDTv5U7CWI5MX9L2uYoQpvtjGJrJoSS3dPRt4HV2W0Iu6+I/0LQ26Jozjw7bUfn57HmVAl3+O1FjOosCvcJej2IIkGFAKS3VVq3k2tLgac3wMUhzZG6jCp6Q/Q6CbqKkcaOsIuwkL0tpn5t7/r2kuiDPwGQOQ9zoPAd+gAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fN+8J4kw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b60565d5f4so124001f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753462620; x=1754067420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVUDay0uTh9zSzuZqzWxGRuG4PrvulI7cJpPqBYzRSQ=;
        b=fN+8J4kwi2PhAlXspoYantWxUsOmpGHXkn+eEOyIULYB1nfAUwnnsHLwzt98cb8qzP
         EwbwTd9QktkWjsipyD98u3yV8ZBVXpQYdpTZb4U41OpqE8taMbTLlVjdVaFL6sEdt+oF
         DL96NibIm9ULDBrL0HLdrJn4cnh+zX/j2Yq9XDV/ZW+AQYcV3a86p/SDCkHaHoK8OOz5
         FCHfqHSf4hhd4NvgVyGgOsB9J29l24+sLMUvUYCUWehx7uCJeefwpB5EuwZnrORlSTzN
         0xQcnWf6rtB/DlCzbK5a1xy3QbY0Xosw3Gl8o9hC4qIBUoeiACLUsbDyj1SbfvTnCMvL
         5RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462620; x=1754067420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVUDay0uTh9zSzuZqzWxGRuG4PrvulI7cJpPqBYzRSQ=;
        b=ViqcKWu3DWuIsLlcIbyn91PhIQIALh2QZc1vcbJ2G5ClxEQibjrmF1jLIedSI5jfv8
         n878JxS8SMTn5okkE/RuALqf7hx0X10ARpTvKuUBdRGiaid5puU0ESN29EBuMcIU6Epl
         YhsneAS8byOP7t6YytyGvTtT6CdrG6ZK382hIvQhMY/3cpSZt7Noh07eFoyUHQgncyBu
         QrIdryeiYAmtvVE8QAnhaZwhsUMpZ+NCUdAJ5x/rP62FBtTfxpOb6BRgPGArIKbLy1p0
         VKzr4f3p1w5Q5oaFZwNeccYsRf8in4l5UDP/WsbcUdnJqNjDFBYahnmEV55TkXxGNzUB
         L7qQ==
X-Gm-Message-State: AOJu0YyD/Shqoo5vnLTotqqqOdSjDCfeTO9O3NT6uCJsdHx4N3OqI8sZ
	HpTzlCPGiZgkpD8SJtO7Syhqhv+Ac3J9dBmA52tZXhNPx69unMeMj6wMXnO68LtniP4=
X-Gm-Gg: ASbGncthhYp5y8NSKLbbqaRj9+jct81xrH/HboTJuMQG+XU8FS1QFQk2H63ZW26aR/G
	CKbYesXEieoJoEpmEAOLF7W4jPDvPjcXnydZH/hdQvihb7BhmxC9gzyvTX8KdVyx4ytpyvWnxdJ
	K2pb34TZOrFXBMzylML6ACUlKRjkNa9fems3He4tPGB+fmzpJWx+hhCn3N9PpRtwQYuCZy2L6ae
	zNiZwg8FX0mRuCVvL0yksp52Eh75rrxbPY+Dod92jQ3YZX80YGvTjngS0C+TisI3aE/OsEut/xB
	V+bwiEWeJopODbV5XPu6XTG6goiJ6DvAzkq67az31GQd0yldVR70euy9cOlrFunDQzs4gCVvhkr
	nbbbkrw7yxp4tdk41Lkv3Z9/JHaNZrw==
X-Google-Smtp-Source: AGHT+IG+sm9Xi5oMr3IceoYumTV1fBp9BB60EG/AQKP6WZ2A2EIRgkULY9UUCbn9Ae+S38jYGhjXtA==
X-Received: by 2002:a05:6000:420b:b0:3a3:6a3d:163a with SMTP id ffacd0b85a97d-3b77676359bmr880702f8f.12.1753462619680;
        Fri, 25 Jul 2025 09:56:59 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705bcbb7sm61690015e9.18.2025.07.25.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:56:59 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 0/4] riscv: minor thread_info.cpu improvements
Date: Fri, 25 Jul 2025 18:54:08 +0200
Message-ID: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I noticed that we give thread_info.cpu two different names in the
assembly, load it as a wider type, and store it suboptimally.

v2 is split for easy backporting.

Thanks.

v2:
* transform [v1 2/3] into [v2 1-2/4] to simplify backports [Alex]
* tested and reviewed by Alex
v1: https://lore.kernel.org/lkml/20250722160556.2216925-2-rkrcmar@ventanamicro.com/

Radim Krčmář (4):
  riscv: use lw when reading int cpu in new_vmalloc_check
  riscv: use lw when reading int cpu in asm_per_cpu
  riscv: use TASK_TI_CPU instead of TASK_TI_CPU_NUM
  riscv: pack rv64 thread_info better

 arch/riscv/include/asm/asm.h         | 2 +-
 arch/riscv/include/asm/thread_info.h | 2 +-
 arch/riscv/kernel/asm-offsets.c      | 1 -
 arch/riscv/kernel/entry.S            | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.50.0


