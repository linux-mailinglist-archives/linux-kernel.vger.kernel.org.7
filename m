Return-Path: <linux-kernel+bounces-758520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F8AB1D03C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F03723A94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3DE1E411C;
	Thu,  7 Aug 2025 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jGhRq5J8"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5F1C5D72
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531095; cv=none; b=OyJAT53unB8AwP5aDyeEllEY7Y5FI/+PssC3snNiTMmm9/1VDqelPJCxJ7+8qCEf/E6NYuW2S3NUMTBnlXnkotXsdeu1S6Nv5N4yzKF7Grnz3BebaY899g3PXkEmTQQHAASAQ6kAKd79vPEPKdL1SY1wkb83G/2Kp/WUX64Ivno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531095; c=relaxed/simple;
	bh=7U4lml8t8oTaVKuCLMpzN1Wuy07LH0AEtgZI7ZnzuAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOqnZLvnKO40XJgwXGTJ8DRTwz51RLQr/+Zj92vG5BNK4aMjZozWt16ig54BK8fZ/obuqxs6WFMr3Vugm2R4Dnj0q8siwea0vYz9j28/T7dNuhVqUrcJX+IZnli2mMkJLEZyaCz3GBItaGk/6AxenTYh0Ned3c6pDsJA2s7rgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jGhRq5J8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-707453b0306so5567776d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531092; x=1755135892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaESzk2f6ioxFaB+zOVCWa3oEolQrGNRo6YQh6Uj768=;
        b=jGhRq5J8VB7lIKnNpy5IKMw8o759Wi8rvUO67fzgAAGCCCNNALGWGFCvUy8qIR2/LT
         DXGxW0APa9sdDaPeZEwdzz0T2lICen0AXKPPnAznTYEJWRHZQTfte+Svh0/PKYE1wN/E
         Hw9FP6Y83KNEBd3R+497m3ThktAMJAxFcsnbHwhRHmebFfa7+opf19X8RXLo+BdSY3gw
         vj1YvsosNm64zjFspN5YAkjdnqvhI7zj2WOgFRuA2hBLMN2h7r3WUF31CD2F4GR4hOmR
         qf6OOUYSKXEEXnkxZcjMDk/tFAuea95bcYCzFRjAcDrsVywYcGTLqOzHgv1pcuTLGqrI
         F8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531092; x=1755135892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaESzk2f6ioxFaB+zOVCWa3oEolQrGNRo6YQh6Uj768=;
        b=btC/k6QKv1fuKmEGYyVkZia6DD1pbMA1MXUfXMIuItJvtVpFSqWeYm1J0J8CLftNEM
         Ob7rgZ+g3QwyMaRfRqf479yip3wL+McKoybjVTDHlRYTxdZahxRUh0Ze+UaU6WEL3WiO
         TZsOMVGMuYJWerisbPXOc3hmp6+8EJzvC82bAM/RV9Cv7hxUaEITTIP8OAib2b32V/WF
         fQngYsjDE3EGgP5ruFO6vPHzePVnJw09yID2B65vyNXm2ttbwGaZ34I0rU+n6FAp+B6U
         6CK5pxoZA2SiKWLYFJTdPQsGGQtyJTksfwhs5vT0DTng+e1wi5mZPacGBC1tH8rbTzX/
         jEzw==
X-Forwarded-Encrypted: i=1; AJvYcCVAoJs+5HWKuCQNF9UtdylPbYnxjafVGHfBAuYHVmJa5tY8dAt+LUBVJJ6wCssDYQLoQcvT/x4Jf5/KvsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpVvLQmYG+8XCw2ZAZaY53cq7Try4yJ2eJJm36ljiNW/cSg1r
	sxKGh+lwxFs8HsdvhMgCaq5i+RmDc3j5fT0tVSNT8BA/fbDG5lNDM/4xcHUbGSKasqk=
X-Gm-Gg: ASbGncvN69cUKDGagk1ezLhKFpWbob0WxzSdxAzRLD1BU+/ME2bvf69HsnxWltMBZJR
	+YywEAxmuVHC1FOZMNVlXs2g3d4O4+jeb3F2DEJ3WeoaCF8kRRWQfNRvSqIytHckn7iAo3isdou
	NWaUp9UwiMplTmlXdhRD3HV4jLt8vVYcVzLhfiNqRO7kNlp5xIXp9Itlv/zfOZe3XL+h4UG2ZAr
	DhEyLDVXm/HPLfOaCDKZlyfRh9U/4O+iabiXX9kgR7eahBEAnY6AbFJALJyNkF/RD2tup9jRzje
	PzEXzpM5CV19+HPV3269w4DVEQozl9OsH2Y3bXiWadMCjdnJeTdZi81nlHvjfzqtY8IEgojVEW7
	VBayvGPRlELSvlZRdkIqjKeJ1S3HwgEPyTPaMi8urDL/Fb3JF5YrunXaQ16kd8ZHhXHL6M2vLBk
	blhJEsez5T8Isr
X-Google-Smtp-Source: AGHT+IEyWMvTBlOM62kNmVMKSSB8JNc55ip6AvkaRw6dwIN2X5ATQTWFGGBA3z7kK5RTd9pgC648bw==
X-Received: by 2002:ad4:5f8f:0:b0:707:4daf:637 with SMTP id 6a1803df08f44-7097af1440bmr64537216d6.29.1754531091759;
        Wed, 06 Aug 2025 18:44:51 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:51 -0700 (PDT)
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
	witu@nvidia.com
Subject: [PATCH v3 03/30] kho: warn if KHO is disabled due to an error
Date: Thu,  7 Aug 2025 01:44:09 +0000
Message-ID: <20250807014442.3829950-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During boot scratch area is allocated based on command line
parameters or auto calculated. However, scratch area may fail
to allocate, and in that case KHO is disabled. Currently,
no warning is printed that KHO is disabled, which makes it
confusing for the end user to figure out why KHO is not
available. Add the missing warning message.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/kexec_handover.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 6240bc38305b..c2b7e8b86db0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
 err_free_scratch_desc:
 	memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch));
 err_disable_kho:
+	pr_warn("Failed to reserve scratch area, disabling kexec handover\n");
 	kho_enable = false;
 }
 
-- 
2.50.1.565.gc32cd1483b-goog


