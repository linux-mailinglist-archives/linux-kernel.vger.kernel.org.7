Return-Path: <linux-kernel+bounces-890374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247E1C3FEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85981896BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3F320385;
	Fri,  7 Nov 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZrb/JIN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHHigW6L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EF2580CB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518992; cv=none; b=U7mpbjuwHGAedRmSHUV4S9/PqvNLWPgj3UUxTzWVBnnNBO3w7clL1Tm0lxOYPW5fX9jBX7s++94KiJOGx6vkgGh8UtkoTSR06ygVR3NMlQCRm+hjsxeYphbBjAcd8gbhO5XBYCo1LqVd0UV/WsVmvLUSzCCnxcMwf4Sh6epqBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518992; c=relaxed/simple;
	bh=fcggPcLDIQTv6YFTOVcBGogTQrJwnTz4cX4nFLOhcUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=la9FW5Uj0RqXeiO90L5n/LMqve13EG+ysEY2/eTpeDNLGteX9otp2rm94bxVNwllpyAhFYxSgI0VLnkvb2AWi0HyaXOxF7bFcvDqtexE60Y3NRkQ9v9moPJh+7fuZbvn6O74JBNVbK0ctywWwE6v1IX1Abq3admv1kuBUNc5TEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZrb/JIN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHHigW6L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762518989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1siZim9NDW4Tl0EKq7x9rZRpMbOBM1ClHh169bAxgS0=;
	b=GZrb/JINGcRXFxyusbhnfKDgEzyS9tJAjPTHh5CsI7oUvv2ArJ1Ju4pRjysDas9rBFQcRw
	GjTdbfhehhqYFWkCS5zD+z0C2Dhpip04+jbW7Nai91k/0KHTFt5I5UjKOh/xUScs9Sg0W0
	QkynUd8JCV4lExhPROS/6kMBFCYen48=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-rLwjV2rqPwChV8M4JuKjhQ-1; Fri, 07 Nov 2025 07:36:27 -0500
X-MC-Unique: rLwjV2rqPwChV8M4JuKjhQ-1
X-Mimecast-MFC-AGG-ID: rLwjV2rqPwChV8M4JuKjhQ_1762518985
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c17b29f3so487394f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762518985; x=1763123785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1siZim9NDW4Tl0EKq7x9rZRpMbOBM1ClHh169bAxgS0=;
        b=UHHigW6LthOEZ4R2I9BAcE5P+CMup/pWkdtnc/BqG8ZEhQu8D8gtwSfoJa0idjxvkm
         dYzZDCbrNlCbsK6UbrBjLCXicfzs2fOzBaQiZyeOTitKfol76+TeW3C8Thkmvp9ZND9p
         pAiz5u4FU6T95Zr9Q/yik7kYn+WrAAlpKxF1+SUUtKw+gYUnbwxHbqd02+44cqSAfjV2
         ClV8ltrJhJhlzvCR/bigTsTmUAtivFFDdjsaggVDOUiZTjEyd45Jc24UZVmP8j67Stb8
         rSJLR/yfZgqYjMWncdmR341NyDelGHdSrXpO5QLox4p35qv3AAbkigUihiFxi0+tScDA
         DV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762518985; x=1763123785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1siZim9NDW4Tl0EKq7x9rZRpMbOBM1ClHh169bAxgS0=;
        b=f/6sZEh6q06WsyUrQUf639RMjL8Q7sLcNd/kf0gtowXeqjw5CmgaPUNzadPoyeJQiv
         B5UDQkiJS9pob/YNjXOVjYaA254fW3DPQgRksUr/vQVJYfj0lI7n7OYyQ0K7tvv3nWzz
         6IrAQ5XU1PEiJ+EaD4jQG1KaOaFGKJhngt0ydev4vqQLP1s3xQMvvU4XbYJaIsX71aZA
         cymhzytjNq7jTakDwjXXss1gNIBKDfbbQsamhx6B2gbfiRFQuZixXUGDF0HI1LurNM7F
         p0nFimEsEJ5WGDJbQ6camSosn+uQBeveFBD1aUTElHUVDf+NC/b53CQkxO/T/fvxmpIc
         niDg==
X-Forwarded-Encrypted: i=1; AJvYcCXp9bknLgKftxQ8KSfLbb12nnlWSKB+r6bolvEAU9kqXcSJzD+lJuePf8U7qmwkmcyiNPpTqWh+8e5cvWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjz1Exx/V83OyX/McV5XAkNGlGAXcjLRWVEzJcyLFXK8JdMPjL
	aX1P0aNhvvKvJV/6qUYJ9WfEHDgH8j+6wSs+5ztaEQbwniCScCSQaRA9H21MQLTGOBdo6dH8mP/
	9GaHrs4OHDTvnRQo9sRTnCpk7kVyBRZI4RIYTwZmvFJOskqF6g6wfwlUuHsp0BZnNLcIEiEbYxw
	==
X-Gm-Gg: ASbGncvoac+8UnKIxMoCFloLsNIvI3ZZQGr39/bwCEniiaqVE2U+w2DF2taLbDkmOk6
	qtjm7CksSJu+suvx2BaRwFfuJMXvFkDQELjlO+EDSVMZBqh2XfDQH/EGtkMIDzgf5TecsQyV3BG
	y8B7nEBOyPsfk94BMCoiN8ArOnUkLeJfoM4hp+Rqu2Qc2ZJZryg8evRWAqC0e6sdMggsbneZ4Ht
	rvdqIlzhi/zyX5rovgzQ6y5xzrbndJZ5Pd7gwiCtOX94P2CqZTKozEYg3PacDPfcNa+jNE+eTAU
	VridPWf6rlONToIvLDmXcoQyWfedHmg7tSve1c+HgVaPpYC8Xqkp9/EAHz5KOMwFwROTK/dG3sA
	qjLf8RMA6GKmiyCuD+99y7hXd/mnE/2QB97lv5KfY/QroRLbF
X-Received: by 2002:a05:6000:26cb:b0:429:d426:fb9 with SMTP id ffacd0b85a97d-42ae5ac987bmr2037288f8f.34.1762518984970;
        Fri, 07 Nov 2025 04:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEylXKmQTrFotELc6oCwxKJ4KvmE3IvEF0/zAZ97as2az8kWIyuFMKUbHCj4k9Gpi+YSaCAyg==
X-Received: by 2002:a05:6000:26cb:b0:429:d426:fb9 with SMTP id ffacd0b85a97d-42ae5ac987bmr2037266f8f.34.1762518984562;
        Fri, 07 Nov 2025 04:36:24 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm5146947f8f.40.2025.11.07.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:36:24 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in ROHM BD71828 CHARGER
Date: Fri,  7 Nov 2025 13:36:21 +0100
Message-ID: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
adds the file bd71828-power.c in drivers/power/supply/, whereas commit
b838cecc2291 ("MAINTAINERS: Add entry for BD71828 charger") from the same
patch series, adds a section referring to the non-existing file
bd71828-charger.c in the directory above.

Adjust the file entry to refer to the intended existing file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58c7e3f678d8..68774e9d1d57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22481,7 +22481,7 @@ ROHM BD71828 CHARGER
 M:	Andreas Kemnade <andreas@kemnade.info>
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 S:	Maintained
-F:	drivers/power/supply/bd71828-charger.c
+F:	drivers/power/supply/bd71828-power.c
 
 ROHM BD79703 DAC
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
-- 
2.51.1


