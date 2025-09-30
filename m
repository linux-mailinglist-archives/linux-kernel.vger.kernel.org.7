Return-Path: <linux-kernel+bounces-836963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E87BAAFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90811189DCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2D221FC7;
	Tue, 30 Sep 2025 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAtCxRmO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36721CC4B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199232; cv=none; b=nnuLoFQItZukAk+SZNvDg6DDFjmCNGrv38oHgWfw5xJApmsDS2zImxVYXRqrVHJ1BLSpAIGf0qxC+tDAC75v+AqBei4nSHzTtAGaqw7CdG0/uxx82gwHEMVjHu+QBdXD0foONYzFgD+y3X4ER/MKQYTclS0TYN29LgzHICL1Dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199232; c=relaxed/simple;
	bh=Lsy1EfnzyO0CBijxsBMmFHw4zdAL6NpN8K8QOCc72YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7koQu9p7ZDuMH1odVBak3Uy0/BAeDatriVZHrbDI22Bhbf6oKRLPMfFzHCcFCxRPXqiSHgvVyfCN1/WLPVxlKEPwUFFu1b/fJ6R9rjqkus4QUu78de9FMS9O5hoyClkee5mLiPKDft5ZthjZFMXBfR0mq5b4zsETYqjF6bg/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAtCxRmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759199229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9PxpAte8R5b+6XB/Vocei7ItJ6+uCKlMHpeePkzmeU=;
	b=QAtCxRmOCfjMmYrXjd2jVksWMwZLCg1Sfv9jDYqF0rXB6ore2ktM4BesEYkbGd7PYxmPBh
	Q7iaZePFxvbGEmz314cOH3H6sajVi5j6QtUUX3FEdEaYBBLa2Vd4q/50Cl+Y95anas3IdT
	Pd1h/YGRX9q1sOKlQOkGMm5hUOcdw9Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-xvdpAYGlPz65fyZaVVuZLA-1; Mon, 29 Sep 2025 22:27:08 -0400
X-MC-Unique: xvdpAYGlPz65fyZaVVuZLA-1
X-Mimecast-MFC-AGG-ID: xvdpAYGlPz65fyZaVVuZLA_1759199227
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ea7fcddd8so10814118a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199227; x=1759804027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9PxpAte8R5b+6XB/Vocei7ItJ6+uCKlMHpeePkzmeU=;
        b=LyZvasiKofxfUywxHSPZZhmmlmj58EZRze4UNIwrHtRmMQsS/6DgNwo/GVlDGU4NFq
         KKUZw/XxTFBKh+FxZhv4XxBr+z+Cho6NoneCC7xEhmKkhb1fleHET6QpWwBZqbmtCG8v
         GWkMLrYYfYMcID/hMmJ6I+7L2EiiyC3ZiTpm1ebiF2lvTtJtNTYFoOHUNgMK6PpCFbqO
         B830q3HBqQoKhXJw0ijQjBOGHniG4a/RVtXFg+h0lj1+h51vHdvWBwClv/MUFyzOX88U
         vNH0HVHIvqwVJMH+U7HcKblOK/Ee6iVKHeS37roQf1P67peqjuF8TPgqpNWTUVrRrVLa
         EGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1kl1nDNPMVUcp43kM4UH/wndXK/70X4aPaFBds3RKN1C/erBbPgeECo3YARp7wxWii90s5C0eoTzAvZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5+tFIHJDvJmKEHo0s9dZa3YtsWSBAtkOgHyRjL1Sw8Uwhqcn
	zBmBuvEUj6aKPSEIveawRcfyadZp/e44CFQoBoyvZZyIY1gE40zJCKxHfZoA8AmEG53g7zWZFpz
	MFCQ0LHbkkOy61eC86lGRWEPmIa0LboIfS8vBnhrwMIdv5GJsivqHnrBdMPKpPP/tBuXO2HxjI3
	IJ
X-Gm-Gg: ASbGncsSVJ2sfuqXwa5n6LbGqdkOeO3iLMxP1KGDN1TqaDSLT5HQaFLdAMFvlfHUsyS
	NUajJ4FclcFFPq4Ka08pe1BellLC99GCE5Wx23QBBKIbht1whfe39pVJSABQ0P5R8r6IMCyu5Qy
	7hfVqgPFRMpxO06/VaLYeVhixvcOBW5wCfUhqD81RV5+1KW3tDLjs2zocnj92G6d/XEGiHZQZzU
	6pSLPWse2aIkP453ON9Rn7d2g5er3RKoPYuLCBu7w6grqvTAMTvFgZPVyY39xDDgpFNnmS6ODbl
	3XSW5Edff374N578muG9OPDCnt5gmOT5a6ni
X-Received: by 2002:a17:90b:3b4f:b0:330:6d5e:f17b with SMTP id 98e67ed59e1d1-3342a2ab8c5mr21107561a91.21.1759199226676;
        Mon, 29 Sep 2025 19:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqT2WISEHZgxCaw7vrR75/tCyagm44J9wKFkRkbX3gbIioJ5YpqGHoSzaLt/LIIa3JwJBSpA==
X-Received: by 2002:a17:90b:3b4f:b0:330:6d5e:f17b with SMTP id 98e67ed59e1d1-3342a2ab8c5mr21107536a91.21.1759199226315;
        Mon, 29 Sep 2025 19:27:06 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm12285975a12.13.2025.09.29.19.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:27:06 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] ima: Add code comments to explain IMA iint cache atomic_flags
Date: Tue, 30 Sep 2025 10:26:57 +0800
Message-ID: <20250930022658.4033410-2-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.4033410-1-coxu@redhat.com>
References: <20250930022658.4033410-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explain these atomic flags to improve code readability. For example, the
flag IMA_DIGSIG is to indicate we mustn't update a file's security.ima
on close because the file already has IMA signature. The code comments
for the first three flags come from commit 0d73a55208e9 ("ima:
re-introduce own integrity cache lock") with a minor tweak.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/ima/ima.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..2130d3764f6a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -176,7 +176,32 @@ struct ima_kexec_hdr {
 				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
 				 IMA_CREDS_APPRAISED)
 
-/* IMA iint cache atomic_flags */
+/*
+ * IMA iint cache atomic_flags
+ *
+ * IMA_CHANGE_ATTR - indicates that chATTR() was called (chmod, chown, chgrp)
+ * and file attributes have changed. On file open, it causes IMA to clear
+ * iint->flags to re-evaluate policy and perform IMA functions again.
+ *
+ * IMA_CHANGE_XATTR - indicates that setxattr or removexattr was called and
+ * extended attributes have changed. On file open, it causes IMA to clear
+ * iint->flags IMA_DONE_MASK to re-appraise.
+ *
+ * IMA_UPDATE_XATTR - indicates that security.ima needs to be updated. It is
+ * cleared if file policy changes and no update is needed.
+ *
+ * IMA_DIGSIG - indicates that file security.ima has signature and file
+ * security.ima must not update on file close.
+ *
+ * IMA_MAY_EMIT_TOMTOU - indicates to add Time-of-Measure-Time-of-Use (ToMToU)
+ * integrity violation (a file, that is already opened for read, is opened for
+ * write) to measurement list and to also emit audit message.
+ *
+ * IMA_EMITTED_OPENWRITERS - indicates to add open-writers integrity violations
+ * integrity violation (a file, that is already opened for write, is opened for
+ * read) to measurement list and to also emit audit message.
+ *
+ */
 #define IMA_CHANGE_XATTR	0
 #define IMA_UPDATE_XATTR	1
 #define IMA_CHANGE_ATTR		2
-- 
2.51.0


