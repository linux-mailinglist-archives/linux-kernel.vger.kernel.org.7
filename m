Return-Path: <linux-kernel+bounces-792879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B4B3C9FA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA975E435D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22EB26D4C0;
	Sat, 30 Aug 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7B46CV+"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD42417C5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548864; cv=none; b=jqjyjJdN4jlGbLWP/qyMT5+Uaycz+V7pUabPRpi9g2gDQnA7De6t1MIyRiaBQmfSzdLQMNpLZ0U/KJpC63ygXIdprTyH0NEq62oQMqHbMdJCV28t5AZly4S3s81ceD0Eaw/fG48sNYLGP6VI9Sz35SngEzt4qP9UfGxHndpEylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548864; c=relaxed/simple;
	bh=pO6DONoaS0lUyRJJDY3ZV79rV05t11cx8Uegm3HkqmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzKC5UrFJUF5MTOhnaw7tV5YsFbNeITvbMbkLKEzw6BcPmpRLkcZr6zrt438oRKVPMMr7YnieKrMKjU/UfSVpwVN6uPrY687ufAHNmgO5f49QRDijGHHaIHQ0KZytTEKMFHZwh4qFwDsfIuV/vhhw6v2qjfssn8LDN3HrCCM+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7B46CV+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c98b309804so1801290f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548861; x=1757153661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Cxt9YYRfml0wt2z5MSpLo70bk672E7ota6Kaf5Kl8=;
        b=H7B46CV+03HDImbK3dpEiANOxw8lYosoSugEl4CG2yUGE3XvU+dykJU5p7fKS4B4h9
         WHp44RMX1aGN8X5ibUMXA5akt4aiuW4lQEr43kM4WFAsFdqZ0zL9fXU0tnmrHfJGNLJ4
         AqDfBDJwMj20so9dxF8y1OhKWlv/n+6TJ2CCrqQnJGTlyJ2f3/EEWeEwzHcYoorDbs9W
         GXSctVYIci7R6MCSVtq115mRRFzcK44KE5kOBOG3yCj71fj9//dyorgpo/8dtmtybLvM
         6va+karsEcTLExgJZvz7PJJFf5XwQvZsOlXRx1TyMiyjUR8QXimh3D7Px9bbxViPKYp1
         9iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548861; x=1757153661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Cxt9YYRfml0wt2z5MSpLo70bk672E7ota6Kaf5Kl8=;
        b=S7B952//pWIWGLKMQiB8Npk6xV1Rxs3ScfVz9ItDHuwqIgBOjLgneJ2X2Pbd8tsEOX
         AdWkG/o0p/BghFAo3611dfawC4nOK4udUbB3SWx2dEzTz6sFPC1kGDB8sJzcLFJfjsX6
         5iRcsC1OpAf0sZnLRIuUv009etJ8S7akD1njHy3u223ab4xEAemBlP4yrPq7UWilvtlG
         eC13K8hzRnCy7BBxAMvzEE/zS5ez0GTXFxpIIbgxMdrzktz+/Vd9Kb9B9cYAk5aLT2Ad
         hHqF//RazDeEywhWcsKAZZDr+M50isE6R3Tj6+88R7RXXUNtjWexftfuKC+267kDcOTQ
         ewmQ==
X-Gm-Message-State: AOJu0YwTYwsjt61l5t58dO8KVcL2DXhuw1ximeE2QcvHkohlAUbkFcat
	gGpvVKjBA/T1uCgzsLiS+PzzOggrZST3zWJ6OixS2uzBauaWH/zAkWZYa0v074nktfMoFQ==
X-Gm-Gg: ASbGncsI9Q139Ke4R/aCjnbJ4ODiglye1bJlVv44RnDnPpNQNQSKNveiLdf8gY+L8BB
	OnzDxbjyTcD7ylRAVTBYA7W7N9uquNIKSuSR0VHZIBv4XEnJMZpBYi8iMgAPfYR9mmEgFC9Q2JN
	sevHS4PvpFdVC/M6JtEAAMo1htyvNQOFlr3H/8xI8AvEDwsX0Vk3vCXvtyvncwMYPTEGe8CnIVp
	H5Ds9xSLvtuZ0rg3kdVQR1NesCbMyy2FuaVauwTzlzktkZUVJKQUDADV2/2IeTu/9XI7XV2AqJH
	riHfpzcb6MobEI93uQpga3JpdJ3t0AolcyZWvlbpri8mv/AnuzVdQNX84GAorMwdla3rcGGGmI0
	bZG9QpZdQr0q6J73BNoL1KucZg6cJsYrJMPEjKxMHNlq6DANbAqLPlGIL74Tl0MQiLwI5P+lxBd
	fCPoLBjOpc9RzCZA+1mgYmlcDyt63uQ0KSPY61zAMNNOnMfBAuJeOuGWlZ2awdq1eDKm4xyMO7E
	ajxFKPXkJaCivYZvxc=
X-Google-Smtp-Source: AGHT+IEuB+qTKZ68oNvpjelOrU62bKL76ax/mQjCMq5CUuR0hkRBu3vLx+fF5cxD3tju/FNQGcUTsA==
X-Received: by 2002:a05:6000:2506:b0:3cd:5815:68cb with SMTP id ffacd0b85a97d-3d1def66c22mr915099f8f.52.1756548860501;
        Sat, 30 Aug 2025 03:14:20 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:20 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 01/12] refactor: remove the call to  in
Date: Sat, 30 Aug 2025 12:14:02 +0200
Message-ID: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/dlm/lock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524cd35..5af1840f98d8 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -977,7 +977,6 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		   request; this should never happen */
 		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
 			  from_nodeid, r->res_master_nodeid, dir_nodeid);
-		dlm_print_rsb(r);
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		error = -ENOTBLK;
 		goto out;
-- 
2.48.1


