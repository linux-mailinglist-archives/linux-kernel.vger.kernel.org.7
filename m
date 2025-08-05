Return-Path: <linux-kernel+bounces-756422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E1BB1B3C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430781827AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF925C816;
	Tue,  5 Aug 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAYfSABa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDC2727E9;
	Tue,  5 Aug 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398217; cv=none; b=QAuhVKYu5FFGTUHjWA2BLvVXx5XWbH/23VU55Qvdc7+zGQYlGJKY3N1QguIlEHgsLz6TXt8nTu0qpxPPPguFJ4mVG5FXkxBf6YIBxerD6OgttUbNZtl8fG/irvMzaWlR63ds71Z4oC2/ptrbvSqEZMul1BL9dIuF/SSNGWZHI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398217; c=relaxed/simple;
	bh=HWKv7ENcWJ5P5qVVKyV90sLF4YTQf9daZ1hSHW1sMG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgpbxkdncIez44UX/OCKcCHRpejRYCUXV8dmHmmlL9eoztUZBNs9UJvPem6SVqyWV/rMj2GfLuu/17rDvmnGAq62gbdTzZnl+JIR9VCvN3Wc8Eq13CdzJdlX+wSgzYLu4cB4b6A79UfceWrDsvqcHIkYyEJyBvLrn3GV9L6+Ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAYfSABa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so6761710a12.3;
        Tue, 05 Aug 2025 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754398212; x=1755003012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3jwKXNI4rekJ3bC3lnRJQ6Yd8MMqu4YCCAHk1Ogkeo=;
        b=iAYfSABasNuONTpySIzrG51dXeoKmIVmgxUJzAHaSntz+24GTXPwUaxQyEAxj/TRMK
         ZbsYlG1q5Pfkixonrh82xIqtgIW4nGzgJwmJz3562Tl1HVquWUfolzaLCZ/ynwaexBGV
         pqCwD16AiURjio+v+LftALvgnTPb4Jb0TKGF2k8+wzSk9slzmFOZ2QZwWlWG71c44Dxr
         5s0r0qWptokvZ/+br+gTePS/utVi5dQ5B82RPyEhkdZfP2KRQMpjvS47l04C3094zh45
         gZBPegH30YCWlxnrq/yQf/zGbs9fSmpau5EZBmKJoVMofsl/X500gcbrDR2O30KlcDmm
         9k7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398212; x=1755003012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3jwKXNI4rekJ3bC3lnRJQ6Yd8MMqu4YCCAHk1Ogkeo=;
        b=Kndbb6mtCTveQSP1nH7iIVfKkoi97s597e7HXw5HDhpeybYAIdQsvkNEh+IAMIFg+g
         YeSY+nirZKWiQ4YIMnOTB+eXstJS5SLpgucl2+mpnbhqkwyyFTvpho+OYsrIKpurUja9
         MWTbUeSbaLxSyloYfP3ugCH6HW5nlwepdZDBByRGwI97UmLTot8jU3D8CbMTqOuV/7Iq
         FvgURq6CEQHMEFFMFbgHQDR4v/N8VNiUYIKX0f0K54QWFZ7P4niPYSpkQJBom7vgsoKh
         g0bByikIT32H8AjkDtoODCK0BVS3pPCX4Jg/lCcgZVttvOK60RtxZFZFmnsegAdUH5Lh
         0dsg==
X-Forwarded-Encrypted: i=1; AJvYcCXB9NlPT5GrAsQDSu/Ln511Jd43svISuZdR8mdI0Pwnt0w4L0MJ8G2ULwe7lBKYVQvGjXt5dpsDdK2zoIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBClOhF7dNQn6xg7KFFzvOXweqivhkOgU0yjVpf9aEvX7mnYg
	NS8+Kw/GkunT2wBUzhwt5Hn5tgBJigMsiR+mbCWIBDiMLdJT3jz8rxaK/ARXVGniM8j5uQ==
X-Gm-Gg: ASbGnculXoflfgyWjok46Pf1nwLQLtj5BW+qp5/5mLl7GWj8xEzJHxug/R5f7IbuSFb
	sgayLfaK8EPYP4oWmhL6oKQgtqpM91h5YpLK9Mc0+IPgQrKTXNrGuTwrOE5OBj7gS0GxkjvM499
	wys1PVOgWecWdhojK3ZwUzyHhsWB2s3TvNdvGWm/Cdv7nOfp3uauqgPOr4qGu0M69OAHntd0X3T
	UVPYxjlATmi/yBPEn7aR6YHv6ezv7ubczeLfbK57k7wOkSRcZSQWrO2M+X5FR9ZHB/rxcSTzsze
	J3xd+DhsK0xAF8Tm/LME8DR98wS1kpYzgUhOQVS3SdZN6HbGUU7O4iL8kFWaVr2UxIZBqEXsXu5
	0vqn1iafDoxuNIeaYNnXycbRC
X-Google-Smtp-Source: AGHT+IG1gZ23yNGA0lZGdf1VO4KsVb63ecOdSFUH2BYkNIrPe3jl65xa3ewdqV99d3pNNix944eXvg==
X-Received: by 2002:a05:6402:27c6:b0:614:fead:3d56 with SMTP id 4fb4d7f45d1cf-615e7195ffcmr12335815a12.32.1754398212403;
        Tue, 05 Aug 2025 05:50:12 -0700 (PDT)
Received: from artem-pc.. ([88.201.168.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aeccsm6811176a12.2.2025.08.05.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:50:11 -0700 (PDT)
From: "a.shimko" <artyom.shimko@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: "a.shimko" <artyom.shimko@gmail.com>,
	linux-kernel@vger.kernel.org,
	sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	guenter.roeck@linux.com
Subject: [PATCH 1/3] hwmon: scmi: Add default case with debug output
Date: Tue,  5 Aug 2025 15:43:57 +0300
Message-ID: <20250805125003.12573-2-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805125003.12573-1-artyom.shimko@gmail.com>
References: <20250805125003.12573-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

Improve handling of unsupported sensor types:
- Add default case in sensor type switch statement
- Log skipped sensors with debug information including:
  * Sensor ID
  * Sensor type
  * Sensor name (if available)
- Use rate-limited dev_dbg for safety

Debug output format:
"Skipping unsupported sensor ID:%d Type:%d (%s)"

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 364199b332c0..a3b5b5c0ec25 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -275,6 +275,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 			nr_count[type]++;
 			break;
 		}
+		default:
+			dev_dbg(dev, "Skipping unsupported sensor ID:%d Type:%d (%s)\n",
+				i, sensor->type, sensor->name ? sensor->name : "unnamed");
+			continue;
 	}
 
 	if (nr_count[hwmon_temp])
@@ -323,6 +327,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 			idx = --nr_count[type];
 			*(scmi_sensors->info[type] + idx) = sensor;
 			break;
+		default:
+			dev_dbg(dev, "Skipping unsupported sensor ID:%d Type:%d (%s)\n",
+				i, sensor->type, sensor->name ? sensor->name : "unnamed");
+			continue;
 		}
 	}
 
-- 
2.43.0


