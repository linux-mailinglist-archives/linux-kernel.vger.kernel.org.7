Return-Path: <linux-kernel+bounces-892333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D308BC44E10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A028B4E7203
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7C20C00C;
	Mon, 10 Nov 2025 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpTXSRpx"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE388849C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747220; cv=none; b=HkVnTLxyDM2KQIKdI8T1ZS/MkReFgtHCQZSoktbEEDTT5tVWxH0w2WiyoTRytl27recvWCzIbgCN/dCWHH1lPTpvErzxzbPIzGNlrDrpeXbPIKdtdMW0E+At2xy+HJjiEVIpS/cMoRWZP4O0ZzSW/PkpfvgcVTeAlUvicCNQnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747220; c=relaxed/simple;
	bh=MYUt4S+k12lqQeD8erIncNYSK/N6bNXBnqfxnjwY2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQQ8tXZGdKLQk7zNbfrYETQ70a1BLwqYuNBlS0jExlZAD+TmhrMgxc+gLeeW2yra+t/EYvTzKqOom0MSYF1owMWrwoQ5WvnGgnKtiFSxRtcdiRIDzEbo5miZgBdRnAuNDjHYjJ05x0bKJ4e6zwZRGzB0abbkWVyNu8P4QvRSX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpTXSRpx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-793021f348fso1684200b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 20:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762747218; x=1763352018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARePJZFcum0I2UcsNc1I6X6ypbFo44099GunaYErXsE=;
        b=ZpTXSRpxQE+og2yEVM/jSdQGC8tk8Xt1GqIQfhusg+vv3CLYI1KlCO9gF4TRcETw+q
         xiPzlEPRWSDTr9C0w2K3akUZQ4Y1RkmfUzq7rxQlMd5R2Hes3PrZ+PKvVYXde+dnkI4Q
         IH2uoEGaXJuI/HbzkBcxriGAOzUcQ8jnhSbz4VY5rBoA2hm3/dFjaESEZvR4enNVJ8+K
         pOLNG7jyr0FBBa/JH4N4GRimWrLEBv2OqHx6aKD15EL9mHetnHHztOP8qxCQyr0zK3Um
         6avdFrtYc/kFuC24RXTWJcYwbgkoaZQgUNMz0DJAlcn9QU/yhWsVGjtP4gBoYvaKfMYL
         nqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762747218; x=1763352018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARePJZFcum0I2UcsNc1I6X6ypbFo44099GunaYErXsE=;
        b=rbchuN1ukQcbZm7b3odpBl7x2mDoLMVVDVLK+MDTd+ZF4Asr0zkoqnr7hVZ03iz4V8
         cGEeBMywY81xePOx82gn3b0ddP1yzZ3aJkTsUbbp36byv3wGjIEM9acy9E+9tZtMXwMH
         w0dKxd8jDmI+nfT2ue+UwaxnfOq/oXhbq3+DunUdfbF1Ux9dqiZX0eE+BSNKZNEF+26k
         6g3AZvPcyPvxiE/hvgNHLua0VSyLwR/rGc4HrJHJPiAiAMKZ+iSjAkpwTuqj4nzfSi+c
         RPNzVq8C7HppesD1mU9FB+dr7oSjozUqNiQkpcFBN3V/6ymMGfXFhYT4rdOmDd9JHfII
         6aMg==
X-Gm-Message-State: AOJu0YykkuIxZZZ6dV2D0+zbMNSRsUgGpOk269N0A+h7mcH1DTP61HLA
	csNjUweVxhkGGxE5MrkGs5nOfH40NFyp4CCLJ6jVVjXB58wYNBxfFSer
X-Gm-Gg: ASbGnctR3xzEJs17P2LUov62FKS1YS31H3mR6GtaR0SkXjIaMcItdOaA4F6hnHepSzs
	s4H0f70ZYLN1+QZmFZOxsVoPAdb89vOcWMXTPR1vud1FG4UIy7wnFZ/PwIaT/KPhFc9Cisms5cL
	Qs+3EnP27MXupubP681mD/f57vKJpXGF0a5LueXEcVCkV2ditWasD8HPX22KvKZnmzmaOZ9rcyz
	/VL4Rpey4gBzfRaHi/Pn6Y5fKrEyHdUNo7KWxPiP3Meq5kte2C5STapoys23NOn4M/Gtv4WOGT1
	jRz6bGk1wt5GqGtTaq4x6T/kiGAsHn/1p0aws1KtPNJTzOU9QYOzpt+rz/C2pHU7IoahJtbbrz3
	UIf4KPLMi2CN/CaqW+RUiFkvHUDlPbCYlgWb3+YEpf0ar1udPL2J9D1kf9f3CVgAKVnZyDjqgvw
	g4
X-Google-Smtp-Source: AGHT+IG3yPz6YTXE7nA7vJNdAshD2gcVhiabblc07+gqriIOoO3eDQGJ9UaYyrZ7ijemvVvAFWSB9w==
X-Received: by 2002:a05:6a00:2d8b:b0:7ab:2fd6:5d42 with SMTP id d2e1a72fcca58-7b22668fd88mr8043382b3a.16.1762747217714;
        Sun, 09 Nov 2025 20:00:17 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm9978570b3a.20.2025.11.09.20.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 20:00:16 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 10B0B418F1BD; Mon, 10 Nov 2025 11:00:13 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ARM MSM <linux-arm-msm@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
	Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Aswin Venkatesan <aswivenk@qti.qualcomm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] accel/qaic: Separate DBC_STATE_* definition list
Date: Mon, 10 Nov 2025 10:59:52 +0700
Message-ID: <20251110035952.25778-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110035952.25778-2-bagasdotme@gmail.com>
References: <20251110035952.25778-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=bagasdotme@gmail.com; h=from:subject; bh=MYUt4S+k12lqQeD8erIncNYSK/N6bNXBnqfxnjwY2Q4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmCSVlPHn654866fXaGkX/vH67K4Gkd2k9zdJoDwoQT3 p+bFNTTUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIlY5TH8lbIT33DD/n601bro TaYzsh79fvNBrYTVsmn/lBXlDPcCFzD8Fb91IKb6vL9g211jWYVt1/omn5/3nn3rha8PrVLzzCc 3MQMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warnings when merging drm-misc tree:

Documentation/accel/qaic/aic100.rst:502: ERROR: Unexpected indentation. [docutils]
Documentation/accel/qaic/aic100.rst:504: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

Fix these by separating DBC_STATE_* definition list from preceding
paragraph.

Fixes: 9675093acea04c ("accel/qaic: Implement basic SSR handling")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251110132401.200d88bd@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/accel/qaic/aic100.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/accel/qaic/aic100.rst b/Documentation/accel/qaic/aic100.rst
index 3b287c3987d269..41331cf580b118 100644
--- a/Documentation/accel/qaic/aic100.rst
+++ b/Documentation/accel/qaic/aic100.rst
@@ -498,6 +498,7 @@ it desires to recover the workload.
 
 When SSR occurs for a specific NSP, the assigned DBC goes through the
 following state transactions in order:
+
 DBC_STATE_BEFORE_SHUTDOWN
 	Indicates that the affected NSP was found in an unrecoverable error
 	condition.
-- 
An old man doll... just what I always wanted! - Clara


