Return-Path: <linux-kernel+bounces-896700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D612C50FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3947934434E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53062EE611;
	Wed, 12 Nov 2025 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdKdpMlF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33232853F7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933653; cv=none; b=qyNEXDGOgr/EktiKk5scGt7LkF9hq8eAoiclFKujMu0P+agRJmkLqa3KCsuRWyr2PxpHD+2ccvpoRlUIaiRbSj5dYdwO8VXdG8VwvjUEswrHMB4HIibJjJMg/jvBB7lL+vk8KqmhHquCnRALCLIdWH5QhTVupNploa2bYokll6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933653; c=relaxed/simple;
	bh=N2srVn5ft8rrLUU2LxtJ7kYPfjxO14iedItRd7WbfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQpA6gCX20BhSEj4qxBqxvcWZrHzFE7el4tfGdbEc8ELEmjo8VQiA8kSiiIpZXh3j0ctC9H5Q8GM6xfjyRvWuCV5mLXSqa/0itVbWpL4GFxrF3TNXFXA6me7ZieHS5hpkjpPABydThox2sB78WRoFPONgztk7csrDwjMN3jIXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdKdpMlF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-79af647cef2so479291b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762933651; x=1763538451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLKuQP1AX/IkdkuwdwbT9+zxaZwxScPhJnRXzeMQssI=;
        b=MdKdpMlFwtTCkI3Z04nkYvXjPKgi9ZHZ9GngbDRqi5vxgsw58jok+Th/xDWppK0/CG
         ZpDPSh6rkC4k3i5nQIipneC/QpY/KsAhPo3ypSyW65zo3BTZFvUiXdueqcf53qnTdY0R
         HoAyW3+wpysfFdmRlCIZdy6T7D8Vtl3Ece/E1eQyN/fMnJFIPsS0Lrx5OMwLCe0Y7gKR
         Ol33JXjcpeIFT/DNuAaRbMsgAE/o+ySgn3kSoKjRpS3qERvIdyxsoPduQ0kJe9pNYSGV
         w8m8csZrcXEdsXbUnOEjl1e77nISFou2nWuckAViowwt/ShPXzbpQ/xQlZhB9CI1L0IU
         cbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933651; x=1763538451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLKuQP1AX/IkdkuwdwbT9+zxaZwxScPhJnRXzeMQssI=;
        b=I5+cNfeaWa6M6769lmK1rT2mEhfv4irlJo71TjoCQwY+oyJ9aW5bERGNzpOVhrwp3E
         jTH+XciSQwA9Nhc0W+ndIyWeH9NqGqsNagVXnyuX70cphNdgcqP3EUPqvFIkhJ9OPaHy
         fVLHSi4vQ7wIb5mpJlBKkx2qNlKEfWPUB84yJNgW3//ywIH13hysEWRD/hWyLo3VtxkV
         6794e/XgvLOiZbh9YByvPJfkZuth6ycJyjx8t5G/qURRhqVPF5nNu5O1gutmJkwymS0M
         kFtGdA5d1z+7v2Cd/TF9Nz5U6UH3cVa7X+tLW2hJBFkhIcjTcXdMK89UcxxRjvxJeLjz
         layw==
X-Forwarded-Encrypted: i=1; AJvYcCXFHOHCQbDZ/80NpFzhYE9qfa1I3cAhAO8jYqwvhcMZsapfMdNFYZxyTx05UcgznSb9PgJJ0HSKN3HpCwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfg8MessscWz9gTQlAHkZFvBzwq+VkxAy5AlttowSNhPxFs8T
	p5UDpub0b18AMEtjgQprnxeblEoWk188CN07AoHRk4tNlcvefD/O49qk
X-Gm-Gg: ASbGnctB3E1pIOONgk9KMUhYr/F9Js1uBSEkR4nkOeZwhr2oftzH28cRuZAIJBUO3wA
	zG4IcCbfzTN4qFkseXJeNrv19YbIBhxslstlmQGsx0N4lmcFRaeuOtogDHaMGrkdsDyrr9e4c3R
	XYnLDl7mQfQC+gwmYkS2G7TiISmmKeYzgQECbSc5L8EhEY+/GQiDHwidorfpXmlfocY7ufYcIt3
	s9KHL+zR402b/yFrTnbNx61q5senZAU3SrddQr1AS8UfYiLYSeul3VyJGRmhzsbL7AWfgPdl7aT
	4f11rtf9f/IQS3RC4GvTAMXZBfpufMbpD9LuwUrLdSSZ6Zct8BTP+KkZsXOxW5IZlv77qQ65Geb
	E8BByotFHjTttuVCLc2osxXJceQLo41gwmLLA0iBxQLcC9fcNhQinhfBYggAVzQ2USJLZcyM1DW
	jg9dUTdLCowGP2FZJaKDNo
X-Google-Smtp-Source: AGHT+IEzc8kFTKN/5uP4kOX7SlKaPkWcvzMYInvDfOzhEJ5HTSk3WJ1KU0r0QzloC42huJGx/DqarQ==
X-Received: by 2002:a05:6a20:a10a:b0:33f:4e3d:b004 with SMTP id adf61e73a8af0-3590b506614mr2649206637.47.1762933651118;
        Tue, 11 Nov 2025 23:47:31 -0800 (PST)
Received: from oslab.. (n11212047227.netvigator.com. [112.120.47.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9634f56sm17931628b3a.4.2025.11.11.23.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:47:30 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] RDMA/irdma: Fix possible null-pointer dereference in irdma_create_user_ah()
Date: Wed, 12 Nov 2025 15:45:12 +0800
Message-ID: <20251112074513.63321-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable udata is checked at the beginning of irdma_create_user_as(),
indicating that it can be NULL:

  if (udata && udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
    return -EINVAL;

However, if udata is NULL, a null-pointer dereference may occur when
calling ib_copy_to_udata():

  err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));

To prevent this possible null-pointer dereference, add a NULL check for
udata before calling ib_copy_to_udata().

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c883c9ea5a83..01eccbbb9600 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5233,7 +5233,8 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	mutex_unlock(&iwdev->rf->ah_tbl_lock);
 
 	uresp.ah_id = ah->sc_ah.ah_info.ah_idx;
-	err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
+	if (udata)
+		err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
 	if (err)
 		irdma_destroy_ah(ibah, attr->flags);
 
-- 
2.43.0


