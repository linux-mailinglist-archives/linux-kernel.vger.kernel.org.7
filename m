Return-Path: <linux-kernel+bounces-732822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230A9B06C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D925637C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48DF1E766F;
	Wed, 16 Jul 2025 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fcE6M1wp"
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8AE2940D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637806; cv=none; b=oTMknPXzNSbxQmJapias+eA81SIYw7AZWUhDe/+9u29l5plPga38aN/gXheCmG6OHN92ko3H/44GYNQC86sU/MiqDsVa3Rs2k8ire8p3r0nQxIYeyqBJPR452+HpRlS4qW3hU2ISIFQmsxyu4PkM86AjHPr/mecbL1/Ded0fhZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637806; c=relaxed/simple;
	bh=u4jfW85MoUcCx5X7XN7qftXMx3N5/ByeAqxRiomfcDg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ry/w/qImZDPFMvRcElc9vUPr2YopYsGF0cCMg8BezE0yAZqfUl8q1BF/c30Xji/GiwpZFxJ1xhdspjjw+9exfrBHI0s1Djos+1+UdYNbe949fzVrmWJNsrqb1bJ80T57613DK5VuJ3j3raCw7enPLlUpSIxHyu4hWtyWt59tTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fcE6M1wp; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752637796; bh=LEOKLduKn83Hk4hJU9cdyVDUO80iRjwGRPOjQDIAj5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcE6M1wpW5/x9hh0x5kyRueaAViwlSHyR4c3UGucs0cbBmzTsFrjekyA/68G3gflO
	 QaqFH1Qzw3Q/4YHf0dU3d4wAVgrjgGcFbjEtaoFYlXX9NGaEEltNl76qg0jKXt8HoV
	 PYHeiNkvnTdSgnrWuF6HElxse1QLpo3QK0A6qvnU=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.33])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 95233899; Wed, 16 Jul 2025 11:37:18 +0800
X-QQ-mid: xmsmtpt1752637038t3ljnbpzq
Message-ID: <tencent_56A4BA7780E65A148134035CC5DB2CFFA007@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5SZ62XQeLKAxgOeEoRz+a6vTdTRn2HHdzSxRdLvtqVF8p9xXbTnW
	 62wfZIha+bKQwzazc3UuOkew8GaSNXYF9EyxosjLKWBHmpbzN0126sBCDGvqk0bIUfz1Lvj9d9jP
	 MZR5MByWYWFZ0+zV3LvHckAlGJruALrfYZRcjh3Eaf+BAjownX0VMv2opIDPdb13+n53sAwkmjRS
	 w14n4yle16gyUkq3X0p7ev462yILd7qQUS85j/U2xQScQWHZ7WTf66xpi20D5TgrFVWda85cFmbB
	 +O/t6UtXqU7SFzM9RzL0LmpB3/gA92CbFHWUsoyS8Fmutl0lB2oHp3BKPI7cGpi3W5MoRbtBK4IV
	 u7/uNiqjs+tJMjDLT6YjK6HpeclkUrUnA5OVva3XA55YbzBGKVXrSybFZqdE/jEKCPB43oCxwMPi
	 xpR0x4k+ThYqOewRGdKqoAAxBQTUoO3JJzIaJmjpKJmlsWFx9iTf6saOuKsGEo7w39ctR0S3dNeO
	 fFIHKlLq1h17aDrxDE3XfdHUbXnye9xujdo2ks6zbesZPDEvKGbgQf0OkB2lIRLYjP590arrohzx
	 LbCe7aT1mLMdM0150Kmb4616G/oTDPzDrFije1+9b81VPLF/ixczqSUDGNNADe3tZuy5WCa8aRae
	 Fpa6E9y6MhpNotlnNfVitm2fqdJf4b9VC4FAaPz9AExWz9ZIiqiRV7vN3G0NMuhWjpp5dXZFaoUU
	 lgrTwD3mw4IvsS3/Bgl4xv8QDTSq639/bus32Ksi2nNzYXuJNAU7aucodLnOV9A8pqGFvoZZr5NH
	 JxGnyE8PU56M2JfyFZYcR/9WXSckwItejn6zmpiE0gsLFpt4OivM3VgfmekoeGeU/7kUxjwrUFQF
	 eQxbX0lE9z+8sHLCd7bIV3LemrOGBA24nry27NQwFK2Kuj1ZUEICqt+SMz07bvWu/JnbXMHDw8vV
	 uKu16LfTRZ8UmVvMNoW6zRDUF24GEERuGz737KDE4p6as5nZaizYXm2mTFMOHHjlNC/JoX+c0G42
	 H4yD/kMa5rqLR62R/fXFd6noUycOaosvpbkqgTkW8d52AeH28NsTAF9ExRZnbDOgPAsclovTCPuT
	 at3hYr
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: jackysliu <1972843537@qq.com>
To: krzk@kernel.org
Cc: 1972843537@qq.com,
	Austin.Zheng@amd.com,
	Dillon.Varone@amd.com,
	Security@tencent.com,
	Sung.Lee@amd.com,
	Wayne.Lin@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	alvin.lee2@amd.com,
	amd-gfx@lists.freedesktop.org,
	aurabindo.pillai@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	joshua.aberback@amd.com,
	linux-kernel@vger.kernel.org,
	linux@treblig.org,
	mario.limonciello@amd.com,
	ryanseto@amd.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	sunpeng.li@amd.com
Subject: Re: [PATCH v2] drm/amd/display:fix a Null pointer dereference vulnerability
Date: Wed, 16 Jul 2025 11:37:18 +0800
X-OQ-MSGID: <20250716033718.3981047-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <12c6632b-65b7-43da-a954-7107ac8cb1b1@kernel.org>
References: <12c6632b-65b7-43da-a954-7107ac8cb1b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 15 2025 12:44:40 +0200  Krzysztof Kozlowski wrote:
>You should disclose that you used some AI tool for that... and that
>other report(s) was really fake finding.  People should know you
>generated it with AI, so they could make informed decision whether to
>even allocate time here.

Although this problem was detected with the help of ai and static methods,
I checked the trigger path by myself and verified this problem. 
I'll describe the ways of detection if I find other issues in the future.
Anyway, thanks for your review.

Siyang Liu


