Return-Path: <linux-kernel+bounces-892181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E4C44909
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB7B3ACDAC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA89526B2DA;
	Sun,  9 Nov 2025 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYid74ZB"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6926560D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727208; cv=none; b=ELAfioDu6X6SuyBHXLQhh9N1quT29w4sEAXo1rUEJ7BGFTdVKjsvMk2zx/kTevQ3S5+oyuTUQS/tWZTSgZsHfi0HPZNBjoLeJ0hhxuhNg7LsYS8eEhs6EbCRbi6JZUxNhRdQWGiPsX/bJe+lDKXQzY7ixhLDM8zCMJXwL/aohdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727208; c=relaxed/simple;
	bh=GRwTmWWCgGyzksGBqAM9TXhdQPTGz3CGeiWXTeRupAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZFt1L2+qlCNDoztfZrDax4o6h2q8yo9+rBZ7ATXlZAHAkLmq/XDv/kueUP4M+pMb8lcBokjzEo8/ORAZZboqnkpyoPQS9yphF72LZzw1isliabz+fAKh4TPywhkgOBtl3OspSno2w/EaZlCMfeSD9wXpARvUZf4CExS58y8PTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYid74ZB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so6586475e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762727205; x=1763332005; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l5PWbqtd6bcvUrej8zvNzXepXMjrjn2nyg8Z4cZHFz8=;
        b=pYid74ZBgCb96gjMnKMx9gjrQkwxfIjFBhQAnJ1uwRsFIVxzTcJs6RMXE8UyhUsX+K
         Qbgm2EgF44l3XmiOb0+VrSuTbe2TYCpNg86UI0XYS2EVdzP2HUhDTf+tn3a0upotHu+6
         q+of6IWadR3+mLCeK6I3N1eNiJDphs24EbUuzYCwd5glHljfJ6CsXtn3BCwgnB8kytDc
         YpBgkEQf+/MNn7Y/kfkC6yp0Kco/Cy29qmdzqDELCCloINL95qHXl+7UbcBDYDEyEKQL
         O/NeXi0iEHslZqKWita2Mvzwrz38QrAU+8jRmVf3cjTRiL11h7papm4cDePAPS2byapg
         eygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762727205; x=1763332005;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5PWbqtd6bcvUrej8zvNzXepXMjrjn2nyg8Z4cZHFz8=;
        b=bEIkQp5Oj83gRPFrohoAn6l8U+Orjhtqb6NPxuDrwv4dBjQO03ftCbLkfOkpAcNEYc
         hwgGtYjJ2RqSbk2VlBCHWZzXz56MvOTRb1cZHy+tuSB073XcMp/hanG2Q6ucrcBBTgXG
         Ogq7CY82T8yRsOyFC7RwEvSXJsnddn93XZn8KpOONrkicG7SgNfHkP3Zw/0ISCtIaB2J
         Dj+pxmTzX7nY2WJ3Q54Wb/m4Wt1qgpyDTDTRynTFrUwYYh/DqZawWZsmAw0BTpftgbFV
         xpx8CAyGbdlwbjrvII9tQU+A0DkC0cBQhglDEblt10KZ/UNAsKk9sv+SJNpS1sBKg0lq
         KZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdUoQk1ON4QKOGdWiU1HNj022keTINuiRPqqpjD9F1HHoYsxguapILqeMrmDyKg10CQivYDQ/lvIxu9nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHO5963z9GZ9/N6U+S7clHZ2MHTgrjwJVmt4qQ0JdD6p4kBbt
	OJETYLJoV06qxE9rGTzoche4pZ08PFDG1i55O2L8TtDuxnopG1KAhxYT5QyEim80Hls=
X-Gm-Gg: ASbGncsYqbKadbUul9vhvBZNPr2H5jO6eaWwO+Deo1ZwcXl3Hsnh0FOZW50vz+AM+8L
	z8bQTp4scPdt0VdlLLg+nQJQD3dbAerJILaYAsA8/97yomX1SjNqlSrsVqXh1LIfnCOlRe8Ztjs
	cKaMfoTtmfWfq5rh8otsl0mSUUUxmYKzOj+9WGiwS6gHsTxvOMjp/gbbe5HRLrAgrxpVrquNtH3
	1RkIUkVdotRpEHO26sh8v2age7sKyM9EV048hfaOKKlijQSVLa7b4BCAAnMZdWtR5bylmY2lNDJ
	AnSvPcinNHTZA1BkFC5kncYpYEM5po6yZ3FfH0yZQMkke8yN70OSjDQMW813O5nzLFkGqDU4Nk0
	9ZJhxr1PNrPWm22IM8YSKLE+uFMPl13SUPDxxk5MYE+hbLcDI/30XP5tpuqmok3kjjXmDuv54Ix
	UnV0Dmrx7m
