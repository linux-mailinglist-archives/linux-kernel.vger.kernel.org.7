Return-Path: <linux-kernel+bounces-782054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B51B31A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D83B99B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0097303CBE;
	Fri, 22 Aug 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjo6vm5J"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59D2737E8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870913; cv=none; b=C/aHVOxJY3ZCSPS213PC+j/vIrwJhq4WgXuB3exekBvRI0N+eAEaOy+0MQG3NDmdTrqKKsy+AurJjCKxh1I8J+7zXmSVk4nKxGZnBPNrpWt7rk7tWqDJtgS/RByWb2hQOik2KqEoR0tTuRa5AuQUN5tdYR8zDpMT05zDzo3SofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870913; c=relaxed/simple;
	bh=X1AqrYiDlVBIXj3hu70zjXFgy/CPWMahbDfE1UFj7e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3R0FzkBf7iVQhL65GRDP5OUb3VqqLrlDCblGbuIKVDFHl3j9gnsSQrljZwFmXnMJtG8V+wdwuhwox1MA98Nk4YP13dFcY0iO7iXsfHd5++Hd7siU4Zwd8LTNvTSWzhgjuyoM6Pq4jU5Mcdv+FuF78n8Y9eo0zQDiSexNuf4OgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjo6vm5J; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78c66dcso311944266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755870910; x=1756475710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj+HgtxduluJorTLjvqhqXUN+0cIHtQzCLrC7EzM7J0=;
        b=fjo6vm5JHtzuU0DfhjyOW6o6FYgvakDyEEsyqkoKnok7OCORYPFyLFeo0saMdyz+0O
         X6Wi6hLG7Kbz97AFYEkbiXa8HAncEUe3xJ39CB4+mNusFYjK2gWoVHGufoHdbLuBnLts
         BKi7ny71N1kk26GbFSeM0ziG5xbsUboOqEbeXWvt09/W43ZV10H0hOejteul9bW/umuA
         unLez/ZQWEHfaFO0A45og0KzqMTDBOmYPZpbVAC+IAMD8HaHvR83nVwi2Kn+wfiSpgJG
         Efej2K0jW7wiWE7nS2lAyrgIm6kWaRXwvr71aJapWuHjqLsP6AP+vI7GH9CurM61klcR
         8TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870910; x=1756475710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rj+HgtxduluJorTLjvqhqXUN+0cIHtQzCLrC7EzM7J0=;
        b=gyMdAJ5L5ppv1txQjPEhcw+y3m4kkBGnhIKh673RudUfbgcxLBv2MSSWxoFYRdoqSn
         6XbvM3WIzsaJceERkaQ4HCy460PhetN/A3DwbvpodZwKsHh5mxVl9+1ZE1o/zGfjnvm6
         AdbUr69+hJWr5LWjJjtLSv8dYbkUn4hg6Uoiz78/0IHRLzgJu+l+O9dK/ddfwawf6HKK
         O4352Y9Y9bQn7vzviRbXYJ3FVMT8xzaQ5Jh+qfY3fWWmbjak1GqNRhAoYJ2D5jQPIxdF
         EQXbWZQShMgL3kUQLQphvKnF9YYU062vQMNxcRPI1DDV6o11g6/wY47xjCaNeLMAn2rc
         Op1A==
X-Forwarded-Encrypted: i=1; AJvYcCXYRoH2Id39RHct25MYwde+nUJNJDMmGPqzyaU5/jIcX8HjJR765hTETa0OwyA7bA1AUkq0xoBdAsKqodk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Iaofs6bw0psp86b0EakwY/OF2wwe+4sLOHFTnYLGsp+ieo/O
	0wJ+Vj5IHmom6n82QK85+GAMorcHamAIb5yiV2vJ1GM56LtB66XQGK3i
X-Gm-Gg: ASbGncukeq8INAY2V90ih5KgQaY254P7JG3wc/xE92fexfYRO1Do/4ilIiMXlGMQP1m
	BLns4rn9ItuFaf2XM8qshkrx7C0FHiIyqLZPHJoFI5yQGTn7HmBg4uExUCg70sIEXTl67Ie8zQl
	+8kaDHemcNXMseDxXDqqOHN5c+qeagRprCmtfhyJvKz31rcy78uO3q2pZe7p1hJWWZx76JopuaB
	jaiAIpFwXf0EvN3ypFLLw2ZEowloFRwtDStFFlVb+khhSz8hXCwV6Kqyo6TGYiJjG96haZ/tsNR
	1ngJhJKTxw5rtDbfjzMDL76Og2ssc8sXQzpXAm04mgQs6pt0SwJq2jqYa57UXlor8xqdsQM9vWT
	DAVajYyE/OJGHDRuQEsIyhIOg2Q==
X-Google-Smtp-Source: AGHT+IGViA0WcJpMqUWyH0PlxyeUQx7RR2prGZEhfZG1uikO48f6AeQtIov1nSstrlCfYu3rGvzfQA==
X-Received: by 2002:a17:907:86ab:b0:af4:11e1:f877 with SMTP id a640c23a62f3a-afe28f162a8mr287292266b.21.1755870910341;
        Fri, 22 Aug 2025 06:55:10 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded307138sm612353866b.45.2025.08.22.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:55:09 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/13] staging: rtl8723bs: get rid of os_dep/recv_linux.c
Date: Fri, 22 Aug 2025 15:54:05 +0200
Message-ID: <20250822135418.118115-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves/merges the functions/functionality of os_dep/recv_linux.c
into the corresponding parts of the driver in the core directory to reduce
"os dependent" code.

The patches have been compile-tested only due to lack of hardware.

Michael Straube (13):
  staging: rtl8723bs: remove wrapper rtw_init_recv_timer
  staging: rtl8723bs: move rtw_recv_indicatepkt to rtw_recv.c
  staging: rtl8723bs: move rtw_handle_tkip_mic_err to rtw_recv.c
  staging: rtl8723bs: merge rtw_os_free_recvframe into rtw_recv.c
  staging: rtl8723bs: merge rtw_os_recv_resource_alloc into rtw_recv.c
  staging: rtl8723bs: merge rtw_os_recv_resource_free into rtw_recv.c
  staging: rtl8723bs: merge rtw_os_recvbuf_resource_free into
    rtl8723bs_recv.c
  staging: rtl8723bs: move rtw_os_alloc_msdu_pkt to rtw_recv.c
  staging: rtl8723bs: rename rtw_os_alloc_msdu_pkt
  staging: rtl8723bs: move rtw_os_recv_indicate_pkt to rtw_recv.c
  staging: rtl8723bs: rename rtw_os_recv_indicate_pkt
  staging: rtl8723bs: remove os_dep/recv_linux.c
  staging: rtl8723bs: remove include/recv_osdep.h

 drivers/staging/rtl8723bs/Makefile            |   1 -
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 194 ++++++++++++++-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |   4 +-
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |   6 +-
 drivers/staging/rtl8723bs/include/drv_types.h |   1 -
 .../staging/rtl8723bs/include/recv_osdep.h    |  40 ----
 drivers/staging/rtl8723bs/include/rtw_recv.h  |   4 +
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 225 ------------------
 8 files changed, 199 insertions(+), 276 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/recv_osdep.h
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/recv_linux.c

-- 
2.51.0


