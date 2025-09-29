Return-Path: <linux-kernel+bounces-835653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3512BA7B50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BB617ADA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D7E2727EE;
	Mon, 29 Sep 2025 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YqgwQruV"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58627056B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107885; cv=none; b=sv9ZPIpuTP+fXDFa4JpXXQiK4Nwrbs/0MRImsfEJvLJhj2glOQV8AysYVqKIvftEiTUH8CD3ufuBC/7epEQsGU4cFyORUk3wK6A4U92qqJZjcgM+9++M3tphED1SYMXffw27Ynxtu4JvS5ua/lE6WCxcuSemGEFcP9MQ4wZcNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107885; c=relaxed/simple;
	bh=9W8xPT3N53RvPHAnS9f5/QrLnT01yqAHq2ba0G88QkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjQw8ZKYh93WhP/cLEMjw4V02MfEkYnKLjODbFFEdlkidYzPwfVMlNUs+jiVijEetpOnWKsKHHw3TUKr/Dh5o8OTeBYgEqNBy8+9JibA240HSR0wLUTxT6MAYTNXr8/xQIFDFry8nSPlUMlYZ3TeiAE6HhszFQeZoTpiGfIPR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YqgwQruV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-85d5cd6fe9fso293012485a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107882; x=1759712682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7EcpRB2lXFP1cLCapL56dmZqGYeN55I/l6E6y0w+Pw=;
        b=YqgwQruV64DhTVuvvXUghhuaB+AJDi1BI1iuUcrVyWiMrPyXJEWs/dwlNUAnUN024w
         T6KBZc/EJHoBLkXs8WfudD9QpAUfnowBYAeQDRF3q+dM8PTTf0h4bOMwKFlOTOzw4WMf
         MfKHlrAwaY6i3poHdRRD2bUgIQcABCKGgCyY1ibV04dgNPuVvvvS5BBdskC6E4FXB6ky
         rKqmCnfvb+12cLzv78dlntY4PMfABHP1UIWjLoxffc3AAsgJn07ZCy/Bwj/jO7bP4kiH
         k3YTU5+2SnVTbnsZ5O98z8ZU+Mm7SWNeahppJ9z+3NLrVs9wuHaMhAaRWlEokvGsLr0Z
         /tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107882; x=1759712682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7EcpRB2lXFP1cLCapL56dmZqGYeN55I/l6E6y0w+Pw=;
        b=XGKER+xGlsMNYVC9B6D02BbJzvR1vM4gYS5XTNMuglylrmi622F+OFOenzFPd9jbnS
         Zj4VEMN8CRuQjhbS97NVGr7b6Z7DniBdlYho2eyyqWSx7ZZftsrS9XMpn6sNX1q2wp9v
         LX0ssKgoH20cK+0ayybUZ/EcEcnfj4UGCku0bMJfhvycVxrrxzzzzu7XP4a9ixMItzNf
         UMqUTZW3rJ4wz2xi+5W73paX6EcUcBOtBx+GeZW4Pv+7s8LMM+JUpNzan+7978n4Vlfr
         VqH3lx1vuM9dWNp/7mg3ImiM+OmZ9H4kpRlTdTKoPbn6BCWNFlNJjWp07KKgUzaX3/3a
         nj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVg/9cZHyj3zrJbCeNBqUk1yUw3tcQCV1tnGRNdupA9N46qO/KkL7GFmNjLgQd2aYyW6FdEiIg9CKRETZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmWPTwh4U3jzstcmli2Likg/q/0dqTEOdGsrs7EDBGt+hFwQx
	JLqYfx6qxwab90IpVGFtu0PDdVYBR96+06zIEviBRMyhoM3IvF2CEGdQUDSwNAlWqOE=
X-Gm-Gg: ASbGncs4pGEKm/RMgo9QXkBP5WHE9m/ysbd2Jut36WDlqw4gt/WtYF4ydzN5P0QbFgY
	ThgadiySRD3i2s9AqG20xyMj0k0kYFSBKpR+w0UsvdMMn/KYP1ToTFQZcyuxS3o/uZcRPTk763P
	VNXlLwyODJTCMl6Ai/ZHsTtIUa9fSS4nbwBdFetbVIiwDRVkzOxdiTsTr8xsj3BsIt/uRA7/lLF
	8NPiNJ8PhKgACTLFMaw3GXV9OsqB8OrXHQ460PxlO27pdf1Q52vhf1VIlfLM6O5UFWIKPFIk+Vr
	nlwChbn453kf6+xAnIfziMivOD53mbT/D9f13SvAx04OKku3AZ1i3qkxPtzSZZL45GzrIZrAYP+
	O+sNVAEYi1BAd5vOMS3vfmCjiy4ALU22ZZGSCyXs6mx/LpT71W7PzBc4wnyfZt8mVa1zwnM1pHn
	baCNC5HYn5VebID3g//A==
X-Google-Smtp-Source: AGHT+IFiLMT68nSMNgBaSuSlJ+JLaJj7OJOpOwM9krl/tnM9X12Z1SJwMWK8EaN96FbQ1GWCyUBDww==
X-Received: by 2002:a05:620a:294a:b0:864:48eb:34e with SMTP id af79cd13be357-86448eb08f9mr880925585a.55.1759107881875;
        Sun, 28 Sep 2025 18:04:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:41 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 20/30] MAINTAINERS: add liveupdate entry
Date: Mon, 29 Sep 2025 01:03:11 +0000
Message-ID: <20250929010321.3462457-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5c800ed4819..e99af6101d3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14431,6 +14431,18 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+F:	tools/testing/selftests/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.51.0.536.g15c5d4f767-goog


