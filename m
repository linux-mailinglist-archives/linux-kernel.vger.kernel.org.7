Return-Path: <linux-kernel+bounces-812873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF58B53DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767191C81610
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616221D5BC;
	Thu, 11 Sep 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hid792jo"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FB32DF3D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626734; cv=none; b=Qg6d/HjgWlQNVIXHS9Z0munQ6406MTMd7KuRmQwdMzWhuKlbmZwyMj+qyCTzAmlRpymrc0NQ0SIqNVsK1NZGY4CLs+lkrZBlpzdqQesgJYNyFU39gGVJdz6bf4/YA2Aq3JL4zEct0qR0qQNyG6GYrtRyVk6nv7/S1H8liFRxnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626734; c=relaxed/simple;
	bh=aKMTvHoFGMDwM92wFBmpn94LIVdnLgrI2RnhwdRN0GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QANr+BsBAPu1cGLLcmZ7HmDmTflPzsNmAOmQY5Ta/dCmuXhzjKRzpahwjXJccDh3GGRfJuWGYeBMyySTBA++itI4cDqhy/G701F+S6ucTJwdWXZHb3ZBBPpLvXgxgXhTOSeiUbqY5AvMsS+0gPcQxEVC1XkQ2nSOy8Fr5cvUAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hid792jo; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88de776ab4aso48723539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626732; x=1758231532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5lAaOOjCc4ULiFrsiLFYK9hqRtLQli7F1TlUXtnya4=;
        b=Hid792jomubTdwx5JMDv02Md49ng0hEUpAO4poBUT2/XPQZYwppCPiogYLXXzTLoBa
         wIEGttEWCKiadOOfcpJzaKoN6xdW8Tjht/SzHOojNizYG1yS3Y1O3o+2c2SNnwUuTIQm
         ASRYQul8TITiZux7o13h/UwXLrOx3lcZuucyVmT4W3k06tggWhvsKcmEbGY3WxGIgLfO
         fytxfSz+QusfDyrcr5BodRdXg1A6O1teA3MdxDfIzt1Lxq71BEsY0RvNJtiSOAwnjt9P
         T/3SoXz8/VXC+jFQ/px7yhgNwGsWK5hWSPb8Rrsf3BVjpPkLjNslMF/ZxcWI/96bnv9D
         uIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626732; x=1758231532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5lAaOOjCc4ULiFrsiLFYK9hqRtLQli7F1TlUXtnya4=;
        b=JE12jnX5ODF1e42269zh8EzLPCBiR7VgRxcLxt5+LIh39BpAOcOPl50RQPh1VS0Xcc
         UtY6V7eO9PavBsG8Gm+6ayq8URNdG7qBGAqoFDIUnjB8jvaU7Zy+W7URKTziV9iAod4S
         WabWdYcNKHVarQNzMTwsUv5P8X61Qqq0SKwMJw2K3y07CRbA4pK9n69e505KSzr4n5+r
         PDlla1RujOkw3lDULZJNTa1oePVV82SNo9/oaLL0KTGyL2Rd4fnYc889TUNWPs2M6SEQ
         FZ6cKQlstFUnL+DpZgYyZWpmtrAUVhvgn6T2itrGQkL/c/dG50KG6g/jReawDaehkOxK
         emSg==
X-Forwarded-Encrypted: i=1; AJvYcCVYUsTyGfpuTrS1bGedvazW+JxZdWVqc8L43JMVJkhsLLkNJvquRGreldAV2sRZHbekUMpyG3Y0KioFC6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwi24QJo8rJ+dS8N1PEHzUtK9LoWcnvvvtVqcefI12lgqK8A1J
	kpSKvmQD3VRRh26OYWInEoiIj7R+MCSjQclZmW1kpKE44Q2EKZkKaMbL
X-Gm-Gg: ASbGnctHzAIMXmdXk/VHO3yGpSpRRm+uxuGQ5mMOXHdRmmFtnspR3PI7VYbO5pZoghM
	6vX8sz5mwvdgWPPFjx5V1u9Jwnayqw9aQHg/d6DnwwY++QI7EnqMQMWX1jeOmxSeyHjKhnnBlKE
	8yDAeqFDMMQyUgxbleX2XNGFpqDoRVdSUG10A9oewwubbbICyVhBGCpedZ/UWEg/wW6/APZtSK+
	P2XPnvkFZR5qKXJtf6QgPo27LU3dqdBABQZ3Loh1xvw+nX85bwHjWJJkfFyZZWQ735ZQyLf5ApV
	a3qOYg9qswvxXMEopI5yXtB52zNqGyH7mztma5x9S/TYKAYgknQGllD6Zg1+e4U68i17q3UQVMB
	YUKqubG2RDlYFZ0DslqB3fAUxIOaeKHQNNAznwcTFKL7IN/CHxBS5k/sKTNGCmLGbQYL1jHtVRw
	HYnEgRzGmCKfH/cA==
X-Google-Smtp-Source: AGHT+IECIzuZpAKsEFWFlKexW899VlLOvzhON2InCMoHuSwn0vJlnSXcgdlZwIYxof02sui39joAHA==
X-Received: by 2002:a05:6602:6c01:b0:876:adf1:b263 with SMTP id ca18e2360f4ac-8903280ad34mr125504639f.6.1757626732193;
        Thu, 11 Sep 2025 14:38:52 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/30] dyndbg: make ddebug_class_param union members same size
Date: Thu, 11 Sep 2025 15:37:58 -0600
Message-ID: <20250911213823.374806-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ddebug_class_param keeps a ref to the state-storage of the
param; make both class-types use the same unsigned long storage type.

ISTM this is simpler and safer; it avoids an irrelevant difference,
and if 2 users somehow get class-type mixed up (or refer to the wrong
union member), at least they will both see the same value.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ff44ec346162..b9afc7731b7c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 147540c57154..55df35df093b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.51.0


