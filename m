Return-Path: <linux-kernel+bounces-894020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69166C4918C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 460164E4CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8FC33A02F;
	Mon, 10 Nov 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bmtp8f3i"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11F337112
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803409; cv=none; b=KUSg1oFsAo8Ld5ZGtU8PyHGSLmUIQYoU6ytvRQG4JCUQzBMbH3Q+a2RvsjWx2xexcDfw+/mwJYgfHz/QlobVWDsiTmaPT/oG6Pl9c3Z/t+bi2/9IFC+tujiWEyPxuE7l0axPthMpdwwp5vcJAwKaxiJRo6Dl/qpuRYmhhigLObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803409; c=relaxed/simple;
	bh=W7QWppO42nNFunrHW0x5wrq6A32TuLyhp6ZUGiac+bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=airWJlPPfY2FerQeUtz9B39knV/Co2GCK2x9RsofDKI563wHAdUh4wHF0fLwrIMKOYZRqFIxDHO/jWnjYnTFRu/xn3t37wiKNlr44pWoVOc8T8qQjfE24dw2VS5w44QV0YdeD8CnaBMQ42/h3mIiRsf19ddFR0OTMUDeN0pRoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bmtp8f3i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632d45c9so23241695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762803406; x=1763408206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTWCP6bTspm09Lx1U+q7f0BGQls8hOwZj+qwEbwY0Hk=;
        b=Bmtp8f3ihF437cwFJkONx0B0z3nb9BTfIdUZ/AhBRg7D7HpbJAv5crsHZjdQXgOeAA
         MiFifiCKwN691N/naK0GgAf+AEX0SW8TkBtumqkTk8VUPVmu0BN8Ek6bfoUEl2NOvZwZ
         1+vbmjJKUbZCPhIzuIbZ5Z8doWYwBNLaWWwHRpBXfzVE0nozaesXeNoOMOQ/dfcCGdAn
         ijV0M8LOn8zJa63WmV73roZn01oCXnFN9Z8DAmAecfsEfikoWLPGdyJFMbDNcmdXEigD
         1AZOAKeAvKjuklN3446J4X7w7SxVqIqKfSaX0rA0DiJ0QU6uTUv+Py4lNw0p8PgErjQe
         4+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803406; x=1763408206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTWCP6bTspm09Lx1U+q7f0BGQls8hOwZj+qwEbwY0Hk=;
        b=kVQYT2QbATy7MyjC+vc89YaVC1syhErhhZiq3p0AVyuH4rVe4TORjzI3ErjKbZ/bPY
         tzjbaBNU1tuIyfTBl/Or3+QZULSOv/IJ3Bgd9xvpLenKRk09Ywb67HRLkWavgihDjRST
         eTgsUm9t4vSrl9Yq7f6eWUbr9m+g5+kOCO2lXe4IqNms7AcePsyvwOuPEtUCcjsZjhpQ
         fjkr+iXNe9iEZ1MPbC767krxshU+qUIYdyBOXJRTI+DIIAeCbFFJ4P1OOTt0WR9xO1fi
         IkqACGmVQniiHLrXUQAaEL/5CXdPDj2+N4fPHxjm6qVpFc9cLVM7iubW5CSADzYKiS9T
         DxPw==
X-Forwarded-Encrypted: i=1; AJvYcCULUnRGF8HFDGdns+D0ogtw0EYsTaA8HkG36fe6CvS0PH75r0PZuZDIdr0YWUXXjuuA5o/X1u7Vy8gkr+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6lnZN/SVcbOikEHsNTtEsspR6EqZYq7Y2mnP+orqwWBpiVj6
	uhAFlAALuNzggnJ01LmgGUGS7IiZHTm6N3U4sPqRvjoFkrCp1CzA1RDD3CdpTg+e/os=
X-Gm-Gg: ASbGncuNkmtGtqTaDHE1rvd8LiefYxHg559LJ7n0cSkpX3L4Z54pqK4dBGbCG7vHqJH
	o+0DddtGMG7hhamjXc+f6EOA7MbbJfPBk7ID/sPhDMx0ub3Xe2X9yaG2Dwmf1v9Y5+6+93HVhV9
	De0cDWixhJSWAeHXtTczMZHV/cwySuP3c2IRpc7FFI8KqnOFPdnwIeMTBBzQdIqvC2P/x1FZDmW
	dqhnKPHbdkeB/sUkBhxv7ksotMacFiJ2AwfNuER3K3Xpwl3/i9vWWoGjpMPUCvQyzZvMmMDZ1yh
	vUcpQwnAx6EDBausjhSp90kiomm4FUoxKi5CBAg/x0PY7Qin4AtjBZmEI9UB341qr9kxpTiQk/E
	ufucbpJaYWi7K3oqXV3xZnVMK1Wd4IUDrK+Lf2Qm0Cxo1li6TG1sbU9aRcIgJs0zKnbxq7o8mbB
	UW2e8EUV0MDGobjdUFaD4X89jUwkZ/frY=
X-Google-Smtp-Source: AGHT+IFUxtkfJc5KA5FIRPDpNTMLzR7n8nqQXez/mScawaL2NDNh5hWWSSs2Qhhirt5MIsnvEx4uwA==
X-Received: by 2002:a05:600c:46d0:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4777327b249mr88103205e9.27.1762803405768;
        Mon, 10 Nov 2025 11:36:45 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm336766725e9.13.2025.11.10.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:36:45 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RESEND 2/3] docs: cgroup: Note about sibling relative reclaim protection
Date: Mon, 10 Nov 2025 20:36:34 +0100
Message-ID: <20251110193638.623208-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110193638.623208-1-mkoutny@suse.com>
References: <20251110193638.623208-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index a6def773a3072..be3d805a929ef 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1952,6 +1952,10 @@ targets ancestors of A, the effective protection of B is capped by the
 protection value configured for A (and any other intermediate ancestors between
 A and the target).
 
+To express indifference about relative sibling protection, it is suggested to
+use memory_recursiveprot. Configuring all descendants of a parent with finite
+protection to "max" works but it may unnecessarily skew memory.events:low
+field.
 
 Memory Ownership
 ~~~~~~~~~~~~~~~~
-- 
2.51.1


