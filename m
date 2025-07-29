Return-Path: <linux-kernel+bounces-749092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C015B149FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BAA18A3343
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC1527FD7D;
	Tue, 29 Jul 2025 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vn8bNIqH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D527FB32
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777121; cv=none; b=gaq78O29EnBbuBhyCYpI5sCuWBbF2QlnTVykDVDqnDSu/EhTuP86nsWzDjedWFA8Mmetsk8ki+YejA0JWPblcxd6ZktB5kvk7gCRkah4RhC0dPDzfWU68s+sUFUg7IOFqjMdyecEN8dQGEVGU2ZdRkhpNQLccsl6Kg1OztJ6EbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777121; c=relaxed/simple;
	bh=UZRpI5AkJvKGGjygW0afWeDkE6V0mQDpeXnOzcKOa6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/W3C9OKovfjqR3pGIeAoD8XKe5oRR+EJKjqeMAxEpBYCS1nZJphLCl3L1+QrN/ivboNnOvHsEjqsopcV9a9nlQL6CUI1Gc5Yzr1Pcc2p52oJ0Q7NS3uaOF6xqx6iOvGIHq5XSJc95b8Ug4XOei/hNqbodZ4vIZmttlcBTPaeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vn8bNIqH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b791736d12so226023f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753777118; x=1754381918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbM9+rFR6RKKN14z7dnuo56Lm9Y4Jzf2iH/S0S+BH7k=;
        b=Vn8bNIqHnlvN6eOmK7XWCQLZwRNohVPw86+/99EJXRcSnkI6sAxcx94q+gJe+TMy/7
         G0ej0rLl3SO7q8vPzWVc9LDDzlKc1gqYSIwqruFihzGk8KcgxEAW2QOP55wfJeHNB0YB
         eYI1+dZbapI9c9EUWF6Q16IqA87fHf5wwFZkya8S2akxY0xNxUPq+ZEF6bFu4W1BYwN+
         WUAhM1uGNJNupUhKOoDVxOyLJALn9NWfeEpkNseOxtF7Ybw5IqfVsFqF3cDZkfFXJPTi
         Tu1XIFvlLhjOgtxFjriqtNT+35WRIUPaD+Of7ukrR+soSkSk4WRyEDU8Esr7Rke0Wzby
         LyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753777118; x=1754381918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbM9+rFR6RKKN14z7dnuo56Lm9Y4Jzf2iH/S0S+BH7k=;
        b=hiJfhoe5LZSVbfQLOt86LNIPIQsJGHO2kJ4IDEgw9mcWcYBjCPEO9Vql+76MMVfBt3
         AqzZxAR2DsEf8AAJwJlBI/GbC4kfyivjj5cuMOlxYeynyfiaMatTjD11YFf/qSTBOaa6
         Nni3p9WnCAD4aljnbRsXX+FRDqRo5YChQlPYPFxCri/3SkvgPAuy1so4D0QCJCPaUw3m
         4L2gi++9NvFhkCK06+K16WDBAr9zDbgtaKF904E9jssaeT5lzwRQqohtaU0StBshlloi
         vVQoUl1jt/FNEXSrTx38PLGtU4coEJpORyY3lhWD7iz9n7g6+hbjkuButpfDagAQ6qp/
         eA+g==
X-Gm-Message-State: AOJu0Yz/LvK2nVs2fh1ExHChihuavIZkiO4T6plnSacEhQ5o8Jn3dHXX
	jJjXDFt6Ce4j3IBFDPIpj72a29Gk+7lAIIeF+NxUtlpJ7qcL1cvheyyUn+wCX6TKXGvft/DILFO
	br4RHnss=
X-Gm-Gg: ASbGncsCuVQXnXttao/DuT8cn1ZnQI69aYwfm1xIIjNJX2YvbuAj90GDha4EPF9c939
	hXjl+X0pqDsfKSbfvTZhvxf+OXTrDQ0qv3RKDJ58sZT0ytPwtgliqIS11fYeK4qC9cFG9DuPPM4
	MxRYp935/GOnnsAaBZElh3VL7QrsF/mvoHzTC4MvPOE2rX4KpZ/FjhmXnkBfHf+TSzgsTysH3sX
	iL76l6WMBw7OKY7L8pVA9zBDMk/OPuugRy9WKXt1mRwI4YnXqwegbQgjGGLyBoeDfgdNioMmrp5
	I4fpGRwWtSnLZ0Za8Y0mhoP79ajZT3jReAH6oxrtKaSkgpGpzAdP+QYjp377aStS/xE3WLPh6qV
	VQA2m5QP36fuiMEG2n+aj0g==
X-Google-Smtp-Source: AGHT+IEcikUqrt4av5FNGoq4z5jzXnR71hHGN4VxzXV5XwAq9Jh8gPqZqSpWanzusq68oBoefyRqsA==
X-Received: by 2002:a05:6000:4308:b0:3b7:87be:d9d8 with SMTP id ffacd0b85a97d-3b787bedf1emr7188827f8f.43.1753777117730;
        Tue, 29 Jul 2025 01:18:37 -0700 (PDT)
Received: from localhost ([2401:e180:88a2:4c10:c47b:26d3:8f9b:63])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23fbe4fc7a4sm71361185ad.120.2025.07.29.01.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 01:18:37 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	cve@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Jo=C3=A3o=20P=C3=B3voas?= <joao.povoas@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH vulns 3/3] add a .vulnerable id for CVE-2023-52920
Date: Tue, 29 Jul 2025 16:18:24 +0800
Message-ID: <20250729081824.85105-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729081824.85105-1-shung-hsi.yu@suse.com>
References: <20250729081824.85105-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is not necessarily where the issues were actually
introduced, but given backtracking is required for BPF verifier to be
mislead to prune an unsafe execution path, this is a lower barrier to
denote that no older versions can be affected.

Cc: Tao Lyu <tao.lyu@epfl.ch>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 cve/published/2023/CVE-2023-52920.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2023/CVE-2023-52920.vulnerable

diff --git a/cve/published/2023/CVE-2023-52920.vulnerable b/cve/published/2023/CVE-2023-52920.vulnerable
new file mode 100644
index 000000000..bc723ccd5
--- /dev/null
+++ b/cve/published/2023/CVE-2023-52920.vulnerable
@@ -0,0 +1 @@
+b5dc0163d8fd78e64a7e21f309cf932fda34353e
-- 
2.50.1


