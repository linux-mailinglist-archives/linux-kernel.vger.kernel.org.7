Return-Path: <linux-kernel+bounces-753559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04397B1848E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BF25621AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E1272810;
	Fri,  1 Aug 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLhWYn7c"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E2271A6F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060893; cv=none; b=ZYxVTo0NIX/ruaFJ6EZgpBPuYZLUF1KrX77iLf+X7WfPhkMQEnHWCgtAdv/d+Ug7JSmwd4U12NCYvfUs3+5noQU9kzSJ9nsxuulw+tBxIbyD9nT5zEqajebR5nxNtcogAw02ScwiNTnDwkeME3KGeOJBrg+QtpNfj1CwSIoZOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060893; c=relaxed/simple;
	bh=OO2Z7mIWJju/0AAWi0QFQrEeFkD+xuMhO5TmIsG9bFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNCcdTGr2UuqxvIWjrwK/jb8IGZwE0cPhOlzyVKz26sl2V+U2+pkiwXfuPLEuxYWOkdQ5y9cpuiLA+PXDKa1lshJNA2wzQ9+3bAB8fsaVyBf83QaUtn1RrD2oVW4ZW/q0rj4MaGbNEYsEhOPIf8urPeKg4TmyMunoSCBZs2X38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLhWYn7c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2406fe901c4so13234465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754060891; x=1754665691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDSLLULuQro4tZ+C6kFbdQGbu24iHgqnLikNbErS/QE=;
        b=QLhWYn7co9gs0vvPVRm9pFeJsuLHmNIdxeDKqG3DPnzT+Ogqp/826Homy9yZO8Gj1+
         oerLQGKf1ruq5KQmVS6ZO5k2U2KS3fupQoWonzv0gPXyeGwNL03JQNJN3nXXTcpRkhQq
         Qa4xFRMetKeJIki27PEobrRewrG3hm0yJv/Oa8bG15zhvs+gXMUzuGQEOLEcdBflXDrm
         uV2ijDoCvEGEEAmkKJlgRCMyHvMumE+QoCB+Yn7KQ7iFKSbb3hiCdypv2U7qlsE+ddct
         wNTiGc9vFOEdkcf5ytiW0sYeIdQln3E+TSv7d3LO+1sfVhWBD7Q10RpQD1fdAZuk40F2
         eyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060891; x=1754665691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDSLLULuQro4tZ+C6kFbdQGbu24iHgqnLikNbErS/QE=;
        b=Cy9QEJHvJQzVjkmm/bQGuFxhm8+4gmZkMl1SR9Lp8F1FdgZhp1gFlY0029Y0ZoQAWS
         D7tTsc58P/I6CMYSHnYwPE1GIIxz37eXiAMxge4pH8KILcMeqbRqJAALbTWWcwaFH/RK
         BUxf05oQ+L1fPF050GqKo6yi3IvgGUDpGcaEfMX+GYyoVQchF1rBkWoQhla+nfw7DnPB
         KaM8W4Dhyhxb5gfxqD+WBVensfrDSxY+fePXeaoJR9t930oT3TmQAg/hBq234gF0yoUH
         wbMvF6Vzj5EahExCqYD6Sj1PpnmjrFMCD3ZSZiR5t+I7VbAPAx3EvdiZUQIY124UoMvx
         YzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdMUShVtDWG+2/NAReXKI9jxJYmk5H/e/rdhU9/wFbD5F34r1gbw4R7k64xy7QhxTi6I6y5Qi2WsBlVC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyupE0DuepaMpRG4y3I65YQ35friN2/bQUL+6tyh86Rg5BsEae3
	FBLF5sozr4RaozTrVsKvmwKumx4NOt8L7abwuvX12GstnQjQfgVZVv1aAeVtG5Rjbp0=
X-Gm-Gg: ASbGnctTDImMCsO23elnAPjlkwFFVso62ztW2fKRHQiwBVfCd3Lt1JhqUpGtBDEE3T2
	DwCQoLJfZM3y6BegmKC3J1VLoa8bf3Gi9QzzF9DqvL+bBHyp8rM671txNUPyXMI5+EswO+6XbfJ
	lW64O8miIVW+ZtF51dDzauxhM/olZdJKitVFs0+UahFsK4m23IpMX+REkTEpZIl8c28ARv8bjss
	3SxTqhsEcN0uzH0Ile7J4WwDyMudhg7BRgWlDe9V7jVKTdCUt0i1PrAdDRxlwKwBPg7BR2VbYpv
	AeXqw+dzVnKNjPZfd4y1mVtR7SJIR/9RgeYiIFU2yu5EFjJjdYKIs+IR3KfsoCaEfL/t7hlpgNL
	H8TVjohsRTD9uUbwScw==
X-Google-Smtp-Source: AGHT+IFayGqBx8hW294QxMt2k98HLw7+m+LZMmht2Y8J5kauLQORFEs1yvXOy9+cvVSKakLHEQx1Ag==
X-Received: by 2002:a17:902:db11:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-2422a6b1521mr43892835ad.35.1754060890630;
        Fri, 01 Aug 2025 08:08:10 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa11sm45639705ad.172.2025.08.01.08.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:08:10 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 01 Aug 2025 23:07:28 +0800
Subject: [PATCH v14 04/13] drm/msm/dpu: fix mixer number counter on
 allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-v6-16-rc2-quad-pipe-upstream-v14-4-b626236f4c31@linaro.org>
References: <20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org>
In-Reply-To: <20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754060859; l=1366;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=OO2Z7mIWJju/0AAWi0QFQrEeFkD+xuMhO5TmIsG9bFo=;
 b=DETqfYzbBAU3+ZrJj8OiSBo60uswBpiJ+Fiol09/aeqJuM42nOixyKlbhgbx+R/Qv/ErHOuBJ
 OZ4elEmcauaA0/mjq4r+cq1buvaWss0mroaRogcSvaeaex/i2K5+B0T
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Current code only supports usage cases with one pair of mixers at
most. To support quad-pipe usage case, two pairs of mixers need to
be reserved. The lm_count for all pairs is cleared if a peer
allocation fails in current implementation. Reset the current lm_count
to an even number instead of completely clearing it. This prevents all
pairs from being cleared in cases where multiple LM pairs are needed.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 2c77c74fac0fda649da8ce19b7b3c6cb32b9535c..3f344322b7f214d0050986e675b32522f8eb0ba7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -374,7 +374,11 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
 		if (!rm->mixer_blks[i])
 			continue;
 
-		lm_count = 0;
+		/*
+		 * Reset lm_count to an even index. This will drop the previous
+		 * primary mixer if failed to find its peer.
+		 */
+		lm_count &= ~1;
 		lm_idx[lm_count] = i;
 
 		if (!_dpu_rm_check_lm_and_get_connected_blks(rm, global_state,

-- 
2.34.1


