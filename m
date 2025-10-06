Return-Path: <linux-kernel+bounces-843287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CEBBED79
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61E1934A90B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC32765D2;
	Mon,  6 Oct 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRRQ/Y5C"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBEE21C179
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772834; cv=none; b=YYGB6RIlTWR7pzDqHNyE1P4cSXWFvUcB6eVdIKnfbxcNVC5+ySj6jHqxqm4A4uW8iLUBOmS8y4p7z2Ap1s+I83Ot9dn4ZF588n8mZy5jZwcLwLmwMoACl4EF+i+LPoRLIm7uvQGQZi7Fn/ZJ2FcpxNUoBrTJJz4kbXiV4NQ+a+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772834; c=relaxed/simple;
	bh=RIiagnyRRBU18SYukiZhday7InM2c8S8PNgxP9C7a14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVFNgSz2Nu6ix2tOBGfC5CWYA0IXT5SRxMdSOop+iY0ryhZ7kbJ4v1gIJEaq4vOtVOO0NUHxvUNSkOx0JLV+WhpP43xfuMVjyq2Iq0Uh9d2N0nRd3CmHaZ9emV8IASoHe1B0wIXzBb4WBEHz++mOKFHcH3S3ydkApbztCGVr00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRRQ/Y5C; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7811a02316bso3662249b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772832; x=1760377632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fcadXEt2TbOOW1SS8BtpXmdQoRjzLU/r23ulkh5ITM=;
        b=WRRQ/Y5Ct8gfBjV/hnoxzpj2GEnZo/FVUTmsFHkNE9eJTHiY5FhGEHp9T0E3Hdz/7E
         K+y9t68aylYZ13dVvPmFgHS0lHdQ8qwhJ9ycB82S7LgHChMjLL2T2VxByMiMMuNt7N0V
         k9L2qpHoKziaxBna4PbBB0X+jmoFga+emxiUSb0HTvHwWmjTfkAYt6QU4EXq56sDTlZK
         LmKuww9a1F4UvxF/GTEKygzy91H393Z63RoFaPwn/gM0GNBBjqjBtiiTvoAIZNHYf77S
         CjiQsJPDmKtDdG2nUORnOVVuFf6LX0M6fxiKVUFCopYVJDwnnUfIiZd+lzgDNtQaMWIo
         m8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772832; x=1760377632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fcadXEt2TbOOW1SS8BtpXmdQoRjzLU/r23ulkh5ITM=;
        b=uj+9MaNw2ga+797dU1Bb3wGSNwcKb8+alwFfsjt+CFBeiMIYMxLPRVBTxtM2KEiOI2
         7dRGa5pKSJt2POBJSQpY86gNGMDaMZitagHoM+A61fmXKw19qTHy1anMlhVXEIST9iOS
         seaJeGR9mGBfV5h6JKXJgLmAcORk96HABSw98/1Iktt58rObVwgybO+mLzJwslTAvN82
         2E8g7UErueb3MFowvmYaoJ/vU/cntk8XwCWM48M68hMaLk8BWBM6N5rkee9ApxbDsL0T
         QKKjYFVAltZPhSJExU/qDqy0sK8VR2jm+GjMYjW7pY0TkHHivAs9PmP8xcVfmt6Bcrfz
         2opw==
X-Forwarded-Encrypted: i=1; AJvYcCXY4c2nhOdtjoMBJ0pFEO/GrQ7d4O+6FqI5w7rUR+n7LLRb9V1SQcYYVWQTZGPCKGi5f/sBq/aOF2DPTDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVz+WCKKwKFV1hUz8FOj6ZqHYIBbDjj2A/sd0HLP/mIZervbJ1
	BhHskrLkiD5Dkg52Ef48M521iS/LKFx+IBofKjd2xovZr3/VMYZKTOOp
X-Gm-Gg: ASbGncsTdYrswTyygPmjV41HLJvbNnOh02oYtUx54qSh3cxM9HihwFJiUKzE9PIyFZe
	obWa4ue7qazs2zeouUWqbdfACd2BRH61GELden6X2FzRFKLGNAd0tTVqf42Yc66LR07byJSScec
	lkyw8seGJUZNp1WhJZoYpfJkzSpPGg1XufMwv4Wj7b8om6s2gaNdPdxkFTG/x/ILLcvkvqo/6pp
	mueQGklVXk7tIcIYO2J1zAlxkPyVxZsbmk4is9VepxgRqzBR+jFwN/aBaXY5Ah44ED6hbW0uP5t
	anF+0Z5rFdr7hDgD1Dp5d56YfIWlv9/qba0BiwqUznzlLenolZTETvA94VRlbVNRTZiUkciqkIy
	oTfaDodtSvlxoI/NNW/k+qEPvJZwVgxdPHBJdmZPvZyHfgRmMGTEs1IY8cJDtV4Fl1a/DvyHI+A
	==
X-Google-Smtp-Source: AGHT+IEAZ3GTNkzOlBaQRRxaIIrZTAJwj5D6x0H+u0usVi9mnU3RcuVZuSifIPdG1jRzEv56AOGPGA==
X-Received: by 2002:a05:6a21:9994:b0:2e6:22da:91bf with SMTP id adf61e73a8af0-32b61dff85fmr12599233637.9.1759772831719;
        Mon, 06 Oct 2025 10:47:11 -0700 (PDT)
Received: from kshitij-laptop.. ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e50esm13084516b3a.62.2025.10.06.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:47:11 -0700 (PDT)
From: Kshitij Paranjape <kshitijvparanjape@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Kshitij Paranjape <kshitijvparanjape@gmail.com>,
	stable@vger.kernel.org,
	syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Subject: [PATCH] scsi: fix shift out-of-bounds in sg_build_indirect The num variable is set to 0. The variable num gets its value from scatter_elem_sz.  However the minimum value of scatter_elem_sz is PAGE_SHIFT. So setting num to PAGE_SIZE when num < PAGE_SIZE.
Date: Mon,  6 Oct 2025 23:16:58 +0530
Message-ID: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
Signed-off-by: Kshitij Paranjape <kshitijvparanjape@gmail.com>
---
 drivers/scsi/sg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index effb7e768165..9ae41bb256d7 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1888,6 +1888,7 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * sfp, int buff_size)
 		if (num < PAGE_SIZE) {
 			scatter_elem_sz = PAGE_SIZE;
 			scatter_elem_sz_prev = PAGE_SIZE;
+			num = scatter_elem_sz;
 		} else
 			scatter_elem_sz_prev = num;
 	}
-- 
2.43.0


