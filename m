Return-Path: <linux-kernel+bounces-737248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B268EB0A9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB327B07FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4B2E7BD4;
	Fri, 18 Jul 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tiRNBv1J"
Received: from sonic307-21.consmr.mail.sg3.yahoo.com (sonic307-21.consmr.mail.sg3.yahoo.com [106.10.241.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAB2E764D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861053; cv=none; b=dYmnJzS6ZXp0u31kwBrKh4eYJvS2E3BLmHOgD2w9aINqD0K1QnnMdPrOIk7VU6V7ci/254k28ZRlwSQaHgpHAQMZZf9ArcgP6JkV6Pt42Qs+N9A6gqxDjcf0S7jQhe3TlImCdQBHuRhMhjWyvWUgBPDL5yIZSawAHC0f/O9IWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861053; c=relaxed/simple;
	bh=pWuTIEPknc1+PSVkaIsrd439yAS0Y7o7RNEQH+z8aB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=TlFN3a88KOzxPVTpMS8nx8iH/1AOzgo1e0cGUCD+LbSajGaoC35UKvVudz+MA+73EX7b2HJH0QJytIZt1uthGz7hgQz5O2Ye1tYnP/WHrH4Qad2DsWAW+EOG32sBMfFzmjoF1oOUafkuD7dUPqEpz6wlsHX4votnVpo9cC0YOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tiRNBv1J; arc=none smtp.client-ip=106.10.241.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752861044; bh=bg+Sbb0dtEq89GA86fQkxE2YnIn2nupjzJC6MN4vTJU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=tiRNBv1JQF5IH9zSn95BOmt9WJnHuI4D6qf4Swt8RKSkw7FrQ89nPklcWl/OsK+nsLvRDtDUuc2WsN+ocsl8W6fKinChFJk49qarW+iVY4bwNXIdzPqP3IIJANVEmzRlykPD4jgFVwMH5o/4n7jHEyt7o0B/UYvov3W2618nuVGjaYFWXnmSzmOrY3aW9k8/N7r6foias2xV1j9F1uZlKwXqyqorFhkq+gj0ScewQJjxbcvY+V94G7casi9tSeOddN3oK4VpeDFrLNZlOhNIlKGRPlF3lW+q7Pxcexo2sZDoMGcFTP64DoFPkbDFLGhHLLdSe3YOVWtjA1+76Bu8Uw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752861044; bh=2TocIBoAxbt1idmCdc3u+6HHXyOoiE6alKkgA66DrRp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iJKXGHF1/lOqfsdJCu+fEC9LI7WR8zKWqx68DkZwzJ35kXbcu8Yq/OJ/tnv+Wo1WvQj2gNJ/rM82/PqK0WvvkVRFqrkpil7N4lO4nE2DR4KlG5ozqe7abmF8tv6U1fxZgkXSIOK3V/3HJD3YALJazZBkkmeOSfjK6cCcUZsjmZ2rzQ2vwDLxpW7nO6ChV6fTE3yP1VUTMsbuvWjsk761p8u2lcJxIxp/W4mpYZmxB1liTdf/13w5wzgFsINgt0XpmM/TS/YAbEy1fYdY1JO+jlI41S+4mLMc9D6OLn/gTK1+g408bCKMyAx9v/slk6RxirqtY7cE8s98cs12gS32wQ==
X-YMail-OSG: 0pmXQ8EVM1lBIoaMX7UT4kMtL4q475ExqYKHwURoZk8arhfayQqbdCLlvjmdWFf
 qmiYY.CN5OsJSZBsJcO1qeErBKjiKxyCukxti680N4uoD.MWB2sSrtig3dDU4TIytK5vjsSyNRsq
 Y5Qe4D2f4yTnK9.sZj92Z2y3d41kpfgCkgB_Had7KxBnF.fnh3MQp0R1Euw29ri_a0KgXgezpMib
 VpcQv.3MbfBm8fWMmih8DPLHQ5cSERw19HtZoKZ28IL0GU9guOurth27kKQa0oeRGGiGpf4CZjim
 I9EbH7cpTahSvtYj6lKhOhXDt8TniSOqst2qHtLrv.2sr4WHMy.TwAS0WbgtfOD_xboOQQAYhnfg
 aE6Ia4WbS8jHR.UMM3SQi4L.tQhg78tecemlsy6gA3EwOVVdtjWNllEvdQZaNfLT87JCImKYrVEM
 lN385RhE0sy_HAXB1V0eCbQcrVuV6pDAUCFWnAhdA53iueqF5VfFID_9R_87d2t7Uqa7t5vv0QTL
 w8en_n21yUlqSiTLShrsK_dqOJ5cWCgU.SojYAKPahiIEanRqW9ZsCmqhMcBiCkN.9Mm5rp77wma
 wq02H0hYLzZ11J8QgY4wYA1btzrVVvomytu46UPiHPVxF1usILiq9xOPehsNnPF8I8c7x3kS0IQd
 XRFyBp4_G713pgeHgr5QdqgsTHLOzu5Ru8C6YHKbVaZjKrXktZcK4JCbYiBX834hJ8j2QF1UdT_U
 9hZvz2lqM8tWH.j2DIv0Wfbkc7SDEFZEaUAZ8dozLeF6g2ukeEjZgdVIVNORgQXFyszXLqouUrYY
 lZCc97yJ52TaPCNFz2lIGjvUwzSAbiURiRflIUtA8NEDx7feLxeY2bkLyVnYIrCIYWVYTaPqlfB1
 TFKpnE7npE9P2tesNBkcgGYIKqBB0_B8dY9Yzbt_svHzMRP0LTwTQPjzPMRHyDlxnZSPBDFxdy6A
 L9zxtWL7z7G98q2CjoNWWv8EBXs7KpfUMW7p43DxUIw0s9tEoAitkr4qdrWJakX6eOVDrS0dxX7H
 eXWTMkIWSnmgp.5lP5p8N8y9mJWLwKqFordWkxmN0U0sZIenLxQnB2_aak4pXaD.dl.SOl9Ro0qf
 qbM.62_9saN3KUlLjvdaIWQReMFEz1RVrshPVf6pGUWb5GSIhrihK4N527Qws5quqHKvZHZNZh9G
 A52ndlpt57aK5ckcwsjRK5MWIXHNmIAPOZ8XOwbSDsecoDc5XYsIKPvBaQZp38DSuZcTJx1wr_tx
 gboikRXUKdqbaJHE1ROrLMZlKu209z0aHJ0Ykx4g0QHMyypaNW8bs5nZHdqcH24D.DnPEZAD1v6m
 OLzs3X2Ijd_90nQtfzAfIOet5M7In3ZhT5J0K7VW7K8wl.r.HDDk2v6AXdYPKeeySD8OiWCoRmTQ
 heB1zYgmvUJ93RUK4v0CeDUmg4m64iijdkvcfR4s3LNgGoBarBfrOo4CHQV67r04bfvBZhNDCfS6
 ntX3TxwALTZ5C8beEKtPq06dvcwi2alv1YBAz_N1i_DbtuXcF98LR_20bS4YoQejTEPJWHcGzjmt
 tjs8xsRaZC8vFxhOsLjXF9jv2uHKoG64beJsptwm3Hv51ey2TraL0e4TPW5JoOmUAlSu6jbdXTTN
 okyZ5cnI8s7P3Qh39JI39u8rUxHLO9LDNCdRjUlD_q.mWHUgAE4JlA_92N78ypPpPoajZpxUt1Fs
 TH8KUfEqJ5chEnGrvmO4Mv523J.LpMfvIhE87wsVO3KXO3wdLknBUWG.giek5b_MOqqyJcFZMqfW
 kzHtwjvZUtlJcuSJYFDahF4NCwEQC8j6cqTmZ2mTwHDwk_gRJ0QWNbFDvIptTgBzaRp6VKCEvRZl
 1ff841WGpQ.n78NQ8qgGS0HH.7bSUZFguu4rONvrxpaoOXstvHCPErSN4kR26TQhgaljsTewmQlP
 _Tw5fwjDYISnDcdLdykiBs7c0aJ7U69F4zGTSSWaBXoIJ64D4iwN3e7OoOootbpSiceNAUSgWfHJ
 wOsdH59h5lFtrj33Y580EAwzncEtesJu9HgfXCgf2.pPphzcUOcSN3okTBxaI4dthql4qDJGPozw
 l.5dqj1wBdo_EWV1pgGV9RnD4IajQ.gX0xc6nnZRMler60OWEy3AE3UpcTnmPKDM5Xw2ZacUuWbc
 EPa71wDmRPWLVcL.PRqVOG9klt7wa_KHu0yw7ZsKDO0Dh8cb8lPLSpCC1LsWZGl8vn4RI_2CxIr3
 IfK9VNPBx90xBrxtJen.456m2PeL7N_cP1a9XhE34XzDbLH2KGcncA3Pg62PW2ErViLyGaGmmKIi
 Xt_2Iee07zDqZp_HB1A--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: c11bdc34-8446-4b38-9fdf-805d214b9985
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.sg3.yahoo.com with HTTP; Fri, 18 Jul 2025 17:50:44 +0000
Received: by hermes--production-ne1-9495dc4d7-psbrp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 70d73d121d4fbf7a2d2044420498d4fa;
          Fri, 18 Jul 2025 17:50:41 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: gregkh@linuxfoundation.org,
	crwulff@gmail.com,
	sumanth.gavini@yahoo.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] usb: gadget: f_uac1: replace scnprintf() with sysfs_emit()
Date: Fri, 18 Jul 2025 12:50:35 -0500
Message-ID: <20250718175037.299710-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250718175037.299710-1-sumanth.gavini.ref@yahoo.com>

Documentation/filesystems/sysfs.rst mentions that show() should only
use sysfs_emit() or sysfs_emit_at() when formating the value to be
returned to user space. So replace scnprintf() with sysfs_emit().

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 drivers/usb/gadget/function/f_uac1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index c87e74afc881..9da9fb4e1239 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -1634,7 +1634,7 @@ static ssize_t f_uac1_opts_##name##_show(struct config_item *item,	\
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = scnprintf(page, sizeof(opts->name), "%s", opts->name);	\
+	result = sysfs_emit(page, "%s", opts->name);        	        \
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
-- 
2.43.0


