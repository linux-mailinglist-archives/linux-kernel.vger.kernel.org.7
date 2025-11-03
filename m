Return-Path: <linux-kernel+bounces-882442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24309C2A7C7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696303B77CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F72D46C0;
	Mon,  3 Nov 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAOGKR/h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rElu7QUp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9622D3ECF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156798; cv=none; b=YPtQ870/o+7d8fdUGVEs2fk9XvZOqbRqedTyDREyL44HA73ASNrV3b0XHDXKeVQVmWprf18FwQfC9nnRRyWyDBYQahANfV7dDQr8e09exn9TpuE6rihe/MJrPCjVWP1nEIHcG/DN0ZYr2YCfWe0njieue3Cb5hzHL3y5kW/ghU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156798; c=relaxed/simple;
	bh=IszVnDCPm0bboeFG4KrxgTH5HC9Vm0rG9lgMcCpXRTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syuU/gCkkG7R0jf1cRdBI8k3QzxNSLekvTrA7UTnd8brwn4KwLTemb+6DkqxBIENMz59v0FUwgkKZBhfEOovaGDDDAkLiG9jyZ78/VNik2zpiSXn3eF/HaKK9RQdikpHJUPhZbPX3AwoDELhn+rS+MfRFZqY1TmFqz8RErbPTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAOGKR/h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rElu7QUp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762156794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Ng1Pwu6FSvlmYcO+fW7tQgV+r8RIUxL6Vl3k5g+WGE=;
	b=AAOGKR/hnC3si2yqySHUvQZOIrjT9n/yteU0gJip4NXjyK7BG8fQkADnobzSImBifzgUQ5
	xR2c3gl3dzYS2thnRIJglZcTA7RwTl4YUJMzu1HoBU2d3vl4KOvmrRsUWgTqT/yaZi3G/N
	8QitM2WyT/gUj505v2QL3KQhSlIcSYI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-riOW-YZbO1iFlIuCZRfItQ-1; Mon, 03 Nov 2025 02:59:53 -0500
X-MC-Unique: riOW-YZbO1iFlIuCZRfItQ-1
X-Mimecast-MFC-AGG-ID: riOW-YZbO1iFlIuCZRfItQ_1762156792
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64097bef0e2so1889824a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762156792; x=1762761592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ng1Pwu6FSvlmYcO+fW7tQgV+r8RIUxL6Vl3k5g+WGE=;
        b=rElu7QUp8TqVy93pBeC1ARbNAPsj7jt7Fb+sRKoqZCd/Js80GcFbRezYmpfC7PmnG1
         oVyBpJCxZ66BXFa22KxQpYiWil0WrIivhSkm2hC0Wbec1zwmCFBOFo1bF78Gof2gsf6C
         gaZcQ6dZ+f0xV27GUSXihR5M0QpOmr5IhDirEuqaFwhZl/RdGwrNNe1m832c+dY4ODuD
         0BUWPDc3ykvRdX9nSx0Rr7JH8+kKogLGNhSuxnHnMYcpWkLoBBSu2XOSTBPtNj48a6nt
         eeA8Ciy93yBwB3Lgay4tcqUzArpiSpdcbnIDOxrZR7v0jM0VpLtSdUaJOqQGyKxbC9Wv
         2moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156792; x=1762761592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ng1Pwu6FSvlmYcO+fW7tQgV+r8RIUxL6Vl3k5g+WGE=;
        b=gpYZp2QPlQ97XENVFbBT1min09tlhew1pwGLLS9qEEcJywZZlmjOml8UwZbofe/vxS
         Azo9Ahrtlf1OrwwYHE9DVezTjmv6FkDEqSAPztKcxwtk+fyJX573EJe6rqnOCSJis0FB
         U0B9u8pZKh9LEwmcbngQx3cohyxb1TxTJ567dMvc5vUupQU6X4XfW9INAVpJgEsiGMMY
         fH6BN/k94GNwtpM58yAb9MIH3tznr6Vdq7AGVoPqyvrQzStAwszBtik49nd4BaSvnR9L
         dfJqzlhsB7DX8Ey9f8jgU2W8tcR7Wg8VhUIvU/5zP5OLEAvyqgLkaIOXf73t1HKwWnki
         wIgw==
