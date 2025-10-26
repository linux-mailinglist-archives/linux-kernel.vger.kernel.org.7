Return-Path: <linux-kernel+bounces-870273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8066C0A56D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FC814E6163
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408AE22D7A1;
	Sun, 26 Oct 2025 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1COdxsR"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478820B7E1
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470665; cv=none; b=D9I3k3JKQsfc6O8cGu69S77AkLhZSIMSbTtMMgx8KTPtfgRDTwNkfY0kPzGrPWMDxM5+/2P8ecl3SdS/l6rTkaYNrIhUt0woWdyQoqENY6292cr6H4YrhSDVsu20IhcigeP/wBzv1BzJe7pQ3czqoHQokEtFlryjI179KHsO5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470665; c=relaxed/simple;
	bh=Wsp8cxVy22klAhiDGv9P8tZ3IPZ7LUZzLpg3S21IfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZnLjrPW+rP5+WN7ZOvFG7nJ2cyTBeUpB8Uw/2MC4/zI+rkcDmn1NR2VBIMNfVIvarq51D7cRY0IkJ+4szbGiteRc9tZImHxv07Ev6DiFjDrADXzC8xhX4iYy37EyQT1vm3jDSzxJqK/aF3PXpEDfeYqILp8yv3aAKnxbfFDYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1COdxsR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso2551100b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470664; x=1762075464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=f1COdxsR66WLD3OuqEA0Rq55Q7m+WcTFWN3K+XEtNYrDT6OAAOlsD/RryqO55LiNrl
         h9P00xlnr0e6ApQsFX3yaF3HsJhF5bQ2oUPa+aBI9Th+4aEUVvaM952ibhXm4BXcUVzk
         U/IBNL+sWV5aWsObI6N/v+T9LMQyMpC6nZ3hCpJM0pPwBHFsVVR4f8+d31buzQ5R3U85
         URHYHd7tZTqdSeGex1E4Ivc012NwgEV7kcSFXr/R4yk/kICCWRgqAAz+dsig46dFRvc/
         kuzS/BkiVeFd6dhUmt920KNpQnJ2cupgas2ECn/k11rYoOK7F7rDyxBG4x/7GOin6u4z
         19BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470664; x=1762075464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdMa6HWGVI8flyxHcsiTS5cMCkPtytHGgTVFhKdr0DY=;
        b=YMaw3m8qgk9dxj8WaTUEuQfP0D3U4UI1dXKZs3iKU/0AxkmqCdl90rkYvOV/mbumQr
         EbBVLpEuWAzltAwh+Y6YHjUQhR9O1+c6LUfZrOVutjHtcResjugoQzfAbryQ8RrV2ZdZ
         Ij3jhZyUCTTJreRN+3zRBBy/3AbyvADJeIQWvJ7yDv8/2W6E9HV2H7G+7kxjRLJMg6C5
         SHApmZDAg2qBmA80d6t6oDhnVo3fh7WcMPHaTX5Pt+tgg/5xKlBlYEJcrxdRP9xRub4g
         vJOx8M+qqijVzIwcBqy5J0HUB6Go0IX8XdK7oFAmp2G4kS61jxkbj2zmn8+2970OEFbR
         scbw==
X-Forwarded-Encrypted: i=1; AJvYcCVdlJClSpTx5fFdrDbmQBpIBIod7aelq7os5Q8Oh9R6lz2R32zoPXTCqOAS/0/ANvjpQflZ7HhsfLtMxOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNpUCmT2AyiETEu/wr1L9VDyR6cWTxtTqSWg6835Hajw99r0H
	OY3PiAxA4ZxgvdSf8z7r1v4UznjZVa0xKYGECLNmV3jUjmvhvKxZCEHh
X-Gm-Gg: ASbGnct9RBdV7k/9AODkvGev1VMlMaFm0taLQhPvtO+XW89l3QdvAOmFxb86jYM+eeQ
	5UWWJoNYcG7s8U5bx9mqoa9zUD1OxRck1Kgox7Pbh2PbUM4trFMgXiAE0xDTZYB9Qf6w4rgkwqK
	MKXLDmXaOBZRpf6dTtGsrr0JErZn5/srEoPn7HmB+6++GOTjrsGFQ+QVPo29eApGupZQoPEzyPM
	LqNZp0fHbiNtdElpR3O7ZBlnR3BpyMurA5P4bImmjhUEeGIgg4mMPE73Ti+EGHLyreEJs5tz0D2
	yKH1QVShjp/jOMmpqmf8go8RTQ973UuENCACqKEUOtRtlILnmajtZejV+PDwfG01iht9mWPaDBI
	IavJo0qr0TVkPH8OGtl5ngaNfCCzUUUeWcUOs+XY/EZ6mN0J054xCM3LOZjEDZya4aXBcM2DA7l
	uDpmGRd3fW946jHpTtFVc=
X-Google-Smtp-Source: AGHT+IGvbZctqDawrbvVj/YWwiaibKLUONAPApFbeuXnBVOb80OZCjV/x8ZAeq0wItW2If52JQqywA==
X-Received: by 2002:a05:6a20:12cf:b0:334:a681:389c with SMTP id adf61e73a8af0-33de967f61dmr10026226637.15.1761470663538;
        Sun, 26 Oct 2025 02:24:23 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bfaa1sm4063316a12.7.2025.10.26.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 02:24:23 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	david.hunter.linux@gmail.com,
	xandfury@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	khalid@kernel.org
Subject: [PATCH v2] selftests: tty: add tty_tiocsti_test to .gitignore
Date: Sun, 26 Oct 2025 14:52:32 +0530
Message-ID: <20251026092341.2896-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025102633-dandruff-clang-e91d@gregkh>
References: <2025102633-dandruff-clang-e91d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building the tty selftests generates the tty_tiocsti_test binary, which
appears as untracked file in git. As mentioned in the kselftest
documentation, all the generated objects must be placed inside
.gitignore. This prevents the generated objects from accidentally
getting staged and keeps the working tree clean.

Add the tty_tiocsti_test binary to .gitignore to avoid accidentally
staging the build artifact and maintain a clean working tree.

Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-tests-details

Suggested-by: David Hunter <david.hunter.linux@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:
- Improve the commit wording and explain clearly why this change is needed.

 tools/testing/selftests/tty/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
index fe70462a4aad..2453685d2493 100644
--- a/tools/testing/selftests/tty/.gitignore
+++ b/tools/testing/selftests/tty/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+tty_tiocsti_test
 tty_tstamp_update
-- 
2.43.0


