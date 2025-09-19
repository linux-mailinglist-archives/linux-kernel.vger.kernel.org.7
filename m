Return-Path: <linux-kernel+bounces-825008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7EB8AB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7781217BD66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682C3218AD;
	Fri, 19 Sep 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dEu51Wd4"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C325C804
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301599; cv=none; b=rEWT97QayX94WEObUmm2U7GjW75F8WDTLb9AsAMQd6AKcQ2oXLaOq0GhaaVgw7EBGYc48Ym3w04HMWR5XYvD9FK1WsNn0o3pItoER5x28Qrfi229uyL+XyDiaTDk5DCuHVM/7A5tFo3W+xW7qPVQ2myAo/xdJkuul/2U8Hwn1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301599; c=relaxed/simple;
	bh=q8hVKWTJYFegeK+gcBPDI5sNVfJB9gAyqBbqKkBR/hM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8yr9dUt8GxKxfmqgKih0lRi7d6TqjGkPDTtExKOOmJWU0uxkPenKtKduBzNdGxM77g6Aw4wr9vdQobXmFLEO15LOyokY/JSrj26XAqvcxfHnvz+hXF9QTGYN6FwQvYmpvosjxe3piaQGZcu7Lb7HjSrFqKtcwGh0Z3wkzfhlZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dEu51Wd4; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-89336854730so86514239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758301596; x=1758906396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xszZQkvWINK5WulR3oXM0DZacWHWOr6o1TKTnr/+EE=;
        b=dEu51Wd4iY0tT1PRC8AXmYSzNp3/M8jEPAX6Osol236IDICTFPF55YSrhkTm2MQIVv
         H666IJi5qpiTdbcdBgSs082G8iK0qXKiuc0mVH98lxTsrIOcmZ/aS3E6ZrTN3P7t5tps
         LDpRxtPP9zNZrRtFc82w4IEcdc3IExPt86EAaB29DbFCErqsbQEUZh7TrPDLDWgxDBGm
         YjjZhrNm0Mu7d1SXy76GFAZUu1jAXZudorY/Q/CxX0pap1u0UEwwEIAu3Hqbqd71HlpQ
         7rSYD4MDdU3TrCEjxbipzfAIXkErFV2VF2J4MEsH9TAphUtAGHI5D1k9Z3t2UcC2b6js
         vJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301596; x=1758906396;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xszZQkvWINK5WulR3oXM0DZacWHWOr6o1TKTnr/+EE=;
        b=Ql93MrOrN0mzavuJOz3p3/A3RJwC2EUXpyjusohJENYqgMojuNikBqF16E8pYkRzGT
         /pTGey+Neo9ueDu022DxnGC3yFPmi3zOltwgTcRhsrkzmIQiZsauq+YycdVd+C1THZDx
         VDX1CALTSaAout2+/myCU5yWeiN0PK2DD1D+D2EQ4uCR3Zp1385cxcoF3zOs2a20cvXV
         44EGvCOJQH7hcfW7zF+1oggS2LR0efSUymdTr6zG/I04jEmACGnDDCOw5biKxx1/Iu7d
         NZwKho/Mi4eUoBljGV4tx2+8iHzsNnc/fDxjmvOek/C1i2vnoBpDjhqaab96Mx2xGYG5
         JkeA==
X-Forwarded-Encrypted: i=1; AJvYcCV5jngrUg17R8gf853wUAuuXh+yp3uVjY2E4K3LANRm/e+84PGfieF9Tw6jPPNA4YUP+6Z/ZsJ/YJal9j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3NRYkyP1sah1bzkPDUr81xUKK8WX7MPrnplqAR2v3ljwroSB
	2YOT0LGZSK+iAWaK4febqrmyi3h8xa2av5p+HhNRkvzZTdDFaRo3wsfy1i4ZrexBpRc=
X-Gm-Gg: ASbGncvqsKw0NXr0V+7++S5RBjpR74B7caDeWMlPaipsnKKoaAY5JdNXcuHnARvGd8K
	HUi2kN4VGQeoLAlWY1+Ni9FF4RgyQEKLMmCYTBLXwrm9TgxsMMJnb7bhPMK18zKctjC4ubgFDcx
	kL8KDOUNm00lfNxQjYq02epgd3pcAuk7fPupYqI+QgDUQegM2XbKNgG6re1MWS1uhAwSogpmxG2
	CRGXdz/484kcaBlqj8tBk60Za3QanNfvHrl5hOupqUQsVd7l4S1WPtN4TMkHeBpCe8dl7AP7yJw
	wyVl67MXUeq7XhshkBhJSXJG+HXjP6XWrbsaq0/yWQkcr3gFVB05Xjx2+T2wLiASS6IKm720HAZ
	cb/wgLqIKX2GjrA==
X-Google-Smtp-Source: AGHT+IEWozrJP43M4DVIrxcb0S2DwxZPhA4LrRW0lqAN04mhddqVBixtfK+2/UInAStgyEXg1YXAIA==
X-Received: by 2002:a05:6602:164b:b0:887:3ae9:c3d9 with SMTP id ca18e2360f4ac-8adcd809f54mr646108739f.2.1758301596382;
        Fri, 19 Sep 2025 10:06:36 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46a68330fsm188484939f.2.2025.09.19.10.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:06:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
Subject: Re: [PATCH v2 0/3] selftests: ublk: kublk: fix feature list
Message-Id: <175830159548.906981.4104343901277988094.b4-ty@kernel.dk>
Date: Fri, 19 Sep 2025 11:06:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 18 Sep 2025 13:34:06 -0600, Uday Shankar wrote:
> This patch simplifies kublk's implementation of the feature list
> command, fixes a bug where a feature was missing, and adds a test to
> ensure that similar bugs do not happen in the future.
> 
> 

Applied, thanks!

[1/3] selftests: ublk: kublk: simplify feat_map definition
      commit: 1f924cf781de47432f220185bb2beeb12c666aa1
[2/3] selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON to feat_map
      commit: 742bcc1101bcaca92901fe3fe434e4b1a467b5e8
[3/3] selftests: ublk: add test to verify that feat_map is complete
      commit: a755da0dd0530e53aa026fd4d08b3097e1be6455

Best regards,
-- 
Jens Axboe




