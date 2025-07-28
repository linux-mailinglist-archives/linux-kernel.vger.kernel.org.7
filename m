Return-Path: <linux-kernel+bounces-747430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFFB133BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B6618964CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026DA216392;
	Mon, 28 Jul 2025 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwzHoiP6"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D61E5B91
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753677413; cv=none; b=Ft5cWgsVCjo4BcGWQMGTfUHqrv6MQV2R471ktRzw2siconTN1P2dVGw0bv4qnt0RI1kM9YZ8AtOgbdULxlrwufWn+Y+DljAvzFuJvQeBBu6wZ3n52s1DqQylTjnWDfbAjjKwRpwu6BoupIMdurEI+z/9t7jlGpIJO2xZq7J9g60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753677413; c=relaxed/simple;
	bh=tDWQTnaOByEBiSkO3FvdLGPrQKPyATsUtvQ/bjuirZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QqjyC5u1creXvvXJ+RhYUhmOu3DzMAPyTKJn1HGSrclKeqDmHQFGkdgdQE7sJZ7S+8F/n7kjo9yz2NCkiOXJ+vhtWksyvW5wAWpBTcdJHy7eqjia9R8li3Xgvu4IEur5T3ZGd0cRwpSh9L7M1PMzdBUbwaP+0oyAht/6xk7O0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwzHoiP6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e32c95775aso438052685a.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753677411; x=1754282211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXztVcGyYhcXEUuh9ymdxD2mjy3D+/Xbd03h6w6BTCI=;
        b=XwzHoiP6X6qHK2bnTHz9+SNiyMOR8inM3hm+zqMvzAiumanfqS03BtWIc9d537UCD8
         ki5d+iXwqBymqosOpkfX6OTlbMx6XABgHmbBaOzRiISc6LhFY6JdoO2jjqpxCF3J3S49
         6gX3/6lT3Acr9GIyS13Da/+QNwGoWkmW1XF3Mn9eCotWyMvlrTjSpYGEPABVansNvj4y
         mkzgSvm0JOmsSfyAr0EMaNhN3Evr5kgVVe40f84K/HTaf2VFsObxuCqkgKxyfPk+g+5U
         MSKb/8uZogKF6z8Q8thJPrfzxHpMOC6yaEJiBK/GjAYRi1OwE9t0gLVNF4eR0TDQuuMW
         mq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753677411; x=1754282211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXztVcGyYhcXEUuh9ymdxD2mjy3D+/Xbd03h6w6BTCI=;
        b=bEhCHXpit/nNrI1FdvoElPNQBBJpC9xtfbtNIkOsZqufaNEsi9evNocPjExOEw6MGl
         gcxj/t3YMdwFf+RlNAXX6NrYBzz2FrvIfOf3BhU9gNmB32Oq1pnJ0yKMi+aKDO0sFalp
         DFNgv3+/Mc7isk/g4nVROtpgnJG/hqSJmpyrtD99bPLxkbhGuoOMP3u3SNU+yuYADxkz
         aPaVRRc2fPMbW02vLt+Btznnr7lJW0PamIl1zAnCG7TasJ0wiisHI6J+6YGz9Oy4StIP
         yz88CWR3kiK1O4Btfk0c4scC0N5w1ofMX/x6TCWvlLktFwc2sgEZ4zm7mmD357uSnxmx
         kJDw==
X-Forwarded-Encrypted: i=1; AJvYcCXfS+OLxHnvt6kAorYSy7u0x6JwXiANHI7VTKbhPqIR+CNp3vvsBsO3wsdmLdNZ8SCMsjKVpUV9NGgjwYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tuxJpgLpv7+f24VhF0Uqgh6dXU/37Lr9BrDxKfNOiMViEaes
	l2WqlyGNZk7ajv9WOdJMaUyPMqn4P0ezzOblGQq3UqTyABbhSb1PWo2DEHirGQ==
X-Gm-Gg: ASbGncsFtoci/pdG/WKDd2867kLx1R+a7syx/dL0qTrJMpf5co5uBN/e99q6Mx47ds4
	NTB5z1/J25PG36DMCtLgpLs0stm4QK0CIHkp7Q+9lzctBeIjRtKYtlmCh9mFmbBkHuJD1PTESdz
	t23Pu2W1LeaOaSoHBomzSBXl3BIjorpns4ikoQn3EuB1Yff4hKsgMiaKVENTo9Db7x8M3xRpLFy
	VRsYAAZwolXnWFqj0kvEwi70WE7M3lkZlY1zIR2a5pL3yvAACHHHFkyamykASIMq39zvEHUXUd9
	oRAiIzpnK5FcTriAKBkgfLv5jMJhDesUpXXdgQ6vOTeZLyJlQAknMfeStC8yOyvbpE8moK1K8uY
	MZ0UUWF7hyeMW9fzfs8DhH9IDPHShl/3lMTDgDb6ShnkIlR2/J2k=
X-Google-Smtp-Source: AGHT+IHVRwJVt2WogTeYvQm25w/2dooYaUNg8V/US+F/CTRtqVjHiUxJQADIE41atp6l093H9eWpRw==
X-Received: by 2002:a05:620a:7002:b0:7e6:440f:50b5 with SMTP id af79cd13be357-7e6440f5113mr997580885a.11.1753677410810;
        Sun, 27 Jul 2025 21:36:50 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeb2e7a7fdsm12694961cf.4.2025.07.27.21.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 21:36:50 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v1 03/20] staging: rtl8723bs: add blank line between rtw_roaming() and _rtw_roaming()
Date: Mon, 28 Jul 2025 04:36:28 +0000
Message-Id: <20250728043628.421849-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-4-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-4-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a blank line after the definition of rtw_roaming() to separate it from
the following function (_rtw_roaming()), improving readability and matching
kernel coding style guidelines.

No functional changes.

Identified using checkpatch.pl.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>

v1: Addressed review comments from Markus Elfring on changing the 
    description of the patch regarding readability and separation between 
    function definitions.
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 24e505111f1f..b1a427a655ef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2449,6 +2449,7 @@ void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	_rtw_roaming(padapter, tgt_network);
 	spin_unlock_bh(&pmlmepriv->lock);
 }
+
 void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.39.5


