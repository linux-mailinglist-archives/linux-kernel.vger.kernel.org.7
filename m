Return-Path: <linux-kernel+bounces-898286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E0C54C42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD8C03462AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F852F0C7C;
	Wed, 12 Nov 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiFN5J2o"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C352EFD8A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988253; cv=none; b=nKcqW+10+2xWrydF4/vkG46HwjB5JTurJYq/W7t3OKH1oL3qgF13GnyBP3JH1wQqUkokYT8hS7vyaD2FGyJ3QYTiUSNW0RSsmUzFX3+6ICseNX8P4jB8BFZiuUE+dcfGt49Ex/uAZT1/CmwbUuDtBTh2sr8M/I4yPRpQT9DjJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988253; c=relaxed/simple;
	bh=gC1f61DmLG1P9pAkwLU/JjaVxGu82BLBwYykpQQ5tcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLd9Z1QNUHrNs//h4t/2d0RCT5tIVrqpopcDr4yCqB6K9goYN5uuIqv5PBtjevmbnZiz7sI8SjMOv2XsgtoTfbxO22GzZ3R8yju2yZs8LMnejlAUc2bVXkYQUpPv2oAVWWk7ftGb+/j9qjOaF4A4HQy8X3Sa4/o8x1AQEnBu6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiFN5J2o; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso170106f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988250; x=1763593050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDdGU9f1AjnbUUZofpssnIOwmqCSincQK/z8WMfUJ40=;
        b=LiFN5J2oICD8D4UpNq73/60lM1jSqqtCN12XSVyGH/O2b89rwteB8yEdBsFR6UIju8
         NJm2HJ4uMfn9SFdyGwq+Rm4i/G8dGJNyvDv9Zzr8hIeBpsYT6vZG4clhGssAdkM+m2yY
         lKikoOLaGfbQovsexzhgs7OxIy5d0UZsm5WStgE8Odi8E+aIreC3sTGcaDAhytS1es+r
         Ph9s/elcaQ3BYbGdvW+To5+UHeySz1pzDHjxnvqCxDSaYcscvAmZ4dgtPOZcQrfvKQdq
         4mqRC0zRuvLZhk47f8WKOb1cytakM25DKg+UhAcgsQuLW670bHSq2GnCAgyJ0LhK5E39
         qUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988250; x=1763593050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDdGU9f1AjnbUUZofpssnIOwmqCSincQK/z8WMfUJ40=;
        b=SiKXT9tKzQjsKy3MZ2UCrpb20TQP0SmFOkBFWfcOk4ekgwJ+CdsQ2WBoyTcIvpOM7s
         Eg7NA280QvMusDrLlX00L+z+Osho2q6NkXRXxFoYYqn+Y/xvWPmlXVeEMspJPJrV6sSm
         LOZTyH+5DxPtIgGcB2tC/HnmilJXbCVzA0100ERWCQ7xHreqGoklbCpqb+OiCrwNfdyE
         S5zt6Hf0lmqeD/JGRqg01eDDSA9irN9vLH5EVaG//vYuVVhMYdjqXKrarXLPXNGpZDTi
         +CxBxw/4oAJLaJ2VgbiHrb8IPVP8lsHD7FO2q59teuogRQNvHXMzQU273EPkTGZxsZhm
         WAKg==
X-Forwarded-Encrypted: i=1; AJvYcCWyhpb5eOCJgCpeTybmeYMlTC53nA4WzeatbbYbbjxJ/db/rIOylYy9zUn9QhehgSe2wmt3EmijKED5pDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywig2z4DUL5FMoyvJsIQjbIUB7Lk2zK/kiqLXitvFWVr9pFUHC9
	oaj2LEvO+BncDq5xpBKDHrIxXfP0z+u2u2DUeh03oYnG374+UBZ7Ih1e
X-Gm-Gg: ASbGncsdSy6j6uzFY3WgFOaO8CKzRQS/2B9/bL81b1e4tPF/qrvr11Eb0YvQySbrnwN
	6qz1X8UZLoPPMrAvL4qtVpddJEYwEXODycH1nAuMlzAxfSmL5A6jXvG7SpaE7yN6VlryxZU9rMo
	VK+sf4yFPEA4uizhi5XhlbMIsfWI14Pd9t/AeCi4XouYYR4OOGtyZSyLgDe5sL5CPOCad2t2R4V
	xL60KnvI4CIqCLsMcUeGBAG2KNB+QXXziHy/XS1pPK5I2j5dMeG3kQ46wGATRFW8sayQykAxV59
	ZgYAUUwfad9FBDqtXtw28fPcFkrTo2TIvJcjw5+O7+NUtortT6smiyo+rn1OgklT4EvCGjfqwcb
	1RFOqiO5PnWhbhIN4nPPR8K7+ip5ikjskUA13AZ+oa8+UKEE1RCAAMb4F9CdPxUvl37XC7cIO
X-Google-Smtp-Source: AGHT+IHd2ghe5/cUirh89dZkN5PNcB58L5BDtdQaut5HE/Jd3Vznjz6w0+Wyr/d7Bgq1xX0pEP1YUw==
X-Received: by 2002:a05:6000:4008:b0:429:d6dc:ae1a with SMTP id ffacd0b85a97d-42b4bd9bca6mr5035268f8f.30.1762988249643;
        Wed, 12 Nov 2025 14:57:29 -0800 (PST)
Received: from localhost.localdomain ([78.209.131.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm236979f8f.17.2025.11.12.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:57:29 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 3/3] iio: ABI: document pressure event attributes
Date: Wed, 12 Nov 2025 23:57:01 +0100
Message-Id: <20251112225701.32158-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112225701.32158-1-apokusinski01@gmail.com>
References: <20251112225701.32158-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs pressure event attributes exposed by the mpl3115 driver. These
allow controlling the threshold value and the enable state.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 352ab7b8476c..5f87dcee78f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_value
 What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
 What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
+What:		/sys/.../events/in_pressure_thresh_rising_value
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.25.1


