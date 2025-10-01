Return-Path: <linux-kernel+bounces-838438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698FBAF2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631A61C7B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B42D949C;
	Wed,  1 Oct 2025 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WEmC3XDz"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D02D8DA6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299045; cv=none; b=bKWjwHCQJ5gL0okfP7+ZyGVW387mzqnf/RQpgSi67CYiAr5r9Brx6Soj/iKynJBOmQrR0n1s8otffpRflYswtFHadk5/z/pq/xmMMWDWc62nAQWFoLajvbmczWAfvcBXOXeXZEdmuNtu6JqeLreQfAyzgu1/KfO11usEhz/D3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299045; c=relaxed/simple;
	bh=dd8tAMAvunlHBs2TbfV6XdzIsVPgnLl/i4lwLZiiVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ss6uREHt2oKhmqBBZOgemvaTAClUvdbpw/ykkrllJkUq/MnwGxsYRrUK42Ehi3VyWMJzB0ICYOG4uXgWtS8on/udNVqO+VuXVzogbddKWLeJMjiB7VQxDavEkUrPGw/YeVwVtNqzbaRfolPdDYRvQ8O+Kt0R992ipAcaEQXEWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WEmC3XDz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3ae239cfc0so60651266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759299042; x=1759903842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96lBuGyGNqGdmWvV/PJjpenC1fPHuudOMddkc9JukfQ=;
        b=WEmC3XDzfBuZJ32BHtahV8bpQI4iqkdQXPau8DKG4pVQzpgCGCTV8+VQkxELZ0x7GP
         RJ0WHocK6+20a6LkOtV3uJPv1KcMXV1fi94VX6z0yA4OzbKBgzl1gfHIfQg3HthCje0u
         csadRUj3cLQyBg+aKmjZI4g42h496IH7vaSNkCmR9dxTpJIkvi74Z//hmapMXyeZtugw
         QZ622bltb9fraYQ32pcK5pVJhDToUEBZUNC5a9cxvyp16puZDFxnX9IgKzqdnWHsn0zf
         eUpXrWMYDuF4DWZ273eM26TcqKZpCaHpMSdZJLxwky+9aTQ7wrd79KLKAbPtKeA59n71
         9KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299042; x=1759903842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96lBuGyGNqGdmWvV/PJjpenC1fPHuudOMddkc9JukfQ=;
        b=AyauD7+c03Tyh+Y6D9+eBfqTU8sr/0+bSG0B48WhLvMhn5M77LdCF2qxGeVO9q/OwN
         mRUiPB6XNN/wcqFKNgYkMav1NSweXacMj5alG+PyS5U1OBLMdK6C+w2Yii3Ia2vivMQ0
         jQR/vqB+LxojBrzuzU81M429qlgLJcl9eilBd+Lj2SFpJ7VXtKv7O0QkGpuP1OWfKCzP
         W1iZUMIntevJxE49V7lsoObaEkUxDvcER90Gk5h9P1johSwggMR033drFYn95WlTFV6Y
         6h2u3fU93bR8ap0InD4jhnwtdFH7+p2c0PE0y8dySJx5UjY8vZunm6RQ3eEgMC092jjN
         Eg/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSwcV6PpRsaeF2eQ/GFa3ermKfAqK5ECcw0nCdMfbnn4oXsHnSFGbIDoMVvMucmmhYvDC1ZV6xrxC9z+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+i2vbx1o5gNXd2Qyqoqei7L59kH0VHfCV4vjujAt6eHEoqajf
	2ksbgKlgYMc/fN5kqTDTU8Vn50TnqGybfVMIm0dJwzFZfeXAlVHKiZAIBER7my906zc=
X-Gm-Gg: ASbGncvt+pzkZyCB4gvTAYaHfM9pcI2dXOzge0zH8dYAnrVk7BYcScZO/Ke0kuMHnLT
	loujU37ihnShdGbgFuzFvRATiypz1NVxZRE9VhrQzTFfcQLyOCl4+7VvvRmKY7meCncUog9vobK
	B09+j+3EIfa5IMFKweiQDjDuZwHXJEfVJJyS+CjGQPq88ZQW+uUDleoXilMSofXctEypBsnzdP3
	BHa0EqkPieXZo3uSuXNu3XH602zJpXJ3GPCqarBe2DDtPXs/uQ9jP3Z9xtYrvmcqpPgZeILBXIt
	oXOGjJStIFE9zKSe5gigRha39lASWjBxIuomRBoKlWQyH3Lyjj9UXray66G3DbBVm8zCduB1vMF
	C3BKk+8ZxUTL45vJGJUFHWM/baM94/10DKRpO9+dyM3upZIU9kq3JyoENmtnloGrSspzHWeHZBI
	aOpaLkyfCGcJLpX54MF6Ukj6kWM1gaATfpKjoYWQ==
X-Google-Smtp-Source: AGHT+IHt6fDP7kqpTGubIfHOuw2BR4PvD5qV97YMPv7HNHGrcP6MVN59nJX/Qk5316ImtAkfWPzuaQ==
X-Received: by 2002:a17:907:868a:b0:b41:1160:a3ef with SMTP id a640c23a62f3a-b46eb7aa04cmr150622166b.10.1759299041854;
        Tue, 30 Sep 2025 23:10:41 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353efa46b2sm1288658966b.24.2025.09.30.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:10:41 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] dma-mapping: fix direction in dma_alloc direction traces
Date: Wed,  1 Oct 2025 08:10:28 +0200
Message-ID: <20251001061028.412258-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set __entry->dir to the actual "dir" parameter of all trace events
in dma_alloc_class. This struct member was left uninitialized by
mistake.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
---
 include/trace/events/dma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index d8ddc27b6a7c8..945fcbaae77e9 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
 		__entry->flags = flags;
+		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
 
-- 
2.51.0


