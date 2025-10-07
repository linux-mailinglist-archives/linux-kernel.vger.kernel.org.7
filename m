Return-Path: <linux-kernel+bounces-844662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31034BC2730
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B2C3A513C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561AD2E975F;
	Tue,  7 Oct 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0HVGjNo"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A02E7F27
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863324; cv=none; b=oputxXU4Y1uTMADU6vjkcZJGN9IoqW59PLOFi0NxmFC6UHdzZ6YO1hwfIo2pCGOXWT8Y2F+cq6BY866CAlHkMiW28sP+JmjNpXnCVCxHk9TwfhXsC/1GOHzF0/okywDy0Cwa6pw8lYCW6hSv8wZILXvskSsiP1FZhfyOKf4oju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863324; c=relaxed/simple;
	bh=KYaaNQMzTyncgQyqSCq4P2yL0PsSWqFZF+5bbRW1HLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAlI7O55kk3Uzx7YKX4C0WhAu1MGnujP0tlweCjHgE2QE92DeSixsRKmpiAM5ujQnRTJAPcNZ3hFitfV1yO6XP1pZ+a7/1dPdjlfQXnPSp1Wq9sXNIPGoMwxsiB7TuPUqiNF/Zz3GeDApVr43z8xYS7b8sKCtmgISovKCzCGwxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0HVGjNo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so75576065ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863322; x=1760468122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEWpi/vkQDymkY4TZuKIEKhri9YrajHYIJ3EVRMXvNM=;
        b=k0HVGjNoxrv+cDkt0LCnj2jXFpQRPZXbJFCsqXO9RoWy/zpE/8hxzpZiJojck41jBS
         Tobu6aRiz3BL9C5GfZSUWBE6PP+2s9twehK3hxawTgPD0nkYvitPQ/LrDPCT5rBYFiDA
         jYfnw3jNMkegNPNb3o4db6vDVcaBgEqcVeWmNYt7BGMirl1bt7S3YvDiRqj5W0GfwlQn
         r5OATYMhAnv6ympM+hbhWeyoAMIIVZ5GIB5JjY4jrCb282doXwyGP3j/SJo/91Pe8XRw
         pNXu7qUrm7I/O19Eki6mpXAqecAYUaqN5LltNIaHEUOY+IFUSGEiNeH5UT4Lwjjq5CZi
         fkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863322; x=1760468122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEWpi/vkQDymkY4TZuKIEKhri9YrajHYIJ3EVRMXvNM=;
        b=pEue9/pLmBbSSnd78DNAdk1tYnk2IWW+Wf8CvCqJN3TuKHDgGNqTftvpEWVbDl5nef
         17bLkW78cE2bz52dyKF99oyYftIn/kvUHZzbwtVH1W+MwWVfmRJYqmyxXNufZIj3jKKv
         4CTzk35Lo1aaN3SCJSgdG98RTH3RhI3sacPz5VJwsG13hXxoJrcwWRTzwIk6GrhUhE2q
         L3FQdShak5Kbh2lcLrVTzH2TvCKDgAJdSZ02NJ5uh+kQqxONO3aXjgw66nv2dh1cp+Cp
         h0AwpLKqfdx5Ks2YDh8Zc0aHRYUKz2ffPKYGywynylysP4Yf0Iz0b0Lb4KkG84AiCnIR
         8jlg==
X-Forwarded-Encrypted: i=1; AJvYcCWfT80FnW7WjCw3DCr5mrIrc8jmzfLiL0uicCKvsBJ90/NubvFodBmoPXIrDk05WYnJGvGoPmoojY/WUNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGmElXChUGsWRJAhnX5ieim5ywnHpyDikwQJi71uoz5M+vLzS
	ukEmAS0jS6enscmYEELUlGI2dj7hOrxi4Lf1IkN7wsE9VDL48EAxypYY
X-Gm-Gg: ASbGncs6ry+ZoPzYaGEZ/oQ7tykfusQIWuw7OoPXWPHKeJjTwzc0qlM46yrk7Gg4tTb
	AKzItOIsPbhfXs3sQKmg9UKmI9tofHokqXN6swXHwaYjXN0wwoHgUs2DgsnTZQWpbI09khFvueO
	KDL15EoCNbPSh2CzKYOuK+S2AveOBKf6sErRqv1ua4wmV5Z6h285Dt4heaPMsZDlaBKxWd3QO6q
	ERLbtyQwVfvJb0SN9G8uzFDWZxepLjfjxqa402bAFidMWXmPtNo5hqYqBhsI5q1j4BV8c3HvnE8
	+s3gPkcNtY61BLG/u31kwCJmzQJQBNDNwgh6A5xPhJiNDtQ55XQ1pTftQiKZlJKyY24RlPfJWR6
	Lru6We/OlMD8wulywqC4fZMhyaE3o49On5DMqg+Rn7iveDyBRRYkzUvZJyBGWs51Bfg==
