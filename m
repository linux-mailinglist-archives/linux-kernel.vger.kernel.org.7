Return-Path: <linux-kernel+bounces-877680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F1C1EBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEA2F4E732E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6943370F4;
	Thu, 30 Oct 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MtfuH8St"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAC334C34
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809278; cv=none; b=BWQ14HZe1BTmpelI0fyu5OOwrzeL9jDesqIkTUjSnPNIqnohG9xAzRlk2aC3VAjMlBEQkI/ZeHEI3t3cVenc5pCwWjfYkWu2fYNUe3pvw76FKhRAv+YdnAqxGDuNRYunyjJB+oWkbM/DwP13/8Kn8v8QZ3J490cdj4MvqU3Zs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809278; c=relaxed/simple;
	bh=6xuAztGGf8TPMrJnMQ/MnAVjKV4Phxg9JewUCE4DOdg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZKJhMCA3vw+21t68BkyXTkdtxePfw7rw7e78DWUPF/UFws82ahtAlYtyMkoE91YNs61ZM2jfFMSD0ouYmzmC119wS6CeLoZYMM1OacSGZJNHSOJ03zzBp9H2yR04b3iEb0hbukmlcPalR9VG+1npGTbb/tlzdh430x+2Pzzhsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MtfuH8St; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c12ff0c5eso1814347a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809274; x=1762414074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6QatJXbzJQcBlbsN/zCXF7ei4jcjtpQXjiRWlC65CY=;
        b=MtfuH8StwX67Enp1wbJuGfxfx7XLviroNfR3AxlO0LVvWz8z7GwJQtAnZj739cm7tu
         epzXNH3+ATAv7rgN0sjI51tNGE84bDt+Cz7teJPz/ZS7z0+zADnXgZvqW5HBgHI8rCqA
         fvRoutsjg2vfXOa6kMYnuRYJ77/T9Y2BXgsyORmfNpj0azDz6HQoHxiQXDXtG9y+Wnq9
         wtWbqcIxeFraYLRVU19s7RbpXVlRm74fu4MeYqHZ4xh3fMJPvcZwUjejc9Jn8Qpf4qwp
         YiiM+qtJ8FZkh1uIpR2wqEq7N9k8OQvzszRk7ShkXxghq1QGTqAk2KwqIlGDvtncxNzq
         sOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809274; x=1762414074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6QatJXbzJQcBlbsN/zCXF7ei4jcjtpQXjiRWlC65CY=;
        b=PcOCV59sxb4xvx8uWBlqbCjnZZ+QRXB+DbspMIwlFWuu337Qvg9GWCbJO+I+15JFKZ
         oScadhFNSbrdqK5eN6IeTmVf6+5cgxucgtcD6hP6L2PoCmVB519oilg1tqIWEwVLFVrV
         I90+mFteDBNgBsI+of9dRo2fMDWdMvXQ/2us4QNKsyUBFflTA+HF5tm0aGbNMJWe6C55
         PqsmvHQx9SoOPIvq0ZleXDDfjCBoPSnRLi8QoqxWWYOcvsxWgFU9w9ANduOhs0toJ9Ks
         nYyehg9MOy+EeF2F+2/iIV6t513cAUzP6IviwWQDnM64y7wH3hvW6+A5Pdk47yixcOkT
         XpZw==
X-Forwarded-Encrypted: i=1; AJvYcCUzHkVqC6n5NCFzJ1Lm81tmHO/x1aKvxYsPtrAaf5Y9iruwlkPh6VipTPrpemDuV2n3dOkMcfZhSMYtk30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8Zl0v1uqa8U/v9BSfJjqOJtsGqFRsckjxX4efcO3WNqkRWpd
	oTq+wXhtxqQ4TNRapptTD1bn3h6Ue7OrUYK5g68A87v3SoIWPUqAT/Vx/tFf8JCwvhw=
