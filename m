Return-Path: <linux-kernel+bounces-828242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FCEB943C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B138169F20
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE1626738C;
	Tue, 23 Sep 2025 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="ekGGZHVC"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18F1DE2A7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758602195; cv=pass; b=hqmgOzD7fRoUcarCKifaMxgn+E2rQjKBBFcRVnMoa0wi3p5E20bgRDT8VBIyzcNqnwQAAu3lDqLS9+iWLebD0pYJViv4Bah5oD4ZZDUrsfgnufcfspTKG4jO7BveUdyxPCk4fBp2eboMVlAVI9liBkLe7B7uPrvSj2hiO7WyG6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758602195; c=relaxed/simple;
	bh=++iGC/Kh5THrVxaenEQgGxJow1H/yDBR3Z/hzYbntr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WEos4HzaGJQVVUG0afJ5KLmqeHMoRRbEVF2LDmshbcAsI/fvUQ9k/BdaLe6OcVuiRScAczmyqU0K8unPfSVg3q4wXqx9W7O1x3NKpMcUwU0qhaB654+LhF728/ipIHvSQ2/MBRgJfIEVb5KUCKGAF+qNa/9nfphOB3cqj3c1IOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=ekGGZHVC; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58N4aNN0016609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Sep 2025 13:36:23 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id CC745109F2883;
	Tue, 23 Sep 2025 13:36:22 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOh9L4ODFgNc; Tue, 23 Sep 2025 13:36:19 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 40990109F2880; Tue, 23 Sep 2025 13:36:19 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1758602179;
	cv=none; b=n4MR4BFzG131PEG7Ii1qN6ZqugPa1V9Ts3sawdaBeVgDSxDiqLnSWDSuJWockjfVx8CbZTSrwd78fHF4tht/hy6rwhGtBugISd57OKbobhhEOnRmV4EGEjf+hwPVzHIuvIa3dw6On3oCpDEbzP+KmzKxFw0L9N5Xr4gsi9l2wAw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1758602179; c=relaxed/relaxed;
	bh=4jUpXLsZEzhN5gdqyk2XnkNOz6aiPTxrRsZKrxphp9U=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding; b=IAi5lMDVPrK3NvBa7LfhFkEvng7GYk7gK+dTHquqnST5l2ngfAMzSg7ePJnbx7HejSdwMJkeeAp5s32YoSNR8fP3PqSva7cMa9D7C8EFgBFVNFhWnrZvOIoXrrZNZ2CsbAh/Omlz6LWLfo5u8wmjMMQ6bjqArKdvrNvlsrP58HI=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 40990109F2880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1758602179;
	bh=4jUpXLsZEzhN5gdqyk2XnkNOz6aiPTxrRsZKrxphp9U=;
	h=From:To:Cc:Subject:Date:From;
	b=ekGGZHVCEOVLGzvfSe4vNeRbhPS8YS/YQn6R9YiTn/ML0uT3wUBpml4XjwXTHltIz
	 t6S/syNS2zoExvTaeVyCHhPPJjcKAthMiXYsBXvq7WYnTn3PF/KcDbmMiA8IiAR2WW
	 HE3ShBQ6glsxQmfY3+DzHhCPFp+0LCvmXF5NiCRc=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        umang.jain@ideasonboard.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: vc04_services: mmal-vchiq: fix typo in comment
Date: Tue, 23 Sep 2025 13:36:17 +0900
Message-ID: <20250923043617.2482243-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

servie =E2=86=92 service

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/driver=
s/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 3fe482bd2793..c2b5a37915f2 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -326,7 +326,7 @@ static int bulk_receive(struct vchiq_mmal_instance *ins=
tance,
 		 * committed a buffer_to_host operation to the mmal
 		 * port without the buffer to back it up (underflow
 		 * handling) and there is no obvious way to deal with
-		 * this - how is the mmal servie going to react when
+		 * this - how is the mmal service going to react when
 		 * we fail to do the xfer and reschedule a buffer when
 		 * it arrives? perhaps a starved flag to indicate a
 		 * waiting bulk receive?
--=20
2.47.3