X-Google-Smtp-Source: AGHT+IFkC90TrbmYWdFb8+Squ/yvNSbuyPw/2N1C/NN0bhPNNPcOuqO79tcCivw9Cvz+HmCkqLSG/w==
X-Received: by 2002:a17:902:d607:b0:269:8f2e:e38 with SMTP id d9443c01a7336-29027356528mr10234435ad.6.1759863322179;
        Tue, 07 Oct 2025 11:55:22 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:21 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com
Subject: [PATCH 0/8] Documentation/rtla: rename common_xxx.rst files to common_xxx.txt 
Date: Wed,  8 Oct 2025 00:24:49 +0530
Message-ID: <20251007185508.40908-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aOUMyGvkibvOV0IS@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a continuation of previous patch available at:
https://lore.kernel.org/linux-kernel-mentees/20251007083228.17319-1-krishnagopi487@gmail.com/

As suggested by Bagas Sanjaya, this series renames all common_*.rst
files under Documentation/tools/rtla to common_*.txt to maintain
consistency with common_options.txt and to avoid building them as
standalone documents, as they are intended to be included by other rtla
documents only.

Each patch renames one file and updates the corrosponding include
references.

Testing was done by running "make htmldocs" before and after the changes
to verify that no build errors were produced and that the rendered
output remained identical.

Gopi Krishna Menon (8):
  Documentation/rtla: rename common_appendix.rst to common_appendix.txt
  Documentation/rtla: rename common_hist_options.rst
  Documentation/rtla: rename common_osnoise_description.rst
  Documentation/rtla: rename common_timerlat_aa.rst
  Documentation/rtla: rename common_timerlat_description.rst
  Documentation/rtla: rename common_timerlat_options.rst
  Documentation/rtla: rename common_top_options.rst
  Documentation/rtla: rename common_osnoise_options.rst

 .../rtla/{common_appendix.rst => common_appendix.txt}  |  0
 ...common_hist_options.rst => common_hist_options.txt} |  0
 ..._description.rst => common_osnoise_description.txt} |  0
 ..._osnoise_options.rst => common_osnoise_options.txt} |  0
 .../{common_timerlat_aa.rst => common_timerlat_aa.txt} |  0
 ...description.rst => common_timerlat_description.txt} |  0
 ...imerlat_options.rst => common_timerlat_options.txt} |  0
 .../{common_top_options.rst => common_top_options.txt} |  0
 Documentation/tools/rtla/rtla-hwnoise.rst              |  6 +++---
 Documentation/tools/rtla/rtla-osnoise-hist.rst         |  8 ++++----
 Documentation/tools/rtla/rtla-osnoise-top.rst          |  8 ++++----
 Documentation/tools/rtla/rtla-osnoise.rst              |  4 ++--
 Documentation/tools/rtla/rtla-timerlat-hist.rst        | 10 +++++-----
 Documentation/tools/rtla/rtla-timerlat-top.rst         | 10 +++++-----
 Documentation/tools/rtla/rtla-timerlat.rst             |  4 ++--
 Documentation/tools/rtla/rtla.rst                      |  2 +-
 16 files changed, 26 insertions(+), 26 deletions(-)
 rename Documentation/tools/rtla/{common_appendix.rst => common_appendix.txt} (100%)
 rename Documentation/tools/rtla/{common_hist_options.rst => common_hist_options.txt} (100%)
 rename Documentation/tools/rtla/{common_osnoise_description.rst => common_osnoise_description.txt} (100%)
 rename Documentation/tools/rtla/{common_osnoise_options.rst => common_osnoise_options.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_aa.rst => common_timerlat_aa.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_description.rst => common_timerlat_description.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_options.rst => common_timerlat_options.txt} (100%)
 rename Documentation/tools/rtla/{common_top_options.rst => common_top_options.txt} (100%)

-- 
2.43.0


