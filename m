Return-Path: <linux-kernel+bounces-889612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FBDC3E0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B389188E7AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6D303C9F;
	Fri,  7 Nov 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtWXk78j"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCC2FC892
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476604; cv=none; b=E1mH0vM5gFLYO32cMnSMZQA8gtLPhpegRteJLz+N1TEhoOlIuVpDGBaMnMbSAjyoYif04Gn2IMGjsEfBOFpehnnNWz3fubxzxrgb8NmsZKS/6ATG6ZQryih+NJyHu0M1NHZcAtZewS5TOn8J7NlGp/cB5fCC+7R1vi8D8RZbX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476604; c=relaxed/simple;
	bh=iMU473kfbxLIfx41vDd7YtatXvonwJ3nvGqIOn/zk5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrkB9pWe5JzgNvNlxJSavLbdwh/WSIowoufCsbyA/FDRZpSjJIv55g3U0AtT8KI80nrQBkATdrRRpb1oXjw+T0Vr70etQ7rkSlaozq0EHjhc6WnnImvKYZsFGxtGGVx9SG3H4ZLM10dUFSuHx83xIKpZObc2njoo6Ho624ivJ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtWXk78j; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b9ef786babcso139952a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=RtWXk78j34yrafHbvKJq76DRJx2KD3ljRmGfybDyf+nVnQLpDf/QfXoN0MEDTd+JMo
         h2AFksiRxOdEIZTL3VpL+fGzwjiCtJAWWjLhEFR3L88neL+bgN/9cYVkCMGmMe8AD7JK
         S+0eg+k6M3LshYM5/m+i5PL1Zo4+XiYE+kiSiyruhmjnhEYiNaK882XAVfX3LG6cpzyA
         gZP3uaRSMs1fV9s6QrGD0byqN+7YKIl8ruouw9CI4eo8CTVSmGcgueaL9Cut6m13ZKC1
         Gynp7APdpH/+ZxqvpPeLoPQWy1+DdcXfqTXj8HiN5mqxPvtPL0XHxfYbLheOvBJs/Mtv
         sr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uegf6nxs6P81Dwl5DQm2UBLSV3f9YHB+8bNv996m32s=;
        b=JsUjWv2+yoa/MHG2U09xvpCHwhH4CPlmnD/MdKcrVsY7s8x0wsnxFchxfXdLV8xKPM
         xGkfnrw7A22a4//PlKBYTzdVVJSZ6P7SgAyFD40/LzWiHhB/xhPFdxpp8WYL/C0FCvwh
         A67zsz/dz8TV0KPxuYkI/3Dc0oIM6xRbQu6R4zIitKraLe+ZO7Ed5kO66iRbwg5aO2gV
         CAWeiMVlAUeFpYpiVtJTou6NSUXQmCwCRp4cwVq93WLn6i3uBPhpuoNudOKx6hhiqqBN
         1fqhgtCawYuFoGrmhlmABtBeQKwDav3Ugh4wPsyJURYLTZSSlsTF/rTdUzPdzyhkw5GN
         Dhrw==
X-Forwarded-Encrypted: i=1; AJvYcCVdq8DkNCItGc9+BykZxTpjx7OJJ0DBcz4bYLG7QL/gmWly4+ddfB8vpt3oKF4BMurEk/SBo3ljda+w/bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFUASDcX7HBpXu6OrhZ9wVlV1BgBwQWWbtRK5CduL8PJvaSaj
	zqkH0fWpnyWt5PYhZQU1ihi/ctVz0Hlvon8LnkeTKF3VXChZHToO2EPS
X-Gm-Gg: ASbGnctiwxrNd4qiz0aPWh22CjJZlTSkC1Mju3PJT9k8yKfhxpMDSMzgWxYHiR8k2le
	o0y2GQwZ2rKom+j/UwC3BCOXoYwZ4dGCUjMfdfE4hG9tooAK6mUNJzNJ+7LqdwJWXf9ndTnHjWb
	6PZzsjqQ5GoTN5kbdQRMxqHjmdjPWQ1yMfAeOKWkRcQdVaR8O1UAefrj3F//fVtMSvZMyOdHbw+
	wrexLL52r5Fr7GqIW7dycRKe6BwnKIghALjrKOEQyoZ0FVpyYbKhfttR7SLoziIpgNRIWPwabRG
	bw82W3peHLLkcEJNmfFbTnY93ZUBEwO4ZwkKMwhQdC8eBGheI4IWmZPvgHypW7143z8/qEs+vV8
	3w5wb/Wl5WVOM9MC2gRIr3jdx2bsPvP7QtFomQrPWNGqIzR9poXd10zaYe+/91owED7J4dxXQ
X-Google-Smtp-Source: AGHT+IEn4ofaJtpDiBFAzxzfLcnblypBsnuT/tfNp8v2pmgiedvOY3KtH3CWotZWmHCTlxnnmEILUA==
X-Received: by 2002:a17:902:ecca:b0:295:a1a5:baee with SMTP id d9443c01a7336-297c03d28dfmr16719935ad.4.1762476602405;
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c778a5sm41166315ad.73.2025.11.06.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:55 -0800
Subject: [PATCH net-next v3 11/11] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-11-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 an SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index cde048bd7fe6..bda1ad173ad1 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3


