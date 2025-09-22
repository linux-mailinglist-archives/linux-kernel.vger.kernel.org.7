Return-Path: <linux-kernel+bounces-826946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAABB8FB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9546916BBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0D8287277;
	Mon, 22 Sep 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6ZOOOpn"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA058285065
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532260; cv=none; b=DyvPTnM9TB6n1PBkEIQ+jBC0YBomdjTBnmsZ9ulAhh+ObGSojOaRIkZ9Ju9qg8MdhrR8hvL7U1lDzX4Gi39aWsQEaL0pmb9cjTyw7BbBekRYvGcAm5yMRDZ3KTv0hO2INdwpb7AZ/2vgqSv1IB48hy4P++LA3EZmQMV5lZjX4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532260; c=relaxed/simple;
	bh=t55ecTqmrNR8pRq7si7fT2qybwnmjw3prAlly92kfiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5etLUFVgSuPNY5cnm5Ugy2dnskWMc4w/2j6XpFSo1Y5nSEHHGd/ljK/YyVLlXMgzFIVQ0FpauldVv3NHPs3lg3W/tLzWcJPV8JF7x/DATTHs8X3zHpfe4eDXRvA+rzVGrngg4jZzcMi1LGcI2kRMv72HkSdhfMOVGqHkPM2oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6ZOOOpn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77ee6e252e5so2268173b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758532258; x=1759137058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyn8ad9UA4c5mQKVC6pbDxbJmyFUn7gmW4IP75tq2Qk=;
        b=O6ZOOOpnI6uJXh095LyaV/bOJAEP2ENUT4HiJpLDZ8w/+9tN5o+ksl002TF2ynP9eg
         kmMpfEOruJXxSnUpcEglVOj8nO7bfu9yYUpGy3r8vA4hmHoU0EF4gw9D2aJAhwIwQhiq
         zm9f8LNjwi5NMpNJGVrn9fmd+MssNhF3HixmKX7xJO9QUEx0Nrl9V3x/IVXKPatoWMSO
         SBNY5sFkjQ4sWVOSOFHTw3v4LFyqtuFMptbj7v6hrXQb++ddKPdFTU1gRcCZKh47vEpb
         WrYVRFbwmn5ESj88vcy5hDxb6lxKvPH+MpiaQYhEH3NQLm5eO02MNv8JAcKdKlfpjvUe
         2N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758532258; x=1759137058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xyn8ad9UA4c5mQKVC6pbDxbJmyFUn7gmW4IP75tq2Qk=;
        b=fZp761ONbpJB0Uf6olVz+GZqAHbgi0JD55+sw2hxisi9QUWx8ESuPQh9zVKzMrlbWz
         z0UbDiQEw2bVKjJYArnvHrli/toGE3aUMPbQScMSxJDfS9bCYSxgEskcOAxKqOWCeLxm
         E2JEJjCogcIrjSZ46WeC44xio/JwhnlcH2rLENXQe17lqawPyE5F3gr3ijvYNFto0Qpj
         mlx5a+FhtNkHmYFcnFgYUYKFJfblykcrKyCBzJhuLA+y9wx9K2l/8JxklzWB8XlMaT/o
         9Mku77/iqZe51g2uxsbrVV5j4WCVmFtS1DDIp+WRu2M2PEzDmb7PCZrou4+eHV0tfdr4
         yEGA==
X-Gm-Message-State: AOJu0Ywuw+y5BCA63Hgdx0m4G1iKa6nCz4TQux+bVSYwo9h32AiyFTYw
	v11bN1B/4Sw2fd+E5sCu0f+IydDlFs5XdK5u6RsMkgtfSnQmDycUF/Gq
X-Gm-Gg: ASbGnctj4PvogWVJdaGhgOY8xjjzC97tLxaP0eZkyTddfovl/Y7e7mHx7RpT2TkWWIY
	29+6Qhym+vgmH07ToyJ4LtJNAtWFyoK8r8mJ8o41uS9W3rtCuu9eAZ9L4uyr/SVQU1OeMhEoIpt
	hqAaLX0+ZKI99BbYOc+T2vCcqHSTQ8Pec8XWc7xDExL0tbajRxMBkTGsLaFEt/DH5iwmh2ZUL03
	0Nv/bMqW8/1415fV85f08/FPpUD6hWG8hgoxYwvM3KDKWEPcAcVVz/uS2xWMlN67gQW/yD+pZGv
	kUGppB2p9iplI9ujFO4/gtnP1Xs6vTYWQdjliQzGzF5PJUhMBeE2HPg4Faf3KQMboUq/obAqVhw
	/pU8vSW6fB6ZiiThE9Xb4CvMg
X-Google-Smtp-Source: AGHT+IFywvuV6sf+8L28eCngThE4JSpP1kQ056fqUT9xEvnRoOaaMQ+9VfNKwtFq9Yq4w4biAlyygg==
X-Received: by 2002:a05:6a20:9150:b0:24a:a45d:7a32 with SMTP id adf61e73a8af0-29272a5daa2mr16952132637.45.1758532258093;
        Mon, 22 Sep 2025 02:10:58 -0700 (PDT)
Received: from archlinux ([36.255.84.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4190cc8dsm1393548b3a.2.2025.09.22.02.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:10:57 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH 2/2] selftests/cachestat: add cleanup for leftover tmpshmcstat binary
Date: Mon, 22 Sep 2025 14:40:42 +0530
Message-ID: <20250922091042.149117-2-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some kselftests generate temporary binaries that are not tracked
by TEST_GEN_PROGS. Add EXTRA_CLEAN entry to remove tmpshmcstat
during `make kselftest-clean`.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/cachestat/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
index 778b54ebb036..c48065d791a9 100644
--- a/tools/testing/selftests/cachestat/Makefile
+++ b/tools/testing/selftests/cachestat/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := test_cachestat
+EXTRA_CLEAN := tmpshmcstat
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall
-- 
2.51.0


