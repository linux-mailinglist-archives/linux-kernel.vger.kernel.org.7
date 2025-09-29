Return-Path: <linux-kernel+bounces-835848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1222BA8320
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF333AE6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049C92C3250;
	Mon, 29 Sep 2025 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTYxhx35"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9C2C21E4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128660; cv=none; b=J63hnTtKjLPO7LEeVJTrTtfk2f+68D7aIkm4vbKcjT+zth7EjA9FFveZ8jQAUVvxczm13rOhzZoCKmr94p2VboRSDR/NoA+WHIiPIbbHHN541aCvWfJGZGTPehBI7Ur43RX2VqR77Mvp2aSvMs/6FkqxFY35BHqY/yFFfiwpZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128660; c=relaxed/simple;
	bh=sVKXAhqtYzmhPhGaAvqO8hHWIMq5fSBKZkUUNjQNhG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTs0GQrTyD4YRe4QfTntesTLah2Jje+9IbOYvpn7gihjECPmniqVCQSQmgP5tqa75mmFQwMFhcsl5gniZan+4IMpf+lDXLu7bZShnepj7pyfYManx4wuTIcCgjVND+nQFdhXgviQX+GA9ZcV5rbD9LJ0PwNrT6bvAvhYRHVA08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTYxhx35; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8608f72582eso127612985a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128658; x=1759733458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyZgeBfEA3RIwZlntNk2i7xrS9inBs6EU9J9QRfIJiE=;
        b=CTYxhx35hRWoT3ITOCmLa2PIyAVxTwTT6Ij3kWJQ3GTiwzQ6ExojJAjD/cKXp84d9V
         TitTqGkkDpUU/sIozbWEGi/BYyio8HZQdY4lTGrJ/AnYybRMXitH/OOq+/Aywwdc2FXD
         QRk1mVpel97v5Jtucw1rYrqpVcaT08wCNIJ4sUnncfu4ydS9WPkAFbLhejGsiPXei1iD
         ctilstRQgZcj0BcCmeNSA2QBJYmf8qfwd1s3+Jk2gAolX3iok5LCJPzCCFxMyZP6DPaF
         FBPcLOxJ2edzliBzEFFfTwh21ZFxIdfHh5w1h35taarhKRUXeSndSmMqCgdfr0VjjtdP
         kECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128658; x=1759733458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyZgeBfEA3RIwZlntNk2i7xrS9inBs6EU9J9QRfIJiE=;
        b=rnuhLDhK/e6vPMKNvxoZlTy5//2nWpDXm48HkfBHQAWDgmldnFyJZwtaR8SyFunno3
         obti8OqlPLARax/cS8EgK0MrnOvykfHBjIBFLPtszRkInO/+CtQhDeNsQshOSnbxNsUm
         QEbwH2xhOqqH4hus93d0lRpdOqLDA3XaVamgrq+V0DG1NWo7kd8nEcQfRezvUDE74VzO
         cZrng0AJRBe4yV0eY1yBHyrfRhPjAj39ef/yrQGoQs1jKtIuD+lt+K4XfRvjuZEPxgld
         umpOlN0y/xf+jnbo7bqxpbyylr+SK625t0OIIF1/ybGiyfqxkfoKqL6oi8odo/aniy3g
         EITQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWsij1rLicYNcUE5H/GzxztIBHW5QooLsHW5uaVW36HUrp806OIP5F4MKccW7WMis8SZW5fATIYvmxC/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwN23YgfT0fR3XR5ZtX4BjamUMhKvtqJ6HtZxyQ1p1DJPONIZ
	flHxcMVTjUfaY81B5AMFehuvw9fEOsmDXk4tbfpSZu83n9jQZmy6AXo6aOfNoQ==
X-Gm-Gg: ASbGncvNkaeqsGvCu2Ud4T1yTHDpHe0ZHt9C98ptzavXOziNPNklrNx4CRIpiNPY19X
	urqEsjsJmFKW8GzlgMM5yJFSByjrql71X7JVzlG3XCYNOLPps+J0YK0IR7b/GBiDT5egyBbzczK
	m+cZJGejMjP5KCeHXqcFUhpN7IKbSHiqbh4yAJ9QXtjl3eUmh0Arf7jWVEcAmrwKLbPvvIi3yuI
	s8OHo+tFu1cFh/alFjgLnETv7NSsMDw5WGF3V7hxCpuPONpgwdmHzyW6qJ39U4j9clKDH8fz1QZ
	afzzmUwKhsCcVxSwRXdd8B1sbE5bIFnAQEjjDa/yd6fr5HF+1oVY9SSdwxvYvn/aCXAZc+zBdbn
	388/MfRDDIuCDDoFWKAlBwsFATRSRZ7Cvyvt1QmcvBH4xsqNJsvadRgp0NUjV4gEX9YixxQcP
X-Google-Smtp-Source: AGHT+IHXbv8Z/DvST7PTSOrUyDPAMEUINlt2IXgFylEqS+yRk5IsLd+EAEVeEyKGV6STYUyWto7Qlg==
X-Received: by 2002:a05:620a:3188:b0:86e:21a4:4738 with SMTP id af79cd13be357-86e21a4478fmr17891985a.13.1759128657607;
        Sun, 28 Sep 2025 23:50:57 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:57 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 13/15] staging: rtl8723bs: fix line ending with '('
Date: Mon, 29 Sep 2025 06:49:58 +0000
Message-Id: <20250929065000.1010848-14-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust formatting to avoid a line ending with an opening parenthesis,
in compliance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 8879d7056324..741c7dc83873 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1113,8 +1113,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter,
 	 * ptarget_wlan->network.phy_info.signal_strength instead (has scaled)
 	 */
 	padapter->recvpriv.rssi =
-	translate_percentage_to_dbm(
-		ptarget_wlan->network.phy_info.signal_strength);
+	translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-- 
2.39.5


