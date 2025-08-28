Return-Path: <linux-kernel+bounces-790687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F936B3ABC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5541BA84CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AC62D5C92;
	Thu, 28 Aug 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="JZ1tV+y7"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A22D1F72
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413454; cv=none; b=JcNZUIXpYR2P/ZUZq4eIbLiNb1rw/6Px6Uwd1i+pSYvNAZsKrcP0vxPAU19w2uXfBPcVpBjsGc61VVQJjmXC6P2JK0wgR4Yb+csyz8F8xDdwRZoYPMlf8o8+PCaXHj9XBVgahGldd9zWUHHkXHOyBFocTD+98QOMjLmlleAQKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413454; c=relaxed/simple;
	bh=oRP2p2pJOga67cG+m/f+zcP4uYDeO+yZ3lN6tYQQkXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qiW/MP2FOjr3AF7ff22V5wTlqljxMKmoS0HAz5jOeWjlT66sJMJ/NRVym+L0GWNl+JNUmJycVY1nn+q+X6GY0mGacBIGAJmloZBRm4MzPUy5v8wL3OYhDdzyY5oGI/8/DFCjeQhN1l4WC1iWY+KytL1vEqgcTxrk0mKBf67/JD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=JZ1tV+y7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7f74b42ec59so88998985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756413452; x=1757018252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOMMLFiaOAz+64Gs7xjJhrQIlkJjOe3bWicWl5TD5n4=;
        b=JZ1tV+y70Qm3p4WBFlmpPtH+KuU8qOrr177+Ya29pk+cows2N2wy5S5/QQ4H07hekn
         LykD5oTy8gj9lmX2eDXsS+1QjodO7Yisdpxb8emuJ8I4pklpj6EiPWopE4bS9euYP3Bf
         TxUYXcpTUWN+tF9fs2ebo0BdlQ5+my7mIPU/Jr+/C3hhwH3DPlAzN42anhkRTDb5Xo8b
         C75hAsSSbVF8qYteBr7XbQ2ypV3NcE48QJzpxiKJLOJIevq2fLPd2mjTUyHjxbjSOCrG
         FzrWX2vXXG3no9tOTfTHqN+1RCFTv0BHEXLt1ufDlF7rPa93dSnTqFoucEn4DUbTAjBu
         8Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413452; x=1757018252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOMMLFiaOAz+64Gs7xjJhrQIlkJjOe3bWicWl5TD5n4=;
        b=W/LKtak2g5ZZPuFMizEOOfibkVOxT16KzzpL4O/YtTjhUYAqMQVUwtlN0gYrUhXeOn
         B1YDAjV210+Z+AxsLYTG5G+mYbFDZHtWiFFAqcy2+WIzLIYgdwdytsipT5SRHc0smV0c
         6u0S4bnF9T7tkljvFQxB216E7xnP99KnC64kC5QGDeAXvmRG5Xfh4vRUAivuvBwsQHel
         +8tR9wFsALafTAI8g+QijfEuQAHlhRrLcIrxfjzM95FQuMOFb/89LH5RrgOZvoAYzCZQ
         L2IoJI8sYOh86RzpEJ07Dw/RTGKHMgm2TCGZST1TNKpCCPxjgntTcospw85JhIfC/Vpq
         ak4A==
X-Forwarded-Encrypted: i=1; AJvYcCX0De27kuzi5SH6OpI4RpkOZ/dfAriQTtApP1InTyrKp0NXMwqmmk9R5SAaiyg3Vc2/+zgsKTnrRvSOofs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxys7UGGweg/auOUijeeKH2/IOmGb8pmwFuW8vAE9dQjLI7vQc2
	s6GGnfCH3X68KyUaYs91KKStsOq1oMKD7jKu/G70DdjKZ3d+nth73C1RU5zgAmidAII=
X-Gm-Gg: ASbGncsr3kBTHoat4WXu9ltQSSpwZ7MQeA/4Oeqs9BRuhdGNW2tDwcHYqvjda5PdXs1
	wtdqqxUTz858xZ/BOspY50U6negLwB3rbCxTGIyoEvTUl+LZ54SqBayUL0Yg+PXp0oymGTHIxth
	aYoNIsXR/ngbcgJgKxZfNssSPqpzp8BkxlXUs78HVPcgu2Y+sPg8IGBG/sN0uDw8f9pYj1hUXpl
	dUqGBWU96sXUKeNfx5s/uFGqxm7Pl24APMmSSTAsEztgMePNfTt30XQ3NdhZBRusg22tFBaYwih
	sjafNeqTl88h21k/SD7nIcNl7uJf8HHq7L/oCNKu+vEHZXs80u/LIQqJk/zfTRIB+MA8KTaE2Qg
	5OkeoTv7cuJObsVzykcqvO7G1pwNSRVkAcuYDEQ==
X-Google-Smtp-Source: AGHT+IEuSR941eoZ1jOjsoOEgYz1hR0QFvD7yeN/R81eIk6+aXmjbxztfihWFemM+y/f9Vu5CUyggw==
X-Received: by 2002:a05:620a:1a98:b0:7e9:fdca:1296 with SMTP id af79cd13be357-7ea10f74696mr2973451385a.13.1756413451848;
        Thu, 28 Aug 2025 13:37:31 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc153de18asm45879585a.54.2025.08.28.13.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:37:31 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 3/3] ntfs3: add FS_IOC_SETFSLABEL ioctl
Date: Thu, 28 Aug 2025 16:37:16 -0400
Message-Id: <20250828203716.468564-4-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828203716.468564-1-ethan.ferguson@zetier.com>
References: <20250828203716.468564-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the FS_IOC_SETFSLABEL ioctl.

Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>

---
 fs/ntfs3/file.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 0a1e9f16ffaf..4c90ec2fa2ea 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -57,6 +57,22 @@ static int ntfs_ioctl_get_volume_label(struct ntfs_sb_info *sbi, u8 __user *buf)
 	return 0;
 }
 
+static int ntfs_ioctl_set_volume_label(struct ntfs_sb_info *sbi, u8 __user *buf)
+{
+	u8 user[FSLABEL_MAX] = {0};
+	int len;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(user, buf, FSLABEL_MAX))
+		return -EFAULT;
+
+	len = strnlen(user, FSLABEL_MAX);
+
+	return ntfs_set_label(sbi, user, len);
+}
+
 /*
  * ntfs_ioctl - file_operations::unlocked_ioctl
  */
@@ -74,6 +90,8 @@ long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 		return ntfs_ioctl_fitrim(sbi, arg);
 	case FS_IOC_GETFSLABEL:
 		return ntfs_ioctl_get_volume_label(sbi, (u8 __user *)arg);
+	case FS_IOC_SETFSLABEL:
+		return ntfs_ioctl_set_volume_label(sbi, (u8 __user *)arg);
 	}
 	return -ENOTTY; /* Inappropriate ioctl for device. */
 }
-- 
2.34.1


