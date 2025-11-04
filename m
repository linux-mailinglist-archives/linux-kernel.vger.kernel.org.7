Return-Path: <linux-kernel+bounces-885546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044BC33476
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40394284AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856AD34A785;
	Tue,  4 Nov 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0ADkr9B"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D257347FD4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295961; cv=none; b=GfoX1iuxr2OtL/zMX0QLcgERZEbH9Rxx7I4u4ehgxID/53OQV3C0i0AnEJha/ItVTJi7+KT7rK00is3yBtNyXjeZ9h2OcjTqO/5rUdVXGv5bQsISrqNhAQxiwAUzSAyiaSl7bBgxjI9yj7cu3sJUPG7AiUGnt2QcincleXnIcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295961; c=relaxed/simple;
	bh=XlP32tEwpZirdMr7sqd9mNrUqkac/qnWShul7Fw9yow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajgtjq1G1Uy2fiAZnPi0LyPS4q4/snGqxs+rm3f+QaXQhIfHkb0Wkzpfsl+KqMgbTxu5Q6DH8yfTiZCuQpRF+Et57u+HXo2Tok7wZb7Kjxp/R52rAbWL0rZ7w9q6XwAPr6PzkQ7/9ZB3EcZ6rN0w8Vk3T2A1fclcoHMKNuTCh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0ADkr9B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-295247a814bso66332715ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295958; x=1762900758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=G0ADkr9B9NpB2Bim0ypTHP3Mt/+mWa4mBYdFMoZrgxG+XmDpZ4hxIQwde8PAioo9vj
         YzWPL8FeNcoFD23u2bvudw/FoErDIYepIqTHQGYgnXvZd+Yy2XdPBl9JEBZIfTzViE7u
         20/XwvC3PtnqWzZhKFLt2QpsT4Jb4Y3y6tg/xeN/sh9XPR0EGPg2RgMab7SaIPSttdMK
         OHNp5LZuPDjU4fHufrYI1mA3kimf8JACMa+ejHdhNWAyPLOc5qHmuCxQLXTZmc3HDy/Q
         94rr1MV5GJxDgVezXdBZUzW7K/V9WZXIe/Ea9FpIsWjpPMfLJFWa+jjjsKWtYd38diIh
         Mxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295958; x=1762900758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=Dj1l//85UzCwFnzf7PCXaTllvewvfEljuwZcb9FrFZEG47UiJW/5rxv3OorjV+fEkk
         pAryBmZ3yiD6e05Ucp6QTVrobU9qoainOhYMAiX8im00FWtqodCs5irG5BPVVqni10S7
         5QVUVS3PVxDqlwwaGUIana1uUswA3sLGANuorFir9svfiVkw9Jp4aab/EXbNj0Rl2UCJ
         bHBf47r22cm6k2ImkGNR4YR77+6/x9cMeV7LGbXS2B3FZe8ALSUavhRt+LxTRfkpJrea
         MGclXsamspslNfc+KZmyeKRrRyl9Np+zr1GPdqr8BnYqogfLJVhp8ceFEfyNzpE+6slT
         lJZw==
X-Forwarded-Encrypted: i=1; AJvYcCUkcid3mQBgHXPqAZ/FitOkZAajtbUX70qWkE8VNDFV4wiWy/m2vJIJzgH7Ef9bVvK2W55YDMSIVUvBRHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2WQBsdD/iaT7Sa/KfnGuGH6okjikm502x05O3wH1vMSdIJw9
	/LBxHgPsW1lUjDzWanVuT0Rc1b0aviOxFi674ZhOAkSmyu+EYx/BH8tm
X-Gm-Gg: ASbGncuOxY3intQIi0R/O/mLIELDvpDx+uMhPYBwCWY41OuugkQ3ZKT4xDQlgMTjk0W
	zkYZ7Cb28Rir26SxfAAsOttKTDXltn/nlcBYG8dQXfy9MLAvf7t5dyr6hIx7twO8I+Bh5jtyjAn
	CavMb4eejZcl9jUho+1um9mHExqxG4WTNmf2dO6e+T/c4VKpJcsDkdZi1z3rzxGzT0yJ177qGSu
	r5i//ZWXoa28LArlIBJxI1fQ0gxeAgOA02pzwXMB5oxLSaCZ2aSR6k+HZcJzK6pre16QC5nPu3o
	H03qli4exBtdp/SqxT9IoHtejkdyY/8WKebb9KqjZPENhQiE6yBtap7WHFZBXajURg84qpuVcWD
	9fqbZz1WLZkiqk4il1GJGtiN/CIVDyLuTOWaj6ihdNm8d1jsQCanW3G398nnD2KJu988W96sF
X-Google-Smtp-Source: AGHT+IGkcKOy3RYFgLwyd/NR+t0Lm3XzaO4mSqwdUYhsWqQ4Xq3qCSzgiAZO/1PlUw5asRlhZe6BpQ==
X-Received: by 2002:a17:902:d488:b0:26d:d860:3dae with SMTP id d9443c01a7336-2962ad83389mr16923805ad.3.1762295958422;
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39341705ad.1.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:00 -0800
Subject: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 3ba9a0dfdd01..0657973b5067 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


