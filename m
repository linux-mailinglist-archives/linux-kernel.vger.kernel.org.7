Return-Path: <linux-kernel+bounces-753071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572F1B17E56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AA2177136
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A186721D5AA;
	Fri,  1 Aug 2025 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaXnarzV"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587391F4613
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037160; cv=none; b=KEc6QNDdecrDvkPT8il+9J/7G8GqX9QOSXisP7DWwxx5zXHajjG32qgdFbxLJgXx7orENTqo/YmZ4e+OHr4S7vad8ReO5+q6mPX5C7Fzg6wTM45qeOxWC5J8XVyCYgYEPElrDqdCKIXUqfC/PSw7IyKWTUWeds418Qn8fX+p30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037160; c=relaxed/simple;
	bh=jNw8gYyPfEc0lCn2sfYFphv3M43A+C5B83Bw6t3WYKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDhcnokrS3EWvtBMCljZsjPPSE1xqxGX+b04Vu3GIPDCcwXvaGYPZznszqmDu1TuC419X0VwZoD+bow7YIbHmcZY4SyE3b9qd1lfPm8nM5VKyhJRHDRGtCqJF630Wx631nUb+WW84NvXbc0rhXo0vI3+i/3Q9lqqkOwLbWudaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaXnarzV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso1075524a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037157; x=1754641957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFCk7W4PYpUqrlv5983kKngtATqBDHXd47fbmciqnpQ=;
        b=MaXnarzVGW/wnJLlGYacXiWmm2w9OydF+ggV7RwV0YdBc0EUhe/Jos57/SMdIuPJJ8
         Ki6+31u81/eWZU93wBeti0hYum7DiASxrKC+zrbGL6O3XbQEh3+TAwE7ASd1ijo6d7bi
         EcYLNiQjenKJvtc0bLvqyz7i0xl+JXcFlXmv1GGk7ghWJUTNJYk60CIAtso5AROsV1TW
         GS/iYMaU6ZslHt3c19OV+QC6XVFpi+3cs5za5scEDxmvXGv2gqb1Ke5QK7oALEVpzAgK
         HVF8OHIzrKBAafWZHTNXX7ITeQiP+ikkkqHZre/VVQhpfO79ju/gz9B+/3a490HnTJ0U
         glDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037157; x=1754641957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFCk7W4PYpUqrlv5983kKngtATqBDHXd47fbmciqnpQ=;
        b=dgCn1n8rhs3FX3nkYaAGS7+qg4Bx/+MW9FTj8L13Y9HvKrmb8MiCmBd9dl2OA+gkod
         RbRGBmBykzt6rQk9oohamgexurW1QDowVxP5VOZ3VTXCPsGRENgcF5cy3A26K9SUjfqX
         +M6fKip8w7Iw/v86DoRzcI9+aXo0gN2ZxQkta+HEuUQZyfHxu05wjCi5QjDUnvqQCnwg
         P+s8zYZA8We9+NBNynIavLvhAWmVfQ1iB4/Bpeplmmwh5CoTAM4sr6bgeOHNHuVux7ia
         ur8FSn9Anls0Cnirt3iJa3jTsmDGerXkBV/MoWvOm1pdi5QHzlhqAXQcLKbrDdTaImZ3
         SpYw==
X-Forwarded-Encrypted: i=1; AJvYcCVRDydM/P7ZQO9bxDJj4U2bem9ZggFl345nQhpFNiZiJvAoi8rhssB7MXt/DMgf0e0mKQc/hZLo0Vd07Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSXTUtEP0XScb339MK0lKiIo8Mad9AdryO//nEO4QVr57TRMF
	H+7Ey945+0mXrvGxfNME2de2dGgEQMoX2wMN5wzI/GaD8soKfe7QSTS6
X-Gm-Gg: ASbGnctf3xJ1YOmY0wWsRJPTIVrgZ1+aSQ5TqyXsyDh50nwmVvrkO7P0Z3oRqp9Ucep
	qMPR8XMyYoXYsgW0f8f4y+14BL4PjyD/w+Xe+I8/pTOUCVJ8pu++C3fP2HVPlMnYIZxFYyaqYAa
	ea1DWTD8EcKllbYrjok6e/tSnK9HuydfwSIv2xtYUB9s3MIhPAZhrXKiEQGoapLT5gb42C8RdKS
	sIkoG+0GTBTzqQu7c4hshhaXEb2i3btaRmZ3weBAb29uvP8YJo8tJH7oULe29tQE7DKjlskerZW
	kTdwqMFLorxKT/tnVYYi3x3EGD3L4gdgt/cla0wcVKheSdzWK1ht944l1DKE7p9BhDF20WsFQRL
	vaNXY57wiV2GzPibCzCdSPJwFU2GgCJTGSvwyiUqb6Xy8/z3/g+s=
X-Google-Smtp-Source: AGHT+IHySLJVS0XBT69Zdi5WfqISPJkGXDMtshkA3DCyFm3wMtzq+ZwLvezA3jCI5dEpOq7Bfd7tzQ==
X-Received: by 2002:a05:6402:518d:b0:615:a023:b809 with SMTP id 4fb4d7f45d1cf-615a023c154mr7761384a12.4.1754037156305;
        Fri, 01 Aug 2025 01:32:36 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:35 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/8] staging: rtl8723bs: remove wrapper rtw_os_indicate_scan_done
Date: Fri,  1 Aug 2025 10:31:24 +0200
Message-ID: <20250801083131.82915-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801083131.82915-1-straube.linux@gmail.com>
References: <20250801083131.82915-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rtw_os_indicate_scan_done is just a wrapper around
rtw_cfg80211_indicate_scan_done. Use rtw_cfg80211_indicate_scan_done
directly and remove the wrapper.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: no changes

 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 2 +-
 drivers/staging/rtl8723bs/include/mlme_osdep.h | 1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c  | 5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 692d0c2b766d..ebc4bd6ecce9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -909,7 +909,7 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 
 inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
-	rtw_os_indicate_scan_done(padapter, aborted);
+	rtw_cfg80211_indicate_scan_done(padapter, aborted);
 
 	if ((!adapter_to_pwrctl(padapter)->bInSuspend) &&
 	    (!check_fwstate(&padapter->mlmepriv,
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
index f0d19637fb0f..c84c84c68286 100644
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ b/drivers/staging/rtl8723bs/include/mlme_osdep.h
@@ -11,7 +11,6 @@
 extern void rtw_init_mlme_timer(struct adapter *padapter);
 extern void rtw_os_indicate_disconnect(struct adapter *adapter);
 extern void rtw_os_indicate_connect(struct adapter *adapter);
-void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted);
 extern void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
 
 void rtw_reset_securitypriv(struct adapter *adapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index fd4ae870a617..09bf363efa8b 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -53,11 +53,6 @@ void rtw_os_indicate_connect(struct adapter *adapter)
 		rtw_signal_process(adapter->pid[2], SIGALRM);
 }
 
-void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted)
-{
-	rtw_cfg80211_indicate_scan_done(padapter, aborted);
-}
-
 static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
 void rtw_reset_securitypriv(struct adapter *adapter)
 {
-- 
2.50.1


