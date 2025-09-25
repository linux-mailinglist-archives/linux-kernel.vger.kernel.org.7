Return-Path: <linux-kernel+bounces-832866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F88BA09A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FCE620B78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857763064B2;
	Thu, 25 Sep 2025 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrDpMXmO"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1321E091
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817736; cv=none; b=GPkvPDP6vyAz72iYb+Lb71MTVID5SNJEOrLXRH6DjIXraGZot1oi+9CAWyvLVxXLXVeosvAr2XOsiEgORvAHETUUYpnkUsJE7BmZKVn08stfzYA44noc3TUpZvMh2P3/AtrearoJoQ3Q9Vpor87wq1bOsJq22hUq/mysGzuyv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817736; c=relaxed/simple;
	bh=yVeHh1fU0YWUnblDCmkhki4+QgyK1imp/E2+6A4Pn4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qY+5IYZ+qeD5NBd/LwydG+aQWs9BFXC8NmypPIwNaP9c3GjwodSrXa2ZIzF+so0dSl3Or2NLCU61rJyQOqDuFMrjF5ROE1Oj9TOQhiqGgtVk8VU+2GIIt9tyhp7EIHHPO4FENEjX+Q5L7IKBKuh4tkIDzSFvcJeb3bDhCqlVnj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrDpMXmO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-368348d30e0so12202041fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817733; x=1759422533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnKoWYkEWH2fw2AAVRtHV79ItoxRJrbqLAVJ4MFNxIk=;
        b=nrDpMXmO7xA3w1Clr8JUDJiFyYr1fyhwu8EjeLJRnFuNHhliYTIH5LeKdLahi/JI8P
         yzeanFKkhPL3a+K7nJzIRVH3sJu56xdoiBYcPY/KVxL7H6088S5oYTZePVnF/vcagEoB
         /rroMFrxAOEn3lxVNbTWFsnh99VIm+M0Fbrd0v4V/J8ztR3YJgBKXVbd9BbNx08X8Q2r
         vwU8NyHttxsezGQnfgKTnMEXv5zIEiscC4M2hPjHL+IpY3STqJ7iCfJJ9/ORjk0esIqS
         mwOG6B/ovWTkZ8F5gPo1UiKQw3C7i6XQN6nLl06nsB9yMJP/RGAd3lupJrpwHU2o7jXu
         kY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817733; x=1759422533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnKoWYkEWH2fw2AAVRtHV79ItoxRJrbqLAVJ4MFNxIk=;
        b=ciq/qYi0PfTJvKQdCKFZOlajbJcptSXmwLgpl7oOkoSJwcUTqhwVXEzejkiacA/Fzz
         xsWwfIS/LlHbsWgxtuCuLpiJ244wdmALnuSp4eWgzT8Omsauh1oeXBumGJpFNpY3wFsx
         0vQmGB2cuOQIdSSOShm2D2IAkOjKf1UiEHr9AjvdW5nI8ZHd4gXRdsfjz9kUy+s67abA
         topDG1gC5FgiRVrQjTKBueLdmQHGmH62r01acRNhlURP4ZmklhPWsciojh9FGs8HvPqX
         f0Rz7/KvIwbbPDY65wW+RDAaV70n/5GqsA48ecxYggGFCRXaM0Lko9s0N6TWWTZOHYpb
         jF4w==
X-Forwarded-Encrypted: i=1; AJvYcCXt3D0za/xmhyfWFhC7W82k60Bn4+Om6FUWtaDUVb4QMa1Me89qWRvrAMo3Qxxerdk9qn69KeFUg6l1ma4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKZ59AJX5JnwpVaq6M2chDYDG/HP6LkngESTXQf4tAIsgts5+
	iniMcZpMAOfWDxd2VVxitDDOrkd/htEZwbyI5mb8rbr0mk8yuUnlGHu/
X-Gm-Gg: ASbGncshi9cQIlWcI54+zirWpxZCNaysM8q8wn6G9R98SLTuZyGWw363hF5IvCBnzos
	qLk6qPxTzVgemy8Ys2wkOt6h9jYBquWbuOasPy0DwkJNkVuhcxAUxWska1/GT5CTZAwd2ul7avN
	Va3ftegDgOfFllzhSaG202WT6eP2FkRSi4O3E4W/p8B0/VEGUABdIbhzUlWFBBGugLRVrafUECz
	MIZ1A92eOXt0nOKAvgwZQnU0/R/fzhjd++NLsovmmxAwrMpTPHhOmDymR++uF9ZGipjTEx0fN2G
	Hkwsl/9Pyh/n5EB3qHho9doXDvXK+JDHZBwIayzquECoELErt5VifGaV20fB23niEwHRDJes/67
	4UHblzia2h99RzjGi0FAgkvNZp76MHwqclckI8AmVAz1UES4wEmAaLALlih7lxurYpAbMvi0aO1
	9WBotigPO2+xjNuHQn
X-Google-Smtp-Source: AGHT+IH0F4IcWkrWVCR3Qs2WUMHWwcPaxX4SRtmDCxFKqMOqVSiVXerIdiqRjKIypJnd8h3S0hrFDQ==
X-Received: by 2002:a05:651c:154c:b0:36e:6146:673c with SMTP id 38308e7fff4ca-36f7dda4c6emr12606361fa.15.1758817733208;
        Thu, 25 Sep 2025 09:28:53 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7fe7ba2sm6541231fa.64.2025.09.25.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:28:52 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Neil Brown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfsd: fix arithmetic expression overflow in decode_saddr()
Date: Thu, 25 Sep 2025 19:28:46 +0300
Message-ID: <20250925162848.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The value of an arithmetic expression tmp2 * NSEC_PER_USEC 
is a subject to overflow because its operands are not cast 
to a larger data type before performing arithmetic.
If tmp2 == 17,000,000 then the expression tmp2 * NSEC_PER_USEC
will overflow because expression is of type u32.
If tmp2 > 1,000,000 then tv_nsec will give be greater 
than 1 second.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 fs/nfsd/nfsxdr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 5777f40c7353..df62ed5099de 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -172,6 +172,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 999999)
+			tmp2 = 999999;
 		iap->ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
 		iap->ia_atime.tv_sec = tmp1;
 		iap->ia_atime.tv_nsec = tmp2 * NSEC_PER_USEC;
@@ -180,6 +182,8 @@ svcxdr_decode_sattr(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	tmp1 = be32_to_cpup(p++);
 	tmp2 = be32_to_cpup(p++);
 	if (tmp1 != (u32)-1 && tmp2 != (u32)-1) {
+		if (tmp2 > 1000000)
+			tmp2 = 999999;
 		iap->ia_valid |= ATTR_MTIME | ATTR_MTIME_SET;
 		iap->ia_mtime.tv_sec = tmp1;
 		iap->ia_mtime.tv_nsec = tmp2 * NSEC_PER_USEC;
-- 
2.43.0