X-Gm-Gg: ASbGncscu1HBSS2+fbXqJJzwXgmSXW8c6Or0XjgGUojR6+rVayLm4+Rd9/GYPCIct0a
	r6edFMxGrnTwp8hCcRqT2lzNd6JO5AIltlgTm1L/eW5OzY+QKTtSkJNi3nWgB8GSPlz21/q/SS/
	3aSBGRmg8o9VXLDj9IrSv/dcBG7O77nBGwyw++AypZTm0bTBfLwlyfFWIzZdgr+Kbp7R7qjpoAZ
	+YdW9vfLUMJpzvmve9qOnuyaAt+XJa5+NCMyx/qKFf+iTQHd/oaFhYxm7sd8fZqn3aM4ixZoWWx
	FglAyHaUp3eB9mZv/GzzSISeFzNU0OoituvWDOt6JCJqyJBbBrnCeNX6mhR6dbRBYfaeeHy91Qx
	iNvMQwdVkynwS5OvpNDR02rw75uXZAMLi8wUclmiUA/OkmKhOlN0VJtOXL1rjo1ei1duUhUtPFx
	kWXdRFUpFrrkTeeVrZmLXrfNErPg==
X-Google-Smtp-Source: AGHT+IGDlgXct6G9XzogASDF4gGFGJL+poglAjzVMKWqtIwLalSVX8z4qpJFHXAl0iKUL0PN+OIvEw==
X-Received: by 2002:aa7:d909:0:b0:63c:1804:7da0 with SMTP id 4fb4d7f45d1cf-6405efcc885mr1528938a12.10.1761809273978;
        Thu, 30 Oct 2025 00:27:53 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb97cbsm14342016a12.26.2025.10.30.00.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:53 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] st_lsm6dsx: add tap event detection
Date: Thu, 30 Oct 2025 08:27:43 +0100
Message-Id: <20251030072752.349633-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=flavra@baylibre.com; h=from:subject; bh=6xuAztGGf8TPMrJnMQ/MnAVjKV4Phxg9JewUCE4DOdg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNEx6Tcn+KW5SYwttXBbevB4f1LJXpj7Vh+f +pmGKCLHTGJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTRAAKCRDt8TtzzpQ2 X1LMC/0cdqFMtF1jQUBOOVYgCN79ShFNncFPt3ROykSnCCEY8Ae3iIlxOGtEdslbwYS3Si7kjyU BZKc85qo06/X8QBYwrzdPBNPv4oG9xDQAtUm9VDvAC7xaQo+fb9BmhI/2hIKSLGHOI3iNy2NlG6 qVDRnda9D5qp1Cdic0EoK1OVi/GuMesZlLGVjepASsZ18vidPbihxLKa3oWpl6q1EfVYYjyBkRO 3IFVv4vdEH3kkVR8bzj0xrgyjZ+7IKSURlsLnMuXoCstXcEMBB5BkyrXerqeIVTIWmw/m580zaQ iGi9dV56sfyGq8TalSaMga8vKNTWCTzIvFumnsjXPSiDwZn7DTyo2nWHs3ZyYFCd2qvNn6jcRRB 40KnBjzbzEPof6sHTEPToaq+tcX2+6B8vN6XO4MvnPjChfBmkVuR287yEqjN/roY9t7+fJmHqBS ecejVBZkd0M27vrXaSfA8/fbNKHhqRRM+uzcfmtL57UOyYeo1OridoH3snY8rupbv7KpE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The bulk of this patch set consists of reworking the existing code for event
detection (which supports IIO_EV_TYPE_THRESH events only) in order to make it
generic to accommodate different event types. Actual support for tap events is
implemented in the last patch.
Tested on LSMDSV16X.

Francesco Lavra (9):
  iio: imu: st_lsm6dsx: dynamically initialize iio_chan_spec data
  iio: imu: st_lsm6dsx: make event_settings more generic
  iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
  iio: imu: st_lsm6dsx: dynamically allocate iio_event_spec structs
  iio: imu: st_lsm6dsx: rework code to check for enabled events
  iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
  iio: imu: st_lsm6dsx: make event management functions generic
  iio: imu: st_lsm6dsx: add event configurability on a per axis basis
  iio: imu: stm_lsm6dsx: add tap event detection

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  73 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 653 +++++++++++--------
 2 files changed, 422 insertions(+), 304 deletions(-)

-- 
2.39.5