X-Google-Smtp-Source: AGHT+IGnXStHSl2sAW2VSLtoJGzxaRxNy1OwnwV1UuTdC0dx69zTixHcYF+mVfT18Y61FR6Hlsyn+w==
X-Received: by 2002:a05:600c:4e93:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-47773239bf6mr50608715e9.9.1762727204598;
        Sun, 09 Nov 2025 14:26:44 -0800 (PST)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2ee2ed31sm11601155f8f.29.2025.11.09.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 14:26:43 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 10 Nov 2025 00:26:31 +0200
Subject: [PATCH] kbuild: install-extmod-build: Properly fix CC expansion
 when ccache is used
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kbuild-install-extmod-build-fix-cc-expand-third-try-v1-1-5c0ddb1c67a8@linaro.org>
X-B4-Tracking: v=1; b=H4sIABYVEWkC/yWNwQqDMBBEf0X23IUk6KH9ldJDkl3r0jRKEotF/
 HeX9jLwHsPMDpWLcIVbt0Phj1SZs4K9dBAnn5+MQsrgjBusNVd8hVUSoeTafErIW3vPhH85yoY
 xqlt8JmyTFM3yRReDHXoTPYURdHkprNXf6/1xHCdwu8j3hQAAAA==
X-Change-ID: 20251109-kbuild-install-extmod-build-fix-cc-expand-third-try-2cb1540cadbf
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1925; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=GRwTmWWCgGyzksGBqAM9TXhdQPTGz3CGeiWXTeRupAA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpERUceXxIjNVIRpZszMr2rii7nI7/k293C+ehI
 dQ7wgdbSxOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaREVHAAKCRAbX0TJAJUV
 VqtAD/43McfqLq1snZF+fOLJ31wyzswCzkH8xbjHuxY8XQQ35S0qiuN7Y0Q+c28KzzCT1UERXoG
 3PlPAN9MnUqsBhiUoEq7wRo+FaH74I66rwRVJ/xeFFZJQ8SHVo22C1/XXrw4J19faugzX6fTUaA
 hEqbjVhWkIofIjP1yJQyu0KibK+rKaguRt6cvAvrHGlQYDaxQfcJ73V5/m/KSjWYYGqGtnYcdOT
 AZJFzhAtM8Ilk7wEX0OtQEDpY8B69YuOuOQskfXZkitAWvlRSX6oE/6vYG7d2eL4adtz7Ux4oRH
 ZkG9yqRVG8vrKmTbG4DKb0G+FJjiSP7y4U8o117s2Mqd3OLYhWQDI3FaBK3efWYSQpoAiljlCcY
 Z8glNyNxI/jkBXH4AEsRtIozFnKxHB0kVOUJpLQjV54k7JozMdkCiD/+pyezeE3UIekuVxTEOnj
 Z7YmQFDQqixasblBF2VtabIX9x7B61X7lsOytG0yCF1xxFDe0xzpa0yHMD3YGNQoBJ4/HenisZL
 23dWEnoJr1BlY/348RL31hyR22Y6AEa0FJyjJd8rU2Nky3I15+xMfsdarP0d8uCOLoiHSVGfemF
 EhcoBFz/P9iTAQhJymFFV7nCNXXTkAdMN94kpO8MS4saqZGwy+V7n9NWnGcuIQVAG5Rs0s32/+D
 0nREDtZwKxUdXxQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Currently, when cross-compiling and ccache is used, the expanding of CC
turns out to be without any quotes, leading to the following error:

make[4]: *** No rule to make target 'aarch64-linux-gnu-gcc'.  Stop.
make[3]: *** [Makefile:2164: run-command] Error 2

And it makes sense, because after expansion it ends up like this:

make run-command KBUILD_RUN_COMMAND=+$(MAKE) \
HOSTCC=ccache aarch64-linux-gnu-gcc VPATH= srcroot=. $(build)= ...

So add another set of double quotes, this time escaped, to make sure the
aarch64-linux-gnu-gcc isn't expanded to something that looks like an
entirely separate target.

Fixes: 140332b6ed72 ("kbuild: fix linux-headers package build when $(CC) cannot link userspace")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 scripts/package/install-extmod-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
index 054fdf45cc37a8717444b8094daf3e1150a8ccf5..6cce5c41552d520bf069487352fd26417b0b3899 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -63,7 +63,7 @@ if [ "${CC}" != "${HOSTCC}" ]; then
 	# Clear VPATH and srcroot because the source files reside in the output
 	# directory.
 	# shellcheck disable=SC2016 # $(MAKE) and $(build) will be expanded by Make
-	"${MAKE}" run-command KBUILD_RUN_COMMAND='+$(MAKE) HOSTCC='"${CC}"' VPATH= srcroot=. $(build)='"$(realpath --relative-to=. "${destdir}")"/scripts
+	"${MAKE}" run-command KBUILD_RUN_COMMAND='+$(MAKE) HOSTCC='\""${CC}"\"' VPATH= srcroot=. $(build)='"$(realpath --relative-to=. "${destdir}")"/scripts
 
 	rm -f "${destdir}/scripts/Kbuild"
 fi

---
base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
change-id: 20251109-kbuild-install-extmod-build-fix-cc-expand-third-try-2cb1540cadbf

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


