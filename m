Return-Path: <linux-kernel+bounces-868060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B8C04428
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DC619A53BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE40726E6F3;
	Fri, 24 Oct 2025 03:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgKV3oN"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD84F5E0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276786; cv=none; b=eDt4bCbBY71zh8bQZK2s6EBe3IVAtzGTCqbVNKTU6ldgL/7dbcl42Wdf5DJsXWuCdmzx3mymZlb9DDm/uXKClEXTFq00rtnsCABy4nlzH3WaRNce0Qg6oyL+hv0lcag/LkvFX/hLcyG2MGkymoXXbEhdhd0B8f9tOVk97Xzt1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276786; c=relaxed/simple;
	bh=vLCgzMyCThpgQ64scTXHgaNMRBa1NmayEDllSs4DkOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=So6v7gmT6gPCbDlBnknZt+3SoLIhreIB1uZbX7m0rMZSfsV6hxaKFbd+lOgXkEH9s1c1pBF+XA1O1mRqnazwEzq7uL/UyXm72R9Sm+Sipx60D4vfbIop3V242by1Z+j6RR2/AHpkW5mWxR1EpoyWSPouMcHQaMQHhVutw9dpjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgKV3oN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1246353a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276784; x=1761881584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbhN64OUg842qsJQSGfmVy1u+1iZgam9qWQhuawKECs=;
        b=NGgKV3oN2kL9sY6hRnQbHiCZTimT5sXguX2PJvLh+3vuwEgJilu1KJboUuScl/0gY8
         NNO7VEk7TMk9O3axiHEaSNHxF8WMAniS6pLQBlLUP6cVZGmBSrkNsYg20ETxOW+aQRa5
         BxOvPZZnQt4dGjJj+fBt7qy+SzL31uhO8I0BDdA68fUndtpa4EcTTEXCQZmxBrZvptdB
         gwSifwmhnSkY09r1+9JV8UVRObbENbMGIStElDQAfkt1TfLvRMb7Dkw255ww6KBDUAW9
         bLkYmVZJMms2J+hcfzjm4No1AB1kDBYyM5tc3atp5grODOGeKL6S8JrEyzEK1sYskc7y
         WXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276784; x=1761881584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbhN64OUg842qsJQSGfmVy1u+1iZgam9qWQhuawKECs=;
        b=bI0n47XQajtruNQ3ZvdbvmKy96FEc2yBU/2SB5z+oby/pUvYud0c9tqY7/6NQ4pPow
         6yi/c+sglQzW0pgHhZgfNPVarkQh2U8sz/V7VuQoiY7HLlDmzfqPRU8sIJeTBlgwd0j/
         iJJsRKFlFtxpVFrWDu+HKV9wyVkHMexOgiO8Z8DOmaaryiy1FSndcAeJn9bUjaKleE+F
         gJbkVWeYMuNBNiiAneaWEhSvYZ0BcXUTu5/paDKswydcRjp3Z8xxDwUe5l8BrGBlhaml
         ieTP1BXAUKkJorOY3vp18taprb1tx/5BNG/OPCexa6SDga7YJCO5Eyu+T8LUec91PVCO
         dAdg==
X-Forwarded-Encrypted: i=1; AJvYcCXYXthB91/BakEXFv5a5W8dhuUB3bKcMWSHdxkVr0NrKxFCRJVxl+3/kpW/NYGTJ1xtjVT6oixEY1G5bk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauLNJuvpRoxPJ479KFRCGDMcwJUuwmIWQakDq1nbxe+aXPUse
	mRqvX7eiCX0u/oTnf0ecGKK8IKLtCgUgU7wOV+UT8+iVzZ48NNKdv9Tq
X-Gm-Gg: ASbGncuctvEiUJ0mc3zOg4YdXLzh9z2rDFUs+dMkLkr4Ka2HtWeRPVjfnl3XG0CrH+R
	IJs2F59l14DE/uZo40mZgTdPfeqB93PbiLIPPzt2CI3j0JNNWmh9rbpnoXhLf/UJUBCAEeVveX4
	FT4KVAV36YFGizNPVpvexAljYtUyS0PRzp330D84Jd2N2wsBucLd/wYWKnzysVrVI3X9+Hrf6qC
	DUFlLpa8FGEsE1SpMIAugx8aK6n3AshVptiVCrx1dlhEm9H8JDd7aSnY63aRA7/g3r/Vu1QOC/b
	8IMralG+BPW0XcestwwnYtDPNMEjJNVyxq6DZwI/sUiASFynGz0IRNjFrYC6FzcpiiAA1h/kv9G
	DsuoWh2IEsGquoX0lMcHTZVvF4SDP3o81wnPW3N6H9ObditbelnTqAuyh4eVPy0Teb/5vUKIQoa
	Caza6KKeU8uECfu/v/AQ==
X-Google-Smtp-Source: AGHT+IGg+i6jZ7Vc8khvsM0OhsbcyBpi7wwmvLoWQaXSJN/oltobDQLp3m3RiNLSjGcA1vXLKS5jrQ==
X-Received: by 2002:a17:902:dad2:b0:293:e5f:85b7 with SMTP id d9443c01a7336-2930e5f9113mr106534885ad.11.1761276783905;
        Thu, 23 Oct 2025 20:33:03 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7949sm40394265ad.3.2025.10.23.20.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:33:03 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: dsa: yt921x: Add STP/MST/HSR/LAG support
Date: Fri, 24 Oct 2025 11:32:26 +0800
Message-ID: <20251024033237.1336249-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for these features was deferred from the initial submission of the
driver.

David Yang (3):
  net: dsa: yt921x: Add STP/MST support
  net: dsa: yt921x: Add HSR offloading support
  net: dsa: yt921x: Add LAG offloading support

 drivers/net/dsa/yt921x.c | 323 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  29 ++++
 net/dsa/tag_yt921x.c     |   4 +
 3 files changed, 356 insertions(+)

-- 
2.51.0


