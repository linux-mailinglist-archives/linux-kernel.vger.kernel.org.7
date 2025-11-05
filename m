Return-Path: <linux-kernel+bounces-887006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4D6C37042
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBF31A23133
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E719342145;
	Wed,  5 Nov 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5EYisWQ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61133F8D7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362436; cv=none; b=Vm7VYxc4exLlC7CqiUjdiHiLk/Xqd2qgzt9f/tvC6B0o4VVEImBjjIs7BA3VFd/v2x/WqfPG8p1tdf+8A4vSjBYuj/xYV6PinEKTqpVSec1BoQj4e76dSmYIeYq2LzViGkSM7bIxiFxbBcmL9AvikiIzS0xA97a8xVEyLBH5x+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362436; c=relaxed/simple;
	bh=SHevSYfAflYvIOjcPM2PiuslQ8TTF9Z0OzcTTNZ+A3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6KDlkVwKPKL6UceYb6p7gokRXX80STmDUfal0Ck/PFbfz17uPpExxtRMgaSwRYEerNhhU3MAjbgbao8EVR2Egb8VBjc2fOARsDvP5c+6pZxzuq1IDt58MPtLqugw5x0epeo+KysTt7tewjAO9YcHRPAhUJ2vQXhmS66HiPmpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5EYisWQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c1b68cd3so12071f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362431; x=1762967231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDPGEALHiJj9n97uz8lWTxmttupO8bbW3KYaPlpx77g=;
        b=j5EYisWQ67d8B0KV1KsvwaJB31nZ1jLTUsyxImW0bIJPYe3MySyolb21OLoX1xEuOe
         CtPkFMWxJkrMJ7BsuFsiOE+PgjjZtevIVLveB4isJuuH4lRg+X+LObmAi599rzPiOmZG
         dB4CtPTfTHJvnTZlvJIhqj/Vhac913z32sAuuPd/Uui7VrTzD4FK1/0X21Ty56tykP3y
         vro9TYtvTRr1XTStnqzk3OOtWDf8Rl1IOvwDKXI86nCx+upoyAyzn1uJ/bs7Efl/WHiS
         /WkoxvE9v4hKJHbT3U3mAO6zMMYN/JntUFWWfJo56vSAS5ImjiqElig1FSKmw/mmJwtA
         iMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362432; x=1762967232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDPGEALHiJj9n97uz8lWTxmttupO8bbW3KYaPlpx77g=;
        b=KNS2L5M1PfKSfKZZ75bjmbxyEq7zsOJTx1F4NBQQdc8+upkm4fhN3oziBXvvAUtuWa
         /VBh7aeFtb1jnlTMjaLWXHChgZNxTs5l5Bg9AqrpVvZfcjjEPAMAhTfhlKVaf+CFDoRw
         OiXxw3DWsQdNsb66cNYKBnhGKtRri3OZc+EEl/9CmVaQVO++CyyDM7hfIODv/ijVlmVc
         q68galDFunaloYqK8LJjAwIeGcHdLjKOX74lHqmsWsO1N5R7RY2LGVBl3Z5/dE8EXCrR
         kCrPMxSXsV7QKjA2gLq7ksr70PRq1nbio7Wxho2CcOgrTDtAbN4Q551WXeC3z9OcDRZR
         9nGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeT+9KPnuI3eXuyUUGpIL1tZMYbf5VQfqcBp1gWsjzNwMuYXxAfdsTqHLveYwH/eqz0nqD01kEH5b272U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWr8EkA2+mLDq0nX8e2EYC/wlNXr0u3/bZ6n1/BuPPodtkdDAp
	Ii6QTKlcwBhS1UF6Rri5Kt4f5C2nSX6/jT7o/+2W5Tkr/3pp7CeswpQen/KeSH39Z74=
X-Gm-Gg: ASbGncv0YXySl2q9Q8HLu2yx7HUthlZ7jzgSSeAZ8AdN7dVq69kE6Zdi6f7FICOpP3n
	9J2BQupBgjF1ciwFZqgj6ZFyJxESICPPtrlr/edvZ9c9fo60zp+A4DcE5FmTSTWTZwm6HDnR2Io
	nEzJ3+vL2OSQGuFcDDqxUJN9AscL9884JZ8TMHCPhKKst1PVyp/CeebW2oYRHb30t9mtcT+WOg7
	JHmKkit77q5j88N87/1ddfZazBvwD2+JKrye771NsiG/pl2RXbbbY0eyhSvL0PwHqZdvOMi8UQC
	2SpXlQ67Yrm1CbWtQZR54RFPo67Xv+4ABPvG4frOcMwMjfV/evXBwEd8csax7xoMIN8acMd0i3e
	qJp0jzlt56E8u3ttuC15mZ8dAdIzgalJNNF+JR9hkOsUGZHPv/x/Ev+ndiLhEg3dM9kxc55ckbz
	XUkwc=
X-Google-Smtp-Source: AGHT+IFGFX9DslUYNk9iBEXMdGr7oaOJipOJWDtvY1Tg3EGRYJjFwA8CB5hzyW6XylUnko4CikmxTg==
X-Received: by 2002:a05:6000:2f81:b0:426:f590:3cab with SMTP id ffacd0b85a97d-429e3275af0mr1981253f8f.0.1762362431350;
        Wed, 05 Nov 2025 09:07:11 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9d33sm11871563f8f.36.2025.11.05.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:10 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Nov 2025 09:06:46 -0800
Subject: [PATCH net-next 4/4] netconsole: Increase MAX_USERDATA_ITEMS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-netconsole_dynamic_extradata-v1-4-142890bf4936@meta.com>
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
In-Reply-To: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Increase MAX_USERDATA_ITEMS from 16 to 256 entries now that the userdata
buffer is allocated dynamically.

The previous limit of 16 was necessary because the buffer was statically
allocated for all targets. With dynamic allocation, we can support more
entries without wasting memory on targets that don't use userdata.

This allows users to attach more metadata to their netconsole messages,
which is useful for complex debugging and logging scenarios.

Also update the testcase accordingly.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c                                | 2 +-
 tools/testing/selftests/drivers/net/netcons_overflow.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 8a11b3ca2763..040bae29d485 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_USERDATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		256
 #define MAX_SYSDATA_ITEMS		4
 #define MAX_PRINT_CHUNK			1000
 
diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh
index 29bad56448a2..06089643b771 100755
--- a/tools/testing/selftests/drivers/net/netcons_overflow.sh
+++ b/tools/testing/selftests/drivers/net/netcons_overflow.sh
@@ -15,7 +15,7 @@ SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
 # This is coming from netconsole code. Check for it in drivers/net/netconsole.c
-MAX_USERDATA_ITEMS=16
+MAX_USERDATA_ITEMS=256
 
 # Function to create userdata entries
 function create_userdata_max_entries() {

-- 
2.47.3


