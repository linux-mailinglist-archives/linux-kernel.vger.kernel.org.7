Return-Path: <linux-kernel+bounces-870054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9015BC09CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD433584CE6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83763310636;
	Sat, 25 Oct 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNWs5z91"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804230BF6A
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410450; cv=none; b=RkUD1cHSaD4zjtpLYLpfo7Xj6ftYi+Je1N7gl4/i9REPhBQme+9JLkzpGzhRHrAxCoI7+MXzO7AOXn8O+lK7i+ecfWAfdLuSy5roco61aarXMaMyFg/3NfgtDFMEf6xP5jauY/CBwjsZ124/mQ2V42lL8OMjYic7nk6nOczuMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410450; c=relaxed/simple;
	bh=+heAOJdpmDquFU3lSVmqK3nMR1KJgJ3fOnV2yC6kTTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1NjtyXwBmulEy5QlsoNipFJStMnUCHv3SU++1TYJY1lG7PxcIEPHu3GQ9bBLzgpC7AOaLuRxMMkOgh3qDES2YQcVZVq+jwkhY780S0913TYT8f+Bw3hoB2l9fgO47WqrKAj8s6oaVEmvlMfsHhBgkBPkeAgqtJBraRuQvD3IPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNWs5z91; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-88f2b29b651so335034685a.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410446; x=1762015246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoCiVofkihU7HPUi3IX0CnSOHLAMfManJqPdcZxdW10=;
        b=VNWs5z910prLyyOsXX7ycqBE3nK+WVdVwsIb8ikH924cZMr+047PJleWj7BRPHia8O
         PDg6qYj+XOLDHvgEkEg0TMGkY7kZKrng5hMgo7kmPOfPqvtFK7SDGJR5Fia8uwTtIsSj
         XXasSqftcuwzGCRzNh928GT2EaUv3Ac/31BSDn/ZAWNir32Nul8tuK/JbhisGC4pWkCN
         C9MSWiPPFl48ol9SUHUKtLeQVABf9G1XJLqn1EV7aGw3lxeVOTs1zZgsXyf/8d5pkZnm
         s398CcOm1Wz/Lneq2X+4aR0FJGzU8IeoogX6nRXjTUaVG4SrYSzmnuWBe8y53Hjq/VXD
         yVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410446; x=1762015246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoCiVofkihU7HPUi3IX0CnSOHLAMfManJqPdcZxdW10=;
        b=CTrLRHFheQH8vP6ZeLiFVGCHazbAwsZjMPSileLwD8EQwwG0t9jQFoD1i4LNkfWhUZ
         1MpTGfQhmf+RAFSXpILPfk9ifmfM8OmKGixoy4XeAwOuRK7ds3bgjJ0Ig5ggPzzDwwRe
         hIJz15SA6nKpmTnWjywByRAso7S6abI00TVQ/ni7MvvsOpvM7klX3h2Bxr7IasJt/j7H
         fK0kuL7rX1v9wqYBhIMZJfDtx0qsa3nONL/gqwp3dK435OVpJxWWS36z6fqCCk1R2i2k
         hWvp35RUzOtCUaCrbtT9b7aGsE3WpAc1xyS3fDlcoF4hJs5z78qspJFeKSWZlIyX16uE
         CPaw==
X-Forwarded-Encrypted: i=1; AJvYcCXSoCBZ2m87PVQjcZf25FQLiAhdVjbd8VKZa7+Es1O++zKIq3rvmhVNBxfZROFu4Ix5ha6eCPB+5hvPpK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TeQSjp6O5ViBla4LL2ad3/8t0A8ihifB462bUKddOYnl+00q
	21LQpBLN4bJVY2Gs3wAjAvndJERM5xFH03EvLNHqcRDs8353eYcvrj/k
X-Gm-Gg: ASbGnctfcqmMGn5EFNGhMbKzJSm7K3VpTNAUm9HhDo0XWeXzjUIWRFWKzZKUp1fpJhD
	uPGnq2rpRBXoqzxnAnuH1VTRXCiEKCbB1Srpbs2pBBvvEse2rvRk06aOc1D2rz3RdfkL3WwQYKQ
	2uCJs2vDqj4sj8IFBqZR7ir676Z7aKAGdD/c/s5Zj7TkLFFd2iyqaFWxMN5eSKO/mLh88CgEk4E
	kdO2BpkeqYCRUXoVdHXzbrXh/n6hu9uVGIqTNhfveTgldcPwmNsQX9rFx9ypriPDy35zylDlYEy
	XLdk6UjrYbmge6WmnAiBIxZymCv4SUzNSx9UnynwvzTuGBfko7sblOebSeQNHelXCZbHSnJnXfD
	qJ3KQi/9JgEfJkRRCo70ahbtkTDJU/iU/EHpl3B+fdG1xNculmIWFNnH0KhuDdGIfC3pgr3PQrM
	8IgAhKjnA=
X-Google-Smtp-Source: AGHT+IEzwEpSPArjLqlG0LYeyDVza7kBw4d+eUFvxpdvGPlHshputst68kEyacFkSxRzJzhEcVF1nw==
X-Received: by 2002:a05:620a:44d0:b0:892:7394:e9f9 with SMTP id af79cd13be357-89c0fecd235mr1189899385a.23.1761410446137;
        Sat, 25 Oct 2025 09:40:46 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25c8b849sm173105485a.46.2025.10.25.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:45 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 08/21] mfd: drop local BITS() macro
Date: Sat, 25 Oct 2025 12:40:07 -0400
Message-ID: <20251025164023.308884-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that generic BITS() is introduced, drop the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/mfd/db8500-prcmu-regs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu-regs.h b/drivers/mfd/db8500-prcmu-regs.h
index 25d2d5966211..c2bbf325efb9 100644
--- a/drivers/mfd/db8500-prcmu-regs.h
+++ b/drivers/mfd/db8500-prcmu-regs.h
@@ -12,9 +12,6 @@
 #ifndef __DB8500_PRCMU_REGS_H
 #define __DB8500_PRCMU_REGS_H
 
-#undef BITS
-#define BITS(_start, _end) ((BIT(_end) - BIT(_start)) + BIT(_end))
-
 #define PRCM_ACLK_MGT		(0x004)
 #define PRCM_SVAMMCSPCLK_MGT	(0x008)
 #define PRCM_SIAMMDSPCLK_MGT	(0x00C)
-- 
2.43.0


