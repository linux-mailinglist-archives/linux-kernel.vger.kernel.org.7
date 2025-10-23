Return-Path: <linux-kernel+bounces-866055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1FABFECB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F09E1A056A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD241C6FE5;
	Thu, 23 Oct 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0kpUtE+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D11D6DB5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181236; cv=none; b=TWX/Rbr12JSqJf/PfiR/K6kxH38ktKlctgqctQ2+6r+tstkDYeYtxclyh5VglHBlbge8yCEt5sHuHhWXnJkq8+b57BD5JaPB+wuG+ctxyTqMrUoL12ko4DR22jhDaiF3vkNBzAh93oVWLrEyJxyuciK70fpa0Fbiu6SAZwv1u0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181236; c=relaxed/simple;
	bh=A7Pia+kzD9m0J27kf4ph64d7fzH2Tfv7wW9zOoywfI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HH5ZDkFgSMBlHA3A8WKs5ATKQ9tjQ0YP/4AOH/LDusaBv3sfXJ7PDcG2nvk7rZEcQhHHHMGg4FpnrHvsK/bsxBCf80bovl58aeg+1l909z/am3p41BhIWSnBGtsvy7jewIY//QeuMC6o+gaibX3WEgUt3D35dknJcqgbnOYdwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0kpUtE+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso232800b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181234; x=1761786034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=R0kpUtE+4xPX+wPqgen1bjgNVxcgtTj69D7Rjudq5oeMR3J07j7dqjIZJ3Q4E6w9X3
         vxgiT9sLvpbMjE9kt0MbO6dhkeaUBZ0cwmExCUMa1Zaeumg6ErwTP/2DwyFNatfWoWNi
         //SOtiIKYI/zFdcxuYzd8f3UTQmpvKeZ8UMPNofw2VxlOxqEOYg91/sxbs4lZJG/H7KT
         0raKiLZmfMmG3ON/ONu8zV9G76Hc7nnVVt2svrQA8tUeTig72vN4OYeu1hk+OBIc/4IV
         SduR9PA0tLVmF0Sq2zLAVJUecLj/UAwTeojbMNKEEMbQQBfEAnwN8Y9kyop0kFHjmUup
         Pc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181234; x=1761786034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=NYGiEFAeKOMQXbXNW779wO5e25UsO6XSDt0R78Tlcr0a+7DkeLysm1TCXURpmehpgp
         5lq+xp0ikMQ5f8bvA8W2hChfNUILKyBqbgJ/+IYIHRWBd7I9fhPlguGYV/a+HKqiWTWQ
         uhclE0eiQH2hjmIqPN2kHaBfj+LdqHaejYrFvQRlvI5u/o/H9jRZe6/iEhrA7XryLLFY
         wNwUFMemlTWtoU3wa1008Mxuh6Iv/smK3TQUhlakh8+WMgmDt2fcmrNA4vbLpFi/g4Ut
         T0H5tpb/eVdaLiKmxeyPiSJJZx/P94MimT5eQr6vRnbs8ZOLi9Mzrngy2HglSfBLHnXP
         42hA==
X-Forwarded-Encrypted: i=1; AJvYcCVKo7JmlyuZW5thyFHPoApB7l2qERiM/WV4Kzq7s99OAhN9rkhM41BPbpg1lKt/mkjw8gz0IUeN0RH5q2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjhj2aR8KZpIvAzjYmY+ok9jiaUVZ8Q94KNlYIxKU5aEXHABuw
	XIZL3vqre0LV3s+WywMdDdMRh4xbGiZcFrvugdKV/Hojku7NDwO4Jkos
X-Gm-Gg: ASbGncvrx2NBDXUkB31MuBaJZHl96qiVtygXiSF9k312yB6MsMfkgyD797w72ULGSpw
	R9q3khRpqal8IckzNG0z88pwh8Q7zdQWJvjxGHpK3sVaTJZ/sa02KAa4Cwc97JVTjdLvcyk6Hl9
	OqL2K12vGp69KHDmam+9t7cZvTsRF3IxzBzm2pbecxV2ZAZKfM8A2xcEHzrW6i+v9PWjZ6qzhZB
	3Z19ptZqJstQrpxZxh/SEoJccWTYvBebO94py2JQGkkI7v30A7PgfUmsI1Km3j3XMV2wMhtyaPH
	n5ejzwdfre/nLVW2vHP85nOlJoZjjV+k6veCHhT9W3W/18ud5Ge78vlWPJYCyMOf7XJAvanz9pe
	zQQLKob2pVtyRvddoitzSvyiiA9crvYv8EuKxDiKlUGoODjrQcwmvdj7UrGZKnaefpuFSzv6rFA
	422NKhgTc=
X-Google-Smtp-Source: AGHT+IF9GCZ5yEahtQVlZaXsqCeQjg9YU+w5E/EIvNEWA8qffUUmtOI33IKw7GAAlLb31mw7tG5+pQ==
X-Received: by 2002:a05:6a20:cd92:b0:334:a916:8b4 with SMTP id adf61e73a8af0-33c5fbaab59mr766832637.8.1761181233861;
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c0e4e6sm362737a12.11.2025.10.22.18.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:13 -0700
Subject: [PATCH net-next 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-9-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a728958c58ee..a312930cb8b7 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -541,6 +541,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


