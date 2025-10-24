Return-Path: <linux-kernel+bounces-869276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896FC077F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709E33BC489
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C196341AC3;
	Fri, 24 Oct 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AxcFCckc"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E431B118
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325630; cv=none; b=QOMMTqgDSDhev5l+2aXLOIwwGZrE8MRXDKNqanoSHiWPV9MRfrwR1szT3Vjwr+cybREbtC7fACv2kJ7iwGWodKoCWeShy6u1DjfBV3aIkeWME3fdKr5H6CNAWp7k7cGIA1acZupeFm3eov682c2MvJvG0UeMzipf+YDKTCWoMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325630; c=relaxed/simple;
	bh=SyDZ5xBAkTxxuQ5WwMLHgiaQYazJL4ofyL0i7i1gEYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWkKKrO1iwuVM0gkYMTKW3LwpSHBYuBgGP7+3m6DPZ3t6j9aM1ahZwL4Q2ez5D3N7hkyBUzTNmDLHvty+x/yi2UaX+gs52zsRT981dYH23LMFo5v9w3hElVodI0xZrcaW3ghoWaCkgecr094jHM15a7QTk5PdPUxpf0ffcyJ7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AxcFCckc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-472cbd003feso1422815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761325623; x=1761930423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7UV3etF9wjAI6A47jUoni1xrIP8wdMkkw9GdIsZjpk=;
        b=AxcFCckcBw6zC9Mb6ii0BckfvFTrBe10gxlzPMgVSctQE6CUiHjHAkO2QZQkK3xbLI
         FmB0EtpNr56xf8VJET8qOCrI+e4+yktDFLSL1SmnL77CbI1vo+jnvjKJNzEbKCxRrNGx
         JHoKJbwK+exCqsQGJ0T0HKuaV+ja7I21Dt4wyKpRA0bR7cPumapc/Gh7B9eZyjyEU+Bj
         WdiGAz3TWm3U6r9D9lrTPmM66iWkIpefHLrRdrMqRes5HTV7wFVqgImtTw0P/zCRnNii
         Y8k49I6X/+XtTc3HWHoLReRClKbqh7j9UtE1GijwMo5HW3WBvXwzJxU2SA6eVdNjFx9f
         EVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325623; x=1761930423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7UV3etF9wjAI6A47jUoni1xrIP8wdMkkw9GdIsZjpk=;
        b=fw3ktKjwlYnbmatJQmt4G5BnE8zCN5p5EZ7Kz0uQRDA06CEtMGo23hF7qc2GxxnsxC
         QzfDL4T9A6tzAjmuVIMLNNty06EnlW5+XF6sAhphgRuGcy+FkhZ8Gr2rRI88zmvxPoBP
         NPJH4PAq9GmzeQ47c2ALIo8WuAVdL2yLb4d84rbFncP4KUgv6A/jV3ja1dztwsL41x/D
         t9bSZu/sfQgcSXi84EE2TVdLPzsJvyxUwxY5RrBOsDSrvleTGNFz8S4uuvllj4V4PEJt
         1XlPjKrSdT2lwDvMeX5c6+vbHX+1du1zXD5J7/vP2LUepuJ95rGFWF81PvwkvUIvw2U/
         6p3g==
X-Forwarded-Encrypted: i=1; AJvYcCVmqZdltUtBPis0tvBkeF5jUmyiduql6NWZsui9gevbxkH7fyFsaRS7CZmBdjfuvqMcBWtZHJQETT736WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtLd3FMDT7NgCrEUhsAjPr1eBiIU+2CO6g+NRLvXiNAD5FsRu
	PxwLmiYhPW5Je0919JSJhK7Ig+/Xr+kfL+fz23/5LENvZy8/mt+MIR+B4TNS7dTrmpQ=
X-Gm-Gg: ASbGnctsaUz+lOEyswwnJITp+1k1jX6TsHi6xofnFEKpbqJXnjflUZd4hR8GEZR7Tnc
	iW6tKf2li5tgZaiRUTcRRgc0lMfPh2l1/gi0aj7D9sD6w0oYtQGfED9Sr+K/5Ehgz7bwXhOOy7U
	qnIYFKu+7iquqQeAPlShmHTxsYpn5gIeGSTtdY2sW+Sbrlv47B37ag42WM3uZkBS8zfW34x/rbJ
	zCyT0NiTXOLGCLGop3w9br1gDum0HO8vqgvVZyf2rRicfm8sSWkmxcwf0Ek/YOQGI1yPm4CE5qO
	ur7nhxRKuetCxcI5ekBuTMoX8mrjOtDyheiqWfY67oPtES8tDimBiDWffyuTA5HwB75t+BH3+Va
	n5EgxVUvckjNeqUDcGNj3foaNq6ebR3NGKP2k9ov9g6910gd1eqLKm2nUP2+Sp6zelF7vdurJgT
	NaE9a4MEK+D7Ur1Vei4hZv3UDkhsJEIZWVq8ilR0AnsogmW+JWSuIQvXkGU771YdiRnqmSYdph6
	Pz+Yg==
X-Google-Smtp-Source: AGHT+IHrQ5SsYuT3IiFX5jb0al/oludtwJa9eupe/AMuS0qb8s/e0+Ey2fu+7MGTVSShR/edgJxrjA==
X-Received: by 2002:a05:600c:350d:b0:46e:6778:c631 with SMTP id 5b1f17b1804b1-47494229fbbmr60195425e9.0.1761325622824;
        Fri, 24 Oct 2025 10:07:02 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429898adc81sm10193839f8f.26.2025.10.24.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:07:02 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 0/3] slab: switch away from the legacy param parser
Date: Fri, 24 Oct 2025 19:06:51 +0200
Message-ID: <cover.1761324765.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The handling of legacy __setup() parameters has some confusing quirks.
Instead of fixing them, convert the code to struct kerenel_param, which
is a saner API.

Note that parameters defined with core_param() and __core_param_cb() are
parsed early in start_kernel(). Do not confuse them with core_param_cb(),
which are processed at a later stage.

Petr Tesarik (3):
  slab: constify slab debug strings
  slab: convert setup_slub_debug() to use __core_param_cb()
  slab: use core_param for remaining command line parameters

 mm/slub.c | 87 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

-- 
2.51.0


