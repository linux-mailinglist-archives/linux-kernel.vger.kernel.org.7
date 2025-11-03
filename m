Return-Path: <linux-kernel+bounces-883519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5AC2DAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E742A188C5E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD95628FFF6;
	Mon,  3 Nov 2025 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLaFQgOH"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A62877F2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194362; cv=none; b=ffAkdZSDZD8HrtzPOg88AuI5kjas5ToCDMkoxFHmunQuVmCtyoRE3E8vprPstLnPxNu9zihoIVJyxzTxODuxqSorQFsg2Fv0175BBk6jX3SqsS/7lSPVEMPPCQsL9KxZxXRTXNa3cvP7qVwnW7f0WCXEkiVUPvTyI8EGqObwb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194362; c=relaxed/simple;
	bh=m6030Z4iV9Dtls4TJA5XNKTsLfZkDJds3EJDAH+jgdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ic+xxzWG+2ePX+sT8cPTZkUFMKsFqv4O+nC+ewaEiMXs0k87ri3r7IlRMHU7aCwDfmaVaUH4gigDcK9LcJnqYqK8y1+F3FHW9bFKbah6EJyfNM9Efk+me0goh+VETg0qfHzBcrW6TzNU7seaSJBpdeuxNWRQbsYy0nenY81sFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLaFQgOH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aad4823079so1354031b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762194360; x=1762799160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bku0j/4uZiPLjuMlogDephhpXZLra5eLiNfB221gaUg=;
        b=JLaFQgOHLQ7VZGjRb2MfLlM7UZxTxhNjBhA8yasw6VX8UenicCT6s1rISsBN/rdiqe
         s9zuP02c/wGhrjlIzn411ysdG03Knxlt7HVHzoeZOYM2A4vgQLBE4ocSYeE8y+GrWKyd
         MqKtAgl5Di2XKWOF2lQb7C0Hqma28QPGtFPacv695gO4G2UpBxaJRzPqM5QAxYxmcvku
         LzPsb0J6Pitjem8jT61mkdxiAtOa4dVc9FwklMCadRFbHCVKjjDvN5BZa07c4ZZlsgfg
         +XPBL4606lKV46ixgAOr1Iypx6X7DevrVrG+JBYHaIgKG2de7qpPonAeLswjYEVcUK90
         DmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194360; x=1762799160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bku0j/4uZiPLjuMlogDephhpXZLra5eLiNfB221gaUg=;
        b=FX3RL1oNrIpii+6woaFe4cVTQNmgoYSvGW5aMBIEyK1DXWvlhXDs3lyNEEWDRmN3Ip
         inmAfJG2XcT5A0XdsHwwdq8YGWV6/xb94AGmSW8SmhGOb6Awqp8LST4JIcKvepFFCdFW
         SZW/2OAuo+VSELeIWdb7iXDDuk0bAfs6SNjWNNTHI93mjSWeQhiTqxWWWTw4CNLrbMll
         kLMLFu5B0ba3uvTaxfvUcylylGUwdOpM8O7HTApOb5QNr6c4ZeqGUTmlP63j13gbHpm0
         b4Tlhn+hp6LizlDfzn+VSlmccpVHyVMnkJ4vzkEqNpXl+Rsq9NK8hbCWX6foRzFtZUqM
         ODfg==
X-Forwarded-Encrypted: i=1; AJvYcCUdu9+7LRQkPBf04gr6FUVJe2UJVyJRh2tXXhIXrXPEFi/hTKpDOZ3Wthk/KKYvpOXIt4UhseqHLDrKROQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1tZfs8fD5VPIVR2VU5IHajRjAVqBBo63CbuXEx951fIVhclD
	LQStMU2yCoPGtWab+427DLgmGSo8ILuKgH5/b1kNC4mzInRJU2l1BTfi
X-Gm-Gg: ASbGnctXUD6nuzkXsW6d/s3uNs10d4wpRWJ1KLKUR3flDTDXKFP5KRGqqAyARMtPSBw
	uvNMrE4SkeNv4ywHV0iS6aJtR3DnLD/YKpNE0QQcV8DtUzKpTguxn21BSMA9Rz9jP3+NFlEuxjA
	ZOKYU0pqE4V5vZspR/XGkKWNhOAQUzm7roOb4U4fI02hvC1MyxlbbzrpHOiIuJpOy0XylKXvVnU
	YOqr6UEhY17ZKq+fH58D8CRla93X80ZtW5DMc/WHe0mx99U96GqO28qf6GUXd/eSHcaVbDJ4i/D
	U5jHEcYx0JG/AG2yGd1Ib5sU/vQjhD07ELPSE/K94Owq2rEVPd65rblJzsEURgXg4h8SJ4Q8fTv
	CH2v2wYAz9p9iw7ONvCoC7GIUsgzhV7xv9gkUwpUea48v42gfR8Z59xBk9G5ZUeuMhG1XOKNKzc
	/lTUDXBIjdufj/WQflZ8lUwG4sBvTbi1FGhPiCG25Xvag2ggD57/HVTqAFJyJvWr5zEIQUO4Rv
X-Google-Smtp-Source: AGHT+IG6wo2PxPEUOSmTABG7eXQzl7e3Do7qYLNg+C+fm5dc/1Vxej4dPh7daaYf/VP+OE99bzrkkQ==
X-Received: by 2002:a05:6a21:99a8:b0:33b:5a3f:3cbe with SMTP id adf61e73a8af0-348ccdfc7efmr20830416637.54.1762194359453;
        Mon, 03 Nov 2025 10:25:59 -0800 (PST)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([43.224.129.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf44dc8esm11042975a12.35.2025.11.03.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:25:59 -0800 (PST)
From: Atharv Dubey <atharvd440@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>,
	syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com
Subject: [PATCH] HID: mcp2221: fix slab out-of-bounds in mcp2221_raw_event
Date: Mon,  3 Nov 2025 23:55:44 +0530
Message-ID: <20251103182543.42451-2-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes an out-of-bounds read triggered by malformed HID input reports.

Fixes: 3a8660878839 ("HID: mcp2221: add support for MCP2221 HID adapter")
Reported-by: syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index a9fd7648515d..c97f0acbac8b 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -945,7 +945,7 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 		switch (data[1]) {
 		case MCP2221_SUCCESS:
 			if ((data[mcp->gp_idx] == MCP2221_ALT_F_NOT_GPIOV) ||
-				(mcp->gp_idx > 0 &&data[mcp->gp_idx - 1] == MCP2221_ALT_F_NOT_GPIOV)) {
+				(mcp->gp_idx > 0 && data[mcp->gp_idx - 1] == MCP2221_ALT_F_NOT_GPIOV)) {
 				mcp->status = -ENOENT;
 			} else {
 				mcp->status = 0;
-- 
2.43.0


