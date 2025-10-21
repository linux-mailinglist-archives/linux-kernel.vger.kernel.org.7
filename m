Return-Path: <linux-kernel+bounces-862584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE340BF5AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14963ABFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38532038D;
	Tue, 21 Oct 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUt+lBYj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273A145A1F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041175; cv=none; b=ddHwTb8018crcP1kQW33HeVm6t1jEASKIpKiKXipAfO/rOz2YwACMboFGVwEtlSODwLYEJIW7fKxEzimdYlgHUr3L9Jmeo+ccDgt6RdImwvVzeEHZiTB8hNaEcRJISy1A2NSS7v0ZaBC/0oLeZssnecWps+tLkVUMblJDIxyOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041175; c=relaxed/simple;
	bh=jZnvd2SSPenaSIMJOGYdj8IrSwzTgRjkn7pjex4HvXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJigmg1ZlQ/Hsl4mWwgIMg5BPfAVwOffnfGlD0HNvLUWdGd++3ZQK31lZePiZMxZ6hghP8x7YdmE/pRMvUP97wiZwUaijqcnA7gDllm8EkR+VycfOABk2yx0n2L+N2jJnHpTM01djm0uA9RuxenhCF/Itf13TlJ30UFpMsJiYGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUt+lBYj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5tRHSKB378wUj6DIWLwa+5I8dp/1qlo2CfW43riSIf8=;
	b=fUt+lBYjpvaIgBl2AgE1JQi23gG88sMvRhWcwTxiEokWVCUg/hyEj0UnQ/SCaZv3Fj244b
	I2fLynNiczRUeQ9u5UGtnfMXyPoPu7uk+wCklUYCgI/mnxxuxTxZDm+yIe+85AtQ7CFEV3
	t46IRtALSXvKwlxoTNAkfHO4XrItcI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-caYhzW18MtK29J_Bem4QjA-1; Tue, 21 Oct 2025 06:06:09 -0400
X-MC-Unique: caYhzW18MtK29J_Bem4QjA-1
X-Mimecast-MFC-AGG-ID: caYhzW18MtK29J_Bem4QjA_1761041169
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so6217834f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041168; x=1761645968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tRHSKB378wUj6DIWLwa+5I8dp/1qlo2CfW43riSIf8=;
        b=WbTNr6wj0+cEPCOQm7p+2aUk2pVVGM7bFsZVF6YUu7BFdyFu65HDUG3CMJnX+/fbXt
         EM9oXEAYZvrktzyAdChSadjJm1RbrTCLJv3Grv1TniDARZ1tlaxkc5i7NoHIAtah+WN1
         oFniaSInmzQ/lvFm6QzMxoPTBkuljAx33j+vDb1x7N308bqoLPfuCHN7kebVV7EMhiar
         symI+1hwCHDm9zkeYWtzgp0SPRnrih5p/UJb8o8ITM5HI2QdcJKchgimJYqcpgexIeh+
         ZF1bgRRbejibCd/hxy+cevOVHt0nOpa7FjbsgTKZuoRcIZ3gPAp7x67P9i4Tpg9XAyLD
         wOlg==
X-Gm-Message-State: AOJu0YzAGCo9piT2+FdrI2ig15yhZ1SKV5ELzw5+uSdRrs6nAwiDdxOj
	xgJl0jLpC3kLyGoMYCeIvkkzaxlDRzF9ymrEF3khRbF6jlaWxCWK/AgZWs18/PXd6f9xdO+MLdD
	P99AZVMXRydHg8hAxMQj2jUcxu7Y522Pzag8vLPz9Y3VK8SgNNKt2vDudigriryHTM4smt6db5y
	gBnuy4IjTwQrc3FOJtOCjHUdMBGjjZc4Vg5s2yj5nQ89b0Ig==
X-Gm-Gg: ASbGncuWQPvgh+1deGtwSPmxKUPkSlOPe91sAHGS/UMXRZaKctBRILdOQONWRNUChlM
	VvnADwdBZvwQcwAoHeD9MIP+RVyoqGyAItBFQF5TYPfBmUDRUkpxRcXDP9v2zP8D86nGDMwD2uY
	pBreD+pjtpWRzSFE7/ObRL6CkQCmbF1MAcIHgujeiTV5llkhVlbb3tyL0urcSlNxE1ETPJTejwE
	Od4Sjfs+JJyyQTZFm17kaY2zJucZTyCTyidxHbCmck7TSKGtR02jASwzLZCnZ8W4hAYYtKpwuSw
	NG/Oa4ZYqU0F/rAzcjwLbjNa9WhvKO3kngF049hjqYkXIey1tU5xX640XTPT1oB08xhB2n4Ninu
	qQDuYgpPmUaa75nd+PEWUonDbkbuiTJBZJ2DpE3smdF6JRe9WGoEqe5/0Au1J
X-Received: by 2002:a05:6000:25ee:b0:427:697:c2db with SMTP id ffacd0b85a97d-4270697c302mr9342471f8f.20.1761041168598;
        Tue, 21 Oct 2025 03:06:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEInIXj3wBV2ru8CJ8e9i4dsSkU7c375jECkW1lOIjIo9JaHXcLWvinfDrHj+KGluxpyRnWdg==
X-Received: by 2002:a05:6000:25ee:b0:427:697:c2db with SMTP id ffacd0b85a97d-4270697c302mr9342440f8f.20.1761041168078;
        Tue, 21 Oct 2025 03:06:08 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-471144b5c91sm272072255e9.11.2025.10.21.03.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:06:07 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 0/2] powerpc/pseries/cmm: two smaller fixes
Date: Tue, 21 Oct 2025 12:06:04 +0200
Message-ID: <20251021100606.148294-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two smaller fixes identified while doing a bigger rework.

Compile-tested only as I don't have an easy way to test right now.

I would prefer for these patches to go through the MM tree as I will
be sending out a bigger version soon that is based on this series --
I split of the fixes from the other stuff.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>

David Hildenbrand (2):
  powerpc/pseries/cmm: call balloon_devinfo_init() also without
    CONFIG_BALLOON_COMPACTION
  powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages

 arch/powerpc/platforms/pseries/cmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 8841ba63f874d5dc05fc4beb47788406be96fd5c
-- 
2.51.0


