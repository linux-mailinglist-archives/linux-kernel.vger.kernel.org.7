Return-Path: <linux-kernel+bounces-870076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8FC09DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8527B1A60A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E13002DA;
	Sat, 25 Oct 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDWr9NWj"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6C2FFDFE
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412404; cv=none; b=hVbe44+PJ3Wqaia2R9ROlIBH11ikCnRtaPYyVUgwjolmG3Ao0jemezdmCkJobLuIbgu/K68r1IKIrNuc2QYe7FczzQNo2PNwmtLa7SperqjpUcpVmHgk55N62TiIuA6bAQ3uH8t06WOr2v6trykj5eknTdKso8PpP53FT1oWT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412404; c=relaxed/simple;
	bh=7lmGC1q+c+FgaQKsnCMXwCqQEYlM/ahItBJoPnseraI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVlY4+4VMUN5kONd3Ds9MVBOcGOk8MHrEN3MNWmrAhxXtQdVaONPmXZy98NhxVtbn58cEnEOESYxM5zB8iSXfuuMWDkUl8WgkVuVd+VPB58z6VmylTzHhMeJpO94fO35Qg9rDpGgH0P34NV3aF1Gh+V30gBk7vS89QmapEB/LJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDWr9NWj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a2738daea2so2709771b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761412402; x=1762017202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z48sCAKG3WKzuxot8CdFTX8oor6ocdCy16+r1lGqXvU=;
        b=SDWr9NWj1Au46BqeZ3hZ+xcBs3b7LiQ266gksE638zhLp5KE+D6O/E1f4q99Wsda+v
         VQvvnDcX1cnehQb2SdDQtKpEgwKIa9acdj82BLJGKVEzafmK452eSo7ZlsLD7iSnWpoE
         rgUteKuQrvrRsCdbz8BxzBkpMVf71kRjKhR7uiIpratmmNWgcl0u9hgRYbKB8vyqEGHM
         UgztY5N6ckIwm4uha33JOjhJWEMdZLGorOyfNTffnLIw2VeczggZBvGi63RipgHWOQpy
         j+HnSMMdxglUz7lMECrkJrOgz5PJxI5aTZ6QoLCO8RweMAFyb2mfQcTYoIlJjOpP7z8g
         okCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761412402; x=1762017202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z48sCAKG3WKzuxot8CdFTX8oor6ocdCy16+r1lGqXvU=;
        b=b1919P4mFy+DQx0eaT9VBrFkvNztWnQZ6AP5Gd2adSi260TSmRxcsXYCDwvblu1bz+
         It9eX75VIufelhhV4mmEIlMvqFwuTbHDnX10Y2LABTZxnMlgvV63kQgdPjdVHxK4J7Iz
         cim9LjR8clo+WISwWt13DMueu7x2naScFMEW8DC/JSM8AUeIffw5ddEkL5dhz5ZT9t9m
         JOgZXrq1J1nZ3EwVw0W5pGMPWnHU5eZtLekczpEEotvWe2usXNpeDs1Yvp+KQN1EBybk
         6MK1wUBPLFsQptYAcJ+BdT9EKLdP/+Y8NXTt2ZXQmjGgREFO4tQ+UgOinKRTsxpjp4Fr
         T9cg==
X-Forwarded-Encrypted: i=1; AJvYcCVAAl2UG0iz3xFuDExEcImvI36lVYC9X5XFZKC6SDmvt+I3pW3UDv9AfbzbkfD/Xz+RWpCHJc8H5OMw3q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlF/9Q9eVjHfdd7l3XaTUefNZvDJeNq6A0XPnZDBcyKvdA7av
	aQPsr/zi8o+2ZtLrVxOPamL5R3KGNJuYZLmIvaPkVfDtUWFNJc6hdsPr
X-Gm-Gg: ASbGncuIHrwrSy/NCYcFlvN8bk/fBQ//6BEFpka8USjrYOHczAzXRE3a+7Mxh8Wa9py
	VUfXmbG/VMKuycoOCW3eSz+f4S60YORo1Mz87YVhQaSewRoQv7aqDs4eyQ6YrevcaOua8ZIfaB0
	m4dZqV/r421e4j9thG6YqS9Wp23LobmoqwtU6Hv1Krew4Au5xoFPGtfnqUaDhu6rUX2wPFHq65B
	czyZ1ClLKWmvTNRQjXWVUTRqw2pAgv4HeXqBIKNTPJKX7fnu4/2sMEJXqIBZzykZ+8bUHRJ27TI
	nkKzmsR57X5sUWiR7Al11oCmasHvhxJmbkNFmpjQ0yo6Gg3l66JSiltU0RP3vvdyKPBDSBAflYE
	QeBpen2bOm3HdGwvKOmwSmRJ+gQG+pGm2ls0c/ovRVtODbrDylkRQAsNpDgKZEQ1ViUyglA5XD3
	K/z2nO/2g=
X-Google-Smtp-Source: AGHT+IHuS/nhNRyMpW/6+6GKiMn0JmU6Izue3QmhMGAWwUn/W6gLcb1ePdGRXmR3Cz1EGUJD2ljA6w==
X-Received: by 2002:a05:6a00:2ea8:b0:7a2:86c0:d630 with SMTP id d2e1a72fcca58-7a286c0e196mr6720193b3a.0.1761412401862;
        Sat, 25 Oct 2025 10:13:21 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bcesm2850481b3a.8.2025.10.25.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:13:21 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Sun, 26 Oct 2025 01:13:09 +0800
Message-ID: <20251025171314.1939608-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning reported by static checker.

v1: https://lore.kernel.org/r/20251024084918.1353031-1-mmyangfl@gmail.com
  - take suggestion from David Laight
  - protect MIB stats with a lock

David Yang (2):
  net: dsa: yt921x: Fix MIB overflow wraparound routine
  net: dsa: yt921x: Protect MIB stats with a lock

 drivers/net/dsa/yt921x.c | 76 +++++++++++++++++++++++++---------------
 drivers/net/dsa/yt921x.h |  4 +++
 2 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.51.0


