Return-Path: <linux-kernel+bounces-744723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F1FB11045
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92611C2558C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7A2EB5D1;
	Thu, 24 Jul 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In5bYl2Y"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA60298249
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377665; cv=none; b=fE2eXhQ8hs4SuYhVxq7EMG2COitT2CPMmu2zFTln6PRVSVm8302umleMxNM7+/BqbfFmw0yTEI5eg/1YPBcS1dk2IPIbPSYkruhUo/eQu8QPIgJu8bwqf3Oa50SpAqO87keWGEL/83pn+o8oAEQzyEfpcGUI5dAGmEDEb4LmlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377665; c=relaxed/simple;
	bh=pVkAJTSajXnDUG7O+7Z+hQiUYfhJP1LPABkituOJAkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFXIR41dIjRjgsQcxj70L9rdwnhvivr7/6QSkOqRgDXolB6NNFLhuXn0PLMd/+O7APvYdexK3zaYUVEBFoG0CUJrydQCsu4o9hGLSON77HDqdYg0qXArt65SLYB4lt4i7px43W0CFa8MgP5FQirQN5sBuv86XeUBvHjkNWF+Js8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In5bYl2Y; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so2250405a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753377661; x=1753982461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfkEUR6otL3cOkfwkcTPOtIx+HSipNHwStyAjZrqVxY=;
        b=In5bYl2Y0eqykeUbeU4KpCERZJzGKvyKFdUh+yBfTDZAeu1TP4C58vg7iNCZB0HJJu
         G/mgWYXBQZ2G0xiiuilTbxYUF+I8CktMLKKLTW8/jvZCtEu1dRyWb5OPeM40nmWxPz0M
         Zov65lupFuhUXe4RQvJ/cC5yr6WxTr1CX4pO3tG1iRXQY6uOUJCT4R0YhnvYpKzKwzSq
         aKyUl+9YeU/ArKjHQbTdk79oSj+F/D1xnhPRX60quhzIKXK3U28wufXGy3Icy6lCdSZY
         nhCNFGORUH1refJmvx2xzdvkbrxW+Mnd0KO9rwJYe+EzcKJawueJLaSxcyNxSabr+jw8
         peag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753377661; x=1753982461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfkEUR6otL3cOkfwkcTPOtIx+HSipNHwStyAjZrqVxY=;
        b=t1qZCD+ckrYa/Eh1AipOIvzEFxqN909zuJbCCUHRKL1DfhfEddLK+YZQ4dwXkOiRi0
         MavLFzIMnJaIQ6hkIt5IdOCzZBZoT4oJjaVL/gOszUD4rHflk976EStCDSSUDbbwR2YQ
         yu01YZ7vQbHIMK/1XvVYHFCuACQCH8yvMzsxq95J6CMaMj/xkEznV3uGrbOs9P7eAiyV
         imzIvUm2Q2ly/R9Yjz0wtgDEgOO1jmE77h56y9B4CmvlomNc84l3DmRuo0kjdK2g9ebq
         j1yOIzO5XbqHHymIBQ7rpUfS2zLzuodlZxf2jEA53cdWZHMuCQHoUpJX8HNAV4OQWu37
         Dm/g==
X-Forwarded-Encrypted: i=1; AJvYcCUlgRTUs3aEHlvm7OJOE5pHqs293y/WXCbWW4Rg+ykLOWi9D+t45eWD6NZfChtAnbYxHdvrpcc0FckyVHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAogdBpx1FdPKyTI1KTk51+feZzyRGGSlJ2LsN54RvbcDhr0yK
	tiGObQUXyapGZLn7sCp0cIiVW3aR9Fow131l712IxpUHqbF0mvP5Ja3S
X-Gm-Gg: ASbGncsP+XV7KEyqZCyflF/b5darHujTy4nGJDRWo+mHx+/bOxLi5bN/uY7Dm8ydGYD
	jiut/vhZSHcOwnsxlos6hbSpKD3xUzQmUsimuwy3bVroWrgCaAFnhWR9NW7HrSIg41Clv1H5k+b
	aPnu75+rSS7nLGWT8NapeV5n/HOCnntioTrbRMPy2eOMdKd9X2q+zFrWj6mhiyIMrZNSD5KVqVc
	7pFXM2H/ZamndHKrk2UuDTiTn1i7bnU0qcDCPW8wdLHjh5Hwc79rqfKvAjVJGm/v5b0LVcybhix
	P2iU+APi6pT+351P9FumRH4bLWlcoE1rG9bIWu0iyMbSZo7TnF3xcHZDRhtJ08sfZL11lQSZDcS
	/1vs9falbaeB0PBzrGc8j+1hLIgNnBLlyhE4kKxplzIsxbkTj+c9o2KvIngWAAjK6ouAjzc8=
X-Google-Smtp-Source: AGHT+IGz10/3ENO8yqJCTlC6H05i4FZFHffxVZlAZr0zy+xLaP5u9qfynV3c9/IDIqsw/FTpJYIe3w==
X-Received: by 2002:a17:906:c14e:b0:ae0:635c:a400 with SMTP id a640c23a62f3a-af2f8d4e87bmr742807166b.51.1753377661017;
        Thu, 24 Jul 2025 10:21:01 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42b60sm134341466b.132.2025.07.24.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:21:00 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bqn9090@gmail.com
Subject: [PATCH v2] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Thu, 24 Jul 2025 19:17:14 +0200
Message-ID: <20250724172034.44679-2-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724172034.44679-1-bqn9090@gmail.com>
References: <2025072409-promoter-shame-8105@gregkh>
 <20250724172034.44679-1-bqn9090@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several style issues in a multiline if-statement:

- Moved '&&' to the end of the previous line to follow logical continuation style
- Fixed indentation to align with the opening parenthesis of the expression
- Avoided ending a line with an open parenthesis '('
- Moved closing ')' to the end of the last expression line (as suggested by the maintainer)

These changes improve readability and conform to Linux kernel coding conventions.
No functional changes.

Signed-off-by: Bruce Qin <bqn9090@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 383a6f7c06f4..c652e0cd35f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -258,11 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
 			/* avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
-				&& padapter->xmitpriv.free_xmitframe_cnt < ((
-					NR_XMITFRAME / pstapriv->asoc_list_cnt
-				) / 2)
-			)
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt <
+					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2))
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-- 
2.43.0


