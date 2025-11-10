Return-Path: <linux-kernel+bounces-892334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB32C44E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229123AA206
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC8626C399;
	Mon, 10 Nov 2025 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSvIUDg8"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06616AD51
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747220; cv=none; b=r8iJDvgkP6TlhV5rX1WK2OfjDWLMVxXzrcNaHwbpTms653L7DJrQh31Ki+wfGP38RRXFPf5bihT6rQb+SI0c3dzypvJB0wooyUEgTlkSkpMRVTa5HoumSnnQ3Y0C+l+IIqZNSz8aK64gtR5Rd1GA+TzpvDjM5ClVU19hyQNOVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747220; c=relaxed/simple;
	bh=+YLA1pF2u5tBPkoi+r5JyGU4phxXNOGQYDiMD+cdBrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmpKYjkHA9lQp6xKzjyrANjeLrTUh1zAOl60emBYBl1icF+EqFhJZMoiWD/G1iF1ul1SJSblp0EOMuP853g1V2jf+1QI4W/mDEdkt5kprF1xX7GHUee0MY2Br2vg7ZHnQ/VH7GrNMqYM1TPtao03xGfxz1Vj+ylHfr6IjQv1blM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSvIUDg8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3437ca434f4so1126709a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 20:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762747218; x=1763352018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMUfG6d8YJVoEPCuzvVWiCBdiIaGW3adtjAXZfiawOQ=;
        b=JSvIUDg8rQ3V0s/QpgDPUq737Jx3R8xpJ3SYe7SPnMaw1peTcli+FfgqGvcCWqKDah
         MEZHNxcHwaOtyqZrdRC6kRWesz92SK8C0gUWvHh+bpHc2jqxju3m3U7bD+jfWLfp9uHN
         RK82IenK4UDxS8vLZNV4BZ7Iu+GD5nKFfrun6TVUFaLwSkEhzkL9KD1+ZmOS5MHt+HRV
         rXg63rA6+DqMgMlod3wDt11GUUHGeXMycwQNa+3b0gwWq3QIEDzwFcSRbnRJHN/auy3d
         l3bIKbePqhjA4v029FKl8MuMiM8599sm2Rzh/1g39LpUEWcmnrlT+/1dQLHzStkwAF19
         h1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762747218; x=1763352018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMUfG6d8YJVoEPCuzvVWiCBdiIaGW3adtjAXZfiawOQ=;
        b=Bsx1R+E1r87ORpYHbIyLd2PSPFktH3sLkCFAkP3xBwIW1RJRr81vvQs/sbayHo59/o
         WUTpqKYFIXrS7pn8UCEHy24PlKA2dZRWzAQ1UhVrQTO/hioVDAkIKKgSu9wmOluVA2BX
         9A22eLsMpeo4md/bYT4tKJOkmStFpkEQHxxCYOhaavjH3zgQ9PSd636PixSvmm96r71Z
         pxUkgCb9ZvFvxTU6bhcrIO3hcqtPSVJoWmLUBtRWHdTothLG+tKiQN137O9/wzuuGg7z
         LJha0X4zClXJTdK/DXxJHP9OS38G/EqVg/07XzNYm0TvZjntPWwRPGpvGoaedARU1588
         Z3Rw==
X-Gm-Message-State: AOJu0YygEYHNoONGYKQQsYTaYdkqfFjyEBKEpSYetRw3T9kYkoivUBe1
	qG618pFN6dyUynAoOz+G/iH1b7MfBgp9d+Oa8dMUnSKhn/mJRCvwLygo
X-Gm-Gg: ASbGnctRdUdfZSr3cL2vs5MFSOVxaDPwjS/hRL0zYoVUPDo9aH+e5oSP48zf+SB5nHT
	9g7ZMtSl6ARIuCNP06vMa2YjoO3QfuaZdD/foZ2wCS3P2WXwBXoAyEPnr5/FVvWswg1n0jviMuN
	Sug+yQI7tFt+hkSVueo+HP4NoHCuWpc9daNDzmXhx1MGax+IC7Td/HasV0Tm2r/mQ7MpnNy1l4T
	0a6YVfjJaLejS2Q9YIkSh/swi6JiCFHlTsg9wUNxM0Ls+8Ea+ONVPXcRUUDAVoFKbhbIuE4jMS6
	1F/kswa0S0VWW87ZT7Almk4DpUGrCZpGCB7QDvtTkC5568SMO7UEKeqqXfCTRNHoPe5tfbArEG5
	hJgRLYTzEBeIb2a37INQ6EUCZSEWoRK3W64vfRDxzS0BmtY+4oBFz+3dCAU3kz3uwp+4Va3n1U1
	HEOgft+vfoXRA=
X-Google-Smtp-Source: AGHT+IGylS3DANSimRKsqAmshVHWUS6uHhBsurOh5pZoC5DU/3TeXp2D1eGJLyuUWjqFxc7R7ZxiJw==
X-Received: by 2002:a17:90b:5588:b0:343:60ab:ca8e with SMTP id 98e67ed59e1d1-3436ccf9da2mr10566796a91.17.1762747216926;
        Sun, 09 Nov 2025 20:00:16 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3437221b329sm5519516a91.16.2025.11.09.20.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 20:00:16 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B7B4B41F3D47; Mon, 10 Nov 2025 11:00:13 +0700 (WIB)
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
	Aswin Venkatesan <aswivenk@qti.qualcomm.com>
Subject: [PATCH 0/2] accel/qaic documentation fixes
Date: Mon, 10 Nov 2025 10:59:51 +0700
Message-ID: <20251110035952.25778-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=720; i=bagasdotme@gmail.com; h=from:subject; bh=+YLA1pF2u5tBPkoi+r5JyGU4phxXNOGQYDiMD+cdBrs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmCSfFXI9PM/p+54WFUsvFkzdomDv+PhZf0hNiuf5x+e YX0/Z2sHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIpxfDPwOD25v26U9xXiG9 6GKHacdzFTmGCRYnJPqjNNidFmq++svwP0i4nOsFx8qwC3+U1ijM3X1phaSvyUbbokzDizxrGYO eMAAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are two documentation (indentation) fixes for accel/qaic as reported in
linux-next ([1], [2]).

Enjoy!

[1]: https://lore.kernel.org/linux-next/20251110132401.200d88bd@canb.auug.org.au/
[2]: https://lore.kernel.org/linux-next/20251110135038.29e96051@canb.auug.org.au/

Bagas Sanjaya (2):
  accel/qaic: Separate DBC_STATE_* definition list
  accel/qaic: Format DBC states table in sysfs ABI documentation

 Documentation/ABI/stable/sysfs-driver-qaic | 17 ++++++++++-------
 Documentation/accel/qaic/aic100.rst        |  1 +
 2 files changed, 11 insertions(+), 7 deletions(-)


base-commit: a2b0c33e9423cd06133304e2f81c713849059b10
-- 
An old man doll... just what I always wanted! - Clara