X-Forwarded-Encrypted: i=1; AJvYcCUT9/05ki2g13987MrepXlW+USaepzM+QoiYX+HnLtI5DHTed1AWH3SCbZQHgQ5/wptQUApPaWGrd8XpwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6FETxjb7GOqSamU8ICPUJASAdnAc+qYBsszLCGi40me/crYPR
	No0WgLFqd/qrrAoFjt0Efqdf1J14oos8R0PEvT+Kk6keaygzg8Wy2PbyoGbEG7iG2v69fwd8tCv
	MWZ46W7+TUXbPPRd2Ki9LQME04HObSWjAlVBiE4iG5A0Dmei67j8E2rWTBRUcyapvXw==
X-Gm-Gg: ASbGncvBKUGjdHO7p7dolv+3HsDMdmyMJjaYzUuUphglTseNKyPDKVVEZZHJefuHNU2
	ht9wnX7n+AtwxooCo062HzSjtKOJglFjRsity6NWnSrTm9OM19M+E2pwYZbGlnackduYL5mkczg
	p7RC8/oJl/yvTrWK5HBUQXTmjOlu29M+ZDj/TdLXkyEYAVdYBGBIn84tweaaGtzipmbAES5x8mM
	3Y92pPLA8xK3Pyn9nCilgRENouzMuVO+esxCtFg7CutG8qvZxEmI3DwOmNbAlXwvZSZ2hw4gq53
	DXURMcfS/gNjObrody1YI6GRYY+hmlf6mt9kiXDRN8IQRrDh5243UF6PkOBscFfgDq6lXLCgvFA
	jhGF2Ct6CubHfIOlwUgkoxmFgY2+dFAqyvbdYIoXrOYxHngzT
X-Received: by 2002:a17:907:6d1b:b0:b43:3dcf:b6c3 with SMTP id a640c23a62f3a-b707062eca7mr1059165666b.49.1762156792464;
        Sun, 02 Nov 2025 23:59:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEei0TEbbcqaHv2/H5u75E6cBldBAuSc4DG6tLxuw9RodARfK8Z6AgTqtkQDZxiwrECzBHCag==
X-Received: by 2002:a17:907:6d1b:b0:b43:3dcf:b6c3 with SMTP id a640c23a62f3a-b707062eca7mr1059163966b.49.1762156792088;
        Sun, 02 Nov 2025 23:59:52 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70b9f29c8asm312691066b.8.2025.11.02.23.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:59:51 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: extend DOCUMENTATION SCRIPTS to the full directories
Date: Mon,  3 Nov 2025 08:59:48 +0100
Message-ID: <20251103075948.26026-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Due to commit abd61d1ff8f0 ("scripts: sphinx-pre-install: move it to
tools/docs"), checkpatch.pl --self-test=patterns reported a non-matching
file entry in DOCUMENTATION SCRIPTS. Clearly, there are now multiple
documentation scripts, all located in Documentation/sphinx/ and tools/docs/
and Mauro is the maintainer of those.

Update the DOCUMENTATION SCRIPTS section to cover these directories. While
at it, also make the DOCUMENTATION section cover the subdirectories of
tools/docs/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7031ee1e7cff..c9bdaaecc946 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7442,7 +7442,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
-F:	tools/docs/*
+F:	tools/docs/
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
@@ -7476,9 +7476,9 @@ DOCUMENTATION SCRIPTS
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
-F:	Documentation/sphinx/parse-headers.pl
+F:	Documentation/sphinx/
 F:	scripts/documentation-file-ref-check
-F:	tools/docs/sphinx-pre-install
+F:	tools/docs/
 
 DOCUMENTATION/ITALIAN
 M:	Federico Vaga <federico.vaga@vaga.pv.it>
-- 
2.51.1


