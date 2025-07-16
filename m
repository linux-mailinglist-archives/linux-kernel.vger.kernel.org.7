Return-Path: <linux-kernel+bounces-732700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4723AB06AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D16817D125
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73B21A420;
	Wed, 16 Jul 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpajcBdA"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC07081C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627361; cv=none; b=HjWyo1Qe5+BDNX/SR7C30f4Un77b7cwYHXR4HJP/VFP8WieqiDX+tYHxSHRk7wf2lnQBBEaW8CA9k0ZNmkdXUP5UrUXDpcynzver77QT/WXu+CvHkmDZp79dej+CwsPWbTlikCqNR7o8hSXPKRWpE9MjDx8po/9jBXBnxeBJ6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627361; c=relaxed/simple;
	bh=T3fgAhGPlvqDMh9Jw5IWDpv8Ko7kjyzgVgZFq/qJh64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qMZPqxC+OKic4N83ze8T0pWEBFSsd7b7+qJn3+zBUtv6CL+9HGO+6qnRk1HNc+WGLhmJKGuXP7bi0LHrbnYCSfjyU3N/sCn/yFGZzz/hX0KSiWZvAsLsWXqyCVJYHEpHcU1aLbUNm5YahdnpyOx56RFqop4Z2ZhhjAlpL+EySjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpajcBdA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73ce2761272so3417564a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752627358; x=1753232158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QP8PckmLEVbu7IC5hLeQq1qAn3hWWpqaT94I16i3aeQ=;
        b=mpajcBdAAMM1ewVWa1a1BxV2eJCCrg0AeX92GbwSifhBX3Gx3VfJnpjkFxeEq9GF2j
         1KkS79DckVf2yiVYZAhTVzIDvDjVNpevot0rJ3m0W3flFmqo8Tji5HRZv66QYf4iPG9V
         f5tP0E9ZAc4qzh465aoRgsrsPPxQW5eu9filDxtiqen6ez5bWlHpH5XlYss51imr7KoC
         DWTYmRYoAqYAmVgtYmpTQcl5NyxGYv++GAppdRVYoYxyTGDo4POgexTNWRwKGajjfUm8
         ECRRWVJdAAaKHVrkP0UemjkefHrFGMnGf1uCTGVXOVgOqN02fc0Oeq/g4/6F1pP7Ag2D
         zCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627358; x=1753232158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QP8PckmLEVbu7IC5hLeQq1qAn3hWWpqaT94I16i3aeQ=;
        b=l56ZugFlGESOuzoP6BoQB32+IVqe71DcLnSn0CQgQUIWXAKfSz9HTEyKk9QLA02vPD
         58J2bwMhv7nxtA9r9dL6itqSIHTRhEV1Ek71s1VBnUQTF7b9OF94H9FwxsojSyLU5UoU
         ebrEh7G2PrQMQC8SPe4J1BhlGihaFUnqz2u3G/o3rkn7UpBazvEI2122m47NeNdSagPw
         qjwzdXpxMioSdZPLCGbYfBSrGAJEGQVN1Bb6cBdm27vthNzzY8S4m6PMA85d24vklpjU
         ABM54PE8+u+AxWcLmuMhS7MfGCmCAg9kUIttfm9w+wdlSlRjl1NLMb97oLsCw3yTb3v7
         jNrA==
X-Forwarded-Encrypted: i=1; AJvYcCXejUZUvocGzaDn9sINsbSLAR/VENIb0qAWYp5OCqmCZ/GGGpPSz5oKdEpJQWULu3NKC6M+Oae79pwGAHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XaxPpOUGc/yTXVvUEuQnFy7XRpeGz3RtdU3tdNzLFm5UR/eH
	y49S36wR0MMMiKC9GyzPxRhWAmquiWSzofvpGtVs66o1QCjH1iYrCqgn
X-Gm-Gg: ASbGnctRrzCBpD5pdJcng9kpD5Z3ql24BorBlr5Vp6OXkhyAIKo37FhLHeT68d564uS
	lRwamHna4xrXHzLeu4kRXHxlzhd1/VVbNVtixx8QcBrc0L9qnPosokXnUpr6LsOERPQACShfone
	LOvKfjhKPVJBKcysZkXuwbqUBLHiMGYLXOcTmcScdadbSTfCB2ivsjyf+SDz/TqwcbRQZsCX4f9
	DwJoFuUw+LTrId5EaJi4Vmq4Q/Qj7hfYFnv86984/+QgycFWGDyihPaFOVXe0U0Z3ePT9XE71Nf
	b1/xQp0jomsFZo+dUaDyl0Rj2fIXMD1AUiRRfT6zcxMCLLZ0seElrYp9T4uDYIUCXO7uxVCXwUF
	bZqqc2g7qUU3Pxomz1sxxSs/GVLRQKC/XPXdblGVbUqAJbmZEd4Nx
X-Google-Smtp-Source: AGHT+IGMZ9RtAkyD4qiFEocxU3QaoJWhrg0amNcLxCCMZ1WjXZjhbkAyLXZh8zuYkIxsAahZMgR9YA==
X-Received: by 2002:a05:6830:3494:b0:727:3303:7ea8 with SMTP id 46e09a7af769-73e64b12bb2mr1331643a34.25.1752627358266;
        Tue, 15 Jul 2025 17:55:58 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e56024edasm1035047a34.34.2025.07.15.17.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:55:57 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Subject: [PATCH v2 0/3] staging: sm750fb: Fix checkpatch warnings in sm750.c
Date: Tue, 15 Jul 2025 20:55:50 -0400
Message-Id: <20250716005553.52369-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series addresses the checkpatch.pl warnings identified
by Dan Carpenter's review. The changes have been split into three
separate patches as requested:

1. Fix const declaration for g_fbmode array
2. Fix function parameter alignment  
3. Fix CamelCase variable naming

Each patch addresses a specific type of checkpatch warning and
can be applied independently. The changes are purely stylistic
and do not affect functionality.

Ignacio Peña (3):
  staging: sm750fb: Fix const declaration for g_fbmode array
  staging: sm750fb: Fix function parameter alignment
  staging: sm750fb: Fix CamelCase variable naming

 drivers/staging/sm750fb/sm750.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.39.5 (Apple Git-154)


