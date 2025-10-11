Return-Path: <linux-kernel+bounces-849064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E6BCF236
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00ED34E7A51
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68923A58B;
	Sat, 11 Oct 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPavFLHG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18991233721
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171298; cv=none; b=kw/N2JhMOWUHL9pNOdJqMZjY67ryXRG5OqZmfNo6EGqYaD09VwQPMyBAMr/SbYKkLzDLsj4gjYI11YimodoqfI1LcnYcCdpkSPBdoLEjoo6nbOHjhirMCfFG86Ab+okXlMUI3D/EW+sKHtpRJXi6iKtMaBIsNwzMlImZoLB+BD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171298; c=relaxed/simple;
	bh=ibj9y3XGzitL7WUJYZHY4Uea+u+ouP63eobF+V6rTcQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=amFbCEK0d6+VxlnZeAtHp9zmBB9yJNmHT7D+K4K/mZW3Luc+qDrrIeht1OdQFm4bo250fCXY/+9iN5WrLGnGWHYx8MnGJQEQhkqfNHNCTLKZtD5GPEg2US3/426RDJ1bU9LyHDO345o3CTjNw7Oz9ivanoYJYLHs6UlBU90kDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPavFLHG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760171292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wRWfEct05XF5GxNiOGHZpckrzzE7GqksRk3vN/AYVmg=;
	b=fPavFLHGVVFxQD9BrrrFBCDYV5ZeKme9Rr5y2g+C0N0TQ6LEno7jOGsrkxqVF+pDjGkmP+
	tcLfqbkz2orMx+XhG9D1w1njl3QgJqVsmY/QbgUFaq40Y5WZ7FQ3dK6KIgiOAV4PqUWwID
	zbYGk22q1RgLfKkeYKog57DgA1UIcao=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-7p0tMd-HOWesGgs9IyVvVg-1; Sat, 11 Oct 2025 04:28:10 -0400
X-MC-Unique: 7p0tMd-HOWesGgs9IyVvVg-1
X-Mimecast-MFC-AGG-ID: 7p0tMd-HOWesGgs9IyVvVg_1760171289
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso2291910f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171289; x=1760776089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRWfEct05XF5GxNiOGHZpckrzzE7GqksRk3vN/AYVmg=;
        b=eibTJS62nudqpPufldxl6m6JqK76AEHzGLG5AGSbOfuGXlDtQ02aO8DqhZT+xcnyyS
         NvaFa6SKAmTzVnWFjDsMkODCihm59ZM/JDivx81LN5mURvLkA/U3SojV3LcrJAMuWxGT
         go4snos6GhvYFzy8Dz583lfVG3b2aiTOIVEeKyIYHUoRg3Dp5ttaEQIJp/mlWw3C/Pf1
         KOnMHNsoDnL8NU+rROHid7fhAMF7UWXM4ayQC0HVRp+xJORCQ/qAqvNIfy1Gx+UVZmKZ
         KkVLBsZDjvzfppTYQTe9z5y9GnK300MeaViGQ0SsOWut/Jrh9RSq96xnSgKMaEsFDhn4
         HM9w==
X-Forwarded-Encrypted: i=1; AJvYcCXFhKk1fdgDnhXaaZngmrtSZYTl9XEsrCprsLGCBiekQr3v5V6Vd3d4s0dnqxYCHS5GyFlnKmOlYyTpP9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf2vr3aDcaJHOdPGC3i/MiuUpVEdHNOV6jl49iANbX9P91RgU/
	w8srNsoB1XnJWR+JfvF9nI3c2T9PuKQ9ew0xzCW5viAA20kK+bN0kiWiqZSCd8vhdQoAn7zzIBM
	40eeJSE1cRlN0Ow79/0wcGmQVfy0XOPS6QZYoNmxNg9W7MoM844jec0P4y1SJBu8ffA==
X-Gm-Gg: ASbGncuNdWPTSJfq/gfuv7ZubpJPI6CP2jzAqrlz0gBW6kohZS7DzOb8iKRd/JirBXE
	wbesLrX+oszXdDjG1pQf70uu+FtBCoJuESb3VAAJaUVFyBuszRAENKUlJVsoPOEgn0Ne/XIBhp2
	agG/+FLtlSFXCeltLmcHtzys3tl2NbcCyrMc8TwJeL2hBAUQ2Ws3KgCSAtv1ARmllWl4XXT3Y1u
	sUBtJjbiTGyEhgQKg1KGIIP0+h+zNNn6iaOWSR9ec7S8xJxYlQqgRDyAzGkifJeSIlqL9SY79Oy
	MMapBWm40bawm3eLz235kERiTwPVAtvSQzkVDBW/iccX
X-Received: by 2002:a05:6000:40cc:b0:426:d5bf:aa1 with SMTP id ffacd0b85a97d-426d5bf0b37mr727818f8f.62.1760171289489;
        Sat, 11 Oct 2025 01:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv+HY+qfihGeK/GnTuDnWbsq9s+051t5h9Mrw/U56mNyFoV7aOb+J0sxA944NzQ+3xeannQg==
X-Received: by 2002:a05:6000:40cc:b0:426:d5bf:aa1 with SMTP id ffacd0b85a97d-426d5bf0b37mr727804f8f.62.1760171289143;
        Sat, 11 Oct 2025 01:28:09 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm8022580f8f.34.2025.10.11.01.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:28:08 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] tools/rtla: Improve argument processing
Date: Sat, 11 Oct 2025 11:27:33 +0300
Message-ID: <20251011082738.173670-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The long-term goal of this patch series is to reduce code duplication
and unify argument display and parsing across all four tools.

Costa Shulyupin (5):
  tools/rtla: Add fatal() and replace error handling pattern
  tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
  tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
  tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")

 tools/tracing/rtla/src/osnoise_hist.c  | 74 +++++++++--------------
 tools/tracing/rtla/src/osnoise_top.c   | 68 ++++++++-------------
 tools/tracing/rtla/src/timerlat_hist.c | 82 ++++++++++----------------
 tools/tracing/rtla/src/timerlat_top.c  | 76 +++++++++---------------
 tools/tracing/rtla/src/timerlat_u.c    | 12 ++--
 tools/tracing/rtla/src/utils.c         | 15 +++++
 tools/tracing/rtla/src/utils.h         |  1 +
 7 files changed, 128 insertions(+), 200 deletions(-)

-- 
2.51.0


