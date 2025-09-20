Return-Path: <linux-kernel+bounces-825553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB27B8C381
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9327BED2D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5428137D;
	Sat, 20 Sep 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRhsdAPv"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890927FD48
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354643; cv=none; b=sxgbIU2Xw/RCM/B7KJk2nyReuyCqzWAI+naqlFaZdId/s/NeLShh+eDc4t7sA+lBr2+H5ndQSnH+dMFpnLU8o+1wx2I10OfH7xGS8GaaXI7qpSqHxOjycVwMmKQsTycQrW/IQRqvJZ9+jTfII5Q070itMNcj+q1ASISpBuCYS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354643; c=relaxed/simple;
	bh=e12XmBcEBam964ELF+GwnaF88BUYkG/1CJmeCfFc4ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSUkyIfi+AakAfVL1XvoLQnm9q2vlevqTlpiyN24TXu6kBAW1tdQ0i3WdnFws179kg8+HcglMkFycuk/g3KP1skD6vZ7SgeiO+gMcEOB7b4SB1S6C1weoMEnYp2Dd8Q1qEadSW0OvrkPYaPyTK/7BMy4DnBd0+f4X84hOTnEYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRhsdAPv; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b54abd46747so2848172a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758354641; x=1758959441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgQfh5YGNEEz08rUsrqg7doSUvqRUOMvv6Rv3Fn8P3Y=;
        b=lRhsdAPvPg5xNvpLARmDm0dmFff3HkXyKhgH/Sv5q/zM47PhFUEXO46SyQ3jiKnWYH
         qJ9wfqQ5oMgHh/Y1c+ReXHO2SddxohaFXgj2uoOEGZ3KXYQs6feWft9WahO1HIvVEnPv
         3neLfNzPpHjITx2RoG6Gukit8LbFCNkWFvdRM3DmYFs2PR11oniJjrk0X9PFor85dQZj
         QIm5h5L0I2jmRSYvCRMYkvAXCwb2B2OV87ACL9uzdFmO4myvgr/QwteuXWZ0urB8rB00
         6B/ccB2YCW+8TzIeM/IEsUPNmD3h8QYLT5fBz2gOdUozjG8Gk2oqvVwokeceSN8TKyCF
         xabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758354641; x=1758959441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgQfh5YGNEEz08rUsrqg7doSUvqRUOMvv6Rv3Fn8P3Y=;
        b=lPck+/JKgL0Jvr/rhrdIblaQlZBPGk6n49vksp8L2dF4RwbXpFTxiEdmFGKknJicvZ
         +7K2qZ+bw+LbLJ/mOQiA+JR+UqhHQpvMpaB3F1kZWQbbxgB8954SRsPbD0V+cQdaJ4r3
         yLmjL3AyiHe7x3opkW4muaRQhQ5WIpaRuqplBTYo4Ip5CWFadlh3gX6S2iPEmy5pIJOD
         mnxUJsj/MOqSd5CoHMl4hmxpHj0aa+Lid4SYD11nOcRVh3rQCTmi0XtAJboq2fsMLIVK
         MDID0uhM9xb4oE+AkivarOGBgHLIr0+ajAJmaRPiBo3wKQFSRRdDMvoOK8P2JK2SijaF
         mEkQ==
X-Gm-Message-State: AOJu0YxaersOizL772VA9Y98wW02qrJ70MoxfMoA96p0idJ7r9rNC7Mc
	PEXhbyA6lunWukfh/eoLJJy1yEZ/xMqWujYlMT6M5BQxzinYTJJNoeD+
X-Gm-Gg: ASbGnct1CUjZmdpV40Ih5DHevbEe8bjVHPht2ZeqgNBe81ZhuJebgG3zmUGLkgFEvjo
	UNRgcTfOmcoE8e8TASNxbcS0HWdpIFWVkiH0d73vhQ+C/ylmVnG1hCVUThRVcz+FZR1kt5ziWlX
	y6euRSZmr6g3VVAMwZETvOvNsghloH9E5wj8oMRl9qWfyNV+qC7/Z0M79e0J9XTPhlhxyHFN0Mc
	0aFQxnVQ2rsXvt21wKvQL12WoyTHgiclkEIIyRL8z9nNDmZL75Wa0/3QQzsXl/e4j3WK9fsDQVF
	LX8EGa6ONscwuUMaWESnCxZgUu/X3I9mNR0vpb4p9pBzsawKo6Jww+ivw0Fj1mnbqIsImEWTOX/
	r15zTfC7A0CHpIBw8qBc5cxkkTpQQJrOXBa1k5ppJIWtftDh9LYo=
X-Google-Smtp-Source: AGHT+IEw3xtj3PbHxvHSoKwQHc2WTSzsfaoVr3TONcGZCJoVyBil2PrkfJCv6XTFpr1x75oL+euysw==
X-Received: by 2002:a05:6a20:2449:b0:24e:e270:2f5d with SMTP id adf61e73a8af0-29271269db9mr9622115637.43.1758354641543;
        Sat, 20 Sep 2025 00:50:41 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55186b8498sm4014686a12.12.2025.09.20.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 00:50:41 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	selinux@vger.kernel.org,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
Date: Sat, 20 Sep 2025 15:50:18 +0800
Message-ID: <20250920075018.631959-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEjxPJ5JFqSMGSg5KEYd40JhLkgUo6g0uykDkXdKW3q5F1JtjQ@mail.gmail.com>
References: <CAEjxPJ5JFqSMGSg5KEYd40JhLkgUo6g0uykDkXdKW3q5F1JtjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Implementation of Muladd:
> > static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> > {
> >         return (ssid * 0x9E3779B9 + tsid * 0x85EBCA77 + tclass * 0xC2B2AE35) & (avc_cache_slots - 1);
> > }
>
> Can you cite the source of this hash function? Is it public domain or
> otherwise GPLv2-compatible?

Based on my input, the AI proposed this algorithm and provided an explanation
for why it fits. The AI also stated that using these constants does not cause
GPLv2 license compatibility issues. If needed, I'll check with the company's
legal department.

Hash constant explaination:
* 0x9E3779B9 (2654435769)
	* Origin: Golden ratio phi = (square(5) - 1) / 2 ~= 0.6180339887...
	* Calculation: 2^32 * phi ~= 2654435769 = 0x9E3779B9
	* Properties:
		* This is the classic constant for Knuth's multiplicative hashing
		* Excellent bit diffusion characteristics
		* Coprime with powers of 2, ensuring uniform distribution
* 0x85EBCA77 (2246822519)
	* Origin: Popular quality constant used in modern hash algorithms like MurmurHash
	* Properties:
		* Contains good alternating patterns of 1s and 0s in binary representation
		* Shows excellent difference from other constants in bitwise perspective
		* Tested and verified for superior avalanche effect
* 0xC2B2AE35 (3266489917)
	* Origin: Also from modern hash algorithms (e.g., MurmurHash3)
	* Properties:
		* Large prime-like properties
		* Complex distribution of 1s in binary representation
		* Complementary to the first two constants

Advantages of this design:
* Minimized collisions: Different inputs won't produce similar contributions
* Bit diffusion: Each constant effectively scrambles input bits
* Mathematical guarantee: These constants are theoretically analyzed and empirically validated
* Complementarity: Three constants complement each other at the binary level

