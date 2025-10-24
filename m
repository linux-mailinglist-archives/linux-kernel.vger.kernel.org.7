Return-Path: <linux-kernel+bounces-868620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B74C05A28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA6A1C21506
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B643126CC;
	Fri, 24 Oct 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7yi6jXF"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA5311C2F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302387; cv=none; b=BWGLcm7p/B/sOH7yiEsr5hpEn5wi5UNwc3boovMcKS0CSt2yauCnEdek60KIhf0HNi5MrzqasazmO0PtS9NxCFO0CxtflHoCLzyp/dZAPuMLI2C3AG9EMlQ+u6oxpLVBokHb9ImDe5bsu07YApFtbPcvf7t11MopWpq76J9avz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302387; c=relaxed/simple;
	bh=uyiLO+LNkEVTknh5PCD2nlZig9mEvwEHQFhgoM6Efq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3pBetb9fih5QV1Ykyk67tICvbd3SzAg+RrFNfOW3/LNMTlGcYXZbQA9UNkuSzREQc9NBdlHZ/E0hfSeP/ThWwuXMhA4uxExKWU5i0qCKm0WOtxJTUOnIbRrn+JvvJLe7aBjfyIGcI5hhVeKd4TfkEdek7VVDcyLgQBNbP4Xyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7yi6jXF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27c369f898fso29753365ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761302384; x=1761907184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLzt3nHwXvYmUXaWuT5xx9MwPLoAGs/1Oa1T6U/Qgwk=;
        b=Q7yi6jXFphbw4ew7tGhMrHo76Zi5fbGktMvFTMQQEo0qO8HmPZhd+N39g3T60LuXwb
         2oCS4WyJYsG6Sy4oNQfhSiSVRyxyfgiRbsoZ9blRRcYzuqzu+WhzPP6jlzVaNYU07hWa
         n3G0veYa4vschtn220bjCkzfkAxAgAU/j7UeffUBltIm/TjYipDCQNkkFw73fQkCJugD
         I1t0GqlzbXctB+uCvo/6scKrHtVSBvuc1LwjxWsMmO1/8mOzulg5SbJtIiNSRp5nvfen
         pwy20839BsmgTow1VmUP75UpnWB/AVdYBq0r1+eG56FEgZifGW3UV8EiOg0cAO5akYbg
         hYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302384; x=1761907184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLzt3nHwXvYmUXaWuT5xx9MwPLoAGs/1Oa1T6U/Qgwk=;
        b=KEZ09CtywNEdZPSGVfWA6YAcYGnZZZ/9Nq4h+1AR5L/yRH8KwUHMSxR9C2bH3CEMnz
         gLiemKzw9sBs7F5z4aT84V9mhxTIO6D1MUYT9biBj6/m2Y2PBJVm+2CCoTym3Wdrmq4H
         QOY2Iyw62CjJ89ydz/5kkD6nDcVxPpEURECZc7LcwTrG18PsBD+xiMCwi8GeeLq6uRTI
         pi4R2PfJ2C/Vixi9m+f0DvDsPVfijok8oruoux8P3GyaBA9/vqE90l8sM7eV889doKE2
         sXXmlYaiuLaP1qTsS6Z+tozXnPYlJaIl5PmlRkrqMK59TIllWlI1tBxKKBkhAyzVi2U9
         D74w==
X-Gm-Message-State: AOJu0YyFbfWc0Av3vNTCZCbdw0eqnYzWeDLIUG6rHhnCM/t5kfnxnxcf
	ZsoVh0OtIKHmhYQjTbwTeLGHdjUL0TFy27y2GDrm3DJ+KBzK29rP2qai
X-Gm-Gg: ASbGncvGdMBrct2F1ppn3l6C1A+RVfmm/h8joyxgDy+qSaUHceWKaymkURDPAZosq6z
	pCVaeKxPiy9fx3KwlQ8EOZcjZKjxQmXmCQFbg7xjA7U53v6cPeYpQUaiRem3TfiCasUhuYDeWWK
	49/xuDc0yCeNjcUXfgFDJBSUp5/r0bwrFgag4oixrsXlMBk+r24xEEv3+/UOoeRiu94LFmd4Eol
	KGTDSeZofvVdklXkzJA/8y6jjvhXi9iSrKoyKiMWlSLrzXX+xGmNyJz0x4s7fGS31SW1AHiR8kP
	m8XBE+2vbQmDbBaC/oJdaphU8WI3VbKDZb/weUukL/EvbHSs3b9TrBzZ7VgDxYF7JEH5x5lKIPv
	ZssYDz8717AemtH47bo/o9rBnR5+pbtJNG222CunaRcKL7iKY+sKBKE90xUrkx41zvRv0YVXYoD
	26qnS+B6ybWVY=
X-Google-Smtp-Source: AGHT+IE7bXnfWQJON3TLaojyE2i4thoKnt7jmM3h/3l0Kl0M5gviToItxxqZWN4WOizVmxSBsRm+Gw==
X-Received: by 2002:a17:903:2b06:b0:25c:b543:2da7 with SMTP id d9443c01a7336-290c9c93a96mr323148085ad.9.1761302384388;
        Fri, 24 Oct 2025 03:39:44 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de0fdc1sm51738365ad.48.2025.10.24.03.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:39:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 737A64206924; Fri, 24 Oct 2025 17:39:36 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Input Devices <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	George Anthony Vernon <contact@gvernon.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] hid-alps docs heading cleanup
Date: Fri, 24 Oct 2025 17:39:32 +0700
Message-ID: <20251024103934.20019-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=457; i=bagasdotme@gmail.com; h=from:subject; bh=uyiLO+LNkEVTknh5PCD2nlZig9mEvwEHQFhgoM6Efq8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBm/ww7t3HvO+itrZPcHkfXXX7POv5J7Ivt/t3dNXtw95 cbLikZCHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIh2xGhgmngiZOvbv778Mf qt+c6xktz/Pc7ijtvij5rZxfJeSmLAcjw3xj+Vsf/t/RK96vft34pM2JBH3ug1OZyy742Blr3mf TZAAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are two section headings cleanup patches for Alps HID documentation.
Enjoy!

Bagas Sanjaya (2):
  Documentation: hid-alps: Fix packet format section headings
  Documentation: hid-alps: Format DataByte* subsection headings

 Documentation/hid/hid-alps.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 828aeac92901c1f31b51ae0b9d792b9af5bd3e27
-- 
An old man doll... just what I always wanted! - Clara


