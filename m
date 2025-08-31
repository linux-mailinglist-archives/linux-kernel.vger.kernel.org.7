Return-Path: <linux-kernel+bounces-793335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D8B3D205
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F010A17D6CE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E712472A8;
	Sun, 31 Aug 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0KXYCnk"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A12036FE
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635225; cv=none; b=S/ZoJ9VWaiU7Z718Gh3S1hlpOtNWxGenOAog1PgfTjOzfecz/ZvcvOLyxDh38tU+ub5h7a/qVtNooJWy5RPPB3/nj+Fqmw4MyxmHDbtFP8q2RyPEcvTni70O2WgTgB7SKKQBszqPsaeVlF3pJcSOJXygKNBnJd3sypuzvQBzRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635225; c=relaxed/simple;
	bh=Y+QE5ju7q026mUNUHObMI1mUISo66ZfzICcWPSRPWc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmfCCAcpgE8j1V+Hz2WcaVj0MjjnjLVOKPv2ZFdG3SyFpDyXBM/oVBvZKjwDvu0QNh9NV9Ctih5LsALWq+4pJIwucZm6/sxZSs6YRMNdsoQvbqWv/pVpJMK78KI3V6Od6yBT29QlnrNfUTCcBCmVfBG1coJsIj7Zi99wOx4rxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0KXYCnk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109c482c8so64249351cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756635223; x=1757240023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NnFF/qZEQ0vbIO+TxuJcxC4FDAmdCshCuApcWT/PwxM=;
        b=V0KXYCnknwPoXSbPHkeGwoFHNCN8Y4j1WCJAtjMrdMSlaESSQWKhiZ+Dz5M8bbeJCp
         aBxauscaIjArK+CfMNMCDy+GIkM6luro5teNwVhWSObQrOZLwR5FuBTepY2gDYWv4EG1
         gZyhVOLtogOS86RB/JtFXJV6d/OO7e1n8NUmvinFarXBevvNkUadw2CVsuGwmKt0IcLh
         Xlkdp/InAzSbv8ALw74zh4aKxVwaXgZOUVdxwdQbjn62RQCM183Lnp/4swVAnpMTEwFo
         xp+W8YkOx/bEVbVYPca1NT64haJOIG0qFLqgQyTA+YnqKY6wh5NLZ4rT/1mOAxHUKkKr
         30SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635223; x=1757240023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnFF/qZEQ0vbIO+TxuJcxC4FDAmdCshCuApcWT/PwxM=;
        b=wlCrBOKgkRev0LQLCydjCLC5FvAMVmKlq4yeqR9hmZR6j7a+WkTx4ropw23+RPhGoA
         B8Om4ZtyR736P7KryUYM3vQggX2uiYCv/+QORmrBEGg/Qair6eh+TdHzs6JoiluqbAqc
         /Vl64xxTvCnNqdI9Bq+5GmfWZWVeuf7shgjj0qo4HnLy3RDFc+a9BvZGJbae9TLsvim4
         3kcIaRciPxmmb+t9EJHQTLbgk17ZodqJ5wYdqBaJW9Ghpx6SasasP1UtWux3gAvs0lVO
         7kb7Po9uNFKgZHnuh04YZHWo2rYI63XllD5g+jK8HguD0QamXQaI+BAUfeS5Yvw2Sizs
         47rg==
X-Forwarded-Encrypted: i=1; AJvYcCVOucJUvGaCobaFbAgJ8PYC/FVmaEBtSSDKBv2l5fibux36TzYku3wrjBhVRE90kEajU8PUTVr7ALiK8Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSideVaJxuOzeHhz/T2JI/nrf4puPcTkQUHLmm6ZfJrBAo6Gw
	puaNyaPfy9NYDhUxZj7XvDS7THAPYH01tXDq0p/SnWW6ghJ2oXs5B+8sFKMVlRtzCE4=
X-Gm-Gg: ASbGncvEFSwpqeDnUPMmV6g2xFnxz6zmXyTxui0yhyVo1nhzsk74+zFJS9kZP+rIa7R
	cqn13PWc4amEEOrpm9N2h1INI+5wNeMroBi8zDDZbQ+nPpXwHXzzEhodTGTT5lDnjOrHbWZcy5N
	yB0Wi41u4IA7l/5RXwvQ99/UzGohXnl2cl1zsdFhkRQBJJ8T4XnE37Qeqs6nfydtKBJyko+WgOK
	EryoEoC1jrqIteJt4CtW5WjcuGd/67HGoZsoyCEPJn/N9lT++v/TB2vMdbfheUft2J8kSVHm34i
	hxp7PorAwH5cs9f+ZrDeXvJwH9a2d6t5E0XzLMkLvJAfoz7gsu8T2XJGzwDAR/Y+41Na18PGqhn
	hm3LMttLAYhN+ebZqAexeewyRMRwSKxheBsC0sNc54tC2+jX8l4ZmYKOSIHB62KXYQWFf5WfYAy
	jl8M22UlU7lla/
X-Google-Smtp-Source: AGHT+IGdP63d/mZOQnDgIGsSI8K5YvjoGUgxD23C3ixymYMlOdnLovlFLiEHzx83sZfmFvjR74As8A==
X-Received: by 2002:a05:622a:1214:b0:4b2:f065:f331 with SMTP id d75a77b69052e-4b31dd7bdc4mr49637301cf.78.1756635223062;
        Sun, 31 Aug 2025 03:13:43 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:1bcc:1b67:3f57:d21e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6e98f7sm43727141cf.46.2025.08.31.03.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:13:42 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: Ryan Chung <seokwoo.chung130@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] trace: minor documentation fixes for clarity and
Date: Sun, 31 Aug 2025 19:13:28 +0900
Message-ID: <20250831101339.11324-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This short series cleans up two small wording issues in the tracing docs to
improve readability. There are no functional changes.

Ryan Chung (2):
  trace: rephrase for clearer documentation
  trace: fix grammar error in debugging.rst

 Documentation/trace/boottime-trace.rst | 2 +-
 Documentation/trace/debugging.rst      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


