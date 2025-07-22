Return-Path: <linux-kernel+bounces-740408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0AB0D3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F6C7AC711
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F72E093B;
	Tue, 22 Jul 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f74xps4T"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A6273803
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170090; cv=none; b=mTC4zmyaAYHOuGD+9AsU9weUvOrjn7HxTa0CohNQmkqa+UKQ06uTH+UJrOcqUUrVeJjiWWLZ/81n05hNqMaJixlgODviB0DZjki0zXWz2SO7Fc8NF+jMTPyAaTG1Y391arCuaidbhOLbmaQCEDZsTHnOXT0lf8c9W0VTTzcZlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170090; c=relaxed/simple;
	bh=rtRC4Ev3m/O8U1vK5Biqqwhz/fsXnQUBT200dVjZ+Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7Y+Y2Ig/GNVR5EYZ+5fDqey4C+aQgMcFxikdKYE6ntjW1SOkYEzNIUgtjDcBT92aUjQ/MQqm+CACpw7ppx7HAsynQLRYn9+CbRNBSNsnU8ghgYBhAIAn9jkQFSXaoaNL9jhjvqCqV9sCRsq3iHO8qVo3qTdo9Pd+mPBHnFi3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f74xps4T; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so8951839a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753170086; x=1753774886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD+WDAZpBhywuFmsykKhAgacOLRRprRh6YgpDRi2+z4=;
        b=f74xps4T0CEvkA63vD9NjpxEmn/pNJMZLKwHaDb+IoABInOp0hEbNNkwm2/ftE1Ckd
         tSWMEAA3rI6yNoZq77E5monrhJBsUx9te/wS4DTQH1PFsEHZ1qch3xJkJGzHaLZNmbLu
         usJrWESYqvtvZDYjkoPz1/ctFVHY4xuAbtTZx7hOnEJc3jwSGJ+qU527oLBzJx35Awni
         1ppBGQjwslPGLLmpRtg+BiOxiCELv77Ma/yfK5SHnRr8dJjW9hzHoz9KajSsbkFktUe1
         HHxuqCH1ZW/RFU3SagzTHKRz4OE9buSy+f1RMaEm14QiPzogyRGWZZYLMOslTWqjLfgn
         xkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170086; x=1753774886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD+WDAZpBhywuFmsykKhAgacOLRRprRh6YgpDRi2+z4=;
        b=hS+zK71+N8Yorkf1m4oMZ0bByEiT8i//zdpDKS1CXAtOEmlCq2Ek26uOrBuYY+xQiR
         658xn6XRXGdTS43akYF7jQgBh17iyvs8ARxiEl/ukT2vxiviDU2uGyCZeQUGdjIRAq6q
         8bo/RnW8wt44381ZLV+ZM9EiV4471jljWwFvtRZ3IQtFaCzfiDnZd7p+pbcpMDYOhVY4
         Kud3fVRDGKjAuf2kNJ+rl+SK8nrXY6gA1kFx3xuKhI2HuwdAcvys2f/ftdmKRepLfL5+
         z3z8mO68DR6R4PfsYjcRP9kw0hQp8/D/l2sMN9oYkOCECFEi72z6njvx+ne5qE8FvIng
         L54g==
X-Forwarded-Encrypted: i=1; AJvYcCXgJxSfgTQozYNlT6nGulvcYacx3Wtd0sfzhClPyCQJnLIeoZ4VMBtesrENqge8S6y9Q6BdYghTxOXxQ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RsNey4/Ak2FNqOjlBIAfXjIOmUB8cAq2bSkY+XQxFiGbg79P
	kR62YOPzq7Yb3pqXJOj5nviV7ab9Aw3IaLZB5kTDQgdyHL9A6JBW36Aa
X-Gm-Gg: ASbGncvGqjPHBoxyUH2u4xtD/kmb65CI4eeNR+S+PIO37mitS4TjgWNsEgme5+byTCT
	5qDUbCPUZQFQefhvixzeHEJPH6ufyStR9zaKbf+5LN8YsxFrxJW5InrwvSMD1q/cvhZc0jmSlYj
	UcYOwnTpXJC8QiZQZv6BIJpRRJ0tkUiX4DYkLMrzT7Rc1O4SPviJpWqzdWVROXx3aQB6XkUl0d6
	YLVNsVBIkcpGdaGsWLlXiW1z3/LngidKVqSRMabZpQGSVuO1JbyPCEZEPNVfD57hJU0NazsWvuT
	kS3K2JY/QDMuz3uvOKGvbfmJeFv7zR/ly4hCEhK6mdluwuUwW45Mg6nv7xtXf4Sa9SyXamlwj1n
	5+gSd0n62vZM1M4Sx3wH394E=
X-Google-Smtp-Source: AGHT+IE7BkXfLIsvxlP1JCVlXpdU6K0hfAWqn/gXsklQoTqpQ23YZ2oC7vEcEUHa/9rB83DtWsLlwA==
X-Received: by 2002:a17:907:d89:b0:ae9:933d:f0de with SMTP id a640c23a62f3a-aec4fbee39amr2202987566b.36.1753170085549;
        Tue, 22 Jul 2025 00:41:25 -0700 (PDT)
Received: from tumbleweed ([95.90.185.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm821224666b.32.2025.07.22.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:41:25 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: rtl8723bs: rtl8723b_set_FwAoacRsvdPage_cmd is empty
Date: Tue, 22 Jul 2025 09:41:10 +0200
Message-ID: <20250722074115.35044-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722074115.35044-1-straube.linux@gmail.com>
References: <20250722074115.35044-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rtl8723b_set_FwAoacRsvdPage_cmd is empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 3c5d516cb3af..93b63a16b4e0 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -300,10 +300,6 @@ static void rtl8723b_set_FwRsvdPage_cmd(struct adapter *padapter, struct rsvdpag
 	FillH2CCmd8723B(padapter, H2C_8723B_RSVD_PAGE, H2C_RSVDPAGE_LOC_LEN, u1H2CRsvdPageParm);
 }
 
-static void rtl8723b_set_FwAoacRsvdPage_cmd(struct adapter *padapter, struct rsvdpage_loc *rsvdpageloc)
-{
-}
-
 void rtl8723b_set_FwMediaStatusRpt_cmd(struct adapter *padapter, u8 mstatus, u8 macid)
 {
 	u8 u1H2CMediaStatusRptParm[H2C_MEDIA_STATUS_RPT_LEN] = {0};
@@ -605,12 +601,9 @@ static void rtl8723b_set_FwRsvdPagePkt(
 		dump_mgntframe_and_wait(padapter, pcmdframe, 100);
 	}
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		rtl8723b_set_FwRsvdPage_cmd(padapter, &RsvdPageLoc);
-		rtl8723b_set_FwAoacRsvdPage_cmd(padapter, &RsvdPageLoc);
-	} else {
-		rtl8723b_set_FwAoacRsvdPage_cmd(padapter, &RsvdPageLoc);
-	}
+
 	return;
 
 error:
@@ -876,7 +869,6 @@ static void SetFwRsvdPagePkt_BTCoex(struct adapter *padapter)
 	dump_mgntframe_and_wait(padapter, pcmdframe, 100);
 
 	rtl8723b_set_FwRsvdPage_cmd(padapter, &RsvdPageLoc);
-	rtl8723b_set_FwAoacRsvdPage_cmd(padapter, &RsvdPageLoc);
 
 	return;
 
-- 
2.50.1


